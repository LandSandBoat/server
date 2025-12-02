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

namespace xi
{

template <typename Container, typename Predicate>
void eraseIf(Container& container, Predicate&& pred)
{
    auto it = container.begin();
    while (it != container.end())
    {
        if (pred(*it))
        {
            it = container.erase(it); // erase returns the next valid iterator
        }
        else
        {
            ++it;
        }
    }
}

} // namespace xi
