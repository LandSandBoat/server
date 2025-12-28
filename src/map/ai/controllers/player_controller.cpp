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

#include "player_controller.h"

#include "ability.h"
#include "ai/ai_container.h"
#include "ai/states/death_state.h"
#include "ai/states/inactive_state.h"
#include "entities/charentity.h"
#include "items/item_weapon.h"
#include "latent_effect_container.h"
#include "packets/s2c/0x029_battle_message.h"
#include "packets/s2c/0x058_assist.h"
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

void CPlayerController::Tick(timer::time_point /*tick*/)
{
}

bool CPlayerController::Cast(uint16 targid, SpellID spellid)
{
    auto* PChar = static_cast<CCharEntity*>(POwner);
    if (canAct() && !PChar->PRecastContainer->HasRecast(RECAST_MAGIC, static_cast<Recast>(spellid), 0s))
    {
        if (auto target = PChar->GetEntity(targid); target && target->PAI->IsUntargetable())
        {
            return false;
        }
        return CController::Cast(targid, spellid);
    }
    else
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::UNABLE_TO_CAST);
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
            if (m_lastAttackTime + std::chrono::milliseconds(PChar->GetWeaponDelay(false)) < timer::now())
            {
                if (CController::Engage(targid))
                {
                    PChar->PLatentEffectContainer->CheckLatentsWeaponDraw(true);
                    PChar->pushPacket<GP_SERV_COMMAND_ASSIST>(PChar, PTarget);
                    return true;
                }
            }
            else
            {
                errMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PTarget, 0, 0, MsgBasic::WAIT_LONGER);
            }
        }
        else
        {
            errMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PTarget, 0, 0, MsgBasic::TOO_FAR_AWAY);
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
    if (canAct() && PChar->PAI->CanChangeState())
    {
        CAbility* PAbility = ability::GetAbility(abilityid);
        if (!PAbility)
        {
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::UNABLE_TO_USE_JA);
            return false;
        }
        if (PChar->PRecastContainer->HasRecast(RECAST_ABILITY, PAbility->getRecastId(), PAbility->getRecastTime()))
        {
            Recast_t* recast = PChar->PRecastContainer->GetRecast(RECAST_ABILITY, PAbility->getRecastId());
            // Set recast time to the normal recast time minus any charge time.
            // Abilities without a charge will have zero chargeTime
            timer::duration currentRecast = recast->TimeStamp - timer::now() + recast->RecastTime;
            // Abilities with a single charge (low-level scholar stratagems) behave like abilities without a charge
            if (recast->maxCharges > 1)
            {
                currentRecast -= recast->chargeTime * (recast->maxCharges - 1);
            }

            currentRecast = std::chrono::ceil<std::chrono::seconds>(currentRecast);
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::UNABLE_TO_USE_JA2);
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, static_cast<uint32>(std::max<int64>(timer::count_seconds(currentRecast), 0)), 0, MsgBasic::TIME_LEFT);
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
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::UNABLE_TO_USE_JA);
        return false;
    }
}

bool CPlayerController::RangedAttack(uint16 targid)
{
    auto* PChar = static_cast<CCharEntity*>(POwner);
    if (canAct() && PChar->PAI->CanChangeState())
    {
        if (auto target = PChar->GetEntity(targid); target && target->PAI->IsUntargetable())
        {
            return false;
        }
        return PChar->PAI->Internal_RangedAttack(targid);
    }
    else
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::WAIT_LONGER);
    }
    return false;
}

bool CPlayerController::UseItem(uint16 targid, uint8 loc, uint8 slotid)
{
    auto* PChar = static_cast<CCharEntity*>(POwner);
    if (canAct() && PChar->PAI->CanChangeState())
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
    if (canAct() && PChar->PAI->CanChangeState())
    {
        // TODO: put all this in weaponskill_state
        CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(wsid);

        if (PWeaponSkill == nullptr)
        {
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::CANNOT_USE_WS);
            return false;
        }

        if (!charutils::hasWeaponSkill(PChar, PWeaponSkill->getID()) || !charutils::canUseWeaponSkill(PChar, wsid))
        {
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::CANNOT_USE_WS);
            return false;
        }

        if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_AMNESIA) || (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_IMPAIRMENT) && (PChar->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower() == 0x02 || PChar->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower() == 0x03)))
        {
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::CANNOT_USE_ANY_WS);
            return false;
        }

        if (PChar->health.tp < 1000)
        {
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::NOT_ENOUGH_TP);
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
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::NO_RANGED_WEAPON);
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
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PTarget, 0, 0, MsgBasic::CANNOT_SEE);
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
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::UNABLE_TO_USE_WS);
    }
    return false;
}

timer::time_point CPlayerController::getLastAttackTime()
{
    return m_lastAttackTime;
}

void CPlayerController::setLastAttackTime(timer::time_point _lastAttackTime)
{
    m_lastAttackTime = _lastAttackTime;
}

timer::time_point CPlayerController::getLastSpellFinishedTime()
{
    return m_spellFinishedTime;
}

void CPlayerController::setLastSpellFinishedTime(timer::time_point _spellFinishedTime)
{
    m_spellFinishedTime = _spellFinishedTime;
}

void CPlayerController::setLastErrMsgTime(timer::time_point _LastErrMsgTime)
{
    m_errMsgTime = _LastErrMsgTime;
}

timer::time_point CPlayerController::getLastErrMsgTime()
{
    return m_errMsgTime;
}

CWeaponSkill* CPlayerController::getLastWeaponSkill()
{
    return m_lastWeaponSkill;
}

// Spells, JAs, ranged attacks and items can't be used instantly after a spell finishes
// Engaging seems to be immune to this
// TODO: there seems to be a penalty or rate limit to incoming 0x01As if you act too early
bool CPlayerController::canAct()
{
    auto timeSinceLastSpell = timer::now() - getLastSpellFinishedTime();

    return timeSinceLastSpell > 2.5s;
}
