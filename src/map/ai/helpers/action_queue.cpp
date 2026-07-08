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
    while (!timerQueue.empty() && tick > timerQueue.top().deadline)
    {
        queueAction_t action = timerQueue.pop();
        handleAction(action);
    }

    while (!actionQueue.empty() && tick > actionQueue.top().deadline && PEntity->PAI->CanChangeState())
    {
        queueAction_t action = actionQueue.pop();
        handleAction(action);
    }
}

void CAIActionQueue::handleAction(queueAction_t& action)
{
    if (action.func)
    {
        action.func(PEntity);
    }
}

bool CAIActionQueue::isEmpty() const
{
    return actionQueue.empty() && timerQueue.empty();
}

void CAIActionQueue::clearActionQueue()
{
    actionQueue.clear();
}

void CAIActionQueue::clearTimerQueue()
{
    timerQueue.clear();
}
