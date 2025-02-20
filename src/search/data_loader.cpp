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

#include "common/database.h"
#include "common/logging.h"
#include "common/mmo.h"
#include "common/settings.h"
#include "common/sql.h"

#include <algorithm>

#include "data_loader.h"
#include "search.h"

namespace
{
    uint8 JOB_MON = 23;
} // namespace

CDataLoader::CDataLoader()
{
}

CDataLoader::~CDataLoader()
{
}

/************************************************************************
 *                                                                       *
 *  Returns the auction house sale history for a given item.             *
 *                                                                       *
 ************************************************************************/

std::vector<ahHistory*> CDataLoader::GetAHItemHistory(uint16 ItemID, bool stack)
{
    std::vector<ahHistory*> HistoryList;

    auto rset = db::preparedStmt("SELECT sale, sell_date, seller_name, buyer_name "
                                 "FROM auction_house "
                                 "WHERE itemid = ? AND stack = ? AND buyer_name IS NOT NULL "
                                 "ORDER BY sell_date DESC "
                                 "LIMIT 10",
                                 ItemID, stack);

    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            ahHistory* PAHHistory = new ahHistory;

            PAHHistory->Price = rset->get<uint32>("sale");
            PAHHistory->Data  = rset->get<uint32>("sell_date");

            PAHHistory->Name1 = rset->get<std::string>("seller_name");
            PAHHistory->Name2 = rset->get<std::string>("buyer_name");

            HistoryList.emplace_back(PAHHistory);
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

std::vector<ahItem*> CDataLoader::GetAHItemsToCategory(uint8 ahCategoryID, const std::string& orderByString)
{
    ShowDebug("Try find category: %u", ahCategoryID);

    std::vector<ahItem*> ItemList;

    const auto rset = [&]()
    {
        const auto subQuery = "(SELECT item_basic.* "
                              "FROM item_basic "
                              "INNER JOIN auction_house_items ON item_basic.itemid = auction_house_items.itemid"
                              ") AS item_basic ";

        const auto fromTable = settings::get<bool>("search.OMIT_NO_HISTORY") ? subQuery : "item_basic";

        // Build the query string with optional subquery and order-by statements before passing it to the prepared statement.
        const auto queryStr = fmt::format("SELECT item_basic.itemid, item_basic.stackSize, COUNT(*)-SUM(stack), SUM(stack) "
                                          "FROM {} "
                                          "LEFT JOIN auction_house ON item_basic.itemId = auction_house.itemid AND auction_house.buyer_name IS NULL "
                                          "LEFT JOIN item_equipment ON item_basic.itemid = item_equipment.itemid "
                                          "LEFT JOIN item_weapon ON item_basic.itemid = item_weapon.itemid "
                                          "WHERE aH = ? "
                                          "GROUP BY item_basic.itemid "
                                          "{}",
                                          fromTable, orderByString);

        // We will now populate the ? in the prepared statement.
        return db::preparedStmt(queryStr, ahCategoryID);
    }();

    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            ahItem* PAHItem = new ahItem;

            PAHItem->ItemID = rset->get<uint16>("itemid");

            PAHItem->SingleAmount = rset->getOrDefault<uint32>("COUNT(*)-SUM(stack)", 0);
            PAHItem->StackAmount  = rset->getOrDefault<uint32>("SUM(stack)", 0);
            PAHItem->Category     = ahCategoryID;

            if (rset->get<uint32>("stackSize") == 1)
            {
                PAHItem->StackAmount = -1;
            }

            ItemList.emplace_back(PAHItem);
        }
    }

    return ItemList;
}

// Return single item including category and how many are listed
ahItem CDataLoader::GetAHItemFromItemID(uint16 ItemID)
{
    ahItem CAHItem       = {};
    CAHItem.ItemID       = ItemID;
    CAHItem.Category     = 0;
    CAHItem.SingleAmount = 0;
    CAHItem.StackAmount  = 0;

    auto rset = db::preparedStmt("SELECT aH, COUNT(*)-SUM(stack), SUM(stack) "
                                 "FROM item_basic "
                                 "LEFT JOIN auction_house ON item_basic.itemId = auction_house.itemid AND auction_house.buyer_name IS NULL "
                                 "LEFT JOIN item_equipment ON item_basic.itemid = item_equipment.itemid "
                                 "LEFT JOIN item_weapon ON item_basic.itemid = item_weapon.itemid "
                                 "WHERE item_basic.itemid = ?",
                                 ItemID);
    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            CAHItem.Category     = rset->get<uint16>("aH");
            CAHItem.SingleAmount = rset->getOrDefault<uint32>("COUNT(*)-SUM(stack)", 0);
            CAHItem.StackAmount  = rset->getOrDefault<uint32>("SUM(stack)", 0);

            if (rset->getOrDefault<uint32>("COUNT(*)-SUM(stack)", 0) == 1)
            {
                CAHItem.StackAmount = 0;
            }
        }
    }
    return CAHItem;
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
        auto rset = db::preparedStmt("SELECT COUNT(*) FROM accounts_sessions LEFT JOIN char_stats USING (charid) WHERE mjob = ?", jobid);
        if (rset && rset->rowsCount() && rset->next())
        {
            return rset->get<uint32>("COUNT(*)");
        }
    }
    else
    {
        auto rset = db::preparedStmt("SELECT COUNT(*) FROM accounts_sessions");
        if (rset && rset->rowsCount() && rset->next())
        {
            return rset->get<uint32>("COUNT(*)");
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
        std::string zoneList;
        int         i = 1;
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
        filterQry.append(fmt::sprintf(" AND (seacom_type & 0xF0) = %u", sr.commentType));
    }

    std::string fmtQuery =
        "SELECT charid, partyid, charname, pos_zone, pos_prevzone, nation, rank_sandoria, rank_bastok, "
        "rank_windurst, race, mjob, sjob, mlvl, slvl, languages, settings, seacom_type, disconnecting, gmHiddenEnabled "
        "FROM accounts_sessions "
        "LEFT JOIN accounts_parties USING (charid) "
        "LEFT JOIN chars USING (charid) "
        "LEFT JOIN char_look USING (charid) "
        "LEFT JOIN char_stats USING (charid) "
        "LEFT JOIN char_profile USING(charid) "
        "LEFT JOIN char_flags USING(charid) "
        "WHERE charname IS NOT NULL ";

    fmtQuery.append(filterQry);
    fmtQuery.append(" ORDER BY charname ASC");

    auto rset = db::preparedStmt(fmtQuery);
    if (rset && rset->rowsCount())
    {
        int totalResults   = 0; // gives ALL matching criteria (total)
        int visibleResults = 0; // capped at first 20
        while (rset->next())
        {
            SearchEntity* PPlayer = new SearchEntity();

            PPlayer->name = rset->get<std::string>("charname");

            PPlayer->id       = rset->get<uint32>("charid");
            PPlayer->zone     = rset->get<uint16>("pos_zone");
            PPlayer->prevzone = rset->get<uint16>("pos_prevzone");
            PPlayer->nation   = rset->get<uint8>("nation");
            PPlayer->mjob     = rset->get<uint8>("mjob");
            PPlayer->sjob     = rset->get<uint8>("sjob");
            PPlayer->mlvl     = rset->get<uint8>("mlvl");
            PPlayer->slvl     = rset->get<uint8>("slvl");
            PPlayer->race     = rset->get<uint8>("race");

            // TODO: Use a nation enum?
            switch (PPlayer->nation)
            {
                case 0:
                    PPlayer->rank = rset->get<uint8>("rank_sandoria");
                    break;
                case 1:
                    PPlayer->rank = rset->get<uint8>("rank_bastok");
                    break;
                case 2:
                    PPlayer->rank = rset->get<uint8>("rank_windurst");
                    break;
                default:
                    ShowWarning("Inconsistent player nation allegiance : %d", PPlayer->nation);
                    PPlayer->rank = static_cast<uint8>(0U);
                    break;
            }

            uint32    settingsInt    = rset->get<uint32>("settings");
            SAVE_CONF playerSettings = {};
            std::memcpy(&playerSettings, &settingsInt, sizeof(uint32));

            PPlayer->zone          = (PPlayer->zone == 0 ? PPlayer->prevzone : PPlayer->zone);
            PPlayer->languages     = rset->get<uint8>("languages");
            PPlayer->mentor        = playerSettings.MentorFlg;
            PPlayer->seacom_type   = rset->get<uint8>("seacom_type");
            PPlayer->disconnecting = rset->get<bool>("disconnecting");
            PPlayer->gmHidden      = rset->get<bool>("gmHiddenEnabled");

            const auto partyid = rset->getOrDefault<uint32>("partyid", 0);

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

            if (playerSettings.AwayFlg)
            {
                PPlayer->flags1 |= 0x0100;
            }

            if (PPlayer->disconnecting)
            {
                PPlayer->flags1 |= 0x0800;
            }

            if (partyid != 0)
            {
                PPlayer->flags1 |= 0x2000;
            }

            if (playerSettings.AnonymityFlg)
            {
                PPlayer->flags1 |= 0x4000;
            }

            if (playerSettings.InviteFlg)
            {
                PPlayer->flags1 |= 0x8000;
            }

            PPlayer->flags2 = PPlayer->flags1;

            if (PPlayer->mjob == JOB_MON || PPlayer->sjob == JOB_MON)
            {
                PPlayer->mjob = 0;
                PPlayer->sjob = 0;
            }

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
                std::string dbname;
                dbname.insert(0, PPlayer->name);

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

            if (PPlayer->gmHidden)
            {
                continue;
            }

            if (visibleResults < 40)
            {
                PlayersList.emplace_back(PPlayer);
                visibleResults++;
            }
            totalResults++;
        }
        if (totalResults > 0)
        {
            *count = totalResults;
        }
        ShowInfo("Found %i results, displaying %i", totalResults, visibleResults);
    }

    return PlayersList;
}

/************************************************************************
 *                                                                       *
 *  Returns the list of characters in a given party/alliance group.      *
 *                                                                       *
 ************************************************************************/

std::list<SearchEntity*> CDataLoader::GetPartyList(uint32 PartyID, uint32 AllianceID)
{
    std::list<SearchEntity*> PartyList;

    auto rset = db::preparedStmt("SELECT charid, partyid, charname, pos_zone, nation, rank_sandoria, rank_bastok, rank_windurst, race, settings, mjob, sjob, mlvl, slvl, languages, seacom_type, disconnecting "
                                 "FROM accounts_sessions "
                                 "LEFT JOIN accounts_parties USING(charid) "
                                 "LEFT JOIN chars USING(charid) "
                                 "LEFT JOIN char_look USING(charid) "
                                 "LEFT JOIN char_stats USING(charid) "
                                 "LEFT JOIN char_profile USING(charid) "
                                 "LEFT JOIN char_flags USING(charid) "
                                 "WHERE IF (allianceid <> 0, allianceid IN (SELECT allianceid FROM accounts_parties WHERE charid = ?) , partyid = ?) "
                                 "ORDER BY charname ASC "
                                 "LIMIT 64",
                                 (!AllianceID ? PartyID : AllianceID), (!PartyID ? AllianceID : PartyID));
    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            SearchEntity* PPlayer = new SearchEntity();

            PPlayer->name   = rset->get<std::string>("charname");
            PPlayer->id     = rset->get<uint32>("charid");
            PPlayer->zone   = rset->get<uint16>("pos_zone");
            PPlayer->nation = rset->get<uint8>("nation");
            PPlayer->mjob   = rset->get<uint8>("mjob");
            PPlayer->sjob   = rset->get<uint8>("sjob");
            PPlayer->mlvl   = rset->get<uint8>("mlvl");
            PPlayer->slvl   = rset->get<uint8>("slvl");
            PPlayer->race   = rset->get<uint8>("race");

            // TODO: Use a nation enum?
            switch (PPlayer->nation)
            {
                case 0:
                    PPlayer->rank = rset->get<uint8>("rank_sandoria");
                    break;
                case 1:
                    PPlayer->rank = rset->get<uint8>("rank_bastok");
                    break;
                case 2:
                    PPlayer->rank = rset->get<uint8>("rank_windurst");
                    break;
                default:
                    ShowWarning("Inconsistent player nation allegiance : %d", PPlayer->nation);
                    PPlayer->rank = static_cast<uint8>(0U);
                    break;
            }

            uint32    settingsInt    = rset->get<uint32>("settings");
            SAVE_CONF playerSettings = {};
            std::memcpy(&playerSettings, &settingsInt, sizeof(uint32));

            PPlayer->languages     = rset->get<uint8>("languages");
            PPlayer->mentor        = playerSettings.MentorFlg;
            PPlayer->seacom_type   = rset->get<uint8>("seacom_type");
            PPlayer->disconnecting = rset->get<bool>("disconnecting");

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
            if (playerSettings.AwayFlg)
            {
                PPlayer->flags1 |= 0x0100;
            }
            if (PPlayer->disconnecting)
            {
                PPlayer->flags1 |= 0x0800;
            }
            if (PartyID != 0)
            {
                PPlayer->flags1 |= 0x2000;
            }
            if (playerSettings.AnonymityFlg)
            {
                PPlayer->flags1 |= 0x4000;
            }
            if (playerSettings.InviteFlg)
            {
                PPlayer->flags1 |= 0x8000;
            }

            PPlayer->flags2 = PPlayer->flags1;

            PartyList.emplace_back(PPlayer);
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

    auto rset = db::preparedStmt("SELECT charid, partyid, charname, pos_zone, nation, rank_sandoria, rank_bastok, rank_windurst, race, settings, mjob, sjob, "
                                 "mlvl, slvl, linkshellid1, linkshellid2, "
                                 "linkshellrank1, linkshellrank2, disconnecting "
                                 "FROM accounts_sessions "
                                 "LEFT JOIN accounts_parties USING (charid) "
                                 "LEFT JOIN chars USING (charid) "
                                 "LEFT JOIN char_look USING (charid) "
                                 "LEFT JOIN char_stats USING (charid) "
                                 "LEFT JOIN char_profile USING(charid) "
                                 "LEFT JOIN char_flags USING(charid) "
                                 "WHERE linkshellid1 = ? OR linkshellid2 = ? "
                                 "ORDER BY charname ASC "
                                 "LIMIT 18",
                                 LinkshellID, LinkshellID);
    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            SearchEntity* PPlayer = new SearchEntity();

            PPlayer->name   = rset->get<std::string>("charname");
            PPlayer->id     = rset->get<uint32>("charid");
            PPlayer->zone   = rset->get<uint16>("pos_zone");
            PPlayer->nation = rset->get<uint8>("nation");
            PPlayer->mjob   = rset->get<uint8>("mjob");
            PPlayer->sjob   = rset->get<uint8>("sjob");
            PPlayer->mlvl   = rset->get<uint8>("mlvl");
            PPlayer->slvl   = rset->get<uint8>("slvl");
            PPlayer->race   = rset->get<uint8>("race");

            // TODO: Use a nation enum?
            switch (PPlayer->nation)
            {
                case 0:
                    PPlayer->rank = rset->get<uint8>("rank_sandoria");
                    break;
                case 1:
                    PPlayer->rank = rset->get<uint8>("rank_bastok");
                    break;
                case 2:
                    PPlayer->rank = rset->get<uint8>("rank_windurst");
                    break;
                default:
                    ShowWarning("Inconsistent player nation allegiance : %d", PPlayer->nation);
                    PPlayer->rank = (uint8)0;
                    break;
            }

            PPlayer->linkshellid1   = rset->get<uint32>("linkshellid1");
            PPlayer->linkshellid2   = rset->get<uint32>("linkshellid2");
            PPlayer->linkshellrank1 = rset->get<uint8>("linkshellrank1");
            PPlayer->linkshellrank2 = rset->get<uint8>("linkshellrank2");
            PPlayer->disconnecting  = rset->get<bool>("disconnecting");

            const auto partyid = rset->getOrDefault<uint32>("partyid", 0);

            uint32    settingsInt    = rset->get<uint32>("settings");
            SAVE_CONF playerSettings = {};
            std::memcpy(&playerSettings, &settingsInt, sizeof(uint32));

            if (partyid == PPlayer->id)
            {
                PPlayer->flags1 |= 0x0008;
            }
            if (playerSettings.AwayFlg)
            {
                PPlayer->flags1 |= 0x0100;
            }

            if (PPlayer->disconnecting)
            {
                PPlayer->flags1 |= 0x0800;
            }

            if (partyid != 0)
            {
                PPlayer->flags1 |= 0x2000;
            }
            if (playerSettings.AnonymityFlg)
            {
                PPlayer->flags1 |= 0x4000;
            }
            if (playerSettings.InviteFlg)
            {
                PPlayer->flags1 |= 0x8000;
            }

            PPlayer->flags2 = PPlayer->flags1;

            LinkshellList.emplace_back(PPlayer);
        }
    }

    return LinkshellList;
}

std::string CDataLoader::GetSearchComment(uint32 playerId)
{
    auto rset = db::preparedStmt("SELECT seacom_message FROM accounts_sessions WHERE charid = (?)", playerId);
    if (rset && rset->rowsCount() && rset->next())
    {
        return rset->get<std::string>("seacom_message").c_str();
    }
    return std::string();
}

struct ListingToExpire
{
    uint32      saleID     = 0;
    uint32      itemID     = 0;
    uint8       itemStack  = 0;
    uint8       ahStack    = 0;
    uint32      sellerID   = 0;
    std::string sellerName = "?";
};

void CDataLoader::ExpireAHItems(uint16 expireAgeInDays)
{
    ShowInfo(fmt::format("Expiring auction house listings over {} days old", expireAgeInDays).c_str());

    std::vector<ListingToExpire> listingsToExpire;

    const auto rset0 = db::preparedStmt("SELECT T0.id,T0.itemid,T1.stacksize, T0.stack, T0.seller FROM auction_house T0 INNER JOIN item_basic T1 ON "
                                        "T0.itemid = T1.itemid WHERE datediff(now(),from_unixtime(date)) >= ? AND buyer_name IS NULL",
                                        expireAgeInDays);

    const auto expiredAuctions = rset0->rowsCount();

    if (rset0 && expiredAuctions > 0)
    {
        while (rset0->next())
        {
            // Collect the items we're going to expire
            uint32 saleID    = rset0->get<uint32>("id");
            uint32 itemID    = rset0->get<uint32>("itemid");
            uint8  itemStack = rset0->get<uint8>("stacksize");
            uint8  ahStack   = rset0->get<uint8>("stack");
            uint32 sellerID  = rset0->get<uint32>("seller");
            // NOTE: seller name left out for now, we'll populate this later

            listingsToExpire.emplace_back(ListingToExpire{ saleID, itemID, itemStack, ahStack, sellerID, "?" });
        }

        for (auto listing : listingsToExpire)
        {
            // Populate name now
            const auto rset1 = db::preparedStmt("SELECT charname FROM chars WHERE charid = ?", listing.sellerID);
            if (rset1 && rset1->rowsCount() && rset1->next())
            {
                listing.sellerName = rset1->get<std::string>("charname");
            }

            const auto [rset2, affectedRows] = db::preparedStmtWithAffectedRows("INSERT INTO delivery_box (charid, charname, box, itemid, itemsubid, quantity, senderid, sender) VALUES "
                                                                                "(?, ?, 1, ?, 0, ?, 0, 'AH-Jeuno')",
                                                                                listing.sellerID, listing.sellerName, listing.itemID, listing.ahStack == 1 ? listing.itemStack : 1);
            if (rset2 && affectedRows > 0)
            {
                // delete the item from the auction house
                db::preparedStmt("DELETE FROM auction_house WHERE id = ?", listing.saleID);
            }
        }
    }
    ShowInfo("Sent %u expired auction house listings back to sellers", expiredAuctions);
}
