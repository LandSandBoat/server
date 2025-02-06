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

#include <asio/io_context.hpp>

#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <functional>
#include <iostream>
#include <memory>
#include <string>
#include <thread>
#include <unordered_map>
#include <vector>

using duration   = std::chrono::steady_clock::duration;
using time_point = std::chrono::steady_clock::time_point;

namespace
{
    constexpr std::chrono::milliseconds kMinWaitMs{ 50 };
    constexpr std::chrono::milliseconds kMaxWaitMs{ 1000 };
} // namespace

using TaskFunc = std::function<void(time_point)>;

enum class TaskKind
{
    TASK_ONCE,
    TASK_INTERVAL
};

struct Task
{
    uint64_t   id;
    time_point tick;     // Next scheduled execution time.
    duration   interval; // Recurrence interval.
    TaskKind   kind;     // One-time or recurring.
    TaskFunc   handler;  // Task callback.
};

struct TaskComparator
{
    bool operator()(const std::unique_ptr<Task>& a, const std::unique_ptr<Task>& b) const
    {
        return a->tick > b->tick;
    }
};

class Scheduler
{
public:
    Scheduler(asio::io_context& ioContext)
    : m_ioContext(ioContext)
    , nextTaskId(0)
    {
    }

    ~Scheduler()
    {
        tasks.clear();
    }

    uint64_t addTask(duration delay, bool recurring, std::function<void(time_point)> handler)
    {
        uint64_t id = nextTaskId++;

        auto now = std::chrono::steady_clock::now();

        auto t      = std::make_unique<Task>();
        t->id       = id;
        t->tick     = now + delay;
        t->interval = delay;
        t->kind     = recurring ? TaskKind::TASK_INTERVAL : TaskKind::TASK_ONCE;
        t->handler  = handler;

        tasks.push_back(std::move(t));

        // Rebuild the heap.
        std::push_heap(tasks.begin(), tasks.end(), TaskComparator());

        return id;
    }

    // Actively remove tasks with the given ID.
    void removeTask(uint64_t taskId)
    {
        const auto pred = [taskId](const auto& t)
        {
            return t->id == taskId;
        };

        auto newEnd = std::remove_if(tasks.begin(), tasks.end(), pred);
        if (newEnd != tasks.end())
        {
            tasks.erase(newEnd, tasks.end());
            std::make_heap(tasks.begin(), tasks.end(), TaskComparator());
        }
    }

    // Process all tasks that are due at or before 'now'.
    // For recurring tasks, reschedule them using:
    //   new_tick = (if >1s late: now, else previous tick) + interval.
    // Returns the time until the next scheduled task, clamped between kMinWaitMs and kMaxWaitMs.
    duration run(time_point now)
    {
        duration diff = std::chrono::seconds(1);
        while (!tasks_.empty())
        {
            // tasks.front() is the task with the earliest tick.
            diff = tasks.front()->tick - now;
            if (diff > duration::zero())
            {
                break; // No tasks are overdue.
            }

            // Pop the top task.
            std::pop_heap(tasks.begin(), tasks.end(), TaskComparator());
            auto task = std::move(tasks.back());
            tasks.pop_back();

            // If the task is very late (>1s late), call its handler with 'now'.
            if (diff < -std::chrono::seconds(1))
            {
                task->handler(now);
            }
            else
            {
                task->handler(task->tick);
            }

            if (task->kind == TaskKind::TASK_INTERVAL)
            {
                // Reschedule recurring task.
                if (now - task->tick > std::chrono::seconds(1))
                {
                    task->tick = now + task->interval;
                }
                else
                {
                    t->tick += t->interval;
                }

                tasks.push_back(std::move(task));

                // Rebuild the heap.
                std::push_heap(tasks.begin(), tasks.end(), TaskComparator());
            }

            // One-time tasks are destroyed when they fall out of scope.
        }

        // We clamp here because:
        // A minimum duration prevents the network run duration from being too short (which might starve network processing).
        // A maximum duration prevents a long wait (if no tasks are due) that might delay periodic network processing.
        diff = std::clamp(diff, kMinWaitMs, kMaxWaitMs);

        return diff;
    }

private:
    using TaskHeap = std::vector<std::unique_ptr<Task>>; // Maintained as a heap.

    // NOTE: We don't use ioContext_ yet, we're mimicking the synchronous TaskMgr.
    asio::io_context& ioContext_;

    uint64_t nextTaskId_;
    TaskHeap tasks_;
};
