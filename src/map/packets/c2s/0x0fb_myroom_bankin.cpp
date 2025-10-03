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

#include "0x0fb_myroom_bankin.h"

#include "entities/charentity.h"
#include "enums/item_lockflg.h"
#include "items/item_furnishing.h"
#include "lua/luautils.h"
#include "packets/char_status.h"
#include "packets/s2c/0x01c_item_max.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x01f_item_list.h"
#include "packets/s2c/0x020_item_attr.h"
#include "packets/s2c/0x026_item_subcontainer.h"
#include "utils/charutils.h"
namespace
{
    const std::set<uint8_t> validContainers = { LOC_MOGSAFE, LOC_MOGSAFE2 };
}

auto GP_CLI_COMMAND_MYROOM_BANKIN::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustNotEqual(MyroomItemNo, 0, "MyroomItemNo must not equal 0")
        .oneOf("MyroomCategory", MyroomCategory, validContainers);
}

void GP_CLI_COMMAND_MYROOM_BANKIN::process(MapSession* PSession, CCharEntity* PChar) const
{
    CItemContainer*  PItemContainer = PChar->getStorage(MyroomCategory);
    CItemFurnishing* PItem          = static_cast<CItemFurnishing*>(PItemContainer->GetItem(MyroomItemIndex));

    if (PItem != nullptr && PItem->getID() == MyroomItemNo && PItem->isType(ITEM_FURNISHING))
    {
        PItemContainer = PChar->getStorage(LOC_STORAGE);

        uint8 RemovedSize = PItemContainer->GetSize() - std::min<uint8>(PItemContainer->GetSize(), PItemContainer->GetBuff() - PItem->getStorage());

        if (PItemContainer->GetFreeSlotsCount() >= RemovedSize)
        {
            PItem->setInstalled(false);
            PItem->setCol(0);
            PItem->setRow(0);
            PItem->setLevel(0);
            PItem->setRotation(0);

            PItem->setSubType(ITEM_UNLOCKED);

            // If this furniture is a mannequin, clear its appearance and unlock all items that were on it!
            if (PItem->isMannequin())
            {
                PChar->pushPacket<GP_SERV_COMMAND_ITEM_SUBCONTAINER>(static_cast<CONTAINER_ID>(MyroomCategory), MyroomItemIndex, 0, 0, 0, 0, 0, 0, 0, 0);
                for (uint8 i = 0; i < 8; ++i)
                {
                    if (PItem->m_extra[10 + i] > 0)
                    {
                        auto* PEquippedItem = PChar->getStorage(LOC_STORAGE)->GetItem(i);
                        if (PEquippedItem == nullptr)
                        {
                            continue;
                        }
                        PChar->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(PEquippedItem, ItemLockFlg::Normal);
                        PItem->m_extra[10 + i] = 0;
                    }
                }
            }

            const auto rset = db::preparedStmt("UPDATE char_inventory "
                                               "SET "
                                               "extra = ? "
                                               "WHERE location = ? AND slot = ? AND charid = ? LIMIT 1",
                                               PItem->m_extra, MyroomCategory, MyroomItemIndex, PChar->id);

            if (rset && rset->rowsAffected())
            {
                uint8 NewSize = PItemContainer->GetSize() - RemovedSize;
                for (uint8 SlotID = PItemContainer->GetSize(); SlotID > NewSize; --SlotID)
                {
                    if (PItemContainer->GetItem(SlotID) != nullptr)
                    {
                        charutils::MoveItem(PChar, LOC_STORAGE, SlotID, ERROR_SLOTID);
                    }
                }

                // Storage mods only apply on the 1st floor
                if (!PItem->getOn2ndFloor())
                {
                    PChar->getStorage(LOC_STORAGE)->AddBuff(-(int8)PItem->getStorage());
                }

                PChar->pushPacket<GP_SERV_COMMAND_ITEM_MAX>(PChar);

                luautils::OnFurnitureRemoved(PChar, PItem);

                PChar->loc.zone->SpawnConditionalNPCs(PChar);
            }
            PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItem, static_cast<CONTAINER_ID>(MyroomCategory), PItem->getSlotID());
            PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
        }
        else
        {
            ShowError("GP_CLI_COMMAND_MYROOM_BANKIN: furnishing can't be removed");
        }
    }
}
