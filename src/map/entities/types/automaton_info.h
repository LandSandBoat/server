/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include <common/cbasetypes.h>
#include <common/mmo.h>

#include <map/entities/types/automaton_equip.h>
#include <map/entities/types/health.h>

#include <array>
#include <string>

struct AutomatonInfo
{
    skills_t automatonSkills{};
    stats_t  automatonStats{};
    Health   automatonHealth{};
    look_t   automatonLook{};

    AutomatonEquip       equip{};
    std::array<uint8, 8> elementMax{};
    std::array<uint8, 8> elementEquip{};
    uint8                elementalCapacityBonus{};

    // Default name
    std::string automatonName{ "Automaton" };
};
