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

    const char* fmtQuery = "SELECT sale, sell_date, seller_name, buyer_name "
                           "FROM auction_house "
                           "WHERE itemid = %u AND stack = %u AND buyer_name IS NOT NULL "
                           "ORDER BY sell_date DESC "
                           "LIMIT 10";

    auto rset = db::query(fmt::sprintf(fmtQuery, ItemID, stack));

    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            ahHistory* PAHHistory = new ahHistory;

            PAHHistory->Price = rset->getUInt("sale");
            PAHHistory->Data  = rset->getUInt("sell_date");

            PAHHistory->Name1 = rset->getString("seller_name");
            PAHHistory->Name2 = rset->getString("buyer_name");

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

std::vector<ahItem*> CDataLoader::GetAHItemsToCategory(uint8 AHCategoryID, const char* OrderByString)
{
    ShowDebug("try find category %u", AHCategoryID);

    std::vector<ahItem*> ItemList;
    const char*          selectFrom = "item_basic";
    if (settings::get<bool>("search.OMIT_NO_HISTORY"))
    {
        // Get items that have been listed before
        selectFrom = "(SELECT item_basic.* "
                     "FROM item_basic "
                     "INNER JOIN auction_house_items ON item_basic.itemid = auction_house_items.itemid"
                     ") AS item_basic";
    }

    auto fmtQuery = fmt::sprintf("SELECT item_basic.itemid, item_basic.stackSize, COUNT(*)-SUM(stack), SUM(stack) "
                                 "FROM %s "
                                 "LEFT JOIN auction_house ON item_basic.itemId = auction_house.itemid AND auction_house.buyer_name IS NULL "
                                 "LEFT JOIN item_equipment ON item_basic.itemid = item_equipment.itemid "
                                 "LEFT JOIN item_weapon ON item_basic.itemid = item_weapon.itemid "
                                 "WHERE aH = %u "
                                 "GROUP BY item_basic.itemid "
                                 "%s",
                                 selectFrom, AHCategoryID, OrderByString);

    auto rset = db::query(fmtQuery);
    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            ahItem* PAHItem = new ahItem;

            PAHItem->ItemID = rset->getInt("itemid");

            PAHItem->SingleAmount = rset->getInt("COUNT(*)-SUM(stack)");
            PAHItem->StackAmount  = rset->getInt("SUM(stack)");
            PAHItem->Category     = AHCategoryID;

            if (rset->getInt("stackSize") == 1)
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

    const char* fmtQuery = "SELECT aH, COUNT(*)-SUM(stack), SUM(stack) "
                           "FROM item_basic "
                           "LEFT JOIN auction_house ON item_basic.itemId = auction_house.itemid AND auction_house.buyer_name IS NULL "
                           "LEFT JOIN item_equipment ON item_basic.itemid = item_equipment.itemid "
                           "LEFT JOIN item_weapon ON item_basic.itemid = item_weapon.itemid "
                           "WHERE item_basic.itemid = %u";

    auto rset = db::query(fmt::sprintf(fmtQuery, ItemID));
    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            CAHItem.Category     = rset->getInt("aH");
            CAHItem.SingleAmount = rset->getInt("COUNT(*)-SUM(stack)");
            CAHItem.StackAmount  = rset->getInt("SUM(stack)");

            if (rset->getInt("COUNT(*)-SUM(stack)") == 1)
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
        auto rset = db::query(fmt::sprintf("SELECT COUNT(*) FROM accounts_sessions LEFT JOIN char_stats USING (charid) WHERE mjob = %u", jobid));
        if (rset && rset->rowsCount() && rset->next())
        {
            return rset->getUInt("COUNT(*)");
        }
    }
    else
    {
        auto rset = db::query("SELECT COUNT(*) FROM accounts_sessions");
        if (rset && rset->rowsCount() && rset->next())
        {
            return rset->getUInt("COUNT(*)");
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
        filterQry.append(fmt::sprintf(" AND (seacom_type & 0xF0) = %u", sr.commentType, sr.commentType));
    }

    std::string fmtQuery =
        "SELECT charid, partyid, charname, pos_zone, pos_prevzone, nation, rank_sandoria, rank_bastok, "
        "rank_windurst, race, nameflags, mjob, sjob, mlvl, slvl, languages, nnameflags, seacom_type "
        "FROM accounts_sessions "
        "LEFT JOIN accounts_parties USING (charid) "
        "LEFT JOIN chars USING (charid) "
        "LEFT JOIN char_look USING (charid) "
        "LEFT JOIN char_stats USING (charid) "
        "LEFT JOIN char_profile USING(charid) "
        "WHERE charname IS NOT NULL ";

    fmtQuery.append(filterQry);
    fmtQuery.append(" ORDER BY charname ASC");

    auto rset = db::query(fmtQuery);
    if (rset && rset->rowsCount())
    {
        int totalResults   = 0; // gives ALL matching criteria (total)
        int visibleResults = 0; // capped at first 20
        while (rset->next())
        {
            SearchEntity* PPlayer = new SearchEntity();

            PPlayer->name = rset->getString("charname");

            PPlayer->id       = rset->getUInt("charid");
            PPlayer->zone     = (uint16)rset->getInt("pos_zone");
            PPlayer->prevzone = (uint16)rset->getInt("pos_prevzone");
            PPlayer->nation   = (uint8)rset->getInt("nation");
            PPlayer->mjob     = (uint8)rset->getInt("mjob");
            PPlayer->sjob     = (uint8)rset->getInt("sjob");
            PPlayer->mlvl     = (uint8)rset->getInt("mlvl");
            PPlayer->slvl     = (uint8)rset->getInt("slvl");
            PPlayer->race     = (uint8)rset->getInt("race");
            PPlayer->rank     = (uint8)rset->getInt(5 + PPlayer->nation);

            PPlayer->zone        = (PPlayer->zone == 0 ? PPlayer->prevzone : PPlayer->zone);
            PPlayer->languages   = (uint8)rset->getUInt("languages");
            PPlayer->mentor      = rset->getUInt("nnameflags") & NFLAG_MENTOR;
            PPlayer->seacom_type = (uint8)rset->getUInt("seacom_type");

            uint32 partyid  = rset->getUInt("partyid");
            uint32 nameflag = rset->getUInt("nameflags");

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
            // dont show hidden gm
            if (nameflag & FLAG_ANON && nameflag & FLAG_GM)
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

    const char* query =
        "SELECT charid, partyid, charname, pos_zone, nation, rank_sandoria, rank_bastok, rank_windurst, race, nameflags, mjob, sjob, mlvl, slvl, languages, nnameflags, seacom_type "
        "FROM accounts_sessions "
        "LEFT JOIN accounts_parties USING(charid) "
        "LEFT JOIN chars USING(charid) "
        "LEFT JOIN char_look USING(charid) "
        "LEFT JOIN char_stats USING(charid) "
        "LEFT JOIN char_profile USING(charid) "
        "WHERE IF (allianceid <> 0, allianceid IN (SELECT allianceid FROM accounts_parties WHERE charid = %u) , partyid = %u) "
        "ORDER BY charname ASC "
        "LIMIT 64";

    auto rset = db::query(fmt::sprintf(query, (!AllianceID ? PartyID : AllianceID), (!PartyID ? AllianceID : PartyID)));
    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            SearchEntity* PPlayer = new SearchEntity();

            PPlayer->name        = rset->getString("charname");
            PPlayer->id          = rset->getUInt("charid");
            PPlayer->zone        = (uint16)rset->getInt("pos_zone");
            PPlayer->nation      = (uint8)rset->getInt("nation");
            PPlayer->mjob        = (uint8)rset->getInt("mjob");
            PPlayer->sjob        = (uint8)rset->getInt("sjob");
            PPlayer->mlvl        = (uint8)rset->getInt("mlvl");
            PPlayer->slvl        = (uint8)rset->getInt("slvl");
            PPlayer->race        = (uint8)rset->getInt("race");
            PPlayer->rank        = (uint8)rset->getInt(5 + PPlayer->nation);
            PPlayer->languages   = (uint8)rset->getUInt("languages");
            PPlayer->mentor      = rset->getUInt("nnameflags") & NFLAG_MENTOR;
            PPlayer->seacom_type = (uint8)rset->getUInt("seacom_type");

            uint32 nameflag = rset->getUInt("nameflags");

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
    const char*              fmtQuery = "SELECT charid, partyid, charname, pos_zone, nation, rank_sandoria, rank_bastok, rank_windurst, race, nameflags, mjob, sjob, "
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

    auto rset = db::query(fmt::sprintf(fmtQuery, LinkshellID, LinkshellID));
    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            SearchEntity* PPlayer = new SearchEntity();

            PPlayer->name           = rset->getString("charname");
            PPlayer->id             = rset->getUInt("charid");
            PPlayer->zone           = (uint16)rset->getInt("pos_zone");
            PPlayer->nation         = (uint8)rset->getInt("nation");
            PPlayer->mjob           = (uint8)rset->getInt("mjob");
            PPlayer->sjob           = (uint8)rset->getInt("sjob");
            PPlayer->mlvl           = (uint8)rset->getInt("mlvl");
            PPlayer->slvl           = (uint8)rset->getInt("slvl");
            PPlayer->race           = (uint8)rset->getInt("race");
            PPlayer->rank           = (uint8)rset->getInt(6 + PPlayer->nation);
            PPlayer->linkshellid1   = rset->getInt("linkshellid1");
            PPlayer->linkshellid2   = rset->getInt("linkshellid2");
            PPlayer->linkshellrank1 = rset->getInt("linkshellrank1");
            PPlayer->linkshellrank2 = rset->getInt("linkshellrank1");

            uint32 partyid  = rset->getUInt("partyid");
            uint32 nameflag = rset->getUInt("nameflags");

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

            LinkshellList.emplace_back(PPlayer);
        }
    }

    return LinkshellList;
}

std::string CDataLoader::GetSearchComment(uint32 playerId)
{
    auto rset = db::preparedStmt(PreparedStatement::Search_GetSearchComment, playerId);
    if (rset && rset->rowsCount() && rset->next())
    {
        return rset->getString("seacom_message").c_str();
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

    std::string qStr = "SELECT T0.id, T0.itemid, T1.stacksize, T0.stack, T0.seller FROM auction_house T0 INNER JOIN item_basic T1 ON \
                            T0.itemid = T1.itemid WHERE datediff(now(),from_unixtime(date)) >= %u AND buyer_name IS NULL;";

    auto rset = db::query(fmt::sprintf(qStr, expireAgeInDays));
    if (!rset)
    {
        return;
    }

    int64 expiredAuctions = rset->rowsCount();
    if (expiredAuctions > 0)
    {
        while (rset->next())
        {
            // Collect the items we're going to expire
            uint32 saleID    = rset->getUInt("id");
            uint32 itemID    = rset->getUInt("itemid");
            uint8  itemStack = (uint8)rset->getUInt("stacksize");
            uint8  ahStack   = (uint8)rset->getUInt("stack");
            uint32 sellerID  = rset->getUInt("seller");
            // NOTE: seller name left out for now, we'll populate this later

            listingsToExpire.emplace_back(ListingToExpire{ saleID, itemID, itemStack, ahStack, sellerID, "?" });
        }

        for (auto listing : listingsToExpire)
        {
            {
                // Populate name now
                auto query = fmt::format("SELECT charname FROM chars WHERE charid={}", listing.sellerID);
                auto rset2 = db::query(query);
                if (rset2 && rset2->rowsCount() && rset2->next())
                {
                    listing.sellerName = rset2->getString("charname");
                }
            }

            {
                auto query = fmt::format("INSERT INTO delivery_box (charid, charname, box, itemid, itemsubid, quantity, senderid, sender) VALUES "
                                         "({}, '{}', 1, {}, 0, {}, 0, 'AH-Jeuno');",
                                         listing.sellerID, listing.sellerName, listing.itemID, listing.ahStack == 1 ? listing.itemStack : 1);

                auto rset3 = db::query(query);
                if (rset3 && rset3->rowInserted())
                {
                    // TODO: Is this still correct?
                    if (!db::query(fmt::sprintf("DELETE FROM auction_house WHERE id=%u", listing.saleID)))
                    {
                        ShowError(fmt::format("Failed to delete expired auction house listing for item {} by {} (listing: {})",
                                              listing.itemID, listing.sellerName, listing.saleID));
                    }
                }
            }
        }
    }
    ShowInfo("Sent %u expired auction house listings back to sellers", expiredAuctions);
}
