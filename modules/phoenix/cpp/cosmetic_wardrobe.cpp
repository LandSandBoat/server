/************************************************************************
 * Cosmetic Wardrobe
 *
 * Blocks equipment moves into Mog Wardrobe 8 unless the item is on the cosmetic list.
 * The list is published to xi.phoenix.cosmeticWardrobe by
 * modules/phoenix/lua/custom/cosmetic_wardrobe.lua, which also opens the
 * wardrobe to its full 80 slots on login. Setup instructions live in that
 * file's header.
 *
 * A blocked move never happens server side. The client draws item moves
 * before the server answers, so the rejection resends the source slot and
 * the item snaps back where it was.
 ************************************************************************/
#include "common/logging.h"
#include "common/settings.h"
#include "map/entities/char_entity.h"
#include "map/enums/chat_message_type.h"
#include "map/item_container.h"
#include "map/items/item.h"
#include "map/packets/basic.h"
#include "map/packets/c2s/0x029_item_move.h"
#include "map/packets/s2c/0x017_chat_std.h"
#include "map/packets/s2c/0x01d_item_same.h"
#include "map/packets/s2c/0x020_item_attr.h"
#include "map/utils/moduleutils.h"

class CosmeticWardrobe : public CPPModule
{
    void OnInit() override
    {
        // Read once at boot, the same lifetime as the Lua gate. False means pass
        // through, so disabling restores stock wardrobe behavior on restart even
        // where Wardrobe 8 is already open.
        enabled = settings::get<bool>("main.ENABLE_COSMETIC_WARDROBE");
    }

    auto OnIncomingPacket(MapSession* PSession, CCharEntity* PChar, CBasicPacket& data) -> bool override
    {
        // Return if the packet isn't an item move.
        if (data.getType() != static_cast<uint16>(GP_CLI_COMMAND_ITEM_MOVE::packetId))
        {
            return false;
        }

        if (!enabled)
        {
            return false;
        }

        // Rearranging within the wardrobe is not storage.
        const auto* packet = data.as<GP_CLI_COMMAND_ITEM_MOVE>();
        if (static_cast<CONTAINER_ID>(packet->Category2) != LOC_WARDROBE8 || packet->Category1 == packet->Category2)
        {
            return false;
        }

        // Validation bounds the containers before this hook runs. Kept anyway, it costs nothing.
        if (packet->Category1 >= MAX_CONTAINER_ID)
        {
            return false;
        }

        CItem* PItem = PChar->getStorage(packet->Category1)->GetItem(packet->ItemIndex1);
        if (!PItem || isAllowedItem(PItem->getID()))
        {
            return false;
        }

        // The client has already drawn the move. Resend the source slot so the item
        // snaps back, tell the player why, and consume the packet.
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItem, static_cast<CONTAINER_ID>(packet->Category1), packet->ItemIndex1);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);
        PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, MESSAGE_SYSTEM_3, "Only event and cosmetic items can be stored in this wardrobe.");

        return true;
    }

    // The list lives Lua side so it can be edited without a rebuild. A missing
    // list while enabled means the Lua half broke, and nothing gets in.
    auto isAllowedItem(const uint16 itemId) -> bool
    {
        const auto maybeList = ::lua["xi"]["phoenix"]["cosmeticWardrobe"].get<sol::optional<sol::table>>();
        if (!maybeList)
        {
            // One log line, not one per attempt.
            if (!warnedMissingList)
            {
                warnedMissingList = true;
                ShowError("CosmeticWardrobe: xi.phoenix.cosmeticWardrobe is not loaded");
            }

            return false;
        }

        return maybeList->get_or(itemId, false);
    }

    bool enabled           = false;
    bool warnedMissingList = false;
};

REGISTER_CPP_MODULE(CosmeticWardrobe);
