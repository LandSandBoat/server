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
#include "entities/base_entity.h"
#include "entities/mob_entity.h"
#include "enums/four_cc.h"
#include "packets/s2c/0x038_schedulor.h"
#include "spawn_handler.h"
#include "zone.h"

CDespawnState::CDespawnState(CBaseEntity* PEntity, const bool instantDespawn)
: CState(PEntity, PEntity->targid)
, despawnTime_(timer::now() + (instantDespawn ? 0s : 3s))
{
    if (!instantDespawn && (PEntity->status != xi::Status::Disappear && !((static_cast<CMobEntity*>(PEntity)->m_Behavior & xi::Behavior::NoDespawn) != xi::Behavior::None)))
    {
        PEntity->loc.zone->PushPacket(PEntity, CHAR_INRANGE, std::make_unique<GP_SERV_COMMAND_SCHEDULOR>(PEntity, PEntity, FourCC::FadeOut));
    }

    if (auto* PMob = dynamic_cast<CMobEntity*>(PEntity); PMob && PMob->m_AllowRespawn && PMob->loc.zone != nullptr)
    {
        PMob->loc.zone->spawnHandler().registerForRespawn(PMob);
    }
}

auto CDespawnState::Update(const timer::time_point tick) -> bool
{
    if (!IsCompleted() && (static_cast<CMobEntity*>(m_PEntity)->m_Behavior & xi::Behavior::NoDespawn) == xi::Behavior::None)
    {
        if (tick >= despawnTime_)
        {
            static_cast<CMobEntity*>(m_PEntity)->OnDespawn(*this);
            Complete();
        }
    }
    return IsCompleted();
}

void CDespawnState::Cleanup(timer::time_point tick)
{
}

auto CDespawnState::CanChangeState() -> bool
{
    return false;
}

auto CDespawnState::CanFollowPath() -> bool
{
    return false;
}

auto CDespawnState::CanInterrupt() -> bool
{
    return false;
}
