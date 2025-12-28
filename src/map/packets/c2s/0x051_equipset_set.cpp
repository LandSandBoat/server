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

#include "0x051_equipset_set.h"

#include "entities/charentity.h"
#include "lua/luautils.h"
#include "utils/charutils.h"

namespace
{

const auto validContainers = [](const CCharEntity* PChar) -> std::set<CONTAINER_ID>
{
    // These are always available in both LSB and retail.
    std::set allowedContainers = {
        LOC_INVENTORY,
        LOC_WARDROBE,
        LOC_WARDROBE2,
    };

    // Global containers optionally unlockable
    const std::set unlockableContainers = {
        LOC_WARDROBE3, // Always available in LSB but paid feature on retail.
        LOC_WARDROBE4,
        LOC_WARDROBE5,
        LOC_WARDROBE6,
        LOC_WARDROBE7,
        LOC_WARDROBE8,
    };

    const std::set additionalContainers = {
        LOC_MOGSATCHEL, LOC_MOGSACK, LOC_MOGCASE
    };

    for (const auto containerId : unlockableContainers)
    {
        if (PChar->getStorage(containerId)->GetSize() > 0)
        {
            allowedContainers.insert(containerId);
        }
    }

    if (settings::get<bool>("main.EQUIP_FROM_OTHER_CONTAINERS"))
    {
        for (const auto containerId : additionalContainers)
        {
            if (PChar->getStorage(containerId)->GetSize() > 0)
            {
                allowedContainers.insert(containerId);
            }
        }
    }

    return allowedContainers;
};

} // namespace

auto GP_CLI_COMMAND_EQUIPSET_SET::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    const auto allowedContainers = validContainers(PChar);

    auto pv = PacketValidator()
                  .isNormalStatus(PChar)
                  .range("Count", Count, 1, 16);

    if (Count <= 16)
    {
        for (uint8 i = 0; i < Count; i++)
        {
            const auto& equipment = Equipment[i];
            pv
                .oneOf<SLOTTYPE>(equipment.EquipKind)
                .oneOf("equipment.Category", static_cast<CONTAINER_ID>(equipment.Category), allowedContainers);
        }
    }

    return pv;
}

void GP_CLI_COMMAND_EQUIPSET_SET::process(MapSession* PSession, CCharEntity* PChar) const
{
    for (uint8 i = 0; i < Count; i++)
    {
        charutils::EquipItem(PChar, Equipment[i].ItemIndex, Equipment[i].EquipKind, Equipment[i].Category);
    }

    PChar->RequestPersist(CHAR_PERSIST::EQUIP);
    luautils::CheckForGearSet(PChar); // check for gear set on gear change
    PChar->UpdateHealth();
    PChar->retriggerLatents = true; // retrigger all latents later because our gear has changed
}
