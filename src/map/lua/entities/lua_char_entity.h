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

#include "lua/lua_baseentity.h"

class CCharEntity;
class CLuaCharEntity : public CLuaBaseEntity
{
public:
    CLuaCharEntity(CCharEntity*);

    void addExp(uint32 exp) const;
    void delExp(uint32 exp) const;
    auto getMerit(uint16 merit) const -> int32;
    auto getMeritCount() const -> uint8;

    static void Register();

private:
    CCharEntity* char_;
};
