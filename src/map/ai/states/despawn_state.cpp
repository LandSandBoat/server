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

#include "despawn_state.h"
#include "ai/ai_container.h"
#include "entities/baseentity.h"
#include "entities/mobentity.h"
#include "packets/entity_animation.h"
#include "zone.h"

CDespawnState::CDespawnState(CBaseEntity* _PEntity, bool instantDespawn)
: CState(_PEntity, _PEntity->targid)
{
    if (!instantDespawn && (_PEntity->status != STATUS_TYPE::DISAPPEAR && !(static_cast<CMobEntity*>(_PEntity)->m_Behavior & BEHAVIOR_NO_DESPAWN)))
    {
        _PEntity->loc.zone->PushPacket(_PEntity, CHAR_INRANGE, std::make_unique<CEntityAnimationPacket>(_PEntity, _PEntity, CEntityAnimationPacket::Fade_Out));
    }
}

bool CDespawnState::Update(time_point tick)
{
    if (tick > GetEntryTime() + 3s && !IsCompleted() && !(static_cast<CMobEntity*>(m_PEntity)->m_Behavior & BEHAVIOR_NO_DESPAWN))
    {
        static_cast<CMobEntity*>(m_PEntity)->OnDespawn(*this);
        Complete();
    }
    return IsCompleted();
}

void CDespawnState::Cleanup(time_point tick)
{
}

bool CDespawnState::CanChangeState()
{
    return false;
}
