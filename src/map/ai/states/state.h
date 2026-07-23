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

#include "common/timer.h"
#include "entities/base_entity.h"
#include "packets/basic.h"
#include <memory>

class CBattleEntity;

class CStateInitException : public std::exception
{
public:
    explicit CStateInitException(std::unique_ptr<CBasicPacket> _msg);

    std::unique_ptr<CBasicPacket> packet;
};

class CState
{
public:
    CState(CBaseEntity* PEntity, uint16 _targid);

    virtual ~CState() = default;

    auto GetTarget() const -> CBaseEntity*;
    void SetTarget(uint16 targid);

    auto HasErrorMsg() const -> bool;
    auto GetErrorMsg() const -> std::unique_ptr<CBasicPacket>;

    auto DoUpdate(timer::time_point tick) -> bool;

    // try interrupt (on hit)
    virtual void TryInterrupt(CBattleEntity* PAttacker);

    // called when state completes
    virtual void Cleanup(timer::time_point tick) = 0;
    // whether the state can be changed by normal means
    virtual auto CanChangeState() -> bool = 0;
    virtual auto CanFollowPath() -> bool  = 0;
    // whether the state can be interrupted (including by stun/sleep)
    virtual auto CanInterrupt() -> bool = 0;
    auto         IsCompleted() const -> bool;
    void         ResetEntryTime();

protected:
    // state logic done per tick - returns whether to exit the state or not
    virtual auto Update(timer::time_point tick) -> bool = 0;
    virtual void UpdateTarget(uint16 targid);
    virtual void UpdateTarget(CBaseEntity* target);

    auto GetTargetID() const -> uint16;
    void Complete();
    auto GetEntryTime() const -> timer::time_point;

    std::unique_ptr<CBasicPacket> m_errorMsg;

    CBaseEntity* const m_PEntity;
    uint16             m_targid{ 0 };

private:
    CBaseEntity*      m_PTarget{ nullptr };
    bool              m_completed{ false };
    timer::time_point m_entryTime{ timer::now() };
};
