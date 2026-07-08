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

#include "common/cbasetypes.h"

#include <magic_enum/magic_enum.hpp>

// Item flags
// Bits 0-15 mirror retail DAT layout
// Bits 16+ for LSB specific behavior
enum class ItemFlag : uint32
{
    None           = 0x00000000,
    AugSendable    = 0x00000001, // Can be sent even with augments.
    GMOnly         = 0x00000002, // Can only be obtained/used by GMs?
    MysteryBox     = 0x00000004, // Can be gained from Gobbie Mystery Box
    MogGarden      = 0x00000008, // Can use in Mog Garden
    CanSendAccount = 0x00000010, // Can send to characters on same account
    Inscribable    = 0x00000020, // Can be signed during synthesis
    NoAuction      = 0x00000040, // Cannot be placed on the Auction House
    Scroll         = 0x00000080,
    Linkshell      = 0x00000100, // Linkshell type items
    CanUse         = 0x00000200, // Can use the item
    CanTradeNPC    = 0x00000400, // Can trade the item to NPCs
    CanEquip       = 0x00000800, // Can be equipped
    NoSale         = 0x00001000, // Cannot be sold to vendors
    NoDelivery     = 0x00002000, // Cannot be sent through the PBX
    Exclusive      = 0x00004000, // Cannot be traded to another PC
    Rare           = 0x00008000, // Cannot own multiple copies
    NoRecycle      = 0x00010000, // Item skips Recycle Bin
    NoRareCheck    = 0x00020000, // Item skips Rare check in Treasure Pool
};

using namespace magic_enum::bitwise_operators;
