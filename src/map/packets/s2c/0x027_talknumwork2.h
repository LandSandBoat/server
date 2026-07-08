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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0027
// This packet is sent by the server to display a formatted message loaded from the DAT files.
class GP_SERV_COMMAND_TALKNUMWORK2 final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_TALKNUMWORK2, GP_SERV_COMMAND_TALKNUMWORK2>
{
public:
    struct PacketData
    {
        uint32_t UniqueNo;    // PS2: UniqueNo
        uint16_t ActIndex;    // PS2: ActIndex
        uint16_t MesNum;      // PS2: MesNum
        uint16_t Type;        // PS2: Type
        uint8_t  Flags;       // PS2: (New; did not exist.)
        uint8_t  padding0F;   // PS2: dummy
        uint32_t Num1[4];     // PS2: Num
        uint8_t  String1[32]; // PS2: String
        uint8_t  String2[16]; // PS2: (New; did not exist.)
        uint32_t Num2[8];     // PS2: (New; did not exist.)
    };

    // Fishing message constructor
    GP_SERV_COMMAND_TALKNUMWORK2(const CCharEntity* PChar, uint16 param0, uint16 messageID, uint8 count);

    // Message with name constructor
    GP_SERV_COMMAND_TALKNUMWORK2(
        CBaseEntity* PActor,
        uint16       messageID,
        CBaseEntity* PNameActor = nullptr,
        int32        param0     = 0,
        int32        param1     = 0,
        int32        param2     = 0,
        int32        param3     = 0,
        int32        chatType   = 4,
        bool         showSender = false);
};
