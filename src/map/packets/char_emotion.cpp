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

#include "char_emotion.h"
#include "entities/charentity.h"
#include "entities/npcentity.h"
#include "item_container.h"
#include "items/item_weapon.h"

CCharEmotionPacket::CCharEmotionPacket(const CCharEntity* PChar, const uint32 targetId, const uint16 targetIndex, Emote emoteId, EmoteMode emoteMode, const uint16 extra)
{
    this->setType(0x5A);
    this->setSize(0x70);

    ref<uint32>(0x04) = PChar->id;
    ref<uint32>(0x08) = targetId;
    ref<uint16>(0x0C) = PChar->targid;
    ref<uint16>(0x0E) = targetIndex;
    ref<uint8>(0x10)  = emoteId == Emote::JOB ? static_cast<uint8>(emoteId) + (extra - 0x1F) : static_cast<uint8>(emoteId);

    if (emoteId == Emote::SALUTE)
    {
        ref<uint16>(0x12) = PChar->profile.nation;
    }
    else if (emoteId == Emote::HURRAY)
    {
        const auto* PWeapon = PChar->getStorage(PChar->equipLoc[SLOT_MAIN])->GetItem(PChar->equip[SLOT_MAIN]);
        if (PWeapon && PWeapon->getID() != 65535)
        {
            ref<uint16>(0x12) = PWeapon->getID();
        }
    }
    else if (emoteId == Emote::AIM)
    {
        ref<uint16>(0x12)          = 65535;
        const CItemWeapon* PWeapon = static_cast<CItemWeapon*>(PChar->getStorage(PChar->equipLoc[SLOT_RANGED])->GetItem(PChar->equip[SLOT_RANGED]));
        if (PWeapon && PWeapon->getID() != 65535)
        {
            if (PWeapon->getSkillType() == SKILL_THROWING)
            {
                ref<uint16>(0x12) = PWeapon->getID();
            }
            else if (PWeapon->getSkillType() == SKILL_MARKSMANSHIP || PWeapon->getSkillType() == SKILL_ARCHERY)
            {
                const CItemWeapon* PAmmo = static_cast<CItemWeapon*>(PChar->getStorage(PChar->equipLoc[SLOT_AMMO])->GetItem(PChar->equip[SLOT_AMMO]));
                if (PAmmo && PAmmo->getID() != 65535)
                {
                    ref<uint16>(0x12) = PWeapon->getID();
                }
            }
        }
    }
    else if (emoteId == Emote::BELL)
    {
        // No emote text for /bell
        emoteMode = EmoteMode::MOTION;

        ref<uint8>(0x12) = (extra - 0x06);
    }
    else if (emoteId == Emote::JOB)
    {
        ref<uint8>(0x12) = (extra - 0x1F);
    }

    ref<uint8>(0x16) = static_cast<uint8>(emoteMode);
}

CCharEmotionPacket::CCharEmotionPacket(const CNpcEntity* PEntity, const uint32 targetId, const uint16 targetIndex, Emote emoteId, EmoteMode emoteMode)
{
    this->setType(0x5A);
    this->setSize(0x70);

    ref<uint32>(0x04) = PEntity->id;
    ref<uint32>(0x08) = targetId;
    ref<uint16>(0x0C) = PEntity->targid;
    ref<uint16>(0x0E) = targetIndex;
    ref<uint8>(0x10)  = static_cast<uint8>(emoteId);
    ref<uint8>(0x16)  = static_cast<uint8>(emoteMode);
}
