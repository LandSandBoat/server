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

extern uint8 PacketSize[512];
extern std::function<void(map_session_data_t* const, CCharEntity* const, CBasicPacket)> PacketParser[512];

class AHPaginationModule : public CPPModule
{
    void OnInit() override
    {
        TracyZoneScoped;

        // If this is set to 7, the client won't let you put up more than 7 items. So, 6.
        auto ITEMS_PER_PAGE = 6U;
        auto TOTAL_PAGES = 6;

        ShowInfo("[AH PAGES] Setting AH_LIST_LIMIT to %i.", ITEMS_PER_PAGE * TOTAL_PAGES)
        lua["xi"]["settings"]["search"]["AH_LIST_LIMIT"] = ITEMS_PER_PAGE * TOTAL_PAGES;

        auto originalHandler = PacketParser[0x04E];

        auto newHandler = [this, ITEMS_PER_PAGE, TOTAL_PAGES, originalHandler](map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data) -> void
        {
            TracyZoneScoped;

            if (PChar->m_GMlevel == 0 && !PChar->loc.zone->CanUseMisc(MISC_AH))
            {
                ShowWarning("%s is trying to use the auction house in a disallowed zone [%s]", PChar->GetName(), PChar->loc.zone->GetName());
                return;
            }

            // Only intercept for action 0x05: Open List Of Sales / Wait
            auto action = data.ref<uint8>(0x04);
            if (action == 0x05)
            {
                uint32 curTick = gettick();
                if (curTick - PChar->m_AHHistoryTimestamp > 1500)
                {
                    // This will get wiped on zoning
                    auto currentAHPage = PChar->GetLocalVar("AH_PAGE");
                    PChar->SetLocalVar("AH_PAGE", (currentAHPage + 1) % ITEMS_PER_PAGE);

                    PChar->m_ah_history.clear();
                    PChar->m_AHHistoryTimestamp = curTick;
                    PChar->pushPacket(new CAuctionHousePacket(action));

                    const char* Query = "SELECT itemid, price, stack FROM auction_house WHERE seller = %u and sale=0 ORDER BY id ASC LIMIT %u OFFSET %u;";
                    int32 ret = sql->Query(Query, PChar->id, ITEMS_PER_PAGE, currentAHPage * ITEMS_PER_PAGE);

                    if (ret != SQL_ERROR && sql->NumRows() == 0)
                    {
                        PChar->pushPacket(new CChatMessagePacket(PChar, MESSAGE_SYSTEM_3, fmt::format("No results for page: {} of {}.",
                            currentAHPage + 1, TOTAL_PAGES).c_str(), ""));

                        // Reset to Page 1
                        const char* Query = "SELECT itemid, price, stack FROM auction_house WHERE seller = %u and sale=0 ORDER BY id ASC LIMIT %u OFFSET %u;";
                        ret = sql->Query(Query, PChar->id, ITEMS_PER_PAGE, 0);

                        // Show Page 1 this time
                        currentAHPage = 0;

                        // Prepare Page 2 for next load
                        PChar->SetLocalVar("AH_PAGE", currentAHPage + 1);
                    }

                    PChar->pushPacket(new CChatMessagePacket(PChar, MESSAGE_SYSTEM_3, fmt::format("Current page: {} of {}. Showing {} items.",
                        currentAHPage + 1, TOTAL_PAGES, sql->NumRows()).c_str(), ""));

                    if (ret != SQL_ERROR && sql->NumRows() != 0)
                    {
                        while (sql->NextRow() == SQL_SUCCESS)
                        {
                            AuctionHistory_t ah;
                            ah.itemid = (uint16)sql->GetIntData(0);
                            ah.price  = sql->GetUIntData(1);
                            ah.stack  = (uint8)sql->GetIntData(2);
                            ah.status = 0;
                            PChar->m_ah_history.push_back(ah);
                        }
                    }

                    auto totalItemsOnAh = PChar->m_ah_history.size();
                    for (size_t slot = 0; slot < totalItemsOnAh; slot++)
                    {
                        PChar->pushPacket(new CAuctionHousePacket(0x0C, (uint8)slot, PChar));
                    }
                }
                else
                {
                    PChar->pushPacket(new CAuctionHousePacket(action, 246, 0, 0, 0, 0)); // try again in a little while msg
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
