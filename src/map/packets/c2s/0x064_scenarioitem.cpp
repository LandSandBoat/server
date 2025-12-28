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

#include "0x064_scenarioitem.h"

#include "entities/charentity.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_SCENARIOITEM::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(UniqueNo, PChar->id, "Character ID mismatch")
        .mustEqual(ActIndex, PChar->targid, "Character targid mismatch")
        .range("TableIndex", TableIndex, 0, PChar->keys.tables.size());
}

void GP_CLI_COMMAND_SCENARIOITEM::process(MapSession* PSession, CCharEntity* PChar) const
{
    for (int i = 0; i < 16; i++)
    {
        const uint32_t flags = LookItemFlag[i];

        for (int bit = 0; bit < 32; bit++)
        {
            const auto keyItemId = (TableIndex * 512) + (i * 32) + bit;

            if ((flags >> bit) & 1)
            {
                charutils::markSeenKeyItem(PChar, static_cast<KeyItem>(keyItemId));
            }
        }
    }

    charutils::SaveKeyItems(PChar);
}
