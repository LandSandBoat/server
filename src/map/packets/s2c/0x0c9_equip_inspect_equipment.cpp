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

#include "0x0c9_equip_inspect_equipment.h"

#include "common/vana_time.h"
#include "entities/charentity.h"
#include "enums/packet_c2s.h"
#include "items/item_equipment.h"
#include "items/item_usable.h"

GP_SERV_COMMAND_EQUIP_INSPECT::EQUIPMENT::EQUIPMENT(CCharEntity* PChar, CCharEntity* PTarget)
{
    auto& packet = this->data();

    packet.UniqNo     = PTarget->id;
    packet.ActIndex   = PTarget->targid;
    packet.OptionFlag = 0x03;

    uint8 count = 0;

    for (int32 i = 0; i < 16; ++i)
    {
        if (CItem* PItem = PTarget->getEquip(static_cast<SLOTTYPE>(i)))
        {
            auto& item = packet.Equip[count];

            item.ItemNo    = PItem->getID();
            item.EquipKind = static_cast<SAVE_EQUIP_KIND>(i);

            if (PItem->isSubType(ITEM_CHARGED))
            {
                timer::time_point currentTime = timer::now();
                timer::time_point nextUseTime = static_cast<CItemUsable*>(PItem)->getNextUseTime();

                item.Data[0] = 0x01; // Type
                item.Data[1] = static_cast<CItemUsable*>(PItem)->getCurrentCharges();
                item.Data[3] = nextUseTime > currentTime ? 0x90 : 0xD0; // ChargeFlag

                uint32 vNextUseTime = earth_time::vanadiel_timestamp(timer::to_utc(nextUseTime));
                uint32 vUseDelay    = static_cast<uint32>(timer::count_seconds(static_cast<CItemUsable*>(PItem)->getUseDelay()) + earth_time::vanadiel_timestamp());

                std::memcpy(&item.Data[4], &vNextUseTime, sizeof(uint32));
                std::memcpy(&item.Data[8], &vUseDelay, sizeof(uint32));
            }

            if (PItem->isSubType(ITEM_AUGMENTED))
            {
                item.Data[0] = 0x02; // Type

                uint16 aug0 = static_cast<CItemEquipment*>(PItem)->getAugment(0);
                uint16 aug1 = static_cast<CItemEquipment*>(PItem)->getAugment(1);
                uint16 aug2 = static_cast<CItemEquipment*>(PItem)->getAugment(2);
                uint16 aug3 = static_cast<CItemEquipment*>(PItem)->getAugment(3);

                std::memcpy(&item.Data[2], &aug0, sizeof(uint16));
                std::memcpy(&item.Data[4], &aug1, sizeof(uint16));
                std::memcpy(&item.Data[6], &aug2, sizeof(uint16));
                std::memcpy(&item.Data[8], &aug3, sizeof(uint16));
            }

            std::memcpy(&item.Data[12], PItem->getSignature().c_str(), std::clamp<size_t>(PItem->getSignature().size(), 0, 12));

            count++;

            if (count == 8)
            {
                packet.EquipCount = count;
                this->setSize(sizeof(GP_SERV_HEADER) + 8 + sizeof(packet.Equip[0]) * count);
                PChar->pushPacket(this->copy());

                // Reset for next batch
                std::memset(packet.Equip, 0, sizeof(packet.Equip));
                count = 0;
            }
        }
    }

    packet.EquipCount = count;
    this->setSize(sizeof(GP_SERV_HEADER) + 8 + sizeof(packet.Equip[0]) * std::max<uint8>(count, 1));
}
