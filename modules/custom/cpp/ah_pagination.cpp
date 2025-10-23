/************************************************************************
 * Auction House Pagination
 *
 * This allows players to list and view more than the client-restricted 7
 * entries. This works by using multiple pages of 6 entries and pages
 * through them every time the player opens their AH listing page.
 ************************************************************************/

#include "map/utils/moduleutils.h"

#include "common/timer.h"

#include "map/enums/chat_message_type.h"
#include "map/packet_system.h"
#include "map/packets/auction_house.h"
#include "map/packets/basic.h"
#include "map/packets/s2c/0x017_chat_std.h"

#include "map/map_session.h"
#include "map/zone.h"

#include <functional>
#include <numeric>

class AHPaginationModule : public CPPModule
{
    void OnInit() override
    {
        TracyZoneScoped;

        const auto originalAHListLimit = settings::get<uint32>("map.AH_LIST_LIMIT");
        if (originalAHListLimit != 0 && originalAHListLimit <= 7)
        {
            ShowWarning("[AH PAGES] AH_LIST_LIMIT is already set to %i. AH_LIST_LIMIT <= 7 is handled by the client. This module isn't required.", originalAHListLimit);
            return;
        }

        totalPages_ = originalAHListLimit == 0 ? 99 : (originalAHListLimit / 6U) + 1;
        ShowInfo("[AH PAGES] AH_LIST_LIMIT is set to %i. Enabling pagination of %i pages with %i items per page.", originalAHListLimit, totalPages_, itemsPerPage_);
    }

    auto OnIncomingPacket(MapSession* session, CCharEntity* PChar, CBasicPacket& packet) -> bool override
    {
        if (packet.getType() != 0x04E)
        {
            return false;
        }

        if (PChar->m_GMlevel == 0 && !PChar->loc.zone->CanUseMisc(MISC_AH))
        {
            ShowWarning("[AH PAGES] %s is trying to use the auction house in a disallowed zone [%s]", PChar->getName(), PChar->loc.zone->getName());
            return true;
        }

        const auto typedPacket = packet.as<GP_CLI_COMMAND_AUC>();

        // Only intercept for action 0x05: Open List Of Sales / Wait
        if (typedPacket->Command != GP_CLI_COMMAND_AUC_COMMAND::Info)
        {
            return false;
        }

        // Rate limit opening the AH Sales Info to once every 1.5 seconds
        const timer::time_point curTick = timer::now();
        if (curTick < PChar->m_AHHistoryTimestamp + 1500ms)
        {
            PChar->pushPacket<CAuctionHousePacket>(typedPacket->Command, 246, 0, 0, 0, 0); // try again in a little while msg
            return true;
        }

        // Not const, because we're going to increment it below
        // This will get wiped on zoning
        auto currentAHPage = PChar->GetLocalVar("AH_PAGE");

        // Will only show the first time you access the AH until you zone again.
        // Since we do rollover of pages inline below.
        // This is also good for performance to not hammer the db completely.
        if (currentAHPage == 0) // Page "1"
        {
            // Get the current number of items the player has for sale
            const auto ahListings = [&]() -> uint32
            {
                const auto rset = db::preparedStmt("SELECT COUNT(*) "
                                                   "FROM auction_house "
                                                   "WHERE seller = ? AND sale = 0",
                                                   PChar->id);
                FOR_DB_SINGLE_RESULT(rset)
                {
                    return rset->get<uint32>(0);
                }

                return 0;
            }();
            PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, MESSAGE_SYSTEM_3, fmt::format("You have {} items listed for sale.", ahListings));
        }

        PChar->SetLocalVar("AH_PAGE", (currentAHPage + 1) % totalPages_);

        PChar->m_ah_history.clear();
        PChar->m_AHHistoryTimestamp = curTick;
        PChar->pushPacket<CAuctionHousePacket>(typedPacket->Command);

        // Not const, because we're possibly going to overwrite it later
        auto rset = db::preparedStmt("SELECT itemid, price, stack "
                                     "FROM auction_house "
                                     "WHERE seller = ? and sale = 0 "
                                     "ORDER BY id ASC "
                                     "LIMIT ? OFFSET ?",
                                     PChar->id, static_cast<uint32>(itemsPerPage_), static_cast<uint32>(currentAHPage * itemsPerPage_));

        // If we get back 0 results, we're at the end of the list. We should redo the query and reset to page 1 (OFFSET 0)
        if (rset && rset->rowsCount() == 0)
        {
            PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, MESSAGE_SYSTEM_3, fmt::format("No results for page: {} of {}.", currentAHPage + 1, totalPages_));

            // Reset to Page 1
            // Overwrite the original rset here
            rset = db::preparedStmt("SELECT itemid, price, stack "
                                    "FROM auction_house "
                                    "WHERE seller = ? and sale = 0 "
                                    "ORDER BY id ASC "
                                    "LIMIT ? OFFSET 0",
                                    PChar->id, static_cast<uint32>(itemsPerPage_));

            // Show Page 1 this time
            currentAHPage = 0;

            // Prepare Page 2 for next load
            PChar->SetLocalVar("AH_PAGE", currentAHPage + 1);
        }

        // TODO: Don't use totalPages_ here, use the actual number of pages of results.
        // Current (10 items): Current page: 2 of 99. Showing 4 items.
        // Desired (10 items): Current page: 2 of 2. Showing 4 items.
        PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, MESSAGE_SYSTEM_3, fmt::format("Current page: {} of {}. Showing {} items.", currentAHPage + 1, totalPages_, rset->rowsCount()));

        FOR_DB_MULTIPLE_RESULTS(rset)
        {
            PChar->m_ah_history.emplace_back(AuctionHistory_t{
                .itemid = rset->get<uint16>("itemid"),
                .stack  = rset->get<uint8>("stack"),
                .price  = rset->get<uint32>("price"),
                .status = 0,
            });
        }

        const auto totalItemsOnAh = PChar->m_ah_history.size();
        for (size_t slot = 0; slot < totalItemsOnAh; slot++)
        {
            PChar->pushPacket<CAuctionHousePacket>(GP_CLI_COMMAND_AUC_COMMAND::LotCancel, static_cast<uint8>(slot), PChar);
        }

        return true;
    }

    // If this is set to 7, the client won't let you put up more than 7 items. So, 6.
    uint8 itemsPerPage_{ 6u };
    uint8 totalPages_{ 1 };
};

REGISTER_CPP_MODULE(AHPaginationModule);
