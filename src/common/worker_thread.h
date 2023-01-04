/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "common/cbasetypes.h"
#include "common/sql.h"

#include "map/navmesh.h"

#include <concurrentqueue.h>

/*
Usage:
    // void()
    {
        auto wt = WorkerThread<void()>();

        // clang-format off
        wt.enqueue([]()
        {
            // Do something
        });
        // clang-format on
    }

    // void(SqlConnection*)
    {
        int  id = 42;
        auto wt = WorkerThread<void(SqlConnection*)>();

        // clang-format off
        wt.enqueue([id](SqlConnection* context)
        {
            // Use `SqlConnection* sql` and anything you've captured:
            auto ret = sql->Query(fmt::format(
                "SELECT * FROM chars WHERE charid = {} LIMIT 1;", id).c_str());
            if (ret == SQL_ERROR)
            {
                // ...
            }
        });
        // clang-format on
    }
*/

// clang-format off
template <typename... Ts> struct first_arg { using type = void; };
template <typename T, typename... Ts> struct first_arg<T, Ts...> { using type = T; };
template <typename... Ts> using first_arg_t = typename first_arg<Ts...>::type;
// clang-format on

template <typename Signature>
class WorkerThread;

template <typename R, typename... Args>
class WorkerThread<R(Args...)>
{
    using Arg              = first_arg_t<Args...>;
    using Context          = typename std::remove_pointer<Arg>::type;
    using TaskFunc         = std::function<R(Args...)>;
    using TaskFuncReturn   = typename TaskFunc::result_type;
    using nothing_t        = std::monostate;
    using NothingOrReturn  = std::conditional_t<std::is_void_v<TaskFuncReturn>, nothing_t, TaskFuncReturn>;
    using NothingOrContext = std::conditional_t<std::is_void_v<Context>, nothing_t, Context>;

    static_assert(std::disjunction_v<std::is_pointer<Arg>, std::is_void<Arg>>, R"(
        The Arg in WorkerThread<R(Arg)> has to be either void or a pointer to a type.
        If it is a pointer to a type the base type will be instantiated once
        and a pointer to it will be passed into each TaskFunc.)");

public:
    template <typename... CArgs>
    WorkerThread(CArgs... args)
    : m_running(true)
    , m_context(std::make_unique<NothingOrContext>(std::forward<CArgs>(args)...))
    , m_thread(std::thread(&WorkerThread::_inner_loop, this))
    {
    }

    ~WorkerThread()
    {
        m_running = false;
        m_condition.notify_all();
        m_thread.join();
    }

    void enqueue(TaskFunc&& func)
    {
        m_inputQueue.enqueue(std::move(func));
        m_condition.notify_one();
    }

    bool try_dequeue_result(NothingOrReturn& out)
    {
        return m_outputQueue.try_dequeue(out);
    }

    bool has_pending_input()
    {
        return m_inputQueue.size_approx();
    }

    bool has_pending_output()
    {
        return m_outputQueue.size_approx();
    }

private:
    void _inner_loop()
    {
        std::unique_lock<std::mutex> lock(m_bottleneck);

        while (m_running)
        {
            TaskFunc task;
            if (m_inputQueue.try_dequeue(task))
            {
                if constexpr (std::is_void_v<R>)
                {
                    if constexpr (std::is_void_v<Context>)
                    {
                        task();
                    }
                    else
                    {
                        task(m_context.get());
                    }
                }
                else
                {
                    if constexpr (std::is_void_v<Context>)
                    {
                        m_outputQueue.enqueue(std::move(task()));
                    }
                    else
                    {
                        m_outputQueue.enqueue(std::move(task(m_context.get())));
                    }
                }
            }
            else
            {
                m_condition.wait(lock);
            }
        }
    }

    std::thread m_thread;

    moodycamel::ConcurrentQueue<TaskFunc>        m_inputQueue;
    moodycamel::ConcurrentQueue<NothingOrReturn> m_outputQueue;

    std::atomic<bool>       m_running;
    std::mutex              m_bottleneck;
    std::condition_variable m_condition;

    std::unique_ptr<NothingOrContext> m_context;
};
