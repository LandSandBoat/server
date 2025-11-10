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
#include <string>

class CCharEntity;
class CTrustEntity;
struct GP_GROUP_ATTR
{
    uint32_t PartyNo : 2;           // PS2: PartyNo
    uint32_t PartyLeaderFlg : 1;    // PS2: PartyLeaderFlg
    uint32_t AllianceLeaderFlg : 1; // PS2: AllianceLeaderFlg
    uint32_t PartyRFlg : 1;         // PS2: PartyRFlg
    uint32_t AllianceRFlg : 1;      // PS2: AllianceRFlg
    uint32_t unknown06 : 1;         // PS2: MasterComFlg
    uint32_t unknown07 : 1;         // PS2: SubMasterComFlg
    uint32_t LevelSyncFlg : 1;      // PS2: LevelSyncFlg
    uint32_t unused : 23;           // PS2: dammy
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00DD
// This packet is sent by the server to update a party members information.
class GP_SERV_COMMAND_GROUP_LIST final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_GROUP_LIST, GP_SERV_COMMAND_GROUP_LIST>
{
public:
    struct PacketData
    {
        uint32_t      UniqueNo;        // PS2: UniqueNo
        uint32_t      Hp;              // PS2: Hp
        uint32_t      Mp;              // PS2: Mp
        uint32_t      Tp;              // PS2: Tp
        GP_GROUP_ATTR GAttr;           // PS2: GAttr
        uint16_t      ActIndex;        // PS2: ActIndex
        uint8_t       MemberNumber;    // PS2: (New; was padding.)
        uint8_t       MoghouseFlg;     // PS2: (New; was padding.)
        uint8_t       Kind;            // PS2: Kind
        uint8_t       Hpp;             // PS2: (New; was HpMax)
        uint8_t       Mpp;             // PS2: (New; was MpMax)
        uint8_t       padding1F;       // PS2: (New; did not exist.)
        uint16_t      ZoneNo;          // PS2: ZoneNo
        uint8_t       mjob_no;         // PS2: (New; did not exist.)
        uint8_t       mjob_lv;         // PS2: (New; did not exist.)
        uint8_t       sjob_no;         // PS2: (New; did not exist.)
        uint8_t       sjob_lv;         // PS2: (New; did not exist.)
        uint8_t       masterjob_lv;    // PS2: (New; did not exist.)
        uint8_t       masterjob_flags; // PS2: (New; did not exist.)
        uint8_t       Name[16];        // PS2: Name
    };

    GP_SERV_COMMAND_GROUP_LIST(const CCharEntity* PChar, uint8_t MemberNumber, uint16_t memberflags, uint16_t ZoneID);
    GP_SERV_COMMAND_GROUP_LIST(const CTrustEntity* PTrust, uint8_t MemberNumber);
    GP_SERV_COMMAND_GROUP_LIST(uint32_t id, const std::string& name, uint16_t memberFlags, uint8_t MemberNumber, uint16_t ZoneID);
};
