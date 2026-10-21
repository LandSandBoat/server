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

#pragma once

#include "common/cbasetypes.h"

class ITriggerArea;

class CLuaTriggerArea
{
    ITriggerArea* m_PLuaTriggerArea;

public:
    CLuaTriggerArea(ITriggerArea*);

    auto getTriggerArea() const -> ITriggerArea*
    {
        return m_PLuaTriggerArea;
    }

    friend auto operator<<(std::ostream& out, const CLuaTriggerArea& triggerArea) -> std::ostream&;

    auto getTriggerAreaID() -> uint32;
    auto getCount() -> int16;
    auto addCount(int16 count) -> int16;
    auto delCount(int16 count) -> int16;

    auto operator==(const CLuaTriggerArea& other) const -> bool
    {
        return this->m_PLuaTriggerArea == other.m_PLuaTriggerArea;
    }

    static void Register();
};
