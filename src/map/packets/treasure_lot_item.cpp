/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "common/socket.h"
#include "common/utils.h"

#include <cstring>

#include "treasure_lot_item.h"

#include "entities/baseentity.h"

CTreasureLotItemPacket::CTreasureLotItemPacket(uint8 slotID, ITEMLOTTYPE MessageType)
{
    this->setType(0xD3);
    this->setSize(0x3C);

    ref<uint8>(0x14) = slotID;
    ref<uint8>(0x15) = MessageType;
}

CTreasureLotItemPacket::CTreasureLotItemPacket(CBaseEntity* PWinner, uint8 slotID, uint16 Lot, ITEMLOTTYPE MessageType)
{
    this->setType(0xD3);
    this->setSize(0x3C);

    ref<uint32>(0x04) = PWinner->id;
    ref<uint16>(0x0C) = PWinner->targid;
    ref<uint16>(0x0E) = Lot;

    ref<uint8>(0x14) = slotID;
    ref<uint8>(0x15) = MessageType;

    std::memcpy(buffer_.data() + 0x16, PWinner->getName().c_str(), PWinner->getName().size());
}

CTreasureLotItemPacket::CTreasureLotItemPacket(CBaseEntity* PHighestLotter, uint16 HighestLot, CBaseEntity* PLotter, uint8 SlotID, uint16 Lot)
{
    this->setType(0xD3);
    this->setSize(0x3C);

    if (PHighestLotter)
    {
        ref<uint32>(0x04) = PHighestLotter->id;
        ref<uint16>(0x0C) = PHighestLotter->targid;
        ref<uint16>(0x0E) = HighestLot;
        std::memcpy(buffer_.data() + 0x16, PHighestLotter->getName().c_str(), PHighestLotter->getName().size());
    }

    ref<uint32>(0x08) = PLotter->id;
    ref<uint16>(0x10) = PLotter->targid;
    packBitsBE(buffer_.data(), Lot, 144, 16); // this fixes an offset problem with lot numbers
    // ref<uint8>(data,(0x12)) = Lot;
    ref<uint8>(0x14) = SlotID;

    std::memcpy(buffer_.data() + 0x26, PLotter->getName().c_str(), PLotter->getName().size());
}
