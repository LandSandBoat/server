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
#include <cstring>

#include "../common/mmo.h"
#include "../common/logging.h"
#include "../common/sql.h"

#include <algorithm>

#include "data_loader.h"
#include "search.h"

CDataLoader::CDataLoader()
{
    SqlHandle = Sql_Malloc();

    //  ShowStatus("sqlhandle is allocating\n");
    if (Sql_Connect(SqlHandle, search_config.mysql_login.c_str(), search_config.mysql_password.c_str(), search_config.mysql_host.c_str(),
                    search_config.mysql_port, search_config.mysql_database.c_str()) == SQL_ERROR)
    {
        ShowError("cant connect\n");
    }
}

CDataLoader::~CDataLoader()
{
    Sql_Free(SqlHandle);
}

/************************************************************************
 *                                                                       *
 *  Returns the auction house sale history for a given item.             *
 *                                                                       *
 ************************************************************************/

std::vector<ahHistory*> CDataLoader::GetAHItemHystory(uint16 ItemID, bool stack)
{
    std::vector<ahHistory*> HistoryList;

    const char* fmtQuery = "SELECT sale, sell_date, seller_name, buyer_name "
                           "FROM auction_house "
                           "WHERE itemid = %u AND stack = %u AND buyer_name IS NOT NULL "
                           "ORDER BY sell_date DESC "
                           "LIMIT 10";

    int32 ret = Sql_Query(SqlHandle, fmtQuery, ItemID, stack);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            ahHistory* PAHHistory = new ahHistory;

            PAHHistory->Price = Sql_GetUIntData(SqlHandle, 0);
            PAHHistory->Data  = Sql_GetUIntData(SqlHandle, 1);

            snprintf((char*)PAHHistory->Name1, 15, "%s", Sql_GetData(SqlHandle, 2));
            snprintf((char*)PAHHistory->Name2, 15, "%s", Sql_GetData(SqlHandle, 3));

            HistoryList.push_back(PAHHistory);
        }
        std::reverse(HistoryList.begin(), HistoryList.end());
    }
    return HistoryList;
}

/************************************************************************
 *                                                                       *
 *  The list of items sold in this category                              *
 *                                                                       *
 ************************************************************************/

std::vector<ahItem*> CDataLoader::GetAHItemsToCategory(uint8 AHCategoryID, int8* OrderByString)
{
    ShowDebug("try find category %u\n", AHCategoryID);

    std::vector<ahItem*> ItemList;

    const char* fmtQuery = "SELECT item_basic.itemid, item_basic.stackSize, COUNT(*)-SUM(stack), SUM(stack) "
                           "FROM item_basic "
                           "LEFT JOIN auction_house ON item_basic.itemId = auction_house.itemid AND auction_house.buyer_name IS NULL "
                           "LEFT JOIN item_equipment ON item_basic.itemid = item_equipment.itemid "
                           "LEFT JOIN item_weapon ON item_basic.itemid = item_weapon.itemid "
                           "WHERE aH = %u "
                           "GROUP BY item_basic.itemid "
                           "%s";

    int32 ret = Sql_Query(SqlHandle, fmtQuery, AHCategoryID, OrderByString);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            ahItem* PAHItem = new ahItem;

            PAHItem->ItemID = Sql_GetIntData(SqlHandle, 0);

            PAHItem->SingleAmount = Sql_GetIntData(SqlHandle, 2);
            PAHItem->StackAmount = Sql_GetIntData(SqlHandle, 3);

            if (Sql_GetIntData(SqlHandle, 1) == 1)
            {
                PAHItem->StackAmount = -1;
            }

            ItemList.push_back(PAHItem);
        }
    }
    return ItemList;
}

/************************************************************************
 *                                                                       *
 *  Returns the number of active players in the world.                   *
 *                                                                       *
 ************************************************************************/

uint32 CDataLoader::GetPlayersCount(const search_req& sr)
{
    uint8 jobid = sr.jobid;
    if (jobid > 0 && jobid < 21)
    {
        if (Sql_Query(SqlHandle, "SELECT COUNT(*) FROM accounts_sessions LEFT JOIN char_stats USING (charid) WHERE mjob = %u", jobid) != SQL_ERROR &&
            Sql_NumRows(SqlHandle) != 0)
        {
            if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                return Sql_GetUIntData(SqlHandle, 0);
            }
        }
    }
    else
    {
        if (Sql_Query(SqlHandle, "SELECT COUNT(*) FROM accounts_sessions") != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                return Sql_GetUIntData(SqlHandle, 0);
            }
        }
    }
    return 0;
}

/************************************************************************
 *                                                                       *
 *  Returns the list of characters found in the world that match the     *
 *  search request.                                                      *
 *          Job ID is 0 for none specified.                              *
 ************************************************************************/

std::list<SearchEntity*> CDataLoader::GetPlayersList(search_req sr, int* count)
{
    std::list<SearchEntity*> PlayersList;
    std::string              filterQry;
    if (sr.jobid > 0 && sr.jobid < 21)
    {
        filterQry.append(" AND ");
        filterQry.append(" mjob = ");
        filterQry.append(std::to_string(static_cast<unsigned long long>(sr.jobid)));
    }
    if (sr.zoneid[0] > 0)
    {
        string_t zoneList;
        int      i = 1;
        zoneList.append(std::to_string(static_cast<unsigned long long>(sr.zoneid[0])));
        while (i < 10 && sr.zoneid[i] != 0)
        {
            zoneList.append(", ");
            zoneList.append(std::to_string(static_cast<unsigned long long>(sr.zoneid[i])));
            i++;
        }
        filterQry.append(" AND ");
        filterQry.append("(pos_zone IN (");
        filterQry.append(zoneList);
        filterQry.append(") OR (pos_zone = 0 AND pos_prevzone IN (");
        filterQry.append(zoneList);
        filterQry.append("))) ");
    }

    if (sr.commentType != 0)
    {
        filterQry.append(fmt::sprintf(" AND (seacom_type & 0xF0) = %u", sr.commentType, sr.commentType));
    }

    std::string fmtQuery =
        "SELECT charid, partyid, charname, pos_zone, pos_prevzone, nation, rank_sandoria, rank_bastok, rank_windurst, race, nameflags, mjob, sjob, mlvl, slvl, languages, nnameflags, seacom_type "
        "FROM accounts_sessions "
        "LEFT JOIN accounts_parties USING (charid) "
        "LEFT JOIN chars USING (charid) "
        "LEFT JOIN char_look USING (charid) "
        "LEFT JOIN char_stats USING (charid) "
        "LEFT JOIN char_profile USING(charid) "
        "WHERE charname IS NOT NULL ";
    fmtQuery.append(filterQry);
    fmtQuery.append(" ORDER BY charname ASC");

    int32 ret = Sql_Query(SqlHandle, fmtQuery.c_str());

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        int totalResults   = 0; // gives ALL matching criteria (total)
        int visibleResults = 0; // capped at first 20
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            SearchEntity* PPlayer = new SearchEntity;
            memset(PPlayer, 0, sizeof(SearchEntity));

            memcpy(PPlayer->name, Sql_GetData(SqlHandle, 2), 15);

            PPlayer->id       = (uint32)Sql_GetUIntData(SqlHandle, 0);
            PPlayer->zone     = (uint16)Sql_GetIntData(SqlHandle, 3);
            PPlayer->prevzone = (uint16)Sql_GetIntData(SqlHandle, 4);
            PPlayer->nation   = (uint8)Sql_GetIntData(SqlHandle, 5);
            PPlayer->mjob     = (uint8)Sql_GetIntData(SqlHandle, 11);
            PPlayer->sjob     = (uint8)Sql_GetIntData(SqlHandle, 12);
            PPlayer->mlvl     = (uint8)Sql_GetIntData(SqlHandle, 13);
            PPlayer->slvl     = (uint8)Sql_GetIntData(SqlHandle, 14);
            PPlayer->race     = (uint8)Sql_GetIntData(SqlHandle, 9);
            PPlayer->rank     = (uint8)Sql_GetIntData(SqlHandle, 6 + PPlayer->nation);

            PPlayer->zone = (PPlayer->zone == 0 ? PPlayer->prevzone : PPlayer->zone);
            PPlayer->languages = (uint8)Sql_GetUIntData(SqlHandle, 15);
            PPlayer->mentor = Sql_GetUIntData(SqlHandle, 16) & NFLAG_MENTOR;
            PPlayer->seacom_type = (uint8)Sql_GetUIntData(SqlHandle, 17);

            uint32 partyid  = (uint32)Sql_GetUIntData(SqlHandle, 1);
            uint32 nameflag = (uint32)Sql_GetUIntData(SqlHandle, 10);

            if (PPlayer->mentor)
            {
                PPlayer->flags1 |= 0x0001;
            }
            if (partyid == PPlayer->id)
            {
                PPlayer->flags1 |= 0x0008;
            }
            if (PPlayer->seacom_type)
            {
                PPlayer->flags1 |= 0x0010;
            }
            if (nameflag & FLAG_AWAY)
            {
                PPlayer->flags1 |= 0x0100;
            }
            if (nameflag & FLAG_DC)
            {
                PPlayer->flags1 |= 0x0800;
            }
            if (partyid != 0)
            {
                PPlayer->flags1 |= 0x2000;
            }
            if (nameflag & FLAG_ANON)
            {
                PPlayer->flags1 |= 0x4000;
            }
            if (nameflag & FLAG_INVITE)
            {
                PPlayer->flags1 |= 0x8000;
            }

            PPlayer->flags2 = PPlayer->flags1;

            // filter by job
            if (sr.jobid > 0 && sr.jobid != PPlayer->mjob)
            {
                continue;
            }

            // filter by nation
            if (sr.nation != 255 && sr.nation != PPlayer->nation)
            {
                continue;
            }

            // filter by race
            if (sr.race != 255)
            {
                // hume (male/female)
                if (sr.race == 0 && (PPlayer->race != 1 && PPlayer->race != 2))
                {
                    continue;
                    // elvaan (male/female)
                }
                if (sr.race == 1 && (PPlayer->race != 3 && PPlayer->race != 4))
                {
                    continue;
                    // tarutaru (male/female)
                }
                if (sr.race == 2 && (PPlayer->race != 5 && PPlayer->race != 6))
                {
                    continue;
                    // mithra (female only)
                }
                else if (sr.race == 3 && PPlayer->race != 7)
                {
                    continue;
                    // galka (male only)
                }
                else if (sr.race == 4 && PPlayer->race != 8)
                {
                    continue;
                }
            }

            // filter by rank
            if (sr.minRank > 0 && sr.maxRank >= sr.minRank)
            {
                if (PPlayer->rank < sr.minRank || PPlayer->rank > sr.maxRank)
                {
                    continue;
                }
            }

            // filter by flag (away, seek party etc.)
            if (sr.flags != 0 && !(PPlayer->flags2 & sr.flags))
            {
                continue;
            }

            // filter by level
            if (sr.minlvl > 0 && sr.maxlvl >= sr.minlvl)
            {
                if (PPlayer->mlvl < sr.minlvl || PPlayer->mlvl > sr.maxlvl)
                {
                    continue;
                }
            }

            // filter by name
            if (sr.nameLen > 0)
            {
                string_t dbname;
                dbname.insert(0, (char*)PPlayer->name);

                // can't be this name, too long
                if (sr.nameLen > dbname.length())
                {
                    continue;
                }
                bool validName = true;
                for (int i = 0; i < sr.nameLen; i++)
                {
                    // convert to lowercase for both
                    if (tolower(sr.name[i]) != tolower(PPlayer->name[i]))
                    {
                        validName = false;
                        break;
                    }
                }
                if (!validName)
                {
                    continue;
                }
            }
            // dont show hidden gm
            if (nameflag & FLAG_ANON && nameflag & FLAG_GM)
            {
                continue;
            }
            if (visibleResults < 20)
            {
                PlayersList.push_back(PPlayer);
                visibleResults++;
            }
            totalResults++;
        }
        if (totalResults > 0)
        {
            *count = totalResults;
        }
        ShowMessage("Found %i results, displaying %i. \n", totalResults, visibleResults);
    }

    return PlayersList;
}

/************************************************************************
 *                                                                       *
 *  Returns the list of characters in a given party/alliance group.      *
 *                                                                       *
 ************************************************************************/

std::list<SearchEntity*> CDataLoader::GetPartyList(uint16 PartyID, uint16 AllianceID)
{
    std::list<SearchEntity*> PartyList;

    const char* Query =
        "SELECT charid, partyid, charname, pos_zone, nation, rank_sandoria, rank_bastok, rank_windurst, race, nameflags, mjob, sjob, mlvl, slvl, languages, nnameflags, seacom_type "
        "FROM accounts_sessions "
        "LEFT JOIN accounts_parties USING(charid) "
        "LEFT JOIN chars USING(charid) "
        "LEFT JOIN char_look USING(charid) "
        "LEFT JOIN char_stats USING(charid) "
        "LEFT JOIN char_profile USING(charid) "
        "WHERE IF (allianceid <> 0, allianceid IN (SELECT allianceid FROM accounts_parties WHERE charid = %u) , partyid = %u) "
        "ORDER BY charname ASC "
        "LIMIT 18";

    int32 ret = Sql_Query(SqlHandle, Query, (!AllianceID ? PartyID : AllianceID), (!PartyID ? AllianceID : PartyID));

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            SearchEntity* PPlayer = new SearchEntity;
            memset(PPlayer, 0, sizeof(SearchEntity));

            memcpy(PPlayer->name, Sql_GetData(SqlHandle, 2), 15);

            PPlayer->id     = (uint32)Sql_GetUIntData(SqlHandle, 0);
            PPlayer->zone   = (uint16)Sql_GetIntData(SqlHandle, 3);
            PPlayer->nation = (uint8)Sql_GetIntData(SqlHandle, 4);
            PPlayer->mjob   = (uint8)Sql_GetIntData(SqlHandle, 10);
            PPlayer->sjob   = (uint8)Sql_GetIntData(SqlHandle, 11);
            PPlayer->mlvl   = (uint8)Sql_GetIntData(SqlHandle, 12);
            PPlayer->slvl   = (uint8)Sql_GetIntData(SqlHandle, 13);
            PPlayer->race   = (uint8)Sql_GetIntData(SqlHandle, 8);
            PPlayer->rank   = (uint8)Sql_GetIntData(SqlHandle, 5 + PPlayer->nation);
            PPlayer->languages = (uint8)Sql_GetUIntData(SqlHandle, 14);
            PPlayer->mentor = Sql_GetUIntData(SqlHandle, 15) & NFLAG_MENTOR;
            PPlayer->seacom_type = (uint8)Sql_GetUIntData(SqlHandle, 16);

            uint32 nameflag = (uint32)Sql_GetUIntData(SqlHandle, 9);

            if (PPlayer->mentor)
            {
                PPlayer->flags1 |= 0x0001;
            }
            if (PartyID == PPlayer->id)
            {
                PPlayer->flags1 |= 0x0008;
            }
            if (PPlayer->seacom_type)
            {
                PPlayer->flags1 |= 0x0010;
            }
            if (nameflag & FLAG_AWAY)
            {
                PPlayer->flags1 |= 0x0100;
            }
            if (nameflag & FLAG_DC)
            {
                PPlayer->flags1 |= 0x0800;
            }
            if (PartyID != 0)
            {
                PPlayer->flags1 |= 0x2000;
            }
            if (nameflag & FLAG_ANON)
            {
                PPlayer->flags1 |= 0x4000;
            }
            if (nameflag & FLAG_INVITE)
            {
                PPlayer->flags1 |= 0x8000;
            }

            PPlayer->flags2 = PPlayer->flags1;

            PartyList.push_back(PPlayer);
        }
    }
    return PartyList;
}

/************************************************************************
 *                                                                       *
 *  Returns the list of characters in a given linkshell.                 *
 *                                                                       *
 ************************************************************************/

std::list<SearchEntity*> CDataLoader::GetLinkshellList(uint32 LinkshellID)
{
    std::list<SearchEntity*> LinkshellList;
    const char* fmtQuery = "SELECT charid, partyid, charname, pos_zone, nation, rank_sandoria, rank_bastok, rank_windurst, race, nameflags, mjob, sjob, "
                           "mlvl, slvl, linkshellid1, linkshellid2, "
                           "linkshellrank1, linkshellrank2 "
                           "FROM accounts_sessions "
                           "LEFT JOIN accounts_parties USING (charid) "
                           "LEFT JOIN chars USING (charid) "
                           "LEFT JOIN char_look USING (charid) "
                           "LEFT JOIN char_stats USING (charid) "
                           "LEFT JOIN char_profile USING(charid) "
                           "WHERE linkshellid1 = %u OR linkshellid2 = %u "
                           "ORDER BY charname ASC "
                           "LIMIT 18";

    int32 ret = Sql_Query(SqlHandle, fmtQuery, LinkshellID, LinkshellID);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            SearchEntity* PPlayer = new SearchEntity;
            memset(PPlayer, 0, sizeof(SearchEntity));

            memcpy(PPlayer->name, Sql_GetData(SqlHandle, 2), 15);

            PPlayer->id             = (uint32)Sql_GetUIntData(SqlHandle, 0);
            PPlayer->zone           = (uint16)Sql_GetIntData(SqlHandle, 3);
            PPlayer->nation         = (uint8)Sql_GetIntData(SqlHandle, 4);
            PPlayer->mjob           = (uint8)Sql_GetIntData(SqlHandle, 10);
            PPlayer->sjob           = (uint8)Sql_GetIntData(SqlHandle, 11);
            PPlayer->mlvl           = (uint8)Sql_GetIntData(SqlHandle, 12);
            PPlayer->slvl           = (uint8)Sql_GetIntData(SqlHandle, 13);
            PPlayer->race           = (uint8)Sql_GetIntData(SqlHandle, 8);
            PPlayer->rank           = (uint8)Sql_GetIntData(SqlHandle, 5 + PPlayer->nation);
            PPlayer->linkshellid1   = Sql_GetIntData(SqlHandle, 14);
            PPlayer->linkshellid2   = Sql_GetIntData(SqlHandle, 15);
            PPlayer->linkshellrank1 = Sql_GetIntData(SqlHandle, 16);
            PPlayer->linkshellrank2 = Sql_GetIntData(SqlHandle, 17);

            uint32 partyid  = (uint32)Sql_GetUIntData(SqlHandle, 1);
            uint32 nameflag = (uint32)Sql_GetUIntData(SqlHandle, 9);

            if (partyid == PPlayer->id)
            {
                PPlayer->flags1 |= 0x0008;
            }
            if (nameflag & FLAG_AWAY)
            {
                PPlayer->flags1 |= 0x0100;
            }
            if (nameflag & FLAG_DC)
            {
                PPlayer->flags1 |= 0x0800;
            }
            if (partyid != 0)
            {
                PPlayer->flags1 |= 0x2000;
            }
            if (nameflag & FLAG_ANON)
            {
                PPlayer->flags1 |= 0x4000;
            }
            if (nameflag & FLAG_INVITE)
            {
                PPlayer->flags1 |= 0x8000;
            }

            PPlayer->flags2 = PPlayer->flags1;

            LinkshellList.push_back(PPlayer);
        }
    }

    return LinkshellList;
}


std::string CDataLoader::GetSearchComment(uint32 playerId)
{
    std::string query = "SELECT seacom_message FROM accounts_sessions WHERE charid = %u";

    int32 ret = Sql_Query(SqlHandle, query.c_str(), playerId);
    if (ret != SQL_SUCCESS || Sql_NumRows(SqlHandle) == 0 || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
    {
        return std::string();
    }

    return std::string((const char*)Sql_GetData(SqlHandle, 0));
}

void CDataLoader::ExpireAHItems()
{
    Sql_t* sqlH2 = Sql_Malloc();
    Sql_Connect(sqlH2, search_config.mysql_login.c_str(), search_config.mysql_password.c_str(), search_config.mysql_host.c_str(), search_config.mysql_port,
                search_config.mysql_database.c_str());

    std::string qStr            = "SELECT T0.id,T0.itemid,T1.stacksize, T0.stack, T0.seller FROM auction_house T0 INNER JOIN item_basic T1 ON \
                            T0.itemid = T1.itemid WHERE datediff(now(),from_unixtime(date)) >=%u AND buyer_name IS NULL;";
    int32       ret             = Sql_Query(SqlHandle, qStr.c_str(), search_config.expire_days);
    int64       expiredAuctions = Sql_NumRows(SqlHandle);
    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            // iterate through the expired auctions and return them to the seller
            uint32 saleID    = (uint32)Sql_GetUIntData(SqlHandle, 0);
            uint32 itemID    = (uint32)Sql_GetUIntData(SqlHandle, 1);
            uint8  itemStack = (uint8)Sql_GetUIntData(SqlHandle, 2);
            uint8  ahStack   = (uint8)Sql_GetUIntData(SqlHandle, 3);
            uint32 seller    = (uint32)Sql_GetUIntData(SqlHandle, 4);
            ret              = Sql_Query(sqlH2,
                            "INSERT INTO delivery_box (charid, charname, box, itemid, itemsubid, quantity, senderid, sender) VALUES "
                            "(%u, (select charname from chars where charid=%u), 1, %u, 0, %u, 0, 'AH-Jeuno');",
                            seller, seller, itemID, ahStack == 1 ? itemStack : 1);
            //      ShowMessage(cC2, seller, seller, itemID);
            if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
            {
                // delete the item from the auction house
                Sql_Query(sqlH2, "DELETE FROM auction_house WHERE id= %u", saleID);
            }
        }
    }
    else if (ret == SQL_ERROR)
    {
        //  ShowMessage(CL_RED"SQL ERROR: %s\n\n", SQL_ERROR);
    }
    ShowMessage("Sent %u expired auction house items back to sellers\n", expiredAuctions);
    Sql_Free(sqlH2);
}
