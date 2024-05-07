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

#ifndef _CCHAREMOTELIST_H
#define _CCHAREMOTELIST_H

#include "common/cbasetypes.h"

#include "basic.h"

std::vector<std::string> const jobGestureKeyItems = {
    "JOB_GESTURE_WARRIOR",
    "JOB_GESTURE_MONK",
    "JOB_GESTURE_WHITE_MAGE",
    "JOB_GESTURE_BLACK_MAGE",
    "JOB_GESTURE_RED_MAGE",
    "JOB_GESTURE_THIEF",
    "JOB_GESTURE_PALADIN",
    "JOB_GESTURE_DARK_KNIGHT",
    "JOB_GESTURE_BEASTMASTER",
    "JOB_GESTURE_BARD",
    "JOB_GESTURE_RANGER",
    "JOB_GESTURE_SAMURAI",
    "JOB_GESTURE_NINJA",
    "JOB_GESTURE_DRAGOON",
    "JOB_GESTURE_SUMMONER",
    "JOB_GESTURE_BLUE_MAGE",
    "JOB_GESTURE_CORSAIR",
    "JOB_GESTURE_PUPPETMASTER",
    "JOB_GESTURE_DANCER",
    "JOB_GESTURE_SCHOLAR",
    "JOB_GESTURE_GEOMANCER",
    "JOB_GESTURE_RUNE_FENCER",
};

std::vector<std::string> const chairKeyItems = {
    "IMPERIAL_CHAIR",
    "DECORATIVE_CHAIR",
    "ORNATE_STOOL",
    "REFINED_CHAIR",
    "PORTABLE_CONTAINER",
    "CHOCOBO_CHAIR",
    "EPHRAMADIAN_THRONE",
    "SHADOW_THRONE",
    "LEAF_BENCH",
    "ASTRAL_CUBE",
    "CHOCOBO_CHAIR_II",
};

class CCharEntity;

class CCharEmoteListPacket : public CBasicPacket
{
public:
    CCharEmoteListPacket(CCharEntity* PChar);
};

#endif
