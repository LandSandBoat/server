/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Team

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "petskill_state.h"
#include "action/action.h"
#include "action/interrupts.h"
#include "ai/ai_container.h"
#include "enmity_container.h"
#include "entities/petentity.h"
#include "packets/s2c/0x028_battle2.h"
#include "petskill.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/petutils.h"

CPetSkillState::CPetSkillState(CPetEntity* PEntity, uint16 targid, uint16 wsid)
: CState(PEntity, targid)
, m_PEntity(PEntity)
, m_spentTP(0)
{
    auto* skill = battleutils::GetPetSkill(wsid);
    if (!skill)
    {
        throw CStateInitException(nullptr);
    }

    if (m_PEntity->StatusEffectContainer->HasStatusEffect({ EFFECT_AMNESIA, EFFECT_IMPAIRMENT }))
    {
        throw CStateInitException(nullptr);
    }

    auto* PTarget = m_PEntity->IsValidTarget(m_targid, skill->getValidTargets(), m_errorMsg);

    if (!PTarget || this->HasErrorMsg())
    {
        if (this->HasErrorMsg())
        {
            throw CStateInitException(m_errorMsg->copy());
        }
        else
        {
            throw CStateInitException(std::make_unique<CBasicPacket>());
        }
    }

    m_PSkill = std::make_unique<CPetSkill>(*skill);

    m_castTime = m_PSkill->getActivationTime();

    if (m_castTime > 0s)
    {
        action_t action{
            .actorId    = m_PEntity->id,
            .actiontype = ActionCategory::SkillStart,
            .actionid   = static_cast<uint32_t>(FourCC::SkillUse),
            .targets    = {
                {
                       .actorId = PTarget->id,
                       .results = {
                        {
                               .param     = m_PSkill->getMobSkillID() > 0 ? m_PSkill->getMobSkillID() : m_PSkill->getID(),
                               .messageID = m_PSkill->getMobSkillID() > 0 ? MSGBASIC_READIES_WS : MSGBASIC_READIES_SKILL,
                        },
                    },
                },
            },
        };

        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));

        // Wyverns immediately emit a skill interrupt packet.
        // This looks like a hack but is retail accurate
        if (PEntity->m_PetID == PETID_WYVERN)
        {
            ActionInterrupts::WyvernSkillReady(PEntity);
        }
    }
    m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_ENTER", m_PEntity, m_PSkill->getID());
    SpendCost();
}

CPetSkill* CPetSkillState::GetPetSkill()
{
    return m_PSkill.get();
}

void CPetSkillState::SpendCost()
{
    if (!m_PSkill->isTpFreeSkill())
    {
        m_spentTP            = m_PEntity->health.tp;
        m_PEntity->health.tp = 0;
    }
}

bool CPetSkillState::Update(timer::time_point tick)
{
    if (m_PEntity && m_PEntity->isAlive() && (tick > GetEntryTime() + m_castTime && !IsCompleted()))
    {
        action_t action{};
        m_PEntity->OnPetSkillFinished(*this, action);
        // Only send packet if action was populated (e.g. interrupts return early)
        if (!action.targets.empty())
        {
            m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));
        }
        m_finishTime = tick + m_PSkill->getAnimationTime();
        Complete();
    }
    if (IsCompleted() && tick > m_finishTime)
    {
        auto* PTarget = GetTarget();
        if (PTarget && PTarget->objtype == TYPE_MOB && PTarget != m_PEntity && m_PEntity->allegiance == ALLEGIANCE_TYPE::PLAYER)
        {
            static_cast<CMobEntity*>(PTarget)->PEnmityContainer->UpdateEnmity(m_PEntity, 0, 0);
        }
        m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_EXIT", m_PEntity, m_PSkill->getID());

        if (m_PEntity->objtype == TYPE_PET && m_PEntity->PMaster && m_PEntity->PMaster->objtype == TYPE_PC && (m_PSkill->isBloodPactRage() || m_PSkill->isBloodPactWard()))
        {
            CCharEntity* PSummoner = dynamic_cast<CCharEntity*>(m_PEntity->PMaster);
            if (PSummoner && PSummoner->StatusEffectContainer->HasStatusEffect(EFFECT_AVATARS_FAVOR))
            {
                auto power = PSummoner->StatusEffectContainer->GetStatusEffect(EFFECT_AVATARS_FAVOR)->GetPower();
                // Retail: Power is gained for BP use
                auto levelGained = m_PSkill->isBloodPactRage() ? 3 : 2;
                power += levelGained;
                PSummoner->StatusEffectContainer->GetStatusEffect(EFFECT_AVATARS_FAVOR)->SetPower(power > 11 ? power : 11);
            }
        }
        return true;
    }
    return false;
}

void CPetSkillState::Cleanup(timer::time_point tick)
{
    if (m_PEntity && m_PEntity->isAlive() && !IsCompleted())
    {
        ActionInterrupts::AbilityInterrupt(m_PEntity);
    }

    if (m_PSkill->getFinalAnimationSub().has_value() && m_PEntity && m_PEntity->isAlive())
    {
        m_PEntity->animationsub = m_PSkill->getFinalAnimationSub().value();
        m_PEntity->updatemask |= UPDATE_COMBAT;
    }
}
