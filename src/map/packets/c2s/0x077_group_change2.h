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

enum class GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND : uint8_t
{
    SetPartyLeader    = 0,
    SetAllianceLeader = 1,
    PearlToSack       = 2,
    SackToPearl       = 3,
    SetQuartermaster  = 4,
    SetLottery        = 5,
    SetLevelSync      = 6,
    DisableLevelSync  = 7,
};

enum class GP_CLI_COMMAND_GROUP_CHANGE2_KIND : uint8_t
{
    Party      = 0,
    Linkshell1 = 1,
    Linkshell2 = 2,
    Alliance   = 5,
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0077
// This packet is sent by the client when changing group system settings. (ie. Party, Alliance, Linkshell)
GP_CLI_PACKET(GP_CLI_COMMAND_GROUP_CHANGE2,
              uint8_t sName[16];  // PS2: sName
              uint8_t Kind;       // PS2: Kind
              uint8_t ChangeKind; // PS2: ChangeKind
);
