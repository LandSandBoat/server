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
#include "map/enums/furnishing_placement.h"
#include "packets/s2c/0x01c_item_max.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x020_item_attr.h"
#include "packets/s2c/0x0fa_myroom_operation.h"

namespace
{
// MH1F: 20x24 grid with a 8x18 unusable rectangle (x 6..13, z 0..17)
// MH2F: 20x26 grid, no exclusions.
auto isValidFloorCell(const uint8 cx, const uint8 cz, const bool is2F) -> bool
{
    if (is2F)
    {
        return cx <= 19 && cz <= 25;
    }

    if (cz > 23)
    {
        return false;
    }

    if (cx <= 5 || (cx >= 14 && cx <= 19))
    {
        return true;
    }

    return cx >= 6 && cx <= 13 && cz >= 18;
}

// 1F has 5 wall slots (0..4); 2F has 92 (0..91).
auto isValidWallSlot(const uint8 slot, const bool is2F) -> bool
{
    return slot <= (is2F ? 91 : 4);
}

// 90/270 degree rotations swap the item's width and depth.
auto rotatedSize(const CItemFurnishing* PItem, const uint8 v) -> std::pair<uint8, uint8>
{
    const auto [sx, sy] = PItem->size();
    return v == 1 || v == 3 ? std::pair{ sy, sx } : std::pair{ sx, sy };
}

// Given packet anchor point for furniture and server-side dimensions, ensure the whole footprint fits in legitimate cells.
auto footprintInGrid(const uint8 ax, const uint8 az, const uint8 sx, const uint8 sz, const bool is2F) -> bool
{
    for (uint8 cx = ax; cx < ax + sx; ++cx)
    {
        for (uint8 cz = az; cz < az + sz; ++cz)
        {
            if (!isValidFloorCell(cx, cz, is2F))
            {
                return false;
            }
        }
    }

    return true;
}

// Does 'other' occupy a floor cell that overlaps the rectangle at (x, z, width, depth)?
auto collidesOnFloor(CItemFurnishing* other, const uint8 x, const uint8 z, const uint8 width, const uint8 depth, const bool is2F) -> bool
{
    if (other->getOn2ndFloor() != is2F)
    {
        return false;
    }

    const auto op = other->placement();
    if (op == FurnishingPlacement::Wall)
    {
        return false;
    }

    // Stacked OnTable items live above the floor and don't conflict.
    if (op == FurnishingPlacement::OnTable && other->getLevel() != 0)
    {
        return false;
    }

    const auto [otherWidth, otherDepth] = rotatedSize(other, other->getRotation());
    const uint8 otherX                  = other->getCol();
    const uint8 otherZ                  = other->getRow();
    return x < otherX + otherWidth && otherX < x + width &&
           z < otherZ + otherDepth && otherZ < z + depth;
}

// Walks every installed furnishing in both mog safes (skipping the
// self entry) and returns true if pred matches one.
auto anyInstalledFurnishing(CCharEntity* PChar, const uint8 selfCat, const uint8 selfSlot, auto&& pred) -> bool
{
    for (const auto cat : { LOC_MOGSAFE, LOC_MOGSAFE2 })
    {
        const auto* container = PChar->getStorage(cat);
        for (int slot = 1; slot <= container->GetSize(); ++slot)
        {
            if (cat == selfCat && slot == selfSlot)
            {
                continue;
            }

            if (auto* PFurn = dynamic_cast<CItemFurnishing*>(container->GetItem(slot)); PFurn && PFurn->isInstalled() && pred(PFurn))
            {
                return true;
            }
        }
    }

    return false;
}
} // namespace

auto GP_CLI_COMMAND_MYROOM_LAYOUT::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .range("MyroomFloorFlg", this->MyroomFloorFlg, 0, 1) // Flag indicating if 2nd floor
        .range("v", this->v, 0, 3)                           // Rotation of the item (0-3)
        .range("y", this->y, 0, 25);                         // Stacking elevation (parent height / 10)
}

void GP_CLI_COMMAND_MYROOM_LAYOUT::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (this->MyroomItemNo == 0)
    {
        // No item sent means the client has finished placing furniture
        PChar->UpdateMoghancement();
        return;
    }

    if (this->MyroomCategory != LOC_MOGSAFE && this->MyroomCategory != LOC_MOGSAFE2)
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid container requested: {}", PChar->getName()));
        return;
    }

    auto* PContainer = PChar->getStorage(this->MyroomCategory);

    // Reject out of bounds item index
    if (this->MyroomItemIndex > PContainer->GetSize())
    {
        RATE_LIMIT(30s, ShowErrorFmt("Invalid slot requested: {}", PChar->getName()));
        return;
    }

    // Reject MH2F placements without MH2F unlocked
    const bool is2F = this->MyroomFloorFlg != 0;
    if (is2F && !(PChar->profile.mhflag & 0x20))
    {
        ShowErrorFmt("MH2F placement without 2F unlocked: {}", PChar->getName());
        return;
    }

    // Reject missing or wrong type items
    CItem* PSlotItem = PContainer->GetItem(this->MyroomItemIndex);
    if (!PSlotItem || !PSlotItem->isType(ITEM_FURNISHING))
    {
        return;
    }

    auto* PItem = static_cast<CItemFurnishing*>(PSlotItem);

    // Reject item ID not matching packet value.
    if (PItem->getID() != this->MyroomItemNo)
    {
        ShowErrorFmt("Layout item id mismatch: {}", PChar->getName());
        return;
    }

    const auto placement              = PItem->placement();
    const auto [itemWidth, itemDepth] = rotatedSize(PItem, this->v);

    switch (placement)
    {
        case FurnishingPlacement::Floor:
        case FurnishingPlacement::Surface:
        case FurnishingPlacement::OnTable:
        {
            // Every cell of the footprint must land on a valid floor tile.
            if (!footprintInGrid(this->x, this->z, itemWidth, itemDepth, is2F))
            {
                ShowErrorFmt("Invalid placement footprint: {}", PChar->getName());
                return;
            }

            // Items on the floor (y=0) must not overlap other floor furniture.
            // Stacked items (y>0) skip this because the client sends them before
            // the parent when repositioning, so the parent isn't at its new spot yet.
            if (this->y == 0 && anyInstalledFurnishing(PChar, this->MyroomCategory, this->MyroomItemIndex, [&](CItemFurnishing* other)
                                                       {
                                                           return collidesOnFloor(other, this->x, this->z, itemWidth, itemDepth, is2F);
                                                       }))
            {
                ShowErrorFmt("Placement collides with installed furniture: {}", PChar->getName());
                return;
            }

            // Fresh OnTable placement (not a move): verify a Surface parent exists
            // at (x, z) with matching height. Moves skip this because the client
            // sends the child packet before the parent's.
            if (placement == FurnishingPlacement::OnTable && this->y > 0 && !PItem->isInstalled())
            {
                const bool hasParent = anyInstalledFurnishing(PChar, this->MyroomCategory, this->MyroomItemIndex, [&](CItemFurnishing* other)
                                                              {
                                                                  if (other->placement() != FurnishingPlacement::Surface || other->getOn2ndFloor() != is2F)
                                                                  {
                                                                      return false;
                                                                  }

                                                                  if (other->height() / 10 != this->y)
                                                                  {
                                                                      return false;
                                                                  }

                                                                  const auto [pw, pd] = rotatedSize(other, other->getRotation());
                                                                  const uint8 px      = other->getCol();
                                                                  const uint8 pz      = other->getRow();
                                                                  return this->x >= px && this->x < px + pw &&
                                                                         this->z >= pz && this->z < pz + pd;
                                                              });
                if (!hasParent)
                {
                    ShowErrorFmt("OnTable placement with no matching Surface parent: {}", PChar->getName());
                    return;
                }
            }

            break;
        }
        case FurnishingPlacement::Wall:
        {
            if (this->y != 0 || this->z != 0)
            {
                ShowErrorFmt("Wall placement with non-zero y/z: {}", PChar->getName());
                return;
            }

            if (!isValidWallSlot(this->x, is2F))
            {
                ShowErrorFmt("Invalid wall slot requested: {}", PChar->getName());
                return;
            }

            const bool occupied = anyInstalledFurnishing(PChar, this->MyroomCategory, this->MyroomItemIndex, [&](CItemFurnishing* other)
                                                         {
                                                             return other->placement() == FurnishingPlacement::Wall &&
                                                                    other->getOn2ndFloor() == is2F &&
                                                                    other->getCol() == this->x;
                                                         });
            if (occupied)
            {
                ShowErrorFmt("Wall slot already occupied: {}", PChar->getName());
                return;
            }

            break;
        }
    }

    // Try to catch packet abuse, leading to gardening pots being placed on 2nd floor.
    if (this->MyroomFloorFlg && PItem->isGardeningPot())
    {
        RATE_LIMIT(
            30s,
            ShowErrorFmt(
                "{} has tried to gardening pot {} ({}) on 2nd floor",
                PChar->getName(),
                PItem->getID(),
                PItem->getName()));
        return;
    }

    // Continue with regular usage
    if (PItem->getID() == this->MyroomItemNo && PItem->isType(ITEM_FURNISHING))
    {
        bool wasInstalled = PItem->isInstalled();
        PItem->setInstalled(true);
        PItem->setOn2ndFloor(this->MyroomFloorFlg);
        PItem->setCol(this->x);
        PItem->setRow(this->z);
        PItem->setLevel(this->y);
        PItem->setRotation(this->v);

        constexpr auto maxContainerSize = MAX_CONTAINER_SIZE * 2;

        // Update installed furniture placement orders
        // First we place the furniture into placed items using the order number as the index
        std::array<CItemFurnishing*, maxContainerSize> placedItems = { nullptr };
        for (auto safeMyroomCategory : { LOC_MOGSAFE, LOC_MOGSAFE2 })
        {
            CItemContainer* PContainer = PChar->getStorage(safeMyroomCategory);
            for (int slotIndex = 1; slotIndex <= PContainer->GetSize(); ++slotIndex)
            {
                if (this->MyroomItemIndex == slotIndex && this->MyroomCategory == safeMyroomCategory)
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

        PChar->pushPacket<GP_SERV_COMMAND_MYROOM_OPERATION>(PItem, static_cast<CONTAINER_ID>(this->MyroomCategory), this->MyroomItemIndex);

        const auto rset = db::preparedStmt("UPDATE char_inventory "
                                           "SET "
                                           "extra = ? "
                                           "WHERE location = ? AND slot = ? AND charid = ? LIMIT 1",
                                           PItem->m_extra,
                                           this->MyroomCategory,
                                           this->MyroomItemIndex,
                                           PChar->id);

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

        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItem, static_cast<CONTAINER_ID>(this->MyroomCategory), this->MyroomItemIndex);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);
    }
}
