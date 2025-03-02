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

#include "action_queue.h"
#include "ai/ai_container.h"
#include "entities/baseentity.h"
#include "lua/lua_baseentity.h"
#include "lua/luautils.h"

CAIActionQueue::CAIActionQueue(CBaseEntity* _PEntity)
: PEntity(_PEntity)
{
}

void CAIActionQueue::pushAction(queueAction_t&& action)
{
    if (action.checkState)
    {
        actionQueue.push(std::move(action));
    }
    else
    {
        timerQueue.push(std::move(action));
    }
}

void CAIActionQueue::checkAction(time_point tick)
{
    while (!timerQueue.empty())
    {
        const auto& topaction = timerQueue.top();
        if (tick > topaction.start_time + topaction.delay)
        {
            queueAction_t action = timerQueue.top();
            timerQueue.pop();
            handleAction(action);
        }
        else
        {
            break;
        }
    }
    while (!actionQueue.empty())
    {
        const auto& topaction = actionQueue.top();
        if (tick > topaction.start_time + topaction.delay && (!topaction.checkState || PEntity->PAI->CanChangeState()))
        {
            auto action = actionQueue.top();
            actionQueue.pop();
            handleAction(action);
        }
        else
        {
            break;
        }
    }
}

void CAIActionQueue::handleAction(queueAction_t& action)
{
    if (action.lua_func.valid())
    {
        auto result = action.lua_func(PEntity);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("CAIActionQueue::handleAction for %s (%i): %s", PEntity->name, PEntity->id, err.what());
        }
    }

    if (action.func)
    {
        action.func(PEntity);
    }
}

bool CAIActionQueue::isEmpty()
{
    return actionQueue.empty() && timerQueue.empty();
}

void CAIActionQueue::clearActionQueue()
{
    while (!actionQueue.empty())
    {
        actionQueue.pop();
    }
}

void CAIActionQueue::clearTimerQueue()
{
    while (!timerQueue.empty())
    {
        timerQueue.pop();
    }
}
