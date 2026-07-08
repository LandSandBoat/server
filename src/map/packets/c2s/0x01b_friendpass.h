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

enum class GP_CLI_COMMAND_FRIENDPASS_PARA : uint16_t
{
    BeginPurchase       = 0, // Client has requested to begin the purchase of a world pass.
    ConfirmPurchase     = 1, // Client has confirmed the purchase of a world pass.
    BeginGoldPurchase   = 2, // Client has requested to begin the purchase of a gold world pass.
    ConfirmGoldPurchase = 3, // Client has confirmed the purchase of a gold world pass.
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x001B
// This packet is sent by the client when it is interacting with, and ultimately purchasing from, a world pass vendor NPC.
GP_CLI_PACKET(GP_CLI_COMMAND_FRIENDPASS,
              uint16_t Para;      // PS2: Para
              uint16_t padding00; // PS2: Dammy
);
