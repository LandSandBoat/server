/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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
#include "utils/attackutils.h"

class CAttack;

class CLuaAttack
{
    CAttack* m_PLuaAttack;

public:
    CLuaAttack(CAttack*);

    CAttack* GetAttack() const
    {
        return m_PLuaAttack;
    }

    CBattleEntity* getAttacker();
    CBattleEntity* getVictim();

    CBattleEntity* getTAEntity();
    bool           isH2H();
    uint8          getWeaponSlot();
    bool           isFirstSwing() const;
    

    bool isSA() const;
    void setSA(bool val);

    bool isTA() const;
    void setTA(bool val);

    float getDamageRatio() const;

    bool isCritical() const;
    void setCritical(bool critical);

    PHYSICAL_ATTACK_TYPE getAttackType() const;
    void                 setAttackType(PHYSICAL_ATTACK_TYPE type);

    friend std::ostream& operator<<(std::ostream& out, const CLuaAttack& action);

    bool operator==(const CLuaAttack& other) const
    {
        return this->m_PLuaAttack == other.m_PLuaAttack;
    }

    static void Register();
};
