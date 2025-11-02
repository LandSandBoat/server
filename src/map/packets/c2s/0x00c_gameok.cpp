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

#include "0x00c_gameok.h"

#include "entities/charentity.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/s2c/0x008_enterzone.h"
#include "packets/s2c/0x01b_job_info.h"
#include "packets/s2c/0x01c_item_max.h"
#include "packets/s2c/0x051_grap_list.h"
#include "packets/s2c/0x063_miscdata_homepoints.h"
#include "packets/s2c/0x063_miscdata_monstrosity.h"
#include "packets/s2c/0x063_miscdata_status_icons.h"
#include "packets/s2c/0x08c_merit.h"
#include "packets/s2c/0x0aa_magic_data.h"
#include "packets/s2c/0x0ac_command_data.h"
#include "packets/s2c/0x0ae_mount_data.h"
#include "packets/s2c/0x0b4_config.h"
#include "packets/s2c/0x0ca_inspect_message.h"
#include "treasure_pool.h"
#include "utils/blacklistutils.h"
#include "utils/charutils.h"
#include "utils/petutils.h"

auto GP_CLI_COMMAND_GAMEOK::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(ClientState, 0, "ClientState not 0")
        .mustEqual(DebugClientFlg, 0, "DebugClientFlg not 0");
}

void GP_CLI_COMMAND_GAMEOK::process(MapSession* PSession, CCharEntity* PChar) const
{
    // This is one of the first packets sent when zoning in and causes the server
    // to start rapidly sending a lot of information to initialize the client.
    //
    // Note that while the packets are sent synchronously below, retail has a different behavior:
    // Some of the packets are queued in some sort of prioritization system and will hitch a ride
    // in the next outgoing batch in an opportunistic fashion.
    //
    // This is why the order below will NOT match 1:1 a retail capture!
    PChar->pushPacket<GP_SERV_COMMAND_ENTERZONE>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_ITEM_MAX>(PChar); // Already sent during LOGIN but retail sends it again
    PChar->pushPacket<GP_SERV_COMMAND_CONFIG>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_GRAP_LIST>(PChar); // Already sent during LOGIN but retail sends it again
    PChar->pushPacket<GP_SERV_COMMAND_JOB_INFO>(PChar);
    PChar->pushPacket<CCharStatusPacket>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::MONSTROSITY2>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::HOMEPOINTS>(PChar);
    charutils::SendExtendedJobPackets(PChar);
    charutils::SendUnityPackets(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_MISCDATA::STATUS_ICONS>(PChar);
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
    blacklistutils::SendBlacklist(PChar);

    // TODO: While in mog house; treasure pool is not created.
    if (PChar->PTreasurePool != nullptr)
    {
        PChar->PTreasurePool->updatePool(PChar);
    }
    PChar->loc.zone->SpawnTransport(PChar);

    // respawn any pets from last zone
    if (PChar->loc.zone->CanUseMisc(MISC_PET) && !PChar->m_moghouseID)
    {
        if (PChar->shouldPetPersistThroughZoning())
        {
            petutils::SpawnPet(PChar, PChar->petZoningInfo.petID, true);
        }

        PChar->resetPetZoningInfo();
    }
}
