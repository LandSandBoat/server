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
class CTrustEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00DF
// This packet is sent by the server to update a party members information. This packet is similar to 0x00DD, but is used for the local client player and Trust party members.
class GP_SERV_COMMAND_GROUP_ATTR final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_GROUP_ATTR, GP_SERV_COMMAND_GROUP_ATTR>
{
public:
    struct PacketData
    {
        uint32_t UniqueNo;          // PS2: UniqueNo
        uint32_t Hp;                // PS2: Hp
        uint32_t Mp;                // PS2: Mp
        uint32_t Tp;                // PS2: Tp
        uint16_t ActIndex;          // PS2: ActIndex
        uint8_t  Hpp;               // PS2: (New; was HpMax)
        uint8_t  Mpp;               // PS2: (New; was MpMax)
        uint8_t  Kind;              // PS2: Kind
        uint8_t  MoghouseFlg;       // PS2: (New; did not exist.)
        uint16_t ZoneNo;            // PS2: (New; did not exist.)
        uint16_t MonstrosityFlag;   // PS2: (New; did not exist.)
        uint16_t MonstrosityNameId; // PS2: (New; did not exist.)
        uint8_t  mjob_no;           // PS2: (New; did not exist.)
        uint8_t  mjob_lv;           // PS2: (New; did not exist.)
        uint8_t  sjob_no;           // PS2: (New; did not exist.)
        uint8_t  sjob_lv;           // PS2: (New; did not exist.)
        uint8_t  masterjob_lv;      // PS2: (New; did not exist.)
        uint8_t  masterjob_flags;   // PS2: (New; did not exist.)
        uint8_t  padding26[2];      // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_GROUP_ATTR(CCharEntity* PChar);
    GP_SERV_COMMAND_GROUP_ATTR(CTrustEntity* PTrust);
};
