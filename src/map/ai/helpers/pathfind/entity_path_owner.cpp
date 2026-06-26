/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include <map/ai/helpers/pathfind/entity_path_owner.h>

#include <map/ai/ai_container.h>

#include <map/entities/base_entity.h>
#include <map/entities/battle_entity.h>
#include <map/entities/mob_entity.h>

#include <map/lua/luautils.h>

#include <map/navmesh/navmesh.h>
#include <map/zone.h>

namespace pathfind
{

EntityPathOwner::EntityPathOwner(CBaseEntity* entity)
: entity_(entity)
{
}

auto EntityPathOwner::position() -> position_t&
{
    return entity_->loc.p;
}

auto EntityPathOwner::position() const -> const position_t&
{
    return entity_->loc.p;
}

auto EntityPathOwner::navMesh() -> NavMesh&
{
    return *entity_->loc.zone->navMesh();
}

auto EntityPathOwner::markPositionDirty() -> void
{
    entity_->updatemask |= UPDATE_POS;

    // The single chokepoint for pathfind repositions, keeping the zone's proximity grid current as the entity moves.
    if (entity_->loc.zone != nullptr)
    {
        entity_->loc.zone->onEntityMoved(entity_);
    }
}

auto EntityPathOwner::baseSpeed() const -> uint8
{
    return entity_->GetSpeed();
}

auto EntityPathOwner::updateSpeed(bool run) -> uint8
{
    return entity_->UpdateSpeed(run);
}

auto EntityPathOwner::isMobEntity() const -> bool
{
    return dynamic_cast<CMobEntity*>(entity_) != nullptr;
}

auto EntityPathOwner::isRoaming() const -> bool
{
    return entity_->PAI->IsRoaming();
}

auto EntityPathOwner::inWater() const -> bool
{
    const auto& pos     = entity_->loc.p;
    const auto  terrain = entity_->loc.zone->xiMesh()->getTerrainAt(pos.x, pos.y, pos.z);
    return terrain == TerrainType::ShallowWater || terrain == TerrainType::DeepWater;
}

auto EntityPathOwner::battleTargetPosition() const -> const position_t*
{
    if (auto* PBattleOwner = dynamic_cast<CBattleEntity*>(entity_))
    {
        if (auto* PTarget = PBattleOwner->GetBattleTarget())
        {
            return &PTarget->loc.p;
        }
    }
    return nullptr;
}

auto EntityPathOwner::onPathPoint() -> void
{
    luautils::OnPathPoint(entity_);
}

auto EntityPathOwner::onPathComplete() -> void
{
    luautils::OnPathComplete(entity_);
}

auto EntityPathOwner::name() const -> const std::string&
{
    return entity_->getName();
}

auto EntityPathOwner::id() const -> uint32
{
    return entity_->id;
}

} // namespace pathfind
