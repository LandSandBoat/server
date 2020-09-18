
#include "packet_guard.h"

#include "entities/charentity.h"

#include <unordered_map> // Lookup
#include <unordered_set> // Capture

#define PACKETGUARD_CAP_ENABLED 0

namespace PacketGuard
{
#ifdef PACKETGUARD_CAP_ENABLED
std::unordered_map<CHAR_SUBSTATE, std::unordered_set<uint16>> regular_client_packets;
#endif

// Allowlists
std::unordered_set<uint16> in_cs_allowlist =
{
    0x015, // Player Sync
    0x016, // Entity Information Request
    0x01A, // Player Action
    0x03A, // Sort Inventory
    0x05B, // Event Update (Completion or Update)
    0x05C, // Event Update (Update Player Position)
    0x0B5, // Chat Message
    0x0F2, // Update Player Zone Boundary
    0x114, // Map Marker Request
};

bool PacketIsValidForPlayerState(CCharEntity* PChar, uint16 SmallPD_Type)
{
#ifdef PACKETGUARD_CAP_ENABLED
    // Capture packets
    // TODO: Generate a file and ask a few servers to run this
    regular_client_packets[PChar->m_Substate].insert(SmallPD_Type);
    for (uint8 state = IN_CS; state < SUBSTATE_LAST; ++state)
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

    switch (PChar->m_Substate)
    {
    case IN_CS:
    {
        // TODO: O(1) lookup
        if (in_cs_allowlist.find(SmallPD_Type) != in_cs_allowlist.end())
        {
            return true;
        }
        break;
    }
    case NONE:
        // TODO: Maybe a small rejectlist here
        [[fallthrough]];
    default:
    {
        return true;
    }
    }

    return false;
}
} // namespace PacketGuard
