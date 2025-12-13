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

enum class MsgBasic : uint16_t;
enum class MsgStd : uint16_t;
class CBaseEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0029
// This packet is sent by the server to display combat related messages to the client.
class GP_SERV_COMMAND_BATTLE_MESSAGE final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_BATTLE_MESSAGE, GP_SERV_COMMAND_BATTLE_MESSAGE>
{
public:
    struct PacketData
    {
        uint32_t UniqueNoCas; // PS2: UniqueNoCas
        uint32_t UniqueNoTar; // PS2: UniqueNoTar
        uint32_t Data;        // PS2: data
        uint32_t Data2;       // PS2: data2
        uint16_t ActIndexCas; // PS2: ActIndexCas
        uint16_t ActIndexTar; // PS2: ActIndexTar
        MsgStd   MessageNum;  // PS2: MessageNum
        uint8_t  Type;        // PS2: Type
        uint8_t  padding1B;   // PS2: dammy3
    };

    inline auto getMessageId() const -> MsgBasic
    {
        return static_cast<MsgBasic>(this->data().MessageNum);
    }

    GP_SERV_COMMAND_BATTLE_MESSAGE(const CBaseEntity* PSender, const CBaseEntity* PTarget, int32 param, int32 value, MsgStd messageId);
    GP_SERV_COMMAND_BATTLE_MESSAGE(const CBaseEntity* PSender, const CBaseEntity* PTarget, int32 param, int32 value, MsgBasic messageId);
};
