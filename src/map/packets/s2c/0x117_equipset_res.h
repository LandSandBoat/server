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

struct equipsetitem_t
{
    uint8_t ItemIndex; // PS2: (New; did not exist.)
    uint8_t EquipKind; // PS2: (New; did not exist.)
    uint8_t Category;  // PS2: (New; did not exist.)
    uint8_t padding03; // PS2: (New; did not exist.)
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0117
// This packet is sent by the server after the client has equipped an equipset. (ie. /equipset 1)
// It is used to validate if any pieces of gear within the set failed to equip.
class GP_SERV_COMMAND_EQUIPSET_RES final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_EQUIPSET_RES, GP_SERV_COMMAND_EQUIPSET_RES>
{
public:
    struct PacketData
    {
        uint8_t        Count;             // PS2: (New; did not exist.)
        uint8_t        padding05[3];      // PS2: (New; did not exist.)
        equipsetitem_t ItemsChanged[16];  // PS2: (New; did not exist.)
        equipsetitem_t ItemsEquipped[16]; // PS2: (New; did not exist.)
    };

    // TODO: Unimplemented
    GP_SERV_COMMAND_EQUIPSET_RES() = default;
};
