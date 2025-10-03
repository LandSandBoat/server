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
#include "common/timer.h"
#include "common/tracy.h"

#include "entities/charentity.h"

#include "packets/auction_house.h"
#include "packets/c2s/0x04e_auc.h"
#include "packets/s2c/0x01d_item_same.h"

#include "utils/charutils.h"
#include "utils/itemutils.h"
#include "utils/zoneutils.h"

namespace
{
    const auto isPartiallyUsed = [](CItem* PItem) -> bool
    {
        if (PItem->isSubType(ITEM_CHARGED))
        {
            const auto PChargedItem = static_cast<CItemUsable*>(PItem);
            return PChargedItem->getCurrentCharges() < PChargedItem->getMaxCharges();
        }

        return false;
    };
} // namespace

void auctionutils::SellingItems(CCharEntity* PChar, GP_AUC_PARAM_ASKCOMMIT param)
{
    TracyZoneScoped;

    DebugAuctionsFmt("AH: SellingItems: player: {}, Commission: {}, ItemWorkIndex: {}, ItemNo: {}, ItemStacks: {}",
                     PChar->getName(), param.Commission, param.ItemWorkIndex, param.ItemNo, param.ItemStacks);

    CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(param.ItemWorkIndex);
    if (!PItem)
    {
        return;
    }

    if (PItem->getID() == param.ItemNo && !PItem->isSubType(ITEM_LOCKED) && !(PItem->getFlag() & ITEM_FLAG_NOAUCTION))
    {
        if (isPartiallyUsed(PItem))
        {
            PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::AskCommit, 197, 0, 0, 0, 0);
            return;
        }

        PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::AskCommit, PItem, param.ItemStacks, param.Commission);
    }
}

void auctionutils::OpenListOfSales(CCharEntity* PChar)
{
    TracyZoneScoped;

    DebugAuctionsFmt("AH: OpenListOfSales: player: {}", PChar->getName());

    if (const auto curTick = timer::now(); curTick > PChar->m_AHHistoryTimestamp + 5s)
    {
        PChar->m_ah_history.clear();
        PChar->m_AHHistoryTimestamp = curTick;
        PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::Info);

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
        PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::Info, 246, 0, 0, 0, 0); // try again in a little while msg
    }
}

void auctionutils::RetrieveListOfItemsSoldByPlayer(CCharEntity* PChar)
{
    TracyZoneScoped;

    DebugAuctionsFmt("AH: RetrieveListOfItemsSoldByPlayer: player: {}", PChar->getName());

    const auto totalItemsOnAh = PChar->m_ah_history.size();

    for (size_t auctionSlot = 0; auctionSlot < totalItemsOnAh; auctionSlot++)
    {
        PChar->pushPacket<CAuctionHousePacket>(static_cast<GP_CLI_COMMAND_AUC_COMMAND>(0x0C), static_cast<uint8>(auctionSlot), PChar);
    }
}

void auctionutils::ProofOfPurchase(CCharEntity* PChar, GP_AUC_PARAM_LOT param)
{
    TracyZoneScoped;

    DebugAuctionsFmt("AH: ProofOfPurchase: player: {}, LimitPrice: {}, ItemWorkIndex: {}, ItemStacks: {}",
                     PChar->getName(), param.LimitPrice, param.ItemWorkIndex, param.ItemStacks);

    CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(param.ItemWorkIndex);

    if (PItem && !(PItem->isSubType(ITEM_LOCKED)) && PItem->getReserve() == 0 && !(PItem->getFlag() & ITEM_FLAG_NOAUCTION) && PItem->getQuantity() >= param.ItemStacks)
    {
        if (isPartiallyUsed(PItem))
        {
            PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::LotIn, 197, 0, 0, 0, 0);
            return;
        }

        uint32 auctionFee = 0;
        if (param.ItemStacks == 0) // Selling a stack
        {
            if (PItem->getStackSize() == 1 || PItem->getStackSize() != PItem->getQuantity())
            {
                ShowErrorFmt("AH: Incorrect quantity of item {}", PItem->getName());
                PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::LotIn, 197, 0, 0, 0, 0); // Failed to place up
                return;
            }
            auctionFee = static_cast<uint32>(settings::get<uint32>("map.AH_BASE_FEE_STACKS") + (param.LimitPrice * settings::get<float>("map.AH_TAX_RATE_STACKS") / 100));
        }
        else // Selling a single item
        {
            auctionFee = static_cast<uint32>(settings::get<uint32>("map.AH_BASE_FEE_SINGLE") + (param.LimitPrice * settings::get<float>("map.AH_TAX_RATE_SINGLE") / 100));
        }

        auctionFee = std::clamp<uint32>(auctionFee, 0, settings::get<uint32>("map.AH_MAX_FEE"));

        const auto PGil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);
        if (PGil->getQuantity() < auctionFee || PGil->getReserve() > 0)
        {
            PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::LotIn, 197, 0, 0, 0, 0); // Not enough gil to pay fee
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
            PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::LotIn, 197, 0, 0, 0, 0); // Failed to place up
            return;
        }

        if (!db::preparedStmt("INSERT INTO auction_house(itemid, stack, seller, seller_name, date, price) VALUES(?, ?, ?, ?, ?, ?)",
                              PItem->getID(), param.ItemStacks == 0, PChar->id, PChar->getName(), earth_time::timestamp(), param.LimitPrice))
        {
            ShowErrorFmt("AH: Cannot insert item {} to database", PItem->getName());
            PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::LotIn, 197, 0, 0, 0, 0); // failed to place up
            return;
        }

        charutils::UpdateItem(PChar, LOC_INVENTORY, param.ItemWorkIndex, -static_cast<int32>(param.ItemStacks != 0 ? 1 : PItem->getStackSize()));
        charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -static_cast<int32>(auctionFee)); // Deduct AH fee

        PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::LotIn, 1, 0, 0, 0, 0);                                     // Merchandise put up on auction msg
        PChar->pushPacket<CAuctionHousePacket>(static_cast<GP_CLI_COMMAND_AUC_COMMAND>(0x0C), static_cast<uint8>(ahListings), PChar); // Inform history of slot
    }
}

auto auctionutils::PurchasingItems(CCharEntity* PChar, GP_AUC_PARAM_BID param) -> bool
{
    TracyZoneScoped;

    DebugAuctionsFmt("AH: PurchasingItems: player: {}, BidPrice: {}, ItemNo: {}, ItemStacks: {}",
                     PChar->getName(), param.BidPrice, param.ItemNo, param.ItemStacks);

    if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
    {
        PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::Bid, 0xE5, 0, 0, 0, 0);
    }
    else
    {
        const CItem* PItem = itemutils::GetItemPointer(param.ItemNo);

        if (PItem != nullptr)
        {
            if (PItem->getFlag() & ITEM_FLAG_RARE)
            {
                for (uint8 LocID = 0; LocID < CONTAINER_ID::MAX_CONTAINER_ID; ++LocID)
                {
                    if (PChar->getStorage(LocID)->SearchItem(param.ItemNo) != ERROR_SLOTID)
                    {
                        PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::Bid, 0xE5, 0, 0, 0, 0);
                        return false;
                    }
                }
            }
            const CItem* gil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

            if (gil != nullptr && gil->isType(ITEM_CURRENCY) && gil->getQuantity() >= param.BidPrice && gil->getReserve() == 0)
            {
                const auto rset = db::preparedStmt("UPDATE auction_house SET buyer_name = ?, sale = ?, sell_date = ? WHERE itemid = ? AND buyer_name IS NULL "
                                                   "AND stack = ? AND price <= ? ORDER BY price LIMIT 1",
                                                   PChar->getName(), param.BidPrice, earth_time::timestamp(), param.ItemNo, param.ItemStacks == 0, param.BidPrice);
                if (rset && rset->rowsAffected())
                {
                    if (charutils::AddItem(PChar, LOC_INVENTORY, param.ItemNo, (param.ItemStacks == 0 ? PItem->getStackSize() : 1)) != ERROR_SLOTID)
                    {
                        charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -static_cast<int32>(param.BidPrice));

                        PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::Bid, 0x01, param.ItemNo, param.BidPrice, param.ItemStacks, PItem->getStackSize());
                        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();

                        return true;
                    }
                }
            }
        }

        // You were unable to buy the {qty} {item}
        if (PItem)
        {
            PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::Bid, 0xC5, param.ItemNo, param.BidPrice, param.ItemStacks, PItem->getStackSize());
        }
        else
        {
            PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::Bid, 0xC5, param.ItemNo, param.BidPrice, param.ItemStacks, 0);
        }
    }

    return false;
}

void auctionutils::CancelSale(CCharEntity* PChar, int8_t AucWorkIndex)
{
    TracyZoneScoped;

    DebugAuctionsFmt("AH: CancelSale: player: {}, AucWorkIndex: {}", PChar->getName(), AucWorkIndex);

    // AucWorkIndex can technically be -1 but this is checked at the packet handler level.
    if (AucWorkIndex < PChar->m_ah_history.size())
    {
        AuctionHistory_t canceledItem = PChar->m_ah_history[AucWorkIndex];

        // clang-format off
        const auto success = db::transaction([&]()
        {
            const auto rset = db::preparedStmt("DELETE FROM auction_house WHERE seller = ? AND itemid = ? AND stack = ? AND price = ? AND sale = 0 LIMIT 1",
                                                                               PChar->id, canceledItem.itemid, canceledItem.stack, canceledItem.price);
            if (rset && rset->rowsAffected())
            {
                if (const CItem* PDelItem = itemutils::GetItemPointer(canceledItem.itemid))
                {
                    if (charutils::AddItem(PChar, LOC_INVENTORY, canceledItem.itemid, (canceledItem.stack != 0 ? PDelItem->getStackSize() : 1), true) != ERROR_SLOTID)
                    {
                        return;
                    }
                }
            }

            // If we got here, something went wrong.
            throw std::runtime_error(fmt::format("AH: Failed to return item id {} stack {} to char {} ({})", canceledItem.itemid, canceledItem.stack, PChar->getName(), PChar->id));
        });
        if (success)
        {
            PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::LotCancel, 0, PChar, static_cast<uint8_t>(AucWorkIndex), false);
            PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
            return;
        }
        // clang-format on
    }

    // Let client know something went wrong
    PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::LotCancel, 0xE5, PChar, static_cast<uint8_t>(AucWorkIndex), true); // Inventory full, unable to remove msg
}

void auctionutils::UpdateSaleListByPlayer(CCharEntity* PChar, int8_t AucWorkIndex)
{
    TracyZoneScoped;

    // AucWorkIndex can technically be -1 but this is checked at the packet handler level.
    DebugAuctionsFmt("AH: UpdateSaleListByPlayer: player: {}, AucWorkIndex: {}", PChar->getName(), AucWorkIndex);
    PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::LotCheck, AucWorkIndex, PChar);
}
