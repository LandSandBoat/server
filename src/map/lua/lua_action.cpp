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

CLuaAction::CLuaAction(action_t* Action)
{
    m_PLuaAction = Action;
}

void CLuaAction::ID(uint32 actionTargetID, uint16 newActionTargetID)
{
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == actionTargetID)
        {
            actionList.ActionTargetID = newActionTargetID;
            return;
        }
    }
}

void CLuaAction::recast(uint16 recast)
{
    m_PLuaAction->recast = recast;
}

void CLuaAction::actionID(uint16 actionid)
{
    m_PLuaAction->actionid = actionid;
}

void CLuaAction::param(uint32 actionTargetID, int32 param)
{
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == actionTargetID)
        {
            actionList.actionTargets[0].param = param;
            return;
        }
    }
}

void CLuaAction::messageID(uint32 actionTargetID, uint16 messageID)
{
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == actionTargetID)
        {
            actionList.actionTargets[0].messageID = messageID;
            return;
        }
    }
}

void CLuaAction::animation(uint32 actionTargetID, uint16 animation)
{
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == actionTargetID)
        {
            actionList.actionTargets[0].animation = animation;
            return;
        }
    }
}

void CLuaAction::speceffect(uint32 actionTargetID, uint8 speceffect)
{
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == actionTargetID)
        {
            actionList.actionTargets[0].speceffect = static_cast<SPECEFFECT>(speceffect);
            return;
        }
    }
}

void CLuaAction::reaction(uint32 actionTargetID, uint8 reaction)
{
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == actionTargetID)
        {
            actionList.actionTargets[0].reaction = static_cast<REACTION>(reaction);
            return;
        }
    }
}

void CLuaAction::additionalEffect(uint32 actionTargetID, uint16 additionalEffect)
{
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == actionTargetID)
        {
            actionList.actionTargets[0].additionalEffect = static_cast<SUBEFFECT>(additionalEffect);
            return;
        }
    }
}

void CLuaAction::addEffectParam(uint32 actionTargetID, int32 addEffectParam)
{
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == actionTargetID)
        {
            actionList.actionTargets[0].addEffectParam = addEffectParam;
            return;
        }
    }
}

void CLuaAction::addEffectMessage(uint32 actionTargetID, uint16 addEffectMessage)
{
    for (auto&& actionList : m_PLuaAction->actionLists)
    {
        if (actionList.ActionTargetID == actionTargetID)
        {
            actionList.actionTargets[0].addEffectMessage = addEffectMessage;
            return;
        }
    }
}

//==========================================================//

void CLuaAction::Register()
{
    SOL_USERTYPE("CAction", CLuaAction);
    SOL_REGISTER("ID", CLuaAction::ID);
    SOL_REGISTER("recast", CLuaAction::recast);
    SOL_REGISTER("actionID", CLuaAction::actionID);
    SOL_REGISTER("param", CLuaAction::param);
    SOL_REGISTER("messageID", CLuaAction::messageID);
    SOL_REGISTER("animation", CLuaAction::animation);
    SOL_REGISTER("speceffect", CLuaAction::speceffect);
    SOL_REGISTER("reaction", CLuaAction::reaction);
    SOL_REGISTER("additionalEffect", CLuaAction::additionalEffect);
    SOL_REGISTER("addEffectParam", CLuaAction::addEffectParam);
    SOL_REGISTER("addEffectMessage", CLuaAction::addEffectMessage);
};

//==========================================================//
