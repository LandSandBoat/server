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

#include <vector>

#include "../items/item_shop.h"

#include "../guild.h"
#include "../item_container.h"
#include "../map.h"
#include "../vana_time.h"
#include "guildutils.h"
#include "itemutils.h"

// TODO: во время закрытия гильдии всем просматривающим список товаров отправляется пакет 0x86 с информацией о закрытии гильдии

//#define количество обновляемых предметов при restock (в процентах от максимального количества)

/************************************************************************
 *																		*
 *  Список гильдий														*
 *																		*
 ************************************************************************/

std::vector<CGuild*>         g_PGuildList;
std::vector<CItemContainer*> g_PGuildShopList;

/************************************************************************
 *																		*
 *																		*
 *																		*
 ************************************************************************/

namespace guildutils
{
    /************************************************************************
     *																		*
     *  Инициализация гильдий												*
     *																		*
     ************************************************************************/

    void Initialize()
    {
        const char* fmtQuery = "SELECT DISTINCT id, points_name FROM guilds ORDER BY id ASC;";
        if (Sql_Query(SqlHandle, fmtQuery) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            g_PGuildList.reserve((const unsigned int)Sql_NumRows(SqlHandle));

            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                g_PGuildList.push_back(new CGuild(Sql_GetIntData(SqlHandle, 0), (const char*)Sql_GetData(SqlHandle, 1)));
            }
        }
        XI_DEBUG_BREAK_IF(g_PGuildShopList.size() != 0);

        fmtQuery = "SELECT DISTINCT guildid FROM guild_shops ORDER BY guildid ASC LIMIT 256;";

        if (Sql_Query(SqlHandle, fmtQuery) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            g_PGuildShopList.reserve((const unsigned int)Sql_NumRows(SqlHandle));

            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                g_PGuildShopList.push_back(new CItemContainer(Sql_GetIntData(SqlHandle, 0)));
            }
        }
        for (auto* PGuildShop : g_PGuildShopList)
        {
            fmtQuery = "SELECT itemid, min_price, max_price, max_quantity, daily_increase, initial_quantity \
				    FROM guild_shops \
					WHERE guildid = %u \
                    LIMIT %u";

            int32 ret = Sql_Query(SqlHandle, fmtQuery, PGuildShop->GetID(), MAX_CONTAINER_SIZE);

            if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
            {
                PGuildShop->SetSize((uint8)Sql_NumRows(SqlHandle));

                while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    CItemShop* PItem = new CItemShop(Sql_GetIntData(SqlHandle, 0));

                    PItem->setMinPrice(Sql_GetIntData(SqlHandle, 1));
                    PItem->setMaxPrice(Sql_GetIntData(SqlHandle, 2));
                    PItem->setStackSize(Sql_GetIntData(SqlHandle, 3));
                    PItem->setDailyIncrease(Sql_GetIntData(SqlHandle, 4));
                    PItem->setInitialQuantity(Sql_GetIntData(SqlHandle, 5));

                    PItem->setQuantity(PItem->IsDailyIncrease() ? PItem->getInitialQuantity() : 0);
                    PItem->setBasePrice((uint32)(PItem->getMinPrice() + ((float)(PItem->getStackSize() - PItem->getQuantity()) / PItem->getStackSize()) *
                                                                            (PItem->getMaxPrice() - PItem->getMinPrice())));

                    PGuildShop->InsertItem(PItem);
                }
            }
        }

        UpdateGuildPointsPattern();
    }

    /************************************************************************
     *                                                                       *
     *  Обновляем запас гильдий                                              *
     *                                                                       *
     ************************************************************************/

    void UpdateGuildsStock()
    {
        for (auto* PGuildShop : g_PGuildShopList)
        {
            for (uint8 slotid = 1; slotid <= PGuildShop->GetSize(); ++slotid)
            {
                CItemShop* PItem = (CItemShop*)PGuildShop->GetItem(slotid);

                PItem->setBasePrice((uint32)(PItem->getMinPrice() + ((float)(PItem->getStackSize() - PItem->getQuantity()) / PItem->getStackSize()) *
                                                                        (PItem->getMaxPrice() - PItem->getMinPrice())));

                if (PItem->IsDailyIncrease())
                {
                    PItem->setQuantity(PItem->getQuantity() + PItem->getDailyIncrease());
                }
            }
        }
        ShowDebug("UpdateGuildsStock is finished\n");
    }

    void UpdateGuildPointsPattern()
    {
        TracyZoneScoped;
        uint8 pattern = xirand::GetRandomNumber(8);

        const char* query = "SELECT value FROM server_variables WHERE name = '[GUILD]pattern_update';";

        int  ret    = Sql_Query(SqlHandle, query);
        bool update = false;

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 1 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            if (Sql_GetUIntData(SqlHandle, 0) != CVanaTime::getInstance()->getJstYearDay())
            {
                update = true;
            }
        }
        else
        {
            update = true;
        }
        if (update)
        {
            // write the new pattern and update time to prevent other servers from updating the pattern
            Sql_Query(SqlHandle, "REPLACE INTO server_variables (name,value) VALUES('[GUILD]pattern_update', %u), ('[GUILD]pattern', %u);",
                      CVanaTime::getInstance()->getJstYearDay(), pattern);
            Sql_Query(SqlHandle, "DELETE FROM char_vars WHERE varname = '[GUILD]daily_points';");
        }

        // load the pattern in case it was set by another server (and this server did not set it)
        Sql_Query(SqlHandle, "SELECT value FROM server_variables WHERE name = '[GUILD]pattern';");
        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 1 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            pattern = Sql_GetUIntData(SqlHandle, 0);
        }

        for (auto* PGuild : g_PGuildList)
        {
            PGuild->updateGuildPointsPattern(pattern);
        }

        ShowDebug("UpdateGuildPointsPattern is finished. New pattern: %d", pattern);
    }

    /************************************************************************
     *																		*
     *  Получаем указатель на магазин гильдии с указанным ID					*
     *																		*
     ************************************************************************/

    CItemContainer* GetGuildShop(uint16 GuildShopID)
    {
        for (auto* PGuildShop : g_PGuildShopList)
        {
            if (PGuildShop->GetID() == GuildShopID)
            {
                return PGuildShop;
            }
        }
        ShowDebug("GuildShop with id <%u> is not found on server\n", GuildShopID);
        return nullptr;
    }

    CGuild* GetGuild(uint8 GuildID)
    {
        if (GuildID < g_PGuildList.size())
        {
            return g_PGuildList.at(GuildID);
        }
        ShowDebug("Guild with id <%u> is not found on server\n", GuildID);
        return nullptr;
    }

} // namespace guildutils
