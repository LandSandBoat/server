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

#include "0x01b_friendpass.h"

#include "entities/char_entity.h"
#include "lua/luautils.h"
#include "packets/c2s/validation.h"
#include "packets/s2c/0x059_friendpass.h"

auto GP_CLI_COMMAND_FRIENDPASS::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .isInEvent()
        .oneOf<GP_CLI_COMMAND_FRIENDPASS_PARA>(this->Para);
}

void GP_CLI_COMMAND_FRIENDPASS::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto reply = luautils::OnWorldPassRequest(PChar, this->Para);
    PChar->pushPacket<GP_SERV_COMMAND_FRIENDPASS>(reply.type, reply.leftNum, reply.leftHours, reply.price, reply.code);
}
