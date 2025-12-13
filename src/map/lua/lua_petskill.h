/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Team

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

#ifndef _LUAPETSKILL_H
#define _LUAPETSKILL_H

#include "common/cbasetypes.h"
#include "luautils.h"

class CPetSkill;

class CLuaPetSkill
{
    CPetSkill* m_PLuaPetSkill;

public:
    CLuaPetSkill(CPetSkill*);

    CPetSkill* GetMobSkill() const
    {
        return m_PLuaPetSkill;
    }

    friend std::ostream& operator<<(std::ostream& out, const CLuaPetSkill& mobskill);

    float  getTP();
    auto   getMobHP() const -> uint8;
    uint8  getMobHPP();
    uint16 getID();
    int16  getParam();
    bool   isAoE();
    bool   isConal();
    bool   isSingle();
    bool   hasMissMsg();
    void   setMsg(MsgBasic message);
    auto   getMsg() -> MsgBasic;
    uint16 getTotalTargets();
    uint32 getPrimaryTargetID();
    void   setFinalAnimationSub(uint8 newAnimationSub);
    auto   getAttackType() const -> ATTACK_TYPE;
    void   setAttackType(ATTACK_TYPE attackType) const;
    auto   isCritical() const -> bool;
    void   setCritical(bool isCritical) const;

    bool operator==(const CLuaPetSkill& other) const
    {
        return this->m_PLuaPetSkill == other.m_PLuaPetSkill;
    }

    static void Register();
};

#endif
