/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "0x0dd_equip_inspect.h"

#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "enums/msg_std.h"
#include "items/item_weapon.h"
#include "mob_modifier.h"
#include "packets/char_check.h"
#include "packets/s2c/0x009_message.h"
#include "packets/s2c/0x029_battle_message.h"
#include "packets/s2c/0x0ca_inspect_message.h"
#include "utils/charutils.h"
#include "utils/jailutils.h"

auto GP_CLI_COMMAND_EQUIP_INSPECT::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_EQUIP_INSPECT_KIND>(Kind);
}

void GP_CLI_COMMAND_EQUIP_INSPECT::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (jailutils::InPrison(PChar))
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return;
    }

    CBaseEntity* PEntity     = PChar->GetEntity(ActIndex, TYPE_MOB | TYPE_PC);
    auto*        PMobTarget  = dynamic_cast<CMobEntity*>(PEntity);
    auto*        PCharTarget = dynamic_cast<CCharEntity*>(PEntity);

    if (PCharTarget && distance(PChar->loc.p, PCharTarget->loc.p) > 50)
    {
        // /check on PC has a 50 yalms range
        ShowWarning("GP_CLI_COMMAND_EQUIP_INSPECT: {} attempting to check PC {} from too far away", PChar->getName(), PCharTarget->getName());
        return;
    }

    if (PMobTarget && distance(PChar->loc.p, PMobTarget->loc.p) > 50)
    {
        // Limit doesn't apply to monsters, but we still log it
        ShowWarning("GP_CLI_COMMAND_EQUIP_INSPECT: {} checking mob {} from too far away", PChar->getName(), PMobTarget->getName());
    }

    switch (static_cast<GP_CLI_COMMAND_EQUIP_INSPECT_KIND>(Kind))
    {
        case GP_CLI_COMMAND_EQUIP_INSPECT_KIND::Check:
        {
            if (!PEntity || PEntity->id != UniqueNo)
            {
                return;
            }

            if (PMobTarget)
            {
                // /check on a mob
                if (PMobTarget->m_Type & MOBTYPE_NOTORIOUS || PMobTarget->m_Type & MOBTYPE_BATTLEFIELD || PMobTarget->getMobMod(MOBMOD_CHECK_AS_NM) > 0)
                {
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PMobTarget, 0, 0, MSGBASIC_CHECK_ITG);
                }
                else
                {
                    uint8          mobLvl   = PMobTarget->GetMLevel();
                    EMobDifficulty mobCheck = charutils::CheckMob(PChar->GetMLevel(), mobLvl);

                    // Calculate main /check message (64 is Too Weak)
                    int32 MessageValue = 64 + static_cast<uint8>(mobCheck);

                    // Grab mob and player stats for extra messaging
                    const uint16 charAcc = PChar->ACC(SLOT_MAIN, 0);
                    const uint16 charAtt = PChar->ATT(SLOT_MAIN);
                    const uint16 mobEva  = PMobTarget->EVA();
                    const uint16 mobDef  = PMobTarget->DEF();

                    // Calculate +/- message
                    uint16 MessageID = MSGBASIC_CHECK_DEFAULT;

                    // Offsetting the message ID by a certain amount for each stat gives us the correct message
                    // Defense is +/- 1
                    // Evasion is +/- 3
                    if (mobDef > charAtt)
                    { // High Defense
                        MessageID -= 1;
                    }
                    else if ((mobDef * 1.25) <= charAtt)
                    { // Low Defense
                        MessageID += 1;
                    }

                    if ((mobEva - 30) > charAcc)
                    { // High Evasion
                        MessageID -= 3;
                    }
                    else if ((mobEva + 10) <= charAcc)
                    {
                        MessageID += 3;
                    }

                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PMobTarget, mobLvl, MessageValue, static_cast<MSGBASIC_ID>(MessageID));
                }
            }
            else if (PCharTarget)
            {
                // /check on a player
                if (!PChar->m_isGMHidden || (PChar->m_isGMHidden && PCharTarget->m_GMlevel >= PChar->m_GMlevel))
                {
                    PCharTarget->pushPacket<GP_SERV_COMMAND_MESSAGE>(PChar, 0, 0, MsgStd::Examine);
                }

                PChar->pushPacket<GP_SERV_COMMAND_INSPECT_MESSAGE>(PCharTarget);
                PChar->pushPacket<CCheckPacket>(PChar, PCharTarget);
            }
        }
        break;
        case GP_CLI_COMMAND_EQUIP_INSPECT_KIND::CheckName:
        {
            if (PCharTarget && PCharTarget->m_PMonstrosity)
            {
                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(PCharTarget, 0, 0, MsgStd::MonstrosityCheckOut);
                PCharTarget->pushPacket<GP_SERV_COMMAND_MESSAGE>(PChar, 0, 0, MsgStd::MonstrosityCheckIn);
            }
        }
        break;
        case GP_CLI_COMMAND_EQUIP_INSPECT_KIND::CheckParam:
        {
            if (PChar->id == UniqueNo)
            {
                // /checkparam on self

                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MSGBASIC_CHECKPARAM_NAME);
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MSGBASIC_CHECKPARAM_ILVL);
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, PChar->ACC(0, 0), PChar->ATT(SLOT_MAIN), MSGBASIC_CHECKPARAM_PRIMARY);

                if (PChar->getEquip(SLOT_SUB) && PChar->getEquip(SLOT_SUB)->isType(ITEM_WEAPON))
                {
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, PChar->ACC(1, 0), PChar->ATT(SLOT_SUB), MSGBASIC_CHECKPARAM_AUXILIARY);
                }
                else
                {
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MSGBASIC_CHECKPARAM_AUXILIARY);
                }

                if (PChar->getEquip(SLOT_RANGED) && PChar->getEquip(SLOT_RANGED)->isType(ITEM_WEAPON))
                {
                    const int skill      = static_cast<CItemWeapon*>(PChar->getEquip(SLOT_RANGED))->getSkillType();
                    const int bonusSkill = static_cast<CItemWeapon*>(PChar->getEquip(SLOT_RANGED))->getILvlSkill();
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, PChar->RACC(skill, bonusSkill), PChar->RATT(skill, bonusSkill), MSGBASIC_CHECKPARAM_RANGE);
                }
                else if (PChar->getEquip(SLOT_AMMO) && PChar->getEquip(SLOT_AMMO)->isType(ITEM_WEAPON))
                {
                    const int skill      = static_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO))->getSkillType();
                    const int bonusSkill = static_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO))->getILvlSkill();
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, PChar->RACC(skill, bonusSkill), PChar->RATT(skill, bonusSkill), MSGBASIC_CHECKPARAM_RANGE);
                }
                else
                {
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MSGBASIC_CHECKPARAM_RANGE);
                }

                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, PChar->EVA(), PChar->DEF(), MSGBASIC_CHECKPARAM_DEFENSE);
            }
            else if (PChar->PPet && PChar->PPet->id == UniqueNo)
            {
                // /checkparam on pet

                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar->PPet, 0, 0, MSGBASIC_CHECKPARAM_NAME);
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar->PPet, PChar->PPet->ACC(0, 0), PChar->PPet->ATT(SLOT_MAIN), MSGBASIC_CHECKPARAM_PRIMARY);
                if (PChar->getEquip(SLOT_SUB) && PChar->getEquip(SLOT_SUB)->isType(ITEM_WEAPON))
                {
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar->PPet, PChar->PPet->ACC(1, 0), PChar->PPet->ATT(SLOT_MAIN), MSGBASIC_CHECKPARAM_AUXILIARY);
                }
                else
                {
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar->PPet, 0, 0, MSGBASIC_CHECKPARAM_AUXILIARY);
                }
                if (PChar->getEquip(SLOT_RANGED) && PChar->getEquip(SLOT_RANGED)->isType(ITEM_WEAPON))
                {
                    const int skill = static_cast<CItemWeapon*>(PChar->getEquip(SLOT_RANGED))->getSkillType();
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar->PPet, PChar->PPet->RACC(skill), PChar->PPet->RATT(skill), MSGBASIC_CHECKPARAM_RANGE);
                }
                else if (PChar->getEquip(SLOT_AMMO) && PChar->getEquip(SLOT_AMMO)->isType(ITEM_WEAPON))
                {
                    const int skill = static_cast<CItemWeapon*>(PChar->getEquip(SLOT_AMMO))->getSkillType();
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar->PPet, PChar->PPet->RACC(skill), PChar->PPet->RATT(skill), MSGBASIC_CHECKPARAM_RANGE);
                }
                else
                {
                    PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar->PPet, 0, 0, MSGBASIC_CHECKPARAM_RANGE);
                }

                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar->PPet, PChar->PPet->EVA(), PChar->PPet->DEF(), MSGBASIC_CHECKPARAM_DEFENSE);
            }

            break;
        }
    }
}
