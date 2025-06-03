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

#include "lua_trigger_area.h"

#include "trigger_area.h"

CLuaTriggerArea::CLuaTriggerArea(ITriggerArea* PTriggerArea)
: m_PLuaTriggerArea(PTriggerArea)
{
    if (PTriggerArea == nullptr)
    {
        ShowError("CLuaTriggerArea created with nullptr instead of valid ITriggerArea*!");
    }
}

uint32 CLuaTriggerArea::getTriggerAreaID()
{
    return m_PLuaTriggerArea->getTriggerAreaID();
}

int16 CLuaTriggerArea::getCount()
{
    return m_PLuaTriggerArea->getCount();
}

int16 CLuaTriggerArea::addCount(int16 count)
{
    return m_PLuaTriggerArea->addCount(count);
}

int16 CLuaTriggerArea::delCount(int16 count)
{
    return m_PLuaTriggerArea->delCount(count);
}

void CLuaTriggerArea::Register()
{
    SOL_USERTYPE("ITriggerArea", CLuaTriggerArea);
    SOL_REGISTER("getTriggerAreaID", CLuaTriggerArea::getTriggerAreaID);
    SOL_REGISTER("getCount", CLuaTriggerArea::getCount);
    SOL_REGISTER("addCount", CLuaTriggerArea::addCount);
    SOL_REGISTER("delCount", CLuaTriggerArea::delCount);
}

std::ostream& operator<<(std::ostream& os, const CLuaTriggerArea& triggerArea)
{
    std::string id = triggerArea.m_PLuaTriggerArea ? std::to_string(triggerArea.m_PLuaTriggerArea->getTriggerAreaID()) : "nullptr";
    return os << "CLuaTriggerArea(" << id << ")";
}
