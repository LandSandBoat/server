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

#ifndef _SETTINGS_H
#define _SETTINGS_H

#include "logging.h"
#include "utils.h"

#include <string>
#include <type_traits>
#include <unordered_map>
#include <variant>

namespace settings
{
    // https://en.cppreference.com/w/cpp/utility/variant/visit
    // helper type for the visitor
    template <class... Ts>
    struct overloaded : Ts...
    {
        // cppcheck-suppress syntaxError
        using Ts::operator()...;
    };
    // explicit deduction guide (not needed as of C++20)
    template <class... Ts>
    overloaded(Ts...) -> overloaded<Ts...>;

    using SettingsVariant_t = std::variant<bool, double, std::string>;
    extern std::unordered_map<std::string, SettingsVariant_t> settingsMap;

    void init();

    /**
     * @brief
     * Get the value of a setting, based on a string key.
     *
     * @tparam T
     * The value type being requested. If not the original type, it will be gracefully converted.
     *
     * @param name
     * The name of the key being requested. It must be prefixed with the filename the setting is from.
     * For example: "settings/main.lua" contains "ENABLE_COP". You would request: "main.ENABLE_COP".
     * Therefore: bool val = settings::get<bool>("map.ENABLE_COP");
     * NOTE: These names are NOT case-sensitive.
     */
    template <typename T>
    T get(std::string name)
    {
        // out = type being requested
        T out{};

        auto key = to_upper(name);
        if (auto maybeResult = settingsMap.find(key); maybeResult != settingsMap.end())
        {
            // clang-format off
            auto& variant = (*maybeResult).second;

            // arg = type held inside the variant
            std::visit(
            overloaded{
                [&](bool const& arg)
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
                [&](double const& arg)
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
                [&](std::string const& arg)
                {
                    bool isTruthy = !arg.empty() && arg != "false" && arg != "0";
                    std::ignore = isTruthy;

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
            }, variant);
            return out;
            // clang-format on
        }

        ShowError(fmt::format("Settings: Failed to look up key: {}, using default value: \"{}\"", name, out));
        return T();
    }

    // A partial, core-only way to set settings.
    // Not suitable for regular use.
    //
    // TODO: Gracefully convert like-types into types for the variant
    // TODO: Publish back up into Lua
    void set(const auto& name, const auto& value)
    {
        const auto key   = to_upper(name);
        settingsMap[key] = SettingsVariant_t(value);
    }

    void visit(const std::function<void(std::string, SettingsVariant_t)>& visitor);
} // namespace settings

#endif // _SETTINGS_H
