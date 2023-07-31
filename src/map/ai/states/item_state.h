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

#ifndef _CITEM_STATE_H
#define _CITEM_STATE_H

#include "state.h"

class CBattleEntity;
class CCharEntity;
class CItemUsable;

struct action_t;

class CItemState : public CState
{
public:
    CItemState(CCharEntity* PEntity, uint16 targid, uint8 loc, uint8 slotid);
    void UpdateTarget(CBaseEntity* target) override;
    void UpdateTarget(uint16 targid) override;
    bool Update(time_point tick) override;
    void Cleanup(time_point tick) override;
    bool CanChangeState() override;
    bool CanFollowPath() override
    {
        return false;
    }

    bool CanInterrupt() override
    {
        return m_interruptable;
    }

    void TryInterrupt(CBattleEntity* PAttacker) override;

    CItemUsable* GetItem();

    void InterruptItem(action_t& action);
    void FinishItem(action_t& action);

protected:
    bool HasMoved();

    CCharEntity* m_PEntity;
    CItemUsable* m_PItem;
    uint8        m_location;
    uint8        m_slot;
    duration     m_castTime{};
    duration     m_animationTime{};
    position_t   m_startPos;
    bool         m_interrupted{ false };
    bool         m_interruptable{ true };
};

#endif
