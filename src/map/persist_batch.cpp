/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "persist_batch.h"

#include <unordered_set>

#include "entities/char_entity.h"
#include "status_effect_container.h"
#include "utils/charutils.h"

#include <common/database.h>
#include <common/synchronized.h>
#include <common/tracy.h>

namespace
{

// Characters already updated by teardown. Held for the duration of any write so sweeps and
// teardowns can't interleave.
Synchronized<std::unordered_set<uint32>> flushedAtTeardown;

void writeRows(const PersistBatch& batch)
{
    charutils::SaveCharPositions(batch.positions);
    effects::SaveEffectRows(batch.replaceEffectsFor, batch.effectRows);
    charutils::SaveCharEquips(batch.replaceEquipFor, batch.equipRows);
    charutils::SaveCharAppearances(batch.appearances);
    charutils::PersistCharVars(batch.charVars);
}

} // namespace

void PersistBatch::add(CCharEntity* PChar, const IsLogout logout)
{
    const auto pending = PChar->persist();
    PChar->clearPersist(pending);

    if ((pending & CharPersist::Position) != CharPersist::None)
    {
        positions.push_back({
            .charid   = PChar->id,
            .rotation = PChar->loc.p.rotation,
            .x        = PChar->loc.p.x,
            .y        = PChar->loc.p.y,
            .z        = PChar->loc.p.z,
            .boundary = PChar->loc.boundary,
        });
    }

    if ((pending & CharPersist::Effects) != CharPersist::None)
    {
        replaceEffectsFor.push_back(PChar->id);

        const auto rows = PChar->StatusEffectContainer->BuildPersistRows(logout);
        effectRows.insert(effectRows.end(), rows.begin(), rows.end());
    }

    if ((pending & CharPersist::Equip) != CharPersist::None)
    {
        replaceEquipFor.push_back(PChar->id);

        const auto slots = charutils::BuildCharEquipSlots(PChar);
        equipRows.insert(equipRows.end(), slots.begin(), slots.end());
    }

    if ((pending & CharPersist::Look) != CharPersist::None)
    {
        appearances.push_back(charutils::BuildCharAppearance(PChar));
    }

    PChar->takeCharVarChanges(charVars);
}

void PersistBatch::write()
{
    TracyZoneScoped;

    flushedAtTeardown.write(
        [this](std::unordered_set<uint32>& flushed)
        {
            if (!flushed.empty())
            {
                const auto dropRow = [&](const auto& row)
                {
                    return flushed.contains(row.charid);
                };

                const auto dropKey = [&](const uint32 charid)
                {
                    return flushed.contains(charid);
                };

                std::erase_if(positions, dropRow);
                std::erase_if(replaceEffectsFor, dropKey);
                std::erase_if(effectRows, dropRow);
                std::erase_if(replaceEquipFor, dropKey);
                std::erase_if(equipRows, dropRow);
                std::erase_if(appearances, dropRow);
                std::erase_if(charVars, dropRow);

                flushed.clear();
            }

            writeRows(*this);
        });
}

void persist::flush(CCharEntity* PChar, const IsLogout logout)
{
    TracyZoneScoped;

    PChar->StatusEffectContainer->DropEffectsForTransition(logout);

    // durations tick down without anything flagging the character, so rewrite them on the way out
    PChar->setPersist(CharPersist::Effects);

    PersistBatch batch;
    batch.add(PChar, logout);

    flushedAtTeardown.write(
        [&](std::unordered_set<uint32>& flushed)
        {
            writeRows(batch);
            flushed.insert(PChar->id);
        });
}
