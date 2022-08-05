
#include "map/utils/moduleutils.h"
#include "map/packets/chat_message.h"
#include "utils/charutils.h"
#include "utils/zoneutils.h"

extern uint8 PacketSize[512];
extern std::function<void(map_session_data_t* const, CCharEntity* const, CBasicPacket)> PacketParser[512];

class DisableMogGardenModule : public CPPModule
{
    void OnInit() override
    {
        auto originalHandler = PacketParser[0x05E];

        auto newHandler = [originalHandler](map_session_data_t* const PSession, CCharEntity* const PChar, CBasicPacket data) -> void
        {
            uint8  requestedZone = data.ref<uint8>(0x17);
            if (requestedZone == 127)
            {
                bool moghouseExitRegular = PChar->m_moghouseID > 0;
                PChar->clearPacketList();
                if (moghouseExitRegular) 
                {
                    PChar->m_moghouseID    = 0;
                    PChar->loc.destination = PChar->getZone();
                    PChar->loc.p           = {};
                } 
                else 
                {
                    PChar->status = STATUS_TYPE::NORMAL;
                    ShowWarning("SmallPacket0x05E: Moghouse zoneline abuse by %s", PChar->GetName());
                    return;
                }
                uint64 ipp = zoneutils::GetZoneIPP(PChar->loc.destination);
                charutils::SendToZone(PChar, 2, ipp);

                PChar->pushPacket(new CChatMessagePacket(PChar, MESSAGE_SYSTEM_3, "You do not have a Mog Garden to enter." ));
            }
            else 
            {
                originalHandler(PSession, PChar, data);
            }
        };
        PacketParser[0x05E] = newHandler;
    }
};

REGISTER_CPP_MODULE(DisableMogGardenModule);
