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

#include "0x00f_clstat.h"

#include "entities/charentity.h"
#include "packets/char_sync.h"
#include "packets/s2c/0x08c_merit.h"
#include "packets/s2c/0x0aa_magic_data.h"
#include "packets/s2c/0x0ac_command_data.h"
#include "packets/s2c/0x0ae_mount_data.h"
#include "packets/s2c/0x0ca_inspect_message.h"
#include "utils/blacklistutils.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_CLSTAT::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // No parameter to validate for this packet.
    return PacketValidator();
}

void GP_CLI_COMMAND_CLSTAT::process(MapSession* PSession, CCharEntity* PChar) const
{
    charutils::SendKeyItems(PChar);
    charutils::SendQuestMissionLog(PChar);
    charutils::SendRecordsOfEminenceLog(PChar);

    PChar->pushPacket<GP_SERV_COMMAND_MAGIC_DATA>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MOUNT_DATA>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(PChar);
    PChar->pushPacket<CCharSyncPacket>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_INSPECT_MESSAGE>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MERIT>(PChar);

    charutils::SendInventory(PChar);

    // Note: This sends the stop downloading packet!
    blacklistutils::SendBlacklist(PChar);
}
