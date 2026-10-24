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
#include "status_effect.h"

#include <sol/forward.hpp>

class CStatusEffect;

class CLuaStatusEffect
{
    CStatusEffect* m_PLuaStatusEffect;

public:
    CLuaStatusEffect(CStatusEffect*);

    auto GetStatusEffect() const -> CStatusEffect*
    {
        return m_PLuaStatusEffect;
    }

    friend auto operator<<(std::ostream& out, const CStatusEffect& effect) -> std::ostream&;

    auto getEffectType() -> uint32;
    auto getSubType() -> uint32;
    auto getSourceType() -> uint16;
    auto getSourceTypeParam() -> uint32;
    auto getOriginID() -> uint32;
    auto getPower() -> uint16;
    auto getSubPower() -> uint16;
    auto getSubIcon() -> uint16;
    auto getTier() -> uint16;
    auto getEffectSlot() -> uint8;
    auto getDuration() -> uint32;
    auto getStartTime() -> uint32;
    auto getLastTick() -> uint32;
    auto getTimeRemaining() -> uint32;
    auto getTickCount() -> uint32;
    auto getTick() -> uint32;
    auto getIcon() -> uint16;

    void setIcon(uint16 icon);
    void setSource(EffectSourceType sourceType, uint32 sourceTypeParam);
    auto setOriginID(uint32 originid) -> void;
    void setPower(uint16 power);
    void setSubPower(uint16 subpower);
    void setSubIcon(uint16 subIcon);
    void setTier(uint16 tier);
    void setEffectSlot(uint8 slot);
    void setDuration(uint32 duration);
    void setTick(uint32 tick);

    void setStartTime(uint32 time);
    void resetStartTime();

    void addMod(uint16 mod, int16 amount);
    auto getEffectFlags() -> uint32;
    void setEffectFlags(uint32 flags);
    void addEffectFlag(uint32 flag);
    void delEffectFlag(uint32 flag);
    auto hasEffectFlag(uint32 flag) -> bool;

    auto operator==(const CLuaStatusEffect& other) const -> bool
    {
        return this->m_PLuaStatusEffect == other.m_PLuaStatusEffect;
    }

    static void Register();
};
