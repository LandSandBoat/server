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

#include "player_controller.h"

#include "ability.h"
#include "ai/ai_container.h"
#include "ai/states/death_state.h"
#include "ai/states/inactive_state.h"
#include "entities/charentity.h"
#include "items/item_weapon.h"
#include "latent_effect_container.h"
#include "packets/char_update.h"
#include "packets/lock_on.h"
#include "recast_container.h"
#include "roe.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "weapon_skill.h"

CPlayerController::CPlayerController(CCharEntity* _PChar)
: CController(_PChar)
{
}

void CPlayerController::Tick(time_point /*tick*/)
{
}

bool CPlayerController::Cast(uint16 targid, SpellID spellid)
{
    auto* PChar = static_cast<CCharEntity*>(POwner);
    if (!PChar->PRecastContainer->HasRecast(RECAST_MAGIC, static_cast<uint16>(spellid), 0))
    {
        if (auto target = PChar->GetEntity(targid); target && target->PAI->IsUntargetable())
        {
            return false;
        }
        return CController::Cast(targid, spellid);
    }
    else
    {
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_CAST);
        return false;
    }
}

bool CPlayerController::Engage(uint16 targid)
{
    // TODO: pet engage/disengage
    std::unique_ptr<CBasicPacket> errMsg;
    auto*                         PChar   = static_cast<CCharEntity*>(POwner);
    auto*                         PTarget = PChar->IsValidTarget(targid, TARGET_ENEMY, errMsg);

    if (PTarget)
    {
        if (distance(PChar->loc.p, PTarget->loc.p) < 30)
        {
            if (m_lastAttackTime + std::chrono::milliseconds(PChar->GetWeaponDelay(false)) < server_clock::now())
            {
                if (CController::Engage(targid))
                {
                    PChar->PLatentEffectContainer->CheckLatentsWeaponDraw(true);
                    PChar->pushPacket<CLockOnPacket>(PChar, PTarget);
                    return true;
                }
            }
            else
            {
                errMsg = std::make_unique<CMessageBasicPacket>(PChar, PTarget, 0, 0, MSGBASIC_WAIT_LONGER);
            }
        }
        else
        {
            errMsg = std::make_unique<CMessageBasicPacket>(PChar, PTarget, 0, 0, MSGBASIC_TOO_FAR_AWAY);
        }
    }
    if (errMsg)
    {
        PChar->HandleErrorMessage(errMsg);
    }
    return false;
}

bool CPlayerController::ChangeTarget(uint16 targid)
{
    return CController::ChangeTarget(targid);
}

bool CPlayerController::Disengage()
{
    return CController::Disengage();
}

bool CPlayerController::Ability(uint16 targid, uint16 abilityid)
{
    auto* PChar = static_cast<CCharEntity*>(POwner);
    if (PChar->PAI->CanChangeState())
    {
        CAbility* PAbility = ability::GetAbility(abilityid);
        if (!PAbility)
        {
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA);
            return false;
        }
        if (PChar->PRecastContainer->HasRecast(RECAST_ABILITY, PAbility->getRecastId(), PAbility->getRecastTime()))
        {
            Recast_t* recast = PChar->PRecastContainer->GetRecast(RECAST_ABILITY, PAbility->getRecastId());
            // Set recast time in seconds to the normal recast time minus any charge time with the difference of the current time minus when the recast was set.
            // Abilities without a charge will have zero chargeTime
            uint32 recastSeconds = recast->RecastTime - ((uint32)time(nullptr) - recast->TimeStamp);
            // Abilities with a single charge (low-level scholoar stratagems) behave like abilities without a charge
            if (recast->maxCharges > 1)
            {
                recastSeconds -= (recast->maxCharges - 1) * recast->chargeTime;
            }

            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2);
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, recastSeconds, 0, MSGBASIC_TIME_LEFT);
            return false;
        }
        if (auto target = PChar->GetEntity(targid); target && target->PAI->IsUntargetable())
        {
            return false;
        }
        return PChar->PAI->Internal_Ability(targid, abilityid);
    }
    else
    {
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_JA);
        return false;
    }
}

bool CPlayerController::RangedAttack(uint16 targid)
{
    auto* PChar = static_cast<CCharEntity*>(POwner);
    if (PChar->PAI->CanChangeState())
    {
        if (auto target = PChar->GetEntity(targid); target && target->PAI->IsUntargetable())
        {
            return false;
        }
        return PChar->PAI->Internal_RangedAttack(targid);
    }
    else
    {
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_WAIT_LONGER);
    }
    return false;
}

bool CPlayerController::UseItem(uint16 targid, uint8 loc, uint8 slotid)
{
    auto* PChar = static_cast<CCharEntity*>(POwner);
    if (PChar->PAI->CanChangeState())
    {
        if (auto target = PChar->GetEntity(targid); target && target->PAI->IsUntargetable())
        {
            return false;
        }
        return PChar->PAI->Internal_UseItem(targid, loc, slotid);
    }
    return false;
}

bool CPlayerController::WeaponSkill(uint16 targid, uint16 wsid)
{
    auto* PChar = static_cast<CCharEntity*>(POwner);
    if (PChar->PAI->CanChangeState())
    {
        // TODO: put all this in weaponskill_state
        CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(wsid);

        if (PWeaponSkill == nullptr)
        {
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_WS);
            return false;
        }

        if (!charutils::hasWeaponSkill(PChar, PWeaponSkill->getID()) || !charutils::canUseWeaponSkill(PChar, wsid))
        {
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_WS);
            return false;
        }

        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_AMNESIA) || (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_IMPAIRMENT) && (PChar->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower() == 0x02 || PChar->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower() == 0x03)))
        {
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_ANY_WS);
            return false;
        }

        if (PChar->health.tp < 1000)
        {
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_NOT_ENOUGH_TP);
            return false;
        }

        if (PWeaponSkill->getType() == SKILL_ARCHERY || PWeaponSkill->getType() == SKILL_MARKSMANSHIP)
        {
            auto* PItem  = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO));
            auto* weapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_RANGED]);
            auto* ammo   = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_AMMO]);

            // before allowing ranged weapon skill...
            if (PItem == nullptr || !weapon || !weapon->isRanged() || !ammo || !ammo->isRanged() || PChar->equip[SLOT_AMMO] == 0)
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_NO_RANGED_WEAPON);
                return false;
            }
        }

        std::unique_ptr<CBasicPacket> errMsg;

        auto* PTarget = PChar->IsValidTarget(targid, battleutils::isValidSelfTargetWeaponskill(wsid) ? TARGET_SELF : TARGET_ENEMY, errMsg);
        if (PTarget)
        {
            if (PTarget->PAI->IsUntargetable())
            {
                return false;
            }

            if (!facing(PChar->loc.p, PTarget->loc.p, 64) && PTarget != PChar)
            {
                PChar->pushPacket<CMessageBasicPacket>(PChar, PTarget, 0, 0, MSGBASIC_CANNOT_SEE);
                return false;
            }

            m_lastWeaponSkill = PWeaponSkill;

            return CController::WeaponSkill(targid, wsid);
        }
        else if (errMsg)
        {
            PChar->pushPacket(std::move(errMsg));
        }
    }
    else
    {
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_UNABLE_TO_USE_WS);
    }
    return false;
}

time_point CPlayerController::getLastAttackTime()
{
    return m_lastAttackTime;
}

void CPlayerController::setLastAttackTime(time_point _lastAttackTime)
{
    m_lastAttackTime = _lastAttackTime;
}

void CPlayerController::setLastErrMsgTime(time_point _LastErrMsgTime)
{
    m_errMsgTime = _LastErrMsgTime;
}

time_point CPlayerController::getLastErrMsgTime()
{
    return m_errMsgTime;
}

CWeaponSkill* CPlayerController::getLastWeaponSkill()
{
    return m_lastWeaponSkill;
}
