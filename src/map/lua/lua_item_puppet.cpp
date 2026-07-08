/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "lua/lua_item_puppet.h"
#include "items/item_puppet.h"

CLuaItemPuppet::CLuaItemPuppet(CItemPuppet* PItemPuppet)
: CLuaItem(PItemPuppet)
, puppetItem(PItemPuppet)
{
}

CLuaItemPuppet::CLuaItemPuppet(const CItemPuppet* PItemPuppet)
: CLuaItem(PItemPuppet)
, puppetItem(PItemPuppet)
{
}

void CLuaItemPuppet::Register()
{
    SOL_USERTYPE_INHERIT("CItemPuppet", CLuaItemPuppet, CLuaItem);
}
