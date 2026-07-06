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

#ifndef _ACTIONQUEUE_H
#define _ACTIONQUEUE_H

#include "common/timer.h"

#include "common/types/fn.h"
#include "common/types/heap.h"

class CBaseEntity;

struct queueAction_t
{
    // Move-only: queued actions can capture move-only state, and pushing/popping
    // moves the callable instead of copying it.
    using EntityFunc_t = Fn<void(CBaseEntity*)>;

    timer::time_point deadline;
    bool              checkState{ false };
    EntityFunc_t      func{};

    queueAction_t(timer::duration _ms, bool _checkstate, EntityFunc_t _func)
    : deadline(timer::now() + _ms)
    , checkState(_checkstate)
    , func(std::move(_func))
    {
    }
};

// Min-heap ordering: the action with the soonest deadline is at the top.
struct QueueActionDeadlineGreater
{
    bool operator()(const queueAction_t& lhs, const queueAction_t& rhs) const noexcept
    {
        return lhs.deadline > rhs.deadline;
    }
};

class CAIActionQueue
{
public:
    explicit CAIActionQueue(CBaseEntity*);

    void pushAction(queueAction_t&&);
    void checkAction(timer::time_point tick);

    void clearActionQueue();
    void clearTimerQueue();
    bool isEmpty() const;

private:
    void handleAction(queueAction_t& action);

    using ActionHeap_t = Heap<queueAction_t, QueueActionDeadlineGreater>;

    CBaseEntity* PEntity;
    ActionHeap_t actionQueue;
    ActionHeap_t timerQueue;
};

#endif
