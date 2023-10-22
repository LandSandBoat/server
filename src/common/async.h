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

#include "singleton.h"
#include "sql.h"
#include <task_system.hpp>

#include <functional>
#include <string>

class Async : public Singleton<Async>, private ts::task_system
{
public:
    void query(std::string const& query);
    void query(std::function<void(SqlConnection*)> const& func);
    void submit(std::function<void()> const& func);

protected:
    Async();
};
