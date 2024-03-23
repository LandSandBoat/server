#include "packet_guard.h"

// #define PACKETGUARD_CAP_ENABLED 1

#include <unordered_map> // Lookup

#ifdef PACKETGUARD_CAP_ENABLED
#include <unordered_set> // Capture
#endif

namespace PacketGuard
{
#ifdef PACKETGUARD_CAP_ENABLED
    std::unordered_map<CHAR_SUBSTATE, std::unordered_set<uint16>> regular_client_packets;
#endif

    std::unordered_map<CHAR_SUBSTATE, std::unordered_map<uint16, bool>> allowList;

    // Time in seconds (double)
    std::unordered_map<uint16, double> ratelimitList; // Default will be 0 - No Limit

    void Init()
    {
        // Allow all non-substate packets
        for (uint16 i = 0; i < 512; ++i)
        {
            allowList[SUBSTATE_NONE][i] = true;
        }

        // In Cutscene
        allowList[SUBSTATE_IN_CS][0x00A] = true; // Log In To Zone
        allowList[SUBSTATE_IN_CS][0x00C] = true; // Event Update (String Update)
        allowList[SUBSTATE_IN_CS][0x00D] = true; // Player Leaving Zone(Dezone)
        allowList[SUBSTATE_IN_CS][0x00F] = true; // Player Information Request
        allowList[SUBSTATE_IN_CS][0x011] = true; // Player Zone Transition Confirmation
        allowList[SUBSTATE_IN_CS][0x015] = true; // Player Sync
        allowList[SUBSTATE_IN_CS][0x016] = true; // Entity Information Request
        allowList[SUBSTATE_IN_CS][0x01A] = true; // Player Action
        allowList[SUBSTATE_IN_CS][0x03A] = true; // Sort Inventory
        allowList[SUBSTATE_IN_CS][0x053] = true; // LockStyleSet
        allowList[SUBSTATE_IN_CS][0x058] = true; // Synthesis Suggestion
        allowList[SUBSTATE_IN_CS][0x05A] = true; // Map Update (Conquest, Besieged, Campaign)
        allowList[SUBSTATE_IN_CS][0x05B] = true; // Event Update (Completion or Update)
        allowList[SUBSTATE_IN_CS][0x05C] = true; // Event Update (Update Player Position)
        allowList[SUBSTATE_IN_CS][0x060] = true; // Event Update (String Update)
        allowList[SUBSTATE_IN_CS][0x061] = true; // Full Char Update
        allowList[SUBSTATE_IN_CS][0x0B5] = true; // Chat Message
        allowList[SUBSTATE_IN_CS][0x0B6] = true; // Tell Message
        allowList[SUBSTATE_IN_CS][0x0DB] = true; // Set Preferred Language
        allowList[SUBSTATE_IN_CS][0x0E0] = true; // Set Search Message
        allowList[SUBSTATE_IN_CS][0x0F2] = true; // Update Player Zone Boundary
        allowList[SUBSTATE_IN_CS][0x112] = true; // Roe Quest Log Request
        allowList[SUBSTATE_IN_CS][0x114] = true; // Map Marker Request
        allowList[SUBSTATE_IN_CS][0x118] = true; // Not Impl
        allowList[SUBSTATE_IN_CS][0x11B] = true; // Not Impl

        // Rate limiting
        // NOTE: You should rate limit any packet that a player can
        //     : send at will that results in an immediate database hit
        //     : or generates logs or results in file or network io.
        ratelimitList[0x017] = 1.0; // Invalid NPC Information Response
        ratelimitList[0x03B] = 1.0; // Mannequin Equip
        ratelimitList[0x05D] = 2.0; // Emotes
        ratelimitList[0x0F4] = 1.0; // Wide Scan
        ratelimitList[0x0F5] = 1.0; // Wide Scan Track
        ratelimitList[0x11B] = 2.0; // Set Job Master Display
        ratelimitList[0x11D] = 2.0; // Jump
    }

    bool PacketIsValidForPlayerState(CCharEntity* PChar, uint16 SmallPD_Type)
    {
        TracyZoneScoped;
#if PACKETGUARD_CAP_ENABLED == 1
        regular_client_packets[PChar->m_Substate].insert(SmallPD_Type);
        for (uint8 state = SUBSTATE_IN_CS; state < SUBSTATE_LAST; ++state)
        {
            fmt::print("Substate {}: ", state);
            for (auto& entry : regular_client_packets[(CHAR_SUBSTATE)state])
            {
                fmt::print("{:#04x}, ", entry);
            }
            fmt::print("\n");
        }
        return true;
#endif

        return allowList[PChar->m_Substate][SmallPD_Type];
    }

    bool IsRateLimitedPacket(CCharEntity* PChar, uint16 SmallPD_Type)
    {
        TracyZoneScoped;
        using namespace std::chrono;

        double lastPacketRecievedTime = static_cast<double>(PChar->m_PacketRecievedTimestamps[SmallPD_Type]);
        double timeNowSeconds         = static_cast<double>(time_point_cast<seconds>(server_clock::now()).time_since_epoch().count());
        double ratelimitTime          = ratelimitList[SmallPD_Type];

        PChar->m_PacketRecievedTimestamps[SmallPD_Type] = timeNowSeconds;

        if (lastPacketRecievedTime == 0 || ratelimitTime == 0)
        {
            return false;
        }

        return timeNowSeconds - lastPacketRecievedTime < ratelimitList[SmallPD_Type];
    }

    void PrintPacketList(CCharEntity* PChar)
    {
        // Count packets in queue
        std::map<std::string, uint32> packetCounterMap;
        for (auto& entry : PChar->getPacketList())
        {
            auto packetStr = fmt::format("0x{:4X}", entry->getType());
            packetCounterMap[packetStr]++;
        }

        // Sort
        using pair_t = std::pair<std::string, uint32>;
        std::vector<pair_t> sortedVec;
        sortedVec.reserve(packetCounterMap.size());
        for (auto& entry : packetCounterMap)
        {
            sortedVec.emplace_back(entry);
        }

        // clang-format off
        std::sort(sortedVec.begin(), sortedVec.end(),
        [](pair_t& a, pair_t& b)
        {
            return a.second < b.second;
        });
        // clang-format on

        // Print
        std::string output;
        output += "\n=======================================\n";
        for (auto& entry : packetCounterMap)
        {
            output += fmt::format("{} : {}\n", entry.first, entry.second);
        }
        output += "=======================================\n";
        ShowInfo(output);
    }

    auto GetPacketAllowList() -> std::unordered_map<CHAR_SUBSTATE, std::unordered_map<uint16, bool>>&
    {
        return allowList;
    }
} // namespace PacketGuard
