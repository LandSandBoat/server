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

class CCharEntity;
struct expansion_addon_t
{
    uint16_t ACP : 4;     // PS2: data
    uint16_t AMK : 4;     // PS2: data
    uint16_t ASA : 4;     // PS2: data
    uint16_t padding : 4; // PS2: data
};

struct tales_beginning_t
{
    uint16_t RoTZ : 1;     // bit 0  (0x0001) - Rise of the Zilart
    uint16_t ACP : 1;      // bit 1  (0x0002) - A Crystalline Prophecy
    uint16_t ASA : 1;      // bit 2  (0x0004) - A Shantotto Ascension
    uint16_t CoP : 1;      // bit 3  (0x0008) - Chains of Promathia
    uint16_t padding : 1;  // bit 4  (0x0010) - unused (AMK doesn't use this system)
    uint16_t SoA : 1;      // bit 5  (0x0020) - Seekers of Adoulin
    uint16_t RoV : 1;      // bit 6  (0x0040) - Rhapsodies of Vana'diel
    uint16_t padding2 : 9; // bits 7-15 (unused)
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0056
// This packet is sent by the server to populate the clients mission and quest information.
namespace GP_SERV_COMMAND_MISSION
{

// Port 0xFFFF: Main Mission Information
// This contains either missions in progress for certain expansions, or a combination of current missions and completed missions.
// In-progress only: RoTZ, Nation
// Both: ACP, AMK, ASA, CoP, SoA, RoV
// Tales Beginning indicates which expansions the player has declined starting.
// Note: ToAU and WoTG are NOT included in this packet.
class MISSION final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISSION, MISSION>
{
public:
    struct PacketData
    {
        uint32_t          Nation;           // PS2: data
        uint32_t          NationMission;    // PS2: data
        uint32_t          Expansion_RotZ;   // PS2: data
        uint32_t          Expansion_CoP;    // PS2: data
        uint32_t          Expansion_CoP2;   // PS2: data
        expansion_addon_t Expansion_Addons; // PS2: data - This is represented as a single uint32 on XiPackets
        tales_beginning_t TalesBeginning;   // PS2: data - This is represented as a single uint32 on XiPackets
        uint32_t          Expansion_SoA;    // PS2: data
        uint32_t          Expansion_RoV;    // PS2: data
        uint16_t          Port;             // PS2: Port
        uint16_t          padding26;        // PS2: (New; did not exist.)
    };

    MISSION(const CCharEntity* PChar);
};

} // namespace GP_SERV_COMMAND_MISSION
