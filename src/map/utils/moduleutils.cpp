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
#include <ranges>
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
    std::string              overrideName;
    std::vector<std::string> nameParts;
    sol::object              func;
    bool                     applied{ false };
};

std::unordered_multimap<std::string, Override> overrides;

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
            DebugModules(fmt::format("Applying override: {}", override.overrideName));

            if (table[part] == sol::lua_nil)
            {
                DebugModules("Inserting empty function to override for: %s (%s)", override.overrideName, override.filename);
                table[part] = []()
                {
                };
            }
            else
            {
                DebugModules("Override target exists for: %s (%s)", override.overrideName, override.filename);
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
        }
    }

    // Cache zone -> port mapping for multi-process override filtering
    HashMap<std::string, uint16> zoneSettingsPorts;

    const auto rset = db::preparedStmt("SELECT name, zoneport FROM zone_settings");
    while (rset && rset->next())
    {
        zoneSettingsPorts[rset->get<std::string>("name")] = rset->get<uint16>("zoneport");
    }

    const auto currentPort = mapIPP.getPort() == 0 ? settings::get<uint16>("network.MAP_PORT") : mapIPP.getPort();

    for (const auto& entry : expandedList)
    {
        const auto path = std::filesystem::path(entry).relative_path();

        if (path.filename() == "module_utils.lua" || std::filesystem::is_directory(path) || path.extension() != ".lua")
        {
            continue;
        }

        const auto filename = path.filename().generic_string();
        const auto res      = lua.safe_script_file(path.generic_string());
        if (!res.valid())
        {
            const sol::error err = res;
            ShowError("Failed to load module: %s", filename);
            ShowError(err.what());
            continue;
        }

        if (res.get_type() != sol::type::table)
        {
            ShowError("Failed to load module: Invalid object returned from: %s", filename);
            continue;
        }

        const sol::table table = res;

        if (table["cmdprops"].valid() && table["onTrigger"].valid())
        {
            const auto commandName = path.stem().generic_string();
            ShowInfo(fmt::format("Registering module command: !{}", commandName));
            lua[sol::create_if_nil]["xi"]["commands"][commandName] = table;
            continue;
        }

        if (table["overrides"].valid())
        {
            const auto moduleName = table.get_or("name", std::string{});
            ShowInfo(fmt::format("=== Module: {} ===", moduleName));

            bool anyPortFiltered = false;

            const auto prevOverrideCount = overrides.size();
            for (auto& override : table.get_or("overrides", std::vector<sol::table>{}))
            {
                const auto name  = override["name"].get<std::string>();
                const auto func  = override["func"];
                const auto parts = split(name, ".");

                DebugModules(fmt::format("Preparing override: {}", name));

                // Multi-process: skip overrides targeting zones on a different port
                if (parts.size() >= 3 && parts[0] == "xi" && parts[1] == "zones")
                {
                    const auto& zoneName = parts[2];
                    const auto  portIt   = zoneSettingsPorts.find(zoneName);
                    if (portIt != zoneSettingsPorts.end() && portIt->second != currentPort)
                    {
                        DebugModules(fmt::format("{} exists on a different port ({}), skipping", zoneName, portIt->second));
                        anyPortFiltered = true;
                        continue;
                    }
                }

                overrides.emplace(name.substr(0, name.rfind('.')),
                                  Override{
                                      .filename     = filename,
                                      .overrideName = name,
                                      .nameParts    = parts,
                                      .func         = func,
                                  });
            }

            // Only warn if no overrides were added AND none were intentionally skipped
            // due to targeting zones on a different map process port.
            if (!anyPortFiltered && overrides.size() == prevOverrideCount)
            {
                ShowError("No overrides found in module: %s", filename);
            }

            // NOTE: This continue is for the expandedList loop
            // TODO: Flatten all of this surrounding logic so it's less fragile
            continue;
        }

        // TODO: Differentiate invalid table vs data-only table in modules directory
        // ShowError("Failed to find valid table fields in module: %s", filename);
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

    const size_t start     = (parts[0] == "globals") ? 1 : 0;
    const auto   lookupKey = fmt::format("xi.{}", fmt::join(parts.cbegin() + start, parts.cend(), "."));

    // Also try the bare filename stem for non-xi globals (e.g. utils, npcUtil convention files)
    const auto& bareKey = parts.back();

    const auto applyRange = [&](const std::string& key)
    {
        const auto [rangeBegin, rangeEnd] = overrides.equal_range(key);
        for (auto& [_, override] : std::ranges::subrange(rangeBegin, rangeEnd))
        {
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
    for (auto& [_, override] : overrides)
    {
        if (!override.applied)
        {
            applyOverride(lua, table, override, true);
        }
    }
}

void ReportLuaModuleUsage()
{
    for (const auto& [_, override] : overrides)
    {
        if (!override.applied)
        {
            ShowError(fmt::format("Override not applied: {} ({})", override.overrideName, override.filename));
        }
    }
}

}; // namespace moduleutils
