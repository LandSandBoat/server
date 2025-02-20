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

#include "char_check.h"

#include "common/socket.h"
#include "common/utils.h"
#include "common/vana_time.h"

#include <cstring>

#include "entities/charentity.h"
#include "utils/itemutils.h"

CCheckPacket::CCheckPacket(CCharEntity* PChar, CCharEntity* PTarget)
{
    this->setType(0xC9);
    this->setSize(0x0C);

    ref<uint32>(0x04) = PTarget->id;
    ref<uint16>(0x08) = PTarget->targid;

    ref<uint8>(0x0A) = 0x03;

    uint8 count = 0;

    for (int32 i = 0; i < 16; ++i)
    {
        CItem* PItem = PTarget->getEquip((SLOTTYPE)i);

        if (PItem != nullptr)
        {
            auto size                    = this->getSize() / 2; // TODO: Verify this, size used to use the old two-byte value
            ref<uint16>(size * 2 + 0x00) = PItem->getID();
            ref<uint8>(size * 2 + 0x02)  = i;

            if (PItem->isSubType(ITEM_CHARGED))
            {
                uint32 currentTime = CVanaTime::getInstance()->getVanaTime();
                uint32 nextUseTime = ((CItemUsable*)PItem)->getLastUseTime() + ((CItemUsable*)PItem)->getReuseDelay();

                ref<uint8>(size * 2 + 0x04) = 0x01;
                ref<uint8>(size * 2 + 0x05) = ((CItemUsable*)PItem)->getCurrentCharges();
                ref<uint8>(size * 2 + 0x07) = (nextUseTime > currentTime ? 0x90 : 0xD0);

                ref<uint32>(size * 2 + 0x08) = nextUseTime;
                ref<uint32>(size * 2 + 0x0C) = ((CItemUsable*)PItem)->getUseDelay() + currentTime;
            }

            if (PItem->isSubType(ITEM_AUGMENTED))
            {
                ref<uint8>(size * 2 + 0x04) = 0x02;

                ref<uint16>(size * 2 + 0x06) = ((CItemEquipment*)PItem)->getAugment(0);
                ref<uint16>(size * 2 + 0x08) = ((CItemEquipment*)PItem)->getAugment(1);
                ref<uint16>(size * 2 + 0x0A) = ((CItemEquipment*)PItem)->getAugment(2);
                ref<uint16>(size * 2 + 0x0C) = ((CItemEquipment*)PItem)->getAugment(3);
            }
            // 12 characters? seems a bit short. // TODO: research.
            std::memcpy(buffer_.data() + (size * 2 + 0x10), PItem->getSignature().c_str(), std::clamp<size_t>(PItem->getSignature().size(), 0, 12));

            this->setSize(size * 2 + 0x1C);
            count++;

            if (count == 8)
            {
                ref<uint8>(0x0B) = count;

                PChar->pushPacket(this->copy());

                this->setSize(0x0C);
                std::memset(buffer_.data() + 0x0B, 0, PACKET_SIZE - 11);
            }
        }
    }

    if (count == 0)
    {
        this->setSize(0x28);
        PChar->pushPacket(this->copy());
    }
    else if (count != 8)
    {
        ref<uint8>(0x0B) = (count > 8 ? count - 8 : count);
        PChar->pushPacket(this->copy());
    }

    this->setSize(0x54);
    std::memset(buffer_.data() + 0x0B, 0, PACKET_SIZE - 11);

    ref<uint8>(0x0A) = 0x01;

    CItemLinkshell* PLinkshell = (CItemLinkshell*)PTarget->getEquip(SLOT_LINK1);

    if ((PLinkshell != nullptr) && PLinkshell->isType(ITEM_LINKSHELL))
    {
        ref<uint16>(0x0E) = PLinkshell->getID();
        // 15 characters? seems a bit short // TODO: research.
        std::memcpy(buffer_.data() + 0x10, PLinkshell->getSignature().c_str(), std::clamp<size_t>(PLinkshell->getSignature().size(), 0, 15));
        // ref<uint16>(0x0C) = PLinkshell->GetLSID();
        ref<uint16>(0x20) = PLinkshell->GetLSRawColor();
    }
    if (PChar->visibleGmLevel >= 3 || !PTarget->isAnon())
    {
        ref<uint8>(0x22) = PTarget->GetMJob();
        ref<uint8>(0x23) = PTarget->GetSJob();
        ref<uint8>(0x24) = PTarget->GetMLevel();
        ref<uint8>(0x25) = PTarget->GetSLevel();
        ref<uint8>(0x26) = PTarget->GetMJob();
        ref<uint8>(0x27) = 0; // Master Level
        ref<uint8>(0x28) = 0; // bitflags, bit 0 = Master Breaker
    }

    // Chevron 32 bit Big Endean, starting at 0x2B
    // ref<uint8>(0x2C) = 0x00; //Ballista Star next to Chevron count
}
