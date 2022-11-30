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

#ifndef _CTRIGGER_AREA_H
#define _CTRIGGER_AREA_H

#include "common/cbasetypes.h"
#include "common/mmo.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

class CTriggerArea
{
public:
    CTriggerArea(uint32 triggerAreaID, bool isCircle);

    uint32 GetTriggerAreaID() const;

    int16 GetCount() const;
    int16 AddCount(int16 count);
    int16 DelCount(int16 count);

    void SetULCorner(float x, float y, float z); // The upper left corner
    void SetLRCorner(float x, float y, float z); // The lower right corner

    bool isPointInside(position_t pos) const;

private:
    uint32 m_TriggerAreaID;
    int16  m_Count; // number of characters in the trigger area

    float x1, y1, z1; // The upper left corner
    float x2, y2, z2; // The lower right corner

    bool circle;
};

#endif // _CTRIGGER_AREA_H
