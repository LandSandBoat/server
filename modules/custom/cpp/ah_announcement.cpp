/************************************************************************
 * Auction House Announcements
 *
 * This will send a message to the seller of an item when it is bought,
 * informing them that their item sold, to who, and for how much.
 * It will only send this message if the seller is online.
 ************************************************************************/

#include "map/utils/moduleutils.h"

#include "common/database.h"

#include "map/packet_system.h"
#include "map/packets/auction_house.h"
#include "map/packets/basic.h"
#include "map/packets/s2c/0x017_chat_std.h"
#include "map/utils/itemutils.h"

#include "map/ipc_client.h"
#include "map/map_session.h"
#include "utils/auctionutils.h"

#include <functional>
#include <numeric>

extern uint8 PacketSize[512];

extern std::function<void(MapSession* const, CCharEntity* const, CBasicPacket&)> PacketParser[512];

class AHAnnouncementModule : public CPPModule
{
    void OnInit() override
    {
        TracyZoneScoped;

        const auto originalHandler = PacketParser[0x04E];

        const auto newHandler = [originalHandler](MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data) -> void
        {
            TracyZoneScoped;

            // Only intercept for action 0x0E: Purchasing Items
            const auto action = data.ref<uint8>(0x04);
            if (action == 0x0E)
            {
                const uint32 price    = data.ref<uint32>(0x08);
                const uint16 itemid   = data.ref<uint16>(0x0C);
                const uint8  quantity = data.ref<uint8>(0x10);

                CItem* PItem = itemutils::GetItemPointer(itemid);
                if (PItem)
                {
                    const GP_AUC_PARAM_BID payload{
                        .BidPrice   = price,
                        .ItemNo     = itemid,
                        .ItemStacks = quantity,
                    };

                    if (auctionutils::PurchasingItems(PChar, payload))
                    {
                        // clang-format off
                        const auto sellerId = [&]() -> uint32
                        {
                            uint32 sellerId = 0;

                            const auto rset = db::preparedStmt("SELECT seller "
                                                               "FROM auction_house WHERE "
                                                               "buyer_name = ? AND "
                                                               "sale = ? AND "
                                                               "itemid = ? AND "
                                                               "stack = ? "
                                                               "ORDER BY sell_date DESC LIMIT 1",
                                                               PChar->getName(), price, itemid, quantity == 0);

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
                            message::send(ipc::ChatMessageCustom{
                                .recipientId = sellerId,
                                .senderName  = "",
                                .message     = fmt::format("Your '{}' has sold to {} for {} gil!", name, PChar->getName(), price),
                                .messageType = MESSAGE_SYSTEM_3,
                            });
                            // clang-format on
                        }
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
