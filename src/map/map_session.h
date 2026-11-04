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
#include "common/macros.h"
#include "common/timer.h"

#include "map_constants.h"
#include "packets/s2c/0x00b_logout.h"

#include <array>

enum class GP_GAME_LOGOUT_STATE : uint8_t;
class CCharEntity;
class Scheduler;

struct MapSession
{
    // Out-of-line so ~unique_ptr<CCharEntity> is instantiated where CCharEntity is complete
    MapSession();
    ~MapSession();

    DISALLOW_COPY_AND_MOVE(MapSession);

    // TODO: Don't pass the scheduler around in here!
    // This is a dirty hack to pipe the scheduler around into the packet handlers.
    Scheduler* scheduler = nullptr;

    IPP                          client_ipp         = {};
    uint16                       client_packet_id   = 0;  // id of the last packet that came from the client
    uint16                       server_packet_id   = 0;  // id of the last packet sent by the server
    NetworkBuffer                server_packet_data = {}; // data of the packet, which was previously sent to the client
    size_t                       server_packet_size = 0;  // the size of the packet that was previously sent to the client
    earth_time::time_point       last_update        = {}; // time of last packet recv
    blowfish_t                   blowfish           = {}; // unique decypher keys, these are the currently expected keys
    std::unique_ptr<CCharEntity> PChar;                   // game char
    uint8                        shuttingDown       = 0;  // prevents double session closing
    uint32                       charID             = 0;
    uint32                       accountID          = 0;
    uint32                       next_zone_id       = 0;
    bool                         forceLinkDead      = false; // Don't allow last_update tap if forced to die
    bool                         hasDecryptedPacket = false; // used to check if the client still needs an 0x00A
    bool                         hasSentGameOk      = false; // the client has loaded this zone and sent C2S 0x00C
    uint16                       loginSeq           = 0;     // header seq of the last C2S 0x00A taken for this zone
    IPP                          loginIpp           = {};    // where that 0x00A came from
    IPP                          previousLoginIpp   = {};    // the address before it, for a late retry after a NAT rebind
    uint16                       previousLoginSeq   = 0;     // header seq of the last 0x00A taken from there
    timer::time_point            loginTime          = {};    // when the first C2S 0x00A for this key was taken
    timer::time_point            gameOkTime         = {};    // when C2S 0x00C arrived for this zone
    timer::time_point            addressChanged     = {};    // last time a 0x00A moved this session

    // Store old blowfish data, when a player recieves 0x00B their key should increment
    // If it doesn't, and we can still successfully decrypt here, that means we need to resend 0x00B.
    blowfish_t prev_blowfish = {};

    // Used to resend 0x00B zoneout packet in case the client needs it
    GP_GAME_LOGOUT_STATE zone_type = GP_GAME_LOGOUT_STATE::NONE;
    IPP                  zone_ipp  = {};

    // Sent C2S 0x00C, or took so long it never will. Until then most packets and every zone change wait.
    auto hasLoadedZone() const -> bool;

    // Loaded, and long enough ago that S2C 0x00B can't catch the client mid-load
    auto canZoneOut() const -> bool;

    // A plaintext C2S 0x00A this session must not take
    auto isStaleLogin(uint16 seq, const IPP& from) const -> bool;

    // Record a C2S 0x00A the server took
    void takeLogin(uint16 seq, const IPP& from);

    void incrementBlowfish();
    void initBlowfish();
    void tapLastUpdate();

    auto toString() const -> std::string;
};
