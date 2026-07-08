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

#include <common/cbasetypes.h>

#include <map>

enum class Weather : uint16_t;

struct ZoneWeather
{
    Weather normal;
    Weather common;
    Weather rare;

    ZoneWeather(Weather normal, Weather common, Weather rare)
    : normal(normal)
    , common(common)
    , rare(rare)
    {
    }
};

//
// Owns a zone's weather state: the active weather, the timestamp it last
// changed, and the per-day probability table loaded from the database.
//
class WeatherContainer
{
public:
    auto current() const -> Weather;
    auto changeTime() const -> uint32;
    void set(Weather weather, uint32 changeTime);

    // A zone with 0 or 1 probability entries never cycles its weather.
    auto isStatic() const -> bool;

    // Build the probability table (called while loading the zone).
    void addEntry(uint16 day, ZoneWeather entry);

    // The probabilities in effect for the given day-of-cycle. Returns a zeroed
    // entry (which reads as Weather::None) when no entry covers the day.
    auto entryForDay(uint16 day) const -> ZoneWeather;

private:
    Weather                       current_{}; // defaults to Weather::None (0)
    uint32                        changeTime_{};
    std::map<uint16, ZoneWeather> probabilities_; // keyed by day-of-cycle
};
