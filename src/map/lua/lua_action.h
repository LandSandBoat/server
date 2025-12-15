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

#include "ability.h"
#include "common/cbasetypes.h"
#include "enums/action/knockback.h"
#include "enums/action/proc_kind.h"
#include "luautils.h"

enum class HitDistortion : uint8_t;
enum class ActionInfo : uint8_t;
enum class ActionResolution : uint8_t;
struct action_t;
struct action_target_t;
class CLuaAction
{
    action_t* m_PLuaAction;

public:
    CLuaAction(action_t*);

    auto GetAction() const -> action_t*
    {
        return m_PLuaAction;
    }

    friend std::ostream& operator<<(std::ostream& out, const CLuaAction& action);

    void ID(uint32 actionTargetId, uint32 newactionTargetId) const;
    auto getPrimaryTargetID() const -> uint32;
    void setRecast(uint16 recast) const;
    auto getRecast() const -> uint16;
    void actionID(uint16 actionid) const;
    auto getParam(uint32 actionTargetId) const -> uint16;
    void param(uint32 actionTargetId, int32 param) const;
    void messageId(uint32 actionTargetId, MsgBasic messageId) const;
    auto getMsg(uint32 actionTargetId) const -> std::optional<MsgBasic>;
    auto getAnimation(uint32 actionTargetId) const -> std::optional<ActionAnimation>;
    void setAnimation(uint32 actionTargetId, ActionAnimation animation) const;
    auto getCategory() const -> ActionCategory;
    void setCategory(uint8 category) const;
    void resolution(uint32 actionTargetId, ActionResolution resolution) const;
    void info(uint32 actionTargetId, ActionInfo info) const;
    void hitDistortion(uint32 actionTargetId, HitDistortion distortion) const;
    void knockback(uint32 actionTargetId, Knockback knockback) const;
    void recordDamage(const CLuaBaseEntity* PLuaTarget, ATTACK_TYPE atkType, int32 damage, std::optional<bool> isCritical = false) const;
    void modifier(uint32 actionTargetId, uint8 modifier) const;
    void additionalEffect(uint32 actionTargetId, ActionProcAddEffect additionalEffect) const;
    void addEffectParam(uint32 actionTargetId, int32 addEffectParam) const;
    void addEffectMessage(uint32 actionTargetId, MsgBasic addEffectMessage) const;
    auto addAdditionalTarget(uint32 actionTargetId) const -> bool;

    bool operator==(const CLuaAction& other) const
    {
        return this->m_PLuaAction == other.m_PLuaAction;
    }

    static void Register();
};
