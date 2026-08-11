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

#include "common/cbasetypes.h"
#include "common/utils.h"
#include "lua/luautils.h"

#include <common/types/hash_map.h>

#include <filesystem>
#include <fstream>
#include <string>
#include <unordered_set>

#include <fmt/ranges.h>

namespace
{

std::vector<CPPModule*>& cppModules()
{
    static std::vector<CPPModule*> cppModules{};
    return cppModules;
}

} // namespace

namespace moduleutils
{

namespace
{

struct Override
{
    std::string              filename;
    std::string              moduleName;
    std::string              overrideName;
    std::vector<std::string> nameParts;
    sol::object              func;
    bool                     enabled{ true };
    bool                     applied{ false };
};

// Keyed by the override's parent path. Per-key order is declaration order,
// which the apply step relies on for super chaining.
HashMap<std::string, std::vector<Override>> overrides;

auto applyOverride(sol::state& lua, sol::table table, Override& override, bool silent = false) -> bool
{
    if (override.nameParts.empty())
    {
        return false;
    }

    for (size_t i = 0; i < override.nameParts.size(); ++i)
    {
        const auto& part = override.nameParts[i];

        if (i == override.nameParts.size() - 1)
        {
            DebugModulesFmt("Applying override: {}", override.overrideName);

            if (table[part] == sol::lua_nil)
            {
                DebugModulesFmt("Inserting empty function to override for: {} ({})", override.overrideName, override.filename);
                table[part] = []()
                {
                };
            }
            else
            {
                DebugModulesFmt("Override target exists for: {} ({})", override.overrideName, override.filename);
            }

            const auto result = lua["applyOverride"](table, part, override.func, override.overrideName, override.filename);
            if (!result.valid())
            {
                const sol::error err = result;
                ShowError("applyOverride failed for %s: %s", override.overrideName, err.what());
                return false;
            }

            override.applied = true;
            return true;
        }

        table = table[part].get_or<sol::table>(sol::lua_nil);
        if (table == sol::lua_nil)
        {
            if (!silent)
            {
                ShowError("Cannot navigate to override path: %s (missing %s)", override.overrideName, part);
            }
            return false;
        }
    }
    return false;
}

void registerModule(const sol::table& moduleTable, const std::string& filename, const HashMap<std::string, uint16>& zoneSettingsPorts, uint16 currentPort)
{
    const auto moduleName = moduleTable.get_or("name", std::string{});

    // A non-boolean must not silently leave the module enabled.
    const auto enabledField = moduleTable.get<sol::optional<bool>>("enabled");
    if (!enabledField.has_value())
    {
        ShowErrorFmt("Module {} has a non-boolean 'enabled' field, skipping module ({})", moduleName, filename);
        return;
    }

    const auto moduleEnabled = enabledField.value();

    const auto stateSuffix = [&]() -> std::string_view
    {
        if (moduleEnabled)
        {
            return "";
        }

        return " (disabled)";
    }();

    ShowInfoFmt("=== Module: {}{} ===", moduleName, stateSuffix);

    auto declaredCount = size_t{ 0 };
    auto enabledCount  = size_t{ 0 };

    for (const auto& overrideTable : moduleTable.get_or("overrides", std::vector<sol::table>{}))
    {
        const auto nameField = overrideTable.get<sol::optional<std::string>>("name");
        if (!nameField.has_value() || nameField.value().empty())
        {
            ShowErrorFmt("Module {} declared an override with no target ({})", moduleName, filename);
            continue;
        }

        const auto&       name        = nameField.value();
        const sol::object func        = overrideTable["func"];
        const auto        caseEnabled = overrideTable.get_or("enabled", true);
        const auto        parts       = split(name, ".");

        ++declaredCount;

        auto enabled = moduleEnabled && caseEnabled;

        if (!moduleEnabled)
        {
            DebugModulesFmt("Declared override (skipped, module condition not met): {}", name);
        }
        else if (!caseEnabled)
        {
            // Lua supplies the reason; it is logged, not kept.
            const auto reason = overrideTable.get_or("reason", std::string{ "condition not met" });
            DebugModulesFmt("Declared override (skipped, {}): {}", reason, name);
        }

        // Multi-process: skip overrides targeting zones on a different port
        if (enabled && parts.size() >= 3 && parts[0] == "xi" && parts[1] == "zones")
        {
            const auto& zoneName = parts[2];
            const auto  portIt   = zoneSettingsPorts.find(zoneName);
            if (portIt != zoneSettingsPorts.end() && portIt->second != currentPort)
            {
                DebugModulesFmt("Declared override (skipped, {} runs on port {}): {}", zoneName, portIt->second, name);
                enabled = false;
            }
        }

        if (enabled)
        {
            DebugModulesFmt("Declared override: {}", name);
            ++enabledCount;
        }

        overrides[name.substr(0, name.rfind('.'))].emplace_back(Override{
            .filename     = filename,
            .moduleName   = moduleName,
            .overrideName = name,
            .nameParts    = parts,
            .func         = func,
            .enabled      = enabled,
        });
    }

    // Declaring no overrides is malformed whatever the condition evaluated to.
    // Declaring some and applying none is a normal configuration.
    if (declaredCount == 0)
    {
        ShowErrorFmt("No overrides declared in module: {} ({})", moduleName, filename);
    }
    else if (enabledCount == 0)
    {
        ShowInfoFmt("Module {}: {} overrides declared, none applied for this configuration", moduleName, declaredCount);
    }
}

} // namespace

void RegisterCPPModule(CPPModule* ptr)
{
    cppModules().emplace_back(ptr);
}

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

void OnPushPacket(CCharEntity* PChar, const std::unique_ptr<CBasicPacket>& packet)
{
    TracyZoneScoped;

    for (auto* module : cppModules())
    {
        module->OnPushPacket(PChar, packet);
    }
}

auto OnIncomingPacket(MapSession* PSession, CCharEntity* PChar, CBasicPacket& packet) -> bool
{
    TracyZoneScoped;

    for (auto* module : cppModules())
    {
        if (module->OnIncomingPacket(PSession, PChar, packet))
        {
            return true;
        }
    }

    return false;
}

void LoadLuaModules(IPP mapIPP)
{
    lua.safe_script_file("./modules/module_utils.lua");

    // Read module list from init.txt
    std::vector<std::string> list;
    {
        std::ifstream file("./modules/init.txt", std::ios_base::in);
        std::string   line;
        while (std::getline(file, line))
        {
            if (!line.empty() && line[0] != '#' && line != "\n" && line != "\r" && line != "\r\n")
            {
                list.emplace_back(trim("./modules/" + line, " \t\r\n"));
            }
        }
    }

    // Expand directories into individual file paths
    std::vector<std::string> expandedList = list;
    for (const auto& entry : list)
    {
        if (std::filesystem::is_directory(entry))
        {
            for (const auto& innerEntry : sorted_directory_iterator<std::filesystem::recursive_directory_iterator>(entry))
            {
                expandedList.emplace_back(innerEntry.relative_path().generic_string());
            }

            continue;
        }

        // A stale init.txt line used to load silently as if it asked for nothing.
        if (!std::filesystem::exists(entry))
        {
            ShowErrorFmt("init.txt entry does not exist: {}", entry);
        }
    }

    // Cache zone -> port mapping for multi-process override filtering
    HashMap<std::string, uint16> zoneSettingsPorts;

    const auto rset = db::preparedStmt("SELECT name, zoneport FROM zone_settings");
    while (rset && rset->next())
    {
        zoneSettingsPorts[rset->get<std::string>("name")] = rset->get<uint16>("zoneport");
    }

    const auto currentPort = [&]() -> uint16
    {
        if (mapIPP.getPort() == 0)
        {
            return settings::get<uint16>("network.MAP_PORT");
        }

        return mapIPP.getPort();
    }();

    // Module files self-register; their return values are ignored.
    for (const auto& entry : expandedList)
    {
        const auto path = std::filesystem::path(entry).relative_path();

        if (path.filename() == "module_utils.lua" || std::filesystem::is_directory(path) || path.extension() != ".lua")
        {
            continue;
        }

        const auto filename = path.filename().generic_string();

        // Per file, so a file that errors cannot leak state into the next one.
        ClearLuaModuleRegistries();

        const auto res = lua.safe_script_file(path.generic_string());
        if (!res.valid())
        {
            const sol::error err = res;
            ShowError("Failed to load module: %s", filename);
            ShowError(err.what());
            continue;
        }

        const sol::table moduleRegistry  = lua["xi"]["module"]["registry"];
        const sol::table commandRegistry = lua["xi"]["module"]["commandRegistry"];

        if (moduleRegistry.size() == 0 && commandRegistry.size() == 0)
        {
            // The old interface returned the command table instead of
            // registering it, and would otherwise vanish silently.
            if (res.get_type() == sol::type::table)
            {
                const sol::table returned = res;
                if (returned["cmdprops"].valid() && returned["onTrigger"].valid())
                {
                    ShowError("Command module returns a table instead of calling xi.module.registerCommand: %s", filename);
                    continue;
                }
            }

            // Anything else registering nothing is a data or helper file.
            DebugModulesFmt("File registered no modules or commands (library/data file): {}", filename);
            continue;
        }

        for (auto i = size_t{ 1 }; i <= commandRegistry.size(); ++i)
        {
            const auto entryTable = commandRegistry[i].get<sol::optional<sol::table>>();
            if (!entryTable.has_value())
            {
                ShowError("Malformed entry in command registry: %s", filename);
                continue;
            }

            const auto commandName = entryTable.value().get<sol::optional<std::string>>("name");
            if (!commandName.has_value())
            {
                ShowError("Command registered with no name: %s", filename);
                continue;
            }

            ShowInfoFmt("Registering module command: !{}", commandName.value());
            lua[sol::create_if_nil]["xi"]["commands"][commandName.value()] = entryTable.value()["command"];
        }

        for (auto i = size_t{ 1 }; i <= moduleRegistry.size(); ++i)
        {
            const auto moduleTable = moduleRegistry[i].get<sol::optional<sol::table>>();
            if (!moduleTable.has_value())
            {
                ShowError("Malformed entry in module registry: %s", filename);
                continue;
            }

            registerModule(moduleTable.value(), filename, zoneSettingsPorts, currentPort);
        }
    }

    ClearLuaModuleRegistries();
}

void ClearLuaModuleRegistries()
{
    // Emptied in place, so any handle held elsewhere stays valid.
    const auto result = lua.safe_script("for i = #xi.module.registry, 1, -1 do xi.module.registry[i] = nil end "
                                        "for i = #xi.module.commandRegistry, 1, -1 do xi.module.commandRegistry[i] = nil end");
    if (!result.valid())
    {
        const sol::error err = result;
        ShowError("Failed to clear module registries: %s", err.what());
    }
}

void CleanupLuaModules()
{
    overrides.clear();
}

auto GetDataModules(const std::string_view name, const std::string_view extension) -> std::vector<std::string>
{
    std::vector<std::string> modules;
    std::ifstream            file("./modules/init.txt", std::ios_base::in);
    if (!file)
    {
        return modules;
    }

    std::unordered_set<std::string> seenModules;
    std::string                     line;
    while (std::getline(file, line))
    {
        const auto trimmed = trim(line, " \t\r\n");
        if (trimmed.empty() || trimmed[0] == '#')
        {
            continue;
        }

        std::string moduleName = trimmed;
        if (const auto slash = moduleName.find('/'); slash != std::string::npos)
        {
            moduleName.resize(slash);
        }

        if (!seenModules.insert(moduleName).second)
        {
            continue;
        }

        const auto modulePath = fmt::format("./modules/{}/data/{}{}", moduleName, name, extension);
        if (std::filesystem::exists(modulePath))
        {
            modules.emplace_back(modulePath);
        }
    }

    return modules;
}

void TryApplyLuaModules(const std::vector<std::string>& parts, bool isReload)
{
    if (parts.empty())
    {
        return;
    }

    const auto start = [&]() -> size_t
    {
        if (parts[0] == "globals")
        {
            return 1;
        }

        return 0;
    }();

    const auto lookupKey = fmt::format("xi.{}", fmt::join(parts.cbegin() + start, parts.cend(), "."));

    // Also try the bare filename stem for non-xi globals (e.g. utils, npcUtil convention files)
    const auto& bareKey = parts.back();

    const auto applyRange = [&](const std::string& key)
    {
        const auto it = overrides.find(key);
        if (it == overrides.end())
        {
            return;
        }

        for (auto& override : it->second)
        {
            if (!override.enabled)
            {
                continue;
            }

            if (isReload)
            {
                override.applied = false;
            }

            if (!override.applied)
            {
                auto table = lua["_G"];
                applyOverride(lua, table, override);
            }
        }
    };

    applyRange(lookupKey);
    if (bareKey != lookupKey)
    {
        applyRange(bareKey);
    }
}

void TryApplyRemainingLuaModules()
{
    auto table = lua["_G"];
    for (auto& [_, keyOverrides] : overrides)
    {
        for (auto& override : keyOverrides)
        {
            if (override.enabled && !override.applied)
            {
                applyOverride(lua, table, override, true);
            }
        }
    }
}

void ReportLuaModuleUsage()
{
    for (const auto& [_, keyOverrides] : overrides)
    {
        for (const auto& override : keyOverrides)
        {
            if (override.enabled && !override.applied)
            {
                ShowErrorFmt("Override not applied: {} (module {}, {})", override.overrideName, override.moduleName, override.filename);
            }
        }
    }
}

}; // namespace moduleutils
