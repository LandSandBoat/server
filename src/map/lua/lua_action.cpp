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

#include "lua_action.h"

#include "action/action.h"

CLuaAction::CLuaAction(action_t* Action)
: m_PLuaAction(Action)
{
    if (Action == nullptr)
    {
        ShowError("CLuaAction created with nullptr instead of valid action_t*!");
    }
}

void CLuaAction::ID(const uint32 actionTargetId, const uint32 newactionTargetId) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            actionTarget.actorId = newactionTargetId;
            return;
        }
    }
}

// Get the first (primary) target's long ID, if available.
uint32 CLuaAction::getPrimaryTargetID() const
{
    if (!m_PLuaAction->targets.empty())
    {
        return m_PLuaAction->targets[0].actorId;
    }

    return 0;
}

void CLuaAction::setRecast(const uint16 recast) const
{
    m_PLuaAction->recast = std::chrono::seconds(recast);
}

auto CLuaAction::getRecast() const -> uint16
{
    return static_cast<uint16>(timer::count_seconds(m_PLuaAction->recast));
}

void CLuaAction::actionID(const uint16 actionid) const
{
    m_PLuaAction->actionid = actionid;
}

auto CLuaAction::getParam(const uint32 actionTargetId) const -> uint16
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            return actionTarget.results[0].param;
        }
    }

    return 0;
}

void CLuaAction::param(const uint32 actionTargetId, const int32 param) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            actionTarget.results[0].param = param;
            return;
        }
    }
}

void CLuaAction::messageId(const uint32 actionTargetId, const MsgBasic messageId) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            actionTarget.results[0].messageID = messageId;
            return;
        }
    }
}

auto CLuaAction::getMsg(const uint32 actionTargetId) const -> std::optional<MsgBasic>
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            return actionTarget.results[0].messageID;
        }
    }

    return std::nullopt;
}

auto CLuaAction::getAnimation(const uint32 actionTargetId) const -> std::optional<ActionAnimation>
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            return actionTarget.results[0].animation;
        }
    }

    return std::nullopt;
}

void CLuaAction::setAnimation(const uint32 actionTargetId, const ActionAnimation animation) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            actionTarget.results[0].animation = animation;
            return;
        }
    }
}

auto CLuaAction::getCategory() const -> ActionCategory
{
    return m_PLuaAction->actiontype;
}

void CLuaAction::setCategory(uint8 category) const
{
    m_PLuaAction->actiontype = static_cast<ActionCategory>(category);
}

void CLuaAction::resolution(const uint32 actionTargetId, const ActionResolution resolution) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            actionTarget.results[0].resolution = resolution;
            return;
        }
    }
}

void CLuaAction::info(const uint32 actionTargetId, const ActionInfo info) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            actionTarget.results[0].info |= info;
            return;
        }
    }
}

void CLuaAction::hitDistortion(const uint32 actionTargetId, const HitDistortion distortion) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            actionTarget.results[0].hitDistortion = distortion;
            return;
        }
    }
}

void CLuaAction::knockback(const uint32 actionTargetId, const Knockback knockback) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            actionTarget.results[0].knockback = knockback;
            return;
        }
    }
}

void CLuaAction::recordDamage(const CLuaBaseEntity* PLuaTarget, const ATTACK_TYPE atkType, const int32 damage, const std::optional<bool> isCritical) const
{
    if (auto* PTarget = dynamic_cast<CBattleEntity*>(PLuaTarget->GetBaseEntity()))
    {
        const uint32 actionTargetId = PTarget->id;
        for (auto&& actionTarget : m_PLuaAction->targets)
        {
            if (actionTarget.actorId == actionTargetId)
            {
                actionTarget.results[0].recordDamage(attack_outcome_t{
                    .atkType    = atkType,
                    .damage     = damage,
                    .target     = PTarget,
                    .isCritical = isCritical.value_or(false),
                });
                return;
            }
        }
    }
}

void CLuaAction::modifier(const uint32 actionTargetId, uint8 modifier) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            actionTarget.results[0].modifier = static_cast<ActionModifier>(modifier);
            return;
        }
    }
}

void CLuaAction::additionalEffect(const uint32 actionTargetId, const ActionProcAddEffect additionalEffect) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            actionTarget.results[0].additionalEffect = additionalEffect;
            return;
        }
    }
}

void CLuaAction::addEffectParam(const uint32 actionTargetId, const int32 addEffectParam) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            actionTarget.results[0].addEffectParam = addEffectParam;
            return;
        }
    }
}

void CLuaAction::addEffectMessage(const uint32 actionTargetId, const MsgBasic addEffectMessage) const
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            actionTarget.results[0].addEffectMessage = addEffectMessage;
            return;
        }
    }
}

auto CLuaAction::addAdditionalTarget(const uint32 actionTargetId) const -> bool
{
    for (auto&& actionTarget : m_PLuaAction->targets)
    {
        if (actionTarget.actorId == actionTargetId)
        {
            return false;
        }
    }

    auto& newAction = m_PLuaAction->addTarget(actionTargetId);
    newAction.addResult();

    return true;
}

//==========================================================//

void CLuaAction::Register()
{
    SOL_USERTYPE("CAction", CLuaAction);
    SOL_REGISTER("ID", CLuaAction::ID);
    SOL_REGISTER("getPrimaryTargetID", CLuaAction::getPrimaryTargetID);
    SOL_REGISTER("getRecast", CLuaAction::getRecast);
    SOL_REGISTER("setRecast", CLuaAction::setRecast);
    SOL_REGISTER("actionID", CLuaAction::actionID);
    SOL_REGISTER("getParam", CLuaAction::getParam);
    SOL_REGISTER("param", CLuaAction::param);
    SOL_REGISTER("messageID", CLuaAction::messageId);
    SOL_REGISTER("getMsg", CLuaAction::getMsg);
    SOL_REGISTER("getAnimation", CLuaAction::getAnimation);
    SOL_REGISTER("setAnimation", CLuaAction::setAnimation);
    SOL_REGISTER("getCategory", CLuaAction::getCategory);
    SOL_REGISTER("setCategory", CLuaAction::setCategory);
    SOL_REGISTER("resolution", CLuaAction::resolution);
    SOL_REGISTER("info", CLuaAction::info);
    SOL_REGISTER("hitDistortion", CLuaAction::hitDistortion);
    SOL_REGISTER("knockback", CLuaAction::knockback);
    SOL_REGISTER("recordDamage", CLuaAction::recordDamage);
    SOL_REGISTER("modifier", CLuaAction::modifier);
    SOL_REGISTER("additionalEffect", CLuaAction::additionalEffect);
    SOL_REGISTER("addEffectParam", CLuaAction::addEffectParam);
    SOL_REGISTER("addEffectMessage", CLuaAction::addEffectMessage);
    SOL_REGISTER("addAdditionalTarget", CLuaAction::addAdditionalTarget);
};

std::ostream& operator<<(std::ostream& os, const CLuaAction& action)
{
    std::string id = action.m_PLuaAction ? std::to_string(action.m_PLuaAction->actorId) : "nullptr";
    return os << "CLuaAction(" << id << ")";
}

//==========================================================//
