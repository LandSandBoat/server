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

struct lockstyleitem_t
{
    uint8_t  ItemIndex;
    uint8_t  EquipKind;
    uint8_t  Category;
    uint8_t  padding00;
    uint16_t ItemNo;
    uint16_t padding01;
};

enum class GP_CLI_COMMAND_LOCKSTYLE_MODE : uint8_t
{
    Disable  = 0, // Disables the lockstyle feature.
    Continue = 1, // Continues the lockstyle feature.
    Query    = 2, // Queries the players current lockstyle feature setting from the server.
    Set      = 3, // Sets the players lockstyle.
    Enable   = 4  // Enables the lockstyle feature.
};

GP_CLI_PACKET(GP_CLI_COMMAND_LOCKSTYLE,
              uint8_t         Count;     // The count of items the lockstyle has enabled in the Items array.
              uint8_t         Mode;      // The lockstyle mode.
              uint8_t         Flags;     // The packet flags.
              uint8_t         padding00; // Padding; unused.
              lockstyleitem_t Items[16]; // The items that will be applied for the lock style.
);
