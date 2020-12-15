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

#include "../entities/charentity.h"
#include "../item_container.h"
#include "../utils/charutils.h"
#include "inventory_size.h"

/************************************************************************
 *																		*
 *  Отсутствие значения в 0x1C управляет доступом к MOGLOCKER.			*
 *  По сюжету он заблокирован до выполнения соответствующей задачи		*
 *																		*
 ************************************************************************/

CInventorySizePacket::CInventorySizePacket(CCharEntity* PChar)
{
    this->type = 0x1C;
    this->size = 0x1A;

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

    ref<uint16>(0x14) = 1 + PChar->getStorage(LOC_INVENTORY)->GetBuff();
    ref<uint16>(0x16) = 1 + PChar->getStorage(LOC_MOGSAFE)->GetBuff();
    ref<uint16>(0x18) = 1 + PChar->getStorage(LOC_STORAGE)->GetBuff();
    ref<uint16>(0x1A) = 1 + PChar->getStorage(LOC_TEMPITEMS)->GetBuff();
    if (charutils::hasMogLockerAccess(PChar))
    {
        ref<uint16>(0x1C) = 1 + PChar->getStorage(LOC_MOGLOCKER)->GetBuff();
    }
    else
    {
        ref<uint16>(0x1C) = 0x00;
    }

    ref<uint16>(0x1E) = 1 + PChar->getStorage(LOC_MOGSATCHEL)->GetBuff();
    ref<uint16>(0x20) = 1 + PChar->getStorage(LOC_MOGSACK)->GetBuff();
    ref<uint16>(0x22) = 1 + PChar->getStorage(LOC_MOGCASE)->GetBuff();
    ref<uint16>(0x24) = 1 + PChar->getStorage(LOC_WARDROBE)->GetBuff();
    ref<uint16>(0x26) = 1 + PChar->getStorage(LOC_MOGSAFE2)->GetBuff();
    ref<uint16>(0x28) = 1 + PChar->getStorage(LOC_WARDROBE2)->GetBuff();
    ref<uint16>(0x2A) = 1 + PChar->getStorage(LOC_WARDROBE3)->GetBuff();
    ref<uint16>(0x2C) = 1 + PChar->getStorage(LOC_WARDROBE4)->GetBuff();
}
