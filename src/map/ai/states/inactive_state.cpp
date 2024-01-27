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
#include "entities/battleentity.h"
#include "status_effect_container.h"

CInactiveState::CInactiveState(CBaseEntity* PEntity, duration _duration, bool canChangeState, bool untargetable)
: CState(PEntity, 0)
, m_duration(_duration)
, m_canChangeState(canChangeState)
, m_untargetable(untargetable)
{
    if (!canChangeState)
    {
        PEntity->PAI->InterruptStates();
    }
}

bool CInactiveState::Update(time_point tick)
{
    auto* PBattleEntity{ dynamic_cast<CBattleEntity*>(m_PEntity) };
    if (PBattleEntity && m_duration == 0ms)
    {
        if (PBattleEntity->isDead())
        {
            return true;
        }

        if (!PBattleEntity->StatusEffectContainer->HasPreventActionEffect() ||
            (PBattleEntity->StatusEffectContainer->HasStatusEffect({ EFFECT_CHARM, EFFECT_CHARM_II }) && !PBattleEntity->StatusEffectContainer->HasPreventActionEffect(true)))
        {
            return true;
        }
    }

    return m_duration > 0ms && tick > GetEntryTime() + m_duration;
}

void CInactiveState::Cleanup(time_point tick)
{
}
