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

#include <string>

#include <common/lua.h>
#include <common/types/flat_hash_map.h>

// NOTE: We previously experimented with empty-handler elision here: using LuaJIT's bytecode
// introspection to detect stub handlers (`function() end` JIT-ing to a single `RET0` op),
// cache them as nil, and skip the C++ -> Lua call entirely on lookup.
//
// It was difficult and fiddly: several call sites use a handler's validity as an existence check
// or pass the handler onward as an Interaction Framework fallback, so eliding silently broke
// them (e.g. food items stopped applying stats) in ways that were hard to debug.
//
// Measured under an insane synthetic load (~5000 active status effects), the total saving was
// only ~0.25ms of main-loop time per second. Cool concept, but not worth the effort.

// Caches resolved Lua functions keyed by string (entity/spell/effect/file + function name).
class LuaCache final
{
public:
    // Look up by key. Returns the stored reference, or sol::lua_nil if the key is absent. For
    // callers that never store an invalid value, an invalid result is equivalent to "not cached".
    [[nodiscard]] auto find(const std::string& key) const -> sol::reference;

    // Negative-aware lookup. Returns a pointer to the stored reference (which may itself be an
    // invalid reference, representing a cached "not found"), or nullptr if the key was never
    // cached. The pointer is valid only until the next store()/clear().
    [[nodiscard]] auto findEntry(const std::string& key) const -> const sol::reference*;

    // Insert or overwrite the value for key. The value may be an invalid reference, to cache a
    // negative ("no such handler") result.
    void store(const std::string& key, sol::reference value);

    // Memoize a Lua function lookup. On a hit, returns the cached function (a negative entry --
    // a function that was looked up and not found -- is returned as a fresh nil, never the stored
    // stateless reference, since converting/pushing that crashes). On a miss, calls resolve()
    // once -- it must return the resolved sol::function or sol::lua_nil -- caches the result
    // (including the nil, so the miss is not repeated), and returns it.
    template <typename Resolver>
    auto getOrResolveFunction(const std::string& key, Resolver&& resolve) -> sol::function;

    // Drop all cached entries. Called on Lua file reload.
    void clear();

    // Reusable scratch buffer for building keys without per-call heap allocation. Lua is
    // single-threaded, so a single shared buffer is safe.
    [[nodiscard]] auto keyBuffer() -> std::string&;

private:
    FlatHashMap<std::string, sol::reference> entries_;
    std::string                              keyBuffer_;
};

//
// Template impls
//

template <typename Resolver>
auto LuaCache::getOrResolveFunction(const std::string& key, Resolver&& resolve) -> sol::function
{
    if (const auto* entry = findEntry(key))
    {
        if (!entry->valid())
        {
            return sol::lua_nil;
        }
        return *entry;
    }

    // Snapshot the key before resolving: callers build keys in a shared scratch buffer (see
    // keyBuffer()), and resolve() could build another key in it, leaving `key` clobbered for
    // the store() below. The copy only happens on a miss (once per key), so it is off the
    // hot path.
    const std::string keyCopy  = key;
    sol::function     resolved = resolve();
    store(keyCopy, resolved);
    return resolved;
}
