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

#include "lua_sim_client.h"

#include "map/entities/charentity.h"
#include "map/item_container.h"
#include "map/items/item.h"
#include "map/lua/lua_baseentity.h"
#include "map/packet_system.h"
#include "map/utils/charutils.h"
#include "map/utils/zoneutils.h"
#include "map/zone.h"

#include "lua_simulation.h"
#include "map/map_server.h"
#include "map_networking.h"
#include "test_char.h"

CLuaSimClient::CLuaSimClient(std::unique_ptr<TestChar> testChar, CLuaSimulation* simulation, MapServer* mapServer)
: m_testChar(std::move(testChar))
, m_simulation(simulation)
, m_engine(mapServer)
{
}

CLuaSimClient::~CLuaSimClient()
{
    m_testChar->clearPackets();

    if (m_testChar->getEntity()->isInEvent())
    {
        ShowErrorFmt("Player was in event {} while logging out in {}",
                     m_testChar->getEntity()->currentEvent->eventId,
                     m_testChar->getEntity()->loc.zone->getName());
    }

    m_testChar->getSession()->blowfish.status = BLOWFISH_PENDING_ZONE;

    // Send a zone out packet
    sendBasicPacket(*createPacket(0x0D));
    m_engine->networking().sessions().destroySession(m_testChar->getSession());
}

auto CLuaSimClient::createPacket(uint16 packetType) -> std::unique_ptr<CBasicPacket>
{
    if (packetType >= 512)
    {
        ShowErrorFmt("Packet type has too big value: {}", packetType);
        return nullptr;
    }

    auto packet = std::make_unique<CBasicPacket>();
    packet->setType(packetType);
    packet->setSize(PacketSize[packetType]);
    packet->setSequence(this->m_sequenceNum++);

    return packet;
}

void CLuaSimClient::sendBasicPacket(CBasicPacket& packet) const
{
    ShowDebug("C2S Packet 0x%03hX", packet.ref<uint8>(0x00));
    PacketParser[packet.ref<uint8>(0x00)](m_testChar->getSession(), m_testChar->getEntity(), packet);
}

/************************************************************************
 *  Function: sendPacket()
 *  Purpose : Sends a packet from the client to the server.
 *  Example : client:sendPacket(packet.data)
 *  Notes   : Use PacketBuilder to build the packet data table.
 ************************************************************************/

void CLuaSimClient::sendPacket(sol::table dataTable)
{
    const uint16 packetType = dataTable[1];
    const auto   packet     = createPacket(packetType);

    for (auto& [fst, snd] : dataTable)
    {
        packet->ref<uint8>(fst.as<uint8>()) = snd.as<uint8>();
    }

    sendBasicPacket(*packet);
}

void CLuaSimClient::sendZonePackets()
{
    m_testChar->clearPackets();

    // Subset of what recv_parse does when receiving a zone in packet
    ShowDebug("Destroying PChar and reloading");
    auto* PChar = m_testChar->getEntity();
    destroy(PChar);
    m_testChar->setEntity(charutils::LoadChar(m_testChar->getCharId()));
    m_testChar->setBlowfish(BLOWFISH_PENDING_ZONE);

    ShowDebug("Sending login packet");
    sendBasicPacket(*createPacket(0x0A));

    // We have to tick once for the player to be spawned
    // Note that, zone events may not occur immediately upon zoning,
    // as there is a 2500ms delay set before IsZoning is unset.
    // Therefore, you will need to move time forward by at least 2 seconds
    // and tick once more if you're expecting some sort of event.
    ShowDebug("Ticking once to process zone in");
    m_simulation->tick(1);
}

/************************************************************************
 *  Function: parseIncomingPackets()
 *  Purpose : Processes incoming packets from the server.
 *  Example : client:parseIncomingPackets()
 *  Notes   : Only processes incoming zone requests at the moment.
 ************************************************************************/

void CLuaSimClient::parseIncomingPackets()
{
    bool foundZonePacket = false;

    for (auto&& packet : m_testChar->getEntity()->getPacketList())
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
        ShowDebug("Server is requesting client to zone, sending zone packets");
        sendZonePackets();
    }
}

/************************************************************************
 *  Function: getIncomingPackets()
 *  Purpose : Returns incoming packets for client.
 *  Example : client:getIncomingPackets()
 *  Notes   :
 ************************************************************************/

auto CLuaSimClient::getIncomingPackets() const -> sol::table
{
    auto table = lua.create_table();
    auto idx   = 1;

    for (auto&& packet : m_testChar->getEntity()->getPacketList())
    {
        auto packetTable = lua.create_table();

        packetTable["type"]     = packet->getType();
        packetTable["size"]     = packet->getSize();
        packetTable["sequence"] = packet->getSequence();
        packetTable["data"]     = *packet;

        table[idx++] = packetTable;
    }

    return table;
}

/************************************************************************
 *  Function: tick()
 *  Purpose : Tick the client and process incoming packets.
 *  Example : client:tick()
 *  Notes   :
 ************************************************************************/

void CLuaSimClient::tick()
{
    ShowDebug("Ticking client");
    m_testChar->getSession()->last_update = timer::now();
    parseIncomingPackets();
}

/************************************************************************
 *  Function: getPlayer()
 *  Purpose : Retrieve the underlying CLuaBaseEntity.
 *  Example : player = client:getPlayer()
 *  Notes   : The returned CLuaBaseEntity is only valid until zoned.
 ************************************************************************/

auto CLuaSimClient::getPlayer() const -> CLuaBaseEntity
{
    return CLuaBaseEntity(m_testChar->getEntity());
}

/************************************************************************
 *  Function: getCurrentEventId()
 *  Purpose : Returns the ID of the current event.
 *  Example : client:getCurrentEventId()
 *  Notes   :
 ************************************************************************/

auto CLuaSimClient::getCurrentEventId() const -> uint16
{
    return m_testChar->getEntity()->currentEvent->eventId;
}

/************************************************************************
 *  Function: getItemInvSlot()
 *  Purpose : Returns the slot of a specific item.
 *  Example : client:getItemInvSlot(xi.item.RIDILL, 1)
 *  Notes   : Only for LOC_INVENTORY items.
 ************************************************************************/

auto CLuaSimClient::getItemInvSlot(const uint16 itemId, const uint8 quantity) const -> std::optional<uint16>
{
    uint8 slotId = 0;

    // clang-format off
    m_testChar->getEntity()->getStorage(LOC_INVENTORY)->ForEachItem([&](const CItem* item)
    {
        if (item->getID() == itemId && item->getQuantity() >= quantity)
        {
            slotId = item->getSlotID();
        }
    });
    // clang-format on

    if (slotId != 0)
    {
        return std::make_optional(slotId);
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: gotoZone()
 *  Purpose : Simulates going to a specific zone.
 *  Example : client:gotoZone(xi.zone.RABAO)
 *  Notes   : This bypasses all regular zoning checks, such as zone lines.
 ************************************************************************/

void CLuaSimClient::gotoZone(uint16 zoneId)
{
    ShowDebugFmt("Going to zoneId: {}", zoneId);

    if (zoneutils::GetZone(zoneId) == nullptr)
    {
        ShowDebug("Zone is not currently loaded, loading it now");
        zoneutils::LoadZones({ zoneId });
    }

    // SendToZone _only_ prepares the character for zoning.
    // Furthermore, PChar will be destroyed and reloaded.
    m_testChar->getEntity()->loc.destination = zoneId;
    charutils::SendToZone(m_testChar->getEntity(), zoneId);

    // Client still needs to send the zone in packet
    sendZonePackets();

    // See disclaimer in sendZonePackets()
    // This ensures IsZoning is unset, so the zone can process any pending event.
    m_simulation->tick(2);
}

/************************************************************************
 *  Function: isPendingZone()
 *  Purpose : Is the client currently waiting for a zone change?
 *  Example : client:isPendingZone()
 *  Notes   :
 ************************************************************************/

auto CLuaSimClient::isPendingZone() const -> bool
{
    return m_testChar->getEntity()->requestedZoneChange;
}

void CLuaSimClient::Register()
{
    SOL_USERTYPE("CSimClient", CLuaSimClient);
    SOL_REGISTER("sendPacket", CLuaSimClient::sendPacket);
    SOL_REGISTER("parseIncomingPackets", CLuaSimClient::parseIncomingPackets);
    SOL_REGISTER("getIncomingPackets", CLuaSimClient::getIncomingPackets);
    SOL_REGISTER("getPlayer", CLuaSimClient::getPlayer);
    SOL_REGISTER("getCurrentEventId", CLuaSimClient::getCurrentEventId);
    SOL_REGISTER("getItemInvSlot", CLuaSimClient::getItemInvSlot);
    SOL_REGISTER("gotoZone", CLuaSimClient::gotoZone);
    SOL_REGISTER("isPendingZone", CLuaSimClient::isPendingZone);
}

std::ostream& operator<<(std::ostream& os, const CLuaSimClient& client)
{
    return os << "CLuaSimClient(" << client.getPlayer().getName() << ")";
}
