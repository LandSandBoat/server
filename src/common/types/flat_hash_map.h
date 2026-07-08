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

#include <ankerl/unordered_dense.h>

#include <functional>

//
// FlatHashMap
//
//   Unlike std::unordered_map, the keys/values here live in a single contiguous array
//   (no per-node heap allocation, no pointer chasing on lookup), which makes it a
//   good drop-in replacement on hot paths that key by an integer/enum/small type.
//   Amortized O(1) lookup/insert/erase, memory proportional to the number of
//   entries actually stored.
//
// Iteration & Invalidation:
//   - Iteration is highly efficient and happens in insertion order.
//   - IMPORTANT: Reallocations (via insert/emplace) invalidate all iterators, pointers,
//     and references.
//   - IMPORTANT: erase() invalidates iterators to the removed element AND the last element in the
//     underlying vector (as it uses a move-from-back strategy to maintain density).
//

// namespace xi
// {

template <typename Key,
          typename Value,
          typename Hash     = ankerl::unordered_dense::hash<Key>,
          typename KeyEqual = std::equal_to<Key>>
using FlatHashMap = ankerl::unordered_dense::map<Key, Value, Hash, KeyEqual>;

// } // namespace xi
