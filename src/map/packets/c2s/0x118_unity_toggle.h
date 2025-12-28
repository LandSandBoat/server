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

enum class GP_CLI_COMMAND_UNITY_TOGGLE_MODE : uint8_t
{
    Inactive = 0x00,
    Active   = 0x01,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0118
// This packet is sent by the client when changing their Unity chat setting. (Active or Inactive)
GP_CLI_PACKET(GP_CLI_COMMAND_UNITY_TOGGLE,
              uint8_t Mode;
              uint8_t padding00[3]; // unused
);
