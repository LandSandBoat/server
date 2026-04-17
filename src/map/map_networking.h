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

#pragma once

#include <common/blowfish.h>
#include <common/cbasetypes.h>
#include <common/ipp.h>
#include <common/scheduler.h>

#include "map_config.h"
#include "map_constants.h"
#include "map_session.h"
#include "map_session_container.h"
#include "map_socket.h"
#include "map_statistics.h"
#include "packet_system.h"

class CBasicPacket;

class MapNetworking
{
public:
    using UsePreviousKey = xi::Flag<struct UsePreviousKeyTag>;

    MapNetworking(Scheduler& scheduler, MapStatistics& mapStatistics, MapConfig config);

    //
    // Networking
    //

    // TODO: Pass around std::span<uint8> instead of uint8* and size_t*
    // TODO: Stop changing the buffsize size_t as we go along
    // TODO: All of these need to become coroutines
    // TODO: Properly use size_t or u32/i32 where appropriate, we do a lot of casting
    // TODO: Do better than returning -1 as an error code
    void handle_incoming_packet(ByteSpan buffer, const IPP& ipp);

    // Decipher packet
    int32 map_decipher_packet(uint8* buff, size_t buffsize, MapSession* PSession, blowfish_t* pbfkey);

    // main function to parse recv packets
    int32 recv_parse(uint8* buff, size_t* buffsize, MapSession* PSession, const IPP& ipp);

    // main function parsing the packets
    int32 parse(uint8* buff, size_t* buffsize, MapSession* PSession);

    // main function is building big packet
    int32 send_parse(uint8* buff, size_t* buffsize, MapSession* PSession, UsePreviousKey usePreviousKey);

    //
    // Packet Building
    //

    // Sets header, sequence, timestamp
    void preparePacket(uint8* buff, MapSession* PSession);

    // Add payload between preparePacket and compressPacket

    auto compressPacket(uint8* buff, size_t buffsize) -> Maybe<size_t>;

    // Sets MD5 hash, blowfish, final buffer size
    void finalizePacket(uint8* buff, size_t* buffsize, size_t PacketSize, MapSession* PSession, UsePreviousKey usePreviousKey);

    //
    // Utils
    //

    void flushStatistics();

    //
    // Accessors
    //

    auto ipp() const -> IPP;
    auto sessions() -> MapSessionContainer&;
    auto scheduler() -> Scheduler&;
    auto socket() -> MapSocket&;
    auto packetSystem() -> PacketSystem&;

private:
    Scheduler&                 scheduler_;
    MapStatistics&             mapStatistics_;
    IPP                        mapIPP_;
    MapSessionContainer        mapSessions_;
    std::unique_ptr<MapSocket> mapSocket_;
    MapConfig                  config_;

    // TODO: We can probably dedupe these and move the main buffer into MapSocket, passing a span
    //     : to it back into here when we've got our buffer of network data.
    // TODO: Update the naming conventions of these
    NetworkBuffer PBuff;          // Global packet clipboard
    NetworkBuffer PBuffCopy;      // Copy of above, used to decrypt a second time if necessary.
    NetworkBuffer PScratchBuffer; // Temporary packet clipboard

    PacketSystem packetSystem_;
};
