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

#include <map/spatial_grid.h>

#include <map/entities/base_entity.h>

#include <algorithm>
#include <ranges>

SpatialGrid::SpatialGrid(const float cellSize)
: cellSize_(cellSize)
{
}

auto SpatialGrid::clear() -> void
{
    // Keep buckets allocated; just empty them so steady-state rebuilds avoid the allocator.
    for (auto& bucket : cells_ | std::views::values)
    {
        bucket.clear();
    }

    entityCells_.clear();
    size_ = 0;
}

auto SpatialGrid::removeFromCell(CBaseEntity* entity, const CellKey key) -> void
{
    const auto cit = cells_.find(key);
    if (cit == cells_.end())
    {
        return;
    }

    auto& bucket = cit->second;
    if (const auto it = std::ranges::find(bucket, entity); it != bucket.end())
    {
        // swap-with-last
        *it = bucket.back();
        bucket.pop_back();
    }
}

auto SpatialGrid::add(CBaseEntity* entity) -> void
{
    if (entity == nullptr)
    {
        return;
    }

    const auto key = cellKeyFor(entity->loc.p);
    cells_[key].push_back(entity);
    entityCells_[entity] = key;
    ++size_;
}

auto SpatialGrid::update(CBaseEntity* entity) -> void
{
    if (entity == nullptr)
    {
        return;
    }

    const auto newKey = cellKeyFor(entity->loc.p);
    const auto it     = entityCells_.find(entity);
    if (it == entityCells_.end())
    {
        // Not tracked yet (e.g. moved before the first resync) - file it now.
        cells_[newKey].push_back(entity);
        entityCells_.emplace(entity, newKey);
        ++size_;
        return;
    }

    if (it->second == newKey)
    {
        // still in the same cell
        return;
    }

    removeFromCell(entity, it->second);
    cells_[newKey].push_back(entity);
    it->second = newKey;
}

auto SpatialGrid::remove(CBaseEntity* entity) -> void
{
    if (entity == nullptr)
    {
        return;
    }

    const auto it = entityCells_.find(entity);
    if (it == entityCells_.end())
    {
        return;
    }

    removeFromCell(entity, it->second);
    entityCells_.erase(it);
    --size_;
}

auto SpatialGrid::size() const -> std::size_t
{
    return size_;
}

auto SpatialGrid::cellCount() const -> std::size_t
{
    return cells_.size();
}

auto SpatialGrid::cellKeyFor(const position_t& p) const -> CellKey
{
    return packKey(cellCoord(p.x), cellCoord(p.z));
}
