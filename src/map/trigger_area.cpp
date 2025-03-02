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

#include <cmath>

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

uint32 ITriggerArea::getTriggerAreaID() const
{
    return m_triggerAreaID;
}

int16 ITriggerArea::getCount() const
{
    return m_count;
}

int16 ITriggerArea::addCount(int16 count)
{
    m_count += count;
    return m_count;
}

int16 ITriggerArea::delCount(int16 count)
{
    m_count -= count;
    return m_count;
}

//
// CCuboidTriggerArea
//

CCuboidTriggerArea::CCuboidTriggerArea(uint32 triggerAreaID, float xMin, float yMin, float zMin, float xMax, float yMax, float zMax)
: ITriggerArea(triggerAreaID)
, m_xMin(xMin)
, m_yMin(yMin)
, m_zMin(zMin)
, m_xMax(xMax)
, m_yMax(yMax)
, m_zMax(zMax)
{
}

bool CCuboidTriggerArea::isPointInside(float x, float y, float z) const
{
    return m_xMin <= x && m_yMin <= y && m_zMin <= z && m_xMax >= x && m_yMax >= y && m_zMax >= z;
}

bool CCuboidTriggerArea::isPointInside(position_t pos) const
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

bool CCylindricalTriggerArea::isPointInside(float x, float y, float z) const
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

bool CCylindricalTriggerArea::isPointInside(position_t pos) const
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

bool CSphericalTriggerArea::isPointInside(float x, float y, float z) const
{
    const float dX = x - m_xPos;
    const float dY = y - m_yPos;
    const float dZ = z - m_zPos;

    const float distanceSquared = (dX * dX) + (dY * dY) + (dZ * dZ);

    return distanceSquared <= square(m_radius);
}

bool CSphericalTriggerArea::isPointInside(position_t pos) const
{
    return isPointInside(pos.x, pos.y, pos.z);
}
