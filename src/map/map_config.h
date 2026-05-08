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

#include <common/ipp.h>

struct MapConfig final
{
    IPP  ipp{};
    bool inCI{ false };              // Is the process running in CI (GitHub runners, etc.)
    bool isTestServer{ false };      // Disables watchdog and certain recurring tasks when ticks are externally managed.
    bool lazyZones{ false };         // Load zones when first accessed
    bool controlledWeather{ false }; // Disables automated weather
    bool rebuildNavmeshes{ false };  // Force rebuild all navmeshes from ximesh on startup
};

static_assert(std::is_standard_layout_v<MapConfig>, "MapConfig must be standard-layout");
