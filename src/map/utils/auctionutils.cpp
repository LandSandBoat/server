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

#include "auctionutils.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/settings.h"
#include "common/sql.h"
#include "common/tracy.h"

#include "entities/charentity.h"

#include "packets/auction_house.h"
#include "packets/inventory_finish.h"

#include "utils/charutils.h"
#include "utils/itemutils.h"
#include "utils/jailutils.h"
#include "utils/zoneutils.h"

void auctionutils::HandlePacket(CCharEntity* PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    const auto playerName = PChar->getName();

    // TODO: Validate all of these to make sure they're within sane bounds.
    const auto action   = data.ref<uint8>(0x04);
    const auto slotid   = data.ref<uint8>(0x05);
    const auto price    = data.ref<uint32>(0x08);
    const auto slot     = data.ref<uint8>(0x0C);
    const auto itemid   = data.ref<uint16>(0x0E);
    const auto quantity = data.ref<uint8>(0x10);

    if (jailutils::InPrison(PChar)) // If jailed, no AH menu for you.
    {
        return;
    }

    if (PChar->m_GMlevel == 0 && !PChar->loc.zone->CanUseMisc(MISC_AH))
    {
        ShowWarningFmt("{} is trying to use the auction house in a disallowed zone [{}]", PChar->getName(), PChar->loc.zone->getName());
        return;
    }

    switch (action)
    {
        case 0x04:
        {
            DebugAuctionsFmt("AH: SellingItems (action: {:02X}): player: {}, price: {}, slot: {}, itemid: {}, quantity: {}", action, playerName, price, slot, itemid, quantity);
            SellingItems(PChar, action, price, slot, itemid, quantity);
        }
        break;
        case 0x05:
        {
            DebugAuctionsFmt("AH: OpenListOfSales (action: {:02X}): player: {}, itemid: {}", action, playerName, itemid);
            OpenListOfSales(PChar, action, itemid);
            [[fallthrough]];
        }
        // FALLTHROUGH!
        case 0x0A:
        {
            DebugAuctionsFmt("AH: RetrieveListOfItemsSoldByPlayer (action: {:02X}): player: {}", action, playerName);
            RetrieveListOfItemsSoldByPlayer(PChar);
        }
        break;
        case 0x0B:
        {
            DebugAuctionsFmt("AH: ProofOfPurchase (action: {:02X}): player: {}, price: {}, slot: {}, itemid: {}, quantity: {}", action, playerName, price, slot, itemid, quantity);
            ProofOfPurchase(PChar, action, price, slot, quantity);
        }
        break;
        case 0x0E:
        {
            const auto itemIdFrom0x0C = data.ref<uint16>(0x0C);

            DebugAuctionsFmt("AH: PurchasingItems (action: {:02X}): player: {}, price: {}, slot: {}, itemid: {}, quantity: {}", action, playerName, price, slot, itemIdFrom0x0C, quantity);
            PurchasingItems(PChar, action, price, itemIdFrom0x0C, quantity);
        }
        break;
        case 0x0C:
        {
            DebugAuctionsFmt("AH: CancelSale (action: {:02X}): player: {}, slotid: {}", action, playerName, slotid);
            CancelSale(PChar, action, slotid);
        }
        break;
        case 0x0D:
        {
            DebugAuctionsFmt("AH: UpdateSaleListByPlayer (action: {:02X}): player: {}, slotid: {}", action, playerName, slotid);
            UpdateSaleListByPlayer(PChar, action, slotid);
        }
        break;
        default:
        {
            ShowErrorFmt("AH: Unhandled action: {:02X}, from player {}", action, playerName);
        }
        break;
    }
}

void auctionutils::SellingItems(CCharEntity* PChar, uint8 action, uint32 price, uint8 slot, uint16 itemid, uint8 quantity)
{
    TracyZoneScoped;

    CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slot);
    if (PItem == nullptr)
    {
        return;
    }

    if (PItem->getID() == itemid && !PItem->isSubType(ITEM_LOCKED) && !(PItem->getFlag() & ITEM_FLAG_NOAUCTION))
    {
        const bool isPartiallyUsed = [&]()
        {
            const bool isChargedItem = PItem->isSubType(ITEM_CHARGED);
            if (isChargedItem)
            {
                const auto PChargedItem = static_cast<CItemUsable*>(PItem);
                return PChargedItem->getCurrentCharges() < PChargedItem->getMaxCharges();
            }
            return false;
        }();
        if (isPartiallyUsed)
        {
            PChar->pushPacket<CAuctionHousePacket>(action, 197, 0, 0, 0, 0);
            return;
        }
        PChar->pushPacket<CAuctionHousePacket>(action, PItem, quantity, price);
    }
}

void auctionutils::OpenListOfSales(CCharEntity* PChar, uint8 action, uint16 itemid)
{
    TracyZoneScoped;

    const uint32 curTick = gettick();

    if (curTick - PChar->m_AHHistoryTimestamp > 5000)
    {
        PChar->m_ah_history.clear();
        PChar->m_AHHistoryTimestamp = curTick;
        PChar->pushPacket<CAuctionHousePacket>(action);

        // A single SQL query for the player's AH history which is stored in a Char Entity struct + vector.
        const auto rset = db::preparedStmt("SELECT itemid, price, stack FROM auction_house WHERE seller = ? AND sale=0 ORDER BY id ASC LIMIT 7", PChar->id);
        if (rset && rset->rowsCount())
        {
            while (rset->next())
            {
                PChar->m_ah_history.emplace_back(AuctionHistory_t{
                    .itemid = rset->get<uint16>("itemid"),
                    .stack  = rset->get<uint8>("stack"),
                    .price  = rset->get<uint32>("price"),
                    .status = 0,
                });
            }
        }
        DebugAuctionsFmt("AH: {} has {} items up on the AH", PChar->getName(), PChar->m_ah_history.size());
    }
    else
    {
        PChar->pushPacket<CAuctionHousePacket>(action, 246, 0, 0, 0, 0); // try again in a little while msg
    }
}

void auctionutils::RetrieveListOfItemsSoldByPlayer(CCharEntity* PChar)
{
    TracyZoneScoped;

    const auto totalItemsOnAh = PChar->m_ah_history.size();

    for (size_t auctionSlot = 0; auctionSlot < totalItemsOnAh; auctionSlot++)
    {
        PChar->pushPacket<CAuctionHousePacket>(0x0C, static_cast<uint8>(auctionSlot), PChar);
    }
}

void auctionutils::ProofOfPurchase(CCharEntity* PChar, uint8 action, uint32 price, uint8 slot, uint8 quantity)
{
    TracyZoneScoped;

    CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slot);

    if ((PItem != nullptr) && !(PItem->isSubType(ITEM_LOCKED)) && PItem->getReserve() == 0 && !(PItem->getFlag() & ITEM_FLAG_NOAUCTION) && PItem->getQuantity() >= quantity)
    {
        const bool isPartiallyUsed = [&]()
        {
            const bool isChargedItem = PItem->isSubType(ITEM_CHARGED);
            if (isChargedItem)
            {
                const auto PChargedItem = static_cast<CItemUsable*>(PItem);
                return PChargedItem->getCurrentCharges() < PChargedItem->getMaxCharges();
            }
            return false;
        }();
        if (isPartiallyUsed)
        {
            PChar->pushPacket<CAuctionHousePacket>(action, 197, 0, 0, 0, 0);
            return;
        }

        uint32 auctionFee = 0;
        if (quantity == 0)
        {
            if (PItem->getStackSize() == 1 || PItem->getStackSize() != PItem->getQuantity())
            {
                ShowErrorFmt("AH: Incorrect quantity of item {}", PItem->getName());
                PChar->pushPacket<CAuctionHousePacket>(action, 197, 0, 0, 0, 0); // Failed to place up
                return;
            }
            auctionFee = (uint32)(settings::get<uint32>("map.AH_BASE_FEE_STACKS") + (price * settings::get<float>("map.AH_TAX_RATE_STACKS") / 100));
        }
        else
        {
            auctionFee = (uint32)(settings::get<uint32>("map.AH_BASE_FEE_SINGLE") + (price * settings::get<float>("map.AH_TAX_RATE_SINGLE") / 100));
        }

        auctionFee = std::clamp<uint32>(auctionFee, 0, settings::get<uint32>("map.AH_MAX_FEE"));

        const auto PGil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);
        if (PGil->getQuantity() < auctionFee || PGil->getReserve() > 0)
        {
            PChar->pushPacket<CAuctionHousePacket>(action, 197, 0, 0, 0, 0); // Not enough gil to pay fee
            return;
        }

        // Get the current number of items the player has for sale
        const auto ahListings = [&]() -> uint32
        {
            const auto rset = db::preparedStmt("SELECT COUNT(*) FROM auction_house WHERE seller = ? AND sale = 0", PChar->id);
            if (rset && rset->rowsCount() && rset->next())
            {
                return rset->get<uint32>(0);
            }
            return 0;
        }();

        const auto ahListLimit = settings::get<uint8>("map.AH_LIST_LIMIT");
        if (ahListLimit && ahListings >= ahListLimit)
        {
            DebugAuctionsFmt("AH: Player {} has reached the AH listing limit of {}", PChar->getName(), ahListLimit);
            PChar->pushPacket<CAuctionHousePacket>(action, 197, 0, 0, 0, 0); // Failed to place up
            return;
        }

        if (!db::preparedStmt("INSERT INTO auction_house(itemid, stack, seller, seller_name, date, price) VALUES(?, ?, ?, ?, ?, ?)",
                              PItem->getID(), quantity == 0, PChar->id, PChar->getName(), (uint32)time(nullptr), price))
        {
            ShowErrorFmt("AH: Cannot insert item {} to database", PItem->getName());
            PChar->pushPacket<CAuctionHousePacket>(action, 197, 0, 0, 0, 0); // failed to place up
            return;
        }

        charutils::UpdateItem(PChar, LOC_INVENTORY, slot, -(int32)(quantity != 0 ? 1 : PItem->getStackSize()));
        charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)auctionFee); // Deduct AH fee

        PChar->pushPacket<CAuctionHousePacket>(action, 1, 0, 0, 0, 0);          // Merchandise put up on auction msg
        PChar->pushPacket<CAuctionHousePacket>(0x0C, (uint8)ahListings, PChar); // Inform history of slot
    }
}

void auctionutils::PurchasingItems(CCharEntity* PChar, uint8 action, uint32 price, uint16 itemid, uint8 quantity)
{
    TracyZoneScoped;

    if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
    {
        PChar->pushPacket<CAuctionHousePacket>(action, 0xE5, 0, 0, 0, 0);
    }
    else
    {
        CItem* PItem = itemutils::GetItemPointer(itemid);

        if (PItem != nullptr)
        {
            if (PItem->getFlag() & ITEM_FLAG_RARE)
            {
                for (uint8 LocID = 0; LocID < CONTAINER_ID::MAX_CONTAINER_ID; ++LocID)
                {
                    if (PChar->getStorage(LocID)->SearchItem(itemid) != ERROR_SLOTID)
                    {
                        PChar->pushPacket<CAuctionHousePacket>(action, 0xE5, 0, 0, 0, 0);
                        return;
                    }
                }
            }
            CItem* gil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

            if (gil != nullptr && gil->isType(ITEM_CURRENCY) && gil->getQuantity() >= price && gil->getReserve() == 0)
            {
                const auto [rset, affectedRows] = db::preparedStmtWithAffectedRows("UPDATE auction_house SET buyer_name = ?, sale = ?, sell_date = ? WHERE itemid = ? AND buyer_name IS NULL "
                                                                                   "AND stack = ? AND price <= ? ORDER BY price LIMIT 1",
                                                                                   PChar->getName(), price, (uint32)time(nullptr), itemid, quantity == 0, price);
                if (rset && affectedRows)
                {
                    uint8 SlotID = charutils::AddItem(PChar, LOC_INVENTORY, itemid, (quantity == 0 ? PItem->getStackSize() : 1));

                    if (SlotID != ERROR_SLOTID)
                    {
                        charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)(price));

                        PChar->pushPacket<CAuctionHousePacket>(action, 0x01, itemid, price, quantity, PItem->getStackSize());
                        PChar->pushPacket<CInventoryFinishPacket>();
                    }
                    return;
                }
            }
        }

        // You were unable to buy the {qty} {item}
        if (PItem)
        {
            PChar->pushPacket<CAuctionHousePacket>(action, 0xC5, itemid, price, quantity, PItem->getStackSize());
        }
        else
        {
            PChar->pushPacket<CAuctionHousePacket>(action, 0xC5, itemid, price, quantity, 0);
        }
    }
}

void auctionutils::CancelSale(CCharEntity* PChar, uint8 action, uint8 slotid)
{
    TracyZoneScoped;

    if (slotid < PChar->m_ah_history.size())
    {
        const bool isAutoCommitOn = db::getAutoCommit();

        AuctionHistory_t canceledItem = PChar->m_ah_history[slotid];

        if (db::setAutoCommit(false) && db::transactionStart())
        {
            const auto [rset, affectedRows] = db::preparedStmtWithAffectedRows("DELETE FROM auction_house WHERE seller = ? AND itemid = ? AND stack = ? AND price = ? AND sale = 0 LIMIT 1",
                                                                               PChar->id, canceledItem.itemid, canceledItem.stack, canceledItem.price);
            if (rset && affectedRows)
            {
                CItem* PDelItem = itemutils::GetItemPointer(canceledItem.itemid);
                if (PDelItem)
                {
                    uint8 SlotID = charutils::AddItem(PChar, LOC_INVENTORY, canceledItem.itemid, (canceledItem.stack != 0 ? PDelItem->getStackSize() : 1), true);
                    if (SlotID != ERROR_SLOTID)
                    {
                        db::transactionCommit();
                        PChar->pushPacket<CAuctionHousePacket>(action, 0, PChar, slotid, false);
                        PChar->pushPacket<CInventoryFinishPacket>();
                        db::setAutoCommit(isAutoCommitOn);
                        return;
                    }
                }
            }
            else
            {
                ShowErrorFmt("AH: Failed to return item id {} stack {} to char. ", canceledItem.itemid, canceledItem.stack);
            }

            db::transactionRollback();
            db::setAutoCommit(isAutoCommitOn);
        }
    }

    // Let client know something went wrong
    PChar->pushPacket<CAuctionHousePacket>(action, 0xE5, PChar, slotid, true); // Inventory full, unable to remove msg
}

void auctionutils::UpdateSaleListByPlayer(CCharEntity* PChar, uint8 action, uint8 slotid)
{
    TracyZoneScoped;

    PChar->pushPacket<CAuctionHousePacket>(action, slotid, PChar);
}
