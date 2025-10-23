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

enum CHAT_MESSAGE_TYPE : uint8_t;
class CCharEntity;
namespace ipc
{
    struct ChatMessageAssist;
}

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0017
// This packet is sent by the server to display chat messages to the client.
// The contents of this packet can vary based on the message Kind.
class GP_SERV_COMMAND_CHAT_STD final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHAT_STD, GP_SERV_COMMAND_CHAT_STD>
{
public:
    struct PacketData
    {
        CHAT_MESSAGE_TYPE Kind;      // PS2: Kind
        uint8_t           Attr;      // PS2: Attr
        uint16_t          Data;      // PS2: (New; did not exist.)
        uint8_t           sName[15]; // PS2: sName
        uint8_t           Mes[128];  // PS2: Mes - Variable sized array
    };

    // Standard constructor
    GP_SERV_COMMAND_CHAT_STD(const CCharEntity* PChar, CHAT_MESSAGE_TYPE MessageType, std::string const& message, std::string const& sender = std::string());

    // Zone-based constructor
    GP_SERV_COMMAND_CHAT_STD(const std::string& name, uint16 zone, CHAT_MESSAGE_TYPE MessageType, const std::string& message, uint8 gmLevel = 0);

    // IPC assist constructor
    GP_SERV_COMMAND_CHAT_STD(const ipc::ChatMessageAssist& payload);
};
