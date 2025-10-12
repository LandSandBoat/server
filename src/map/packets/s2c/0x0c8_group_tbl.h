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

enum class PartyKind : uint8_t;
class CParty;
struct GROUP_TBL
{
    uint32_t UniqueNo;              // PS2: UniqueNo
    uint16_t ActIndex;              // PS2: ActIndex
    uint8_t  PartyNo : 2;           // PS2: PartyNo
    uint8_t  PartyLeaderFlg : 1;    // PS2: PartyLeaderFlg
    uint8_t  AllianceLeaderFlg : 1; // PS2: AllianceLeaderFlg
    uint8_t  PartyRFlg : 1;         // PS2: PartyRFlg
    uint8_t  AllianceRFlg : 1;      // PS2: AllianceRFlg
    uint8_t  unknown06 : 1;         // PS2: MasterComFlg
    uint8_t  unknown07 : 1;         // PS2: SubMasterComFlg
    uint8_t  padding07;             // PS2: (New; was ZoneNo originally.)
    uint16_t ZoneNo;                // PS2: (New; did not exist.)
    uint16_t padding0A;             // PS2: (New; did not exist.)
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00C8
// This packet is sent by the server to update the clients party list information.
class GP_SERV_COMMAND_GROUP_TBL final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_GROUP_TBL, GP_SERV_COMMAND_GROUP_TBL>
{
public:
    struct PacketData
    {
        PartyKind Kind;         // PS2: Kind
        uint8_t   padding05[3]; // PS2: (New; did not exist.)
        GROUP_TBL GroupTbl[20]; // PS2: GroupTbl
    };

    GP_SERV_COMMAND_GROUP_TBL(CParty* PParty, bool loadTrust = false);
};
