/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "gmcall_container.h"
#include "common/database.h"
#include "common/ipc_structs.h"
#include "common/logging.h"
#include "entities/charentity.h"
#include "ipc_client.h"
#include "packets/s2c/0x0b6_set_gmmsg.h"

#include <algorithm>
#include <unordered_set>

namespace
{
constexpr std::size_t MAX_GMCALL_PACKETS = 6; // Arbitrary limit. Observed 3 packets at most.

const std::unordered_set<std::string> ALLOWED_GMCALL_PARAMS = {
    "GENERIC.AREACODE",
    "GENERIC.CLILANG",
    "GENERIC.SELLANG",
    "GENERIC.PLATFORM",
    "GENERIC.VERSION",
    "GAME.INFIELD",
    "GAME.GMTIME",
    "EXEC.LOGOUT",
    "EXEC.POLEXIT",
    "EXEC.RESCUE",
    "GMREPORT.NOTICE",
    "GMREPORT.GMCALL",
    "GMREPORT.HARASSMENT",
    "GMREPORT.STUCK",
    "GMREPORT.BLOCK",
    "GMCALL.INPUT",
};
} // namespace

// Store one GMCALL packet for later processing
auto GMCallContainer::addPacket(const GP_CLI_COMMAND_FAQ_GMCALL& packet) -> bool
{
    if (packet.pktId != pktId_)
    {
        clear();
        pktId_ = packet.pktId;
    }

    if (packets_.size() >= MAX_GMCALL_PACKETS)
    {
        ShowWarning("GMCallContainer: Packet limit reached. Possible abuse.");
        return false;
    }

    packets_.push_back(packet);

    return packet.eos == 1; // Notify this was the last packet of the current GM call.
}

void GMCallContainer::clear()
{
    packets_.clear();
    pktId_ = 0;
}

// Build the actual GM call out of multiple packets
void GMCallContainer::processCall(const CCharEntity* PChar) const
{
    std::map<std::string, std::string> parameters;
    std::string                        message;

    // Reorder fragments by sequence ID
    auto sortedPackets = packets_;
    std::ranges::sort(sortedPackets,
                      [](const auto& a, const auto& b)
                      {
                          return a.seq < b.seq;
                      });

    for (const auto& packet : sortedPackets)
    {
        std::size_t offset = 0;
        for (uint8_t block = 0; block < packet.blkNum && offset < sizeof(packet.Data); ++block)
        {
            if (offset + sizeof(FFGpGMReportBlockHdr) > sizeof(packet.Data))
            {
                break;
            }

            const auto* header    = reinterpret_cast<const FFGpGMReportBlockHdr*>(&packet.Data[offset]);
            const auto  blockSize = header->bkLength;

            if (blockSize < sizeof(FFGpGMReportBlockHdr) || offset + blockSize > sizeof(packet.Data))
            {
                break;
            }

            switch (static_cast<GMReportBlockType>(header->bkType))
            {
                case GMReportBlockType::Position:
                {
                    // This contains client reported position but is not generally useful.
                    break;
                }
                case GMReportBlockType::Version:
                {
                    if (blockSize >= sizeof(sub_block_01_t))
                    {
                        const auto* blk                 = reinterpret_cast<const sub_block_01_t*>(&packet.Data[offset]);
                        parameters["VERSION.UNKNOWN00"] = std::to_string(blk->unknown00);
                        parameters["VERSION.UNKNOWN01"] = fmt::format("{},{},{},{}", blk->unknown01[0], blk->unknown01[1], blk->unknown01[2], blk->unknown01[3]);
                    }
                    break;
                }
                case GMReportBlockType::Error:
                {
                    if (blockSize >= sizeof(FFGpGMReportECodeStruct))
                    {
                        const auto* blk              = reinterpret_cast<const FFGpGMReportECodeStruct*>(&packet.Data[offset]);
                        parameters["ERROR.CODE"]     = std::to_string(blk->code);
                        parameters["ERROR.COUNT"]    = std::to_string(blk->count);
                        parameters["ERROR.TIMECODE"] = std::to_string(blk->timeCode);
                    }
                    break;
                }
                case GMReportBlockType::StringParam:
                {
                    const auto  strLen  = std::min<std::size_t>(blockSize - sizeof(FFGpGMReportBlockHdr), sizeof(sub_block_03_t::Str));
                    const auto* strData = reinterpret_cast<const char*>(&packet.Data[offset + sizeof(FFGpGMReportBlockHdr)]);
                    std::string param(strData, strnlen(strData, strLen));

                    if (const auto colonPos = param.find(':'); colonPos != std::string::npos)
                    {
                        auto       key   = param.substr(0, colonPos);
                        const auto value = param.substr(colonPos + 1);
                        if (!ALLOWED_GMCALL_PARAMS.contains(key))
                        {
                            ShowWarning("GMCallContainer: Unknown parameter key. Ignoring.");
                        }
                        else
                        {
                            parameters[key] = value;
                            if (key == "GMCALL.INPUT")
                            {
                                message = value;
                            }
                        }
                    }
                    break;
                }
                case GMReportBlockType::LobbyHistory:
                {
                    const auto  dataSize   = blockSize - sizeof(FFGpGMReportBlockHdr);
                    const auto  numEntries = std::min(dataSize / sizeof(FFGpGMReportLobbyEntry), std::size_t(8));
                    const auto* entries    = reinterpret_cast<const FFGpGMReportLobbyEntry*>(&packet.Data[offset + sizeof(FFGpGMReportBlockHdr)]);

                    for (std::size_t i = 0; i < numEntries; ++i)
                    {
                        if (entries[i].ident == 0)
                        {
                            continue;
                        }

                        auto prefix                      = fmt::format("LOBBY.{}", i);
                        parameters[prefix + ".CMD"]      = std::to_string(entries[i].cmd);
                        parameters[prefix + ".OPT"]      = std::to_string(entries[i].opt);
                        parameters[prefix + ".TIMECODE"] = std::to_string(entries[i].timeCode);
                        parameters[prefix + ".IDENT"]    = std::to_string(entries[i].ident);
                        parameters[prefix + ".NAME"]     = std::string(reinterpret_cast<const char*>(entries[i].name), strnlen(reinterpret_cast<const char*>(entries[i].name), sizeof(entries[i].name)));
                    }
                    break;
                }
                default:
                    break;
            }

            offset += blockSize;
        }
    }

    uint32 callId = 0;
    db::transaction([&]()
                    {
                        db::preparedStmt("INSERT INTO help_desk (charid, message) VALUES (?, ?)", PChar->id, message);
                        if (const auto rset = db::preparedStmt("SELECT LAST_INSERT_ID() AS id"); rset && rset->next())
                        {
                            callId = rset->get<uint32>("id");
                        }
                    });

    // Send the GM call to xi_world for rerouting to external listeners
    message::send(ipc::GMCallRequest{
        .callId     = callId,
        .charId     = PChar->id,
        .charName   = PChar->name,
        .accId      = PChar->accid,
        .zoneId     = PChar->getZone(),
        .posX       = PChar->loc.p.x,
        .posY       = PChar->loc.p.y,
        .posZ       = PChar->loc.p.z,
        .message    = message,
        .parameters = parameters,
    });
}

// On zone-in, check if the player has any pending unacknowledged response and build the packets if so.
void GMCallContainer::sendPendingResponse(CCharEntity* PChar) const
{
    TracyZoneScoped;

    const auto rset = db::preparedStmt("SELECT id, response "
                                       "FROM help_desk "
                                       "WHERE charid = ? AND response IS NOT NULL AND deleted_at IS NULL "
                                       "ORDER BY id ASC LIMIT 1",
                                       PChar->id);
    FOR_DB_SINGLE_RESULT(rset)
    {
        const auto callId   = rset->get<uint32>("id");
        const auto response = rset->get<std::string>("response");

        // Max 244 characters per packet, with an upper limit of 1024 characters.
        constexpr std::size_t maxPerPacket = sizeof(GP_SERV_COMMAND_SET_GMMSG::PacketData::Msg);
        const auto            totalPackets = (response.size() + maxPerPacket - 1) / maxPerPacket;

        for (std::size_t i = 0; i < totalPackets; ++i)
        {
            const auto chunkOffset = i * maxPerPacket;
            const auto chunkSize   = std::min(response.size() - chunkOffset, maxPerPacket);
            const auto chunk       = response.substr(chunkOffset, chunkSize);
            const auto seqId       = static_cast<uint16_t>(i + 1);
            const auto pktNum      = static_cast<uint16_t>((i == totalPackets - 1) ? 0 : seqId);

            PChar->pushPacket<GP_SERV_COMMAND_SET_GMMSG>(callId, seqId, pktNum, chunk);
        }
    }
}

// Marks the oldest unacknowledged response as read/deleted.
void GMCallContainer::acknowledgeOldestResponse(CCharEntity* PChar) const
{
    TracyZoneScoped;

    db::preparedStmt("UPDATE help_desk "
                     "SET deleted_at = NOW() "
                     "WHERE charid = ? AND response IS NOT NULL AND deleted_at IS NULL "
                     "ORDER BY id ASC LIMIT 1",
                     PChar->id);

    // Send another response if player has multiple queued.
    sendPendingResponse(PChar);
}
