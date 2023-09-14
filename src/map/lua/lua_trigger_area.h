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

#ifndef _LUATRIGGERAREA_H
#define _LUATRIGGERAREA_H

#include "common/cbasetypes.h"
#include "luautils.h"

class CTriggerArea;

class CLuaTriggerArea
{
    CTriggerArea* m_PLuaTriggerArea;

public:
    CLuaTriggerArea(CTriggerArea*);

    CTriggerArea* GetTriggerArea() const
    {
        return m_PLuaTriggerArea;
    }

    friend std::ostream& operator<<(std::ostream& out, const CLuaTriggerArea& triggerArea);

    uint32 GetTriggerAreaID();
    int16  GetCount();
    int16  AddCount(int16 count);
    int16  DelCount(int16 count);

    bool operator==(const CLuaTriggerArea& other) const
    {
        return this->m_PLuaTriggerArea == other.m_PLuaTriggerArea;
    }

    static void Register();
};

#endif // _LUATRIGGERAREA_H
