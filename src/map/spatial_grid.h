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

#include <common/cbasetypes.h>
#include <common/mmo.h>
#include <common/types/flat_hash_map.h>

#include <cmath>
#include <vector>

class CBaseEntity;

// Uniform 2D (x/z) grid over a zone's entities. Cell size is the proximity radius, so a "within R"
// query touches a fixed 3x3 block of cells. The grid only narrows the candidate set - callers keep
// their own precise distance/vertical/status filters, so results match a full scan.
//
// Maintained incrementally: add() on enter, remove() on leave, update() on move (re-files only when
// the cell changes), so it stays current between ticks for consumers called at arbitrary times. A
// per-tick clear()+re-add resync is a cheap safety net for repositions that bypass the move hook.
class SpatialGrid
{
public:
    using CellKey = uint64;
    using Bucket  = std::vector<CBaseEntity*>;

    // cellSize defaults to the proximity radius (ENTITY_RENDER_DISTANCE), making a "within R" query a
    // 3x3 block. Smaller cells stay correct (forEachInRange widens the block via ceil(radius/cellSize))
    // but trade fewer over-fetched candidates for more cell lookups; measure before changing it.
    // TODO: confirm the client's real max draw distance (~30?) and track it here and in ENTITY_RENDER_DISTANCE.
    explicit SpatialGrid(float cellSize = 50.0f);

    auto clear() -> void;                     // empty buckets (keep capacity) and reset tracking
    auto add(CBaseEntity* entity) -> void;    // file at its current loc.p (non-owning)
    auto update(CBaseEntity* entity) -> void; // re-file if it crossed a cell; files it if untracked
    auto remove(CBaseEntity* entity) -> void; // pull from the grid (safe if absent)

    // Visit every entity in a cell within `radius` of `center` (2D x/z); caller applies precise filters.
    template <typename Func>
    auto forEachInRange(const position_t& center, float radius, Func&& fn) const -> void;

    [[nodiscard]] auto size() const -> std::size_t;
    [[nodiscard]] auto cellCount() const -> std::size_t;
    [[nodiscard]] auto cellKeyFor(const position_t& p) const -> CellKey;

private:
    [[nodiscard]] auto        cellCoord(float v) const -> int32;
    [[nodiscard]] static auto packKey(int32 cx, int32 cz) -> CellKey;
    // pull from a cell's bucket (swap-with-last)

    auto removeFromCell(CBaseEntity* entity, CellKey key) -> void;

    float                              cellSize_;
    FlatHashMap<CellKey, Bucket>       cells_;
    FlatHashMap<CBaseEntity*, CellKey> entityCells_; // where each entity is currently filed
    std::size_t                        size_ = 0;
};

//
// Template impls
//

template <typename Func>
auto SpatialGrid::forEachInRange(const position_t& center, const float radius, Func&& fn) const -> void
{
    const auto span = static_cast<int32>(std::ceil(radius / cellSize_));
    const auto ccx  = cellCoord(center.x);
    const auto ccz  = cellCoord(center.z);

    for (int32 dx = -span; dx <= span; ++dx)
    {
        for (int32 dz = -span; dz <= span; ++dz)
        {
            if (const auto it = cells_.find(packKey(ccx + dx, ccz + dz)); it != cells_.end())
            {
                for (const auto entity : it->second)
                {
                    fn(entity);
                }
            }
        }
    }
}

inline auto SpatialGrid::cellCoord(const float v) const -> int32
{
    return static_cast<int32>(std::floor(v / cellSize_));
}

inline auto SpatialGrid::packKey(const int32 cx, const int32 cz) -> CellKey
{
    return (static_cast<CellKey>(static_cast<uint32>(cx)) << 32) | static_cast<uint32>(cz);
}
