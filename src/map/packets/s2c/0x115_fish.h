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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0115
// This packet is sent by the server to begin the fishing mini-game within the client. This packet holds the needed information to tell the client how to fight the hooked fish.
class GP_SERV_COMMAND_FISH final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_FISH, GP_SERV_COMMAND_FISH>
{
public:
    struct PacketData
    {
        uint16_t stamina;        // PS2: (New; did not exist.)
        uint16_t arrow_delay;    // PS2: (New; did not exist.)
        uint16_t regen;          // PS2: (New; did not exist.)
        uint16_t move_frequency; // PS2: (New; did not exist.)
        uint16_t arrow_damage;   // PS2: (New; did not exist.)
        uint16_t arrow_regen;    // PS2: (New; did not exist.)
        uint16_t time;           // PS2: (New; did not exist.)
        uint8_t  angler_sense;   // PS2: (New; did not exist.)
        uint8_t  padding13;      // PS2: (New; did not exist.)
        uint32_t intuition;      // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_FISH(
        uint16 stamina,
        uint16 regen,
        uint16 response,
        uint16 hitDmg,
        uint16 arrowDelay,
        uint16 missRegen,
        uint16 gameTime,
        uint8  sense,
        uint32 special);
};
