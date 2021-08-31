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

#include "lua_region.h"
#include "../region.h"

/************************************************************************
 *																		*
 *  Конструктор															*
 *																		*
 ************************************************************************/

CLuaRegion::CLuaRegion(CRegion* PRegion)
: m_PLuaRegion(PRegion)
{
    if (PRegion == nullptr)
    {
        ShowError("CLuaRegion created with nullptr instead of valid CRegion*!");
    }
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

uint32 CLuaRegion::GetRegionID()
{
    return m_PLuaRegion->GetRegionID();
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

int16 CLuaRegion::GetCount()
{
    return m_PLuaRegion->GetCount();
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

int16 CLuaRegion::AddCount(int16 count)
{
    return m_PLuaRegion->AddCount(count);
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

int16 CLuaRegion::DelCount(int16 count)
{
    return m_PLuaRegion->DelCount(count);
}

//======================================================//

void CLuaRegion::Register()
{
    SOL_USERTYPE("CRegion", CLuaRegion);
    SOL_REGISTER("GetRegionID", CLuaRegion::GetRegionID);
    SOL_REGISTER("AddCount", CLuaRegion::AddCount);
    SOL_REGISTER("DelCount", CLuaRegion::DelCount);
}

std::ostream& operator<<(std::ostream& os, const CLuaRegion& region)
{
    std::string id = region.m_PLuaRegion ? std::to_string(region.m_PLuaRegion->GetRegionID()) : "nullptr";
    return os << "CLuaRegion(" << id << ")";
}

//======================================================//
