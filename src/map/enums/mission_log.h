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

enum class MissionLog : uint8_t
{
    Sandoria = 0,
    Bastok   = 1,
    Windurst = 2,
    Zilart   = 3,
    ToAU     = 4,
    WoTG     = 5,
    CoP      = 6,
    Assault  = 7,
    Campaign = 8,
    ACP      = 9,
    AMK      = 10,
    ASA      = 11,
    SoA      = 12,
    RoV      = 13,
    // TODO: TVR
};

// Client-side MISSION packet 'Port' values for completed missions.
// Not all storylines use this system. See GP_SERV_COMMAND_MISSION::MISSION for details.
enum class MissionComplete : uint16_t
{
    Campaign1 = 0x0030,
    Campaign2 = 0x0038,
    Nations   = 0x00D0,
    ToAU_WoTG = 0x00D8,
};
