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
#include "entities/mob_entity.h"
#include "lua/lua_test_entity_assertions.h"
#include "test_common.h"

// Thin wrapper over CBaseEntity with assertions and some helpers.
CLuaTestEntity::CLuaTestEntity(Scheduler& scheduler, CBaseEntity* entity)
: CLuaBaseEntity(entity)
, scheduler_(scheduler)
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
        // We cannot co_await within a Lua binding - the suspension will obliterate the Lua stack.
        scheduler_.blockOnMainThread(
            mob->PAI->Tick(timer::now() + std::chrono::seconds(i)));
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
 *  Function: setLevelRange()
 *  Purpose : Fix the level a mob rolls when it spawns
 *  Example : mob:setLevelRange(28, 28)
 *  Notes   : Spawn() draws the level from [minLevel, maxLevel], so a mob with a
 *          : range gets different stats depending on the shared RNG stream.
 *          : Collapse the range to pin the stats.
 ************************************************************************/
void CLuaTestEntity::setLevelRange(const uint8 minLevel, const uint8 maxLevel) const
{
    auto* mob = dynamic_cast<CMobEntity*>(m_PBaseEntity);
    if (!mob)
    {
        TestError("setLevelRange() can only be called on mob entities, not on {}",
                  static_cast<uint8>(m_PBaseEntity->objtype));
        return;
    }

    if (minLevel == 0 || maxLevel < minLevel)
    {
        TestError("setLevelRange({}, {}) is not a valid level range for {}", minLevel, maxLevel, mob->getName());
        return;
    }

    mob->m_minLevel = minLevel;
    mob->m_maxLevel = maxLevel;
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
    SOL_REGISTER("setLevelRange", CLuaTestEntity::setLevelRange);
    SOL_READONLY("assert", CLuaTestEntity::assert_);
}
