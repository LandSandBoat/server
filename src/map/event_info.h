/*
===========================================================================

  Copyright (c) 2020-2021 Eden Dev Teams

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

#ifndef _EVENT_INFO_H
#define _EVENT_INFO_H

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include <bitset>
#include <deque>
#include <map>
#include <vector>

class CBaseEntity;

struct EventPrep
{
    CBaseEntity* targetEntity = {};
    std::string  scriptFile;

    void reset()
    {
        targetEntity = 0;
        scriptFile.clear();
    }
};

enum EVENT_TYPE : uint8
{
    NORMAL,
    CUTSCENE,
    OPTIONAL_CUTSCENE,
};

struct EventInfo : EventPrep
{
    int32                        eventId = -1;
    int32                        option  = 0;
    std::map<uint8, uint32>      params;
    std::map<uint8, std::string> strings;
    int16                        textTable = -1;

    EVENT_TYPE         type = NORMAL;
    std::vector<int32> cutsceneOptions;
    uint16             interruptText = 0;
    uint32             eventFlags    = 0;

    bool hasCutsceneOption(int32 _option)
    {
        return std::find(cutsceneOptions.begin(), cutsceneOptions.end(), _option) != cutsceneOptions.end();
    }

    void reset()
    {
        EventPrep::reset();
        eventId = -1;
        option  = 0;
        cutsceneOptions.clear();
        params.clear();
        strings.clear();
        textTable  = -1;
        eventFlags = 0;
    }
};

#endif
