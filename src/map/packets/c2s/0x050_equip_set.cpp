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

#include "0x050_equip_set.h"

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

auto GP_CLI_COMMAND_EQUIP_SET::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .isNormalStatus(PChar)
        .oneOf<SLOTTYPE>(EquipKind)
        .oneOf("Category", static_cast<CONTAINER_ID>(Category), validContainers(PChar));
}

void GP_CLI_COMMAND_EQUIP_SET::process(MapSession* PSession, CCharEntity* PChar) const
{
    charutils::EquipItem(PChar, PropertyItemIndex, EquipKind, Category);
    PChar->RequestPersist(CHAR_PERSIST::EQUIP);
    luautils::CheckForGearSet(PChar); // check for gear set on gear change
    PChar->UpdateHealth();
    PChar->retriggerLatents = true; // retrigger all latents later because our gear has changed
    // TODO: Sort out above logic and ensure the following packets are emitted synchronously as a response
    // EQUIP_LIST
    // GRAP_LIST
    // MAGIC_DATA
    // COMMAND_DATA
}
