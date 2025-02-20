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

#include "ai/ai_container.h"
#include "entities/battleentity.h"
#include "packets/action.h"
#include "roe.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "weapon_skill.h"

CWeaponSkillState::CWeaponSkillState(CBattleEntity* PEntity, uint16 targid, uint16 wsid)
: CState(PEntity, targid)
, m_PEntity(PEntity)
{
    auto* skill = battleutils::GetWeaponSkill(wsid);
    if (!skill)
    {
        throw CStateInitException(std::make_unique<CMessageBasicPacket>(PEntity, PEntity, 0, 0, MSGBASIC_CANNOT_USE_WS));
    }

    auto  target_flags = battleutils::isValidSelfTargetWeaponskill(wsid) ? TARGET_SELF : TARGET_ENEMY;
    auto* PTarget      = m_PEntity->IsValidTarget(m_targid, target_flags, m_errorMsg);

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

    if (!m_PEntity->CanSeeTarget(PTarget, false))
    {
        throw CStateInitException(std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION));
    }

    m_PSkill = std::make_unique<CWeaponSkill>(*skill);

    action_t action;
    action.id         = m_PEntity->id;
    action.actiontype = ACTION_WEAPONSKILL_START;

    actionList_t& actionList  = action.getNewActionList();
    actionList.ActionTargetID = PTarget->id;

    actionTarget_t& actionTarget = actionList.getNewActionTarget();

    actionTarget.reaction   = REACTION::NONE;
    actionTarget.speceffect = SPECEFFECT::NONE;
    actionTarget.animation  = 0;
    actionTarget.param      = m_PSkill->getID();
    actionTarget.messageID  = 43;
    m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(action));
}

CWeaponSkill* CWeaponSkillState::GetSkill()
{
    return m_PSkill.get();
}

void CWeaponSkillState::SpendCost()
{
    auto tp = 0;
    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MEIKYO_SHISUI))
    {
        tp = m_PEntity->addTP(-1000);
    }
    else if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SEKKANOKI))
    {
        tp = m_PEntity->addTP(-1000);
        m_PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_SEKKANOKI);
    }
    else
    {
        tp = m_PEntity->health.tp;

        if (m_PEntity->getMod(Mod::WS_NO_DEPLETE) <= xirand::GetRandomNumber(100))
        {
            m_PEntity->addTP(-tp);
        }
    }

    if (xirand::GetRandomNumber(100) < m_PEntity->getMod(Mod::CONSERVE_TP))
    {
        m_PEntity->addTP(xirand::GetRandomNumber(10, 200));
    }

    m_spent = tp;
}

bool CWeaponSkillState::Update(time_point tick)
{
    if (m_PEntity && m_PEntity->isAlive() && !IsCompleted())
    {
        CBattleEntity* PTarget = dynamic_cast<CBattleEntity*>(GetTarget());
        action_t       action;

        if (PTarget && PTarget->isAlive())
        {
            SpendCost();

            m_PEntity->OnWeaponSkillFinished(*this, action);
            m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(action));

            // Reset Restraint bonus and trackers on weaponskill use
            if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_RESTRAINT))
            {
                uint16 WSBonus = m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_RESTRAINT)->GetPower();
                m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_RESTRAINT)->SetPower(0);
                m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_RESTRAINT)->SetSubPower(0);
                m_PEntity->delModifier(Mod::ALL_WSDMG_FIRST_HIT, WSBonus);
            }

            if (action.actiontype == ACTION_WEAPONSKILL_FINISH) // category changes upon being out of range. This does not count for RoE and delay is not increased beyond the normal delay.
            {
                // only send lua the WS events if we are in range
                uint32 weaponskillVar    = PTarget->GetLocalVar("weaponskillHit");
                uint32 weaponskillDamage = weaponskillVar & 0xFFFFFF;

                m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_USE", m_PEntity, PTarget, m_PSkill->getID(), m_spent, &action, weaponskillDamage);
                PTarget->PAI->EventHandler.triggerListener("WEAPONSKILL_TAKE", PTarget, m_PEntity, m_PSkill->getID(), m_spent, &action);

                if (m_PEntity->objtype == TYPE_PC)
                {
                    roeutils::event(ROE_EVENT::ROE_WSKILL_USE, static_cast<CCharEntity*>(m_PEntity), RoeDatagram("skillType", m_PSkill->getType()));
                }
            }
        }
        else // Mob is dead before we could finish WS, generate interrupt for WS
        {
            // Could not reproduce on retail due to server tick rate, this entire block is assumed.
            // Ideally, you would ready a WS then have the mob die to either a DoT or a JA like Quick Draw/Jump and dump the packet.
            // To the best of our knowledge this would produce a similar-enough effect to cancel the WS animation
            // Essentially, very similar to "too far away" and casting out of range spell cancellation, with no message.
            action.actiontype        = ACTION_MAGIC_FINISH;
            action.actionid          = 28787; // Some hardcoded magic for interrupts
            actionList_t& actionList = action.getNewActionList();

            if (PTarget)
            {
                actionList.ActionTargetID = PTarget->id;
            }
            else // Dead code? PTarget should probably never be nullptr.
            {
                actionList.ActionTargetID = 0;
            }

            actionTarget_t& actionTarget = actionList.getNewActionTarget();

            actionTarget.animation = 0x1FC;
            actionTarget.messageID = 0;
            actionTarget.reaction  = REACTION::ABILITY | REACTION::HIT;

            m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(action));
        }

        auto delay   = m_PSkill->getAnimationTime(); // TODO: Is delay time a fixed number if the weaponskill is used out of range?
        m_finishTime = tick + delay;
        Complete();
    }
    else if (tick > m_finishTime)
    {
        if (m_PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(m_PEntity);
            PChar->m_charHistory.wsUsed++;
        }
        m_PEntity->PAI->EventHandler.triggerListener("WEAPONSKILL_STATE_EXIT", m_PEntity, m_PSkill->getID());
        return true;
    }
    return false;
}

void CWeaponSkillState::Cleanup(time_point tick)
{
    // TODO: interrupt an in progress ws
}
