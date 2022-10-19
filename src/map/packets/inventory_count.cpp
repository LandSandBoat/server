/*
===========================================================================

  Copyright (c) 2021 LandSandBoat Dev Team

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

#include "inventory_count.h"

CInventoryCountPacket::CInventoryCountPacket(uint8 locationId, uint8 slotId)
{
    this->setType(0x26); // this->type = 0x026; // TODO
    this->setSize(0x38);

    ref<uint8>(0x04) = locationId;
    ref<uint8>(0x05) = slotId;
}

// For Mannequin updates
CInventoryCountPacket::CInventoryCountPacket(uint8 locationId, uint8 slotId, uint16 headId, uint16 bodyId, uint16 handsId, uint16 legId, uint16 feetId, uint16 mainId, uint16 subId, uint16 rangeId)
{
    this->setType(0x26);
    this->setSize(0x38);

    ref<uint8>(0x04) = 0x01;
    ref<uint8>(0x05) = locationId;
    ref<uint8>(0x06) = slotId;

    ref<uint8>(0x08) = 0xFC;
    ref<uint8>(0x09) = 0xFC;
    ref<uint8>(0x0A) = 0x1F;

    ref<uint8>(0x0B) = 0x01; // Update mask?

    // clang-format off
    ref<uint16>(0x0C) = headId  + 0x1000;
    ref<uint16>(0x0E) = bodyId  + 0x2000;
    ref<uint16>(0x10) = handsId + 0x3000;
    ref<uint16>(0x12) = legId   + 0x4000;
    ref<uint16>(0x14) = feetId  + 0x5000;
    ref<uint16>(0x16) = mainId  + 0x6000;
    ref<uint16>(0x18) = subId   + 0x7000;
    ref<uint16>(0x1A) = rangeId + 0x8000;
    // clang-format on
}
