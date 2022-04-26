/*
===========================================================================

  Copyright (c) 2021 LandSandBoat Dev Teams

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

#include "moduleutils.h"

#include "../lua/luautils.h"
#include "common/cbasetypes.h"
#include "common/utils.h"

#include <filesystem>
#include <regex>
#include <string>
#include <vector>
#include <iostream>

namespace
{
    // static storage, init and access
    std::vector<CPPModule*>& cppModules()
    {
        static std::vector<CPPModule*> cppModules{};
        return cppModules;
    }
}

namespace moduleutils
{
    void RegisterCPPModule(CPPModule* ptr)
    {
        cppModules().emplace_back(ptr);
    }

    // Hooks for calling modules
    void OnInit()
    {
        TracyZoneScoped;
        for (auto* module : cppModules())
        {
            module->OnInit();
        }
    }

    void OnZoneTick(CZone* PZone)
    {
        TracyZoneScoped;
        for (auto* module : cppModules())
        {
            module->OnZoneTick(PZone);
        }
    }

    void OnTimeServerTick()
    {
        TracyZoneScoped;
        for (auto* module : cppModules())
        {
            module->OnTimeServerTick();
        }
    }

    void OnCharZoneIn(CCharEntity* PChar)
    {
        TracyZoneScoped;
        for (auto* module : cppModules())
        {
            module->OnCharZoneIn(PChar);
        }
    }

    void OnCharZoneOut(CCharEntity* PChar)
    {
        TracyZoneScoped;
        for (auto* module : cppModules())
        {
            module->OnCharZoneOut(PChar);
        }
    }

    struct Override
    {
        std::string              filename;
        std::string              overrideName;
        std::vector<std::string> nameParts;
        sol::object              func;
        bool                     applied;
    };

    // Lua-side Module
    // obj.name = name
    // obj.overrides = {}
    // obj.enabled = false

    std::vector<Override> overrides;

    void LoadLuaModules()
    {
        sol::state& lua = luautils::lua;

        // Load the helper file
        lua.script_file("./modules/module_utils.lua");

        // Load each module file that isn't the helpers.lua file
        for (auto const& entry : std::filesystem::recursive_directory_iterator("modules"))
        {
            auto path          = entry.path().relative_path();
            bool isHelpersFile = path.filename() == "module_utils.lua";

            if (!entry.is_directory() &&
                path.extension() == ".lua" &&
                !isHelpersFile)
            {
                std::string filename  = path.filename().generic_string();
                std::string relPath   = path.relative_path().generic_string();
                std::string pathNoExt = path.relative_path().replace_extension("").generic_string();

                // Execute the script once in "safe mode" to check it for syntax errors
                // lua.require_file will crash if it's given a bad script
                auto res = lua.safe_script_file(relPath);
                if (!res.valid())
                {
                    sol::error err = res;
                    ShowError("Failed to load module: %s", filename);
                    ShowError(err.what());
                    continue;
                }

                // Run for real
                sol::table table = lua.require_file(pathNoExt, relPath);
                if (table["enabled"])
                {
                    auto moduleName = table.get<std::string>("name");
                    ShowScript(fmt::format("=== Module: {} ===", moduleName));
                    for (auto& override : table.get<std::vector<sol::table>>("overrides"))
                    {
                        std::string name = override["name"];
                        sol::object func = override["func"];

                        ShowScript(fmt::format("Preparing override: {}", name));

                        auto parts = split(name, '.');
                        parts      = std::vector<std::string>(parts.begin() + 1, parts.end());

                        overrides.emplace_back(Override{ filename, name, parts, func, false });
                    }
                }
            }
        }
    }

    void TryApplyLuaModules()
    {
        sol::state& lua = luautils::lua;
        for (auto& override : overrides)
        {
            if (!override.applied)
            {
                sol::table table = lua["xi"].get<sol::table>();

                auto lastTable = *(override.nameParts.end() - 2);
                auto lastElem  = override.nameParts.back();
                for (auto& part : override.nameParts)
                {
                    table = table[part].get_or<sol::table>(sol::lua_nil);
                    if (table == sol::lua_nil)
                    {
                        break;
                    }

                    // Get parent table of the function at the end of the string
                    if (part == lastTable)
                    {
                        ShowScript(fmt::format("Applying override: {}", override.overrideName));

                        lua["applyOverride"](table, lastElem, override.func);

                        override.applied = true;
                    }
                }
            }
        }
    }

    void ReportLuaModuleUsage()
    {
        for (auto& override : overrides)
        {
            if (!override.applied)
            {
                ShowWarning("Override not applied: {} ({})", override.overrideName, override.filename);
            }
        }
    }
}; // namespace moduleutils
