/************************************************************************
 * Auction House Announcements
 *
 * This will send a message to the seller of an item when it is bought,
 * informing them that their item sold, to who, and for how much.
 * It will only send this message if the seller is online.
 ************************************************************************/

#include "map/utils/moduleutils.h"

#include "common/timer.h"
#include "map/item_container.h"
#include "map/message.h"
#include "map/packets/auction_house.h"
#include "map/packets/chat_message.h"
#include "map/packets/inventory_finish.h"
#include "map/utils/charutils.h"
#include "map/utils/itemutils.h"
#include "map/zone.h"

#include <numeric>

extern uint8 PacketSize[512];

extern std::function<void(map_session_data_t* const, CCharEntity* const, CBasicPacket)> PacketParser[512];

class AHAnnouncementModule : public CPPModule
{
    void OnInit() override
    {
        TracyZoneScoped;

        auto originalHandler = PacketParser[0x04E];

        auto newHandler = [this, originalHandler](map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data) -> void
        {
            TracyZoneScoped;

            // Only intercept for action 0x0E: Purchasing Items
            auto action = data.ref<uint8>(0x04);
            if (action == 0x0E)
            {
                // !!!
                // NOTE: This is almost the exact same code as the original, with the annoucement attached to the end.
                //     : If the original code changes, this will have to change too!
                // !!!

                uint32 price    = data.ref<uint32>(0x08);
                uint16 itemid   = data.ref<uint16>(0x0C);
                uint8  quantity = data.ref<uint8>(0x10);

                if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
                {
                    PChar->pushPacket(new CAuctionHousePacket(action, 0xE5, 0, 0, 0, 0));
                }
                else
                {
                    CItem* PItem = itemutils::GetItemPointer(itemid);

                    if (PItem != nullptr)
                    {
                        if (PItem->getFlag() & ITEM_FLAG_RARE)
                        {
                            for (uint8 LocID = 0; LocID < CONTAINER_ID::MAX_CONTAINER_ID; ++LocID)
                            {
                                if (PChar->getStorage(LocID)->SearchItem(itemid) != ERROR_SLOTID)
                                {
                                    PChar->pushPacket(new CAuctionHousePacket(action, 0xE5, 0, 0, 0, 0));
                                    return;
                                }
                            }
                        }

                        CItem* gil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

                        if (gil != nullptr && gil->isType(ITEM_CURRENCY) && gil->getQuantity() >= price)
                        {
                            // clang-format off
                            auto ret = sql->Query(fmt::format(R"(
                                UPDATE auction_house
                                SET buyer_name = '{}', sale = {}, sell_date = {}
                                WHERE itemid = {}
                                AND buyer_name IS NULL
                                AND stack = {}
                                AND price <= {}
                                # LAST_INSERT_ID:
                                # The ID that was generated is maintained in the server on a per-connection basis.
                                # Always evaluates to a positive integer, therefore true
                                AND LAST_INSERT_ID(seller)
                                ORDER BY price
                                LIMIT 1;
                                )",
                                PChar->GetName(), price, (uint32)time(nullptr), itemid, quantity == 0, price).c_str());
                            // clang-format on

                            if (ret != SQL_ERROR && sql->AffectedRows() != 0)
                            {
                                uint8 SlotID = charutils::AddItem(PChar, LOC_INVENTORY, itemid, (quantity == 0 ? PItem->getStackSize() : 1));

                                if (SlotID != ERROR_SLOTID)
                                {
                                    charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)(price));

                                    PChar->pushPacket(new CAuctionHousePacket(action, 0x01, itemid, price, quantity, PItem->getStackSize()));
                                    PChar->pushPacket(new CInventoryFinishPacket());

                                    ret = sql->Query(R"(
                                        SELECT seller
                                        FROM auction_house
                                        WHERE id = LAST_INSERT_ID();
                                    )");

                                    uint32 sellerId = 0;

                                    if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
                                    {
                                        sellerId = sql->GetUIntData(0);
                                    }

                                    if (sellerId > 0)
                                    {
                                        // clang-format off
                                        // Sanitize name
                                        std::string name  = PItem->getName();
                                        auto        parts = split(name, "_");
                                        name              = "";
                                        name += std::accumulate(std::begin(parts), std::end(parts), std::string(),
                                        [](std::string& ss, std::string& s)
                                        {
                                            return ss.empty() ? s : ss + " " + s;
                                        });
                                        name[0] = std::toupper(name[0]);

                                        // Send message to seller!
                                        message::send(sellerId, new CChatMessagePacket(PChar, MESSAGE_SYSTEM_3,
                                            fmt::format("Your '{}' has sold to {} for {} gil!", name, PChar->name, price).c_str(), ""));
                                        // clang-format on
                                    }
                                }
                                return;
                            }
                        }
                    }
                    if (PItem)
                    {
                        PChar->pushPacket(new CAuctionHousePacket(action, 0xC5, itemid, price, quantity, PItem->getStackSize()));
                    }
                    else
                    {
                        PChar->pushPacket(new CAuctionHousePacket(action, 0xC5, itemid, price, quantity, 0));
                    }
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

REGISTER_CPP_MODULE(AHAnnouncementModule);
