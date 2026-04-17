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

#include "map_networking.h"

#include <common/arguments.h>
#include <common/md52.h>
#include <common/tracy.h>
#include <common/zlib.h>

#include "entities/charentity.h"

#include "packets/basic.h"
#include "packets/s2c/0x00b_logout.h"

#include "utils/charutils.h"

#include "ipc_client.h"
#include "job_points.h"
#include "latent_effect_container.h"
#include "map_engine.h"
#include "map_session.h"
#include "map_statistics.h"
#include "roe.h"
#include "status_effect_container.h"
#include "transport.h"
#include "zone.h"
#include "zone_entities.h"

extern std::map<uint16, CZone*> g_PZoneList; // Global array of pointers for zones

MapNetworking::MapNetworking(Scheduler& scheduler, MapStatistics& mapStatistics, MapConfig config)
: scheduler_(scheduler)
, mapStatistics_(mapStatistics)
, mapIPP_(config.ipp) // TODO: Refactor to not use this, since we have config_ in here
, config_(config)
, PBuff{}
, PBuffCopy{}
, PScratchBuffer{}
{
    TracyZoneScoped;

    // Embedded map server for testing does not actually need to open a socket
    if (config_.isTestServer)
    {
        return;
    }

    // TODO: Remove all of the SQL query logic that relies IPP being 0.
    try
    {
        const auto udpPort = mapIPP_.getPort() == 0 ? settings::get<uint16>("network.MAP_PORT") : mapIPP_.getPort();
        mapSocket_         = std::make_unique<MapSocket>(scheduler_, udpPort, std::bind(&MapNetworking::handle_incoming_packet, this, std::placeholders::_1, std::placeholders::_2));
    }
    catch (const std::exception& e)
    {
        ShowCriticalFmt("Failed to create MapSocket: {}", e.what());
        std::exit(1);
    }
}

void MapNetworking::handle_incoming_packet(ByteSpan buffer, const IPP& ipp)
{
    TracyZoneScoped;

    // find player session. May be null if there is a pending session for that char id
    MapSession* PSession = mapSessions_.getSessionByIPP(ipp);

    // TODO: Don't copy into PBuff, use buffer directly and smaller scratch buffers if required
    std::memcpy(PBuff.data(), buffer.data(), buffer.size());
    size_t size = buffer.size();

    // set PSession if it's null and the incoming packet is non-encrypted 0x00A
    int32 decryptCount = recv_parse(PBuff.data(), &size, PSession, ipp);
    if (PSession == nullptr)
    {
        return;
    }

    if (decryptCount != -1)
    {
        // DecryptCount of 0 means the main key decrypted the packet
        if (decryptCount == 0 && PSession->PChar)
        {
            // If the previous package was lost, then we do not collect a new one,
            // and send the previous packet again
            if (!parse(PBuff.data(), &size, PSession))
            {
                send_parse(PBuff.data(), &size, PSession, UsePreviousKey::No);
            }
        }
        else if (decryptCount == 1 && PSession->blowfish.status == BLOWFISH_PENDING_ZONE)
        {
            // TODO: Client will send 0x00D in response to 0x00B, so we are probably always sending an extra 0x00B when we don't need to.
            // However, the client will fail to decrypt this if they received it before, effectively being a no-op.
            // It could be beneficial to parse 0x00D here anyway.

            //
            // Client failed to receive 0x00B, manually rebuild it, and copy it into PBuff for
            // re-sending
            //

            mapStatistics_.increment(MapStatistics::Key::TotalPacketsToSendPerTick);

            preparePacket(PBuff.data(), PSession);

            // Build the packet
            GP_SERV_COMMAND_LOGOUT zonePacket(PSession->zone_type, PSession->zone_ipp);
            size = FFXI_HEADER_SIZE;
            zonePacket.setSequence(PSession->server_packet_id);

            // Copy into PBuff
            // TODO: This memcpy is funky, we need to fix the API of BasicPacket and derived
            //     : packets.
            std::memcpy(PBuff.data() + size, &(*zonePacket), zonePacket.getSize());
            size += zonePacket.getSize();

            auto maybePacketSize = compressPacket(PBuff.data(), size);
            if (!maybePacketSize)
            {
                ShowError("zlib compression error");
                size = 0;
            }
            else
            {
                finalizePacket(PBuff.data(), &size, *maybePacketSize, PSession, UsePreviousKey::Yes);
                mapStatistics_.increment(MapStatistics::Key::TotalPacketsSentPerTick);
            }

            // Increment sync count with every packet
            // TODO: match incoming with a new parse that only cares about sync count
            PSession->server_packet_id += 1;
        }

        mapSocket_->send(ipp, { PBuff.data(), size });

        std::swap(PBuff, PSession->server_packet_data);
        std::swap(size, PSession->server_packet_size);
    }

    // If client is logging out, just close it.
    if (PSession->shuttingDown == 1)
    {
        mapSessions_.destroySession(PSession);
    }
}

int32 MapNetworking::map_decipher_packet(uint8* buff, size_t buffsize, MapSession* PSession, blowfish_t* pbfkey)
{
    TracyZoneScoped;

    uint16 tmp = 0;
    uint16 i   = 0;

    // counting blocks whose size = 4 byte
    tmp = (uint16)((buffsize - FFXI_HEADER_SIZE) / 4);
    tmp -= tmp % 2;

    const auto ip = PSession->client_ipp.getIP();

    for (i = 0; i < tmp; i += 2)
    {
        blowfish_decipher((uint32*)buff + i + 7, (uint32*)buff + i + 8, pbfkey->P, pbfkey->S[0]);
    }

    if (checksum((uint8*)(buff + FFXI_HEADER_SIZE), (uint32)(buffsize - (FFXI_HEADER_SIZE + 16)), (char*)(buff + buffsize - 16)) == 0)
    {
        return 0;
    }

    // We can fail to decipher if the client is attempting to zone.
    if (PSession->blowfish.status != BLOWFISH_PENDING_ZONE)
    {
        ShowError(fmt::format("map_decipher_packet: bad packet from <{}>", ip2str(ip)));
    }

    return -1;
}

int32 MapNetworking::recv_parse(uint8* buff, size_t* buffsize, MapSession* PSession, const IPP& ipp)
{
    TracyZoneScoped;

    size_t size           = *buffsize;
    int32  checksumResult = -1;

    try
    {
        if (size <= (FFXI_HEADER_SIZE + 16)) // check for underflow or no-data packet
        {
            return -1;
        }
        checksumResult = checksum((uint8*)(buff + FFXI_HEADER_SIZE), (uint32)(size - (FFXI_HEADER_SIZE + 16)), (char*)(buff + size - 16));
    }
    catch (...)
    {
        ShowError(fmt::format("Possible crash attempt from: {}", ipp.toString()));
        return -1;
    }

    if (checksumResult == 0)
    {
        uint16 packetID = ref<uint16>(buff, FFXI_HEADER_SIZE) & 0x1FF;

        if (packetID != 0x00A)
        {
            return -1;
        }

        // Not big enough to be 0x00A
        if (size < (FFXI_HEADER_SIZE + sizeof(GP_CLI_LOGIN)))
        {
            return -1;
        }

        GP_CLI_LOGIN loginPacket = {};

        std::memcpy(&loginPacket, buff + FFXI_HEADER_SIZE, sizeof(GP_CLI_LOGIN));

        // See LoginPacketCheck from https://github.com/atom0s/XiPackets/tree/main/world/client/0x000A
        uint8 checksum = 0;

        const auto checksumOffset = offsetof(GP_CLI_LOGIN, unknown01);
        const auto checksumLength = sizeof(GP_CLI_LOGIN) - checksumOffset;

        for (int i = 0; i < checksumLength; i++)
        {
            checksum += ref<uint8>(&loginPacket, checksumOffset + i);
        }

        // Failed checksum
        if (checksum != loginPacket.LoginPacketCheck)
        {
            return -1;
        }

        uint32 packetCharID = loginPacket.UniqueNo;

        if (PSession == nullptr)
        {
            auto pendingSession = mapSessions_.getPendingSessionByCharId(packetCharID);
            if (pendingSession)
            {
                mapSessions_.destroyPendingSession(pendingSession);
                PSession = mapSessions_.createSession(ipp);
                if (PSession == nullptr)
                {
                    // TODO: err msg?
                    return -1;
                }
                PSession->scheduler = &scheduler_;
            }
            else
            {
                return -1;
            }
        }

        // We can only get here if an 0x00A (not encrypted) packet was here.
        // If we were pending zones, delete our old char
        if (PSession->blowfish.status == BLOWFISH_PENDING_ZONE)
        {
            PSession->PChar.reset();
        }

        if (PSession->PChar == nullptr)
        {
            uint16 langID    = loginPacket.uCliLang;
            uint32 accountID = 0;

            std::ignore = langID;

            auto rset = db::preparedStmt("SELECT charid FROM chars WHERE charid = ? LIMIT 1", packetCharID);
            if (!rset || rset->rowsCount() == 0 || !rset->next())
            {
                ShowError("recv_parse: Cannot load charid %u", packetCharID);
                return -1;
            }

            rset = db::preparedStmt("SELECT accid FROM chars WHERE charid = ? LIMIT 1", packetCharID);
            if (!rset || rset->rowsCount() == 0 || !rset->next())
            {
                ShowError("recv_parse: Cannot load account id for char id %u", packetCharID);
                return -1;
            }

            accountID = rset->get<uint32>("accid");

            rset = db::preparedStmt("SELECT session_key FROM accounts_sessions WHERE charid = ? LIMIT 1", packetCharID);
            if (rset && rset->rowsCount() && rset->next())
            {
                db::extractFromBlob(rset, "session_key", PSession->blowfish.key);
                PSession->initBlowfish();
            }
            else
            {
                ShowError("recv_parse: Cannot load session_key for charid %u", packetCharID);
            }

            PSession->PChar     = charutils::LoadChar(scheduler_, config_, packetCharID);
            PSession->charID    = packetCharID;
            PSession->accountID = accountID;

            auto* PChar = PSession->PChar.get();

            PChar->PSession = PSession;

            // If we're a new char on a new instance and prevzone != zone
            if (PSession->blowfish.status == BLOWFISH_WAITING && PChar->loc.destination != PChar->loc.prevzone)
            {
                message::send(ipc::KillSession{
                    .victimId = packetCharID,
                });
            }
        }

        PSession->client_packet_id = 0;
        PSession->server_packet_id = 0;
        PSession->zone_ipp         = {};
        PSession->zone_type        = GP_GAME_LOGOUT_STATE::NONE;

        return 0;
    }
    else if (PSession != nullptr)
    {
        if (PSession->blowfish.status == BLOWFISH_PENDING_ZONE)
        {
            // Copy buff into the backup buffer. Blowfish can't be rewound currently.
            std::memcpy(PBuffCopy.data(), buff, *buffsize);
        }

        int decryptCount = 0;

        if (map_decipher_packet(buff, *buffsize, PSession, &PSession->blowfish) == -1)
        {
            // If the client is pending zone, they might not have received 0x00B, and thus not incremented their key
            // Check old blowfish data
            if (PSession->blowfish.status == BLOWFISH_PENDING_ZONE &&
                map_decipher_packet(PBuffCopy.data(), *buffsize, PSession, &PSession->prev_blowfish) != -1)
            {
                // Copy decrypted bytes back into buffer
                std::memcpy(buff, PBuffCopy.data(), *buffsize);
                decryptCount++;
            }
            else
            {
                *buffsize = 0;
                return -1;
            }
        }

        // reading data size
        uint32 PacketDataSize = ref<uint32>(buff, *buffsize - sizeof(int32) - 16);

        // it's decompressing data and getting new size
        PacketDataSize = zlib_decompress((int8*)(buff + FFXI_HEADER_SIZE), PacketDataSize, (int8*)PScratchBuffer.data(), kMaxBufferSize);

        // Not sure why zlib_decompress is defined to return a uint32 when it returns -1 in situations.
        if (static_cast<int32>(PacketDataSize) != -1)
        {
            // it's making result buff
            // don't need std::memcpy header
            std::memcpy(buff + FFXI_HEADER_SIZE, PScratchBuffer.data(), PacketDataSize);
            *buffsize = FFXI_HEADER_SIZE + PacketDataSize;

            return decryptCount;
        }

        return decryptCount;
    }

    return -1;
}

int32 MapNetworking::parse(uint8* buff, size_t* buffsize, MapSession* PSession)
{
    TracyZoneScoped;

    // Start processing the incoming packet
    uint8* PacketData_Begin = &buff[FFXI_HEADER_SIZE];
    uint8* PacketData_End   = &buff[*buffsize];

    auto* PChar = PSession->PChar.get();

    TracyZoneString(PChar->getName());

    uint16 SmallPD_Size = 0;
    uint16 SmallPD_Type = 0;
    uint16 SmallPD_Code = ref<uint16>(buff, 0);

    // TODO: figure out what exactly the client sends when you're not in a CS. there's no C2S packets being sent via the client,
    // and yet we receive something here. It doesnt look like a valid packet, as it has no size and the type is 0x001 which is not valid.
    // TODO: Should unencrypted 0x00As not tap the timer?
    if (PSession->blowfish.status != BLOWFISH_PENDING_ZONE && PSession->blowfish.status != BLOWFISH_WAITING)
    {
        // Update the time we last got a char sync packet
        // The client can spam some other packets when trying to zone, preventing timely session deletions
        PSession->last_update = timer::now();
    }

    for (uint8* SmallPD_ptr = PacketData_Begin; SmallPD_ptr + (ref<uint8>(SmallPD_ptr, 1) & 0xFE) * 2 <= PacketData_End && (ref<uint8>(SmallPD_ptr, 1) & 0xFE);
         SmallPD_ptr        = SmallPD_ptr + SmallPD_Size * 2)
    {
        SmallPD_Size = (ref<uint8>(SmallPD_ptr, 1) & 0x0FE);
        SmallPD_Type = (ref<uint16>(SmallPD_ptr, 0) & 0x1FF);

        if ((ref<uint16>(SmallPD_ptr, 2) <= PSession->client_packet_id) || (ref<uint16>(SmallPD_ptr, 2) > SmallPD_Code))
        {
            continue;
        }

        if (SmallPD_Type != static_cast<uint16>(PacketC2S::GP_CLI_COMMAND_POS))
        {
            DebugPackets("parse: %03hX | %04hX %04hX %02hX from user: %s",
                         SmallPD_Type,
                         ref<uint16>(SmallPD_ptr, 2),
                         ref<uint16>(buff, 2),
                         SmallPD_Size,
                         PChar->getName());
        }

        if (PChar->loc.zone == nullptr && SmallPD_Type != static_cast<uint16>(PacketC2S::GP_CLI_COMMAND_LOGIN))
        {
            // Packets aren't unexpected from the old key under BLOWFISH_PENDING_ZONE
            if (PSession->blowfish.status != BLOWFISH_PENDING_ZONE)
            {
                ShowWarning("This packet is unexpected from %s - Received %03hX earlier without matching 0x0A", PChar->getName(), SmallPD_Type);
            }
        }
        else
        {
            auto basicPacket = CBasicPacket::createFromBuffer(SmallPD_ptr);
            ShowTraceFmt("map::parse: Char: {} ({}): {}", PChar->getName(), PChar->id, hex16ToString(basicPacket->getType()));
            packetSystem_.dispatch(SmallPD_Type, PSession, PChar, *basicPacket);
        }
    }

    if (PChar->retriggerLatents)
    {
        for (uint8 equipSlotID = 0; equipSlotID < 16; ++equipSlotID)
        {
            if (PChar->equip[equipSlotID] != 0)
            {
                PChar->PLatentEffectContainer->CheckLatentsEquip(equipSlotID);
            }
        }
        PChar->retriggerLatents = false; // reset as we have retriggered the latents somewhere
    }

    // Flush any batched equip changes after processing all incoming packets
    PChar->flushEquipChanges();

    PSession->client_packet_id = SmallPD_Code;

    // Google Translate:
    // here we check if the client received the previous package
    // if not received, then we do not create a new one, but send the previous one

    if (ref<uint16>(buff, 2) != PSession->server_packet_id)
    {
        // If the client and server have become out of sync, then caching takes place. However, caching
        // zone packets will result in the client never properly connecting. Ignore those specifically.
        if (SmallPD_Type == static_cast<uint16>(PacketC2S::GP_CLI_COMMAND_LOGIN))
        {
            return 0;
        }

        ref<uint16>(PSession->server_packet_data.data(), 2) = SmallPD_Code;
        ref<uint16>(PSession->server_packet_data.data(), 8) = earth_time::timestamp();

        PBuff     = PSession->server_packet_data;
        *buffsize = PSession->server_packet_size;

        std::memcpy(PSession->server_packet_data.data(), buff, *buffsize);

        return -1;
    }

    // GT: increase the number of the sent packet only if new data is sent

    PSession->server_packet_id += 1;

    return 0;
}

int32 MapNetworking::send_parse(uint8* buff, size_t* buffsize, MapSession* PSession, UsePreviousKey usePreviousKey)
{
    TracyZoneScoped;

    preparePacket(buff, PSession);

    // build a large package, consisting of several small packets
    auto* PChar = PSession->PChar.get();
    TracyZoneString(PChar->name);

    std::unique_ptr<CBasicPacket> PSmallPacket = nullptr;

    size_t PacketSize               = static_cast<size_t>(UINT32_MAX);
    size_t PacketCount              = std::clamp<size_t>(PChar->getPacketCount(), 0, kMaxPacketPerCompression);
    uint8  packets                  = 0;
    bool   incrementKeyAfterEncrypt = false;

    mapStatistics_.increment(MapStatistics::Key::TotalPacketsToSendPerTick, static_cast<uint32>(PChar->getPacketCount()));

    do
    {
        do
        {
            *buffsize       = FFXI_HEADER_SIZE;
            auto packetList = PChar->getPacketListCopy();
            packets         = 0;

            while (!packetList.empty() && *buffsize + packetList.front()->getSize() < kMaxBufferSize && static_cast<size_t>(packets) < PacketCount)
            {
                PSmallPacket = std::move(packetList.front());
                packetList.pop_front();

                PSmallPacket->setSequence(PSession->server_packet_id);
                auto type = PSmallPacket->getType();

                // Store zoneout packet in case we need to re-send this
                if (type == 0x00B)
                {
                    const auto IPPacket = static_cast<GP_SERV_COMMAND_LOGOUT*>(PSmallPacket.get());

                    PSession->zone_ipp  = IPPacket->zoneIPP();
                    PSession->zone_type = IPPacket->zoneType();

                    incrementKeyAfterEncrypt = true;

                    // Set client port to zero, indicating the client tried to zone out and no longer has a port until the next 0x00A
                    db::preparedStmt("UPDATE accounts_sessions SET client_port = 0, last_zoneout_time = NOW() WHERE charid = ?", PSession->charID);
                }

                std::memcpy(buff + *buffsize, *PSmallPacket, PSmallPacket->getSize());

                *buffsize += PSmallPacket->getSize();

                packets++;
            }

            PacketCount -= PacketCount / 3;

            // Compress the data without regard to the header
            // The returned size is 8 times the real data
            auto maybePacketSize = compressPacket(buff, static_cast<size_t>(*buffsize));
            if (!maybePacketSize)
            {
                ShowError("zlib compression error");
                continue;
            }
            PacketSize = *maybePacketSize;
        } while (PacketCount > 0 && PacketSize > 1300 - FFXI_HEADER_SIZE - 16); // max size for client to accept

        if (PacketSize == static_cast<uint32>(-1))
        {
            if (PChar->getPacketCount() > 0)
            {
                PChar->erasePackets(1);
                PacketCount = PChar->getPacketCount();
            }
            else
            {
                *buffsize = 0;
                return -1;
            }
        }
    } while (PacketSize == static_cast<uint32>(-1));

    PChar->erasePackets(packets);

    mapStatistics_.increment(MapStatistics::Key::TotalPacketsSentPerTick, static_cast<uint32>(packets));
    TracyZoneString(fmt::format("Sending {} packets", packets));

    finalizePacket(buff, buffsize, PacketSize, PSession, usePreviousKey);

    auto remainingPackets = PChar->getPacketCount();
    mapStatistics_.increment(MapStatistics::Key::TotalPacketsDelayedPerTick, static_cast<uint32>(remainingPackets));

    if (settings::get<bool>("logging.DEBUG_PACKET_BACKLOG"))
    {
        TracyZoneString(fmt::format("{} packets remaining", remainingPackets));
        if (remainingPackets > kMaxPacketBacklogSize)
        {
            if (PChar->loc.zone == nullptr)
            {
                ShowWarning(fmt::format("Packet backlog exists for char {} with a nullptr zone. Clearing packet list.", PChar->name));
                PChar->clearPacketList();
                return 0;
            }
            ShowWarning(fmt::format("Packet backlog for char {} in {} is {}! Limit is: {}",
                                    PChar->name,
                                    PChar->loc.zone->getName(),
                                    remainingPackets,
                                    kMaxPacketBacklogSize));
        }
    }

    // Increment the key after 0x00B was sent (otherwise the client would never get it!)
    if (incrementKeyAfterEncrypt)
    {
        PSession->incrementBlowfish();

        db::preparedStmt("UPDATE accounts_sessions SET session_key = ? WHERE charid = ? LIMIT 1",
                         PSession->blowfish.key,
                         PChar->id);

        // see https://github.com/atom0s/XiPackets/blob/main/world/server/0x000B/README.md
        // GP_GAME_LOGOUT_STATE::GP_GAME_LOGOUT_STATE_LOGOUT = disconnect/logout/shutdown
        if (PSession->zone_type != GP_GAME_LOGOUT_STATE::LOGOUT)
        {
            message::send(ipc::CharZone{
                .charId            = PChar->id,
                .destinationZoneId = PChar->loc.destination,
            });
        }

        PSession->blowfish.status = BLOWFISH_PENDING_ZONE;
        PChar->PSession->PChar.reset(); // destroy PChar
    }

    return 0;
}

void MapNetworking::preparePacket(uint8* buff, MapSession* PSession)
{
    TracyZoneScoped;

    // Modify the header of the outgoing packet
    // The essence of the transformations:
    // - send the client the number of the last packet received from him
    // - assign the outgoing packet the number of the last packet sent to the client +1
    // - write down the current time of sending the packet

    ref<uint16>(buff, 0) = PSession->server_packet_id;
    ref<uint16>(buff, 2) = PSession->client_packet_id;

    // save the current time (32 BIT!)
    ref<uint32>(buff, 8) = earth_time::timestamp();
}

auto MapNetworking::compressPacket(uint8* buff, size_t buffsize) -> Maybe<size_t>
{
    TracyZoneScoped;

    // Compress the data without regard to the header
    // The returned size is 8 times the real data
    int32 result = zlib_compress((int8*)(buff + FFXI_HEADER_SIZE), (uint32)(buffsize - FFXI_HEADER_SIZE), (int8*)PScratchBuffer.data(), kMaxBufferSize);

    // handle compression error
    if (result == -1)
    {
        return std::nullopt;
    }

    auto packetSize = static_cast<size_t>(result);

    ref<uint32>(PScratchBuffer.data(), zlib_compressed_size(packetSize)) = static_cast<uint32>(packetSize);

    packetSize = zlib_compressed_size(packetSize) + 4;

    return packetSize;
}

void MapNetworking::finalizePacket(uint8* buff, size_t* buffsize, size_t PacketSize, MapSession* PSession, UsePreviousKey usePreviousKey)
{
    TracyZoneScoped;

    // Record data size excluding header
    uint8 hash[16];
    md5(PScratchBuffer.data(), hash, static_cast<int32>(PacketSize));
    std::memcpy(PScratchBuffer.data() + PacketSize, hash, 16);
    PacketSize += 16;

    if (PacketSize > kMaxBufferSize)
    {
        ShowCritical("Network: PScratchBuffer is overflowed (%u)", PacketSize);
    }

    // Making total outgoing packet
    std::memcpy(buff + FFXI_HEADER_SIZE, PScratchBuffer.data(), PacketSize);

    uint32 CypherSize = (PacketSize / 4) & -2;

    blowfish_t* pbfkey = nullptr;

    if (PSession->blowfish.status == BLOWFISH_PENDING_ZONE && usePreviousKey == UsePreviousKey::Yes)
    {
        pbfkey = &PSession->prev_blowfish;
    }
    else
    {
        pbfkey = &PSession->blowfish;
    }

    for (uint32 j = 0; j < CypherSize; j += 2)
    {
        blowfish_encipher((uint32*)(buff) + j + 7, (uint32*)(buff) + j + 8, pbfkey->P, pbfkey->S[0]);
    }

    *buffsize = PacketSize + FFXI_HEADER_SIZE;
}

void MapNetworking::flushStatistics()
{
    // Collect statistics
    // TODO: Collect these inline
    std::size_t activeZoneCount       = 0;
    std::size_t playerCount           = 0;
    std::size_t mobCount              = 0;
    std::size_t dynamicTargIdCount    = 0;
    std::size_t dynamicTargIdCapacity = 0;

    for (auto& [id, PZone] : g_PZoneList)
    {
        if (PZone->IsZoneActive())
        {
            activeZoneCount += 1;
            playerCount += PZone->GetZoneEntities()->GetCharList().size();
            mobCount += PZone->GetZoneEntities()->GetMobList().size();
            dynamicTargIdCount += PZone->GetZoneEntities()->GetUsedDynamicTargIDsCount();
            dynamicTargIdCapacity += 511;
        }
    }

    // Set statistics
    mapStatistics_.set(MapStatistics::Key::ActiveZones, activeZoneCount);
    mapStatistics_.set(MapStatistics::Key::ConnectedPlayers, playerCount);
    mapStatistics_.set(MapStatistics::Key::ActiveMobs, mobCount);

    const auto percent = dynamicTargIdCapacity > 0
                             ? static_cast<double>(dynamicTargIdCount) / static_cast<double>(dynamicTargIdCapacity) * 100.0
                             : 0.0;

    mapStatistics_.set(MapStatistics::Key::DynamicTargIdUsagePercent, static_cast<int64>(percent));

    // This also zeroes out all the stats
    mapStatistics_.flush();
}

auto MapNetworking::ipp() const -> IPP
{
    return mapIPP_;
}

auto MapNetworking::sessions() -> MapSessionContainer&
{
    return mapSessions_;
}

auto MapNetworking::scheduler() -> Scheduler&
{
    return scheduler_;
}

auto MapNetworking::socket() -> MapSocket&
{
    return *mapSocket_;
}

auto MapNetworking::packetSystem() -> PacketSystem&
{
    return packetSystem_;
}
