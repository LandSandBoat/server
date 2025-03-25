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

#include "common/blowfish.h"
#include "common/cbasetypes.h"
#include "common/ipp.h"

#include "map_constants.h"
#include "map_session.h"
#include "map_session_container.h"
#include "map_socket.h"
#include "map_statistics.h"

#include <span>

class MapServer;

class MapNetworking
{
public:
    MapNetworking(MapServer& mapServer, MapStatistics& mapStatistics);

    //
    // Networking
    //

    void tapStatistics();
    auto doSocketsBlocking(duration) -> duration;

    // TODO: Pass around std::span<uint8> instead of uint8* and size_t*
    // TODO: Stop changing the buffsize size_t as we go along
    // TODO: Replace bool with named enum class
    void  handle_incoming_packet(const std::error_code& ec, std::span<uint8> buffer, IPP ipp);
    int32 map_decipher_packet(uint8*, size_t, MapSession*, blowfish_t*); // Decipher packet
    int32 recv_parse(uint8*, size_t*, MapSession*);                      // main function to parse recv packets
    int32 parse(uint8*, size_t*, MapSession*);                           // main function parsing the packets
    int32 send_parse(uint8*, size_t*, MapSession*, bool);                // main function is building big packet

    //
    // Accessors
    //

    auto ipp() -> IPP;
    auto sessions() -> MapSessionContainer&;
    auto socket() -> MapSocket&;

private:
    MapServer&                 mapServer_;
    MapStatistics&             mapStatistics_;
    IPP                        mapIPP_;
    MapSessionContainer        mapSessions_;
    std::unique_ptr<MapSocket> mapSocket_;
};
