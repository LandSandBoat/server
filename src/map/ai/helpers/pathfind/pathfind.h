/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include <common/mmo.h>
#include <common/timer.h>

#include <data/enums/roam_flag.h>

#include <map/ai/helpers/pathfind/chunked_path.h>
#include <map/ai/helpers/pathfind/path.h>
#include <map/ai/helpers/pathfind/pathfind_types.h>

#include <array>
#include <cstddef>
#include <memory>
#include <vector>

class CBaseEntity;
class NavMesh;

namespace pathfind
{

class PathOwner;

}

class CPathFind
{
public:
    // Production: wraps the entity in an owned EntityPathOwner.
    explicit CPathFind(CBaseEntity* PTarget);

    // General/tests: take ownership of an injected PathOwner.
    explicit CPathFind(std::unique_ptr<pathfind::PathOwner> owner);

    ~CPathFind();

    // Walk to a random point around the given point.
    auto RoamAround(const position_t& point, float maxRadius, uint8 maxTurns, xi::RoamFlag roamFlags = xi::RoamFlag::None) -> bool;

    // Find and walk to the given point.
    auto PathTo(const position_t& point, uint8 pathFlags = 0) -> bool;

    // Walk toward the point until within range.
    auto PathInRange(const position_t& point, float range, uint8 pathFlags = 0) -> bool;

    // Walk to somewhere around the point.
    auto PathAround(const position_t& point, float distanceFromPoint, uint8 pathFlags = 0) -> bool;

    // Walk through the given points; no new points are generated.
    auto PathThrough(std::vector<pathpoint_t>&& points, uint8 pathFlags = 0) -> bool;

    // Instantly move the entity to `point`, skipping the navmesh - the caller must ensure it is valid.
    auto WarpTo(const position_t& point, float maxDistance = 2.0f) -> bool;

    auto ResumePatrol() -> void;

    // Move the mob toward the next point.
    auto FollowPath(timer::time_point tick) -> void;

    // True if the entity is on a waypoint.
    auto OnPoint() const -> bool;

    // Stop pathfinding after this much distance has been walked.
    auto LimitDistance(float maxDistance) -> void;

    // Take one step toward position.
    auto StepTo(const position_t& pos, bool run = false) -> void;

    // True while the mob is following a path.
    auto IsFollowingPath() const -> bool;
    auto IsFollowingScriptedPath() const -> bool;
    auto IsPatrolling() const -> bool;

    // Face the given point.
    auto LookAt(const position_t& point) -> void;

    // Clear the current path.
    auto Clear() -> void;

    // Pause pathing for the given duration, or indefinitely when zero; the entity holds position and keeps facing its target.
    auto Pause(timer::duration pauseDuration = timer::duration::zero()) -> void;

    // Resume pathing immediately if currently paused.
    auto Unpause() -> void;

    auto ValidPosition(const position_t& pos) const -> bool;

    auto NearValidPosition(const position_t& pos) const -> bool;

    // True if in water.
    auto InWater() const -> bool;

    // Final destination of the current path.
    auto GetDestination() const -> const position_t&;

    // True when the path is no longer than `ratio` x the straight-line distance, and false for no path or a partial one.
    auto IsPathDirect(float ratio = 2.0f) const -> bool;

    // Navmesh legs taken by the current PathTo journey (1 = single query, >1 = chunked).
    auto ChunkCount() const -> int;

private:
    // The owner's zone navmesh.
    auto navMesh() const -> NavMesh&;

    // Core of PathTo; does not Clear() and does not guard against scripted paths.
    auto PathToImpl(const position_t& point, uint8 pathFlags) -> bool;

    auto FindPathInternal(const position_t& start, const position_t& end) -> bool;

    auto BuildDirectPath(const position_t& end) -> bool;

    // Find a random path around the given point.
    auto FindRandomPath(const position_t& start, float maxRadius, uint8 maxTurns, xi::RoamFlag roamFlags) -> bool;

    // Core of StepTo, settling `stopShort` yalms short of `pos`.
    auto StepToInternal(const position_t& pos, bool run, float stopShort) -> void;

    auto AddPoints(std::vector<pathpoint_t>&& points, bool reverse = false) -> void;

    auto FinishedPath() -> void;

    // Re-request the next chunk after a partial path; false once we have arrived or pathing failed.
    auto TryRequestNextChunk() -> bool;

    // True when the owner is within the arrival threshold of `pos`.
    auto AtPoint(const position_t& pos, bool isFinalPoint = true) const -> bool;

    // The moved entity, owned here so the abstraction stays inside the pathfind module.
    std::unique_ptr<pathfind::PathOwner> owner_;

    // The active path being walked (waypoints + cursor + geometry).
    pathfind::Path path_;

    // Re-requests the next leg of a partial path toward the eventual destination.
    pathfind::ChunkedPath chunked_;

    std::vector<pathpoint_t> patrol_;
    std::vector<position_t>  turnPoints_;
    float                    distanceFromPoint_;

    uint8        pathFlags_;
    uint8        patrolFlags_;
    xi::RoamFlag roamFlags_;
    bool         onPoint_;

    timer::time_point timeAtPoint_;

    // Path is held while tick < unpauseTime_; time_point::min() means not paused.
    timer::time_point unpauseTime_{ timer::time_point::min() };

    uint8 currentTurn_;

    float distanceMoved_;

    struct ValidPositionEntry
    {
        position_t        position{};
        timer::time_point checkedAt{ timer::time_point::min() };
        bool              valid{ false };
    };

    // Small enough that a linear scan beats hashing, and that repeated own-position queries
    // survive the one-shot candidate probes that share this cache.
    static constexpr std::size_t kValidPositionCacheSize = 8;

    // Most recently used first; the max age bounds staleness after a navmesh reload we cannot see.
    mutable std::array<ValidPositionEntry, kValidPositionCacheSize> validPositionCache_{};
    mutable std::size_t                                             validPositionCacheCount_{ 0 };

    float maxDistance_;

    // Legs taken by the current PathTo journey (1 = single query, >1 = chunked).
    int chunkCount_{ 0 };
};
