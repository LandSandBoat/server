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

#ifndef _LUAREGION_H
#define _LUAREGION_H

#include "../../common/cbasetypes.h"
#include "luautils.h"

class CRegion;
class CLuaRegion
{
    CRegion* m_PLuaRegion;

public:
    CLuaRegion(CRegion*);

    CRegion* GetRegion() const
    {
        return m_PLuaRegion;
    }

    int32 GetRegionID(lua_State*);
    int32 GetCount(lua_State*);
    int32 AddCount(lua_State*);
    int32 DelCount(lua_State*);

    static void Register();
};

#endif
