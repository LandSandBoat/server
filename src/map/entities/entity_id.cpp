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

#include "entity_id.h"

#include "base_entity.h"
#include "instance.h"
#include "utils/zoneutils.h"
#include "zone.h"

EntityID_t::EntityID_t(const CBaseEntity* PEntity)
{
    if (PEntity == nullptr)
    {
        return;
    }

    id            = PEntity->id;
    targid        = PEntity->targid;
    zoneId        = PEntity->loc.zone ? static_cast<uint16>(PEntity->loc.zone->GetID()) : uint16{ 0 };
    instanceRunId = PEntity->PInstance ? PEntity->PInstance->runId() : uint32{ 0 };
    serial        = PEntity->serial();
    objtype       = PEntity->objtype;
}

void EntityID_t::clean()
{
    *this = EntityID_t{};
}

auto EntityID_t::isSet() const -> bool
{
    return targid != 0;
}

auto EntityID_t::isDynamic() const -> bool
{
    return targid >= 0x700;
}

auto EntityID_t::operator==(const EntityID_t& other) const -> bool
{
    return isDynamic() ? serial == other.serial : id == other.id;
}

auto EntityID_t::operator==(const CBaseEntity* PEntity) const -> bool
{
    if (PEntity == nullptr)
    {
        return !isSet();
    }

    return PEntity->IsDynamicEntity() ? serial == PEntity->serial() : id == PEntity->id;
}

auto EntityID_t::resolveEntity() const -> CBaseEntity*
{
    if (targid == 0 || serial == 0)
    {
        return nullptr;
    }

    CZone* PZone = zoneutils::GetZone(zoneId);
    if (PZone == nullptr)
    {
        return nullptr;
    }

    CBaseEntity* PEntity = nullptr;
    if (instanceRunId != 0)
    {
        auto* PInstance = zoneutils::GetInstanceByRunId(zoneId, instanceRunId);
        if (PInstance == nullptr)
        {
            return nullptr;
        }

        PEntity = PInstance->GetEntity(targid, objtype);
    }
    else
    {
        PEntity = PZone->GetEntity(targid, objtype);
    }

    // Verify that we retrieved the exact same entity (dynamic entities).
    if (PEntity == nullptr || *this != PEntity)
    {
        return nullptr;
    }

    return PEntity;
}
