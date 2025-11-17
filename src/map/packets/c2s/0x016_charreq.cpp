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

#include "0x016_charreq.h"

#include "entities/charentity.h"
#include "entities/npcentity.h"
#include "packets/char_status.h"
#include "utils/zoneutils.h"

auto GP_CLI_COMMAND_CHARREQ::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator();
}

void GP_CLI_COMMAND_CHARREQ::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (ActIndex == PChar->targid)
    {
        PChar->updateEntityPacket(PChar, ENTITY_SPAWN, UPDATE_ALL_CHAR);
        PChar->pushPacket<CCharStatusPacket>(PChar);
    }
    else
    {
        CBaseEntity* PEntity = PChar->GetEntity(ActIndex, TYPE_NPC | TYPE_PC);

        if (PEntity && PEntity->objtype == TYPE_PC)
        {
            // Char we want an update for
            if (auto* PCharEntity = dynamic_cast<CCharEntity*>(PEntity))
            {
                if (!PCharEntity->m_isGMHidden)
                {
                    PChar->updateEntityPacket(PCharEntity, ENTITY_SPAWN, UPDATE_ALL_CHAR);
                }
                else
                {
                    ShowError(fmt::format("Player {} requested information about a hidden GM ({}) using targid {}", PChar->getName(), PCharEntity->getName(), ActIndex));
                }
            }
        }
        else
        {
            if (!PEntity)
            {
                PEntity = zoneutils::GetTrigger(ActIndex, PChar->getZone());

                // PEntity->id will now be the full id of the entity we could not find
                ShowWarning(fmt::format("Server missing npc_list.sql entry <{}> in zone <{} ({})>",
                                        PEntity->id,
                                        zoneutils::GetZone(PChar->getZone())->getName(),
                                        PChar->getZone()));
            }

            // Special case for onZoneIn cutscenes in Mog House
            // TODO: Verify this condition when Mog House sharing is implemented.
            if (PChar->m_moghouseID == PChar->id &&
                PEntity->status == STATUS_TYPE::DISAPPEAR &&
                PEntity->loc.p.z == 1.5 &&
                PEntity->look.face == 0x52)
            {
                // Using the same logic as in ZoneEntities::SpawnConditionalNPCs:
                // Change the status of the entity, send the packet, change it back to disappear
                PEntity->status = STATUS_TYPE::NORMAL;
                PChar->updateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
                PEntity->status = STATUS_TYPE::DISAPPEAR;
            }
            else
            {
                PChar->updateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
            }
        }
    }
}
