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

#ifndef _LUAACTION_H
#define _LUAACTION_H

#include "common/cbasetypes.h"
#include "luautils.h"

struct action_t;
struct actionList_t;
class CLuaAction
{
    action_t* m_PLuaAction;

public:
    CLuaAction(action_t*);

    action_t* GetAction() const
    {
        return m_PLuaAction;
    }

    friend std::ostream& operator<<(std::ostream& out, const CLuaAction& action);

    void   ID(uint32 actionTargetID, uint32 newActionTargetID);
    void   setRecast(uint16 recast);
    uint16 getRecast();
    void   actionID(uint16 actionid);
    uint16 getParam(uint32 actionTargetID);
    void   param(uint32 actionTargetID, int32 param);
    void   messageID(uint32 actionTargetID, uint16 messageID);
    auto   getAnimation(uint32 actionTargetID) -> std::optional<uint16>;
    void   setAnimation(uint32 actionTargetID, uint16 animation);
    auto   getCategory() -> uint8;
    void   setCategory(uint8 category);
    void   speceffect(uint32 actionTargetID, uint8 speceffect);
    void   reaction(uint32 actionTargetID, uint8 reaction);
    void   modifier(uint32 actionTargetID, uint8 modifier);
    void   additionalEffect(uint32 actionTargetID, uint16 additionalEffect);
    void   addEffectParam(uint32 actionTargetID, int32 addEffectParam);
    void   addEffectMessage(uint32 actionTargetID, uint16 addEffectMessage);
    bool   addAdditionalTarget(uint32 actionTargetID);

    static void Register();
};

#endif
