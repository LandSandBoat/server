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

#include "base.h"
#include "common/ipp.h"

class CCharEntity;

// PS2: GP_GAME_LOGOUT_STATE
enum class GP_GAME_LOGOUT_STATE : uint8_t
{
    NONE           = 0,
    LOGOUT         = 1,
    ZONECHANGE     = 2,
    MYROOM         = 3,
    CANCELL        = 4,
    POLEXIT        = 5,
    JOBEXIT        = 6,
    POLEXIT_MYROOM = 7,
    TIMEOUT        = 8,
    GMLOGOUT       = 9,
    END            = 10,
};

// PS2: GP_GAME_ECODE
enum class GP_GAME_ECODE : uint32_t
{
    NOERR      = 0,
    RESERR     = 1,
    ZONEDOWN   = 2,
    REGERR     = 3,
    CLIVERSERR = 4,
    CLINOEXERR = 5,
    UNKNOWN    = 6,
    MAX        = 7,
};

struct GP_SERV_LOGOUTSUB
{
    uint32_t ip;
    uint32_t port;
    uint8_t  padding00[8];
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x000B
// This packet is sent by the server to respond to a client zone request.
// The client sends different kinds of requests related to this packet.
// For example, when walking between zones, the client will send a zone line request (0x5B) packet which can trigger this response.
// The client will also send a logout request when exiting the game (ie. via /shutdown) which will also see this packet response.
class GP_SERV_COMMAND_LOGOUT final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_LOGOUT, GP_SERV_COMMAND_LOGOUT>
{
public:
    struct PacketData
    {
        GP_GAME_LOGOUT_STATE LogoutState; // PS2: LogoutState
        GP_SERV_LOGOUTSUB    Iwasaki;     // PS2: Iwasaki - This is uint8_t[16] when not passing IP/Port
        GP_GAME_ECODE        cliErrCode;  // PS2: cliErrCode
    };

    inline auto zoneType() const -> GP_GAME_LOGOUT_STATE
    {
        return this->data().LogoutState;
    }

    inline auto zoneIPP() const -> IPP
    {
        return IPP(this->data().Iwasaki.ip, this->data().Iwasaki.port);
    }

    GP_SERV_COMMAND_LOGOUT(GP_GAME_LOGOUT_STATE zoneType, IPP zoneIpp);
};
