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

#pragma once

#include "common/cbasetypes.h"

#include <sol/forward.hpp>

#include <string>

enum class ActionAnimation : uint16_t;
enum class MsgBasic : uint16_t;
class CAbility;

namespace xi
{

enum class Recast : uint16_t;
enum class StatusEffect : uint16_t;

} // namespace xi

class CLuaAbility
{
    CAbility* m_PLuaAbility;

public:
    CLuaAbility(CAbility*);

    auto GetAbility() const -> CAbility*
    {
        return m_PLuaAbility;
    }

    friend auto operator<<(std::ostream& out, const CLuaAbility& ability) -> std::ostream&;

    auto getID() -> uint16;
    auto getMsg() -> MsgBasic;
    auto getRecast() -> uint16;
    auto getRecastID() const -> xi::Recast;
    auto getRange() -> uint16;
    auto getRadius() const -> uint8;
    auto getAOE() const -> uint8;
    auto getName() -> const std::string&;
    auto getAnimation() -> ActionAnimation;
    auto getAddType() -> uint16; // see map/ability.h for definitions. These can tell if the ability is a Merit ability, Astral Flow only ability, etc

    void setMsg(MsgBasic messageID);
    void setAnimation(uint16 animationID);
    void setRecast(uint16 recastTime);
    auto getCE() -> int32;
    void setCE(int32 ce);
    auto getVE() -> int32;
    void setVE(int32 ve);
    void setRange(float range);
    void setPostActionCleanupEffect(xi::StatusEffect effectToCleanup);

    auto operator==(const CLuaAbility& other) const -> bool
    {
        return this->m_PLuaAbility == other.m_PLuaAbility;
    }

    static void Register();
};
