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

enum class MsgStd : uint16_t;
class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0009
// This packet is sent by the server to display general purpose system messages to the client.
// The packet contains the message id to be loaded from the games data files along with the parameters used to populate the strings formatting arguments.
class GP_SERV_COMMAND_MESSAGE final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MESSAGE, GP_SERV_COMMAND_MESSAGE>
{
public:
    struct PacketData
    {
        uint32_t UniqueNo;  // PS2: UniqueNo
        uint16_t ActIndex;  // PS2: ActIndex
        uint16_t MesNo;     // PS2: MesNo
        uint8_t  Attr;      // PS2: Attr
        char     Data[128]; // PS2: Data
    };

    // Debug version - prefer type-safe versions below
    GP_SERV_COMMAND_MESSAGE(uint16 messageID);

    GP_SERV_COMMAND_MESSAGE(MsgStd messageID);
    GP_SERV_COMMAND_MESSAGE(uint32 param0, MsgStd messageID);
    GP_SERV_COMMAND_MESSAGE(const std::string& string2, MsgStd messageID);
    GP_SERV_COMMAND_MESSAGE(uint32 param0, uint32 param1, uint16 messageID);
    GP_SERV_COMMAND_MESSAGE(const CCharEntity* PChar, uint32 param0, MsgStd messageID);
    GP_SERV_COMMAND_MESSAGE(CCharEntity* PChar, uint32 param0, uint32 param1, MsgStd messageID);
    GP_SERV_COMMAND_MESSAGE(uint32 param0, uint32 param1, uint32 param2, uint32 param3, MsgStd messageID);
};
