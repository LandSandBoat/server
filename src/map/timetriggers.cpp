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

#include "timetriggers.h"

#include "common/vana_time.h"

#include "lua/luautils.h"

std::unique_ptr<CTriggerHandler> CTriggerHandler::_instance;

CTriggerHandler* CTriggerHandler::getInstance()
{
    if (!_instance)
    {
        _instance.reset(new CTriggerHandler);
    }

    return _instance.get();
}

void CTriggerHandler::insertTrigger(Trigger_t trigger)
{
    trigger.lastTrigger = (CVanaTime::getInstance()->getDate() - trigger.minuteOffset) / trigger.period;
    triggerList.push_back(trigger);
}

void CTriggerHandler::triggerTimer()
{
    uint32     vanaTime  = CVanaTime::getInstance()->getDate();
    uint32     timeCount = 0;
    Trigger_t* trigger   = nullptr;

    for (auto& i : triggerList)
    {
        trigger   = &i;
        timeCount = (vanaTime - trigger->minuteOffset) / trigger->period;

        if (timeCount > trigger->lastTrigger)
        {
            luautils::OnTimeTrigger(trigger->npc, trigger->id);
            trigger->lastTrigger = timeCount;
        }
    }
}
