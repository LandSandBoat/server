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

#include "weather_container.h"

#include "enums/weather.h"

auto WeatherContainer::current() const -> Weather
{
    return current_;
}

auto WeatherContainer::changeTime() const -> uint32
{
    return changeTime_;
}

void WeatherContainer::set(Weather weather, uint32 changeTime)
{
    current_    = weather;
    changeTime_ = changeTime;
}

auto WeatherContainer::isStatic() const -> bool
{
    return probabilities_.empty() || probabilities_.size() == 1;
}

void WeatherContainer::addEntry(uint16 day, ZoneWeather entry)
{
    probabilities_.insert(std::make_pair(day, entry));
}

auto WeatherContainer::entryForDay(uint16 day) const -> ZoneWeather
{
    ZoneWeather entry(Weather::None, Weather::None, Weather::None);
    for (const auto& [entryDay, probabilities] : probabilities_)
    {
        if (entryDay > day)
        {
            break;
        }
        entry = probabilities;
    }
    return entry;
}
