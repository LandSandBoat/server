/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

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

#include <set>

class CBattleEntity;

// If enmity is a one-to-many list held by monsters,
// notoriety is the many-to-one opposite list held by players (or other targets of enmity)
class CNotorietyContainer
{
public:
    CNotorietyContainer(CBattleEntity* owner);

    auto begin() -> std::set<CBattleEntity*>::iterator;
    auto end() -> std::set<CBattleEntity*>::iterator;

    void add(CBattleEntity* entity);
    void remove(CBattleEntity* entity);
    auto size() -> std::size_t;

    auto hasEnmity() -> bool;

private:
    CBattleEntity*           m_POwner;
    std::set<CBattleEntity*> m_Lookup;
};
