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
#include "enums/emote.h"

class CCharEntity;
class CNpcEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x005A
// This packet is sent when executing emotes
class GP_SERV_COMMAND_MOTIONMES final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MOTIONMES, GP_SERV_COMMAND_MOTIONMES>
{
public:
    struct PacketData
    {
        uint32_t  CasUniqueNo;      // PS2: CasUniqueNo
        uint32_t  TarUniqueNo;      // PS2: TarUniqueNo
        uint16_t  CasActIndex;      // PS2: CasActIndex
        uint16_t  TarActIndex;      // PS2: TarActIndex
        uint16_t  MesNum;           // PS2: MesNum
        uint16_t  Param;            // PS2: (New; did not exist.)
        uint16_t  unknown14;        // PS2: (New; did not exist.)
        EmoteMode Mode;             // PS2: Mode
        uint8_t   padding00;        // PS2: (New; did not exist.)
        uint32_t  FaithUniqueNo[5]; // PS2: (New; did not exist.)
        uint16_t  FaithActIndex[5]; // PS2: (New; did not exist.)
        uint16_t  padding01;        // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_MOTIONMES(const CCharEntity* PChar, uint32 targetId, uint16 targetIndex, Emote emoteId, EmoteMode emoteMode, uint16 extra);
    GP_SERV_COMMAND_MOTIONMES(const CNpcEntity* PEntity, uint32 targetId, uint16 targetIndex, Emote emoteId, EmoteMode emoteMode);
};
