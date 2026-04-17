/************************************************************************
 * Auction House Announcements
 *
 * This will send a message to the seller of an item when it is bought,
 * informing them that their item sold, to who, and for how much.
 * It will only send this message if the seller is online.
 ************************************************************************/

#include "common/database.h"

#include "map/ipc_client.h"
#include "map/map_session.h"
#include "map/packets/basic.h"
#include "map/utils/itemutils.h"
#include "map/utils/moduleutils.h"
#include "packets/c2s/0x04e_auc.h"
#include "utils/auctionutils.h"

#include <functional>
#include <numeric>

class AHAnnouncementModule : public CPPModule
{
    void OnInit() override
    {
    }

    auto OnIncomingPacket(MapSession* PSession, CCharEntity* PChar, CBasicPacket& data) -> bool override
    {
        TracyZoneScoped;

        // Only intercept AUC packets (0x04E)
        if (data.getType() != static_cast<uint16_t>(PacketC2S::GP_CLI_COMMAND_AUC))
        {
            return false;
        }

        // Only intercept for action 0x0E: Purchasing Items
        const auto* packet = data.as<GP_CLI_COMMAND_AUC>();
        if (packet->Command != GP_CLI_COMMAND_AUC_COMMAND::Bid)
        {
            return false;
        }

        const uint32 price    = packet->Param.Bid.BidPrice;
        const uint16 itemid   = packet->Param.Bid.ItemNo;
        const uint8  quantity = packet->Param.Bid.ItemStacks;

        CItem* PItem = itemutils::GetItemPointer(itemid);
        if (!PItem)
        {
            return false;
        }

        const GP_AUC_PARAM_BID payload{
            .BidPrice   = price,
            .ItemNo     = itemid,
            .ItemStacks = quantity,
        };

        if (!auctionutils::PurchasingItems(PChar, payload))
        {
            return false;
        }

        const auto sellerId = [&]() -> uint32
        {
            uint32 id = 0;

            const auto rset = db::preparedStmt("SELECT seller "
                                               "FROM auction_house WHERE "
                                               "buyer_name = ? AND "
                                               "sale = ? AND "
                                               "itemid = ? AND "
                                               "stack = ? "
                                               "ORDER BY sell_date DESC LIMIT 1",
                                               PChar->getName(),
                                               price,
                                               itemid,
                                               quantity == 0);

            FOR_DB_SINGLE_RESULT(rset)
            {
                id = rset->get<uint32>("seller");
            }

            return id;
        }();

        if (sellerId)
        {
            // Sanitize name
            std::string name  = PItem->getName();
            auto        parts = split(name, "_");
            name              = "";
            name += std::accumulate(
                std::begin(parts),
                std::end(parts),
                std::string(),
                [](const std::string& ss, const std::string& s)
                {
                    return ss.empty() ? s : ss + " " + s;
                });

            // Capitalize first letter
            name[0] = std::toupper(name[0]);

            // Send message to seller!
            message::send(ipc::ChatMessageCustom{
                .recipientId = sellerId,
                .senderName  = "",
                .message     = fmt::format("Your '{}' has sold to {} for {} gil!", name, PChar->getName(), price),
                .messageType = MESSAGE_SYSTEM_3,
            });
        }

        return true;
    }
};

REGISTER_CPP_MODULE(AHAnnouncementModule);
