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

#include "0x0fa_myroom_layout.h"

#include "entities/charentity.h"
#include "items/item_furnishing.h"
#include "lua/luautils.h"
#include "packets/furniture_interact.h"
#include "packets/s2c/0x01c_item_max.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x020_item_attr.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_MYROOM_LAYOUT::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // There's a handful more checks that could be moved up here, but the handler needs a proper refactor first.
    return PacketValidator()
        .range("MyroomFloorFlg", MyroomFloorFlg, 0, 1) // Flag indicating if 2nd floor
        .range("v", v, 0x0, 0x03)                      // Rotation of the item (0-3)
        .range("y", y, 0x0, 0x15);                     // Y grid position
}

void GP_CLI_COMMAND_MYROOM_LAYOUT::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (MyroomItemNo == 0)
    {
        // No item sent means the client has finished placing furniture
        PChar->UpdateMoghancement();
        return;
    }

    // TODO: Should we be responding with inventory update/finish if we reject the client's request?

    if (MyroomCategory != LOC_MOGSAFE && MyroomCategory != LOC_MOGSAFE2)
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid container requested: {}", PChar->getName()));
        return;
    }

    auto* PContainer = PChar->getStorage(MyroomCategory);
    if (PContainer == nullptr)
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid storage requested: {}", PChar->getName()));
        return;
    }

    if (MyroomItemIndex > PContainer->GetSize()) // TODO: Is this off-by-one?
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid slot requested: {}", PChar->getName()));
        return;
    }

    // NOTE: Items hanging on walls count as their own z/x entries, rather than y changes.
    //     : The multiple options on MH2F mean the x limit is higher.

    // NOTE: These are all unsigned, so <0 is handled
    bool lowerArea0 = z <= 23 && x <= 5;
    bool lowerArea1 = z >= 18 && z <= 23 && x >= 6 && x <= 13;
    bool lowerArea2 = z <= 23 && x >= 14 && x <= 19;
    bool upperArea0 = z <= 25 && x <= 91;

    if (MyroomFloorFlg && !upperArea0)
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid z/x requested: {}", PChar->getName()));
        return;
    }
    else if (!MyroomFloorFlg && !lowerArea0 && !lowerArea1 && !lowerArea2)
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid z/x requested: {}", PChar->getName()));
        return;
    }

    // Get item
    auto* PItem = dynamic_cast<CItemFurnishing*>(PContainer->GetItem(MyroomItemIndex));
    if (PItem == nullptr)
    {
        return;
    }

    // Try to catch packet abuse, leading to gardening pots being placed on 2nd floor.
    if (MyroomFloorFlg && PItem->isGardeningPot())
    {
        RATE_LIMIT(30s, ShowErrorFmt("{} has tried to gardening pot {} ({}) on 2nd floor",
                                     PChar->getName(), PItem->getID(), PItem->getName()));
        return;
    }

    // Continue with regular usage
    if (PItem->getID() == MyroomItemNo && PItem->isType(ITEM_FURNISHING))
    {
        auto tempV = v;

        if (PItem->getFlag() & ITEM_FLAG_WALLHANGING)
        {
            tempV = (x >= 2 ? 3 : 1);
        }

        bool wasInstalled = PItem->isInstalled();
        PItem->setInstalled(true);
        PItem->setOn2ndFloor(MyroomFloorFlg);
        PItem->setCol(x);
        PItem->setRow(z);
        PItem->setLevel(y);
        PItem->setRotation(tempV);

        constexpr auto maxContainerSize = MAX_CONTAINER_SIZE * 2;

        // Update installed furniture placement orders
        // First we place the furniture into placed items using the order number as the index
        std::array<CItemFurnishing*, maxContainerSize> placedItems = { nullptr };
        for (auto safeMyroomCategory : { LOC_MOGSAFE, LOC_MOGSAFE2 })
        {
            CItemContainer* PContainer = PChar->getStorage(safeMyroomCategory);
            for (int slotIndex = 1; slotIndex <= PContainer->GetSize(); ++slotIndex)
            {
                if (MyroomItemIndex == slotIndex && MyroomCategory == safeMyroomCategory)
                {
                    continue;
                }

                CItem* PContainerItem = PContainer->GetItem(slotIndex);
                if (PContainerItem != nullptr && PContainerItem->isType(ITEM_FURNISHING))
                {
                    if (auto PFurniture = static_cast<CItemFurnishing*>(PContainerItem); PFurniture->isInstalled())
                    {
                        placedItems[PFurniture->getOrder()] = PFurniture;
                    }
                }
            }
        }

        // Update the item's order number
        for (int32 i = 0; i < MAX_CONTAINER_SIZE * 2; ++i)
        {
            // We can stop updating the order numbers once we hit an empty order number
            if (placedItems[i] == nullptr)
            {
                break;
            }
            placedItems[i]->setOrder(placedItems[i]->getOrder() + 1);
        }

        // Set this item to being the most recently placed item
        PItem->setOrder(0);

        PItem->setSubType(ITEM_LOCKED);

        PChar->pushPacket<CFurnitureInteractPacket>(PItem, MyroomCategory, MyroomItemIndex);

        const auto rset = db::preparedStmt("UPDATE char_inventory "
                                           "SET "
                                           "extra = ? "
                                           "WHERE location = ? AND slot = ? AND charid = ? LIMIT 1",
                                           PItem->m_extra, MyroomCategory, MyroomItemIndex, PChar->id);

        if (rset && rset->rowsAffected() && !wasInstalled)
        {
            // Storage mods only apply on the 1st floor
            if (!PItem->getOn2ndFloor())
            {
                PChar->getStorage(LOC_STORAGE)->AddBuff(PItem->getStorage());
            }

            PChar->pushPacket<GP_SERV_COMMAND_ITEM_MAX>(PChar);

            luautils::OnFurniturePlaced(PChar, PItem);

            PChar->loc.zone->SpawnConditionalNPCs(PChar);
        }

        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItem, static_cast<CONTAINER_ID>(MyroomCategory), MyroomItemIndex);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
    }
}
