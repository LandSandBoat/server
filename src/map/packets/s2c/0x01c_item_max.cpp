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

#include "0x01c_item_max.h"

#include "entities/charentity.h"
#include "item_container.h"
#include "utils/charutils.h"

GP_SERV_COMMAND_ITEM_MAX::GP_SERV_COMMAND_ITEM_MAX(const CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.ItemNum[LOC_INVENTORY]  = 1 + PChar->getStorage(LOC_INVENTORY)->GetSize();
    packet.ItemNum[LOC_MOGSAFE]    = 1 + PChar->getStorage(LOC_MOGSAFE)->GetSize();
    packet.ItemNum[LOC_STORAGE]    = 1 + PChar->getStorage(LOC_STORAGE)->GetSize();
    packet.ItemNum[LOC_TEMPITEMS]  = 1 + PChar->getStorage(LOC_TEMPITEMS)->GetSize();
    packet.ItemNum[LOC_MOGLOCKER]  = 1 + PChar->getStorage(LOC_MOGLOCKER)->GetSize();
    packet.ItemNum[LOC_MOGSATCHEL] = 1 + PChar->getStorage(LOC_MOGSATCHEL)->GetSize();
    packet.ItemNum[LOC_MOGSACK]    = 1 + PChar->getStorage(LOC_MOGSACK)->GetSize();
    packet.ItemNum[LOC_MOGCASE]    = 1 + PChar->getStorage(LOC_MOGCASE)->GetSize();
    packet.ItemNum[LOC_WARDROBE]   = 1 + PChar->getStorage(LOC_WARDROBE)->GetSize();
    packet.ItemNum[LOC_MOGSAFE2]   = 1 + PChar->getStorage(LOC_MOGSAFE2)->GetSize();
    packet.ItemNum[LOC_WARDROBE2]  = 1 + PChar->getStorage(LOC_WARDROBE2)->GetSize();
    packet.ItemNum[LOC_WARDROBE3]  = 1 + PChar->getStorage(LOC_WARDROBE3)->GetSize();
    packet.ItemNum[LOC_WARDROBE4]  = 1 + PChar->getStorage(LOC_WARDROBE4)->GetSize();
    packet.ItemNum[LOC_WARDROBE5]  = 1 + PChar->getStorage(LOC_WARDROBE5)->GetSize();
    packet.ItemNum[LOC_WARDROBE6]  = 1 + PChar->getStorage(LOC_WARDROBE6)->GetSize();
    packet.ItemNum[LOC_WARDROBE7]  = 1 + PChar->getStorage(LOC_WARDROBE7)->GetSize();
    packet.ItemNum[LOC_WARDROBE8]  = 1 + PChar->getStorage(LOC_WARDROBE8)->GetSize();
    packet.ItemNum[LOC_RECYCLEBIN] = 1 + PChar->getStorage(LOC_RECYCLEBIN)->GetSize();

    // These set the usable amount of the container. 0x00 disables the container.
    packet.ItemNum2[LOC_INVENTORY]  = 1 + PChar->getStorage(LOC_INVENTORY)->GetBuff();
    packet.ItemNum2[LOC_MOGSAFE]    = 1 + PChar->getStorage(LOC_MOGSAFE)->GetBuff();
    packet.ItemNum2[LOC_STORAGE]    = 1 + PChar->getStorage(LOC_STORAGE)->GetBuff();
    packet.ItemNum2[LOC_TEMPITEMS]  = 1 + PChar->getStorage(LOC_TEMPITEMS)->GetBuff();
    packet.ItemNum2[LOC_MOGLOCKER]  = charutils::hasMogLockerAccess(PChar) ? 1 + PChar->getStorage(LOC_MOGLOCKER)->GetBuff() : 0x00;
    packet.ItemNum2[LOC_MOGSATCHEL] = 1 + PChar->getStorage(LOC_MOGSATCHEL)->GetBuff();
    packet.ItemNum2[LOC_MOGSACK]    = 1 + PChar->getStorage(LOC_MOGSACK)->GetBuff();
    packet.ItemNum2[LOC_MOGCASE]    = 1 + PChar->getStorage(LOC_MOGCASE)->GetBuff();
    packet.ItemNum2[LOC_WARDROBE]   = 1 + PChar->getStorage(LOC_WARDROBE)->GetBuff();
    packet.ItemNum2[LOC_MOGSAFE2]   = 1 + PChar->getStorage(LOC_MOGSAFE2)->GetBuff();
    packet.ItemNum2[LOC_WARDROBE2]  = 1 + PChar->getStorage(LOC_WARDROBE2)->GetBuff();
    packet.ItemNum2[LOC_WARDROBE3]  = 1 + PChar->getStorage(LOC_WARDROBE3)->GetBuff();
    packet.ItemNum2[LOC_WARDROBE4]  = 1 + PChar->getStorage(LOC_WARDROBE4)->GetBuff();
    packet.ItemNum2[LOC_WARDROBE5]  = 1 + PChar->getStorage(LOC_WARDROBE5)->GetBuff();
    packet.ItemNum2[LOC_WARDROBE6]  = 1 + PChar->getStorage(LOC_WARDROBE6)->GetBuff();
    packet.ItemNum2[LOC_WARDROBE7]  = 1 + PChar->getStorage(LOC_WARDROBE7)->GetBuff();
    packet.ItemNum2[LOC_WARDROBE8]  = 1 + PChar->getStorage(LOC_WARDROBE8)->GetBuff();
    packet.ItemNum2[LOC_RECYCLEBIN] = 1 + PChar->getStorage(LOC_RECYCLEBIN)->GetBuff();
}
