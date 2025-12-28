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

#pragma once

#include "common/cbasetypes.h"

enum class Emote : uint8
{
    Point      = 0,
    Bow        = 1,
    Salute     = 2,
    Kneel      = 3,
    Laugh      = 4,
    Cry        = 5,
    No         = 6,
    Yes        = 7,
    Wave       = 8,
    Goodbye    = 9,
    Welcome    = 10,
    Joy        = 11,
    Cheer      = 12,
    Clap       = 13,
    Praise     = 14,
    Smile      = 15,
    Poke       = 16,
    Slap       = 17,
    Stagger    = 18,
    Sigh       = 19,
    Comfort    = 20,
    Surprised  = 21,
    Amazed     = 22,
    Stare      = 23,
    Blush      = 24,
    Angry      = 25,
    Disgusted  = 26,
    Muted      = 27,
    Doze       = 28,
    Panic      = 29,
    Grin       = 30,
    Dance      = 31,
    Think      = 32,
    Fume       = 33,
    Doubt      = 34,
    Sulk       = 35,
    Psych      = 36,
    Huh        = 37,
    Shocked    = 38,
    Logging    = 40, // Only used for HELM
    Excavation = 41, // Only used for HELM
    Harvesting = 42, // Only used for HELM
    Hurray     = 43,
    Toss       = 44,
    Dance1     = 65,
    Dance2     = 66,
    Dance3     = 67,
    Dance4     = 68,
    Bell       = 73,
    Job        = 74,
    Aim        = 96
};

enum class EmoteMode : uint8
{
    All    = 0,
    Text   = 1,
    Motion = 2
};
