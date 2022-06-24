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
#include "tracy.h"
#include "utils.h"

#include <filesystem>
#include <stdexcept>
#include <string>
#include <variant>

namespace settings
{
    std::unordered_map<std::string, SettingsVariant_t> settingsMap;

    void network_settings_from_env()
    {
        lua["xi"]["settings"]["network"]["SQL_HOST"]     = std::getenv("XI_DB_HOST") ? std::getenv("XI_DB_HOST") : get<std::string>("network.SQL_HOST");
        lua["xi"]["settings"]["network"]["SQL_PORT"]     = std::getenv("XI_DB_PORT") ? std::stoi(std::getenv("XI_DB_PORT")) : get<uint16>("network.SQL_PORT");
        lua["xi"]["settings"]["network"]["SQL_LOGIN"]    = std::getenv("XI_DB_USER") ? std::getenv("XI_DB_USER") : get<std::string>("network.SQL_LOGIN");
        lua["xi"]["settings"]["network"]["SQL_PASSWORD"] = std::getenv("XI_DB_USER_PASSWD") ? std::getenv("XI_DB_USER_PASSWD") : get<std::string>("network.SQL_PASSWORD");
        lua["xi"]["settings"]["network"]["SQL_DATABASE"] = std::getenv("XI_DB_NAME") ? std::getenv("XI_DB_NAME") : get<std::string>("network.SQL_DATABASE");

        lua["xi"]["settings"]["network"]["ZMQ_IP"]   = std::getenv("XI_MSG_IP") ? std::getenv("XI_MSG_IP") : get<std::string>("network.ZMQ_IP");
        lua["xi"]["settings"]["network"]["ZMQ_PORT"] = std::getenv("XI_MSG_PORT") ? std::stoi(std::getenv("XI_MSG_PORT")) : get<uint16>("network.ZMQ_PORT");
    }

    /**
     * @brief
     * Load the settings Lua files found in <root>/settings/. Default settings are loaded first from <root>/settings/default/,
     * and are then replaced by the settings found in <root>/settings/, if any.
     */
    void init()
    {
        ShowInfo("Loading settings files");

        // Load defaults
        for (auto const& entry : std::filesystem::directory_iterator("./settings/default/"))
        {
            auto path     = std::filesystem::path(entry).relative_path();
            auto isLua    = path.extension() == ".lua";
            auto filename = path.string();
            auto key      = path.lexically_normal().replace_extension("").generic_string();

            if (isLua)
            {
                {
                    auto res = lua.safe_script_file(filename, &sol::script_pass_on_error);
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

        // Scrape defaults into cpp's settingsMap
        for (auto [outerKeyObj, outerValObj] : lua["xi"]["settings"].get<sol::table>())
        {
            auto outerKey = outerKeyObj.as<std::string>();

            for (auto [innerKeyObj, innerValObj] : outerValObj.as<sol::table>())
            {
                auto innerKey = innerKeyObj.as<std::string>();
                auto key      = to_upper(fmt::format("{}.{}", outerKey, innerKey));

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
        for (auto const& entry : std::filesystem::directory_iterator("./settings/"))
        {
            auto path     = std::filesystem::path(entry).relative_path();
            auto isLua    = path.extension() == ".lua";
            auto filename = path.string();
            auto key      = path.lexically_normal().replace_extension("").generic_string();

            if (isLua)
            {
                {
                    auto res = lua.safe_script_file(filename, &sol::script_pass_on_error);
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

        // Scrape user settings into cpp's settingsMap
        // This will overwrite the defaults, if user settings exist. Otherwise the
        // defaults will be left intact.
        for (auto [outerKeyObj, outerValObj] : lua["xi"]["settings"].get<sol::table>())
        {
            auto outerKey = outerKeyObj.as<std::string>();

            for (auto [innerKeyObj, innerValObj] : outerValObj.as<sol::table>())
            {
                auto innerKey = innerKeyObj.as<std::string>();
                auto key      = to_upper(fmt::format("{}.{}", outerKey, innerKey));

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

        // Push the consolidated defaults + user settings back up into xi.settings
        for (auto [key, value] : settingsMap)
        {
            auto parts                          = split(key, ".");
            auto outer                          = to_lower(parts[0]);
            auto inner                          = to_lower(parts[1]);
            lua["xi"]["settings"][outer][inner] = value;
        }

        // Test to ensure requires aren't trampling changes, and that the user's settings aren't reverting
        // to the defaults:
        //
        // lua.safe_script("require('settings/main'); require('settings/default/main'); print(xi.settings)");

        network_settings_from_env();
    }
} // namespace settings
