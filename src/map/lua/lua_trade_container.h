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

#ifndef _LUATRADECONTAINER_H
#define _LUATRADECONTAINER_H

#include "../../common/cbasetypes.h"
#include "luautils.h"

class CTradeContainer;
class CLuaTradeContainer
{
    CTradeContainer* m_pMyTradeContainer;

public:
    CLuaTradeContainer(CTradeContainer*);

    CTradeContainer* GetTradeContainer() const
    {
        return m_pMyTradeContainer;
    }

    int32 getGil(lua_State*);
    int32 getItem(lua_State*);
    int32 getItemId(lua_State*);
    int32 getItemSubId(lua_State*);
    int32 getItemQty(lua_State*);
    int32 hasItemQty(lua_State*);
    int32 getSlotQty(lua_State*);   // количество предметов в указанной ячейке
    int32 getItemCount(lua_State*); // общее количество предметов
    int32 getSlotCount(lua_State*);
    int32 confirmItem(lua_State*);
    int32 confirmSlot(lua_State*);

    static void Register(sol::state& lua);
};

#endif
