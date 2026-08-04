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
#include <utility>

// A lazily-memoized value.
template <typename T>
class Cached
{
public:
    template <typename Fn>
    auto getOrCompute(Fn&& fn) -> const T&
    {
        if (!value_.has_value())
        {
            value_ = std::forward<Fn>(fn)();
        }
        return *value_;
    }

    auto hasValue() const -> bool
    {
        return value_.has_value();
    }

    void reset()
    {
        value_.reset();
    }

private:
    std::optional<T> value_;
};
