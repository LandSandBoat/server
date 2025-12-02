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

class CCharEntity;
class CBaseEntity;
struct EventInfo;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0032
// This packet is sent by the server to begin an event on the client.
class GP_SERV_COMMAND_EVENT final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_EVENT, GP_SERV_COMMAND_EVENT>
{
public:
    struct PacketData
    {
        uint32_t UniqueNo;   // PS2: UniqueNo
        uint16_t ActIndex;   // PS2: ActIndex
        uint16_t EventNum;   // PS2: EventNum
        uint16_t EventPara;  // PS2: EventPara
        uint16_t Mode;       // PS2: Mode
        uint16_t EventNum2;  // PS2: (New; did not exist.)
        uint16_t EventPara2; // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_EVENT(const CCharEntity* PChar, const EventInfo* eventInfo);
};
