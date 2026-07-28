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

#include "inactive_state.h"
#include "ai/ai_container.h"
#include "entities/battle_entity.h"
#include "status_effect_container.h"

CInactiveState::CInactiveState(xi::Badge<CState>, CBaseEntity* PEntity, const timer::duration _duration, const bool canChangeState, const bool untargetable)
: CState(PEntity, PEntity->entityId())
, m_duration(_duration)
, m_canChangeState(canChangeState)
, m_untargetable(untargetable)
{
    // Capture constructor arguments into members and nothing else. All other logic goes into init().
}

auto CInactiveState::init() -> StateErrorOr<void>
{
    if (!m_canChangeState)
    {
        m_PEntity->PAI->InterruptStates();
    }

    return Success();
}

auto CInactiveState::Update(const timer::time_point tick) -> bool
{
    const auto* PBattleEntity{ dynamic_cast<CBattleEntity*>(m_PEntity) };
    if (PBattleEntity && m_duration == 0ms)
    {
        if (PBattleEntity->isDead())
        {
            return true;
        }

        if (!PBattleEntity->StatusEffectContainer->HasPreventActionEffect() ||
            (PBattleEntity->StatusEffectContainer->HasStatusEffect({ xi::StatusEffect::CharmI, xi::StatusEffect::CharmIi }) && !PBattleEntity->StatusEffectContainer->HasPreventActionEffect(true)))
        {
            return true;
        }
    }

    return m_duration > 0ms && tick > GetEntryTime() + m_duration;
}

void CInactiveState::Cleanup(timer::time_point tick)
{
}

auto CInactiveState::GetUntargetable() const -> bool
{
    return m_untargetable;
}

auto CInactiveState::CanChangeState() -> bool
{
    return m_canChangeState;
}

auto CInactiveState::CanFollowPath() -> bool
{
    return false;
}

auto CInactiveState::CanInterrupt() -> bool
{
    return false;
}
