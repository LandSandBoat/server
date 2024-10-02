﻿/*
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

#include "range_state.h"

#include "ai/ai_container.h"
#include "entities/charentity.h"
#include "entities/trustentity.h"
#include "items/item_weapon.h"
#include "packets/action.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"

CRangeState::CRangeState(CBattleEntity* PEntity, uint16 targid)
: CState(PEntity, targid)
, m_PEntity(PEntity)
{
    auto* PTarget = m_PEntity->IsValidTarget(m_targid, TARGET_ENEMY, m_errorMsg);

    if (!PTarget || m_errorMsg)
    {
        throw CStateInitException(std::move(m_errorMsg));
    }

    if (!CanUseRangedAttack(PTarget, false))
    {
        throw CStateInitException(std::move(m_errorMsg));
    }

    if (distance(m_PEntity->loc.p, PTarget->loc.p) > 25)
    {
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, 0, 0, MSGBASIC_TOO_FAR_AWAY);
        throw CStateInitException(std::move(m_errorMsg));
    }

    auto delay = m_PEntity->GetRangedWeaponDelay(false);
    delay      = battleutils::GetSnapshotReduction(m_PEntity, delay);

    // TODO: Allow trusts to use this
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PEntity))
    {
        if (charutils::hasTrait(PChar, TRAIT_RAPID_SHOT))
        {
            auto chance{ PChar->getMod(Mod::RAPID_SHOT) + PChar->PMeritPoints->GetMeritValue(MERIT_RAPID_SHOT_RATE, PChar) };
            if (xirand::GetRandomNumber(100) < chance)
            {
                // reduce delay by 10%-50%
                delay       = (int16)(delay * (10 - xirand::GetRandomNumber(1, 6)) / 10.f);
                m_rapidShot = true;
            }
        }
    }

    m_aimTime  = std::chrono::milliseconds(delay);
    m_startPos = m_PEntity->loc.p;

    action_t action;
    action.id         = m_PEntity->id;
    action.actiontype = ACTION_RANGED_START;

    actionList_t& actionList  = action.getNewActionList();
    actionList.ActionTargetID = PTarget->id;

    actionTarget_t& actionTarget = actionList.getNewActionTarget();
    actionTarget.animation       = ANIMATION_RANGED;

    m_PEntity->PAI->EventHandler.triggerListener("RANGE_START", CLuaBaseEntity(m_PEntity), CLuaAction(&action));

    m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(action));
}

void CRangeState::SpendCost()
{
}

bool CRangeState::CanChangeState()
{
    return false;
}

bool CRangeState::Update(time_point tick)
{
    if (m_PEntity && m_PEntity->isAlive() && (tick > GetEntryTime() + m_aimTime && !IsCompleted()))
    {
        auto* PTarget = m_PEntity->IsValidTarget(m_targid, TARGET_ENEMY, m_errorMsg);

        CanUseRangedAttack(PTarget, true);
        if (HasMoved())
        {
            m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, m_PEntity, 0, 0, MSGBASIC_MOVE_AND_INTERRUPT);
        }

        action_t action;
        auto*    cast_errorMsg = dynamic_cast<CMessageBasicPacket*>(m_errorMsg.get());
        if (m_errorMsg && (!cast_errorMsg || cast_errorMsg->getMessageID() != MSGBASIC_CANNOT_SEE))
        {
            action.id         = m_PEntity->id;
            action.actiontype = ACTION_RANGED_INTERRUPT;

            actionList_t& actionList  = action.getNewActionList();
            actionList.ActionTargetID = PTarget ? PTarget->id : m_PEntity->id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();
            actionTarget.animation       = ANIMATION_RANGED;

            if (auto* PChar = dynamic_cast<CCharEntity*>(m_PEntity))
            {
                PChar->pushPacket(m_errorMsg.release());
            }
            // reset aim time so interrupted players only have to wait the correct 2.7s until next shot
            m_aimTime = std::chrono::seconds(0);
            m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(action));
            m_PEntity->PAI->EventHandler.triggerListener("RANGE_STATE_EXIT", CLuaBaseEntity(m_PEntity), nullptr, CLuaAction(&action));
        }
        else
        {
            m_errorMsg.reset();

            m_PEntity->OnRangedAttack(*this, action);
            m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(action));
            m_PEntity->PAI->EventHandler.triggerListener("RANGE_STATE_EXIT", CLuaBaseEntity(m_PEntity), CLuaBaseEntity(PTarget), CLuaAction(&action));
        }

        Complete();
    }

    if (IsCompleted() && tick > GetEntryTime() + m_aimTime + m_returnWeaponDelay)
    {
        if (auto* PChar = dynamic_cast<CCharEntity*>(m_PEntity))
        {
            PChar->m_LastRangedAttackTime = GetEntryTime() + m_aimTime + m_returnWeaponDelay;
        }
        return true;
    }

    return false;
}

void CRangeState::Cleanup(time_point tick)
{
}

bool CRangeState::CanUseRangedAttack(CBattleEntity* PTarget, bool isEndOfAttack)
{
    if (!PTarget)
    {
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, m_PEntity, 0, 0, MSGBASIC_CANNOT_ATTACK_TARGET);
        return false;
    }

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PEntity))
    {
        CItemWeapon* PRanged = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_RANGED));
        CItemWeapon* PAmmo   = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));

        if (!((PRanged && PRanged->isType(ITEM_WEAPON)) || (PAmmo && PAmmo->isThrowing())))
        {
            m_errorMsg = std::make_unique<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_NO_RANGED_WEAPON);
            return false;
        }

        auto SkillType = PRanged ? PRanged->getSkillType() : PAmmo->getSkillType();

        switch (SkillType)
        {
            case SKILL_THROWING:
            {
                // remove barrage, doesn't work here
                PChar->StatusEffectContainer->DelStatusEffect(EFFECT_BARRAGE);
                break;
            }
            case SKILL_ARCHERY:
            case SKILL_MARKSMANSHIP:
            {
                PRanged = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));
                if (PRanged != nullptr && PRanged->isType(ITEM_WEAPON))
                {
                    break;
                }
                else
                {
                    m_errorMsg = std::make_unique<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_NO_RANGED_WEAPON);
                    return false;
                }
            }
            default:
            {
                m_errorMsg = std::make_unique<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_NO_RANGED_WEAPON);
                return false;
            }
        }
    }

    if (!facing(m_PEntity->loc.p, PTarget->loc.p, 64))
    {
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, 0, 0, MSGBASIC_CANNOT_SEE);
        return false;
    }

    if (!isEndOfAttack && !m_PEntity->CanSeeTarget(PTarget, false))
    {
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION);
        return false;
    }

    // make sure player is waiting the appropriate time between ranged attacks
    if (auto PChar = dynamic_cast<CCharEntity*>(m_PEntity))
    {
        if (m_PEntity->PAI->getTick() - PChar->m_LastRangedAttackTime < m_freePhaseTime)
        {
            m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, 0, 0, MSGBASIC_WAIT_LONGER);
            return false;
        }
    }

    uint8 anim = m_PEntity->animation;
    if (anim != ANIMATION_NONE && anim != ANIMATION_ATTACK)
    {
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, 0, 0, MSGBASIC_CANNOT_PERFORM_ACTION);
        return false;
    }

    return true;
}

bool CRangeState::HasMoved()
{
    return floorf(m_startPos.x * 10 + 0.5f) / 10 != floorf(m_PEntity->loc.p.x * 10 + 0.5f) / 10 || floorf(m_startPos.y * 10 + 0.5f) / 10 != floorf(m_PEntity->loc.p.y * 10 + 0.5f) / 10 || floorf(m_startPos.z * 10 + 0.5f) / 10 != floorf(m_PEntity->loc.p.z * 10 + 0.5f) / 10;
}
