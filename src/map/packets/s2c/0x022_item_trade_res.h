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

#include "common/cbasetypes.h"

#include "base.h"

class CCharEntity;

enum class GP_ITEM_TRADE_RES_KIND : uint32_t
{
    Start          = 0, // GP_ITEM_TRADE_RES_KIND_START
    Cancell        = 1, // GP_ITEM_TRADE_RES_KIND_CANCELL
    Make           = 2, // GP_ITEM_TRADE_RES_KIND_MAKE
    MakeCancell    = 3, // GP_ITEM_TRADE_RES_KIND_MAKECANCELL
    ErrEtc         = 4, // GP_ITEM_TRADE_RES_KIND_ERR_ETC
    ErrNoSearchYou = 5, // GP_ITEM_TRADE_RES_KIND_ERR_NOSEARCHYOU
    ErrNowReq      = 6, // GP_ITEM_TRADE_RES_KIND_ERR_NOWREQ
    ErrYouTrade    = 7, // GP_ITEM_TRADE_RES_KIND_ERR_YOUTRADE
    ErrLogout      = 8, // GP_ITEM_TRADE_RES_KIND_ERR_LOGOUT
    End            = 9, // GP_ITEM_TRADE_RES_KIND_END
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0022
// This packet is sent by the server to inform the player of a trade result action.
class GP_SERV_COMMAND_ITEM_TRADE_RES final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_ITEM_TRADE_RES, GP_SERV_COMMAND_ITEM_TRADE_RES>
{
public:
    struct PacketData
    {
        uint32_t               UniqueNo; // PS2: UniqueNo
        GP_ITEM_TRADE_RES_KIND Kind;     // PS2: Kind
        uint16_t               ActIndex; // PS2: ActIndex
    };

    GP_SERV_COMMAND_ITEM_TRADE_RES(const CCharEntity* PChar, GP_ITEM_TRADE_RES_KIND action);
};
