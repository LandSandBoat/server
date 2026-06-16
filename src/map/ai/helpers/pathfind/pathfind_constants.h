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

// Cap on point lists passed to AddPoints (PathThrough). Patrol paths may exceed it (long scripted
// routes); other callers get truncated with a warning.
constexpr size_t kMaxPathPoints = 50;

// Re-path once the target drifts this far from the current destination. Must be under the minimum
// melee range (GetMeleeRange base = 2.0f) so a player can't stand just out of reach without
// triggering a re-path.
constexpr float kPathDestinationDriftThreshold = 1.0f;

// Distance walked toward spawn per roam-home tick before re-evaluating.
constexpr float kRoamHomeStepDistance = 10.0f;
