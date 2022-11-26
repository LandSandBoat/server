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

// Initialize the trigger area to a unique number within the zone.
// When trying to set 0, issue a warning.
CTriggerArea::CTriggerArea(uint32 triggerAreaID, bool isCircle)
: m_TriggerAreaID(triggerAreaID)
, m_Count(0)
, circle(isCircle)
{
    x1 = 0.f;
    x2 = 0.f;
    y1 = 0.f;
    y2 = 0.f;
    z1 = 0.f;
    z2 = 0.f;

    if (m_TriggerAreaID == 0)
    {
        ShowWarning("TriggerArea ID cannot be zero");
    }
}

uint32 CTriggerArea::GetTriggerAreaID() const
{
    return m_TriggerAreaID;
}

int16 CTriggerArea::GetCount() const
{
    return m_Count;
}

int16 CTriggerArea::AddCount(int16 count)
{
    m_Count += count;
    return m_Count;
}

int16 CTriggerArea::DelCount(int16 count)
{
    m_Count -= count;
    return m_Count;
}

// set upper left corner of area
void CTriggerArea::SetULCorner(float x, float y, float z)
{
    x1 = x;
    y1 = y;
    z1 = z;
}

// set lower right corner of area
void CTriggerArea::SetLRCorner(float x, float y, float z)
{
    x2 = x;
    y2 = y;
    z2 = z;
}

// check whether the position is inside the area
bool CTriggerArea::isPointInside(position_t pos) const
{
    if (circle)
    {
        // Get the distance between their X coordinate and ours.
        float dX = pos.x - x1;

        // Get the distance between their Z coordinate and ours.
        float dZ = pos.z - z1;

        float distance = std::sqrt((dX * dX) + (dZ * dZ));

        // Check if were within range of the target.
        // In this case of a circle, 'y' is the radius.
        return distance <= y1;
    }

    return (x1 <= pos.x && y1 <= pos.y && z1 <= pos.z && x2 >= pos.x && y2 >= pos.y && z2 >= pos.z);
}
