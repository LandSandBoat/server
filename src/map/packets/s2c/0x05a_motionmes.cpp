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

#include "0x05a_motionmes.h"

#include "entities/charentity.h"
#include "entities/npcentity.h"
#include "item_container.h"
#include "items/item_weapon.h"

GP_SERV_COMMAND_MOTIONMES::GP_SERV_COMMAND_MOTIONMES(const CCharEntity* PChar, const uint32 targetId, const uint16 targetIndex, Emote emoteId, EmoteMode emoteMode, const uint16 extra)
{
    auto& packet = this->data();

    packet.CasUniqueNo = PChar->id;
    packet.CasActIndex = PChar->targid;
    packet.TarUniqueNo = targetId;
    packet.TarActIndex = targetIndex;
    packet.MesNum      = emoteId == Emote::Job ? static_cast<uint8>(emoteId) + (extra - 0x1F) : static_cast<uint8>(emoteId);

    if (emoteId == Emote::Salute)
    {
        packet.Param = PChar->profile.nation;
    }
    else if (emoteId == Emote::Hurray)
    {
        const auto* PWeapon = PChar->getStorage(PChar->equipLoc[SLOT_MAIN])->GetItem(PChar->equip[SLOT_MAIN]);
        if (PWeapon && PWeapon->getID() != 65535)
        {
            packet.Param = PWeapon->getID();
        }
    }
    else if (emoteId == Emote::Aim)
    {
        packet.Param               = 65535;
        const CItemWeapon* PWeapon = static_cast<CItemWeapon*>(PChar->getStorage(PChar->equipLoc[SLOT_RANGED])->GetItem(PChar->equip[SLOT_RANGED]));
        if (PWeapon && PWeapon->getID() != 65535)
        {
            if (PWeapon->getSkillType() == SKILL_THROWING)
            {
                packet.Param = PWeapon->getID();
            }
            else if (PWeapon->getSkillType() == SKILL_MARKSMANSHIP || PWeapon->getSkillType() == SKILL_ARCHERY)
            {
                const CItemWeapon* PAmmo = static_cast<CItemWeapon*>(PChar->getStorage(PChar->equipLoc[SLOT_AMMO])->GetItem(PChar->equip[SLOT_AMMO]));
                if (PAmmo && PAmmo->getID() != 65535)
                {
                    packet.Param = PWeapon->getID();
                }
            }
        }
    }
    else if (emoteId == Emote::Bell)
    {
        // No emote text for /bell
        emoteMode = EmoteMode::Motion;

        packet.Param = (extra - 0x06);
    }
    else if (emoteId == Emote::Job)
    {
        packet.Param = (extra - 0x1F);
    }

    packet.Mode = emoteMode;
}

GP_SERV_COMMAND_MOTIONMES::GP_SERV_COMMAND_MOTIONMES(const CNpcEntity* PEntity, const uint32 targetId, const uint16 targetIndex, Emote emoteId, EmoteMode emoteMode)
{
    auto& packet = this->data();

    packet.CasUniqueNo = PEntity->id;
    packet.TarUniqueNo = targetId;
    packet.CasActIndex = PEntity->targid;
    packet.TarActIndex = targetIndex;
    packet.MesNum      = static_cast<uint8>(emoteId);
    packet.Mode        = emoteMode;
}
