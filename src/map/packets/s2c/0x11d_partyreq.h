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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x011D
// This packet is sent by the server to inform the client of a party invite request. (Using the newer party request system.)
class GP_SERV_COMMAND_PARTYREQ final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_PARTYREQ, GP_SERV_COMMAND_PARTYREQ>
{
public:
    struct PacketData
    {
        uint32_t UniqueNo;     // PS2: UniqueNo
        uint16_t ActIndex;     // PS2: ActIndex
        uint8_t  Flags;        // PS2: Flags
        uint8_t  Status;       // PS2: Status
        uint8_t  sName[16];    // PS2: sName
        uint16_t Race;         // PS2: Race
        uint8_t  padding1E[2]; // PS2: (New; did not exist.)
    };

    // TODO: Unimplemented
    GP_SERV_COMMAND_PARTYREQ() = default;
};
