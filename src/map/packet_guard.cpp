
#include "packet_guard.h"

#include "entities/charentity.h"

#include <unordered_map> // Lookup
#include <unordered_set> // Capture

// #define PACKETGUARD_CAP_ENABLED 1

namespace PacketGuard
{
#ifdef PACKETGUARD_CAP_ENABLED
std::unordered_map<CHAR_SUBSTATE, std::unordered_set<uint16>> regular_client_packets;
#endif

std::unordered_map<CHAR_SUBSTATE, std::unordered_map<uint16, bool>> allowlist;

void Init()
{
    // Allow all non-substate packets
    for (uint16 i = 0; i < 512; ++i)
    {
        allowlist[SUBSTATE_NONE][i] = true;
    }

    // In Cutscene
    allowlist[SUBSTATE_IN_CS][0x015] = true; // Player Sync
    allowlist[SUBSTATE_IN_CS][0x016] = true; // Entity Information Request
    allowlist[SUBSTATE_IN_CS][0x01A] = true; // Player Action
    allowlist[SUBSTATE_IN_CS][0x03A] = true; // Sort Inventory
    allowlist[SUBSTATE_IN_CS][0x05B] = true; // Event Update (Completion or Update)
    allowlist[SUBSTATE_IN_CS][0x05C] = true; // Event Update (Update Player Position)
    allowlist[SUBSTATE_IN_CS][0x0B5] = true; // Chat Message
    allowlist[SUBSTATE_IN_CS][0x0B6] = true; // Tell Message
    allowlist[SUBSTATE_IN_CS][0x0F2] = true; // Update Player Zone Boundary
    allowlist[SUBSTATE_IN_CS][0x114] = true; // Map Marker Request
}

bool PacketIsValidForPlayerState(CCharEntity* PChar, uint16 SmallPD_Type)
{
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

    return allowlist[PChar->m_Substate][SmallPD_Type];
}
} // namespace PacketGuard
