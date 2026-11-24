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

#include "entities/char_entity.h"
#include "lua/luautils.h"
#include "monstrosity.h"
#include "packets/c2s/validation.h"
#include "utils/charutils.h"

namespace
{

const auto validContainers = [](const CCharEntity* PChar) -> std::set<xi::Container>
{
    // These are always available in both LSB and retail.
    std::set allowedContainers = {
        xi::Container::Inventory,
        xi::Container::Wardrobe,
        xi::Container::Wardrobe2,
    };

    // Global containers optionally unlockable
    const std::set unlockableContainers = {
        xi::Container::Wardrobe3, // Always available in LSB but paid feature on retail.
        xi::Container::Wardrobe4,
        xi::Container::Wardrobe5,
        xi::Container::Wardrobe6,
        xi::Container::Wardrobe7,
        xi::Container::Wardrobe8,
    };

    const std::set additionalContainers = {
        xi::Container::MogSatchel, xi::Container::MogSack, xi::Container::MogCase
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

    // JP wiki: a Monipulator cannot use /equipset.
    auto pv = PacketValidator(PChar)
                  .blockedBy({ BlockedState::InEvent, BlockedState::AbnormalStatus, BlockedState::Fishing, BlockedState::Monstrosity })
                  .range("Count", this->Count, 1, 16);

    if (this->Count <= 16)
    {
        for (uint8 i = 0; i < this->Count; i++)
        {
            const auto& equipment = this->Equipment[i];
            pv
                .oneOf<SLOTTYPE>(equipment.EquipKind)
                .oneOf("equipment.Category", static_cast<xi::Container>(equipment.Category), allowedContainers);
        }
    }

    return pv;
}

void GP_CLI_COMMAND_EQUIPSET_SET::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto changed = false;
    for (uint8 i = 0; i < this->Count; i++)
    {
        // Encumbrance locks the slot against unequipping too, which EquipItem allows for scripts.
        if (PChar->m_EquipBlock & (1 << this->Equipment[i].EquipKind))
        {
            continue;
        }

        const auto  slot    = static_cast<SLOTTYPE>(this->Equipment[i].EquipKind);
        const auto* PBefore = PChar->getEquip(slot);
        charutils::EquipItem(PChar, this->Equipment[i].ItemIndex, this->Equipment[i].EquipKind, static_cast<xi::Container>(this->Equipment[i].Category));
        changed = changed || PChar->getEquip(slot) != PBefore;
    }

    if (changed)
    {
        monstrosity::HandleGladiatorGearChange(PChar);
    }

    luautils::CheckForGearSet(PChar); // check for gear set on gear change
    PChar->UpdateHealth();
    PChar->retriggerLatents = true; // retrigger all latents later because our gear has changed
}
