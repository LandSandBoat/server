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
#include <common/mmo.h>

namespace pathfind
{

// Tracks the eventual destination across the partial chunks findPath() returns for far targets.
// Aborts when consecutive chunks make no progress, rather than circling an obstacle forever.
class ChunkedPath
{
public:
    enum class Step
    {
        Inactive, // no chunked sequence in flight
        Arrived,  // within arrival distance of the target - stop
        Stalled,  // too many consecutive non-progressing chunks - give up
        Continue, // request another chunk toward the target
    };

    auto clear() -> void;

    // Begin a chunked sequence toward `target`; `range` is the stop-short distance, or 0 for a plain PathTo.
    auto begin(const position_t& target, float range) -> void;

    // Override the stop-short range after begin() (PathInRange applies it post-PathToImpl).
    auto setRange(float range) -> void;

    auto active() const -> bool;
    auto range() const -> float;
    auto target() const -> const position_t&;

    // Decide the next Step from the distance to the target, owning the arrival test and the stall abort.
    auto evaluate(float distanceToTarget) -> Step;

private:
    bool       active_{ false };
    position_t target_{};
    float      range_{ 0.0f };

    // Distance to the target when the previous chunk began, used to detect chunks that make no progress.
    float lastDistance_{ 0.0f };

    // Consecutive chunks that didn't reduce distance to target.
    uint8 stallCount_{ 0 };

    // Abort after this many consecutive non-progressing chunks.
    static constexpr uint8 kMaxStalls = 3;
};

} // namespace pathfind
