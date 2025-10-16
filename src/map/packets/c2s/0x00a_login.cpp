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

#include "0x00a_login.h"

#include "entities/charentity.h"
#include "packets/s2c/0x008_enterzone.h"
#include "packets/s2c/0x04f_equip_clear.h"
#include "packets/zone_in.h"
#include "utils/charutils.h"
#include "utils/gardenutils.h"
#include "utils/zoneutils.h"

auto GP_CLI_COMMAND_LOGIN::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(PChar->id, UniqueNo, "Player ID mismatch")
        .mustNotEqual(PSession->blowfish.status == BLOWFISH_ACCEPTED && PChar->status == STATUS_TYPE::NORMAL, true, "Player already logged in.");
}

void GP_CLI_COMMAND_LOGIN::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (!PChar)
    {
        ShowError("GP_CLI_COMMAND_LOGIN: PChar is null for player");
        return;
    }

    //
    // Handle out of sync zone correction..
    //
    if (header.sync > 1)
    {
        PSession->server_packet_id = header.sync;

        // Clear all pending packets for this character.
        // This incoming 0x00A from the client wants us to set the starting sync count for all new packets to the sync count from 0x02.
        // If we do not do this, all further packets may be ignored by the client and will result in disconnection from the server.
        PChar->clearPacketList();
    }

    // No real distinction between these two states in the 0x00A handler --
    // Key is already assumed to be incremented correctly,
    // Pending zone is same process transfer, and waiting is new login or different process.
    if (PSession->blowfish.status == BLOWFISH_PENDING_ZONE || PSession->blowfish.status == BLOWFISH_WAITING) // Call zone in, etc, only once.
    {
        PSession->blowfish.status = BLOWFISH_ACCEPTED;
        PChar->clearPacketList();

        if (PChar->loc.zone != nullptr)
        {
            ShowError(fmt::format("{} sent 0x00A while their original zone wasn't wiped!", PChar->getName()));
            return;
        }

        PSession->shuttingDown = 0;

        const uint16 destination = PChar->loc.destination;
        CZone*       destZone    = zoneutils::GetZone(destination);

        if (destination >= MAX_ZONEID || destZone == nullptr)
        {
            // TODO: work out how to drop player in moghouse that exits them to the zone they were in before this happened, like we used to.
            ShowWarning("GP_CLI_COMMAND_LOGIN: player tried to enter zone that was invalid or out of range");
            ShowWarning("GP_CLI_COMMAND_LOGIN: dumping player `%s` to homepoint!", PChar->getName());
            PChar->requestedWarp = true; // Not a "request" but a demand
            return;
        }

        destZone->IncreaseZoneCounter(PChar);

        // Current zone could either be current zone or destination
        CZone* currentZone = zoneutils::GetZone(PChar->getZone());
        if (currentZone == nullptr)
        {
            ShowWarning("GP_CLI_COMMAND_LOGIN: currentZone was null for Zone ID %d.", PChar->getZone());
            return;
        }

        charutils::updateSession(PSession, PChar, currentZone);
        charutils::loadDeathTimestamp(PChar);
        charutils::loadZoningFlag(PChar);
        charutils::SaveCharPosition(PChar);
        charutils::SaveZonesVisited(PChar);
        charutils::SavePlayTime(PChar);

        if (PChar->m_moghouseID != 0)
        {
            PChar->m_charHistory.mhEntrances++;
            // TODO: Does this even work with Mog House sharing?
            charutils::updateMannequins(PChar);
            gardenutils::UpdateGardening(PChar, false);
        }
    }

    // Only release client from "Downloading Data" if the packet sequence came in without a drop on 0x00D
    // It is also possible that the client also never received our packets to release themselves from the loading screen.
    // TODO: Need further research into the relationship between 0x00D and 0x00A, if any.
    if (PChar->loc.zone != nullptr)
    {
        PChar->pushPacket<GP_SERV_COMMAND_EQUIP_CLEAR>();
        PChar->pushPacket<CZoneInPacket>(PChar, PChar->currentEvent);
        PChar->pushPacket<GP_SERV_COMMAND_ENTERZONE>(PChar);
    }
}
