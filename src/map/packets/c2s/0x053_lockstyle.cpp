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

#include "0x053_lockstyle.h"

#include "enums/msg_std.h"
#include "items/item_equipment.h"
#include "packets/char_sync.h"
#include "packets/s2c/0x009_message.h"
#include "packets/s2c/0x051_grap_list.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

namespace
{
    const auto updateClientAppearance = [](CCharEntity* PChar)
    {
        PChar->pushPacket<GP_SERV_COMMAND_GRAP_LIST>(PChar);
        PChar->pushPacket<CCharSyncPacket>(PChar);
    };
} // namespace

auto GP_CLI_COMMAND_LOCKSTYLE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_LOCKSTYLE_MODE>(Mode)
        .range("Count", Count, 0, 16);
}

void GP_CLI_COMMAND_LOCKSTYLE::process(MapSession* PSession, CCharEntity* PChar) const
{
    switch (static_cast<GP_CLI_COMMAND_LOCKSTYLE_MODE>(Mode))
    {
        case GP_CLI_COMMAND_LOCKSTYLE_MODE::Disable:
        {
            if (PChar->getStyleLocked())
            {
                charutils::SetStyleLock(PChar, false);
                PChar->RequestPersist(CHAR_PERSIST::EQUIP);
                updateClientAppearance(PChar);
            }
        }
        break;
        case GP_CLI_COMMAND_LOCKSTYLE_MODE::Continue:
        {
            PChar->setStyleLocked(true);
        }
        break;
        case GP_CLI_COMMAND_LOCKSTYLE_MODE::Query:
        {
            PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(PChar->getStyleLocked() ? MsgStd::StyleLockIsOn : MsgStd::StyleLockIsOff);
        }
        break;
        case GP_CLI_COMMAND_LOCKSTYLE_MODE::Set:
        {
            // TODO: First, move this to charutils.
            // TODO: Missing a handful of retail checks here
            charutils::SetStyleLock(PChar, true);

            // Build new lockstyle
            for (int i = 0; i < Count; i++)
            {
                const auto& item   = Items[i];
                uint16_t    itemId = item.ItemNo;

                // Skip non-visible items
                if (item.EquipKind > SLOT_FEET)
                {
                    continue;
                }

                const auto* PItem = dynamic_cast<CItemEquipment*>(itemutils::GetItemPointer(itemId));
                if (!PItem || !(PItem->isType(ITEM_WEAPON) || PItem->isType(ITEM_EQUIPMENT)))
                {
                    itemId = 0;
                }
                else if ((PItem->getEquipSlotId() & (1 << item.EquipKind)) == 0) // item doesn't fit in slot
                {
                    itemId = 0;
                }

                PChar->styleItems[item.EquipKind] = itemId;
            }

            // Check if we need to remove conflicting slots. Essentially, packet injection shenanigan detector.
            for (int i = 0; i < 10; i++)
            {
                if (const auto* PItemEquipment = dynamic_cast<CItemEquipment*>(itemutils::GetItemPointer(PChar->styleItems[i])))
                {
                    const auto removeSlotID = PItemEquipment->getRemoveSlotId();

                    for (uint8_t x = 0; x < sizeof(removeSlotID) * 8; ++x)
                    {
                        if (removeSlotID & (1 << x))
                        {
                            PChar->styleItems[x] = 0;
                        }
                    }
                }
            }

            for (int i = 0; i < 10; i++)
            {
                // variable initialized here due to case/switch optimization throwing warnings inside the case
                auto* PItem = PChar->getEquip(static_cast<SLOTTYPE>(i));

                switch (i)
                {
                    case SLOT_MAIN:
                    case SLOT_SUB:
                    case SLOT_RANGED:
                    case SLOT_AMMO:
                        charutils::UpdateWeaponStyle(PChar, i, PItem);
                        break;
                    case SLOT_HEAD:
                    case SLOT_BODY:
                    case SLOT_HANDS:
                    case SLOT_LEGS:
                    case SLOT_FEET:
                        charutils::UpdateArmorStyle(PChar, i);
                        break;
                }
            }

            charutils::UpdateRemovedSlotsLookForLockStyle(PChar);
            PChar->RequestPersist(CHAR_PERSIST::EQUIP);
            updateClientAppearance(PChar);
        }
        break;
        case GP_CLI_COMMAND_LOCKSTYLE_MODE::Enable:
        {
            charutils::SetStyleLock(PChar, true);
            charutils::UpdateRemovedSlotsLookForLockStyle(PChar);
            PChar->RequestPersist(CHAR_PERSIST::EQUIP);
            updateClientAppearance(PChar);
        }
        break;
    }
}
