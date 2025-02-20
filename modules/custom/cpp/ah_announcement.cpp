/************************************************************************
 * Auction House Announcements
 *
 * This will send a message to the seller of an item when it is bought,
 * informing them that their item sold, to who, and for how much.
 * It will only send this message if the seller is online.
 ************************************************************************/

#include "map/utils/moduleutils.h"

#include "common/database.h"
#include "common/timer.h"

#include "map/item_container.h"
#include "map/message.h"
#include "map/packets/auction_house.h"
#include "map/packets/chat_message.h"
#include "map/packets/inventory_finish.h"
#include "map/utils/charutils.h"
#include "map/utils/itemutils.h"
#include "map/zone.h"

#include <functional>
#include <numeric>

extern uint8 PacketSize[512];

extern std::function<void(map_session_data_t* const, CCharEntity* const, CBasicPacket&)> PacketParser[512];

class AHAnnouncementModule : public CPPModule
{
    void OnInit() override
    {
        TracyZoneScoped;

        const auto originalHandler = PacketParser[0x04E];

        const auto newHandler = [originalHandler](map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket& data) -> void
        {
            TracyZoneScoped;

            // Only intercept for action 0x0E: Purchasing Items
            const auto action = data.ref<uint8>(0x04);
            if (action == 0x0E)
            {
                // !!!
                // NOTE: This is almost the exact same code as the original, with the annoucement attached to the end.
                //     : If the original code changes, this will have to change too!
                // !!!

                const uint32 price    = data.ref<uint32>(0x08);
                const uint16 itemid   = data.ref<uint16>(0x0C);
                const uint8  quantity = data.ref<uint8>(0x10);

                if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
                {
                    PChar->pushPacket<CAuctionHousePacket>(action, 0xE5, 0, 0, 0, 0);
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
                                    PChar->pushPacket<CAuctionHousePacket>(action, 0xE5, 0, 0, 0, 0);
                                    return;
                                }
                            }
                        }

                        CItem* gil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

                        if (gil != nullptr && gil->isType(ITEM_CURRENCY) && gil->getQuantity() >= price && gil->getReserve() == 0)
                        {
                            // clang-format off
                            const auto success = db::transaction([&]()
                            {
                                // Get the row id of the item we're buying
                                const auto rowId = [&]() -> uint32
                                {
                                    const auto rset = db::preparedStmt(R"(
                                        SELECT id
                                        FROM auction_house
                                        WHERE itemid = ?
                                        AND buyer_name IS NULL
                                        AND stack = ?
                                        AND price <= ?
                                        ORDER BY price
                                        LIMIT 1;
                                        )",
                                        itemid, quantity == 0, price);

                                    FOR_DB_SINGLE_RESULT(rset)
                                    {
                                        return rset->get<uint32>("id");
                                    }

                                    return 0;
                                }();

                                // Now that we have the row id, we can use it to update the purchase information
                                const auto successfulUpdate = [&]() -> bool
                                {
                                    const auto [rset, affectedRows] = db::preparedStmtWithAffectedRows(R"""(
                                        UPDATE auction_house
                                        SET buyer_name = ?, sale = ?, sell_date = ?
                                        WHERE id = ?
                                        LIMIT 1;
                                        )""",
                                        PChar->getName(), price, (uint32)time(nullptr), rowId);

                                    return rset && affectedRows;
                                }();

                                // If the update was successful we can now add the item to the buyer's inventory
                                if (successfulUpdate)
                                {
                                    uint8 SlotID = charutils::AddItem(PChar, LOC_INVENTORY, itemid, (quantity == 0 ? PItem->getStackSize() : 1));
                                    if (SlotID != ERROR_SLOTID)
                                    {
                                        charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -(int32)(price));

                                        PChar->pushPacket<CAuctionHousePacket>(action, 0x01, itemid, price, quantity, PItem->getStackSize());
                                        PChar->pushPacket<CInventoryFinishPacket>();

                                        // Now that the item is in the buyer's inventory we can send the message to the seller
                                        const auto sellerId = [&]() -> uint32
                                        {
                                            uint32 sellerId = 0;

                                            const auto rset = db::preparedStmt(R"(
                                                SELECT seller
                                                FROM auction_house
                                                WHERE id = ?;
                                                )",
                                                rowId);

                                            FOR_DB_SINGLE_RESULT(rset)
                                            {
                                                sellerId = rset->get<uint32>("seller");
                                            }

                                            return sellerId;
                                        }();

                                        if (sellerId)
                                        {
                                            // Sanitize name
                                            std::string name  = PItem->getName();
                                            auto        parts = split(name, "_");
                                            name              = "";
                                            name += std::accumulate(std::begin(parts), std::end(parts), std::string(),
                                            [](std::string const& ss, std::string const& s)
                                            {
                                                return ss.empty() ? s : ss + " " + s;
                                            });
                                            name[0] = std::toupper(name[0]);

                                            // Send message to seller!
                                            message::send(sellerId, std::make_unique<CChatMessagePacket>(PChar, MESSAGE_SYSTEM_3,
                                                fmt::format("Your '{}' has sold to {} for {} gil!", name, PChar->name, price).c_str(), ""));
                                        }
                                    }
                                }
                            });
                            if (success)
                            {
                                return;
                            }
                            // clang-format on
                        }
                    }

                    // You were unable to buy the {qty} {item}
                    if (PItem)
                    {
                        PChar->pushPacket<CAuctionHousePacket>(action, 0xC5, itemid, price, quantity, PItem->getStackSize());
                    }
                    else
                    {
                        PChar->pushPacket<CAuctionHousePacket>(action, 0xC5, itemid, price, quantity, 0);
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
