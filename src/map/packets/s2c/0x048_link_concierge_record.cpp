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

#include "0x048_link_concierge_record.h"

#include "common/utils.h"

GP_SERV_COMMAND_LINK_CONCIERGE::RECORD::RECORD(const std::array<SlotInput, 4>& slots)
{
    auto& packet = this->data();

    for (uint8 i = 0; i < 4; ++i)
    {
        packet.unknown00[i] = 0x0203;

        if (!slots[i].filled)
        {
            packet.Indices[i] = 0xFF;
            continue;
        }

        packet.Indices[i] = slots[i].slotIndex;

        // Exdata::Linkshell body
        packet.Bodies[i].GroupId  = slots[i].groupId;
        packet.Bodies[i].GroupKey = slots[i].groupKey;
        std::memcpy(&packet.Bodies[i].Color, &slots[i].color, sizeof(uint16));
        packet.Bodies[i].Flag = slots[i].flag;

        char encoded[LinkshellStringLength] = {};
        EncodeStringLinkshell(slots[i].name, encoded);
        std::memcpy(packet.Bodies[i].Name, encoded, sizeof(packet.Bodies[i].Name));

        auto& attrs           = packet.Attrs[i];
        attrs.Active          = 1;
        attrs.LangJP          = (slots[i].lang == 1) ? 1 : 0;
        attrs.LangEN          = (slots[i].lang == 2) ? 1 : 0;
        attrs.LangOther       = (slots[i].lang == 3) ? 1 : 0;
        attrs.MembersGoal     = slots[i].membersGoal;
        attrs.ActiveTier      = slots[i].activeTier;
        attrs.Characteristics = slots[i].characteristics;
    }
}
