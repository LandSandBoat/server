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

enum class GP_BAZAAR_BUY_STATE : uint32_t
{
    OK  = 0,
    ERR = 1,
    END = 2
};

class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0106
// This packet is sent by the server when the client has made, or attempted to make, a purchase from another players Bazaar.
class GP_SERV_COMMAND_BAZAAR_BUY final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_BAZAAR_BUY, GP_SERV_COMMAND_BAZAAR_BUY>
{
public:
    struct PacketData
    {
        GP_BAZAAR_BUY_STATE State;
        uint8_t             sName[16];
    };

    GP_SERV_COMMAND_BAZAAR_BUY(const CCharEntity* PChar, GP_BAZAAR_BUY_STATE state);
};
