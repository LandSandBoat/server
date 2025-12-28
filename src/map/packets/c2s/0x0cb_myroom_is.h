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
#include <magic_enum/magic_enum.hpp>

enum class GP_CLI_COMMAND_MYROOM_IS_PARAM2 : uint16_t
{
    Unk1             = 0,   // When opening the mog house
    Unk2             = 1,   // When closing the mog house
    SandorianStyle   = 615, // Remodel
    BastokanStyle    = 616,
    WindurstianStyle = 617,
    MogPatio         = 618,
};

template <>
struct magic_enum::customize::enum_range<GP_CLI_COMMAND_MYROOM_IS_PARAM2>
{
    static constexpr int min = 0;
    static constexpr int max = 618;
};

enum class GP_CLI_COMMAND_MYROOM_IS_KIND : uint8_t
{
    Open    = 1,
    Close   = 2,
    Remodel = 5,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x00CB
// This packet is sent by the client when interacting with different mog house functionality.
GP_CLI_PACKET(GP_CLI_COMMAND_MYROOM_IS,
              uint8_t  Kind;   // The packet kind.
              uint8_t  Param1; // The packet parameter. (1)
              uint16_t Param2; // The packet parameter. (2)
);
