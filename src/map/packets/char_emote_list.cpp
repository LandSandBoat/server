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

#include "entities/baseentity.h"
#include "enums/key_items.h"
#include "utils/charutils.h"

namespace
{
    const std::vector jobGestureKeyItems = {
        KeyItem::JOB_GESTURE_WARRIOR,
        KeyItem::JOB_GESTURE_MONK,
        KeyItem::JOB_GESTURE_WHITE_MAGE,
        KeyItem::JOB_GESTURE_BLACK_MAGE,
        KeyItem::JOB_GESTURE_RED_MAGE,
        KeyItem::JOB_GESTURE_THIEF,
        KeyItem::JOB_GESTURE_PALADIN,
        KeyItem::JOB_GESTURE_DARK_KNIGHT,
        KeyItem::JOB_GESTURE_BEASTMASTER,
        KeyItem::JOB_GESTURE_BARD,
        KeyItem::JOB_GESTURE_RANGER,
        KeyItem::JOB_GESTURE_SAMURAI,
        KeyItem::JOB_GESTURE_NINJA,
        KeyItem::JOB_GESTURE_DRAGOON,
        KeyItem::JOB_GESTURE_SUMMONER,
        KeyItem::JOB_GESTURE_BLUE_MAGE,
        KeyItem::JOB_GESTURE_CORSAIR,
        KeyItem::JOB_GESTURE_PUPPETMASTER,
        KeyItem::JOB_GESTURE_DANCER,
        KeyItem::JOB_GESTURE_SCHOLAR,
        KeyItem::JOB_GESTURE_GEOMANCER,
        KeyItem::JOB_GESTURE_RUNE_FENCER,
    };

    const std::vector chairKeyItems = {
        KeyItem::IMPERIAL_CHAIR,
        KeyItem::DECORATIVE_CHAIR,
        KeyItem::ORNATE_STOOL,
        KeyItem::REFINED_CHAIR,
        KeyItem::PORTABLE_CONTAINER,
        KeyItem::CHOCOBO_CHAIR,
        KeyItem::EPHRAMADIAN_THRONE,
        KeyItem::SHADOW_THRONE,
        KeyItem::LEAF_BENCH,
        KeyItem::ASTRAL_CUBE,
        KeyItem::CHOCOBO_CHAIR_II,
    };
} // namespace

CCharEmoteListPacket::CCharEmoteListPacket(CCharEntity* PChar)
{
    this->setType(0x11A);
    this->setSize(0x0C);

    uint32 jobEmotes = 0;
    for (const auto keyItemId : jobGestureKeyItems)
    {
        if (charutils::hasKeyItem(PChar, keyItemId))
        {
            uint16 bitOffset = 0;
            if (keyItemId < KeyItem::JOB_GESTURE_GEOMANCER)
            {
                bitOffset = static_cast<uint16_t>(KeyItem::JOB_GESTURE_WARRIOR);
            }
            else
            {
                bitOffset = static_cast<uint16_t>(KeyItem::JOB_GESTURE_GEOMANCER) - 20;
            }

            jobEmotes |= 1 << (static_cast<uint16_t>(keyItemId) - bitOffset);
        }
    }

    uint16 chairEmotes = 0;
    for (const auto keyItemId : chairKeyItems)
    {
        if (charutils::hasKeyItem(PChar, keyItemId))
        {
            chairEmotes |= 1 << (static_cast<uint16_t>(keyItemId) - static_cast<uint16_t>(KeyItem::IMPERIAL_CHAIR));
        }
    }

    ref<uint32>(0x04) = jobEmotes;
    ref<uint16>(0x08) = chairEmotes;
}
