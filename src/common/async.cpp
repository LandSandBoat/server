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

#include "async.h"

#include "sql.h"
#include <task_system.hpp>

// Allocated on and owned the main thread
Async*           Async::_instance = nullptr;
ts::task_system* Async::_ts       = nullptr;

// Allocated on and owned by by _ts
SqlConnection* Async::_sql = nullptr;

Async* Async::getInstance()
{
    if (_instance == nullptr)
    {
        _instance = new Async();

        // NOTE: We only create a single worker thread in the task_system
        //     : because we're going to be using _sql, which isn't thread safe.
        // TODO: Wrap access to _sql in a mutex so it can be shared between
        //     : threads, and then bump the worker thread count.
        _ts = new ts::task_system(1);
    }
    return _instance;
}

void Async::query(std::string const& query)
{
    // clang-format off
    _ts->schedule([query]()
    {
        TracySetThreadName("Async Worker Thread");
        if (_sql == nullptr)
        {
            _sql = new SqlConnection();
        }
        _sql->Query(query.c_str());
    });
    // clang-format on
}

// NOTE: Be _very_ careful when defining your sql argument in the passed-in function.
//     : If you define your arg as _sql, but then call sql, it will use the global
//     : SQLConnection, which is on the main thread.
//     : Remember that SQLConnection is NOT THREAD-SAFE!
void Async::query(std::function<void(SqlConnection*)> const& func)
{
    // clang-format off
    _ts->schedule([func]()
    {
        TracySetThreadName("Async Worker Thread");
        if (_sql == nullptr)
        {
            _sql = new SqlConnection();
        }
        func(_sql);
    });
    // clang-format on
}

void Async::submit(std::function<void()> const& func)
{
    // clang-format off
    _ts->schedule([func]()
    {
        TracySetThreadName("Async Worker Thread");
        func();
    });
    // clang-format on
}
