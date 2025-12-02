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

#include "0x015_pos.h"

#include "entities/charentity.h"
#include "packets/s2c/0x0f5_tracking_pos.h"

auto GP_CLI_COMMAND_POS::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustNotEqual(PChar->status, STATUS_TYPE::DISAPPEAR, "Character is disappearing")
        .mustNotEqual(PChar->status, STATUS_TYPE::SHUTDOWN, "Character is shutting down");
}

void GP_CLI_COMMAND_POS::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (PChar->pendingPositionUpdate)
    {
        return;
    }

    const float  newX        = x;
    const float  newY        = z; // Not a typo.
    const float  newZ        = y; // Not a typo.
    const uint16 newTargID   = facetarget;
    const uint8  newRotation = dir;

    // clang-format off
    const bool moved =
        PChar->loc.p.x != newX ||
        PChar->loc.p.y != newY ||
        PChar->loc.p.z != newZ ||
        PChar->m_TargID != newTargID ||
        PChar->loc.p.rotation != newRotation;
    // clang-format on

    // Cache previous location
    PChar->m_previousLocation = PChar->loc;

    if (!PChar->isCharmed)
    {
        PChar->loc.p.x = newX;
        PChar->loc.p.y = newY;
        PChar->loc.p.z = newZ;

        PChar->loc.p.moving   = MoveFlame;
        PChar->loc.p.rotation = newRotation;

        PChar->m_TargID = newTargID;
    }

    if (moved)
    {
        PChar->updatemask |= UPDATE_POS; // Indicate that we want to update this PChar's PChar->loc or targID

        // Calculate rough amount of steps taken
        if (PChar->m_previousLocation.zone->GetID() == PChar->loc.zone->GetID())
        {
            const float distanceTravelled = distance(PChar->m_previousLocation.p, PChar->loc.p);
            PChar->m_charHistory.distanceTravelled += static_cast<uint32>(distanceTravelled);
        }
    }

    // Request updates for all entity types
    PChar->loc.zone->SpawnNPCs(PChar); // Some NPCs can move, some rotate when other players talk to them, always request NPC updates.
    PChar->loc.zone->SpawnMOBs(PChar);
    PChar->loc.zone->SpawnPETs(PChar);
    PChar->loc.zone->SpawnTRUSTs(PChar);
    PChar->requestedInfoSync = true; // Ask to update PCs during CZoneEntities::ZoneServer

    // clang-format off
    PChar->WideScanTarget.apply([&](const auto& wideScanTarget)
    {
        if (const auto* PWideScanEntity = PChar->GetEntity(wideScanTarget.targid, TYPE_MOB | TYPE_NPC))
        {
            PChar->pushPacket<GP_SERV_COMMAND_TRACKING_POS>(PWideScanEntity);

            if (PWideScanEntity->status == STATUS_TYPE::DISAPPEAR)
            {
                PChar->WideScanTarget = std::nullopt;
            }
        }
        else
        {
            PChar->WideScanTarget = std::nullopt;
        }
    });
    // clang-format on
}
