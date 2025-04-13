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
#include "map_server.h"
#include "serverutils.h"

// TODO: During the closure of the guild, all viewing products of the goods are sent 0x86 with information about the closure of the guild

std::vector<std::unique_ptr<CGuild>>         g_PGuildList;
std::vector<std::unique_ptr<CItemContainer>> g_PGuildShopList;

namespace guildutils
{
    void Initialize()
    {
        {
            const auto rset = db::preparedStmt("SELECT DISTINCT id, points_name FROM guilds ORDER BY id ASC");
            if (rset && rset->rowsCount())
            {
                g_PGuildList.reserve(rset->rowsCount());
                while (rset->next())
                {
                    const auto id         = rset->get<uint8>("id");
                    const auto pointsName = rset->get<std::string>("points_name");
                    g_PGuildList.emplace_back(std::make_unique<CGuild>(id, pointsName));
                }
            }

            if (g_PGuildShopList.size() != 0)
            {
                ShowWarning("g_PGuildShopList contains information prior to initialization.");
                return;
            }
        }

        {
            const auto rset = db::preparedStmt("SELECT DISTINCT guildid FROM guild_shops ORDER BY guildid ASC LIMIT 256");
            if (rset && rset->rowsCount())
            {
                g_PGuildShopList.reserve(rset->rowsCount());
                while (rset->next())
                {
                    const auto guildid = rset->get<uint16>("guildid");
                    g_PGuildShopList.emplace_back(std::make_unique<CItemContainer>(guildid));
                }
            }
        }

        for (auto& PGuildShop : g_PGuildShopList)
        {
            const auto fmtQuery = "SELECT itemid, min_price, max_price, max_quantity, daily_increase, initial_quantity "
                                  "FROM guild_shops "
                                  "WHERE guildid = ? "
                                  "LIMIT ?";

            const auto rset = db::preparedStmt(fmtQuery, PGuildShop->GetID(), MAX_CONTAINER_SIZE);
            if (rset && rset->rowsCount())
            {
                PGuildShop->SetSize(rset->rowsCount());

                while (rset->next())
                {
                    CItemShop* PItem = new CItemShop(rset->get<uint16>(0));

                    PItem->setMinPrice(rset->get<uint32>(1));
                    PItem->setMaxPrice(rset->get<uint32>(2));
                    PItem->setStackSize(rset->get<uint32>(3));
                    PItem->setDailyIncrease(rset->get<uint16>(4));
                    PItem->setInitialQuantity(rset->get<uint16>(5));

                    PItem->setQuantity(PItem->IsDailyIncrease() ? PItem->getInitialQuantity() : 0);
                    PItem->setBasePrice((uint32)(PItem->getMinPrice() + ((float)(PItem->getStackSize() - PItem->getQuantity()) / PItem->getStackSize()) *
                                                                            (PItem->getMaxPrice() - PItem->getMinPrice())));

                    PGuildShop->InsertItem(PItem);
                }
            }
        }

        UpdateGuildPointsPattern();
    }

    void UpdateGuildsStock()
    {
        for (auto& PGuildShop : g_PGuildShopList)
        {
            for (uint8 slotid = 1; slotid <= PGuildShop->GetSize(); ++slotid)
            {
                CItemShop* PItem = (CItemShop*)PGuildShop->GetItem(slotid);

                if (PItem != nullptr)
                {
                    PItem->setBasePrice((uint32)(PItem->getMinPrice() + ((float)(PItem->getStackSize() - PItem->getQuantity()) / PItem->getStackSize()) *
                                                                            (PItem->getMaxPrice() - PItem->getMinPrice())));

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

        bool doUpdate = static_cast<uint32>(serverutils::GetServerVar("[GUILD]pattern_update")) != CVanaTime::getInstance()->getJstYearDay();

        uint8 pattern = xirand::GetRandomNumber(8);
        if (doUpdate)
        {
            // write the new pattern and update time to try to prevent other servers from updating the pattern
            serverutils::SetServerVar("[GUILD]pattern_update", CVanaTime::getInstance()->getJstYearDay());
            serverutils::SetServerVar("[GUILD]pattern", pattern);
            charutils::ClearCharVarFromAll("[GUILD]daily_points");
        }
        else
        {
            // load the pattern in case it was set by another server (and this server did not set it)
            pattern = serverutils::GetServerVar("[GUILD]pattern");
            charutils::ClearCharVarFromAll("[GUILD]daily_points", true);
        }

        for (auto& PGuild : g_PGuildList)
        {
            PGuild->updateGuildPointsPattern(pattern);
        }

        ShowDebug("Guild point pattern update has finished. New pattern: %d", pattern);
    }

    CItemContainer* GetGuildShop(uint16 GuildShopID)
    {
        for (auto& PGuildShop : g_PGuildShopList)
        {
            if (PGuildShop->GetID() == GuildShopID)
            {
                return PGuildShop.get();
            }
        }
        ShowDebug("GuildShop with id <%u> is not found on server", GuildShopID);
        return nullptr;
    }

    CGuild* GetGuild(uint8 GuildID)
    {
        if (GuildID < g_PGuildList.size())
        {
            return g_PGuildList.at(GuildID).get();
        }
        ShowDebug("Guild with id <%u> is not found on server", GuildID);
        return nullptr;
    }

} // namespace guildutils
