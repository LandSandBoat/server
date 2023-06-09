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

#include "common/logging.h"

#include "trigger_area.h"

#include <cmath>

namespace
{
    bool CuboidCuboidIntersect(CCuboidTriggerArea const* a, CCuboidTriggerArea const* b)
    {
        // Points of b
        auto p0 = position_t(b->xMax, b->yMax, b->zMax, 0, 0);
        auto p1 = position_t(b->xMax, b->yMax, b->zMin, 0, 0);
        auto p2 = position_t(b->xMax, b->yMin, b->zMax, 0, 0);
        auto p3 = position_t(b->xMax, b->yMin, b->zMin, 0, 0);
        auto p4 = position_t(b->xMin, b->yMax, b->zMax, 0, 0);
        auto p5 = position_t(b->xMin, b->yMax, b->zMin, 0, 0);
        auto p6 = position_t(b->xMin, b->yMin, b->zMax, 0, 0);
        auto p7 = position_t(b->xMin, b->yMin, b->zMin, 0, 0);

        // For each point of b, is it contained inside a?
        for (auto& pos : { p0, p1, p2, p3, p4, p5, p6, p7 })
        {
            if (a->IsPointInside(pos))
            {
                return true;
            }
        }

        return false;
    }

    bool CuboidCylinderIntersect(CCuboidTriggerArea const* a, CCylindricalTriggerArea const* b)
    {
        return false;
    }

    bool CylinderCylinderIntersect(CCylindricalTriggerArea const* a, CCylindricalTriggerArea const* b)
    {
        // clang-format off
        auto distance = std::sqrtf(std::powf(a->xPos - b->xPos, 2) +
                                   std::powf(a->zPos - b->zPos, 2));
        return distance <= (a->radius + b->radius);
        // clang-format on
    }

    bool SphereCuboidIntersect(CSphericalTriggerArea const* a, CCuboidTriggerArea const* b)
    {
        return false;
    }

    bool SphereCylinderIntersect(CSphericalTriggerArea const* a, CCylindricalTriggerArea const* b)
    {
        return false;
    }

    bool SphereSphereIntersect(CSphericalTriggerArea const* a, CSphericalTriggerArea const* b)
    {
        // clang-format off
        auto distance = std::sqrtf(std::powf(a->xPos - b->xPos, 2) +
                                   std::powf(a->yPos - b->yPos, 2) +
                                   std::powf(a->zPos - b->zPos, 2));
        return distance <= (a->radius + b->radius);
        // clang-format on
    }
} // namespace

// Initialize the trigger area to a unique number within the zone.
// When trying to set 0, issue a warning.
ITriggerArea::ITriggerArea(uint32 triggerAreaID)
: m_TriggerAreaID(triggerAreaID)
, m_Count(0)
{
    if (m_TriggerAreaID == 0)
    {
        ShowWarning("TriggerArea ID cannot be zero");
    }
}

uint32 ITriggerArea::GetTriggerAreaID() const
{
    return m_TriggerAreaID;
}

int16 ITriggerArea::GetCount() const
{
    return m_Count;
}

int16 ITriggerArea::AddCount(int16 count)
{
    m_Count += count;
    return m_Count;
}

int16 ITriggerArea::DelCount(int16 count)
{
    m_Count -= count;
    return m_Count;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

CCuboidTriggerArea::CCuboidTriggerArea(uint32 triggerAreaID, float xMin, float yMin, float zMin, float xMax, float yMax, float zMax)
: ITriggerArea(triggerAreaID)
{
}

bool CCuboidTriggerArea::IsPointInside(float x, float y, float z) const
{
    return xMin <= x && yMin <= y && zMin <= z && xMax >= x && yMax >= y && zMax >= z;
}

bool CCuboidTriggerArea::IsPointInside(position_t pos) const
{
    return IsPointInside(pos.x, pos.y, pos.z);
}

bool CCuboidTriggerArea::IntersectsOtherTriggerArea(std::unique_ptr<ITriggerArea> const& other) const
{
    auto* rawPtr = other.get();
    if (auto* cuboidPtr = dynamic_cast<CCuboidTriggerArea*>(rawPtr))
    {
        return CuboidCuboidIntersect(this, cuboidPtr);
    }
    else if (auto* cylinderPtr = dynamic_cast<CCylindricalTriggerArea*>(rawPtr))
    {
        return CuboidCylinderIntersect(this, cylinderPtr);
    }
    else if (auto* spherePtr = dynamic_cast<CSphericalTriggerArea*>(rawPtr))
    {
        return SphereCuboidIntersect(spherePtr, this);
    }

    ShowError("Invalid Trigger Area type reached!");

    return false;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

CCylindricalTriggerArea::CCylindricalTriggerArea(uint32 triggerAreaID, float xPos, float zPos, float radius)
: ITriggerArea(triggerAreaID)
{
}

bool CCylindricalTriggerArea::IsPointInside(float x, float y, float z) const
{
    // The y component is "infinite" for cylindrical checks, so we don't
    // need to do anything with it.
    std::ignore = y;

    // Get the distance between their X coordinate and ours.
    float dX = x - xPos;

    // Get the distance between their Z coordinate and ours.
    float dZ = z - xPos;

    float distance = std::sqrt((dX * dX) + (dZ * dZ));

    // Check if were within range of the target.
    return distance <= radius;
}

bool CCylindricalTriggerArea::IsPointInside(position_t pos) const
{
    return IsPointInside(pos.x, pos.y, pos.z);
}

bool CCylindricalTriggerArea::IntersectsOtherTriggerArea(std::unique_ptr<ITriggerArea> const& other) const
{
    auto* rawPtr = other.get();
    if (auto* cuboidPtr = dynamic_cast<CCuboidTriggerArea*>(rawPtr))
    {
        return CuboidCylinderIntersect(cuboidPtr, this);
    }
    else if (auto* cylinderPtr = dynamic_cast<CCylindricalTriggerArea*>(rawPtr))
    {
        return CylinderCylinderIntersect(this, cylinderPtr);
    }
    else if (auto* spherePtr = dynamic_cast<CSphericalTriggerArea*>(rawPtr))
    {
        return SphereCylinderIntersect(spherePtr, this);
    }

    ShowError("Invalid Trigger Area type reached!");

    return false;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

CSphericalTriggerArea::CSphericalTriggerArea(uint32 triggerAreaID, float xPos, float yPos, float zPos, float radius)
: ITriggerArea(triggerAreaID)
, xPos(xPos)
, yPos(yPos)
, zPos(zPos)
, radius(radius)
{
}

bool CSphericalTriggerArea::IsPointInside(float x, float y, float z) const
{
    float xAbs = std::powf(x - xPos, 2);
    float yAbs = std::powf(y - yPos, 2);
    float zAbs = std::powf(z - zPos, 2);
    return (xAbs + yAbs + zAbs) <= radius;
}

bool CSphericalTriggerArea::IsPointInside(position_t pos) const
{
    return IsPointInside(pos.x, pos.y, pos.z);
}

bool CSphericalTriggerArea::IntersectsOtherTriggerArea(std::unique_ptr<ITriggerArea> const& other) const
{
    auto* rawPtr = other.get();
    if (auto* cuboidPtr = dynamic_cast<CCuboidTriggerArea*>(rawPtr))
    {
        return SphereCuboidIntersect(this, cuboidPtr);
    }
    else if (auto* cylinderPtr = dynamic_cast<CCylindricalTriggerArea*>(rawPtr))
    {
        return SphereCylinderIntersect(this, cylinderPtr);
    }
    else if (auto* spherePtr = dynamic_cast<CSphericalTriggerArea*>(rawPtr))
    {
        return SphereSphereIntersect(this, spherePtr);
    }

    ShowError("Invalid Trigger Area type reached!");

    return false;
}
