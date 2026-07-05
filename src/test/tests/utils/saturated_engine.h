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

#include <cstdint>

namespace xirand::test
{

// Engine pinned to all-ones output: drives canonical53 to its largest value
// (1 - 2^-53), the draw most likely to round up to max downstream. Satisfies
// std::uniform_random_bit_generator, so it can stand in for a real engine
// anywhere a worst-case draw is needed.
struct SaturatedEngine
{
    using result_type = std::uint32_t;

    static constexpr auto min() -> result_type
    {
        return 0;
    }

    static constexpr auto max() -> result_type
    {
        return UINT32_MAX;
    }

    constexpr auto operator()() -> result_type
    {
        return UINT32_MAX;
    }
};

} // namespace xirand::test
