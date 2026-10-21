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

#include "trigger_area.h"

#include "common/logging.h"
#include "common/utils.h"

#include <cmath>
#include <numeric>

// Initialize the trigger area to a unique number within the zone.
// When trying to set 0, issue a warning.
ITriggerArea::ITriggerArea(uint32 triggerAreaID)
: m_triggerAreaID(triggerAreaID)
, m_count(0)
{
    if (m_triggerAreaID == 0)
    {
        ShowWarning("TriggerArea ID cannot be zero");
    }
}

auto ITriggerArea::getTriggerAreaID() const -> uint32
{
    return m_triggerAreaID;
}

auto ITriggerArea::getCount() const -> int16
{
    return m_count;
}

auto ITriggerArea::addCount(int16 count) -> int16
{
    m_count += count;
    return m_count;
}

auto ITriggerArea::delCount(int16 count) -> int16
{
    m_count -= count;
    return m_count;
}

//
// CCuboidTriggerArea
//

CCuboidTriggerArea::CCuboidTriggerArea(uint32 triggerAreaID, float xMin, float yMin, float zMin, float xMax, float yMax, float zMax, float rotation)
: ITriggerArea(triggerAreaID)
, m_xMin(xMin)
, m_yMin(yMin)
, m_zMin(zMin)
, m_xMax(xMax)
, m_yMax(yMax)
, m_zMax(zMax)
, m_rotation(rotation)
, m_sin(std::sin(rotation))
, m_cos(std::cos(rotation))
{
}

auto CCuboidTriggerArea::isPointInside(float x, float y, float z) const -> bool
{
    if (m_rotation != 0.0f)
    {
        const float xCentre = std::midpoint(m_xMin, m_xMax);
        const float zCentre = std::midpoint(m_zMin, m_zMax);
        const float dX      = x - xCentre;
        const float dZ      = z - zCentre;

        x = xCentre + dX * m_cos + dZ * m_sin;
        z = zCentre + dZ * m_cos - dX * m_sin;
    }

    return m_xMin <= x && m_yMin <= y && m_zMin <= z && m_xMax >= x && m_yMax >= y && m_zMax >= z;
}

auto CCuboidTriggerArea::isPointInside(position_t pos) const -> bool
{
    return isPointInside(pos.x, pos.y, pos.z);
}

//
// CCylindricalTriggerArea
//

CCylindricalTriggerArea::CCylindricalTriggerArea(uint32 triggerAreaID, float xPos, float zPos, float radius)
: ITriggerArea(triggerAreaID)
, m_xPos(xPos)
, m_zPos(zPos)
, m_radius(radius)
{
}

auto CCylindricalTriggerArea::isPointInside(float x, float y, float z) const -> bool
{
    // The y component is "infinite" for cylindrical checks, so we don't
    // need to do anything with it.
    std::ignore = y;

    // Get the distance between their X coordinate and ours.
    const float dX = x - m_xPos;

    // Get the distance between their Z coordinate and ours.
    const float dZ = z - m_zPos;

    const float distanceSquared = (dX * dX) + (dZ * dZ);

    // Check if were within range of the target.
    return distanceSquared <= square(m_radius);
}

auto CCylindricalTriggerArea::isPointInside(position_t pos) const -> bool
{
    return isPointInside(pos.x, pos.y, pos.z);
}

//
// CSphericalTriggerArea
//

CSphericalTriggerArea::CSphericalTriggerArea(uint32 triggerAreaID, float xPos, float yPos, float zPos, float radius)
: ITriggerArea(triggerAreaID)
, m_xPos(xPos)
, m_yPos(yPos)
, m_zPos(zPos)
, m_radius(radius)
{
}

auto CSphericalTriggerArea::isPointInside(float x, float y, float z) const -> bool
{
    const float dX = x - m_xPos;
    const float dY = y - m_yPos;
    const float dZ = z - m_zPos;

    const float distanceSquared = (dX * dX) + (dY * dY) + (dZ * dZ);

    return distanceSquared <= square(m_radius);
}

auto CSphericalTriggerArea::isPointInside(position_t pos) const -> bool
{
    return isPointInside(pos.x, pos.y, pos.z);
}
