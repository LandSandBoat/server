/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#ifndef _CCHAREMOTIONPACKET_H
#define _CCHAREMOTIONPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

enum class Emote : uint8
{
    POINT      = 0,
    BOW        = 1,
    SALUTE     = 2,
    KNEEL      = 3,
    LAUGH      = 4,
    CRY        = 5,
    NO         = 6,
    YES        = 7,
    WAVE       = 8,
    GOODBYE    = 9,
    WELCOME    = 10,
    JOY        = 11,
    CHEER      = 12,
    CLAP       = 13,
    PRAISE     = 14,
    SMILE      = 15,
    POKE       = 16,
    SLAP       = 17,
    STAGGER    = 18,
    SIGH       = 19,
    COMFORT    = 20,
    SURPRISED  = 21,
    AMAZED     = 22,
    STARE      = 23,
    BLUSH      = 24,
    ANGRY      = 25,
    DISGUSTED  = 26,
    MUTED      = 27,
    DOZE       = 28,
    PANIC      = 29,
    GRIN       = 30,
    DANCE      = 31,
    THINK      = 32,
    FUME       = 33,
    DOUBT      = 34,
    SULK       = 35,
    PSYCH      = 36,
    HUH        = 37,
    SHOCKED    = 38,
    LOGGING    = 40, // Only used for HELM
    EXCAVATION = 41, // Only used for HELM
    HARVESTING = 42, // Only used for HELM
    HURRAY     = 43,
    TOSS       = 44,
    DANCE1     = 65,
    DANCE2     = 66,
    DANCE3     = 67,
    DANCE4     = 68,
    JOB        = 74
};

enum class EmoteMode : uint8
{
    ALL    = 0,
    TEXT   = 1,
    MOTION = 2
};

class CCharEntity;

class CCharEmotionPacket : public CBasicPacket
{
public:
    CCharEmotionPacket(CCharEntity* PChar, uint32 TargetID, uint16 TargetIndex, Emote EmoteID, EmoteMode emoteMode, uint16 extra);
};

#endif
