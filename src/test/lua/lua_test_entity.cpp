/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "lua_test_entity.h"

#include "ai/ai_container.h"
#include "common/logging.h"
#include "common/lua.h"
#include "entities/mobentity.h"
#include "lua/lua_test_entity_assertions.h"
#include "map/zone.h"
#include "test_common.h"

// Thin wrapper over CBaseEntity with assertions and some helpers.
CLuaTestEntity::CLuaTestEntity(CBaseEntity* entity)
: CLuaBaseEntity(entity)
{
}

CLuaTestEntity::~CLuaTestEntity() = default;

/************************************************************************
 *  Function: setEntity()
 *  Purpose : Update the underlying entity pointer
 *  Example : entity:setEntity(newEntity)
 *  Notes   :
 ************************************************************************/
void CLuaTestEntity::setEntity(CBaseEntity* entity)
{
    m_PBaseEntity = entity;
}

/************************************************************************
 *  Function: despawn()
 *  Purpose : Despawn a mob entity
 *  Example : mob:despawn()
 ************************************************************************/
void CLuaTestEntity::despawn() const
{
    auto* mob = dynamic_cast<CMobEntity*>(m_PBaseEntity);
    if (!mob)
    {
        TestError("despawn() can only be called on mob entities, not on {}",
                  static_cast<uint8>(m_PBaseEntity->objtype));
        return;
    }

    // Kill the mob if it's alive to trigger death sequence
    if (mob->isAlive())
    {
        mob->Die();
    }

    mob->PAI->Despawn();

    // Full despawn is about 20s
    for (uint32 i = 0; i <= 20; ++i)
    {
        mob->PAI->Tick(timer::now() + std::chrono::seconds(i));
    }
}

/************************************************************************
 *  Function: respawn()
 *  Purpose : Respawn a dead mob entity
 *  Example : mob:respawn()
 ************************************************************************/
void CLuaTestEntity::respawn() const
{
    auto* mob = dynamic_cast<CMobEntity*>(m_PBaseEntity);
    if (!mob)
    {
        TestError("respawn() can only be called on mob entities, not on {}",
                  static_cast<uint8>(m_PBaseEntity->objtype));
        return;
    }

    despawn();

    // Respawn the mob
    mob->Spawn();

    if (!mob->isAlive())
    {
        TestError("Failed to respawn mob {}", mob->getName());
    }
}

/************************************************************************
 *  Function: assert_()
 *  Purpose : Get assertion helper for this entity
 *  Example : entity.assert:isAlive()
 ************************************************************************/
auto CLuaTestEntity::assert_() -> CLuaTestEntityAssertions
{
    return CLuaTestEntityAssertions(this);
}

void CLuaTestEntity::Register()
{
    SOL_USERTYPE_INHERIT("CTestEntity", CLuaTestEntity, CLuaBaseEntity);
    SOL_REGISTER("setEntity", CLuaTestEntity::setEntity);
    SOL_REGISTER("despawn", CLuaTestEntity::despawn);
    SOL_REGISTER("respawn", CLuaTestEntity::respawn);
    SOL_READONLY("assert", CLuaTestEntity::assert_);
}
