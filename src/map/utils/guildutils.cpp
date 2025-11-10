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

#include "guildutils.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/vana_time.h"

#include <vector>

#include "items/item_shop.h"

#include "charutils.h"
#include "guild.h"
#include "item_container.h"
#include "itemutils.h"
#include "serverutils.h"

// TODO: During the closure of the guild, all viewing products of the goods are sent 0x86 with information about the closure of the guild

std::vector<CGuild*>         g_PGuildList;
std::vector<CItemContainer*> g_PGuildShopList;

namespace guildutils
{

void Initialize()
{
    auto rset = db::preparedStmt("SELECT DISTINCT id, points_name FROM guilds ORDER BY id ASC");
    if (rset)
    {
        g_PGuildList.reserve(rset->rowsCount());
    }

    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        g_PGuildList.emplace_back(new CGuild(rset->get<uint8>("id"), rset->get<std::string>("points_name")));
    }

    if (g_PGuildShopList.size() != 0)
    {
        ShowWarning("g_PGuildShopList contains information prior to initialization.");
        return;
    }

    rset = db::preparedStmt("SELECT DISTINCT guildid FROM guild_shops ORDER BY guildid ASC LIMIT 256");
    if (rset)
    {
        g_PGuildShopList.reserve(rset->rowsCount());
    }

    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        g_PGuildShopList.emplace_back(new CItemContainer(rset->get<uint16>("guildid")));
    }

    for (auto* PGuildShop : g_PGuildShopList)
    {
        rset = db::preparedStmt("SELECT gs.itemid, gs.min_price, gs.max_price, gs.max_quantity, gs.daily_increase, gs.initial_quantity, ib.flags "
                                "FROM guild_shops gs "
                                "JOIN item_basic ib ON gs.itemid = ib.itemid "
                                "WHERE gs.guildid = ? "
                                "LIMIT ?",
                                PGuildShop->GetID(),
                                MAX_CONTAINER_SIZE);
        if (rset)
        {
            PGuildShop->SetSize(static_cast<uint8>(rset->rowsCount()));
        }

        FOR_DB_MULTIPLE_RESULTS(rset)
        {
            auto* PItem = new CItemShop(rset->get<uint32>("itemid"));

            PItem->setMinPrice(rset->get<uint32>("min_price"));
            PItem->setMaxPrice(rset->get<uint32>("max_price"));
            PItem->setStackSize(rset->get<uint32>("max_quantity"));
            PItem->setDailyIncrease(rset->get<uint16>("daily_increase"));
            PItem->setInitialQuantity(rset->get<uint16>("initial_quantity"));
            PItem->setFlag(rset->get<uint16>("flags"));

            PItem->setQuantity(PItem->IsDailyIncrease() ? PItem->getInitialQuantity() : 0);
            PItem->setBasePrice(getItemDynamicBasePrice(PItem));

            PGuildShop->InsertItem(PItem);
        }
    }

    UpdateGuildPointsPattern();
}

void Cleanup()
{
    // Delete pointers and cleanup vectors manually
    for (auto guild : g_PGuildList)
    {
        destroy(guild);
    }

    g_PGuildList.clear();

    for (auto itemContainer : g_PGuildShopList)
    {
        destroy(itemContainer);
    }

    g_PGuildShopList.clear();
}

void UpdateGuildsStock()
{
    for (const auto* PGuildShop : g_PGuildShopList)
    {
        for (uint8 slotid = 1; slotid <= PGuildShop->GetSize(); ++slotid)
        {
            if (auto* PItem = static_cast<CItemShop*>(PGuildShop->GetItem(slotid)))
            {
                PItem->setBasePrice(getItemDynamicBasePrice(PItem));

                if (PItem->IsDailyIncrease())
                {
                    PItem->setQuantity(PItem->getQuantity() + PItem->getDailyIncrease());
                }
            }
        }
    }

    ShowDebug("UpdateGuildsStock is finished");
}

void UpdateGuildPointsPattern()
{
    // TODO: This function can be faulty when dealing with multiple processes. Needs to be synchronized properly across servers.
    const auto jstDayOfYear = earth_time::jst::get_yearday();
    const bool doUpdate     = serverutils::GetServerVar("[GUILD]pattern_update") != jstDayOfYear;

    uint8 pattern = xirand::GetRandomNumber(8);
    if (doUpdate)
    {
        // write the new pattern and update time to try to prevent other servers from updating the pattern
        serverutils::SetServerVar("[GUILD]pattern_update", jstDayOfYear);
        serverutils::SetServerVar("[GUILD]pattern", pattern);
    }
    else
    {
        // load the pattern in case it was set by another server (and this server did not set it)
        pattern = serverutils::GetServerVar("[GUILD]pattern");
    }

    for (const auto PGuild : g_PGuildList)
    {
        PGuild->updateGuildPointsPattern(pattern);
    }

    ShowDebug("Guild point pattern update has finished. New pattern: %d", pattern);
}

auto GetGuildShop(const uint16 guildShopId) -> CItemContainer*
{
    for (auto* PGuildShop : g_PGuildShopList)
    {
        if (PGuildShop->GetID() == guildShopId)
        {
            return PGuildShop;
        }
    }

    ShowDebug("GuildShop with id <%u> is not found on server", guildShopId);
    return nullptr;
}

auto GetGuild(const uint8 guildId) -> CGuild*
{
    if (guildId < g_PGuildList.size())
    {
        return g_PGuildList.at(guildId);
    }

    ShowDebug("Guild with id <%u> is not found on server", guildId);
    return nullptr;
}

auto getItemDynamicBasePrice(const CItemShop* PItem) -> uint32
{
    // Calculate how much of the stock has been depleted (0.0 = full, 1.0 = empty)
    const float depletionRatio = static_cast<float>(PItem->getStackSize() - PItem->getQuantity()) / PItem->getStackSize();
    // Delta between min and max price
    const uint32 priceRange = PItem->getMaxPrice() - PItem->getMinPrice();

    // Price increases as stock depletes: min price + (depletion * price range)
    return PItem->getMinPrice() + static_cast<uint32>(depletionRatio * priceRange);
}

} // namespace guildutils
