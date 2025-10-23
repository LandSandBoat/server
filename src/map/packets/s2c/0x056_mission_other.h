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

enum class QuestOffer : uint16_t;
enum class QuestComplete : uint16_t;
enum class MissionComplete : uint16_t;
class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0056
// This packet is sent by the server to populate the clients mission and quest information.
namespace GP_SERV_COMMAND_MISSION
{
    // Other Port: ToAU, WoTG missions (in-progress + completed).
    // All quests in progress/completed including Abyssea, Campaign and Coalition.
    class OTHER final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MISSION, OTHER>
    {
    public:
        struct PacketData
        {
            uint32_t Data[8];   // PS2: data
            uint16_t Port;      // PS2: Port
            uint16_t padding26; // PS2: (New; did not exist.)
        };

        OTHER(const CCharEntity* PChar, MissionComplete log);
        OTHER(const CCharEntity* PChar, QuestOffer log);
        OTHER(const CCharEntity* PChar, QuestComplete log);
    };
} // namespace GP_SERV_COMMAND_MISSION
