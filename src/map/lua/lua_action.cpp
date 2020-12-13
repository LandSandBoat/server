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
#include "../packets/action.h"

CLuaAction::CLuaAction(lua_State *L)
{
    if (!lua_isnil(L, -1) && !lua_isnil(L, -2))
    {
        m_PLuaAction = (action_t*)(lua_touserdata(L, 1));
        lua_pop(L, 2);
    }
    else
    {
        m_PLuaAction = nullptr;
    }
}

CLuaAction::CLuaAction(action_t* Action)
{
    m_PLuaAction = Action;
}


int32 CLuaAction::ID(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == lua_tointeger(L, 1))
        {
            if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
            {
                actionList.ActionTargetID = (uint32)lua_tointeger(L, 2);
                return 0;
            }
        }
    }
    return 0;
}

int32 CLuaAction::recast(lua_State* L)
{
    if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
    {
        m_PLuaAction->recast = (uint16)lua_tointeger(L, 1);
        return 0;
    }
    else
    {
        lua_pushinteger(L, m_PLuaAction->recast);
        return 1;
    }
}

int32 CLuaAction::actionID(lua_State* L)
{
    if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
    {
        m_PLuaAction->actionid = (uint16)lua_tointeger(L, 1);
        return 0;
    }
    else
    {
        lua_pushinteger(L, m_PLuaAction->actionid);
        return 1;
    }
}

inline int32 CLuaAction::param(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == lua_tointeger(L, 1))
        {
            if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
            {
                actionList.actionTargets[0].param = (int32)lua_tointeger(L, 2);
                return 0;
            }
            else
            {
                lua_pushinteger(L, actionList.actionTargets[0].param);
                return 1;
            }
        }
    }
    return 0;
}

inline int32 CLuaAction::messageID(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == lua_tointeger(L, 1))
        {
            if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
            {
                actionList.actionTargets[0].messageID = (uint16)lua_tointeger(L, 2);
                return 0;
            }
            else
            {
                lua_pushinteger(L, actionList.actionTargets[0].messageID);
                return 1;
            }
        }
    }
    return 0;
}

int32 CLuaAction::animation(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == lua_tointeger(L, 1))
        {
            if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
            {
                actionList.actionTargets[0].animation = (uint16)lua_tointeger(L, 2);
                return 0;
            }
            else
            {
                lua_pushinteger(L, actionList.actionTargets[0].animation);
                return 1;
            }
        }
    }
    return 0;
}

int32 CLuaAction::speceffect(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == lua_tointeger(L, 1))
        {
            if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
            {
                actionList.actionTargets[0].speceffect = static_cast<SPECEFFECT>(lua_tointeger(L, 2));
                return 0;
            }
            else
            {
                lua_pushinteger(L, actionList.actionTargets[0].speceffect);
                return 1;
            }
        }
    }
    return 0;
}

int32 CLuaAction::reaction(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == lua_tointeger(L, 1))
        {
            if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
            {
                actionList.actionTargets[0].reaction = static_cast<REACTION>(lua_tointeger(L, 2));
                return 0;
            }
            else
            {
                lua_pushinteger(L, static_cast<uint16>(actionList.actionTargets[0].reaction));
                return 1;
            }
        }
    }
    return 0;
}

inline int32 CLuaAction::additionalEffect(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == lua_tointeger(L, 1))
        {
            if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
            {
                actionList.actionTargets[0].additionalEffect = static_cast<SUBEFFECT>(lua_tointeger(L, 2));
                return 0;
            }
            else
            {
                lua_pushinteger(L, actionList.actionTargets[0].additionalEffect);
                return 1;
            }
        }
    }
    return 0;
}

inline int32 CLuaAction::addEffectParam(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == lua_tointeger(L, 1))
        {
            if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
            {
                actionList.actionTargets[0].addEffectParam = (int32)lua_tointeger(L, 2);
                return 0;
            }
            else
            {
                lua_pushinteger(L, actionList.actionTargets[0].addEffectParam);
                return 1;
            }
        }
    }
    return 0;
}


int32 CLuaAction::addEffectMessage(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == lua_tointeger(L, 1))
        {
            if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
            {
                actionList.actionTargets[0].addEffectMessage = (uint16)lua_tointeger(L, 2);
                return 0;
            }
            else
            {
                lua_pushinteger(L, actionList.actionTargets[0].addEffectMessage);
                return 1;
            }
        }
    }
    return 0;
}

// clang-format off
const char CLuaAction::className[] = "CAction";

Lunar<CLuaAction>::Register_t CLuaAction::methods[] =
{
    LUNAR_DECLARE_METHOD(CLuaAction, ID),
    LUNAR_DECLARE_METHOD(CLuaAction, recast),
    LUNAR_DECLARE_METHOD(CLuaAction, actionID),
    LUNAR_DECLARE_METHOD(CLuaAction, param),
    LUNAR_DECLARE_METHOD(CLuaAction, messageID),
    LUNAR_DECLARE_METHOD(CLuaAction, animation),
    LUNAR_DECLARE_METHOD(CLuaAction, speceffect),
    LUNAR_DECLARE_METHOD(CLuaAction, reaction),
    LUNAR_DECLARE_METHOD(CLuaAction, additionalEffect),
    LUNAR_DECLARE_METHOD(CLuaAction, addEffectParam),
    LUNAR_DECLARE_METHOD(CLuaAction, addEffectMessage),
    {nullptr,nullptr}
};
// clang-format on
