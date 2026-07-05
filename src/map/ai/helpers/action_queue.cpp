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
#include "entities/base_entity.h"
#include "lua/lua_base_entity.h"
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

void CAIActionQueue::checkAction(timer::time_point tick)
{
    while (!timerQueue.empty())
    {
        const auto& topaction = timerQueue.top();
        if (tick > topaction.start_time + topaction.delay)
        {
            // Safe: the element isn't const and pop() follows before the queue is used again.
            // priority_queue has no API to move out of top().
            // NOLINTNEXTLINE(cppcoreguidelines-pro-type-const-cast)
            queueAction_t action = std::move(const_cast<queueAction_t&>(timerQueue.top()));
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
            // Safe: the element isn't const and pop() follows before the queue is used again.
            // priority_queue has no API to move out of top().
            // NOLINTNEXTLINE(cppcoreguidelines-pro-type-const-cast)
            auto action = std::move(const_cast<queueAction_t&>(actionQueue.top()));
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
