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
#include <ctime>

#include "cbasetypes.h"

namespace earth_time
{

// Base clock for wall-clock time (UTC)
using clock      = std::chrono::system_clock;
using duration   = clock::duration;
using time_point = clock::time_point;

inline duration time_offset{ 0 };

// Unix time of the Vana'diel epoch
static constexpr earth_time::time_point vanadiel_epoch{ 1009810800s };

// Earth time = UTC
inline time_point now()
{
    return clock::now() + time_offset;
}

inline std::tm to_utc_tm(const time_point& tp = now())
{
    std::time_t time_t_val = clock::to_time_t(tp);
    std::tm     utc_tm{};
    _gmtime_s(&utc_tm, &time_t_val);
    return utc_tm;
}

inline std::tm to_local_tm(const time_point& tp = now())
{
    std::time_t time_t_val = clock::to_time_t(tp);
    std::tm     local_tm{};
    _localtime_s(&local_tm, &time_t_val);
    return local_tm;
}

inline void add_offset(const duration& additional_offset)
{
    time_offset += additional_offset;
}

inline void reset_offset()
{
    time_offset = duration{ 0 };
}

namespace utc
{

// seconds after the minute - [​0​, 60]
inline uint32 get_second(const time_point& tp = now())
{
    const auto days = std::chrono::floor<std::chrono::days>(tp);
    const auto time = std::chrono::hh_mm_ss<clock::duration>(tp - days);
    return static_cast<uint32>(time.seconds().count());
}
// minutes after the hour – [​0​, 59]
inline uint32 get_minute(const time_point& tp = now())
{
    const auto days = std::chrono::floor<std::chrono::days>(tp);
    const auto time = std::chrono::hh_mm_ss<clock::duration>(tp - days);
    return static_cast<uint32>(time.minutes().count());
}
// hours since midnight – [​0​, 23]
inline uint32 get_hour(const time_point& tp = now())
{
    const auto days = std::chrono::floor<std::chrono::days>(tp);
    const auto time = std::chrono::hh_mm_ss<clock::duration>(tp - days);
    return static_cast<uint32>(time.hours().count());
}
// day of the month – [1, 31]
inline uint32 get_monthday(const time_point& tp = now())
{
    const auto ymd = std::chrono::year_month_day(std::chrono::floor<std::chrono::days>(tp));
    return static_cast<uint32>(ymd.day());
}
// current month – [​1​, 12]
inline uint32 get_month(const time_point& tp = now())
{
    const auto ymd = std::chrono::year_month_day(std::chrono::floor<std::chrono::days>(tp));
    return static_cast<uint32>(ymd.month());
}
// current year
inline int32 get_year(const time_point& tp = now())
{
    const auto ymd = std::chrono::year_month_day(std::chrono::floor<std::chrono::days>(tp));
    return static_cast<int32>(ymd.year());
}
// days since Sunday – [​0​, 6]
inline uint32 get_weekday(const time_point& tp = now())
{
    return std::chrono::weekday(std::chrono::floor<std::chrono::days>(tp)).c_encoding();
}
// days since January 1 – [​0​, 365]
inline uint32 get_yearday(const time_point& tp = now())
{
    const auto years = std::chrono::floor<std::chrono::years>(tp);
    const auto days  = std::chrono::floor<std::chrono::days>(tp - years);
    return static_cast<uint32>(days.count());
}

inline time_point get_next_midnight(const time_point& tp = now())
{
    return std::chrono::ceil<std::chrono::days>(tp);
}

} // namespace utc

// https://github.com/llvm/llvm-project/issues/99982
// Japan Standard Time (UTC+9)
namespace jst
{

// seconds after the minute - [​0​, 60]
inline uint32 get_second(const time_point& tp = now())
{
    // const auto jst_tp = std::chrono::zoned_time(std::chrono::locate_zone("Asia/Tokyo"), tp).get_local_time();
    const auto jst_tp = time_point(tp + 9h);
    const auto days   = std::chrono::floor<std::chrono::days>(jst_tp);
    const auto time   = std::chrono::hh_mm_ss<clock::duration>(jst_tp - days);
    return static_cast<uint32>(time.seconds().count());
}
// minutes after the hour – [​0​, 59]
inline uint32 get_minute(const time_point& tp = now())
{
    // const auto jst_tp = std::chrono::zoned_time(std::chrono::locate_zone("Asia/Tokyo"), tp).get_local_time();
    const auto jst_tp = time_point(tp + 9h);
    const auto days   = std::chrono::floor<std::chrono::days>(jst_tp);
    const auto time   = std::chrono::hh_mm_ss<clock::duration>(jst_tp - days);
    return static_cast<uint32>(time.minutes().count());
}
// hours since midnight – [​0​, 23]
inline uint32 get_hour(const time_point& tp = now())
{
    // const auto jst_tp = std::chrono::zoned_time(std::chrono::locate_zone("Asia/Tokyo"), tp).get_local_time();
    const auto jst_tp = time_point(tp + 9h);
    const auto days   = std::chrono::floor<std::chrono::days>(jst_tp);
    const auto time   = std::chrono::hh_mm_ss<clock::duration>(jst_tp - days);
    return static_cast<uint32>(time.hours().count());
}
// day of the month – [1, 31]
inline uint32 get_monthday(const time_point& tp = now())
{
    // const auto jst_tp = std::chrono::zoned_time(std::chrono::locate_zone("Asia/Tokyo"), tp).get_local_time();
    const auto jst_tp = time_point(tp + 9h);
    const auto ymd    = std::chrono::year_month_day(std::chrono::floor<std::chrono::days>(jst_tp));
    return static_cast<uint32>(ymd.day());
}
// current month – [​1​, 12]
inline uint32 get_month(const time_point& tp = now())
{
    // const auto jst_tp = std::chrono::zoned_time(std::chrono::locate_zone("Asia/Tokyo"), tp).get_local_time();
    const auto jst_tp = time_point(tp + 9h);
    const auto ymd    = std::chrono::year_month_day(std::chrono::floor<std::chrono::days>(jst_tp));
    return static_cast<uint32>(ymd.month());
}
// current year
inline int32 get_year(const time_point& tp = now())
{
    // const auto jst_tp = std::chrono::zoned_time(std::chrono::locate_zone("Asia/Tokyo"), tp).get_local_time();
    const auto jst_tp = time_point(tp + 9h);
    const auto ymd    = std::chrono::year_month_day(std::chrono::floor<std::chrono::days>(jst_tp));
    return static_cast<int32>(ymd.year());
}
// days since Sunday – [​0​, 6]
inline uint32 get_weekday(const time_point& tp = now())
{
    // const auto jst_tp = std::chrono::zoned_time(std::chrono::locate_zone("Asia/Tokyo"), tp).get_local_time();
    const auto jst_tp = time_point(tp + 9h);
    return std::chrono::weekday(std::chrono::floor<std::chrono::days>(jst_tp)).c_encoding();
}
// days since January 1 – [​0​, 365]
inline uint32 get_yearday(const time_point& tp = now())
{
    // const auto jst_tp = std::chrono::zoned_time(std::chrono::locate_zone("Asia/Tokyo"), tp).get_local_time();
    const auto jst_tp = time_point(tp + 9h);
    const auto years  = std::chrono::floor<std::chrono::years>(jst_tp);
    const auto days   = std::chrono::floor<std::chrono::days>(jst_tp - years);
    return static_cast<uint32>(days.count());
}

inline time_point get_next_midnight(const time_point& tp = now())
{
    // const auto jst_tp       = std::chrono::zoned_time(std::chrono::locate_zone("Asia/Tokyo"), tp).get_local_time();
    // const auto jst_midnight = std::chrono::ceil<std::chrono::days>(jst_tp);
    // return std::chrono::zoned_time(std::chrono::locate_zone("Asia/Tokyo"), jst_midnight).get_sys_time();
    return utc::get_next_midnight(tp + 9h) - 9h;
}

} // namespace jst

namespace local
{

// seconds after the minute - [​0​, 60]
inline uint32 get_second(const time_point& tp = now())
{
    // const auto local_tp = std::chrono::zoned_time(std::chrono::current_zone(), tp).get_local_time();
    // const auto days     = std::chrono::floor<std::chrono::days>(local_tp);
    // const auto time     = std::chrono::hh_mm_ss<clock::duration>(local_tp - days);
    // return static_cast<uint32>(time.seconds().count());
    return to_local_tm(tp).tm_sec;
}
// minutes after the hour – [​0​, 59]
inline uint32 get_minute(const time_point& tp = now())
{
    // const auto local_tp = std::chrono::zoned_time(std::chrono::current_zone(), tp).get_local_time();
    // const auto days     = std::chrono::floor<std::chrono::days>(local_tp);
    // const auto time     = std::chrono::hh_mm_ss<clock::duration>(local_tp - days);
    // return static_cast<uint32>(time.minutes().count());
    return to_local_tm(tp).tm_min;
}
// hours since midnight – [​0​, 23]
inline uint32 get_hour(const time_point& tp = now())
{
    // const auto local_tp = std::chrono::zoned_time(std::chrono::current_zone(), tp).get_local_time();
    // const auto days     = std::chrono::floor<std::chrono::days>(local_tp);
    // const auto time     = std::chrono::hh_mm_ss<clock::duration>(local_tp - days);
    // return static_cast<uint32>(time.hours().count());
    return to_local_tm(tp).tm_hour;
}
// day of the month – [1, 31]
inline uint32 get_monthday(const time_point& tp = now())
{
    // const auto local_tp = std::chrono::zoned_time(std::chrono::current_zone(), tp).get_local_time();
    // const auto ymd      = std::chrono::year_month_day(std::chrono::floor<std::chrono::days>(local_tp));
    // return static_cast<uint32>(ymd.day());
    return to_local_tm(tp).tm_mday;
}
// current month – [​1​, 12]
inline uint32 get_month(const time_point& tp = now())
{
    // const auto local_tp = std::chrono::zoned_time(std::chrono::current_zone(), tp).get_local_time();
    // const auto ymd      = std::chrono::year_month_day(std::chrono::floor<std::chrono::days>(local_tp));
    // return static_cast<uint32>(ymd.month());
    return to_local_tm(tp).tm_mon + 1;
}
// current year
inline int32 get_year(const time_point& tp = now())
{
    // const auto local_tp = std::chrono::zoned_time(std::chrono::current_zone(), tp).get_local_time();
    // const auto ymd      = std::chrono::year_month_day(std::chrono::floor<std::chrono::days>(local_tp));
    // return static_cast<int32>(ymd.year());
    return to_local_tm(tp).tm_year + 1900;
}
// days since Sunday – [​0​, 6]
inline uint32 get_weekday(const time_point& tp = now())
{
    // const auto local_tp = std::chrono::zoned_time(std::chrono::current_zone(), tp).get_local_time();
    // return std::chrono::weekday(std::chrono::floor<std::chrono::days>(local_tp)).c_encoding();
    return to_local_tm(tp).tm_wday;
}
// days since January 1 – [​0​, 365]
inline uint32 get_yearday(const time_point& tp = now())
{
    // const auto local_tp = std::chrono::zoned_time(std::chrono::current_zone(), tp).get_local_time();
    // const auto years    = std::chrono::floor<std::chrono::years>(local_tp);
    // const auto days     = std::chrono::floor<std::chrono::days>(local_tp - years);
    // return static_cast<uint32>(days.count());
    return to_local_tm(tp).tm_yday;
}
inline bool is_dst(const time_point& tp = now())
{
    // const auto sys_info = std::chrono::current_zone()->get_info(tp);
    // return sys_info.save != 0min;
    return to_local_tm(tp).tm_isdst > 0;
}

} // namespace local

// Returns a Unix timestamp.
inline uint32 timestamp(const time_point& tp = now())
{
    return static_cast<uint32>(std::chrono::floor<std::chrono::seconds>(tp.time_since_epoch()).count());
}

// Returns the number of Earth seconds since the Vana'diel epoch.
inline uint32 vanadiel_timestamp(const time_point& tp = now())
{
    return static_cast<uint32>(std::chrono::floor<std::chrono::seconds>(tp - vanadiel_epoch).count());
}

// Returns an integer 0-6 representing Monday-Sunday JST.
inline uint8 get_game_weekday(const time_point& tp = now())
{
    return static_cast<uint8>(std::chrono::weekday(jst::get_weekday(tp)).iso_encoding() - 1);
}

// Returns a time point for the start of the next game week (midnight Monday JST aka weekly reset).
inline time_point get_next_game_week(const time_point& tp = now())
{
    // Start with the next midnight and apply N days worth of time to it.
    return jst::get_next_midnight(tp) + std::chrono::days(6 - get_game_weekday(tp));
}

}; // namespace earth_time
