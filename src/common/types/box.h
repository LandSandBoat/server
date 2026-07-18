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

#pragma once

#include <memory>
#include <utility>

// namespace xi
// {

//
// Box<T>
//
template <typename T>
using Box = std::unique_ptr<T>;

template <typename T, typename... Args>
auto makeBox(Args&&... args) -> Box<T>
{
    return std::make_unique<T>(std::forward<Args>(args)...);
}

// } // namespace xi
