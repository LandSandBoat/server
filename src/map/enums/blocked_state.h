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

#include "magic_enum/magic_enum.hpp"

enum class BlockedState : uint16_t
{
    Jailed         = 0x00000001, // PC must not be jailed
    Dead           = 0x00000002, // PC must not be dead
    Crafting       = 0x00000004, // PC must not be crafting
    Healing        = 0x00000008, // PC must not be healing (incl. logging out)
    Fishing        = 0x00000010, // PC must not be fishing
    Sitting        = 0x00000020, // PC must not be using /sit or /sitchair
    Mounted        = 0x00000040, // PC must not be mounted
    Charmed        = 0x00000080, // PC must not be charmed
    PreventAction  = 0x00000100, // PC must not be prevented from acting (Charm, Sleep, Stun, Terror, Petrified)
    InEvent        = 0x00000200, // PC must not be in a cutscene/event
    Engaged        = 0x00000400, // PC must not be engaged
    AbnormalStatus = 0x00000800, // Any status != NORMAL
    Monstrosity    = 0x00001000, // PC cannot be assuming a Monstrosity form
};

template <>
struct magic_enum::customize::enum_range<BlockedState>
{
    static constexpr bool is_flags = true;
};

#include "magic_enum/magic_enum_containers.hpp"

using namespace magic_enum::bitwise_operators;
