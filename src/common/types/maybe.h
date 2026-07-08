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

#include <optional>

// namespace xi
// {

//
// Maybe<T>
//

// TODO: Replace with a third-party optional impl which supports reference types, until the STL
//     : supports them.
template <typename T>
using Maybe = std::optional<T>;

// TODO: Rename to apply() once we're using xi:: namespace, because otherwise we'll collide with std
template <typename T, typename F>
void applyTo(const Maybe<T>& maybe, F fn)
{
    if (maybe)
    {
        fn(*maybe);
    }
}

// } // namespace xi
