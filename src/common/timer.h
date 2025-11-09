/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams
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

#include <chrono>

#include "cbasetypes.h"
#include "earth_time.h"

namespace timer
{

// This clock is not stable across reboots.
// Use earth_time if you need real time.
// Use timer::to_utc/timer::from_utc to persist timestamps to the database (status effects).
using clock      = std::chrono::steady_clock;
using duration   = clock::duration;
using time_point = clock::time_point;

inline const time_point start_time = clock::now();
inline duration         time_offset{ 0 };

inline time_point now()
{
    return clock::now() + time_offset;
}

inline duration get_uptime()
{
    return clock::now() - start_time;
}

// https://stackoverflow.com/questions/35282308/convert-between-c11-clocks/35282833#35282833
inline earth_time::time_point to_utc(const time_point& timer_tp = now())
{
    const auto utc_now   = earth_time::now();
    const auto timer_now = timer::now();
    return std::chrono::time_point_cast<earth_time::duration>(timer_tp - timer_now + utc_now);
};

inline time_point from_utc(const earth_time::time_point& utc_tp = earth_time::now())
{
    const auto timer_now = timer::now();
    const auto utc_now   = earth_time::now();
    return utc_tp - utc_now + timer_now;
};

inline void add_offset(const duration& additional_offset)
{
    time_offset += additional_offset;
}

inline void reset_offset()
{
    time_offset = duration{ 0 };
}

// Gets the Earth milliseconds of a duration.
template <typename Rep, typename Period>
auto count_milliseconds(const std::chrono::duration<Rep, Period>& d) -> int64
{
    return std::chrono::floor<std::chrono::milliseconds>(d).count();
};

// Gets the Earth seconds of a duration.
template <typename Rep, typename Period>
auto count_seconds(const std::chrono::duration<Rep, Period>& d) -> int64
{
    return std::chrono::floor<std::chrono::seconds>(d).count();
};

}; // namespace timer
