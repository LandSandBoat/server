/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

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

#include <common/logging.h>
#include <common/utils.h>
#include <common/xi.h>

#include <common/types/hash_map.h>
#include <common/types/variant.h>

#include <atomic>
#include <cstdint>
#include <functional>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>

namespace settings
{

using SettingsVariant = Variant<bool, double, std::string>;

namespace detail
{

// Bumped every time the settings are (re)loaded (settings::init) or mutated (settings::set).
// Cached reads compare against this with a single atomic load to detect staleness, so a
// hot-reload transparently invalidates every per-thread read cache.
extern std::atomic<uint64_t> generation;

} // namespace detail

// HashMap's string-keyed defaults are transparent: lookups accept a std::string_view
// directly, no temporary std::string on the hot path.
using SettingsMap = HashMap<std::string, SettingsVariant>;
extern SettingsMap settingsMap;

void init();

//
// @brief
// Get the value of a setting, based on a string key.
//
// @tparam T
// The value type being requested. If not the original type, it will be gracefully converted.
//
// @param key
// The name of the key being requested. It must be prefixed with the filename the setting is from.
// For example: "settings/main.lua" contains "ENABLE_COP". You would request: "main.ENABLE_COP".
// Therefore: bool val = settings::get<bool>("map.ENABLE_COP");
// NOTE: These names ARE case-sensitive.
//
template <typename T>
T getUncached(std::string_view key)
{
    // out = type being requested
    T out{};

    if (const auto maybeResult = settingsMap.find(key); maybeResult != settingsMap.end())
    {
        const auto& variant = maybeResult->second;

        // arg = type held inside the variant
        variant.visit(
            overload{
                [&](const bool& arg)
                {
                    if constexpr (std::is_same_v<T, bool>)
                    {
                        out = arg;
                    }
                    else if constexpr (std::is_floating_point_v<T>)
                    {
                        out = static_cast<double>(arg);
                    }
                    else if constexpr (std::is_integral_v<T> && std::is_signed_v<T>)
                    {
                        out = static_cast<int>(arg);
                    }
                    else if constexpr (std::is_integral_v<T> && std::is_unsigned_v<T>)
                    {
                        out = static_cast<unsigned int>(arg);
                    }
                    else if constexpr (std::is_same_v<T, std::string>)
                    {
                        out = std::string(arg ? "true" : "false");
                    }
                },
                [&](const double& arg)
                {
                    if constexpr (std::is_same_v<T, bool>)
                    {
                        out = static_cast<bool>(arg);
                    }
                    else if constexpr (std::is_floating_point_v<T>)
                    {
                        out = arg;
                    }
                    else if constexpr (std::is_integral_v<T> && std::is_signed_v<T>)
                    {
                        out = static_cast<int>(arg);
                    }
                    else if constexpr (std::is_integral_v<T> && std::is_unsigned_v<T>)
                    {
                        out = static_cast<unsigned int>(arg);
                    }
                    else if constexpr (std::is_same_v<T, std::string>)
                    {
                        out = fmt::format("{}", arg);
                    }
                },
                [&](const std::string& arg)
                {
                    bool isTruthy = !arg.empty() && arg != "false" && arg != "0";
                    std::ignore   = isTruthy;

                    if constexpr (std::is_same_v<T, bool>)
                    {
                        out = isTruthy;
                    }
                    else if constexpr (std::is_floating_point_v<T>)
                    {
                        out = static_cast<double>(isTruthy);
                    }
                    else if constexpr (std::is_integral_v<T> && std::is_signed_v<T>)
                    {
                        out = static_cast<int>(isTruthy);
                    }
                    else if constexpr (std::is_integral_v<T> && std::is_unsigned_v<T>)
                    {
                        out = static_cast<unsigned int>(isTruthy);
                    }
                    else if constexpr (std::is_same_v<T, std::string>)
                    {
                        out = arg;
                    }
                },
            });
        return out;
    }

    ShowError(fmt::format("Settings: Failed to look up key: {}, using default value: \"{}\"", key, out));
    return T();
}

template <typename T>
T get(std::string_view key)
{
    // One memo per (T, thread). Bounded by the number of distinct setting keys, so it never
    // grows unbounded. thread_local also means no locking and no contention with the reload thread
    // on a cache hit.
    static thread_local HashMap<std::string, std::pair<uint64_t, T>> cache;

    const uint64_t gen = detail::generation.load(std::memory_order_acquire);

    if (const auto it = cache.find(key); it != cache.end())
    {
        if (it->second.first == gen)
        {
            return it->second.second;
        }

        // Stale entry (settings were reloaded/mutated): refresh it in place.
        it->second.first  = gen;
        it->second.second = getUncached<T>(key);
        return it->second.second;
    }

    T value = getUncached<T>(key);
    cache.emplace(std::string(key), std::pair<uint64_t, T>{ gen, value });
    return value;
}

// A partial, core-only way to set settings.
// Not suitable for regular use.
//
// TODO: Gracefully convert like-types into types for the variant
// TODO: Publish back up into Lua
void set(const auto& key, const auto& value)
{
    settingsMap[key] = SettingsVariant(value);

    // Invalidate every per-thread read cache (see detail::generation).
    detail::generation.fetch_add(1, std::memory_order_release);
}

void visit(const Fn<void(std::string, SettingsVariant) const>& visitor);

} // namespace settings
