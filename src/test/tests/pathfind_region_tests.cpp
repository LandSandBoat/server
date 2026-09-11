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

#include "map/ai/helpers/pathfind/path_owner.h"
#include "map/ai/helpers/pathfind/pathfind.h"
#include "map/navmesh/navmesh.h"
#include "map/roam_region.h"

#include "common/utils.h"

#include <catch2/catch_test_macros.hpp>

#include <memory>
#include <string>

namespace
{

// flat ground everywhere: every path is the straight line to its end
class FlatNavMesh final : public NavMesh
{
public:
    auto findPath(const position_t&, const position_t& end) -> Maybe<PathResult> override
    {
        return PathResult{ { pathpoint_t{ end, 0s, false } }, false };
    }

    auto findRandomPosition(const position_t& start, float) const -> Maybe<position_t> override
    {
        return start;
    }

    auto validPosition(const position_t&) const -> bool override
    {
        return true;
    }

    auto findClosestValidPoint(const position_t& position) const -> Maybe<position_t> override
    {
        return position;
    }

    auto findFurthestValidPoint(const position_t&, const position_t& endPosition) const -> Maybe<position_t> override
    {
        return endPosition;
    }

    auto snapToValidPosition(position_t&) const -> void override
    {
    }

    auto moveAlongSurface(const position_t&, const position_t& end, position_t& result) const -> bool override
    {
        result = end;
        return true;
    }
};

class StubOwner final : public pathfind::PathOwner
{
public:
    StubOwner(position_t position, NavMesh& navMesh)
    : position_(position)
    , navMesh_(navMesh)
    {
    }

    auto position() -> position_t& override
    {
        return position_;
    }

    auto position() const -> const position_t& override
    {
        return position_;
    }

    auto navMesh() -> NavMesh& override
    {
        return navMesh_;
    }

    auto markPositionDirty() -> void override
    {
    }

    auto baseSpeed() const -> uint8 override
    {
        return 40;
    }

    auto updateSpeed(bool) -> uint8 override
    {
        return 40;
    }

    auto isMobEntity() const -> bool override
    {
        return true;
    }

    auto isRoaming() const -> bool override
    {
        return true;
    }

    auto inWater() const -> bool override
    {
        return false;
    }

    auto battleTargetPosition() const -> const position_t* override
    {
        return nullptr;
    }

    auto onPathPoint() -> void override
    {
    }

    auto onPathComplete() -> void override
    {
    }

    auto name() const -> const std::string& override
    {
        return name_;
    }

    auto id() const -> uint32 override
    {
        return 1;
    }

private:
    position_t  position_;
    NavMesh&    navMesh_;
    std::string name_{ "stub" };
};

auto squareWithHole() -> RoamRegion
{
    const RoamRegion::Ring outer{ { 0.0f, -10.0f, 0.0f }, { 100.0f, -10.0f, 0.0f }, { 100.0f, -10.0f, 100.0f }, { 0.0f, -10.0f, 100.0f } };
    const RoamRegion::Ring hole{ { 40.0f, -10.0f, 40.0f }, { 60.0f, -10.0f, 40.0f }, { 60.0f, -10.0f, 60.0f }, { 40.0f, -10.0f, 60.0f } };

    return RoamRegion(outer, { hole });
}

// every yalm of the straight leg from `from` to `to` lies in the region
auto legStaysInside(const RoamRegion& region, const position_t& from, const position_t& to) -> bool
{
    const float length = distance(from, to, true);
    for (float along = 0.0f; along <= length; along += 0.5f)
    {
        const float t = length > 0.0f ? along / length : 0.0f;
        if (!region.contains(from.x + (to.x - from.x) * t, from.z + (to.z - from.z) * t))
        {
            return false;
        }
    }

    return region.contains(to.x, to.z);
}

} // namespace

TEST_CASE("pathfind: a roam leg never crosses out of its region", "[pathfind][region]")
{
    const auto  region = squareWithHole();
    FlatNavMesh navMesh;

    // hard against the hole, where a drawn step is most likely to want to cross it
    for (const auto& start : { position_t{ 39.0f, -10.0f, 50.0f, 0, 0 }, position_t{ 50.0f, -10.0f, 39.0f, 0, 0 }, position_t{ 2.0f, -10.0f, 2.0f, 0, 0 } })
    {
        for (int i = 0; i < 300; ++i)
        {
            auto      owner    = std::make_unique<StubOwner>(start, navMesh);
            auto*     ownerPtr = owner.get();
            CPathFind pathFind(std::move(owner));

            if (!pathFind.RoamAround(start, 30.0f, 1, 1, xi::RoamFlag::None, &region))
            {
                continue;
            }

            REQUIRE(legStaysInside(region, ownerPtr->position(), pathFind.GetDestination()));
        }
    }
}

TEST_CASE("pathfind: a region mob that cannot sample a leg walks back onto its region", "[pathfind][region]")
{
    const auto  region = squareWithHole();
    FlatNavMesh navMesh;

    // outside the outline every sample fails
    const position_t stranded{ -10.0f, -10.0f, 50.0f, 0, 0 };
    auto             owner    = std::make_unique<StubOwner>(stranded, navMesh);
    auto*            ownerPtr = owner.get();
    CPathFind        pathFind(std::move(owner));

    // the failed sample turns into a walk to a point inside, not cut at the outline
    REQUIRE(pathFind.RoamAround(stranded, 10.0f, 1, 1, xi::RoamFlag::None, &region));
    const auto destination = pathFind.GetDestination();
    CHECK(region.contains(destination.x, destination.z));
    CHECK_FALSE(region.contains(ownerPtr->position().x, ownerPtr->position().z));
}
