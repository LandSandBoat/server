/************************************************************************
 * Auction House Pagination
 *
 * This allows players to list and view more than the client-restricted 7
 * entries. This works by using multiple pages of 6 entries and pages
 * through them every time the player opens their AH listing page.
 ************************************************************************/

#include "map/utils/moduleutils.h"

#include "common/timer.h"
#include "map/packets/auction_house.h"
#include "map/packets/chat_message.h"
#include "map/zone.h"

extern uint8                                                                             PacketSize[512];
extern std::function<void(map_session_data_t* const, CCharEntity* const, CBasicPacket&)> PacketParser[512];

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

        // If this is set to 7, the client won't let you put up more than 7 items. So, 6.
        const auto ITEMS_PER_PAGE = 6U;
        const auto TOTAL_PAGES    = originalAHListLimit == 0 ? 99 : (originalAHListLimit / 6U) + 1;

        ShowInfo("[AH PAGES] AH_LIST_LIMIT is set to %i. Enabling pagination of %i pages with %i items per page.", originalAHListLimit, TOTAL_PAGES, ITEMS_PER_PAGE);

        const auto originalHandler = PacketParser[0x04E];

        const auto newHandler = [ITEMS_PER_PAGE, TOTAL_PAGES, originalHandler](map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data) -> void
        {
            TracyZoneScoped;

            if (PChar->m_GMlevel == 0 && !PChar->loc.zone->CanUseMisc(MISC_AH))
            {
                ShowWarning("[AH PAGES] %s is trying to use the auction house in a disallowed zone [%s]", PChar->getName(), PChar->loc.zone->getName());
                return;
            }

            // Only intercept for action 0x05: Open List Of Sales / Wait
            const auto action = data.ref<uint8>(0x04);
            if (action == 0x05)
            {
                const uint32 curTick = gettick();
                if (curTick - PChar->m_AHHistoryTimestamp > 1500)
                {
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
                            const auto rset = db::preparedStmt("SELECT COUNT(*) FROM auction_house WHERE seller = ? AND sale = 0", PChar->id);
                            FOR_DB_SINGLE_RESULT(rset)
                            {
                                return rset->get<uint32>(0);
                            }

                            return 0;
                        }();
                        PChar->pushPacket<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_3, fmt::format("You have {} items listed for sale.", ahListings).c_str(), "");
                    }

                    PChar->SetLocalVar("AH_PAGE", (currentAHPage + 1) % TOTAL_PAGES);

                    PChar->m_ah_history.clear();
                    PChar->m_AHHistoryTimestamp = curTick;
                    PChar->pushPacket<CAuctionHousePacket>(action);

                    // Not const, because we're possibly going to overwrite it later
                    auto rset = db::preparedStmt("SELECT itemid, price, stack FROM auction_house WHERE seller = ? and sale = 0 ORDER BY id ASC LIMIT ? OFFSET ?", PChar->id, ITEMS_PER_PAGE, currentAHPage * ITEMS_PER_PAGE);

                    // If we get back 0 results, we're at the end of the list. We should redo the query and reset to page 1 (OFFSET 0)
                    if (rset && rset->rowsCount() == 0)
                    {
                        PChar->pushPacket<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_3, fmt::format("No results for page: {} of {}.", currentAHPage + 1, TOTAL_PAGES).c_str(), "");

                        // Reset to Page 1
                        // Overwrite the original rset here
                        rset = db::preparedStmt("SELECT itemid, price, stack FROM auction_house WHERE seller = ? and sale = 0 ORDER BY id ASC LIMIT ? OFFSET 0", PChar->id, ITEMS_PER_PAGE);

                        // Show Page 1 this time
                        currentAHPage = 0;

                        // Prepare Page 2 for next load
                        PChar->SetLocalVar("AH_PAGE", currentAHPage + 1);
                    }

                    // TODO: Don't use TOTAL_PAGES here, use the actual number of pages of results.
                    // Current (10 items): Current page: 2 of 99. Showing 4 items.
                    // Desired (10 items): Current page: 2 of 2. Showing 4 items.
                    PChar->pushPacket<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_3, fmt::format("Current page: {} of {}. Showing {} items.", currentAHPage + 1, TOTAL_PAGES, rset->rowsCount()).c_str(), "");

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
                        PChar->pushPacket<CAuctionHousePacket>(0x0C, (uint8)slot, PChar);
                    }
                }
                else
                {
                    PChar->pushPacket<CAuctionHousePacket>(action, 246, 0, 0, 0, 0); // try again in a little while msg
                }
            }
            else // Otherwise, call original handler
            {
                originalHandler(PSession, PChar, data);
            }
        };

        PacketParser[0x04E] = newHandler;
    }
};

REGISTER_CPP_MODULE(AHPaginationModule);
