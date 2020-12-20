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

#ifndef _CREGION_H
#define _CREGION_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

class CRegion
{
public:
    CRegion(uint32 RegionID, bool isCircle);

    uint32 GetRegionID() const;

    int16 GetCount() const;
    int16 AddCount(int16 count);
    int16 DelCount(int16 count);

    void SetULCorner(float x, float y, float z); // верхний левый угол (Upper Left)
    void SetLRCorner(float x, float y, float z); // нижний правый угол (Lower Right)

    bool isPointInside(position_t pos) const;

private:
    uint32 m_RegionID; // номер региона
    int16  m_Count;    // количество персонажей в регионе

    float x1, y1, z1; // верхний левый угол
    float x2, y2, z2; // лижний правый угол

    bool circle;
};

#endif
