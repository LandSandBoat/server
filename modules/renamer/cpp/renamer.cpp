#include "map/packet_guard.h"
#include "map/utils/moduleutils.h"
#include "map/zone.h"

extern uint8                                                                             PacketSize[512];
extern std::function<void(map_session_data_t* const, CCharEntity* const, CBasicPacket&)> PacketParser[512];

class RenamerModule : public CPPModule
{
    void SendListPacket(CCharEntity* PChar, std::string const& data)
    {
        if (data.empty())
        {
            // Nothing to do, bail out
            return;
        }

        auto customPacket = std::unique_ptr<CBasicPacket>();
        customPacket->setType(0x1FF);
        customPacket->setSize(0x100);
        for (std::size_t i = 0; i < data.size(); ++i)
        {
            customPacket->ref<uint8>(0x04 + i) = data[i];
        }
        PChar->pushPacket(std::move(customPacket));
    }

    void OnInit() override
    {
        TracyZoneScoped;

        ShowInfo("Renamer: Loading ./modules/renamer/lua/list.lua");

        auto result = lua.safe_script_file("./modules/renamer/lua/list.lua", &sol::script_pass_on_error);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("Load error: %s", err.what());
            return;
        }

        if (!result.return_count())
        {
            ShowError("No returned renamer list object");
            return;
        }

        // NOTE: If we don't attach the result to something global, it will not be
        //     : correclty captured by the packet handling lambda.
        lua[sol::create_if_nil]["xi"]["renamerTable"] = result;

        // Add a custom packet handler to the PacketParser array for id 0x01
        PacketParser[0x01] = [&](map_session_data_t* const, CCharEntity* const PChar, CBasicPacket&)
        {
            ShowInfo(fmt::format("{} requested renamer list for {}", PChar->getName(), PChar->loc.zone->getName()));

            auto zoneId       = PChar->getZone();
            auto renamerTable = lua["xi"]["renamerTable"].get<sol::table>();

            auto zoneTable = renamerTable[zoneId].get_or<sol::table>(sol::lua_nil);
            if (zoneTable == sol::lua_nil)
            {
                return;
            }

            std::string dataString;
            for (const auto& [key, value] : zoneTable)
            {
                auto entryTable = value.as<sol::table>();

                // convert entityId to targid
                auto entityCodedName   = entryTable[1].get<std::string>();
                auto entityDisplayName = entryTable[2].get<std::string>();
                auto packedString      = fmt::format("{},{}.", entityCodedName, entityDisplayName);

                // If the dataString gets too large, send a packet with what we've
                // already prepared so we don't exceed the target size of 0x100.
                if (0x04 + dataString.size() + packedString.size() > 0x100)
                {
                    SendListPacket(PChar, dataString);
                    dataString.clear();
                }
                else
                {
                    dataString += packedString;
                }
            }

            SendListPacket(PChar, dataString);
        };

        // Add new possible packet to PacketGuard allow list
        auto& allowList = PacketGuard::GetPacketAllowList();

        allowList[SUBSTATE_IN_CS][0x01] = true;
    }
};

REGISTER_CPP_MODULE(RenamerModule);
