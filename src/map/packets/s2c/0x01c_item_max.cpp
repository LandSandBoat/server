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

#include "entities/char_entity.h"
#include "item_container.h"
#include "utils/charutils.h"

GP_SERV_COMMAND_ITEM_MAX::GP_SERV_COMMAND_ITEM_MAX(const CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.ItemNum[static_cast<uint8>(xi::Container::Inventory)]  = 1 + PChar->getStorage(xi::Container::Inventory)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::MogSafe)]    = 1 + PChar->getStorage(xi::Container::MogSafe)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::Storage)]    = 1 + PChar->getStorage(xi::Container::Storage)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::TempItems)]  = 1 + PChar->getStorage(xi::Container::TempItems)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::MogLocker)]  = 1 + PChar->getStorage(xi::Container::MogLocker)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::MogSatchel)] = 1 + PChar->getStorage(xi::Container::MogSatchel)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::MogSack)]    = 1 + PChar->getStorage(xi::Container::MogSack)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::MogCase)]    = 1 + PChar->getStorage(xi::Container::MogCase)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::Wardrobe)]   = 1 + PChar->getStorage(xi::Container::Wardrobe)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::MogSafe2)]   = 1 + PChar->getStorage(xi::Container::MogSafe2)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::Wardrobe2)]  = 1 + PChar->getStorage(xi::Container::Wardrobe2)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::Wardrobe3)]  = 1 + PChar->getStorage(xi::Container::Wardrobe3)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::Wardrobe4)]  = 1 + PChar->getStorage(xi::Container::Wardrobe4)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::Wardrobe5)]  = 1 + PChar->getStorage(xi::Container::Wardrobe5)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::Wardrobe6)]  = 1 + PChar->getStorage(xi::Container::Wardrobe6)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::Wardrobe7)]  = 1 + PChar->getStorage(xi::Container::Wardrobe7)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::Wardrobe8)]  = 1 + PChar->getStorage(xi::Container::Wardrobe8)->GetSize();
    packet.ItemNum[static_cast<uint8>(xi::Container::RecycleBin)] = 1 + PChar->getStorage(xi::Container::RecycleBin)->GetSize();

    // These set the usable amount of the container. 0x00 disables the container.
    packet.ItemNum2[static_cast<uint8>(xi::Container::Inventory)]  = 1 + PChar->getStorage(xi::Container::Inventory)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::MogSafe)]    = 1 + PChar->getStorage(xi::Container::MogSafe)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::Storage)]    = 1 + PChar->getStorage(xi::Container::Storage)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::TempItems)]  = 1 + PChar->getStorage(xi::Container::TempItems)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::MogLocker)]  = charutils::hasMogLockerAccess(PChar) ? 1 + PChar->getStorage(xi::Container::MogLocker)->GetBuff() : 0x00;
    packet.ItemNum2[static_cast<uint8>(xi::Container::MogSatchel)] = 1 + PChar->getStorage(xi::Container::MogSatchel)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::MogSack)]    = 1 + PChar->getStorage(xi::Container::MogSack)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::MogCase)]    = 1 + PChar->getStorage(xi::Container::MogCase)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::Wardrobe)]   = 1 + PChar->getStorage(xi::Container::Wardrobe)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::MogSafe2)]   = 1 + PChar->getStorage(xi::Container::MogSafe2)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::Wardrobe2)]  = 1 + PChar->getStorage(xi::Container::Wardrobe2)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::Wardrobe3)]  = 1 + PChar->getStorage(xi::Container::Wardrobe3)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::Wardrobe4)]  = 1 + PChar->getStorage(xi::Container::Wardrobe4)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::Wardrobe5)]  = 1 + PChar->getStorage(xi::Container::Wardrobe5)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::Wardrobe6)]  = 1 + PChar->getStorage(xi::Container::Wardrobe6)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::Wardrobe7)]  = 1 + PChar->getStorage(xi::Container::Wardrobe7)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::Wardrobe8)]  = 1 + PChar->getStorage(xi::Container::Wardrobe8)->GetBuff();
    packet.ItemNum2[static_cast<uint8>(xi::Container::RecycleBin)] = 1 + PChar->getStorage(xi::Container::RecycleBin)->GetBuff();
}
