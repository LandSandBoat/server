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

#include "mountutils.h"

#include "common/settings.h"
#include "entities/base_entity.h"
#include "entities/char_entity.h"
#include "items.h"
#include "items/item_equipment.h"
#include "status_effect.h"
#include "status_effect_container.h"

namespace mountutils
{

// ChocoboIndex is a field (0-7) used in various packets.
// While it has little incidence for mounts, it is extremely important for custom chocobos.
// CustomProperties[0] sets the Personal Chocobo model.
// CustomProperties[1] is used for Noble Chocobo, and is set to 1.
auto packetDefinition(const CCharEntity* PChar) -> MountPacketDefinition
{
    const auto* effect = PChar->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Mounted);
    if (!effect)
    {
        return MountPacketDefinition{
            .ChocoboIndex = 0,
        };
    }

    switch (const auto mount = effect->GetPower())
    {
        case MOUNT_CHOCOBO:
        {
            // Customized chocobos need ChocoboIndex 2
            if (isPersonalChocobo(PChar))
            {
                return MountPacketDefinition{
                    .ChocoboIndex     = 2,
                    .CustomProperties = { PChar->m_chocoboUserData.fieldChocobo, 0 },
                };
            }

            // Regular Chocobos use 1
            return MountPacketDefinition{
                .ChocoboIndex = 1,
            };
        }
        case MOUNT_NOBLE_CHOCOBO:
        {
            // Noble Chocobo is a special case, it should return 3
            // if following other mounts logic, however captures show it uses 4, likely to indicate it is a Chocobo.
            // It also needs 1 in CustomProperties[1]
            return MountPacketDefinition{
                .ChocoboIndex     = static_cast<uint8_t>((mount % 8) + 2),
                .CustomProperties = { 0, 1 },
            };
        }
        default:
            // All other mounts return the remainder + 1
            return MountPacketDefinition{
                .ChocoboIndex = static_cast<uint8_t>((mount % 8) + 1),
            };
    }
}

auto isPersonalChocobo(const CCharEntity* PChar) -> bool
{
    if (!PChar->m_chocoboUserData.fieldChocobo)
    {
        return false;
    }

    const auto* effect = PChar->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Mounted);

    return effect &&
           effect->GetPower() == MOUNT_CHOCOBO &&
           (effect->GetSubPower() & kPersonalChocoboFlag) != 0;
}

auto personalChocoboSpeed(const CCharEntity* PChar) -> uint8_t
{
    const auto chocobo = ChocoboCustomProperties{ .properties = PChar->m_chocoboUserData.fieldChocobo };

    // Registered before speeds were stored.
    if (chocobo.speed == 0)
    {
        return settings::get<uint8>("map.MOUNT_SPEED");
    }

    // Purple Race Silks add their rank only while worn; lockstyle does not count.
    auto speed = uint32_t{ chocobo.speed };
    if (const auto* PBody = PChar->getEquip(SLOT_BODY); PBody && PBody->getID() == ITEMID::PURPLE_RACING_SILKS)
    {
        speed += PChar->m_chocoboUserData.silksSpeedBonus;
    }

    return static_cast<uint8_t>(std::min<uint32_t>(speed, 0xFF));
}

}; // namespace mountutils
