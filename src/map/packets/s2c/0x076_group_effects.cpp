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

#include "0x076_group_effects.h"

#include "entities/battleentity.h"
#include "entities/charentity.h"
#include "status_effect_container.h"

GP_SERV_COMMAND_GROUP_EFFECTS::GP_SERV_COMMAND_GROUP_EFFECTS(const std::vector<CCharEntity*>& membersList)
{
    auto& packet = this->data();

    // Check for valid party size to prevent buffer being overrun (244 bytes).
    // When using multiple map processes across different IPs, the latency
    // in communication combined with players joining/leaving at the same time
    // can cause the party size to be larger than the packet size.
    for (std::size_t idx = 0; idx < membersList.size() && idx < 5; ++idx)
    {
        const CCharEntity* PMember = membersList[idx];

        packet.Members[idx].UniqueNo = PMember->id;
        packet.Members[idx].ActIndex = PMember->targid;
        packet.Members[idx].Bits     = PMember->StatusEffectContainer->m_Flags;

        std::memcpy(packet.Members[idx].Buffs, PMember->StatusEffectContainer->m_StatusIcons, sizeof(packet.Members[idx].Buffs));
    }
}
