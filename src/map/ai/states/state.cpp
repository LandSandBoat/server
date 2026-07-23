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

#include "state.h"
#include "entities/base_entity.h"

CStateInitException::CStateInitException(std::unique_ptr<CBasicPacket> _msg)
: std::exception()
, packet(std::move(_msg))
{
}

void CState::TryInterrupt(CBattleEntity* PAttacker)
{
}

CState::CState(CBaseEntity* PEntity, const uint16 _targid)
: m_PEntity(PEntity)
, m_targid(_targid)
{
}

void CState::UpdateTarget(const uint16 targid)
{
    m_PTarget = m_PEntity->GetEntity(targid);
}

void CState::UpdateTarget(CBaseEntity* target)
{
    m_PTarget = target;
}

auto CState::GetTarget() const -> CBaseEntity*
{
    return m_PTarget;
}

auto CState::GetTargetID() const -> uint16
{
    return m_targid;
}

void CState::Complete()
{
    m_completed = true;
}

auto CState::GetEntryTime() const -> timer::time_point
{
    return m_entryTime;
}

void CState::ResetEntryTime()
{
    m_entryTime = timer::now();
}

void CState::SetTarget(const uint16 targid)
{
    if (!m_PTarget || targid != m_targid || (m_PTarget && m_PTarget->targid != targid))
    {
        m_targid = targid;
        UpdateTarget(targid);
    }
}

auto CState::HasErrorMsg() const -> bool
{
    return m_errorMsg != nullptr;
}

auto CState::GetErrorMsg() const -> std::unique_ptr<CBasicPacket>
{
    if (HasErrorMsg())
    {
        return m_errorMsg->copy();
    }

    ShowError("State attempted to get error message when error message was null");

    return std::unique_ptr<CBasicPacket>();
}

auto CState::DoUpdate(const timer::time_point tick) -> bool
{
    UpdateTarget(m_targid);
    return Update(tick);
}

auto CState::IsCompleted() const -> bool
{
    return m_completed;
}
