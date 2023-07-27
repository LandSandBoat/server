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

#include "respawn_state.h"
#include "ai/ai_container.h"
#include "entities/baseentity.h"
#include "entities/mobentity.h"

CRespawnState::CRespawnState(CBaseEntity* _PEntity, duration spawnTime)
: CState(_PEntity, _PEntity->targid)
, m_spawnTime(spawnTime)
{
}

bool CRespawnState::Update(time_point tick)
{
    // make sure that the respawn time is up to date
    auto* PMob = dynamic_cast<CMobEntity*>(m_PEntity);
    if (PMob)
    {
        if (!PMob->m_AllowRespawn)
        {
            if (m_spawnTime > 0s)
            {
                m_spawnTime = 0s;
            }
        }
        else
        {
            if (std::chrono::milliseconds(PMob->m_RespawnTime) != m_spawnTime)
            {
                m_spawnTime = std::chrono::milliseconds(PMob->m_RespawnTime);
            }
        }
    }
    if (m_spawnTime > 0s && tick > GetEntryTime() + m_spawnTime)
    {
        m_PEntity->Spawn();
        return true;
    }
    return false;
}

void CRespawnState::Cleanup(time_point tick)
{
}

bool CRespawnState::CanChangeState()
{
    return false;
}
