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

#include <utility>

#include "common/logging.h"
#include "common/task_manager.h"
#include "common/tracy.h"
#include "common/utils.h"

CTaskManager::~CTaskManager()
{
    while (!m_TaskList.empty())
    {
        CTask* PTask = m_TaskList.top();
        m_TaskList.pop();

        destroy(PTask);
    }
}

CTaskManager::CTask* CTaskManager::AddTask(CTask* PTask)
{
    TracyZoneScoped;

    m_TaskList.push(PTask);
    return PTask;
}

void CTaskManager::RemoveTask(const std::string& TaskName)
{
    TracyZoneScoped;

    // m_TaskList is a priority_queue, so we can't directly pull members out of it.
    //
    // Tasks are compared using their m_tick values, so we can safely remove all the tasks
    // and re-insert them, sans the one we're trying to remove.

    std::size_t tasksRemoved = 0;
    TaskList_t  newPq;
    while (!m_TaskList.empty())
    {
        CTask* PTask = m_TaskList.top();
        m_TaskList.pop();

        // Don't add tasks we're trying to remove to the new pq
        // FIXME: duplicate task names AREN'T checked on insert!
        if (PTask->m_name != TaskName)
        {
            newPq.push(PTask);
        }
        else
        {
            ++tasksRemoved;
            destroy(PTask);
        }
    }

    if (tasksRemoved == 0)
    {
        ShowWarning("Tried to remove task: %s, but didn't find it!", TaskName);
    }

    // Replace the old queue with the new queue
    m_TaskList = newPq;
}

timer::duration CTaskManager::doExpiredTasks(timer::time_point tick) // tick is normally timer::now()
{
    TracyZoneScoped;

    const auto start = timer::now();

    timer::duration diff = 1s;
    while (!m_TaskList.empty())
    {
        CTask* PTask = m_TaskList.top();
        TracyZoneString(PTask->m_name);

        diff = PTask->m_tick - tick;
        if (diff > 0s)
        {
            break; // no more expired timers to process
        }

        m_TaskList.pop();

        if (PTask->m_func)
        {
            PTask->m_func((diff < -1s ? tick : PTask->m_tick), PTask);
        }

        switch (PTask->m_type)
        {
            case TASK_INTERVAL:
            {
                PTask->m_tick = PTask->m_interval + (diff < -1s ? tick : PTask->m_tick);
                m_TaskList.push(PTask);
            }
            break;
            case TASK_ONCE:
            case TASK_REMOVE:
            default:
            {
                destroy(PTask); // suppose that all tasks were allocated by new
            }
            break;
        }
    }

    return timer::now() - start;
}
