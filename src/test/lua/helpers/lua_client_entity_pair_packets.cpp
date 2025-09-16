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

#include "common/logging.h"
#include "common/lua.h"
#include "lua/lua_client_entity_pair.h"
#include "lua/lua_simulation.h"
#include "lua/sol_bindings.h"
#include "map/packet_system.h"
#include "map/packets/c2s/0x00a_login.h"
#include "test_char.h"
#include "test_common.h"
#include "utils/charutils.h"

CLuaClientEntityPairPackets::CLuaClientEntityPairPackets(CLuaClientEntityPair* parent)
: parent_(parent)
{
}

auto CLuaClientEntityPairPackets::createPacket(uint16 packetType) -> std::unique_ptr<CBasicPacket>
{
    if (packetType >= 512)
    {
        ShowErrorFmt("Packet type has too big value: {}", packetType);
        return nullptr;
    }

    auto packet = std::make_unique<CBasicPacket>();
    packet->setType(packetType);
    packet->setSize(PacketSize[packetType]);
    packet->setSequence(sequenceNum_++);

    return packet;
}

void CLuaClientEntityPairPackets::sendBasicPacket(CBasicPacket& packet) const
{
    const auto testChar = parent_->testChar();
    DebugTestFmt("Sending C2S Packet 0x{:03X}", packet.ref<uint8>(0x00));
    PacketParser[packet.ref<uint8>(0x00)](testChar->session(), testChar->entity(), packet);
}

/************************************************************************
 *  Function: send()
 *  Purpose : Send a packet from FFI cdata
 *  Example : packets:send(0x1A, ffiPacket, ffi.sizeof(ffiPacket))
 *  Notes   : Takes packet ID, FFI struct pointer, and struct size
 ************************************************************************/

void CLuaClientEntityPairPackets::send(const uint16 packetId, const sol::object& ffiData, const size_t ffiSize)
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
    packet->setType(packetId);
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
    testChar->clearPackets();

    ShowInfoFmt("Reloading character {} for zone change", testChar->charId());
    testChar->setEntity(charutils::LoadChar(testChar->charId()));
    testChar->setBlowfish(BLOWFISH_PENDING_ZONE);

    // IMPORTANT: Both TestChar and CLuaClientEntityPair wrapper need to be updated
    // TestChar holds the actual CCharEntity, while parent_ is the Lua wrapper
    // that also needs its internal pointer updated to the newly loaded entity
    parent_->setEntity(testChar->entity());

    const auto loginPacket = createPacket(0x0A);
    auto*      login       = loginPacket->as<GP_CLI_COMMAND_LOGIN>();
    login->UniqueNo        = testChar->charId();

    sendBasicPacket(*loginPacket);

    // We have to tick once for the player to be spawned
    parent_->simulation()->skipTime(3);
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

void CLuaClientEntityPairPackets::Register()
{
    SOL_USERTYPE("CClientEntityPairPackets", CLuaClientEntityPairPackets);
    SOL_REGISTER("send", CLuaClientEntityPairPackets::send);
    SOL_REGISTER("getIncoming", CLuaClientEntityPairPackets::getIncoming);
}
