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

#pragma once

#include "base.h"

enum class GP_CLI_COMMAND_SET_USERMSG_MSGTYPE : uint32_t
{
    Default                 = 0x00,
    EXPPartySeekParty       = 0x11,
    EXPPartyFindMember      = 0x12,
    EXPPartyOther           = 0x13,
    BattleContentSeekParty  = 0x21,
    BattleContentFindMember = 0x22,
    BattleContentOther      = 0x23,
    MissionsQuestSeekParty  = 0x31,
    MissionsQuestFindMember = 0x32,
    MissionsQuestOther      = 0x33,
    ItemWantToSell          = 0x41,
    ItemWantToBuy           = 0x42,
    ItemOther               = 0x43,
    LinkshellLookingForLS   = 0x51,
    LinkshellRecruiting     = 0x52,
    LinkshellOther          = 0x53,
    LookingForFriends       = 0x61,
    Others                  = 0x73,
};

struct expansions_t
{
    uint32_t has_final_fantasy_xi : 1;        // Final Fantasy XI (Base Game)
    uint32_t has_rise_of_the_zilart : 1;      // Rise of the Zilart
    uint32_t has_chains_of_promathia : 1;     // Chains of Promathia
    uint32_t has_treasures_of_aht_urhgan : 1; // Treasures of Aht Urhgan
    uint32_t has_wings_of_the_goddess : 1;    // Wings of the Goddess
    uint32_t has_a_crystalline_prophecy : 1;  // A Crystalline Prophecy (Requires Rise of the Zilart to be enabled!)
    uint32_t has_a_moogle_kupo_detat : 1;     // A Moogle Kupo d'Etat (Requires Rise of the Zilart to be enabled!)
    uint32_t has_a_shantotto_ascension : 1;   // A Shantotto Ascension (Requires Rise of the Zilart to be enabled!)
    uint32_t has_vision_of_abyssea : 1;       // Vision of Abyssea
    uint32_t has_scars_of_abyssea : 1;        // Scars of Abyssea
    uint32_t has_heroes_of_abyssea : 1;       // Heroes of Abyssea
    uint32_t has_seekers_of_adoulin : 1;      // Seekers of Adoulin
    uint32_t has_bit12 : 1;                   // (unused)
    uint32_t has_bit13 : 1;                   // (unused)
    uint32_t has_bit14 : 1;                   // (unused)
    uint32_t has_bit15 : 1;                   // (unused)
    uint32_t has_bit16 : 1;                   // (unused)
    uint32_t has_bit17 : 1;                   // (unused)
    uint32_t has_bit18 : 1;                   // (unused)
    uint32_t has_bit19 : 1;                   // (unused)
    uint32_t has_bit20 : 1;                   // (unused)
    uint32_t has_bit21 : 1;                   // (unused)
    uint32_t has_bit22 : 1;                   // (unused)
    uint32_t has_bit23 : 1;                   // (unused)
    uint32_t has_bit24 : 1;                   // (unused)
    uint32_t has_bit25 : 1;                   // (unused)
    uint32_t has_bit26 : 1;                   // (unused)
    uint32_t has_bit27 : 1;                   // (unused)
    uint32_t has_bit28 : 1;                   // (unused)
    uint32_t has_bit29 : 1;                   // (unused)
    uint32_t has_bit30 : 1;                   // (unused)
    uint32_t has_bit31 : 1;                   // (unused)
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00E0
// This packet is sent by the client when changing their search message.
GP_CLI_PACKET(GP_CLI_COMMAND_SET_USERMSG,
              uint8_t      sMessage[128]; // PS2: sMessage
              uint32_t     installTime;   // PS2: installTime
              uint8_t      platform[4];   // PS2: platform
              expansions_t srvExCode;     // PS2: srvExCode
              expansions_t cliExCode;     // PS2: cliExCode
              uint32_t     msgType;       // PS2: msgType
);
