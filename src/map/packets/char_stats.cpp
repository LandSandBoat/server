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

#include "common/socket.h"
#include "common/utils.h"

#include <cstring>

#include "char_stats.h"

#include "entities/charentity.h"
#include "items/item_weapon.h"
#include "modifier.h"
#include "roe.h"
#include "utils/charutils.h"

CCharStatsPacket::CCharStatsPacket(CCharEntity* PChar)
{
    this->setType(0x61);
    this->setSize(0x70);

    ref<uint32>(0x04) = PChar->GetMaxHP();
    ref<uint32>(0x08) = PChar->GetMaxMP();

    ref<uint8>(0x0C) = PChar->GetMJob();
    ref<uint8>(0x0D) = PChar->GetMLevel();
    ref<uint8>(0x0E) = PChar->GetSJob();
    ref<uint8>(0x0F) = PChar->GetSLevel();

    ref<uint16>(0x10) = PChar->jobs.exp[PChar->GetMJob()];
    ref<uint16>(0x12) = charutils::GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]);

    std::memcpy(buffer_.data() + 0x14, &PChar->stats, 14); // TODO: it won't work with merits

    // Hasso gives STR only if main weapon is two handed
    if (auto* weapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[SLOT_MAIN]); weapon && weapon->isTwoHanded())
    {
        ref<uint16>(0x22) = std::clamp<int16>(PChar->getMod(Mod::STR) + PChar->getMod(Mod::TWOHAND_STR), -999 + PChar->stats.STR, 999 - PChar->stats.STR);
    }
    else
    {
        ref<uint16>(0x22) = std::clamp<int16>(PChar->getMod(Mod::STR), -999 + PChar->stats.STR, 999 - PChar->stats.STR);
    }
    ref<uint16>(0x24) = std::clamp<int16>(PChar->getMod(Mod::DEX), -999 + PChar->stats.DEX, 999 - PChar->stats.DEX);
    ref<uint16>(0x26) = std::clamp<int16>(PChar->getMod(Mod::VIT), -999 + PChar->stats.VIT, 999 - PChar->stats.VIT);
    ref<uint16>(0x28) = std::clamp<int16>(PChar->getMod(Mod::AGI), -999 + PChar->stats.AGI, 999 - PChar->stats.AGI);
    ref<uint16>(0x2A) = std::clamp<int16>(PChar->getMod(Mod::INT), -999 + PChar->stats.INT, 999 - PChar->stats.INT);
    ref<uint16>(0x2C) = std::clamp<int16>(PChar->getMod(Mod::MND), -999 + PChar->stats.MND, 999 - PChar->stats.MND);
    ref<uint16>(0x2E) = std::clamp<int16>(PChar->getMod(Mod::CHR), -999 + PChar->stats.CHR, 999 - PChar->stats.CHR);

    ref<uint16>(0x30) = PChar->ATT(SLOT_MAIN);
    ref<uint16>(0x32) = PChar->DEF();

    ref<uint16>(0x34) = PChar->getMod(Mod::FIRE_MEVA);
    ref<uint16>(0x36) = PChar->getMod(Mod::ICE_MEVA);
    ref<uint16>(0x38) = PChar->getMod(Mod::WIND_MEVA);
    ref<uint16>(0x3A) = PChar->getMod(Mod::EARTH_MEVA);
    ref<uint16>(0x3C) = PChar->getMod(Mod::THUNDER_MEVA);
    ref<uint16>(0x3E) = PChar->getMod(Mod::WATER_MEVA);
    ref<uint16>(0x40) = PChar->getMod(Mod::LIGHT_MEVA);
    ref<uint16>(0x42) = PChar->getMod(Mod::DARK_MEVA);

    ref<uint16>(0x44) = PChar->profile.title;
    ref<uint8>(0x46)  = PChar->profile.rank[PChar->profile.nation];
    ref<uint16>(0x48) = PChar->profile.rankpoints;
    ref<uint16>(0x4A) = PChar->profile.home_point.destination;
    ref<uint8>(0x50)  = PChar->profile.nation;

    // 0x51 = 0x01 on fresh player, 0x03 with 99
    ref<uint8>(0x52) = PChar->getMod(Mod::SUPERIOR_LEVEL);
    ref<uint8>(0x54) = charutils::getMaxItemLevel(PChar);        // Maximum Item Level
    ref<uint8>(0x55) = charutils::getItemLevelDifference(PChar); // itemlevel over 99
    ref<uint8>(0x56) = charutils::getMainhandItemLevel(PChar);   // Item level of Main Hand weapon
    ref<uint8>(0x57) = charutils::getRangedItemLevel(PChar);     // Item level of Ranged (Ranged priority, ammo if only)

    uint8 unityRank = PChar->profile.unity_leader > 0 ? roeutils::RoeSystem.unityLeaderRank[PChar->profile.unity_leader - 1] : 0;

    ref<uint32>(0x58) = (charutils::GetPoints(PChar, "unity_accolades") << 10) | (unityRank << 5 | PChar->profile.unity_leader);

    // Note: 0x5C and 0x5E Appear to follow the below format
    ref<uint16>(0x5C) = charutils::GetPoints(PChar, "current_accolades") / 1000; // Partial Personal Eval
    ref<uint16>(0x5E) = charutils::GetPoints(PChar, "prev_accolades") / 1000;    // Personal Eval

    ref<uint8>(0x65)  = 0; // Master Level
    ref<uint8>(0x66)  = 0; // Bit0 - Master Breaker
    ref<uint32>(0x68) = 0; // Current Exemplar Points
    ref<uint32>(0x6C) = 0; // Required Exemplar Points
}
