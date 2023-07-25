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

#include "entities/charentity.h"
#include "inventory_size.h"
#include "item_container.h"
#include "utils/charutils.h"

/************************************************************************
 *
 * No value in 0x1C controls access to MOGLOCKER.
 * In the plot it is blocked before performing the appropriate task
 *
 *************************************************************************/

CInventorySizePacket::CInventorySizePacket(CCharEntity* PChar)
{
    this->setType(0x1C);
    this->setSize(0x64);

    ref<uint8>(0x04) = 1 + PChar->getStorage(LOC_INVENTORY)->GetSize();
    ref<uint8>(0x05) = 1 + PChar->getStorage(LOC_MOGSAFE)->GetSize();
    ref<uint8>(0x06) = 1 + PChar->getStorage(LOC_STORAGE)->GetSize();
    ref<uint8>(0x07) = 1 + PChar->getStorage(LOC_TEMPITEMS)->GetSize();
    ref<uint8>(0x08) = 1 + PChar->getStorage(LOC_MOGLOCKER)->GetSize();
    ref<uint8>(0x09) = 1 + PChar->getStorage(LOC_MOGSATCHEL)->GetSize();
    ref<uint8>(0x0A) = 1 + PChar->getStorage(LOC_MOGSACK)->GetSize();
    ref<uint8>(0x0B) = 1 + PChar->getStorage(LOC_MOGCASE)->GetSize();
    ref<uint8>(0x0C) = 1 + PChar->getStorage(LOC_WARDROBE)->GetSize();
    ref<uint8>(0x0D) = 1 + PChar->getStorage(LOC_MOGSAFE2)->GetSize();
    ref<uint8>(0x0E) = 1 + PChar->getStorage(LOC_WARDROBE2)->GetSize();
    ref<uint8>(0x0F) = 1 + PChar->getStorage(LOC_WARDROBE3)->GetSize();
    ref<uint8>(0x10) = 1 + PChar->getStorage(LOC_WARDROBE4)->GetSize();
    ref<uint8>(0x11) = 1 + PChar->getStorage(LOC_WARDROBE5)->GetSize();
    ref<uint8>(0x12) = 1 + PChar->getStorage(LOC_WARDROBE6)->GetSize();
    ref<uint8>(0x13) = 1 + PChar->getStorage(LOC_WARDROBE7)->GetSize();
    ref<uint8>(0x14) = 1 + PChar->getStorage(LOC_WARDROBE8)->GetSize();
    ref<uint8>(0x15) = 1 + PChar->getStorage(LOC_RECYCLEBIN)->GetSize();

    // These set the usable amount of the container. 0x00 disables the container.
    ref<uint8>(0x24) = 1 + PChar->getStorage(LOC_INVENTORY)->GetBuff();
    ref<uint8>(0x26) = 1 + PChar->getStorage(LOC_MOGSAFE)->GetBuff();
    ref<uint8>(0x28) = 1 + PChar->getStorage(LOC_STORAGE)->GetBuff();
    ref<uint8>(0x2A) = 1 + PChar->getStorage(LOC_TEMPITEMS)->GetBuff();
    ref<uint8>(0x2C) = charutils::hasMogLockerAccess(PChar) ? 1 + PChar->getStorage(LOC_MOGLOCKER)->GetBuff() : 0x00;
    ref<uint8>(0x2E) = 1 + PChar->getStorage(LOC_MOGSATCHEL)->GetBuff();
    ref<uint8>(0x30) = 1 + PChar->getStorage(LOC_MOGSACK)->GetBuff();
    ref<uint8>(0x32) = 1 + PChar->getStorage(LOC_MOGCASE)->GetBuff();
    ref<uint8>(0x34) = 1 + PChar->getStorage(LOC_WARDROBE)->GetBuff();
    ref<uint8>(0x36) = 1 + PChar->getStorage(LOC_MOGSAFE2)->GetBuff();
    ref<uint8>(0x38) = 1 + PChar->getStorage(LOC_WARDROBE2)->GetBuff();
    ref<uint8>(0x3A) = 1 + PChar->getStorage(LOC_WARDROBE3)->GetBuff();
    ref<uint8>(0x3C) = 1 + PChar->getStorage(LOC_WARDROBE4)->GetBuff();
    ref<uint8>(0x3E) = 1 + PChar->getStorage(LOC_WARDROBE5)->GetBuff();
    ref<uint8>(0x40) = 1 + PChar->getStorage(LOC_WARDROBE6)->GetBuff();
    ref<uint8>(0x42) = 1 + PChar->getStorage(LOC_WARDROBE7)->GetBuff();
    ref<uint8>(0x44) = 1 + PChar->getStorage(LOC_WARDROBE8)->GetBuff();
    ref<uint8>(0x46) = 1 + PChar->getStorage(LOC_RECYCLEBIN)->GetBuff();
}
