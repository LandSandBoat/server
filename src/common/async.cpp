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

Async::Async()
: ts::task_system(1)
{
}

void Async::query(std::string const& query)
{
    // clang-format off
    this->schedule([query]()
    {
        TracySetThreadName("Async Worker Thread");
        static thread_local std::unique_ptr<SqlConnection> _sql;
        if (!_sql)
        {
            _sql = std::make_unique<SqlConnection>();
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
    this->schedule([func]()
    {
        TracySetThreadName("Async Worker Thread");
        static thread_local std::unique_ptr<SqlConnection> _sql;
        if (!_sql)
        {
            _sql = std::make_unique<SqlConnection>();
        }
        func(_sql.get());
    });
    // clang-format on
}

void Async::submit(std::function<void()> const& func)
{
    // clang-format off
    this->schedule([func]()
    {
        TracySetThreadName("Async Worker Thread");
        func();
    });
    // clang-format on
}
