/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "logging_context.h"

namespace
{

auto stack() -> std::vector<logging::Field>&
{
    thread_local std::vector<logging::Field> s;
    return s;
}

} // namespace

logging::LogScope::LogScope(std::initializer_list<Field> fields)
: pushedCount_(fields.size())
{
    auto& s = stack();
    s.insert(s.end(), fields.begin(), fields.end());
}

logging::LogScope::~LogScope()
{
    auto& s = stack();
    s.erase(s.end() - pushedCount_, s.end());
}

auto logging::currentContext() -> const std::vector<Field>&
{
    return stack();
}
