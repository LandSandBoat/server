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

#include "inventory_item.h"

#include "common/socket.h"
#include "common/utils.h"
#include "common/vana_time.h"

#include <cstring>

#include "utils/itemutils.h"

CInventoryItemPacket::CInventoryItemPacket(CItem* PItem, uint8 LocationID, uint8 SlotID)
{
    this->setType(0x20);
    this->setSize(0x2C);

    ref<uint8>(0x0E) = LocationID;
    ref<uint8>(0x0F) = SlotID;

    if (PItem != nullptr)
    {
        ref<uint32>(0x04) = PItem->getQuantity();
        ref<uint32>(0x08) = PItem->getCharPrice();
        ref<uint16>(0x0C) = PItem->getID();
        std::memcpy(buffer_.data() + 0x11, PItem->m_extra, sizeof(PItem->m_extra));

        if (PItem->isSubType(ITEM_CHARGED))
        {
            ref<uint8>(0x11) = 0x01;

            uint8 flags = 0x80; // Tests showed high bit always set.
            if (((CItemUsable*)PItem)->getCurrentCharges() < ((CItemUsable*)PItem)->getMaxCharges())
            {
                flags |= 0x10; // Partial charges mask
            }

            if (((CItemUsable*)PItem)->getCurrentCharges() > 0)
            {
                if (((CItemUsable*)PItem)->getReuseTime() == 0)
                {
                    flags |= 0x40; // Ready to use
                }
                else
                {
                    uint32 CurrentTime = CVanaTime::getInstance()->getVanaTime();
                    ref<uint32>(0x15)  = ((CItemUsable*)PItem)->getNextUseTime();

                    // Not sent if the item is unequipped.

                    ref<uint32>(0x19) = ((CItemUsable*)PItem)->getUseDelay() + CurrentTime;
                }
            }
            else
            {
                flags |= 0x20; // Empty charges
            }
            ref<uint8>(0x14) = flags;
        }

        if (PItem->isType(ITEM_WEAPON) && ((CItemWeapon*)PItem)->isUnlockable())
        {
            ref<uint16>(0x11) = 0;
        }

        if (PItem->getCharPrice() != 0)
        {
            ref<uint8>(0x10) = 0x19;
        }
        else if (PItem->isSubType(ITEM_LOCKED))
        {
            if (PItem->isType(ITEM_LINKSHELL))
            {
                ref<uint8>(0x10) = 0x13;
            }
            else
            {
                ref<uint8>(0x10) = 0x05;
            }
        }
        else
        {
            ref<uint8>(0x10) = 0x00;
        }

        if (PItem->isType(ITEM_LINKSHELL))
        {
            ref<uint8>(0x19) = ((CItemLinkshell*)PItem)->GetLSType();
        }
    }
}
