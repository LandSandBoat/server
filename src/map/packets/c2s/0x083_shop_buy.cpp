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

#include "0x083_shop_buy.h"

#include "common/settings.h"
#include "entities/char_entity.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x03f_shop_buy.h"
#include "trade_container.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"
#include "utils/zoneutils.h"

namespace
{

const auto auditPurchase = [](Scheduler& scheduler, CCharEntity* PChar, uint32_t itemId, uint32_t quantity, uint32_t basePrice, int32_t appliedGil)
{
    if (settings::get<bool>("map.AUDIT_PLAYER_VENDOR"))
    {
        const auto* PNpc = zoneutils::GetEntity(PChar->Container->getShopVendorId(), TYPE_NPC);

        const auto npcName = [PNpc]() -> std::string
        {
            if (PNpc)
            {
                return PNpc->getName();
            }

            return {};
        }();

        scheduler.postToWorkerThread(
            [itemId,
             quantity,
             buyer     = PChar->id,
             buyerName = PChar->getName(),
             basePrice,
             appliedGil,
             npcId = PChar->Container->getShopVendorId(),
             npcName,
             zoneId = static_cast<uint16>(PChar->getZone())]()
            {
                const auto totalPrice = quantity * basePrice;

                if (!db::preparedStmt("INSERT INTO audit_vendor(itemid, quantity, seller, seller_name, direction, npcid, npc_name, zoneid, baseprice, totalprice, applied_gil, date) "
                                      "VALUES (?, ?, ?, ?, 'buy', ?, ?, ?, ?, ?, ?, UNIX_TIMESTAMP())",
                                      itemId,
                                      quantity,
                                      buyer,
                                      buyerName,
                                      npcId,
                                      npcName,
                                      zoneId,
                                      basePrice,
                                      totalPrice,
                                      appliedGil))
                {
                    ShowErrorFmt("Failed to log vendor purchase (item: {}, quantity: {}, buyer: {}, totalprice: {})", itemId, quantity, buyer, totalPrice);
                }
            });
    }
};

} // namespace

auto GP_CLI_COMMAND_SHOP_BUY::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .mustEqual(this->PropertyItemIndex, 0, "PropertyItemIndex not 0");
}

void GP_CLI_COMMAND_SHOP_BUY::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto quantity = this->ItemNum;

    // Prevent users from buying from invalid container slots
    if (this->ShopItemIndex > PChar->Container->getExSize() - 1)
    {
        ShowError("User '%s' attempting to buy vendor item from an invalid slot!", PChar->getName());
        return;
    }

    const uint16 itemId = PChar->Container->getItemID(this->ShopItemIndex);
    const uint32 price  = PChar->Container->getQuantity(this->ShopItemIndex); // We used the "quantity" to store the item's sale price

    const CItem* PItem = xi::items::lookup(itemId);
    if (!PItem)
    {
        ShowWarning("User '%s' attempting to buy an invalid item from vendor!", PChar->getName());
        return;
    }

    // Ensure player meets the item purchase requirement, if any
    const bool meetsRequirement = std::visit(
        [&]<typename T>(const T& restriction) -> bool
        {
            if constexpr (std::is_same_v<T, JobRestriction>)
            {
                return PChar->jobs.job[restriction.jobId] >= restriction.level;
            }
            else if constexpr (std::is_same_v<T, GuildRestriction>)
            {
                return PChar->RealSkills.rank[restriction.guildId] >= restriction.rank;
            }
            else
            {
                return true;
            }
        },
        PChar->Container->getRestriction(this->ShopItemIndex));

    if (!meetsRequirement)
    {
        ShowWarningFmt("{} attempting to buy item {} without meeting shop requirement!", PChar->getName(), itemId);
        return;
    }

    // Prevent purchasing larger stacks than the actual stack size in database.
    if (quantity > PItem->getStackSize())
    {
        quantity = PItem->getStackSize();
    }

    const CItem* gil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

    if (!gil || !gil->isType(ITEM_CURRENCY) || gil->getReserve() != 0 || gil->isBusy())
    {
        ShowError("User '%s' has invalid gil", PChar->getName());
        return;
    }

    if (gil->getQuantity() >= (price * quantity))
    {
        if (charutils::AddItem(PChar, LOC_INVENTORY, itemId, quantity) != ERROR_SLOTID)
        {
            // Track the gil the player had before the transaction
            const uint32 gilBefore = gil->getQuantity();
            charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -static_cast<int32>(price * quantity));

            // Audit the purchase if enabled
            const auto appliedGil = static_cast<int32>(PChar->getStorage(LOC_INVENTORY)->GetItem(0)->getQuantity()) - static_cast<int32>(gilBefore);
            auditPurchase(*PSession->scheduler, PChar, itemId, quantity, price, appliedGil);

            ShowInfo("User '%s' purchased %u of item of ID %u [from VENDOR] ", PChar->getName(), quantity, itemId);
            PChar->pushPacket<GP_SERV_COMMAND_SHOP_BUY>(this->ShopItemIndex, quantity);
            PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);
        }
    }
}
