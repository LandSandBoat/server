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

#include <cstdint>
#include <limits>

class NullRandomEngine
{
public:
    using result_type = uint64_t;

    static constexpr auto min() -> result_type;
    static constexpr auto max() -> result_type;

    constexpr auto operator()() -> result_type;

    constexpr auto seed(result_type) -> void;

    template <class Sseq>
    constexpr auto seed(Sseq&) -> void;
};

constexpr auto NullRandomEngine::min() -> result_type
{
    return 0;
}

constexpr auto NullRandomEngine::max() -> result_type
{
    return std::numeric_limits<result_type>::max();
}

constexpr auto NullRandomEngine::operator()() -> result_type
{
    return (min() + max()) / 2;
}

constexpr auto NullRandomEngine::seed(result_type) -> void
{
}

template <class Sseq>
constexpr auto NullRandomEngine::seed(Sseq&) -> void
{
}
