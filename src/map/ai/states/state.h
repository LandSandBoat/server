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

#ifndef _CSTATE_H
#define _CSTATE_H

#include "common/mmo.h"
#include "packets/message_basic.h"
#include <memory>

class CBattleEntity;

class CStateInitException : public std::exception
{
public:
    explicit CStateInitException(std::unique_ptr<CBasicPacket> _msg)
    : std::exception()
    , packet(std::move(_msg))
    {
    }
    std::unique_ptr<CBasicPacket> packet;
};

class CState
{
public:
    CState(CBaseEntity* PEntity, uint16 _targid);

    virtual ~CState() = default;

    CBaseEntity* GetTarget() const;
    void         SetTarget(uint16 targid);

    bool HasErrorMsg() const;

    auto GetErrorMsg() -> std::unique_ptr<CBasicPacket>;

    bool DoUpdate(time_point tick);
    // try interrupt (on hit)
    virtual void TryInterrupt(CBattleEntity* PAttacker)
    {
    }

    // called when state completes
    virtual void Cleanup(time_point tick) = 0;
    // whether the state can be changed by normal means
    virtual bool CanChangeState() = 0;
    virtual bool CanFollowPath()  = 0;
    // whether the state can be interrupted (including by stun/sleep)
    virtual bool CanInterrupt() = 0;
    bool         IsCompleted() const;
    void         ResetEntryTime();

protected:
    // state logic done per tick - returns whether to exit the state or not
    virtual bool Update(time_point tick) = 0;
    virtual void UpdateTarget(uint16 targid);
    virtual void UpdateTarget(CBaseEntity* target);

    uint16     GetTargetID() const;
    void       Complete();
    time_point GetEntryTime() const;

    std::unique_ptr<CBasicPacket> m_errorMsg;

    CBaseEntity* const m_PEntity;
    uint16             m_targid{ 0 };

private:
    CBaseEntity* m_PTarget{ nullptr };
    bool         m_completed{ false };
    time_point   m_entryTime{ server_clock::now() };
};

#endif
