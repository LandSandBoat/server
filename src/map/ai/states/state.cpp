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

void CState::TryInterrupt(CBattleEntity* PAttacker)
{
}

CState::CState(CBaseEntity* PEntity, const EntityId& target)
: m_PEntity(PEntity)
, target_(target)
{
}

void CState::UpdateTarget(const EntityId& target)
{
}

auto CState::target() const -> EntityId
{
    return target_;
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

void CState::SetTarget(const EntityId& target)
{
    if (!target_.isSet() || target_ != target)
    {
        target_ = target;
        UpdateTarget(target);
    }
}

auto CState::refuseWithErrorMsg() const -> Error<std::unique_ptr<CBasicPacket>>
{
    if (m_errorMsg)
    {
        return Error{ m_errorMsg->copy() };
    }

    // The check failed but left no reason behind.
    return RefuseSilently();
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
    UpdateTarget(target_);
    return Update(tick);
}

auto CState::IsCompleted() const -> bool
{
    return m_completed;
}
