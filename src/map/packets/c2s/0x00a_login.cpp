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
#include "packets/s2c/0x00a_login.h"

#include "ai/ai_container.h"
#include "ai/helpers/action_queue.h"
#include "entities/char_entity.h"
#include "lua/luautils.h"
#include "map_session.h"
#include "packets/c2s/validation.h"
#include "packets/s2c/0x01c_item_max.h"
#include "packets/s2c/0x04f_equip_clear.h"
#include "packets/s2c/0x050_equip_list.h"
#include "packets/s2c/0x051_grap_list.h"
#include "utils/charutils.h"
#include "utils/gardenutils.h"
#include "utils/zoneutils.h"

auto GP_CLI_COMMAND_LOGIN::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .mustEqual(PChar->id, this->UniqueNo, "Player ID mismatch")
        .mustNotEqual(PSession->blowfish.status == BLOWFISH_ACCEPTED && PChar->status == xi::Status::Normal && PSession->hasDecryptedPacket, true, "Player already logged in.");
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
        // The client has seen this sync already, so everything from here goes out above it
        PSession->server_packet_id = header.sync;

        // Only the missed reply is replaced. Held packets get their sync when they go out
        constexpr auto staleReply = std::to_array<uint16>({ 0x00A, 0x01C, 0x04F, 0x050, 0x051 });
        PChar->erasePacketsOfType(staleReply);
    }

    // No real distinction between these two states in the 0x00A handler --
    // Key is already assumed to be incremented correctly,
    // Pending zone is same process transfer, and waiting is new login or different process.
    const auto isFirstZoneIn = PSession->blowfish.status == BLOWFISH_PENDING_ZONE || PSession->blowfish.status == BLOWFISH_WAITING;
    if (isFirstZoneIn) // Call zone in, etc, only once.
    {
        PSession->blowfish.status = BLOWFISH_ACCEPTED;
        PChar->clearPacketList();

        if (PChar->loc.zone != nullptr)
        {
            ShowError(fmt::format("{} sent 0x00A while their original zone wasn't wiped!", PChar->getName()));
            return;
        }

        PSession->shuttingDown = 0;

        const auto destination = PChar->loc.destination;
        CZone*     destZone    = zoneutils::GetZone(destination);

        // The client gets no reply and times out at the title screen
        if (static_cast<uint16>(destination) >= MAX_ZONEID || destZone == nullptr)
        {
            ShowErrorFmt("GP_CLI_COMMAND_LOGIN: {} can't enter zone {} on this process", PChar->getName(), destination);

            // Save pet if any
            if (PChar->shouldPetPersistThroughZoning())
            {
                PChar->setPetZoningInfo();
            }
            return;
        }

        // Host closed or left while the visitor was zoning in
        if (PChar->inMogHouse(xi::MogHouse::Visiting) && PChar->getCharVar("mh-visit-npc") != 0)
        {
            const auto* PHost = zoneutils::GetChar(PChar->m_moghouseID);
            if (PHost == nullptr || PHost->getZone() != destination || !PHost->moghouse().isOpen() || !PHost->inMogHouse(xi::MogHouse::Own))
            {
                PChar->m_moghouseID = 0;
                PChar->loc.p        = {};
            }
        }

        destZone->IncreaseZoneCounter(PChar);

        if (PChar->loc.zone == nullptr)
        {
            ShowErrorFmt("GP_CLI_COMMAND_LOGIN: {} was not placed in zone {}", PChar->getName(), destination);
            return;
        }

        if (auto* PHost = PChar->moghouse().host(); PHost != nullptr && PHost != PChar)
        {
            PHost->moghouse().addVisitor(PChar);
        }

        luautils::OnZoneIn(PChar);
        luautils::OnGameIn(PChar, PChar->arrivedByZoning);

        // Current zone could either be current zone or destination
        CZone* currentZone = zoneutils::GetZone(PChar->getZone());
        if (currentZone == nullptr)
        {
            ShowWarning("GP_CLI_COMMAND_LOGIN: currentZone was null for Zone ID %d.", PChar->getZone());
            return;
        }

        charutils::updateSession(PSession, PChar, currentZone);
        charutils::loadDeathTimestamp(PChar);
        charutils::SaveCharPosition(PChar);
        charutils::SaveZonesVisited(PChar);
        charutils::SavePlayTime(PChar);

        if (PChar->inMogHouse())
        {
            charutils::updateMannequins(PChar);
        }

        if (PChar->inMogHouse(xi::MogHouse::Own))
        {
            PChar->m_charHistory.mhEntrances++;

            gardenutils::UpdateGardening(PChar, SendPacket::No);
        }
    }

    // The client leaves "Downloading data" on the first S2C 0x00A it accepts, so every retry gets one
    if (PChar->loc.zone != nullptr)
    {
        // Ahead of anything the zone-in queued, which waits for C2S 0x00C
        const auto queued = PChar->getPacketCount();

        PChar->pushPacket<GP_SERV_COMMAND_EQUIP_CLEAR>();
        PChar->pushPacket<GP_SERV_COMMAND_GRAP_LIST>(PChar);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_MAX>(PChar);
        PChar->pushPacket<GP_SERV_COMMAND_LOGIN>(PChar, PChar->currentEvent);
        for (uint8 i = 0; i < 16; ++i)
        {
            auto eloc = PChar->equipLocation(i);
            if (eloc)
            {
                PChar->pushPacket<GP_SERV_COMMAND_EQUIP_LIST>(*eloc, static_cast<SLOTTYPE>(i));
            }
        }

        PChar->movePacketsToFront(PChar->getPacketCount() - queued);

        // A retry would undo a zone change or logout queued while the client loads
        if (isFirstZoneIn)
        {
            PChar->status = xi::Status::Normal;
        }

        PChar->PAI->QueueAction(queueAction_t(4000ms, false, zoneutils::AfterZoneIn));
    }
}
