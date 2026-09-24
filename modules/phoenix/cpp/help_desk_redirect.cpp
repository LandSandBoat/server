/************************************************************************
 * Help Desk Redirect
 *
 * Directs players to the Phoenix account portal and blocks in-game GM calls.
 ************************************************************************/
#include "map/entities/char_entity.h"
#include "map/enums/chat_message_type.h"
#include "map/packets/basic.h"
#include "map/packets/c2s/0x0d3_faq_gmcall.h"
#include "map/packets/c2s/0x0d4_faq_gmparam.h"
#include "map/packets/s2c/0x017_chat_std.h"
#include "map/utils/moduleutils.h"

class HelpDeskRedirect : public CPPModule
{
    void OnInit() override
    {
    }

    auto OnIncomingPacket(MapSession* PSession, CCharEntity* PChar, CBasicPacket& data) -> bool override
    {
        if (data.getType() == static_cast<uint16>(GP_CLI_COMMAND_FAQ_GMPARAM::packetId))
        {
            sendNotice(PChar);
            return false;
        }

        if (data.getType() != static_cast<uint16>(GP_CLI_COMMAND_FAQ_GMCALL::packetId))
        {
            return false;
        }

        const auto* packet = data.as<GP_CLI_COMMAND_FAQ_GMCALL>();
        if (static_cast<GP_CLI_COMMAND_FAQ_GMCALL_TYPE>(packet->type) != GP_CLI_COMMAND_FAQ_GMCALL_TYPE::GMCall)
        {
            return false;
        }

        // A GM call spans several packets. Show the notice after the final fragment.
        if (packet->eos == 1)
        {
            sendNotice(PChar);
        }

        return true;
    }

    static void sendNotice(CCharEntity* PChar)
    {
        PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, MESSAGE_SYSTEM_3, "-------------------------------");
        PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, MESSAGE_SYSTEM_3, "In game GM tickets have been disabled.");
        PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, MESSAGE_SYSTEM_3, "Please visit the Phoenix website and file tickets from your Phoenix account portal to receive support:");
        PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, MESSAGE_SYSTEM_3, "https://phoenix-xi.com/account");
        PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, MESSAGE_SYSTEM_3, "-------------------------------");
    }
};

REGISTER_CPP_MODULE(HelpDeskRedirect);
