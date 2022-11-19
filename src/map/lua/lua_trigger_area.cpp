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

CLuaTriggerArea::CLuaTriggerArea(CTriggerArea* PTriggerArea)
: m_PLuaTriggerArea(PTriggerArea)
{
    if (PTriggerArea == nullptr)
    {
        ShowError("CLuaTriggerArea created with nullptr instead of valid CTriggerArea*!");
    }
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

uint32 CLuaTriggerArea::GetTriggerAreaID()
{
    return m_PLuaTriggerArea->GetTriggerAreaID();
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

int16 CLuaTriggerArea::GetCount()
{
    return m_PLuaTriggerArea->GetCount();
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

int16 CLuaTriggerArea::AddCount(int16 count)
{
    return m_PLuaTriggerArea->AddCount(count);
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

int16 CLuaTriggerArea::DelCount(int16 count)
{
    return m_PLuaTriggerArea->DelCount(count);
}

//======================================================//

void CLuaTriggerArea::Register()
{
    SOL_USERTYPE("CTriggerArea", CLuaTriggerArea);
    SOL_REGISTER("GetTriggerAreaID", CLuaTriggerArea::GetTriggerAreaID);
    SOL_REGISTER("GetCount", CLuaTriggerArea::GetCount);
    SOL_REGISTER("AddCount", CLuaTriggerArea::AddCount);
    SOL_REGISTER("DelCount", CLuaTriggerArea::DelCount);
}

std::ostream& operator<<(std::ostream& os, const CLuaTriggerArea& triggerArea)
{
    std::string id = triggerArea.m_PLuaTriggerArea ? std::to_string(triggerArea.m_PLuaTriggerArea->GetTriggerAreaID()) : "nullptr";
    return os << "CLuaTriggerArea(" << id << ")";
}

//======================================================//
