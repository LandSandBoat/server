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

#include "0x029_battle_message.h"

#include "entities/baseentity.h"
#include "enums/msg_std.h"

GP_SERV_COMMAND_BATTLE_MESSAGE::GP_SERV_COMMAND_BATTLE_MESSAGE(const CBaseEntity* PSender, const CBaseEntity* PTarget, const int32 param, const int32 value, const MsgStd messageId)
{
    auto& packet = this->data();

    packet.UniqueNoCas = PSender->id;
    packet.UniqueNoTar = PTarget->id;
    packet.Data        = param;
    packet.Data2       = value;
    packet.ActIndexCas = PSender->targid;
    packet.ActIndexTar = PTarget->targid;
    packet.MessageNum  = messageId;
    packet.Type        = 0;
    packet.padding1B   = 0;
}

GP_SERV_COMMAND_BATTLE_MESSAGE::GP_SERV_COMMAND_BATTLE_MESSAGE(const CBaseEntity* PSender, const CBaseEntity* PTarget, int32 param, int32 value, MsgBasic messageId)
: GP_SERV_COMMAND_BATTLE_MESSAGE(PSender, PTarget, param, value, static_cast<MsgStd>(messageId))
{
}
