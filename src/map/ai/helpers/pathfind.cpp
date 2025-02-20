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

#include "pathfind.h"

#include "ai/ai_container.h"
#include "common/utils.h"
#include "entities/baseentity.h"
#include "entities/mobentity.h"
#include "lua/luautils.h"
#include "mob_modifier.h"
#include "status_effect_container.h"
#include "zone.h"

#include <cfloat>

namespace
{
    bool arePositionsClose(const position_t& a, const position_t& b)
    {
        return distance(a, b) < 1.0f;
    }
} // namespace

CPathFind::CPathFind(CBaseEntity* PTarget)
: m_POwner(PTarget)
, m_distanceFromPoint(0.0f)
, m_pathFlags(0)
, m_patrolFlags(0)
, m_roamFlags(0)
, m_onPoint(false)
, m_currentPoint(0)
, m_currentTurn(0)
, m_distanceMoved(0.0f)
, m_maxDistance(0.0f)
, m_carefulPathing(false)
{
    m_originalPoint.x        = 0.f;
    m_originalPoint.y        = 0.f;
    m_originalPoint.z        = 0.f;
    m_originalPoint.moving   = 0;
    m_originalPoint.rotation = 0;

    Clear();
}

CPathFind::~CPathFind()
{
    m_POwner = nullptr;
    Clear();
}

bool CPathFind::RoamAround(const position_t& point, float maxRadius, uint8 maxTurns, uint16 roamFlags)
{
    TracyZoneScoped;
    Clear();

    m_roamFlags = roamFlags;

    if (isNavMeshEnabled())
    {
        if (FindRandomPath(point, maxRadius, maxTurns, roamFlags))
        {
            return true;
        }
        else
        {
            Clear();
            return false;
        }
    }
    else
    {
        // no point worm roaming cause it'll move one inch
        if (m_roamFlags & ROAMFLAG_WORM)
        {
            Clear();
            return false;
        }

        m_points.emplace_back(pathpoint_t{ { point.x - 1 + rand() % 2, point.y, point.z - 1 + rand() % 2, 0, 0 }, 0, false });
    }

    return true;
}

bool CPathFind::PathTo(const position_t& point, uint8 pathFlags, bool clear)
{
    TracyZoneScoped;
    // don't follow a new path if the current path has script flag and new path doesn't
    if (IsFollowingPath() && (m_pathFlags & PATHFLAG_SCRIPT) && !(pathFlags & PATHFLAG_SCRIPT))
    {
        return false;
    }

    if (clear)
    {
        Clear();
    }

    m_pathFlags = pathFlags;

    if (isNavMeshEnabled())
    {
        bool result = false;

        if (m_pathFlags & PATHFLAG_WALLHACK)
        {
            result = FindClosestPath(m_POwner->loc.p, point);
        }
        else
        {
            result = FindPath(m_POwner->loc.p, point);
        }

        if (!result)
        {
            Clear();
        }

        return result;
    }
    else
    {
        if (clear)
        {
            Clear();
        }

        m_points.emplace_back(pathpoint_t{ point, 0, false });
    }

    return true;
}

bool CPathFind::PathInRange(const position_t& point, float range, uint8 pathFlags /*= 0*/, bool clear /*= true*/)
{
    TracyZoneScoped;
    if (clear)
    {
        Clear();
    }

    m_distanceFromPoint = range;

    bool result = PathTo(point, pathFlags, false);

    PrunePathWithin(range);
    return result;
}

bool CPathFind::PathAround(const position_t& point, float distanceFromPoint, uint8 pathFlags)
{
    TracyZoneScoped;
    Clear();

    // save for sliding logic
    m_originalPoint     = point;
    m_distanceFromPoint = distanceFromPoint;

    // Don't clear path so
    // original point / distance are kept
    return PathTo(point, pathFlags, false);
}

bool CPathFind::PathThrough(std::vector<pathpoint_t>&& points, uint8 pathFlags)
{
    TracyZoneScoped;
    Clear();

    m_pathFlags = pathFlags;

    AddPoints(std::move(points), m_pathFlags & PATHFLAG_REVERSE);

    return true;
}

bool CPathFind::WarpTo(const position_t& point, float maxDistance)
{
    TracyZoneScoped;
    Clear();

    position_t newPoint = nearPosition(point, maxDistance, (float)M_PI);

    m_POwner->loc.p.x      = newPoint.x;
    m_POwner->loc.p.y      = newPoint.y;
    m_POwner->loc.p.z      = newPoint.z;
    m_POwner->loc.p.moving = 0;

    LookAt(point);
    m_POwner->updatemask |= UPDATE_POS;

    return true;
}

void CPathFind::ResumePatrol()
{
    if (m_patrolFlags & PATHFLAG_PATROL)
    {
        m_pathFlags        = m_patrolFlags;
        m_points           = m_patrol;
        m_currentPoint     = 0;
        float closestPoint = FLT_MAX;
        for (size_t i = 0; i < m_points.size(); ++i)
        {
            const float distanceSq = distanceSquared(m_POwner->loc.p, m_points[i].position);
            if (distanceSq < closestPoint)
            {
                m_currentPoint = (int16)i;
                closestPoint   = distanceSq;
            }
        }
    }
}

bool CPathFind::isNavMeshEnabled()
{
    return m_POwner->loc.zone && m_POwner->loc.zone->m_navMesh != nullptr;
}

bool CPathFind::ValidPosition(const position_t& pos)
{
    TracyZoneScoped;
    if (isNavMeshEnabled())
    {
        return m_POwner->loc.zone->m_navMesh->validPosition(pos);
    }
    else
    {
        return true;
    }
}

void CPathFind::LimitDistance(float maxLength)
{
    m_maxDistance = maxLength;
}

void CPathFind::PrunePathWithin(float within)
{
    TracyZoneScoped;

    if (!IsFollowingPath())
    {
        return;
    }

    position_t targetPoint = m_points.back().position;

    while (m_points.size() > 1)
    {
        position_t secondLastPoint = m_points[m_points.size() - 2].position;

        if (distance(targetPoint, secondLastPoint) > within)
        {
            break;
        }
        m_points.erase(m_points.end() - 2);
    }
}

void CPathFind::FollowPath(time_point tick)
{
    TracyZoneScoped;
    if (!IsFollowingPath())
    {
        return;
    }

    if (m_timeAtPoint.time_since_epoch().count() != 0)
    {
        // Continue to wait until full wait time has elapsed
        if (tick >= m_timeAtPoint)
        {
            m_timeAtPoint = {};
            ++m_currentPoint;
            luautils::OnPathPoint(m_POwner);
            if (m_currentPoint >= (int16)m_points.size())
            {
                luautils::OnPathComplete(m_POwner);
                FinishedPath();
            }
        }
        return;
    }

    m_onPoint = false;

    pathpoint_t targetPoint = m_points[m_currentPoint];

    if (isNavMeshEnabled() && m_carefulPathing)
    {
        m_POwner->loc.zone->m_navMesh->snapToValidPosition(m_POwner->loc.p);
    }

    if (m_maxDistance && m_distanceMoved >= m_maxDistance)
    {
        // if I have a max distance, check to stop me
        Clear();
        m_onPoint = true;
        return;
    }

    // Iterate over points in the current path and find the first point
    // that we haven't successfully arrived at already.
    while (m_currentPoint < (int16)m_points.size())
    {
        targetPoint = m_points[m_currentPoint];

        if (AtPoint(targetPoint.position))
        {
            m_onPoint = true;
            if (targetPoint.setRotation)
            {
                m_POwner->loc.p.rotation = targetPoint.position.rotation;
                m_POwner->updatemask |= UPDATE_POS;
            }
            if (targetPoint.wait != 0 && m_timeAtPoint.time_since_epoch().count() == 0)
            {
                m_timeAtPoint = tick + std::chrono::milliseconds(targetPoint.wait);
                return;
            }

            luautils::OnPathPoint(m_POwner);
            m_currentPoint++;
        }
        else
        {
            break;
        }
    }

    StepTo(targetPoint.position, m_pathFlags & PATHFLAG_RUN);

    if (m_currentPoint >= (int16)m_points.size())
    {
        luautils::OnPathComplete(m_POwner);
        FinishedPath();
        m_onPoint = true;
    }
}

void CPathFind::StepTo(const position_t& pos, bool run)
{
    TracyZoneScoped;
    bool  speedChange = m_POwner->GetSpeed() != m_POwner->UpdateSpeed(run);
    float speed       = m_POwner->GetSpeed();

    if (const auto* PMobEntity = dynamic_cast<CMobEntity*>(m_POwner))
    {
        if (PMobEntity->GetSpeed() == 0 && (m_roamFlags & ROAMFLAG_WORM))
        {
            speed = 20;
        }
    }

    float stepDistance = speed / (run ? 50 : 40);
    float distanceTo   = distance(m_POwner->loc.p, pos);
    float diff_y       = pos.y - m_POwner->loc.p.y;

    // face point mob is moving towards
    LookAt(pos);

    if (distanceTo <= m_distanceFromPoint + stepDistance)
    {
        m_distanceMoved += distanceTo - m_distanceFromPoint;

        if (m_distanceFromPoint == 0)
        {
            m_POwner->loc.p.x = pos.x;
            m_POwner->loc.p.y = pos.y;
            m_POwner->loc.p.z = pos.z;
        }
        else
        {
            float radians = (1 - (float)m_POwner->loc.p.rotation / 256) * 2 * (float)M_PI;

            m_POwner->loc.p.x += cosf(radians) * (distanceTo - m_distanceFromPoint);
            m_POwner->loc.p.z += sinf(radians) * (distanceTo - m_distanceFromPoint);
            if (abs(diff_y) > .5f)
            {
                // Don't step too far vertically by simply utilizing the slope
                float new_y = m_POwner->loc.p.y + stepDistance * (pos.y - m_POwner->loc.p.y) / distance(m_POwner->loc.p, pos, true);
                float min_y = (pos.y + m_POwner->loc.p.y - abs(pos.y - m_POwner->loc.p.y)) / 2;
                float max_y = (pos.y + m_POwner->loc.p.y + abs(pos.y - m_POwner->loc.p.y)) / 2;
                // clamp new_y between start and end vertical position
                new_y             = new_y < min_y ? min_y : new_y;
                m_POwner->loc.p.y = new_y > max_y ? max_y : new_y;
            }
            else
            {
                m_POwner->loc.p.y = pos.y;
            }
        }
    }
    else
    {
        m_distanceMoved += stepDistance;
        // take a step towards target point
        float radians = (1 - (float)m_POwner->loc.p.rotation / 256) * 2 * (float)M_PI;

        m_POwner->loc.p.x += cosf(radians) * stepDistance;
        m_POwner->loc.p.z += sinf(radians) * stepDistance;
        if (abs(diff_y) > .5f)
        {
            // Don't step too far vertically by simply utilizing the slope
            float new_y = m_POwner->loc.p.y + stepDistance * (pos.y - m_POwner->loc.p.y) / distance(m_POwner->loc.p, pos, true);
            float min_y = (pos.y + m_POwner->loc.p.y - abs(pos.y - m_POwner->loc.p.y)) / 2;
            float max_y = (pos.y + m_POwner->loc.p.y + abs(pos.y - m_POwner->loc.p.y)) / 2;
            // clamp new_y between start and end vertical position
            new_y             = new_y < min_y ? min_y : new_y;
            m_POwner->loc.p.y = new_y > max_y ? max_y : new_y;
        }
        else
        {
            m_POwner->loc.p.y = pos.y;
        }
    }

    m_POwner->loc.p.moving += speedChange ? 0x28 : 0x35;

    m_POwner->loc.p.moving %= 0x2000;

    m_POwner->updatemask |= UPDATE_POS;
}

bool CPathFind::FindPath(const position_t& start, const position_t& end)
{
    TracyZoneScoped;

    if (arePositionsClose(start, end))
    {
        return false;
    }

    if (!isNavMeshEnabled())
    {
        return false;
    }

    m_points       = m_POwner->loc.zone->m_navMesh->findPath(start, end);
    m_currentPoint = 0;

    if (m_points.empty())
    {
        DebugNavmesh("CPathFind::FindPath Entity (%s - %d) could not find path", m_POwner->getName(), m_POwner->id);
        return false;
    }

    return true;
}

bool CPathFind::FindRandomPath(const position_t& start, float maxRadius, uint8 maxTurns, uint16 roamFlags)
{
    TracyZoneScoped;

    if (!isNavMeshEnabled())
    {
        return false;
    }

    auto m_turnLength = static_cast<uint8_t>(xirand::GetRandomNumber<uint32>(maxTurns) + 1);

    // Seemingly arbitrary value to pass for maxRadius, all values seem to give similar results, likely due to navmesh polygons being too dense?
    float      maxRadiusForPolyQuery = maxRadius / 10.f;
    position_t startPosition         = start;

    // find end points for turns, iterate potentially twice as many times to account for erroneous turnPoints
    for (int i = 0; i < m_turnLength * 2; i++)
    {
        // look for new turnPoint. findRandomPosition doesn't guarantee the new point is within the radius
        auto status = m_POwner->loc.zone->m_navMesh->findRandomPosition(startPosition, maxRadiusForPolyQuery);

        // couldn't find one point so just break out
        if (status.first != 0)
        {
            return false;
        }

        // only add the roam point if it's _actually_ within range of the spawn point...
        if (isWithinDistance(startPosition, status.second, maxRadius, true))
        {
            m_turnPoints.emplace_back(status.second);
        }
        // else
        // {
        //     ShowDebug("CPathFind::FindRandomPath (%s - %d) random point too far: sq distance (%f)", m_POwner->GetName(), m_POwner->id, distSq);
        // }

        if (m_turnPoints.size() >= m_turnLength)
        {
            break;
        }
    }
    if (m_turnPoints.size() > 0)
    {
        m_points       = m_POwner->loc.zone->m_navMesh->findPath(start, m_turnPoints[0]);
        m_currentPoint = 0;
    }

    return !m_points.empty();
}

bool CPathFind::FindClosestPath(const position_t& start, const position_t& end)
{
    TracyZoneScoped;

    if (arePositionsClose(start, end))
    {
        return false;
    }

    if (!isNavMeshEnabled())
    {
        return false;
    }

    m_points       = m_POwner->loc.zone->m_navMesh->findPath(start, end);
    m_currentPoint = 0;
    m_points.emplace_back(pathpoint_t{ end, 0, false }); // this prevents exploits with navmesh / impassible terrain

    /* this check requirement is never met as intended since m_points are never empty when mob has a path
    if (m_points.empty())
    {
        // this is a trick to make mobs go up / down impassible terrain
        m_points.emplace_back(end);
    }
*/

    return true;
}

void CPathFind::LookAt(const position_t& point)
{
    // Avoid unpredictable results if we're too close.
    if (!isWithinDistance(m_POwner->loc.p, point, 0.1f, true))
    {
        m_POwner->loc.p.rotation = worldAngle(m_POwner->loc.p, point);
        m_POwner->updatemask |= UPDATE_POS;
    }
}

bool CPathFind::OnPoint() const
{
    return m_onPoint;
}

bool CPathFind::IsFollowingPath()
{
    return !m_points.empty();
}

bool CPathFind::IsFollowingScriptedPath()
{
    return IsFollowingPath() && m_pathFlags & PATHFLAG_SCRIPT;
}

bool CPathFind::IsPatrolling()
{
    return m_patrolFlags & PATHFLAG_PATROL;
}

bool CPathFind::AtPoint(const position_t& pos)
{
    if (m_distanceFromPoint == 0)
    {
        return isWithinDistance(m_POwner->loc.p, pos, 0.1f);
    }
    else
    {
        return isWithinDistance(m_POwner->loc.p, pos, m_distanceFromPoint + 0.2f);
    }
}

bool CPathFind::InWater()
{
    if (isNavMeshEnabled())
    {
        return m_POwner->loc.zone->m_navMesh->inWater(m_POwner->loc.p);
    }

    return false;
}

const position_t& CPathFind::GetDestination() const
{
    return m_points.back().position;
}

void CPathFind::SetCarefulPathing(bool careful)
{
    m_carefulPathing = careful;
}

void CPathFind::Clear()
{
    m_distanceFromPoint = 0;
    m_pathFlags         = 0;
    m_roamFlags         = 0;
    m_points.clear();
    m_timeAtPoint = {};

    m_currentPoint  = 0;
    m_maxDistance   = 0;
    m_distanceMoved = 0;

    m_onPoint = true;

    m_currentTurn = 0;
    m_turnPoints.clear();
}

void CPathFind::AddPoints(std::vector<pathpoint_t>&& points, bool reverse)
{
    if (points.size() > MAX_PATH_POINTS && (m_pathFlags & PATHFLAG_PATROL) == 0)
    {
        ShowWarning("CPathFind::AddPoints Given too many points (%d). Limiting to max (%d)", points.size(), MAX_PATH_POINTS);
        points.resize(MAX_PATH_POINTS);
    }

    m_points = std::move(points);

    if (reverse)
    {
        std::reverse(m_points.begin(), m_points.end());
    }

    if (m_pathFlags & PATHFLAG_PATROL)
    {
        m_patrol      = m_points;
        m_patrolFlags = m_pathFlags;
    }
    else
    {
        m_patrol.clear();
        m_patrolFlags = 0;
    }
}

void CPathFind::FinishedPath()
{
    m_currentTurn++;

    // turning is only available to navmeshed maps
    if (m_currentTurn < m_turnPoints.size() && isNavMeshEnabled())
    {
        // move on to next turn
        position_t& nextTurn = m_turnPoints[m_currentTurn];

        bool result = FindPath(m_POwner->loc.p, nextTurn);

        if (!result)
        {
            Clear();
        }
    }
    else if (IsPatrolling() && m_POwner->PAI->IsRoaming())
    {
        m_currentPoint = 0;
        m_currentTurn  = 0;
    }
    else
    {
        Clear();
    }
}
