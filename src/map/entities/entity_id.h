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

#pragma once

#include "common/cbasetypes.h"
#include "common/types/maybe.h"

#include "data/enums/zone.h"

#include <type_traits>

enum ENTITYTYPE : uint8;
class CBaseEntity;

// A resolvable reference to an entity.
// Holds enough context to find the entity again at a later time in a safe fashion.
struct EntityId
{
    EntityId() = default;
    explicit EntityId(const CBaseEntity* PEntity);

    void clean();
    auto isSet() const -> bool;
    auto isDynamic() const -> bool;

    // Compare two entity IDs for equality. Dynamic entities use the auto-incrementing serial.
    auto operator==(const EntityId& other) const -> bool;
    auto operator==(const CBaseEntity* PEntity) const -> bool;

    uint32        UniqueNo{ 0 }; // "Long" global ID of the entity. Built from 0x10000000 | (zoneId << 16) | ActIndex. Formerly known as "id"
    uint16        ActIndex{ 0 }; // The "index" of the entity in the current zone. Used for local targeting and referencing. Formerly known as "targid".
    xi::ZoneId    zoneId{};      // Zone the entity was in when this reference was taken.
    Maybe<uint32> instanceRunId; // Live instance the entity was in, nullopt if it was not instanced.
    uint64        serial{ 0 };   // Never-reused per-process counter, telling a rebuilt entity from the one that held the slot before it. Only dynamic entities need it.
    ENTITYTYPE    objtype{ 0 };  // What kind of entity this is.

    // Look the entity up again, or nullptr if it is gone
    //
    //     if (auto* PTarget = target.resolve<CCharEntity>())
    //     {
    //         PTarget->doThing();
    //     }
    template <typename T = CBaseEntity>
    [[nodiscard]] auto resolve() const -> T*
    {
        if constexpr (std::is_same_v<T, CBaseEntity>)
        {
            return resolveEntity();
        }
        else
        {
            return dynamic_cast<T*>(resolveEntity());
        }
    }

private:
    auto resolveEntity() const -> CBaseEntity*;
};
