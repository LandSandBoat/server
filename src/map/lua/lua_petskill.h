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

#pragma once

#include "common/cbasetypes.h"

#include <sol/forward.hpp>

enum class MsgBasic : uint16_t;
class CPetSkill;

namespace xi
{

enum class AttackType : uint8_t;

} // namespace xi

class CLuaPetSkill
{
    CPetSkill* m_PLuaPetSkill;

public:
    CLuaPetSkill(CPetSkill*);

    auto GetMobSkill() const -> CPetSkill*
    {
        return m_PLuaPetSkill;
    }

    friend auto operator<<(std::ostream& out, const CLuaPetSkill& mobskill) -> std::ostream&;

    auto getTP() -> float;
    auto getMobHP() const -> int32;
    auto getMobHPP() -> uint8;
    auto getID() -> uint16;
    auto getParam() -> int16;
    auto isAoE() -> bool;
    auto isConal() -> bool;
    auto isSingle() -> bool;
    auto hasMissMsg() -> bool;
    void setMsg(MsgBasic message);
    auto getMsg() -> MsgBasic;
    auto getTotalTargets() -> uint16;
    auto getPrimaryTargetID() -> uint32;
    void setFinalAnimationSub(uint8 newAnimationSub);
    auto getAttackType() const -> xi::AttackType;
    void setAttackType(xi::AttackType attackType) const;
    auto isCritical() const -> bool;
    void setCritical(bool isCritical) const;

    auto operator==(const CLuaPetSkill& other) const -> bool
    {
        return this->m_PLuaPetSkill == other.m_PLuaPetSkill;
    }

    static void Register();
};
