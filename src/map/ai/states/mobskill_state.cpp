/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "mobskill_state.h"
#include "action/action.h"
#include "action/interrupts.h"
#include "ai/ai_container.h"
#include "ai/helpers/targetfind.h"
#include "enmity_container.h"
#include "entities/battleentity.h"
#include "entities/mobentity.h"
#include "enums/action/category.h"
#include "lua/luautils.h"
#include "mobskill.h"
#include "packets/s2c/0x028_battle2.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"

CMobSkillState::CMobSkillState(CBattleEntity* PEntity, uint16 targid, uint16 wsid, std::optional<timer::duration> castTimeOverride)
: CState(PEntity, targid)
, m_PEntity(PEntity)
, m_spentTP(0)
{
    auto* skill = battleutils::GetMobSkill(wsid);
    if (!skill)
    {
        throw CStateInitException(nullptr);
    }

    if (m_PEntity->StatusEffectContainer->HasStatusEffect({ EFFECT_AMNESIA, EFFECT_IMPAIRMENT }))
    {
        throw CStateInitException(nullptr);
    }

    // Self-centered AoE: validate mob can target itself, but keep original targid for allegiance
    const bool   isSelfCenteredAoE = skill->getAoe() == static_cast<uint8>(AOE_RADIUS::ATTACKER);
    const uint16 validTargets      = isSelfCenteredAoE ? static_cast<uint16>(TARGET_SELF) : skill->getValidTargets();
    const uint16 validateTargid    = isSelfCenteredAoE ? m_PEntity->targid : targid;
    auto*        PTarget           = m_PEntity->IsValidTarget(validateTargid, validTargets, m_errorMsg);

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

    // Store original targid - for self-centered AoE this preserves battle target for allegiance checks
    SetTarget(targid);

    m_PSkill = std::make_unique<CMobSkill>(*skill);

    if (castTimeOverride.has_value())
    {
        m_castTime = castTimeOverride.value();
    }
    else
    {
        m_castTime = m_PSkill->getActivationTime();
    }

    if (m_castTime > 0s)
    {
        // For self-centered AoE damaging moves, show battle target in readies message
        // For true self-target buffs (TARGET_SELF), show self
        const bool isSelfBuff    = skill->getValidTargets() == TARGET_SELF;
        auto*      PActionTarget = isSelfBuff ? m_PEntity : (isSelfCenteredAoE ? m_PEntity->GetBattleTarget() : m_PEntity->GetEntity(targid));
        if (!PActionTarget)
        {
            PActionTarget = m_PEntity;
        }

        action_t action{
            .actorId    = m_PEntity->id,
            .actiontype = ActionCategory::SkillStart,
            .actionid   = static_cast<uint32_t>(FourCC::SkillUse),
            .targets    = {
                {
                       .actorId = PActionTarget ? PActionTarget->id : m_PEntity->id,
                       .results = {
                        {
                               .param     = m_PSkill->getID(),
                               .messageID = m_PSkill->getFlag() & SKILLFLAG_NO_START_MSG ? MsgBasic::NONE : MsgBasic::READIES_WS,
                        },
                    },
                },
            },
        };

        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));

        // face toward target // TODO : add force param to turnTowardsTarget on certain TP moves like Petro Eyes
        battleutils::turnTowardsTarget(m_PEntity, PTarget);
    }
    m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_ENTER", m_PEntity, m_PSkill->getID());
    SpendCost();

    // Probably ok to do this for all skills, but there's no need
    // This allows instant mobskills to actually be instant by processing the first tick immediately
    if (m_castTime == 0s)
    {
        DoUpdate(GetEntryTime());
    }
}

CMobSkill* CMobSkillState::GetSkill()
{
    return m_PSkill.get();
}

void CMobSkillState::SpendCost()
{
    if (!m_PSkill->isTpFreeSkill())
    {
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SEKKANOKI))
        {
            m_spentTP = m_PEntity->addTP(-1000);
            m_PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_SEKKANOKI);
        }
        else if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MEIKYO_SHISUI) &&
                 m_PEntity->GetLocalVar("[MeikyoShisui]MobSkillCount") > 0)
        {
            auto currentCount = m_PEntity->GetLocalVar("[MeikyoShisui]MobSkillCount");
            m_PEntity->SetLocalVar("[MeikyoShisui]MobSkillCount", currentCount - 1);
            m_spentTP = m_PEntity->addTP(-1000);
        }
        else
        {
            m_spentTP            = m_PEntity->health.tp;
            m_PEntity->health.tp = 0;
        }
    }
}

bool CMobSkillState::Update(timer::time_point tick)
{
    // Rotate towards target during ability // TODO : add force param to turnTowardsTarget on certain TP moves like Petro Eyes
    if (m_castTime > 0s && tick < GetEntryTime() + m_castTime)
    {
        if (CBaseEntity* PTarget = GetTarget())
        {
            battleutils::turnTowardsTarget(m_PEntity, PTarget);
        }
    }

    if (m_PEntity && m_PEntity->isAlive() && (tick >= GetEntryTime() + m_castTime && !IsCompleted()))
    {
        // Check for stun/sleep/etc at the moment of skill completion - Cleanup handles the interrupt
        if (m_PEntity->StatusEffectContainer->HasPreventActionEffect())
        {
            return true;
        }

        action_t action{};
        m_PEntity->OnMobSkillFinished(*this, action);

        // Zero message ID
        if (m_PSkill->getFlag() & SKILLFLAG_NO_FINISH_MSG)
        {
            action.ForEachResult([&](action_result_t& result)
                                 {
                                     result.messageID = MsgBasic::NONE;
                                 });
        }

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

void CMobSkillState::Cleanup(timer::time_point tick)
{
    if (m_PEntity && !IsCompleted())
    {
        ActionInterrupts::AbilityInterrupt(m_PEntity);
        reduceTpOnInterrupt();
    }

    // Call finalizer if skill completed (not interrupted) and set any final animationsub
    if (m_PEntity && IsCompleted())
    {
        if (m_PSkill->getFinalAnimationSub().has_value() && m_PEntity && m_PEntity->isAlive())
        {
            m_PEntity->animationsub = m_PSkill->getFinalAnimationSub().value();
            m_PEntity->updatemask |= UPDATE_COMBAT;
        }

        luautils::OnMobSkillFinalize(m_PEntity, m_PSkill.get());
    }

    if (m_PEntity)
    {
        m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_EXIT", m_PEntity, m_PSkill->getID());
    }
}

void CMobSkillState::reduceTpOnInterrupt() const
{
    if (m_PEntity && m_PEntity->isAlive())
    {
        // On retail testing, mobs lose 33% of their TP at 2900 or higher TP
        // But lose 25% at < 2900 TP.
        // Testing was done via charm on a steelshell, methodology was the following on BST/DRK with a scythe
        // charm -> build tp -> leave -> stun -> interrupt TP move with weapon bash -> charm and check TP. Note that weapon bash incurs damage and thus adds TP.
        // Note: this is very incomplete. Further testing shows that other statuses also reduce TP but in addition it seems that specific mobskills may reduce TP more or less than these numbers
        // Thus while incomplete, is better than nothing.
        if (m_PEntity->StatusEffectContainer && m_PEntity->StatusEffectContainer->HasPreventActionEffect())
        {
            int16 tp = m_spentTP;
            if (tp >= 2900)
            {
                m_PEntity->health.tp = std::floor(std::round(0.333333f * tp));
            }
            else
            {
                m_PEntity->health.tp = std::floor(0.25f * tp);
            }
        }
    }
}
