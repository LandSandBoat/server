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

#include "weaponskill_state.h"

#include "enums/four_cc.h"

#include "action/action.h"
#include "ai/ai_container.h"
#include "entities/battle_entity.h"
#include "packets/s2c/0x028_battle2.h"
#include "packets/s2c/0x029_battle_message.h"
#include "roe.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/zoneutils.h"
#include "weapon_skill.h"

CWeaponSkillState::CWeaponSkillState(CBattleEntity* PEntity, uint16 targid, uint16 wsid)
: CState(PEntity, targid)
, m_PEntity(PEntity)
{
    auto* skill = battleutils::GetWeaponSkill(wsid);
    if (!skill)
    {
        throw CStateInitException(std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(PEntity, PEntity, 0, 0, MsgBasic::CannotUseWeaponskill));
    }

    const auto targetFlags = battleutils::isValidSelfTargetWeaponskill(wsid) ? TARGET_SELF : TARGET_ENEMY;
    auto*      PTarget     = m_PEntity->IsValidTarget(m_targid, targetFlags, m_errorMsg);

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

    if (!m_PEntity->CanSeeTarget(PTarget))
    {
        throw CStateInitException(std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, PTarget, 0, 0, MsgBasic::CannotPerformAction));
    }

    m_PSkill = std::make_unique<CWeaponSkill>(*skill);

    action_t action{
        .actorId    = m_PEntity->id,
        .actiontype = ActionCategory::SkillStart,
        .actionid   = static_cast<uint32_t>(FourCC::SkillUse),
        .targets    = {
            {
                .actorId = PTarget->id,
                .results = {
                    {
                        .param     = m_PSkill->getID(),
                        .messageID = MsgBasic::ReadiesWeaponskill,
                    },
                },
            },
        },
    };

    m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));
}

auto CWeaponSkillState::GetSkill() const -> CWeaponSkill*
{
    return m_PSkill.get();
}

void CWeaponSkillState::SpendCost()
{
    auto tp = 0;
    if (m_PEntity->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::MeikyoShisui))
    {
        // Meikyo Shisui uses the entitys current TP value for the weaponskill. 3K -> 2K -> 1K. So we set TP the entities current amount.
        tp = m_PEntity->health.tp;
        m_PEntity->addTP(-1000);
    }
    else if (m_PEntity->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Sekkanoki))
    {
        // Sekkanoki counts as a 1000 TP weaponskill.
        tp = 1000;
        m_PEntity->addTP(-1000);
        m_PEntity->StatusEffectContainer->DelStatusEffect(xi::StatusEffect::Sekkanoki);
    }
    else
    {
        tp = m_PEntity->health.tp;

        if (m_PEntity->getMod(xi::Mod::WS_NO_DEPLETE) <= xirand::GetRandomNumber(100))
        {
            m_PEntity->addTP(-tp);
        }
    }

    if (xirand::GetRandomNumber(100) < m_PEntity->getMod(xi::Mod::CONSERVE_TP))
    {
        m_PEntity->addTP(xirand::GetRandomNumber(10, 200));
    }

    m_spent = tp;
}

auto CWeaponSkillState::Update(const timer::time_point tick) -> bool
{
    if (!m_PEntity)
    {
        ShowError("CWeaponSkillState: m_Pentity is nullptr");
        return false;
    }

    if (m_PEntity->isAlive() && !IsCompleted())
    {
        CBattleEntity* PTarget = dynamic_cast<CBattleEntity*>(GetTarget());
        action_t       action;

        if (PTarget && PTarget->isAlive())
        {
            SpendCost();

            m_PEntity->OnWeaponSkillFinished(*this, action);
            // Only send packet if action was populated (e.g. interrupts return early)
            if (!action.targets.empty())
            {
                m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));
            }

            // Reset Restraint bonus and trackers on weaponskill use
            if (m_PEntity->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Restraint))
            {
                const uint16 WSBonus = m_PEntity->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Restraint)->GetPower();
                m_PEntity->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Restraint)->SetPower(0);
                m_PEntity->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Restraint)->SetSubPower(0);
                m_PEntity->delModifier(xi::Mod::ALL_WSDMG_FIRST_HIT, WSBonus);
            }

            if (action.actiontype == ActionCategory::SkillFinish) // category changes upon being out of range. This does not count for RoE and delay is not increased beyond the normal delay.
            {
                // only send lua the WS events if we are in range
                const uint32 weaponskillVar    = PTarget->GetLocalVar("weaponskillHit");
                uint32       weaponskillDamage = weaponskillVar & 0xFFFFFF;

                m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_USE", m_PEntity, PTarget, m_PSkill.get(), m_spent, &action, weaponskillDamage);
                for (const auto& actionTarget : action.targets)
                {
                    auto* PActionTarget = dynamic_cast<CBattleEntity*>(zoneutils::GetEntity(actionTarget.actorId));
                    if (PActionTarget)
                    {
                        PActionTarget->PAI->EventHandler.triggerListener("WEAPONSKILL_TAKE", m_PEntity, PActionTarget, m_PSkill.get(), m_spent, &action);
                    }
                }

                if (m_PEntity->objtype == TYPE_PC)
                {
                    roeutils::event(ROE_EVENT::ROE_WSKILL_USE, static_cast<CCharEntity*>(m_PEntity), RoeDatagram("skillType", m_PSkill->getType()));
                }
            }
        }
        else
        {
            // There used to be specific handling here for the Weaponskill interrupt, but it was assumed and should not be reintroduced without a test and a proper capture.
        }

        const auto delay = m_PSkill->getAnimationTime(); // TODO: Is delay time a fixed number if the weaponskill is used out of range?
        m_finishTime     = tick + delay;
        Complete();
    }
    else if (tick > m_finishTime)
    {
        if (m_PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(m_PEntity);
            PChar->m_charHistory.wsUsed++;
        }
        return true;
    }
    return false;
}

void CWeaponSkillState::Cleanup(const timer::time_point tick)
{
    if (!m_PEntity)
    {
        return;
    }

    // Interrupted.
    if (!IsCompleted())
    {
    }

    // Not interrupted.
    else
    {
    }

    // Call listener. Feed skill result.
    if (m_PEntity->isAlive())
    {
        m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_EXIT", m_PEntity, m_PSkill->getID(), IsCompleted());
    }
}

auto CWeaponSkillState::GetSpentTP() const -> int16
{
    return m_spent;
}

auto CWeaponSkillState::CanChangeState() -> bool
{
    return false;
}

auto CWeaponSkillState::CanFollowPath() -> bool
{
    return false;
}

auto CWeaponSkillState::CanInterrupt() -> bool
{
    return true;
}
