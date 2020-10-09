/*
 * notoriety_container.h
 *      Author: zach2good | github.com/zach2good
 *
===========================================================================
  Copyright (c) 2020 Topaz Dev Teams
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

#ifndef _NOTORIETYCONTAINER_H
#define _NOTORIETYCONTAINER_H

#include <set>

class CBattleEntity;
class CMobEntity;

// If enmity is a one-to-many list held by monsters,
// notoriety is the many-to-one opposite list held by players (or other targets of enmity)
class CNotorietyContainer
{
public:
    CNotorietyContainer(CBattleEntity* owner);
    ~CNotorietyContainer() = default;

    std::set<CBattleEntity*>::iterator begin();
    std::set<CBattleEntity*>::iterator end();

    void add(CBattleEntity* entity);
    void remove(CBattleEntity* entity);
    void clear();
    std::size_t size();

    bool hasEnmity();

private:
    using BattleEntitySet = std::set<CBattleEntity*>;
    CBattleEntity* m_POwner;
    BattleEntitySet m_Lookup;
};

#endif // _NOTORIETYCONTAINER_H
