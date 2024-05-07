/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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

#include "char_emote_list.h"
#include "common/socket.h"
#include "entities/baseentity.h"
#include "lua/luautils.h"
#include "utils/charutils.h"

CCharEmoteListPacket::CCharEmoteListPacket(CCharEntity* PChar)
{
    this->setType(0x11A);
    this->setSize(0x0C);

    // RUN and GEO are not sequential with the rest of the list, so grab those two separate offsets first.
    // Geomancer begins with bit 20, so create the offset based on an ID with that value subtracted.
    auto warriorKeyItem   = lua["xi"]["keyItem"]["JOB_GESTURE_WARRIOR"].get<uint16>();
    auto geomancerKeyItem = lua["xi"]["keyItem"]["JOB_GESTURE_GEOMANCER"].get<uint16>();

    uint32 jobEmotes = 0;
    for (const auto& keyItemName : jobGestureKeyItems)
    {
        auto keyItemId = lua["xi"]["keyItem"][keyItemName].get<uint16>();
        if (charutils::hasKeyItem(PChar, keyItemId))
        {
            uint16 bitOffset = keyItemId < geomancerKeyItem ? warriorKeyItem : geomancerKeyItem - 20;
            jobEmotes |= 1 << (keyItemId - bitOffset);
        }
    }

    auto imperialChairKeyItem = lua["xi"]["keyItem"]["IMPERIAL_CHAIR"].get<uint16>();

    uint16 chairEmotes = 0;
    for (const auto& keyItemName : chairKeyItems)
    {
        auto keyItemId = lua["xi"]["keyItem"][keyItemName].get<uint16>();
        if (charutils::hasKeyItem(PChar, keyItemId))
        {
            chairEmotes |= 1 << (keyItemId - imperialChairKeyItem);
        }
    }

    ref<uint32>(0x04) = jobEmotes;
    ref<uint16>(0x08) = chairEmotes;
}
