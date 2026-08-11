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

#include <type_traits>
#include <vector>

namespace db
{

// A copy of a trivially-copyable value's bytes, bound as a blob parameter. Owning the bytes keeps
// them alive independently of the caller's original object.
struct Blob
{
    std::vector<char> bytes;
};

// Copy `source`'s object representation into a blob parameter.
template <typename T>
[[nodiscard]] auto makeBlob(const T& source) -> Blob
{
    static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable");

    const auto* first = reinterpret_cast<const char*>(&source);

    return Blob{ std::vector<char>(first, first + sizeof(T)) };
}

} // namespace db
