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

#include "settings.h"

#include "logging.h"
#include "lua.h"
#include "utils.h"

#include <filesystem>
#include <stdexcept>
#include <string>
#include <variant>

namespace settings
{

SettingsMap settingsMap;

namespace
{

auto deepCopyTable(const sol::table& source) -> sol::table
{
    auto copy = lua.create_table();
    for (const auto& [key, value] : source)
    {
        if (value.get_type() == sol::type::table)
        {
            copy.set(key, deepCopyTable(value.as<sol::table>()));
        }
        else
        {
            copy.set(key, value);
        }
    }

    return copy;
}

auto isSequence(const sol::table& table) -> bool
{
    for (const auto& [key, value] : table)
    {
        if (key.get_type() != sol::type::number)
        {
            return false;
        }
    }

    return true;
}

void fillMissingKeys(const sol::table& defaults, sol::table target, int depth)
{
    constexpr int fileDepth = 1;

    for (const auto& [key, defaultValue] : defaults)
    {
        const auto isTable = defaultValue.get_type() == sol::type::table;
        if (!isTable && depth <= fileDepth)
        {
            continue;
        }

        const auto existing = target.get<sol::object>(key);
        if (!existing.valid())
        {
            target.set(key, defaultValue);
            continue;
        }

        if (!isTable)
        {
            continue;
        }

        const auto defaultTable = defaultValue.as<sol::table>();
        if (existing.get_type() == sol::type::table && !isSequence(defaultTable))
        {
            fillMissingKeys(defaultTable, existing.as<sol::table>(), depth + 1);
        }
    }
}

} // namespace

namespace detail
{

std::atomic<uint64_t> generation{ 0 };

} // namespace detail

// We need this to figure out which environment variables are numbers
// so we can pass them to the lua settings properly typed.
bool isNumber(const std::string& stringValue)
{
    for (const char c : stringValue)
    {
        if (std::isdigit(c) == 0)
        {
            return false;
        }
    }

    return true;
}

//
// @brief
// Load the settings Lua files found in <root>/settings/. Default settings are loaded first from <root>/settings/default/,
// and are then replaced by the settings found in <root>/settings/, if any.
//
void init()
{
    // Load defaults
    for (const auto& entry : sorted_directory_iterator<std::filesystem::directory_iterator>("./settings/default/"))
    {
        auto path     = entry.relative_path();
        auto isLua    = path.extension() == ".lua";
        auto filename = path.string();
        auto key      = path.lexically_normal().replace_extension("").generic_string();

        if (isLua)
        {
            {
                auto res = lua.safe_script_file(filename);
                if (!res.valid())
                {
                    sol::error err = res;

                    auto errorString = fmt::format("Error parsing settings file: {}\n{}", filename, err.what());
                    ShowCritical(errorString.c_str());
                    throw std::runtime_error(errorString);
                }
            }

            {
                // `require()` the file first, so it can be cached, and won't overwrite our settings later
                // TODO: Why is using lua.require_file(key, filename) such a struggle?
                auto res = lua.safe_script(fmt::format(R"(package.loaded["{}"] = nil; require("{}");)", key, key));
                if (!res.valid())
                {
                    sol::error err = res;

                    auto errorString = fmt::format("{}", err.what());
                    ShowCritical(errorString.c_str());
                    throw std::runtime_error(errorString);
                }
            }
        }
    }

    const auto defaultSettings = deepCopyTable(lua["xi"]["settings"].get<sol::table>());

    // Scrape defaults into cpp's settingsMap
    for (const auto& [outerKeyObj, outerValObj] : lua["xi"]["settings"].get<sol::table>())
    {
        auto outerKey = outerKeyObj.as<std::string>();

        for (const auto& [innerKeyObj, innerValObj] : outerValObj.as<sol::table>())
        {
            auto innerKey = innerKeyObj.as<std::string>();
            // Stored verbatim: settings::get is case-sensitive, and call sites use the
            // conventional "<file>.<SETTING_NAME>" casing, so the key must match exactly.
            auto key = fmt::format("{}.{}", outerKey, innerKey);

            if (innerValObj.is<bool>())
            {
                settingsMap[key] = innerValObj.as<bool>();
            }
            else if (innerValObj.is<double>())
            {
                settingsMap[key] = innerValObj.as<double>();
            }
            else if (innerValObj.is<std::string>())
            {
                settingsMap[key] = innerValObj.as<std::string>();
            }
        }
    }

    // Load user settings
    for (const auto& entry : sorted_directory_iterator<std::filesystem::directory_iterator>("./settings/"))
    {
        auto path     = entry.relative_path();
        auto isLua    = path.extension() == ".lua";
        auto filename = path.string();
        auto key      = path.lexically_normal().replace_extension("").generic_string();

        if (isLua)
        {
            {
                auto res = lua.safe_script_file(filename);
                if (!res.valid())
                {
                    sol::error err = res;

                    auto errorString = fmt::format("Error parsing settings file: {}\n{}", filename, err.what());
                    ShowCritical(errorString.c_str());
                    throw std::runtime_error(errorString);
                }
            }

            {
                // `require()` the file first, so it can be cached, and won't overwrite our settings later
                // TODO: Why is using lua.require_file(key, filename) such a struggle?
                auto res = lua.safe_script(fmt::format(R"(package.loaded["{}"] = nil; require("{}");)", key, key));
                if (!res.valid())
                {
                    sol::error err = res;

                    auto errorString = fmt::format("{}", err.what());
                    ShowCritical(errorString.c_str());
                    throw std::runtime_error(errorString);
                }
            }
        }
    }

    fillMissingKeys(defaultSettings, lua["xi"]["settings"].get<sol::table>(), 0);

    // Scrape user settings into cpp's settingsMap
    // This will overwrite the defaults, if user settings exist. Otherwise the
    // defaults will be left intact.
    for (const auto& [outerKeyObj, outerValObj] : lua["xi"]["settings"].get<sol::table>())
    {
        auto outerKey = outerKeyObj.as<std::string>();

        for (const auto& [innerKeyObj, innerValObj] : outerValObj.as<sol::table>())
        {
            auto innerKey = innerKeyObj.as<std::string>();
            // Stored verbatim: settings::get is case-sensitive, and call sites use the
            // conventional "<file>.<SETTING_NAME>" casing, so the key must match exactly.
            auto key = fmt::format("{}.{}", outerKey, innerKey);

            if (innerValObj.is<bool>())
            {
                settingsMap[key] = innerValObj.as<bool>();
            }
            else if (innerValObj.is<double>())
            {
                settingsMap[key] = innerValObj.as<double>();
            }
            else if (innerValObj.is<std::string>())
            {
                settingsMap[key] = innerValObj.as<std::string>();
            }

            // Apply any environment variables over the default/user settings.
            auto envKey = fmt::format("XI_{}_{}", to_upper(outerKey), to_upper(innerKey));

            // If we try to assign this value in the if() statement, it will
            // come back as a bool, so we have to check only then assign in the
            // block.
            if (std::getenv(envKey.c_str()))
            {
                auto value = std::string(trim(std::getenv(envKey.c_str())));
                ShowInfo(fmt::format("Applying ENV VAR {} to {}", envKey, key));

                // If we don't convert the PORTS to doubles (or ints), then the LUA
                // doesn't interpret them correctly and it breaks everything.
                // Therefor we need to check if the value is a number.
                if (isNumber(value))
                {
                    settingsMap[key] = std::stod(value);
                }
                else
                {
                    settingsMap[key] = value;
                }
            }
        }
    }

    // Push the consolidated defaults + user settings back up into xi.settings.
    // Push the held alternative, not the variant itself: sol only auto-unwraps
    // std::variant exactly, and SettingsVariant is our derived Variant - assigning
    // it directly would land in Lua as opaque userdata.
    for (const auto& [key, value] : settingsMap)
    {
        auto parts = split(key, ".");
        auto outer = to_lower(parts[0]);
        auto inner = to_upper(parts[1]);
        value.visit([&](const auto& held)
                    {
                        lua["xi"]["settings"][outer][inner] = held;
                    });
    }

    detail::generation.fetch_add(1, std::memory_order_release);

    logging::SetPattern(get<std::string>("logging.PATTERN"));

    // Test to ensure requires aren't trampling changes, and that the user's settings aren't reverting
    // to the defaults:
    //
    // lua.safe_script("require('settings/main'); require('settings/default/main'); print(xi.settings)");
}

void visit(const Fn<void(std::string, SettingsVariant) const>& visitor)
{
    for (auto& [key, value] : settingsMap)
    {
        visitor(key, value);
    }
}

} // namespace settings
