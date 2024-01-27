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

#ifndef _CTIMETRIGGERS_H
#define _CTIMETRIGGERS_H

#include "common/cbasetypes.h"
#include "common/singleton.h"
#include "entities/npcentity.h"
#include <vector>

struct Trigger_t
{
    uint8 id; // trigger id unique to the NPC.

    CNpcEntity* npc; // NPC entity that the trigger belongs to

    uint16 period;       // The time in vanadiel minutes between two firings of the trigger
    uint16 minuteOffset; // The time in vanadiel minutes after SE epoch which the period syncs to

    uint32 lastTrigger; // Used to store the last firing of the trigger
};

class CTriggerHandler : public Singleton<CTriggerHandler>
{
public:
    void insertTrigger(Trigger_t);
    void triggerTimer();

protected:
    CTriggerHandler() = default;

private:
    std::vector<Trigger_t> triggerList;
};
#endif
