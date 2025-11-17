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

#include "0x04c_auc.h"

#include "entities/charentity.h"
#include "packets/c2s/0x04e_auc.h"

namespace
{

constexpr uint8_t AuctionHouseId = 4; // Jeuno linked AH

}

GP_SERV_COMMAND_AUC::GP_SERV_COMMAND_AUC(const GP_CLI_COMMAND_AUC_COMMAND action)
{
    auto& packet = this->data();

    packet.Command      = action;
    packet.AucWorkIndex = -1;
    packet.Result       = 1; // Auction House open
}

GP_SERV_COMMAND_AUC::GP_SERV_COMMAND_AUC(const GP_CLI_COMMAND_AUC_COMMAND action, const CItem* PItem, const uint8 quantity, const uint32 price)
{
    auto& packet = this->data();

    uint32 auctionFee = 0;
    if (quantity == 0) // This is a stack..Yes, zero for stacks.. Why is this being called quantity?
    {
        auctionFee = static_cast<uint32>(settings::get<uint32>("map.AH_BASE_FEE_STACKS") + (price * settings::get<float>("map.AH_TAX_RATE_STACKS") / 100));
    }
    else // This is a single item.
    {
        auctionFee = static_cast<uint32>(settings::get<uint32>("map.AH_BASE_FEE_SINGLE") + (price * settings::get<float>("map.AH_TAX_RATE_SINGLE") / 100));
    }

    auctionFee = std::clamp<uint32>(auctionFee, 0, settings::get<uint32>("map.AH_MAX_FEE"));

    packet.Command                       = action;
    packet.AucWorkIndex                  = -1;
    packet.Result                        = 1;
    packet.ResultStatus                  = 0x02;
    packet.Param.AskCommit.Commission    = auctionFee;
    packet.Param.AskCommit.ItemNo        = PItem->getID();
    packet.Param.AskCommit.ItemWorkIndex = PItem->getSlotID();
    packet.Param.AskCommit.ItemStacks    = quantity;
    packet.Parcel.MarketNo               = AuctionHouseId;
}

// e.g. client history, client probes a slot number which you give the correct itemId+price
GP_SERV_COMMAND_AUC::GP_SERV_COMMAND_AUC(const GP_CLI_COMMAND_AUC_COMMAND action, const uint8 slot, const CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.Command      = action;
    packet.AucWorkIndex = slot;
    packet.Result       = 1;

    if (slot < 7 && slot < PChar->m_ah_history.size())
    {
        packet.Parcel.Stat         = 0x03;
        packet.Parcel.ItemIndex    = 0x01;                                   // Value is changed, the purpose is unknown
        packet.Parcel.ItemNo       = PChar->m_ah_history.at(slot).itemid;    // Item ID of item in slot
        packet.Parcel.ItemQuantity = 1 - PChar->m_ah_history.at(slot).stack; // Number of items stack size
        packet.Parcel.ItemCategory = 0x02;                                   // Number of items stack size?
        packet.Parcel.Price        = PChar->m_ah_history.at(slot).price;     // Selling price
        packet.Parcel.MarketNo     = AuctionHouseId;
    }
}

GP_SERV_COMMAND_AUC::GP_SERV_COMMAND_AUC(const GP_CLI_COMMAND_AUC_COMMAND action, const uint8 message, const uint16 itemid, const uint32 price, const uint8 quantity, const uint8 stacksize)
{
    auto& packet = this->data();

    packet.Command            = action;
    packet.Result             = message;
    packet.Param.Bid.BidPrice = price;
    packet.Param.Bid.ItemNo   = itemid;
    // 0 = stack, 1 = single
    packet.Param.Bid.ItemStacks = quantity == 0 ? stacksize : 1;
}

GP_SERV_COMMAND_AUC::GP_SERV_COMMAND_AUC(const GP_CLI_COMMAND_AUC_COMMAND action, const uint8 message, const CCharEntity* PChar, const uint8 slot, const bool keepItem)
{
    auto& packet = this->data();

    packet.Command      = action;
    packet.AucWorkIndex = slot;
    packet.Result       = message;

    // we need all this guff so the item stays in the history.
    if (keepItem && slot < 7 && slot < PChar->m_ah_history.size())
    {
        packet.Parcel.Stat         = 0x03;
        packet.Parcel.ItemIndex    = 0x01;                                   // Value is changed, the purpose is unknown
        packet.Parcel.ItemNo       = PChar->m_ah_history.at(slot).itemid;    // Id sell items item id
        packet.Parcel.ItemQuantity = 1 - PChar->m_ah_history.at(slot).stack; // Number of items stack size
        packet.Parcel.ItemCategory = 0x02;                                   // Number of items stack size?
        packet.Parcel.Price        = PChar->m_ah_history.at(slot).price;     // Price selling price
        packet.Parcel.MarketNo     = AuctionHouseId;

        std::memcpy(packet.Parcel.Name, PChar->getName().c_str(), std::min(PChar->getName().size(), sizeof(packet.Parcel.Name)));
    }
}
