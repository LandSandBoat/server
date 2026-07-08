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

#include "0x115_fish.h"

GP_SERV_COMMAND_FISH::GP_SERV_COMMAND_FISH(
    const uint16 stamina,
    const uint16 regen,
    const uint16 response,
    const uint16 hitDmg,
    const uint16 arrowDelay,
    const uint16 missRegen,
    const uint16 gameTime,
    const uint8  sense,
    const uint32 special)
{
    auto& packet = this->data();

    packet.stamina        = stamina;
    packet.arrow_delay    = arrowDelay;
    packet.regen          = regen;
    packet.move_frequency = response;
    packet.arrow_damage   = hitDmg;
    packet.arrow_regen    = missRegen;
    packet.time           = gameTime;
    packet.angler_sense   = sense;
    packet.intuition      = special;
}
