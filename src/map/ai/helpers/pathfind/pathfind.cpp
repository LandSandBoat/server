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

// CPathFind holds the public request API, the per-tick FollowPath loop and the FinishedPath continuation.

#include <map/ai/helpers/pathfind/pathfind.h>

#include <map/ai/helpers/pathfind/entity_path_owner.h>
#include <map/ai/helpers/pathfind/path_builder.h>
#include <map/ai/helpers/pathfind/path_owner.h>
#include <map/ai/helpers/pathfind/pathfind_step.h>

#include <common/logging.h>
#include <common/utils.h>

#include <map/entities/mob_entity.h> // xi::RoamFlag::Worm

#include <algorithm>
#include <memory>

namespace
{

// Cap for AddPoints; patrol paths may exceed it, other callers are truncated with a warning.
constexpr size_t kMaxPathPoints = 50;

} // namespace

CPathFind::CPathFind(CBaseEntity* PTarget)
: CPathFind(std::make_unique<pathfind::EntityPathOwner>(PTarget))
{
}

CPathFind::CPathFind(std::unique_ptr<pathfind::PathOwner> owner)
: owner_(std::move(owner))
, distanceFromPoint_(0.0f)
, pathFlags_(0)
, patrolFlags_(0)
, roamFlags_(xi::RoamFlag::None)
, onPoint_(false)
, currentTurn_(0)
, distanceMoved_(0.0f)
, maxDistance_(0.0f)
{
    Clear();
}

CPathFind::~CPathFind()
{
    Clear();
}

auto CPathFind::navMesh() const -> NavMesh&
{
    return owner_->navMesh();
}

auto CPathFind::PathToImpl(const position_t& point, uint8 pathFlags) -> bool
{
    pathFlags_ = pathFlags;

    // Single-destination PathTo always chunks, since the navmesh poly buffer cannot span a far destination in one query.
    chunked_.begin(point, 0.0f);
    chunkCount_ = 1;

    const bool found = FindPathInternal(owner_->position(), point);
    if (!found)
    {
        Clear();
    }
    return found;
}

auto CPathFind::RoamAround(const position_t& point, float maxRadius, uint8 maxTurns, xi::RoamFlag roamFlags) -> bool
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    Clear();

    roamFlags_ = roamFlags;

    if (FindRandomPath(point, maxRadius, maxTurns, roamFlags))
    {
        return true;
    }

    Clear();
    return false;
}

auto CPathFind::PathTo(const position_t& point, uint8 pathFlags) -> bool
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    // Never overwrite an active scripted path with a non-scripted one.
    if (IsFollowingPath() && (pathFlags_ & PATHFLAG_SCRIPT) && !(pathFlags & PATHFLAG_SCRIPT))
    {
        return false;
    }

    Clear();
    return PathToImpl(point, pathFlags);
}

auto CPathFind::PathInRange(const position_t& point, float range, uint8 pathFlags) -> bool
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    Clear();
    distanceFromPoint_ = range;

    // PathToImpl starts the chunked sequence; override the chunk range so re-chunks stop short.
    const bool found = PathToImpl(point, pathFlags);
    chunked_.setRange(range);

    path_.pruneTailWithin(range);
    return found;
}

auto CPathFind::PathAround(const position_t& point, float distanceFromPoint, uint8 pathFlags) -> bool
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    Clear();
    distanceFromPoint_ = distanceFromPoint;
    return PathToImpl(point, pathFlags);
}

auto CPathFind::PathThrough(std::vector<pathpoint_t>&& points, uint8 pathFlags) -> bool
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    Clear();

    pathFlags_ = pathFlags;

    AddPoints(std::move(points), pathFlags_ & PATHFLAG_REVERSE);

    return true;
}

auto CPathFind::WarpTo(const position_t& point, float maxDistance) -> bool
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    Clear();

    const auto  newPoint = nearPosition(point, maxDistance, static_cast<float>(M_PI));
    position_t& ownerPos = owner_->position();

    ownerPos.x      = newPoint.x;
    ownerPos.y      = newPoint.y;
    ownerPos.z      = newPoint.z;
    ownerPos.moving = 0;

    LookAt(point);
    owner_->markPositionDirty();

    return true;
}

auto CPathFind::ResumePatrol() -> void
{
    if (!(patrolFlags_ & PATHFLAG_PATROL))
    {
        return;
    }

    pathFlags_ = patrolFlags_;
    path_.assign(patrol_);

    // Resume from the patrol waypoint we're currently closest to.
    path_.setCursorToNearest(owner_->position());
}

auto CPathFind::ValidPosition(const position_t& pos) const -> bool
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    constexpr auto maxEntryAge = 10s;

    const auto now   = timer::now();
    const auto begin = validPositionCache_.begin();

    for (std::size_t i = 0; i < validPositionCacheCount_; ++i)
    {
        const auto& entry = validPositionCache_[i];
        if (!isWithinDistance(entry.position, pos, 0.05f) || now - entry.checkedAt >= maxEntryAge)
        {
            continue;
        }

        // Promote the hit to the front so one-shot probes evict each other rather than it.
        std::rotate(begin, begin + i, begin + i + 1);

        return validPositionCache_.front().valid;
    }

    std::rotate(begin, validPositionCache_.end() - 1, validPositionCache_.end());
    validPositionCache_.front() = { pos, now, navMesh().validPosition(pos) };
    validPositionCacheCount_    = std::min(validPositionCacheCount_ + 1, kValidPositionCacheSize);

    return validPositionCache_.front().valid;
}

auto CPathFind::NearValidPosition(const position_t& pos) const -> bool
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    return navMesh().findClosestValidPoint(pos).has_value();
}

auto CPathFind::LimitDistance(float maxLength) -> void
{
    maxDistance_ = maxLength;
}

auto CPathFind::FollowPath(timer::time_point tick) -> void
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    if (!IsFollowingPath())
    {
        return;
    }

    // Paused (e.g. animation lock): hold position and keep facing the battle target.
    if (tick < unpauseTime_)
    {
        if (const position_t* targetPos = owner_->battleTargetPosition())
        {
            LookAt(*targetPos);
        }
        return;
    }

    // Waiting out a waypoint's `wait` duration before advancing to the next one.
    const bool waitingAtPoint = timeAtPoint_ != timer::time_point::min();
    if (waitingAtPoint)
    {
        if (tick < timeAtPoint_)
        {
            return;
        }

        timeAtPoint_ = timer::time_point::min();
        path_.advance();
        owner_->onPathPoint();
        if (path_.consumed())
        {
            // FinishedPath fires onPathComplete only at the true end, not on a re-chunk, roam turn or patrol loop.
            FinishedPath();
        }
        return;
    }

    onPoint_ = false;

    // LimitDistance() caps the distance walked; past it the path completes in place.
    if (maxDistance_ && distanceMoved_ >= maxDistance_)
    {
        Clear();
        onPoint_ = true;
        return;
    }

    // Walk through waypoints already arrived at, stopping at the first one still to step toward.
    pathpoint_t targetPoint{};
    while (!path_.consumed())
    {
        targetPoint = path_.current();

        // Only the final waypoint stops short; corners must be hit precisely or we clip the wall the navmesh inset us from.
        const bool isFinalPoint = path_.atLastIndex();
        if (!AtPoint(targetPoint.position, isFinalPoint))
        {
            break;
        }

        onPoint_ = true;

        if (targetPoint.setRotation)
        {
            owner_->position().rotation = targetPoint.position.rotation;
            owner_->markPositionDirty();
        }

        if (targetPoint.wait != 0s)
        {
            // Stop here until the wait elapses; the next FollowPath() resumes.
            timeAtPoint_ = tick + targetPoint.wait;
            return;
        }

        owner_->onPathPoint();
        path_.advance();
    }

    // Stop short only for the last waypoint so corners are rounded precisely.
    const bool  steppingToFinal = path_.atOrPastLastIndex();
    const float stopShort       = steppingToFinal ? distanceFromPoint_ : 0.0f;
    StepToInternal(targetPoint.position, pathFlags_ & PATHFLAG_RUN, stopShort);

    if (path_.consumed())
    {
        // FinishedPath fires onPathComplete only at the true end, not on a chunk, turn or patrol continuation.
        FinishedPath();
        onPoint_ = true;
    }
}

auto CPathFind::StepTo(const position_t& pos, bool run) -> void
{
    // External callers honor the configured stop-short distance, which is 0 unless a range was set.
    StepToInternal(pos, run, distanceFromPoint_);
}

auto CPathFind::StepToInternal(const position_t& pos, bool run, float stopShort) -> void
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    const bool speedChange = owner_->baseSpeed() != owner_->updateSpeed(run);

    // Worms underground get a synthetic speed (their normal speed is 0).
    const float speed = [&]() -> float
    {
        const auto baseSpeed = owner_->baseSpeed();
        // baseSpeed is an integer compare and isMobEntity() is a dynamic_cast, so test it first.
        if (baseSpeed == 0 && ((roamFlags_ & xi::RoamFlag::Worm) != xi::RoamFlag::None) && owner_->isMobEntity())
        {
            return 20.0f;
        }
        return static_cast<float>(baseSpeed);
    }();

    const float stepDistance = speed / (run ? 50.0f : 40.0f);

    // Kinematics live in pathfind_step so tests can exercise the exact math; stepTowards() also faces the owner.
    position_t& ownerPos = owner_->position();
    distanceMoved_ += pathfind::stepTowards(ownerPos, pos, stepDistance, stopShort);

    ownerPos.moving += speedChange ? 0x28 : 0x35;
    ownerPos.moving %= 0x2000;
    owner_->markPositionDirty();
}

auto CPathFind::FindPathInternal(const position_t& start, const position_t& end) -> bool
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    // Already co-located on the navmesh grid - a query would return a trivial/empty path.
    if (isNear(start, end))
    {
        path_.setPartial(false);
        return false;
    }

    const pathfind::NavPathBuilder builder{ navMesh() };
    auto                           built = builder.findPath(start, end);

    if (!built)
    {
        DebugNavmesh("CPathFind::FindPathInternal Entity (%s - %d) could not find path", owner_->name(), owner_->id());
        path_.clear();

        return false;
    }

    path_.assign(std::move(built->points), built->isPartial);
    return !path_.empty();
}

auto CPathFind::BuildDirectPath(const position_t& end) -> bool
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    // Opt-in single-waypoint path straight to the destination, ignoring the navmesh and possibly clipping geometry.
    path_.assign({ pathpoint_t{ end, 0s, false } }, false);
    return true;
}

auto CPathFind::FindRandomPath(const position_t& start, float maxRadius, uint8 maxTurns, xi::RoamFlag roamFlags) -> bool
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    const pathfind::NavPathBuilder builder{ navMesh() };

    auto turnPoints = builder.findRoamTurnPoints(start, maxRadius, maxTurns);
    if (!turnPoints)
    {
        // Hard navmesh failure - bail rather than partially populate the turn list.
        return false;
    }
    turnPoints_ = std::move(*turnPoints);

    // Path to the first turn only; later turns chain in FinishedPath().
    // Turns are sampled around the anchor, but the walk starts from wherever the owner is.
    if (!turnPoints_.empty())
    {
        FindPathInternal(owner_->position(), turnPoints_[0]);
    }

    return !path_.empty();
}

auto CPathFind::LookAt(const position_t& point) -> void
{
    position_t& ownerPos = owner_->position();

    // Avoid unpredictable rotation when too close.
    if (!isWithinDistance(ownerPos, point, 0.1f, true))
    {
        ownerPos.rotation = worldAngle(ownerPos, point);
        owner_->markPositionDirty();
    }
}

auto CPathFind::OnPoint() const -> bool
{
    return onPoint_;
}

auto CPathFind::IsFollowingPath() const -> bool
{
    return !path_.empty();
}

auto CPathFind::IsFollowingScriptedPath() const -> bool
{
    return IsFollowingPath() && (pathFlags_ & PATHFLAG_SCRIPT);
}

auto CPathFind::IsPatrolling() const -> bool
{
    return (patrolFlags_ & PATHFLAG_PATROL) != 0;
}

auto CPathFind::AtPoint(const position_t& pos, bool isFinalPoint) const -> bool
{
    // Corners are reached precisely (0.1y); only the final point uses the requested stop-short plus slack.
    const float threshold = (isFinalPoint && distanceFromPoint_ != 0) ? distanceFromPoint_ + 0.2f : 0.1f;
    return isWithinDistance(owner_->position(), pos, threshold);
}

auto CPathFind::InWater() const -> bool
{
    return owner_->inWater();
}

auto CPathFind::GetDestination() const -> const position_t&
{
    // Chunked paths return the eventual destination, not the current chunk's end, so callers comparing against the goal stay correct.
    if (chunked_.active())
    {
        return chunked_.target();
    }
    return path_.destination();
}

auto CPathFind::IsPathDirect(float ratio) const -> bool
{
    // Partial (chunked) paths reach only the current chunk's end, never the eventual destination.
    if (path_.partial())
    {
        return false;
    }
    return path_.isWithinRatio(owner_->position(), ratio);
}

auto CPathFind::ChunkCount() const -> int
{
    // Navmesh legs taken by this PathTo journey (1 = single query, >1 = chunked).
    return chunkCount_;
}

auto CPathFind::Clear() -> void
{
    distanceFromPoint_ = 0;
    pathFlags_         = 0;
    roamFlags_         = xi::RoamFlag::None;

    path_.clear();

    timeAtPoint_ = timer::time_point::min();
    unpauseTime_ = timer::time_point::min();

    maxDistance_   = 0;
    distanceMoved_ = 0;

    onPoint_ = true;

    currentTurn_ = 0;
    turnPoints_.clear();

    // Drop any in-flight chunked sequence; the next PathTo / PathInRange starts fresh.
    chunked_.clear();
    chunkCount_ = 0;
}

auto CPathFind::Pause(timer::duration pauseDuration) -> void
{
    // Zero pauses indefinitely (until Unpause()); otherwise pause until now + duration.
    if (pauseDuration == timer::duration::zero())
    {
        unpauseTime_ = timer::time_point::max();
    }
    else
    {
        unpauseTime_ = timer::now() + pauseDuration;
    }
}

auto CPathFind::Unpause() -> void
{
    unpauseTime_ = timer::time_point::min();
}

auto CPathFind::AddPoints(std::vector<pathpoint_t>&& points, bool reverse) -> void
{
    // Patrol paths may legitimately exceed kMaxPathPoints, so cap only other callers.
    const bool isPatrol = (pathFlags_ & PATHFLAG_PATROL) != 0;
    if (points.size() > kMaxPathPoints && !isPatrol)
    {
        ShowWarning("CPathFind::AddPoints Given too many points (%d). Limiting to max (%d)", points.size(), kMaxPathPoints);
        points.resize(kMaxPathPoints);
    }

    if (reverse)
    {
        std::reverse(points.begin(), points.end());
    }

    path_.assign(std::move(points));

    if (isPatrol)
    {
        patrol_      = path_.points();
        patrolFlags_ = pathFlags_;
    }
    else
    {
        patrol_.clear();
        patrolFlags_ = 0;
    }
}

auto CPathFind::FinishedPath() -> void
{
    // A partial chunk silently requests the next one and must not fire onPathComplete, so chunk boundaries stay invisible to scripts.
    if (chunked_.active() && path_.partial() && TryRequestNextChunk())
    {
        return;
    }

    // A genuine completion fires the script hook first, since its handler may set up the next path.
    owner_->onPathComplete();

    ++currentTurn_;

    // Random-roam paths chain through turnPoints_ - set up the next leg if there is one.
    if (currentTurn_ < turnPoints_.size())
    {
        const position_t& nextTurn = turnPoints_[currentTurn_];
        if (!FindPathInternal(owner_->position(), nextTurn))
        {
            Clear();
        }
        return;
    }

    // Patrol paths loop forever while still roaming.
    if (IsPatrolling() && owner_->isRoaming())
    {
        path_.restart();
        currentTurn_ = 0;
        return;
    }

    Clear();
}

auto CPathFind::TryRequestNextChunk() -> bool
{
    TracyZoneScoped;
    TracyZoneString(owner_->name());

    const float distanceToTarget = distance(owner_->position(), chunked_.target());

    switch (chunked_.evaluate(distanceToTarget))
    {
        case pathfind::ChunkedPath::Step::Continue:
            break;
        case pathfind::ChunkedPath::Step::Stalled:
            DebugNavmesh("CPathFind::TryRequestNextChunk Entity (%s - %d) chunked path stalled, aborting", owner_->name(), owner_->id());
            return false;
        default: // Inactive / Arrived
            return false;
    }

    if (!FindPathInternal(owner_->position(), chunked_.target()))
    {
        return false;
    }

    ++chunkCount_;

    // Re-apply PathInRange's range pruning so chunked callers still stop short of the destination.
    if (chunked_.range() > 0.0f)
    {
        distanceFromPoint_ = chunked_.range();
        path_.pruneTailWithin(chunked_.range());
    }

    return true;
}
