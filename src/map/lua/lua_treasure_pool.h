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

#include "common/cbasetypes.h"
#include "luautils.h"

enum class TreasurePoolType : uint8;
class CTreasurePool;
class CLuaTreasurePool
{
    CTreasurePool* m_PLuaTreasurePool;

public:
    CLuaTreasurePool(CTreasurePool* PTreasurePool);

    auto getType() const -> TreasurePoolType;
    void flush() const;
    void addMember(CBaseEntity* PEntity) const;
    void delMember(CBaseEntity* PEntity) const;
    void update(CBaseEntity* PEntity) const;
    auto addItem(uint16 ItemID, CBaseEntity* PEntity) const -> uint8;
    auto memberCount() const -> size_t;
    auto getItems() const -> sol::table;
    auto getMembers() const -> sol::table;

    static void Register();
};
