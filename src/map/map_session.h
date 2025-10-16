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
#include "common/timer.h"

#include "map_constants.h"
#include "packets/s2c/0x00b_logout.h"

#include <array>

enum class GP_GAME_LOGOUT_STATE : uint8_t;
class CCharEntity;

struct MapSession
{
    IPP                          client_ipp         = {};
    uint16                       client_packet_id   = 0;  // id of the last packet that came from the client
    uint16                       server_packet_id   = 0;  // id of the last packet sent by the server
    NetworkBuffer                server_packet_data = {}; // data of the packet, which was previously sent to the client
    size_t                       server_packet_size = 0;  // the size of the packet that was previously sent to the client
    timer::time_point            last_update        = {}; // time of last packet recv
    blowfish_t                   blowfish           = {}; // unique decypher keys, these are the currently expected keys
    std::unique_ptr<CCharEntity> PChar;                   // game char
    uint8                        shuttingDown = 0;        // prevents double session closing
    uint32                       charID       = 0;
    uint32                       accountID    = 0;

    // Store old blowfish data, when a player recieves 0x00B their key should increment
    // If it doesn't, and we can still successfully decrypt here, that means we need to resend 0x00B.
    blowfish_t prev_blowfish = {};

    // Used to resend 0x00B zoneout packet in case the client needs it
    GP_GAME_LOGOUT_STATE zone_type = GP_GAME_LOGOUT_STATE::NONE;
    IPP                  zone_ipp  = {};

    void incrementBlowfish();
    void initBlowfish();

    auto toString() -> std::string;
};
