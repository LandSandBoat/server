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

#include <chrono>

#include "cbasetypes.h"
#include "xi.h"

enum DAYTYPE : uint8
{
    FIRESDAY     = 0,
    EARTHSDAY    = 1,
    WATERSDAY    = 2,
    WINDSDAY     = 3,
    ICEDAY       = 4,
    LIGHTNINGDAY = 5,
    LIGHTSDAY    = 6,
    DARKSDAY     = 7
};

namespace vanadiel_time
{

using clock      = xi::vanadiel_clock;
using duration   = clock::duration;
using time_point = clock::time_point;

enum TOTD : uint8
{
    NONE     = 0,
    MIDNIGHT = 1,
    NEWDAY   = 2,
    DAWN     = 3,
    DAY      = 4,
    DUSK     = 5,
    EVENING  = 6,
    NIGHT    = 7
};

inline time_point now()
{
    return clock::now();
}

inline earth_time::time_point to_earth_time(const time_point& vanadiel_tp = now())
{
    const earth_time::duration earth_since_epoch = std::chrono::duration_cast<earth_time::duration>(vanadiel_tp.time_since_epoch());
    return earth_time::time_point(earth_since_epoch + earth_time::vanadiel_epoch);
};

inline time_point from_earth_time(const earth_time::time_point& earth_tp = earth_time::now())
{
    const clock::duration vanadiel_since_epoch = std::chrono::duration_cast<clock::duration>(earth_tp - earth_time::vanadiel_epoch);
    return time_point(vanadiel_since_epoch);
};

inline uint32 count_weeks(const duration& d)
{
    const clock::weeks total_weeks = std::chrono::floor<clock::weeks>(d);
    return static_cast<uint32>(total_weeks.count());
}

inline uint32 count_days(const duration& d)
{
    const clock::days total_days = std::chrono::floor<clock::days>(d);
    return static_cast<uint32>(total_days.count());
}

// seconds after the minute - [​0​, 60]
inline uint32 get_second(const time_point& tp = now())
{
    const duration       since_epoch = tp.time_since_epoch();
    const clock::minutes minutes     = std::chrono::floor<clock::minutes>(since_epoch);
    const clock::seconds seconds     = std::chrono::floor<clock::seconds>(since_epoch);
    return static_cast<uint32>((seconds % minutes).count());
}
// minutes after the hour – [​0​, 59]
inline uint32 get_minute(const time_point& tp = now())
{
    const duration       since_epoch = tp.time_since_epoch();
    const clock::hours   hours       = std::chrono::floor<clock::hours>(since_epoch);
    const clock::minutes minutes     = std::chrono::floor<clock::minutes>(since_epoch);
    return static_cast<uint32>((minutes % hours).count());
}
// hours since midnight – [​0​, 23]
inline uint32 get_hour(const time_point& tp = now())
{
    const duration     since_epoch = tp.time_since_epoch();
    const clock::days  days        = std::chrono::floor<clock::days>(since_epoch);
    const clock::hours hours       = std::chrono::floor<clock::hours>(since_epoch);
    return static_cast<uint32>((hours % days).count());
}
// day of the month – [1, 30]
inline uint32 get_monthday(const time_point& tp = now())
{
    const duration      since_epoch = tp.time_since_epoch();
    const clock::months months      = std::chrono::floor<clock::months>(since_epoch);
    const clock::days   days        = std::chrono::ceil<clock::days>(since_epoch);
    return static_cast<uint32>((days % months).count());
}
// current month – [​1​, 12]
inline uint32 get_month(const time_point& tp = now())
{
    const duration      since_epoch = tp.time_since_epoch();
    const clock::years  years       = std::chrono::floor<clock::years>(since_epoch);
    const clock::months months      = std::chrono::ceil<clock::months>(since_epoch);
    return static_cast<uint32>((months % years).count());
}
// years since 886
inline int32 get_year(const time_point& tp = now())
{
    const duration     since_epoch = tp.time_since_epoch();
    const clock::years years       = std::chrono::floor<clock::years>(since_epoch);
    return static_cast<int32>(years.count());
}
// days since Firesday – [​0​, 7]
inline uint32 get_weekday(const time_point& tp = now())
{
    const duration     since_epoch = tp.time_since_epoch();
    const clock::weeks weeks       = std::chrono::floor<clock::weeks>(since_epoch);
    const clock::days  days        = std::chrono::floor<clock::days>(since_epoch);
    return static_cast<uint32>((days % weeks).count());
}
// days since 1st day of year – [​0​, 360]
inline uint32 get_yearday(const time_point& tp = now())
{
    const duration     since_epoch = tp.time_since_epoch();
    const clock::years years       = std::chrono::floor<clock::years>(since_epoch);
    const clock::days  days        = std::chrono::floor<clock::days>(since_epoch);
    return static_cast<uint32>((days % years).count());
}

inline time_point get_next_midnight(const time_point& tp = now())
{
    return std::chrono::ceil<clock::days>(tp);
}

/**
 * Gets the time of the day for the current or given time point.
 * @returns NONE, MIDNIGHT, NEWDAY, DAWN, DAY, DUSK, EVENING, NIGHT
 */
inline TOTD get_totd(const time_point& tp = now())
{
    switch (get_hour(tp))
    {
        case 0:
        case 1:
        case 2:
        case 3:
            return TOTD::MIDNIGHT;
        case 4:
        case 5:
            return TOTD::NEWDAY;
        case 6:
            return TOTD::DAWN;
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
        case 16:
            return TOTD::DAY;
        case 17:
            return TOTD::DUSK;
        case 18:
        case 19:
            return TOTD::EVENING;
        case 20:
        case 21:
        case 22:
        case 23:
            return TOTD::NIGHT;
        default:
            return TOTD::NONE;
    }
}

namespace moon
{

inline uint32 get_phase(const time_point& tp = now())
{
    int32  phase   = 0;
    double daysmod = static_cast<int32>((count_days(tp.time_since_epoch() + clock::years(886)) + 26) % 84);

    if (daysmod >= 42)
    {
        phase = static_cast<int32>(100 * ((daysmod - 42) / 42) + 0.5);
    }
    else
    {
        phase = static_cast<int32>(100 * (1 - (daysmod / 42)) + 0.5);
    }

    return phase;
}

/**
 * Gets the moon direction for the current or given time point.
 * @returns
 * ```
 * 0: Neither
 * 1: Waning
 * 2: Waxing
 * ```
 */
inline uint8 get_direction(const time_point& tp = now())
{
    double daysmod = static_cast<int32>((count_days(tp.time_since_epoch() + clock::years(886)) + 26) % 84);

    if (daysmod == 42 || daysmod == 0)
    {
        return 0; // neither waxing nor waning
    }
    else if (daysmod < 42)
    {
        return 1; // waning
    }
    else
    {
        return 2; // waxing
    }
}

} // namespace moon

namespace rse
{

inline uint8 get_race(const time_point& tp = now())
{
    return static_cast<uint8>(count_weeks(tp.time_since_epoch()) % 8 + 1);
}

/**
 * Gets the RSE location for the current or given time point.
 * @returns
 * ```
 * 0: Ordelle's Caves
 * 1: Gusgen Mines
 * 2: Maze of Shakhrami
 * ```
 */
inline uint8 get_location(const time_point& tp = now())
{
    return static_cast<uint8>(count_weeks(tp.time_since_epoch()) % 3);
}

} // namespace rse
}; // namespace vanadiel_time
