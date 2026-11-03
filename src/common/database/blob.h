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

#include <cstddef>
#include <memory>
#include <type_traits>

namespace db
{

// The bytes of a trivially copyable value, copied so they outlive the value they came from.
struct BlobWrapper
{
    std::unique_ptr<char[]> data;
    std::size_t             size;

    template <typename T>
    static auto create(const T& source) -> std::shared_ptr<BlobWrapper>;

    BlobWrapper(const char* source, std::size_t size);
};

//
// Out-of-line template definitions
//

template <typename T>
auto BlobWrapper::create(const T& source) -> std::shared_ptr<BlobWrapper>
{
    static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable");
    return std::make_shared<BlobWrapper>(reinterpret_cast<const char*>(&source), sizeof(T));
}

} // namespace db
