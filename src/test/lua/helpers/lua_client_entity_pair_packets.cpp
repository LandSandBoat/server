/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "lua/helpers/lua_client_entity_pair_packets.h"

#include "ai/ai_container.h"
#include "common/logging.h"
#include "common/lua.h"
#include "enums/packet_c2s.h"
#include "enums/packet_s2c.h"
#include "lua/lua_client_entity_pair.h"
#include "lua/lua_simulation.h"
#include "lua/sol_bindings.h"
#include "map/packet_system.h"
#include "map/packets/c2s/0x00a_login.h"
#include "map/packets/s2c/0x028_battle2.h"
#include "packets/c2s/0x011_zone_transition.h"
#include "test_char.h"
#include "test_common.h"
#include "utils/charutils.h"
#include "utils/zoneutils.h"

CLuaClientEntityPairPackets::CLuaClientEntityPairPackets(CLuaClientEntityPair* parent)
: parent_(parent)
{
}

auto CLuaClientEntityPairPackets::createPacket(PacketC2S packetType) -> std::unique_ptr<CBasicPacket>
{
    auto packet = std::make_unique<CBasicPacket>();
    packet->setType(static_cast<uint16_t>(packetType));
    packet->setSize(PacketSize[static_cast<uint16_t>(packetType)]);
    packet->setSequence(sequenceNum_++);

    return packet;
}

void CLuaClientEntityPairPackets::sendBasicPacket(CBasicPacket& packet) const
{
    const auto testChar = parent_->testChar();
    DebugTestFmt("C2S 0x{:03X} {}", packet.getType(), magic_enum::enum_name(static_cast<PacketC2S>(packet.getType())));
    PacketParser[packet.getType()](testChar->session(), testChar->entity(), packet);
}

/************************************************************************
 *  Function: send()
 *  Purpose : Send a packet from FFI cdata
 *  Example : packets:send(0x1A, ffiPacket, ffi.sizeof(ffiPacket))
 *  Notes   : Takes packet ID, FFI struct pointer, and struct size
 ************************************************************************/

void CLuaClientEntityPairPackets::send(const PacketC2S packetId, const sol::object& ffiData, const size_t ffiSize)
{
    // Get the raw pointer from FFI cdata using lua_topointer
    lua_State* L        = ffiData.lua_state();
    std::ignore         = ffiData.push();
    const void* rawData = lua_topointer(L, -1);
    lua_pop(L, 1);

    if (!rawData)
    {
        TestError("send: Failed to extract pointer from FFI cdata");
        return;
    }

    const size_t packetSize = ffiSize;
    const auto   packet     = std::make_unique<CBasicPacket>();
    packet->setType(static_cast<uint16_t>(packetId));
    packet->setSize(packetSize);
    packet->setSequence(sequenceNum_++);

    // Copy packet data from FFI struct to CBasicPacket
    // FFI struct has GP_CLI_HEADER (4 bytes) then actual data
    // CBasicPacket header (4 bytes) is set by setType/setSize/setSequence
    // Copy the actual data (skipping the FFI header) into CBasicPacket starting at byte 4
    const auto srcData = static_cast<const uint8_t*>(rawData);
    for (size_t i = 4; i < packetSize; ++i)
    {
        packet->ref<uint8_t>(i) = srcData[i]; // Copy from FFI byte 4+ to packet byte 4+
    }

    sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: sendZonePackets()
 *  Purpose : Send packets for zone transition
 *  Example : packets:sendZonePackets()
 *  Notes   : Handles the zone-in packet sequence
 ************************************************************************/

void CLuaClientEntityPairPackets::sendZonePackets()
{
    const auto testChar = parent_->testChar();

    // IMPORTANT: Both TestChar and CLuaClientEntityPair wrapper need to be updated
    // TestChar holds the actual CCharEntity, while parent_ is the Lua wrapper
    // that also needs its internal pointer updated to the newly loaded entity
    testChar->setBlowfish(BLOWFISH_PENDING_ZONE);
    testChar->setEntity(charutils::LoadChar(testChar->charId()));
    parent_->setEntity(testChar->entity());

    // Send LOGIN packet to begin zone-in sequence
    const auto loginPacket = createPacket(PacketC2S::GP_CLI_COMMAND_LOGIN);
    auto*      login       = loginPacket->as<GP_CLI_COMMAND_LOGIN>();
    login->UniqueNo        = testChar->charId();
    sendBasicPacket(*loginPacket);

    // Send ZONE_TRANSITION packet to complete zone-in sequence
    const auto transitionPacket = createPacket(PacketC2S::GP_CLI_COMMAND_ZONE_TRANSITION);
    auto*      transition       = transitionPacket->as<GP_CLI_COMMAND_ZONE_TRANSITION>();
    transition->unknown00       = 2;
    transition->unknown01       = 0;
    sendBasicPacket(*transitionPacket);

    // Execute AfterZoneIn logic
    parent_->simulation()->skipTime(4);
    testChar->entity()->PAI->checkQueueImmediately();
}

/************************************************************************
 *  Function: parseIncoming()
 *  Purpose : Process incoming packets from the server
 *  Example : packets:parseIncoming()
 *  Notes   : Currently handles zone change requests
 ************************************************************************/

void CLuaClientEntityPairPackets::parseIncoming()
{
    const auto testChar        = parent_->testChar();
    bool       foundZonePacket = false;

    for (auto&& packet : testChar->entity()->getPacketList())
    {
        switch (packet->getType())
        {
            case 0x0B: // CServerIPPacket: request from server to change zone
            {
                foundZonePacket = true;
                break;
            }
            default:
                break;
        }
    }

    if (foundZonePacket)
    {
        DebugTest("Server requesting zone change");
        sendZonePackets();
    }
}

/************************************************************************
 *  Function: getIncoming()
 *  Purpose : Get all incoming packets as a Lua table
 *  Example : local packets = packets:getIncoming()
 *  Notes   : Returns table with packet info and data
 ************************************************************************/

auto CLuaClientEntityPairPackets::getIncoming() const -> sol::table
{
    const auto testChar = parent_->testChar();
    auto       table    = lua.create_table();
    auto       idx      = 1;

    for (auto&& packet : testChar->entity()->getPacketList())
    {
        auto packetTable = lua.create_table();

        packetTable["type"]     = packet->getType();
        packetTable["size"]     = packet->getSize();
        packetTable["sequence"] = packet->getSequence();

        // Create a table of bytes for the packet data
        auto dataTable = lua.create_table();
        for (size_t i = 0; i < packet->getSize(); ++i)
        {
            dataTable[i] = packet->ref<uint8_t>(i);
        }

        packetTable["data"] = dataTable;

        table[idx++] = packetTable;
    }

    return table;
}

/************************************************************************
 *  Function: actionPackets()
 *  Purpose : Get all BATTLE2 (0x028) packets unpacked into Lua tables
 *  Example : local actions = packets:actionPackets()
 *  Notes   : Filters for type 0x028 and unpacks using GP_SERV_COMMAND_BATTLE2::unpack
 ************************************************************************/

auto CLuaClientEntityPairPackets::actionPackets() const -> sol::table
{
    const auto testChar = parent_->testChar();
    auto       table    = lua.create_table();
    auto       idx      = 1;

    for (auto&& pkt : testChar->entity()->getPacketList())
    {
        if (pkt->getType() == static_cast<uint16_t>(PacketS2C::GP_SERV_COMMAND_BATTLE2))
        {
            auto* packet = reinterpret_cast<GP_SERV_COMMAND_BATTLE2*>(pkt.get());
            table[idx++] = packet->unpack();
        }
    }

    return table;
}

/************************************************************************
 *  Function: clear()
 *  Purpose : Clear all packets from the player's packet list
 *  Example : packets:clear()
 *  Notes   : Used to clean up packets between tests
 ************************************************************************/

void CLuaClientEntityPairPackets::clear() const
{
    const auto testChar = parent_->testChar();
    testChar->entity()->clearPacketList();
}

void CLuaClientEntityPairPackets::Register()
{
    SOL_USERTYPE("CClientEntityPairPackets", CLuaClientEntityPairPackets);
    SOL_REGISTER("send", CLuaClientEntityPairPackets::send);
    SOL_REGISTER("getIncoming", CLuaClientEntityPairPackets::getIncoming);
    SOL_REGISTER("actionPackets", CLuaClientEntityPairPackets::actionPackets);
    SOL_REGISTER("clear", CLuaClientEntityPairPackets::clear);
}
