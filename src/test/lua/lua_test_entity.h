/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "lua_test_entity_assertions.h"
#include "map/lua/lua_baseentity.h"

class CBaseEntity;
class CLuaTestEntity : public CLuaBaseEntity
{
public:
    CLuaTestEntity(CBaseEntity* entity);
    virtual ~CLuaTestEntity();

    virtual void setEntity(CBaseEntity* entity);
    void         despawn() const;
    void         respawn() const;
    auto         assert_() -> CLuaTestEntityAssertions;

    static void Register();
};
