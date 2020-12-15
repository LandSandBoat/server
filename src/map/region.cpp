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

#include "../common/showmsg.h"

#include "region.h"

#include <cmath>

/************************************************************************
 *																		*
 *  При инициализации области задаем уникальный номер в пределах зоны.	*
 *  При попытке установить 0 в качестве номера выдаем предупреждение.	*
 *																		*
 ************************************************************************/

CRegion::CRegion(uint32 RegionID, bool isCircle)
: m_RegionID(RegionID)
, m_Count(0)
, circle(isCircle)
{
    if (m_RegionID == 0)
    {
        ShowWarning(CL_YELLOW "Region ID cannot be zero\n" CL_RESET);
    }
}

/************************************************************************
 *																		*
 *  Узнаем уникальный номер активной области								*
 *																		*
 ************************************************************************/

uint32 CRegion::GetRegionID() const
{
    return m_RegionID;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

int16 CRegion::GetCount() const
{
    return m_Count;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

int16 CRegion::AddCount(int16 count)
{
    m_Count += count;
    return m_Count;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

int16 CRegion::DelCount(int16 count)
{
    m_Count -= count;
    return m_Count;
}

/************************************************************************
 *																		*
 *  Устанавливаем верхний левый угол области								*
 *																		*
 ************************************************************************/

void CRegion::SetULCorner(float x, float y, float z)
{
    x1 = x;
    y1 = y;
    z1 = z;
}

/************************************************************************
 *																		*
 *  Устанавливаем нижний правый угол области								*
 *																		*
 ************************************************************************/

void CRegion::SetLRCorner(float x, float y, float z)
{
    x2 = x;
    y2 = y;
    z2 = z;
}

/************************************************************************
 *																		*
 *  Проверяем, находится ли позиция внутри области						*
 *																		*
 ************************************************************************/

bool CRegion::isPointInside(position_t pos) const
{
    if (circle == true)
    {
        // Get the distance between their X coordinate and ours.
        float dX = pos.x - x1;

        // Get the distance between their Z coordinate and ours.
        float dZ = pos.z - z1;

        float distance = std::sqrt((dX * dX) + (dZ * dZ));

        // Check if were within range of the target.
        // In this case of a circle, 'y' is the radius.
        if (distance <= y1)
        {
            return true;
        }

        return false;
    }

    return (x1 <= pos.x && y1 <= pos.y && z1 <= pos.z && x2 >= pos.x && y2 >= pos.y && z2 >= pos.z);
}
