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

#include "entities/charentity.h"
#include "packets/s2c/0x059_friendpass.h"

auto GP_CLI_COMMAND_FRIENDPASS::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // Not implemented.
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_FRIENDPASS_PARA>(Para);
}

void GP_CLI_COMMAND_FRIENDPASS::process(MapSession* PSession, CCharEntity* PChar) const
{
    switch (static_cast<GP_CLI_COMMAND_FRIENDPASS_PARA>(Para))
    {
        case GP_CLI_COMMAND_FRIENDPASS_PARA::BeginPurchase:
            break;
        case GP_CLI_COMMAND_FRIENDPASS_PARA::ConfirmPurchase:
            break;
        case GP_CLI_COMMAND_FRIENDPASS_PARA::BeginGoldPurchase:
            break;
        case GP_CLI_COMMAND_FRIENDPASS_PARA::ConfirmGoldPurchase:
            break;
    }

    PChar->pushPacket<GP_SERV_COMMAND_FRIENDPASS>(Para & 1 ? static_cast<uint32>(xirand::GetRandomNumber(9999999999)) : 0);
}
