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

#include "../../common/socket.h"

#include "macroequipset.h"

CAddtoEquipSet::CAddtoEquipSet(uint8* orig)
{
    // Im guessing this is here to check if you can use A Item, as it seems useless to have this sent to server
    // as It will check requirements when it goes to equip the items anyway
    // 0x04 is slot of updated item
    // 0x08 is info for updated item
    // 0x0C is first slot every 4 bytes is another set, in (01-equip 0-2 remve),(container),(ID),(ID)
    // in this list the slot of whats being updated is old value, replace with new in 116
    // Should Push 0x116 (size 68) in responce
    // 0x04 is start, contains 16 4 byte parts repersently each slot in order
    this->type   = 0x16;
    this->size   = 0x23;
    uint8 slotID = ::ref<uint8>(orig, 0x04);
    for (int i = 0; i < 0x10; i++)
    {
        if (i == slotID)
        {
            ref<uint8>(0x04 + 0x04 * i) = ::ref<uint8>(orig, 0x08);
            ref<uint8>(0x05 + 0x04 * i) = ::ref<uint8>(orig, 0x09);
            ref<uint8>(0x06 + 0x04 * i) = ::ref<uint8>(orig, 0x0A);
            ref<uint8>(0x07 + 0x04 * i) = ::ref<uint8>(orig, 0x0B);
        }
        else
        {
            ref<uint8>(0x04 + 0x04 * i) = ::ref<uint8>(orig, 0x0C + (0x04 * i));
            ref<uint8>(0x05 + 0x04 * i) = ::ref<uint8>(orig, 0x0D + (0x04 * i));
            ref<uint8>(0x06 + 0x04 * i) = ::ref<uint8>(orig, 0x0E + (0x04 * i));
            ref<uint8>(0x07 + 0x04 * i) = ::ref<uint8>(orig, 0x0F + (0x04 * i));
        }
    }
}
