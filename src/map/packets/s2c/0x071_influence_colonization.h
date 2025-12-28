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

enum class GP_SERV_COMMAND_INFLUENCE_MODE : uint8_t;
class CCharEntity;
struct coalitionranks_t
{
    uint32_t Pioneers : 4;
    uint32_t Peacekeepers : 4;
    uint32_t Couriers : 4;
    uint32_t Scouts : 4;
    uint32_t Inventors : 4;
    uint32_t Mummers : 4;
    uint32_t unused : 8;
};

struct colonizationzone_t
{
    uint32_t ColonizationRate : 7;
    uint32_t CurrentBivouacs : 3;
    uint32_t MaxBivouacs : 3;
    uint32_t unused : 19;
};

struct colonizationzones_t
{
    colonizationzone_t unused;
    colonizationzone_t YahseHuntingGrounds;
    colonizationzone_t CeizakBattlegrounds;
    colonizationzone_t ForetDeHennetiel;
    colonizationzone_t YorciaWeald;
    colonizationzone_t MorimarBasaltFields;
    colonizationzone_t MarjamiRavine;
    colonizationzone_t KamihrDrifts;
    colonizationzone_t RaKaznar;
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0071
// This packet is sent by the server to inform the client of the campaign and colonization map information.
namespace GP_SERV_COMMAND_INFLUENCE
{

// Mode=3 Colonization Information
class COLONIZATION final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_INFLUENCE, COLONIZATION>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_INFLUENCE_MODE Mode;      // PS2: (New; did not exist.)
        uint8_t                        padding05; // PS2: (New; did not exist.)
        uint16_t                       Length;    // PS2: (New; did not exist.)
        uint32_t                       unknown00; // PS2: (New; did not exist.)
        uint32_t                       unknown01; // PS2: (New; did not exist.)
        coalitionranks_t               Ranks;     // PS2: (New; did not exist.)
        colonizationzones_t            Zones;     // PS2: (New; did not exist.)
        int32_t                        Bayld;     // PS2: (New; did not exist.)
        uint8_t                        padding00[144];
    };

    COLONIZATION(CCharEntity* PChar);
};

} // namespace GP_SERV_COMMAND_INFLUENCE
