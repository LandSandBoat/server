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

#include "common/cbasetypes.h"

#include "base.h"

enum class GP_SERV_COMMAND_INFLUENCE_MODE : uint8_t;
class CCharEntity;
struct CampaignState;

struct campaigncontrolledareas_t
{
    uint32_t Sandoria : 5;
    uint32_t Bastok : 5;
    uint32_t Windurst : 5;
    uint32_t Beastman : 5;
    uint32_t unused : 12;
};

struct campaignnation_t
{
    uint32_t Reconnaissance : 4;
    uint32_t unused : 14;
    uint32_t Morale : 7;
    uint32_t Prosperity : 7;
};

struct campaignnations_t
{
    campaignnation_t Sandoria;
    campaignnation_t Bastok;
    campaignnation_t Windurst;
    campaignnation_t BeastmanOrc;
    campaignnation_t BeastmanQuadav;
    campaignnation_t BeastmanYagudo;
    campaignnation_t BeastmanDarkKindred;
};

struct campaignzone_t
{
    uint32_t unused00 : 1;
    uint32_t Owner : 3;
    uint32_t CurrentFortifications : 10;
    uint32_t CurrentResources : 10;
    uint32_t Heroism : 8;
    uint8_t  InfluenceSandoria;
    uint8_t  InfluenceBastok;
    uint8_t  InfluenceWindurst;
    uint8_t  InfluenceBeastman;
    uint32_t MaxFortifications : 10;
    uint32_t MaxResources : 10;
    uint32_t unused01 : 12;
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0071
// This packet is sent by the server to inform the client of the campaign and colonization map information.
namespace GP_SERV_COMMAND_INFLUENCE
{
    // Mode=2 Campaign Information
    class CAMPAIGN final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_INFLUENCE, CAMPAIGN>
    {
    public:
        struct PacketData
        {
            GP_SERV_COMMAND_INFLUENCE_MODE Mode;            // PS2: (New; did not exist.)
            uint8_t                        padding05;       // PS2: (New; did not exist.)
            uint16_t                       Length;          // PS2: (New; did not exist.)
            uint8_t                        padding07;       // PS2: (New; did not exist.)
            uint8_t                        ZoneOffset;      // PS2: (New; did not exist.)
            uint8_t                        padding0A[2];    // PS2: (New; did not exist.)
            int32_t                        AlliedNotes;     // PS2: (New; did not exist.)
            campaigncontrolledareas_t      ControlledAreas; // PS2: (New; did not exist.)
            campaignnations_t              Nations;         // PS2: (New; did not exist.)
            campaignzone_t                 Zones[13];       // PS2: (New; did not exist.)
        };

        CAMPAIGN(CCharEntity* PChar, CampaignState const& state, uint8 number);
    };
} // namespace GP_SERV_COMMAND_INFLUENCE
