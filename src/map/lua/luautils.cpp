/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "../../common/showmsg.h"
#include "../../common/utils.h"
#include "../../common/version.h"

#include <array>
#include <filesystem>
#include <optional>
#include <string>
#include <unordered_map>

#include "lua_action.h"
#include "lua_battlefield.h"
#include "lua_instance.h"
#include "lua_item.h"
#include "lua_mobskill.h"
#include "lua_region.h"
#include "lua_spell.h"
#include "lua_statuseffect.h"
#include "lua_trade_container.h"
#include "lua_zone.h"
#include "luautils.h"

#include "../ability.h"
#include "../ai/ai_container.h"
#include "../ai/states/ability_state.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/death_state.h"
#include "../ai/states/inactive_state.h"
#include "../ai/states/item_state.h"
#include "../ai/states/magic_state.h"
#include "../ai/states/mobskill_state.h"
#include "../ai/states/raise_state.h"
#include "../ai/states/range_state.h"
#include "../ai/states/respawn_state.h"
#include "../ai/states/weaponskill_state.h"
#include "../alliance.h"
#include "../battlefield.h"
#include "../conquest_system.h"
#include "../daily_system.h"
#include "../entities/automatonentity.h"
#include "../entities/baseentity.h"
#include "../entities/charentity.h"
#include "../entities/mobentity.h"
#include "../instance.h"
#include "../items/item_puppet.h"
#include "../map.h"
#include "../mobskill.h"
#include "../packets/action.h"
#include "../packets/char_emotion.h"
#include "../packets/char_update.h"
#include "../packets/entity_update.h"
#include "../packets/entity_visual.h"
#include "../packets/menu_raisetractor.h"
#include "../party.h"
#include "../roe.h"
#include "../spell.h"
#include "../status_effect_container.h"
#include "../timetriggers.h"
#include "../transport.h"
#include "../utils/battleutils.h"
#include "../utils/charutils.h"
#include "../utils/itemutils.h"
#include "../utils/zoneutils.h"
#include "../vana_time.h"
#include "../weapon_skill.h"

// TODO: Fix path
#include "../../ext/filewatch/filewatch/FileWatch.hpp"
std::unique_ptr<filewatch::FileWatch<std::string>> watch = nullptr;

namespace luautils
{
    sol::state lua;
    lua_State* LuaHandle = nullptr;

    bool                                  contentRestrictionEnabled;
    std::unordered_map<std::string, bool> contentEnabledMap;

    std::mutex                    reloadListBottleneck;
    std::map<std::string, uint64> toReloadList;
    std::vector<std::string>      filteredList;
    void                          SafeApplyFunc_ReloadList(std::function<void(std::map<std::string, uint64>&)> func)
    {
        std::lock_guard bottleneck(reloadListBottleneck);
        func(toReloadList);
    }

    /************************************************************************
     *                                                                       *
     *  Инициализация lua, пользовательских классов и глобальных функций     *
     *                                                                       *
     ************************************************************************/

    int32 init()
    {
        TracyZoneScoped;
        ShowStatus("luautils::init:lua initializing...");

        lua = sol::state();
        lua.open_libraries();

        // Compatability with old style
        LuaHandle = lua.lua_state();

        // Globally require bit library
        lua.do_string("if not bit then bit = require('bit') end");

        // Bind print() and math.random() globally
        lua["print"] = sol::overload(&luautils::print<double>, &luautils::print<std::string>, &luautils::print<bool>);

        // clang-format off
        lua["math"]["random"] =
            sol::overload([]() { return xirand::GetRandomNumber(1.0f); },
                          [](int n) { return xirand::GetRandomNumber<int>(1, n); },
                          [](float n) { return xirand::GetRandomNumber<float>(0.0f, n); },
                          [](int n, int m) { return xirand::GetRandomNumber<int>(n, m + 1); },
                          [](float n, float m) { return xirand::GetRandomNumber<float>(n, m); });
        // clang-format on

        // Get-or-create xi.core
        auto xi      = lua["xi"].get_or_create<sol::table>();
        auto xi_core = xi["core"].get_or_create<sol::table>();

        // Set functions in both global namespace and as part of xi.core
        // Example:
        // set_function("getNPCByID", &luautils::GetNPCByID);
        // -> GetNPCByID() or xi.core.getNPCByID()
        auto set_function = [&](std::string name, auto&& func) {
            auto lowerName = name;
            auto upperName = name;

            lowerName[0] = std::tolower(lowerName[0]);
            upperName[0] = std::toupper(upperName[0]);

            xi_core.set_function(lowerName, func);
            lua.set_function(upperName, func);
        };

        set_function("garbageCollectStep", &luautils::garbageCollectStep);
        set_function("garbageCollectFull", &luautils::garbageCollectFull);
        set_function("GetZone", &luautils::GetZone);
        set_function("getNPCByID", &luautils::GetNPCByID);
        set_function("getMobByID", &luautils::GetMobByID);
        set_function("weekUpdateConquest", &luautils::WeekUpdateConquest);
        set_function("getRegionOwner", &luautils::GetRegionOwner);
        set_function("getRegionInfluence", &luautils::GetRegionInfluence);
        set_function("getNationRank", &luautils::GetNationRank);
        set_function("getConquestBalance", &luautils::GetConquestBalance);
        set_function("isConquestAlliance", &luautils::IsConquestAlliance);
        set_function("spawnMob", &luautils::SpawnMob);
        set_function("despawnMob", &luautils::DespawnMob);
        set_function("getPlayerByName", &luautils::GetPlayerByName);
        set_function("getPlayerByID", &luautils::GetPlayerByID);
        set_function("getMagianTrial", &luautils::GetMagianTrial);
        set_function("getMagianTrialsWithParent", &luautils::GetMagianTrialsWithParent);
        set_function("jstMidnight", &luautils::JstMidnight);
        set_function("jstWeekday", &luautils::JstWeekday);
        set_function("vanadielTime", &luautils::VanadielTime);
        set_function("vanadielTOTD", &luautils::VanadielTOTD);
        set_function("vanadielHour", &luautils::VanadielHour);
        set_function("vanadielMinute", &luautils::VanadielMinute);
        set_function("vanadielDayOfTheWeek", &luautils::VanadielDayOfTheWeek);
        set_function("vanadielDayOfTheMonth", &luautils::VanadielDayOfTheMonth);
        set_function("vanadielDayOfTheYear", &luautils::VanadielDayOfTheYear);
        set_function("vanadielYear", &luautils::VanadielYear);
        set_function("vanadielMonth", &luautils::VanadielMonth);
        set_function("vanadielUniqueDay", &luautils::VanadielUniqueDay);
        set_function("vanadielDayElement", &luautils::VanadielDayElement);
        set_function("vanadielMoonPhase", &luautils::VanadielMoonPhase);
        set_function("vanadielMoonDirection", &luautils::VanadielMoonDirection);
        set_function("vanadielRSERace", &luautils::VanadielRSERace);
        set_function("vanadielRSELocation", &luautils::VanadielRSELocation);
        set_function("setVanadielTimeOffset", &luautils::SetVanadielTimeOffset);
        set_function("isMoonNew", &luautils::IsMoonNew);
        set_function("isMoonFull", &luautils::IsMoonFull);
        set_function("runElevator", &luautils::StartElevator);
        set_function("getServerVariable", &luautils::GetServerVariable);
        set_function("setServerVariable", &luautils::SetServerVariable);
        set_function("clearVarFromAll", &luautils::ClearVarFromAll);
        set_function("sendEntityVisualPacket", &luautils::SendEntityVisualPacket);
        set_function("updateServerMessage", &luautils::UpdateServerMessage);
        set_function("getServerVersion", &luautils::GetServerVersion);
        set_function("getMobRespawnTime", &luautils::GetMobRespawnTime);
        set_function("disallowRespawn", &luautils::DisallowRespawn);
        set_function("updateNMSpawnPoint", &luautils::UpdateNMSpawnPoint);
        set_function("setDropRate", &luautils::SetDropRate);
        set_function("nearLocation", &luautils::NearLocation);
        set_function("terminate", &luautils::Terminate);
        set_function("getHealingTickDelay", &luautils::GetHealingTickDelay);
        set_function("getReadOnlyItem", &luautils::GetReadOnlyItem);
        set_function("getAbility", &luautils::GetAbility);
        set_function("getSpell", &luautils::GetSpell);
        set_function("selectDailyItem", &luautils::SelectDailyItem);

        // Register Sol Bindings
        CLuaAbility::Register();
        CLuaAction::Register();
        CLuaBaseEntity::Register();
        CLuaBattlefield::Register();
        CLuaInstance::Register();
        CLuaMobSkill::Register();
        CLuaRegion::Register();
        CLuaSpell::Register();
        CLuaStatusEffect::Register();
        CLuaTradeContainer::Register();
        CLuaZone::Register();
        CLuaItem::Register();

        // Load globals
        // TODO: Load these as requires
        lua.script_file("./scripts/globals/settings.lua");
        lua.script_file("./scripts/globals/conquest.lua");
        lua.script_file("./scripts/globals/player.lua");
        roeutils::init();
        lua.script_file("./scripts/globals/roe.lua");
        lua.script_file("./scripts/globals/gear_sets.lua");
        lua.script_file("./scripts/globals/battlefield.lua");
        lua.script_file("./scripts/globals/mobs.lua");
        lua.script_file("./scripts/globals/mixins.lua");

        // Pet Scripts
        CacheLuaObjectFromFile("./scripts/globals/pets/automaton.lua");
        CacheLuaObjectFromFile("./scripts/globals/pets/luopan.lua");
        CacheLuaObjectFromFile("./scripts/globals/pets/wyvern.lua");

        // Handle settings
        contentRestrictionEnabled = GetSettingsVariable("RESTRICT_CONTENT") != 0;

        TracyReportLuaMemory(LuaHandle);

        ShowMessage("\t\t - " CL_GREEN "[OK]" CL_RESET "\n");
        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Освобождение lua                                                     *
     *                                                                       *
     ************************************************************************/

    int32 garbageCollectStep()
    {
        TracyZoneScoped;
        TracyReportLuaMemory(LuaHandle);

        lua.step_gc(10); // LUA_GCSTEP 10 (performs an incremental step of garbage collection. Step size 10kb.)

        // NOTE: This is just requesting that an incremental step starts. There won't be a before/after change from
        //       this request!

        ShowDebug(CL_CYAN "[Lua] Garbage Collected (Step)\n" CL_RESET);
        ShowDebug(CL_CYAN "[Lua] Current State Top: %d, Total Memory Used: %dkb\n" CL_RESET, lua_gettop(LuaHandle), lua.memory_used() / 1024);

        TracyReportLuaMemory(LuaHandle);

        return 0;
    }

    int32 garbageCollectFull()
    {
        TracyZoneScoped;
        TracyReportLuaMemory(LuaHandle);

        auto before_mem_kb = lua.memory_used() / 1024;

        lua.collect_garbage(); // LUA_GCCOLLECT (performs a full garbage-collection cycle.)

        auto after_mem_kb = lua.memory_used() / 1024;

        ShowDebug(CL_CYAN "[Lua] Garbage Collected (Full)\n" CL_RESET);
        ShowDebug(CL_CYAN "[Lua] Current State Top: %d, Total Memory Used: %dkb -> %dkb\n" CL_RESET, lua_gettop(LuaHandle), before_mem_kb, after_mem_kb);

        TracyReportLuaMemory(LuaHandle);

        return 0;
    }

    void EnableFilewatcher()
    {
        // Prepare script file watcher
        auto watchReaction = [](const std::filesystem::path& path, const filewatch::Event change_type) {
            // If a Lua file is modified
            if (path.extension() == ".lua" && change_type == filewatch::Event::modified)
            {
                TracyZoneScoped;
                TracyZoneString(path.generic_string());

                auto real_path          = "./scripts/" + path.generic_string();
                auto modified           = std::filesystem::last_write_time(real_path).time_since_epoch().count();
                auto modified_timestamp = static_cast<uint64>(modified);
                SafeApplyFunc_ReloadList([&](std::map<std::string, uint64>& list) {
                    if (list.find(real_path) == list.end())
                    {
                        // No entry, make one
                        list[real_path] = modified_timestamp;
                    }
                    else
                    {
                        auto last_modified = list.at(real_path);
                        if (last_modified < modified_timestamp)
                        {
                            list[real_path] = modified_timestamp;
                            filteredList.emplace_back(real_path);
                        }
                    }
                });
            }
        };
        watch = std::make_unique<filewatch::FileWatch<std::string>>("./scripts/", watchReaction);
    }

    void ReloadFilewatchList()
    {
        SafeApplyFunc_ReloadList([&](std::map<std::string, uint64>& list) {
            TracyZoneScoped;
            for (auto& path_string : filteredList)
            {
                CacheLuaObjectFromFile(path_string, true);
            }

            // Erase list
            filteredList.clear();
        });
    }

    /************************************************************************
     *                                                                       *
     *  Переопределение официальной lua функции print                        *
     *                                                                       *
     ************************************************************************/

    template <typename T>
    void print(T const& item)
    {
        TracyZoneScoped;
        ShowScript(fmt::format("{}\n", item));
    }

    sol::function getEntityCachedFunction(CBaseEntity* PEntity, std::string funcName)
    {
        TracyZoneScoped;
        TracyZoneString(funcName);
        TracyZoneIString(PEntity->GetName());

        if (PEntity->objtype == TYPE_NPC)
        {
            std::string zone_name = (const char*)PEntity->loc.zone->GetName();
            std::string npc_name  = (const char*)PEntity->GetName();

            if (auto cached_func = lua["xi"]["zones"][zone_name]["npcs"][npc_name][funcName]; cached_func.valid())
            {
                return cached_func;
            }
        }
        else if (PEntity->objtype == TYPE_MOB)
        {
            std::string zone_name = (const char*)PEntity->loc.zone->GetName();
            std::string mob_name  = (const char*)PEntity->GetName();

            if (auto cached_func = lua["xi"]["zones"][zone_name]["mobs"][mob_name][funcName]; cached_func.valid())
            {
                return cached_func;
            }
        }
        else if (PEntity->objtype == TYPE_PET)
        {
            std::string mob_name = static_cast<CPetEntity*>(PEntity)->GetScriptName();

            if (auto cached_func = lua["xi"]["globals"]["pets"][mob_name][funcName]; cached_func.valid())
            {
                return cached_func;
            }
        }
        else if (PEntity->objtype == TYPE_TRUST)
        {
            std::string mob_name = (const char*)PEntity->GetName();

            if (auto cached_func = lua["xi"]["globals"]["spells"]["trust"][mob_name][funcName]; cached_func.valid())
            {
                return cached_func;
            }
        }

        // Didn't find it
        return sol::nil;
    }

    sol::function getSpellCachedFunction(CSpell* PSpell, std::string funcName)
    {
        TracyZoneScoped;
        TracyZoneString(funcName);
        TracyZoneIString(PSpell->getName());

        auto name = (const char*)PSpell->getName();

        if (PSpell->getSpellGroup() == SPELLGROUP_BLUE)
        {
            if (auto cached_func = lua["xi"]["globals"]["spells"]["bluemagic"][name][funcName]; cached_func.valid())
            {
                return cached_func;
            }
        }
        else if (PSpell->getSpellGroup() == SPELLGROUP_TRUST)
        {
            if (auto cached_func = lua["xi"]["globals"]["spells"]["trust"][name][funcName]; cached_func.valid())
            {
                return cached_func;
            }
        }
        else
        {
            if (auto cached_func = lua["xi"]["globals"]["spells"][name][funcName]; cached_func.valid())
            {
                return cached_func;
            }
        }

        // Didn't find it
        return sol::nil;
    }

    // Assumes filename in the form "./scripts/folder0/folder1/folder2/mob_name.lua
    // Object returned form that script will be cached to:
    // xi.folder0.folder1.folder2.mob_name
    void CacheLuaObjectFromFile(std::string filename, bool printOutput /*= false*/)
    {
        TracyZoneScoped;
        TracyZoneString(filename);

        // Handle filename -> path conversion
        std::filesystem::path    path(filename);
        std::vector<std::string> parts;
        for (auto part : path)
        {
            part.replace_extension("");
            parts.emplace_back(part.string());
        }

        auto it = std::find(parts.begin(), parts.end(), "scripts");
        if (it == parts.end())
        {
            ShowError("luautils::CacheLuaObjectFromFile: Invalid filename: %s\n", filename);
            return;
        }

        // Now that the list is verified, overwrite it with the same list; without "scripts"
        parts = std::vector<std::string>(it + 1, parts.end());

        // Globals need to be nil'd before they're reloaded
        if (parts.size() == 2 && parts[0] == "globals")
        {
            std::string requireName = fmt::format("scripts/globals/{}", parts[1]);

            auto result = lua.safe_script(fmt::format("package.loaded[\"{}\"] = nil; require(\"{}\");", requireName, requireName));
            if (!result.valid())
            {
                sol::error err = result;
                ShowError("luautils::CacheLuaObjectFromFile: Load global error: %s: %s\n", filename, err.what());
                return;
            }

            ShowInfo("[FileWatcher] GLOBAL %s -> \"%s\"\n", filename, requireName);
            return;
        }

        if (!std::filesystem::exists(filename))
        {
            // ShowDebug("luautils::CacheLuaObjectFromFile: File does not exist: %s\n", filename);
            return;
        }

        // Try and load script
        auto file_result = lua.safe_script_file(filename);
        if (!file_result.valid())
        {
            sol::error err = file_result;
            ShowError("luautils::CacheLuaObjectFromFile: Load error: %s: %s\n", filename, err.what());
            return;
        }

        if (!file_result.return_count())
        {
            ShowError("luautils::CacheLuaObjectFromFile: No returned object to cache: %s\n", filename);
            return;
        }

        // file_result should be good, cache it!

        auto        table   = lua["xi"].get_or_create<sol::table>();
        std::string out_str = "xi";
        for (auto& part : parts)
        {
            if (part == parts.back())
            {
                table[sol::override_value][part] = file_result;
            }
            else
            {
                table = table[part].get_or_create<sol::table>(lua.create_table());
            }
            out_str += "." + part;
        }

        if (printOutput)
        {
            ShowInfo("[FileWatcher] %s -> %s\n", filename, out_str);
        }
    }

    sol::table GetCacheEntryFromFilename(std::string filename)
    {
        TracyZoneScoped;
        TracyZoneString(filename);

        if (filename.empty())
        {
            return lua.create_table();
        }

        // Handle filename -> path conversion
        std::filesystem::path    path(filename);
        std::vector<std::string> parts;
        for (auto part : path)
        {
            part.replace_extension("");
            parts.emplace_back(part.string());
        }

        auto it = std::find(parts.begin(), parts.end(), "scripts");
        if (it == parts.end())
        {
            ShowError("luautils::GetCacheEntryFromFilename: Invalid filename: %s\n", filename);
            return lua.create_table();
        }

        // Now that the list is verified, overwrite it with the same list; without "scripts"
        parts = std::vector<std::string>(it + 1, parts.end());

        // TODO: This is bad, this could create bad tables that persist...
        auto table = lua["xi"].get_or_create<sol::table>();
        for (auto& part : parts)
        {
            table = table[part].get_or_create<sol::table>();
        }

        return table;
    }

    void OnEntityLoad(CBaseEntity* PEntity)
    {
        TracyZoneScoped;

        std::string filename;
        if (PEntity->objtype == TYPE_NPC)
        {
            // TODO: These int8 string need to die.
            std::string zone_name = (const char*)PEntity->loc.zone->GetName();
            std::string npc_name  = (const char*)PEntity->GetName();
            filename              = fmt::format("./scripts/zones/{}/npcs/{}.lua", zone_name, npc_name);
        }
        else if (PEntity->objtype == TYPE_MOB)
        {
            // TODO: These int8 string need to die.
            std::string zone_name = (const char*)PEntity->loc.zone->GetName();
            std::string mob_name  = (const char*)PEntity->GetName();
            filename              = fmt::format("./scripts/zones/{}/mobs/{}.lua", zone_name, mob_name);
        }
        else if (PEntity->objtype == TYPE_PET)
        {
            std::string mob_name = static_cast<CPetEntity*>(PEntity)->GetScriptName();
            filename             = fmt::format("./scripts/globals/pets/{}.lua", static_cast<CPetEntity*>(PEntity)->GetScriptName());
        }
        else if (PEntity->objtype == TYPE_TRUST)
        {
            std::string mob_name = (const char*)PEntity->GetName();
            filename             = fmt::format("./scripts/globals/spells/trust/{}.lua", PEntity->GetName());
        }

        CacheLuaObjectFromFile(filename);
    }

    // temporary solution for geysers in Dangruf_Wadi
    void SendEntityVisualPacket(uint32 npcid, const char* command)
    {
        TracyZoneScoped;
        if (CBaseEntity* PNpc = zoneutils::GetEntity(npcid, TYPE_NPC))
        {
            PNpc->loc.zone->PushPacket(PNpc, CHAR_INRANGE, new CEntityVisualPacket(PNpc, command));
        }
    }

    std::optional<CLuaBaseEntity> GetNPCByID(uint32 npcid, sol::object const& instanceObj)
    {
        TracyZoneScoped;

        CInstance* PInstance = nullptr;
        if (instanceObj.is<CLuaInstance>())
        {
            PInstance = instanceObj.as<CLuaInstance>().GetInstance();
        }

        CBaseEntity* PNpc{ nullptr };
        if (PInstance)
        {
            PNpc = PInstance->GetEntity(npcid & 0xFFF, TYPE_NPC);
        }
        else
        {
            PNpc = zoneutils::GetEntity(npcid, TYPE_NPC);
        }

        if (!PNpc)
        {
            ShowWarning("luautils::GetNPCByID NPC doesn't exist (%d)\n", npcid);
            return std::nullopt;
        }

        return std::optional<CLuaBaseEntity>(PNpc);
    }

    void InitInteractionGlobal()
    {
        CacheLuaObjectFromFile("./scripts/globals/interaction/interaction_global.lua");

        auto initZones = lua["xi"]["globals"]["interaction"]["interaction_global"]["initZones"];
        std::vector<uint16> zoneIds;
        zoneutils::ForEachZone([&zoneIds](CZone* PZone) {
            zoneIds.push_back(PZone->GetID());
        });

        auto result = initZones(zoneIds);

        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::InitInteractionGlobal: %s\n", err.what());
        }
    }

    /************************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    std::optional<CLuaZone> GetZone(uint16 zoneId)
    {
        TracyZoneScoped;

        CZone* zone = zoneutils::GetZone(zoneId);
        if (zone)
        {
            return std::optional<CLuaZone>(zone);
        }

        return std::nullopt;
    }

    std::optional<CLuaBaseEntity> GetMobByID(uint32 mobid, sol::object const& instanceObj)
    {
        TracyZoneScoped;

        CInstance* PInstance = nullptr;
        if (instanceObj.is<CLuaInstance>())
        {
            PInstance = instanceObj.as<CLuaInstance>().GetInstance();
        }

        CBaseEntity* PMob{ nullptr };

        if (PInstance)
        {
            PMob = PInstance->GetEntity(mobid & 0xFFF, TYPE_MOB | TYPE_PET);
        }
        else
        {
            PMob = zoneutils::GetEntity(mobid, TYPE_MOB | TYPE_PET);
        }

        if (!PMob)
        {
            ShowWarning("luautils::GetMobByID Mob doesn't exist (%d)\n", mobid);
            return std::nullopt;
        }

        return std::optional<CLuaBaseEntity>(PMob);
    }

    /************************************************************************
     *                                                                       *
     * WeekUpdateConquest                                                    *
     *                                                                       *
     ************************************************************************/

    void WeekUpdateConquest(sol::variadic_args va)
    {
        TracyZoneScoped;

        ConquestUpdate type = Conquest_Tally_Start;
        if (va.size())
        {
            type = static_cast<ConquestUpdate>(va.get<uint8>(0));
        }
        conquest::UpdateConquestGM(type);
    }

    /************************************************************************
     *                                                                       *
     *  Find out the country that owns the current region                    *
     *                                                                       *
     ************************************************************************/

    uint8 GetRegionOwner(uint8 type)
    {
        TracyZoneScoped;
        return conquest::GetRegionOwner(static_cast<REGION_TYPE>(type));
    }

    uint8 GetRegionInfluence(uint8 type)
    {
        TracyZoneScoped;
        return conquest::GetInfluenceGraphics(static_cast<REGION_TYPE>(type));
    }

    /************************************************************************
     *                                                                       *
     * Get Rank of Nations in Conquest                                       *
     *                                                                       *
     ************************************************************************/

    uint8 GetNationRank(uint8 nation)
    {
        TracyZoneScoped;

        uint8 balance = conquest::GetBalance();
        switch (nation)
        {
            case NATION_SANDORIA:
                balance &= 0x3U;
                return balance;
            case NATION_BASTOK:
                balance &= 0xCU;
                balance >>= 2;
                return balance;
            case NATION_WINDURST:
                balance >>= 4;
                return balance;
            default:
                return 0;
        }
    }

    uint8 GetConquestBalance()
    {
        TracyZoneScoped;
        return conquest::GetBalance();
    }

    bool IsConquestAlliance()
    {
        TracyZoneScoped;
        return conquest::IsAlliance();
    }

    /************************************************************************
     *                                                                       *
     * SetRegionalConquestOverseers() used for updating conquest guards      *
     *                                                                       *
     ************************************************************************/

    int32 SetRegionalConquestOverseers(uint8 regionID)
    {
        TracyZoneScoped;

        auto setRegionalConquestOverseers = lua["xi"]["conquest"]["setRegionalConquestOverseers"];
        if (!setRegionalConquestOverseers.valid())
        {
            sol::error err = setRegionalConquestOverseers;
            ShowError("luautils::setRegionalConquestOverseers: %s\n", err.what());
            return -1;
        }

        auto result = setRegionalConquestOverseers(regionID);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::setRegionalConquestOverseers: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *    Return Vanadiel Time                                               *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielTime()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getVanaTime();
    }

    /************************************************************************
     *                                                                       *
     *  Получаем текущее время суток Vana'diel                               *
     *                                                                       *
     ************************************************************************/

    uint8 VanadielTOTD()
    {
        TracyZoneScoped;
        return static_cast<uint8>(CVanaTime::getInstance()->GetCurrentTOTD());
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Year                                                *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielYear()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getYear();
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Month                                               *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielMonth()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getMonth();
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Unique Day                                          *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielUniqueDay()
    {
        TracyZoneScoped;

        int32 day;
        int32 month;
        int32 year;

        day   = CVanaTime::getInstance()->getDayOfTheMonth();
        month = CVanaTime::getInstance()->getMonth();
        year  = CVanaTime::getInstance()->getYear();

        return (year * 360) + (month * 30 - 30) + day;
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Day of Year                                         *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielDayOfTheYear()
    {
        TracyZoneScoped;

        int32 day;
        int32 month;

        day   = CVanaTime::getInstance()->getDayOfTheMonth();
        month = CVanaTime::getInstance()->getMonth();

        return (month * 30 - 30) + day;
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Day of the Month                                    *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielDayOfTheMonth()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getDayOfTheMonth();
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel day of the week                                     *
     *   Note: THIS IS NOT THE SAME AS THAT DAY'S ELEMENT                    *
     *   Days of week: Fire Earth Water Wind Ice Lightning Light Dark        *
     *   Elements: Fire Ice Wind Earth Thunder Water Light Dark              *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielDayOfTheWeek()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getWeekday();
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Hour                                                *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielHour()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getHour();
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Minute                                              *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielMinute()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getMinute();
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Day's element                                       *
     *   Note: THIS IS NOT THE SAME AS THE DAY OF THE WEEK                   *
     *   Days of week: Fire Earth Water Wind Ice Lightning Light Dark        *
     *   Elements: Fire Ice Wind Earth Thunder Water Light Dark              *
     *                                                                       *
     ************************************************************************/

    uint8 VanadielDayElement()
    {
        TracyZoneScoped;
        return static_cast<uint8>(battleutils::GetDayElement());
    }

    /************************************************************************
     *                                                                       *
     * JstMidnight - Returns UTC timestamp of upcoming JST midnight
     *                                                                       *
     ************************************************************************/

    uint32 JstMidnight()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getJstMidnight();
    }

    /************************************************************************
     *                                                                       *
     * JstWeekday - Returns days since Sunday JST
     *                                                                       *
     ************************************************************************/

    uint32 JstWeekday()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getJstWeekDay();
    }

    /************************************************************************
     *                                                                       *
     *   Return Moon Phase                                                   *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielMoonPhase()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getMoonPhase();
    }

    bool SetVanadielTimeOffset(int32 offset)
    {
        TracyZoneScoped;
        int32 custom = CVanaTime::getInstance()->getCustomEpoch();
        CVanaTime::getInstance()->setCustomEpoch((custom ? custom : VTIME_BASEDATE) - offset);
        return true;
    }

    /************************************************************************
     *                                                                       *
     *   Return Moon Phasing Direction                                       *
     *                                                                       *
     ************************************************************************/

    uint8 VanadielMoonDirection()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getMoonDirection();
    }

    /************************************************************************
     *                                                                       *
     *   Return RSE Race                                                     *
     *                                                                       *
     ************************************************************************/

    uint8 VanadielRSERace()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getRSERace();
    }

    /************************************************************************
     *                                                                       *
     *   Return RSE Location                                                 *
     *                                                                       *
     ************************************************************************/

    uint8 VanadielRSELocation()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getRSELocation();
    }

    /************************************************************************
     *                                                                       *
     *   is new moon?                                                        *
     *                                                                       *
     ************************************************************************/

    bool IsMoonNew()
    {
        TracyZoneScoped;
        // New moon occurs when:
        // Waning (decreasing) from 10% to 0%,
        // Waxing (increasing) from 0% to 5%.

        uint8 phase = CVanaTime::getInstance()->getMoonPhase();

        switch (CVanaTime::getInstance()->getMoonDirection())
        {
            case 0: // None
                if (phase == 0)
                {
                    return true;
                }
            case 1: // Waning (decending)
                if (phase <= 10 && phase >= 0)
                {
                    return true;
                }
            case 2: // Waxing (increasing)
                if (phase >= 0 && phase <= 5)
                {
                    return true;
                }
        }

        return false;
    }

    /************************************************************************
     *                                                                       *
     *   is full moon?                                                       *
     *                                                                       *
     ************************************************************************/

    bool IsMoonFull()
    {
        TracyZoneScoped;
        // Full moon occurs when:
        // Waxing (increasing) from 90% to 100%,
        // Waning (decending) from 100% to 95%.

        uint8 phase = CVanaTime::getInstance()->getMoonPhase();

        switch (CVanaTime::getInstance()->getMoonDirection())
        {
            case 0: // None
                if (phase == 100)
                {
                    return true;
                }
            case 1: // Waning (decending)
                if (phase >= 95 && phase <= 100)
                {
                    return true;
                }
            case 2: // Waxing (increasing)
                if (phase >= 90 && phase <= 100)
                {
                    return true;
                }
        }

        return false;
    }

    /************************************************************************
     *                                                                       *
     *  Spawn a mob using mob ID. Returns that mob.                          *
     *                                                                       *
     ************************************************************************/
    std::optional<CLuaBaseEntity> SpawnMob(uint32 mobid, sol::object const& arg2, sol::object const& arg3)
    {
        TracyZoneScoped;

        CMobEntity* PMob = nullptr;

        if (arg2.is<CLuaInstance>())
        {
            auto PInstance = arg2.as<CLuaInstance>().GetInstance();
            auto PEntity   = PInstance->GetEntity(mobid & 0xFFF, TYPE_MOB);
            PMob           = dynamic_cast<CMobEntity*>(PEntity);
        }
        else if (((mobid >> 12) & 0x0FFF) < MAX_ZONEID)
        {
            PMob = dynamic_cast<CMobEntity*>(zoneutils::GetEntity(mobid, TYPE_MOB));
        }

        if (PMob != nullptr)
        {
            if (arg2.is<uint32>())
            {
                PMob->SetDespawnTime(std::chrono::seconds(arg2.as<uint32>()));
            }

            if (arg3.is<uint32>())
            {
                PMob->m_RespawnTime  = arg3.as<uint32>() * 1000;
                PMob->m_AllowRespawn = true;
            }
            else
            {
                if (!PMob->PAI->IsSpawned())
                {
                    PMob->Spawn();
                }
                else
                {
                    ShowDebug(CL_CYAN "SpawnMob: %u <%s> is already spawned\n" CL_RESET, PMob->id, PMob->GetName());
                }
            }
        }
        else
        {
            ShowDebug(CL_RED "SpawnMob: mob <%u> not found\n" CL_RESET, mobid);
            return std::nullopt;
        }

        return std::optional<CLuaBaseEntity>(PMob);
    }

    /************************************************************************
     *                                                                       *
     *  DeSpawn mob using mob ID.                                            *
     *                                                                       *
     ************************************************************************/

    void DespawnMob(uint32 mobid, sol::object const& arg2)
    {
        TracyZoneScoped;

        CMobEntity* PMob = nullptr;

        if (arg2.is<CLuaInstance>())
        {
            auto PInstance = arg2.as<CLuaInstance>().GetInstance();
            PMob           = (CMobEntity*)PInstance->GetEntity(mobid & 0xFFF, TYPE_MOB);
        }
        else
        {
            PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB);
        }

        if (PMob != nullptr)
        {
            if (arg2.is<uint32>())
            {
                PMob->SetDespawnTime(std::chrono::seconds(arg2.as<uint32>()));
            }
            else
            {
                PMob->PAI->Despawn();
            }
        }
    }

    /************************************************************************
     *                                                                       *
     *  Gets a player object via the player's name. Used for GM commands.    *
     *                                                                       *
     ************************************************************************/

    std::optional<CLuaBaseEntity> GetPlayerByName(std::string name)
    {
        TracyZoneScoped;

        CCharEntity* PTargetChar = zoneutils::GetCharByName((int8*)name.c_str());

        if (PTargetChar != nullptr)
        {
            return std::optional<CLuaBaseEntity>(PTargetChar);
        }

        return std::nullopt;
    }

    /************************************************************************
     *                                                                       *
     *  Gets a player object via the player's ID.                            *
     *                                                                       *
     ************************************************************************/

    std::optional<CLuaBaseEntity> GetPlayerByID(uint32 pid)
    {
        TracyZoneScoped;

        CCharEntity* PTargetChar = zoneutils::GetChar(pid);

        if (PTargetChar != nullptr)
        {
            return std::optional<CLuaBaseEntity>(PTargetChar);
        }

        return std::nullopt;
    }

    /*******************************************************************************
    *                                                                              *
    *  Returns data of Magian trials                                               *
    *  Will return a single table with keys matching the SQL table column          *
    *  names if given one trial #, or will return a table of likewise trial        *
    *  columns if given a table of trial #s.                                       *
    *  examples: GetMagianTrial(2)          returns {column = value, ...}          *
    *            GetMagianTrial({2, 16})    returns { 2 = { column = value, ...},  *
    *                                                16 = { column = value, ...}}  *
    *******************************************************************************/

    sol::table GetMagianTrial(sol::variadic_args va)
    {
        TracyZoneScoped;

        sol::table table = lua.create_table();

        if (va.size())
        {
            // Get all magian table columns to build lua keys
            const char*              ColumnQuery = "SHOW COLUMNS FROM `magian`;";
            std::vector<std::string> magianColumns;
            if (Sql_Query(SqlHandle, ColumnQuery) == SQL_SUCCESS && Sql_NumRows(SqlHandle) != 0)
            {
                while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    magianColumns.push_back((const char*)Sql_GetData(SqlHandle, 0));
                }
            }
            else
            {
                ShowError("Error: No columns in `magian` table?");
                return sol::nil;
            }

            const char* Query = "SELECT * FROM `magian` WHERE trialId = %u;";

            if (va[0].is<lua_Number>())
            {
                int32 trial = va[0].as<int32>();
                int32 field{ 0 };
                if (Sql_Query(SqlHandle, Query, trial) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    for (auto column : magianColumns)
                    {
                        table[column] = (int32)Sql_GetIntData(SqlHandle, field++);
                    }
                }
            }
            else if (va[0].is<sol::table>())
            {
                auto trials = va[0].as<std::vector<int32>>();

                // one inner table each trial { trial# = { column = value, ... } }
                for (auto trial : trials)
                {
                    int32 ret = Sql_Query(SqlHandle, Query, trial);
                    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                    {
                        auto  inner_table = table.create_named(trial);
                        int32 field{ 0 };
                        for (auto column : magianColumns)
                        {
                            inner_table[column] = (int32)Sql_GetIntData(SqlHandle, field++);
                        }
                    }
                }
            }
            else
            {
                return sol::nil;
            }

            return table;
        }

        return sol::nil;
    }

    /*******************************************************************************
    *                                                                              *
    *  Returns a list of trial numbers who have the given parent trial             *
    *                                                                              *
    *******************************************************************************/

    sol::table GetMagianTrialsWithParent(int32 parentTrial)
    {
        TracyZoneScoped;

        const char* Query = "SELECT `trialId` from `magian` WHERE `previousTrial` = %u;";
        int32       ret   = Sql_Query(SqlHandle, Query, parentTrial);
        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0)
        {
            auto  table = lua.create_table();
            int32 field{ 0 };
            while (Sql_NextRow(SqlHandle) == 0)
            {
                int32 childTrial = Sql_GetIntData(SqlHandle, 0);
                table[++field]   = childTrial;
            }

            return table;
        }

        return sol::nil;
    }

    /************************************************************************
     *                                                                       *
     *  Load the value of the TextID variable of the specified zone          *
     *                                                                       *
     ************************************************************************/

    int32 GetTextIDVariable(uint16 ZoneID, const char* variable)
    {
        TracyZoneScoped;
        return lua["zones"][ZoneID]["text"][variable].get_or(0);
    }

    /************************************************************************
     *                                                                       *
     *  Get a Variable From Settings.lua                                     *
     *                                                                       *
     ************************************************************************/

    uint8 GetSettingsVariable(const char* variable)
    {
        TracyZoneScoped;
        return lua[variable].valid() ? lua[variable].get<uint8>() : 0;
    }

    /************************************************************************
     *                                                                       *
     *  Check if an something is restricted in Settings.lua                  *
     *  ENABLE_ is subject to RESTRICT_BY_EXPANSION                          *
     *  ALLOW_ is NOT subject to RESTRICT_BY_EXPANSION                       *
     *                                                                       *
     ************************************************************************/

    bool IsContentEnabled(const char* contentTag)
    {
        TracyZoneScoped;

        if (contentTag != nullptr)
        {
            std::string contentVariable("ENABLE_");
            contentVariable.append(contentTag);

            bool contentEnabled;

            if (auto contentEnabledIter = contentEnabledMap.find(contentVariable); contentEnabledIter != contentEnabledMap.end())
            {
                contentEnabled = contentEnabledIter->second;
            }
            else
            {
                // Cache contentTag lookups in a map so that we don't re-hit the Lua file every time
                contentEnabled = (GetSettingsVariable(contentVariable.c_str()) != 0);

                contentEnabledMap[contentVariable] = contentEnabled;
            }

            if (!contentEnabled && contentRestrictionEnabled)
            {
                return false;
            }
        }

        return true;
    }

    /************************************************************************
     *                                                                       *
     ************************************************************************/

    int32 OnZoneInitialise(uint16 ZoneID)
    {
        TracyZoneScoped;

        CZone* PZone = zoneutils::GetZone(ZoneID);
        auto   name  = (const char*)PZone->GetName();

        auto filename = fmt::format("./scripts/zones/{}/Zone.lua", name);

        CacheLuaObjectFromFile(filename);

        auto onInitialize = lua["xi"]["zones"][name]["Zone"]["onInitialize"];
        if (!onInitialize.valid())
        {
            return -1;
        }

        auto result = onInitialize(CLuaZone(PZone));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInitialize: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Выполняем скрипт при входе персонажа в зону                          *
     *                                                                       *
     ************************************************************************/

    int32 OnGameIn(CCharEntity* PChar, bool zoning)
    {
        TracyZoneScoped;

        auto onGameIn = lua["xi"]["player"]["onGameIn"];
        if (!onGameIn.valid())
        {
            ShowError("luautils::onGameIn");
            return -1;
        }

        auto result = onGameIn(CLuaBaseEntity(PChar), PChar->GetPlayTime(false) == 0, zoning);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onGameIn: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Выполняем скрипт при входе персонажа в зону                          *
     *                                                                       *
     ************************************************************************/

    int32 OnZoneIn(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto name = PChar->m_moghouseID ? "Residential_Area" : (const char*)zoneutils::GetZone(PChar->loc.destination)->GetName();

        auto onZoneInFramework = lua["xi"]["globals"]["interaction"]["interaction_global"]["onZoneIn"];
        auto onZoneIn = lua["xi"]["zones"][name]["Zone"]["onZoneIn"];

        auto result = onZoneInFramework(CLuaBaseEntity(PChar), PChar->loc.prevzone, onZoneIn);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onZoneIn: %s\n", err.what());
            return -1;
        }

        return result;
    }

    void AfterZoneIn(CBaseEntity* PChar)
    {
        TracyZoneScoped;

        auto name = (const char*)PChar->loc.zone->GetName();

        auto afterZoneIn = lua["xi"]["zones"][name]["Zone"]["afterZoneIn"];
        if (!afterZoneIn.valid())
        {
            return;
        }

        auto result = afterZoneIn(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::afterZoneIn: %s\n", err.what());
        }
    }

    /************************************************************************
     *                                                                       *
     *  Персонаж входит в активный регион                                    *
     *                                                                       *
     ************************************************************************/

    int32 OnRegionEnter(CCharEntity* PChar, CRegion* PRegion)
    {
        TracyZoneScoped;

        std::string filename;
        if (PChar->PInstance)
        {
            filename =
                std::string("./scripts/zones/") + (const char*)PChar->loc.zone->GetName() + "/instances/" + (const char*)PChar->PInstance->GetName() + ".lua";
        }
        else
        {
            filename = std::string("./scripts/zones/") + (const char*)PChar->loc.zone->GetName() + "/Zone.lua";
        }

        // player may be entering because of an earlier event (event that changes position)
        // these should probably not call another event from onRegionEnter (use onEventFinish instead)
        if (PChar->m_event.EventID == -1)
        {
            PChar->m_event.Script = filename;
        }

        auto name = (const char*)PChar->loc.zone->GetName();

        sol::function onRegionEnter;
        if (PChar->PInstance)
        {
            auto instance_name = (const char*)PChar->PInstance->GetName();
            onRegionEnter      = lua["xi"]["zones"][name]["instance"][instance_name]["onRegionEnter"];
        }
        else
        {
            onRegionEnter = lua["xi"]["zones"][name]["Zone"]["onRegionEnter"];
        }

        auto onRegionEnterFramework = lua["xi"]["globals"]["interaction"]["interaction_global"]["onRegionEnter"];
        auto result                 = onRegionEnterFramework(CLuaBaseEntity(PChar), CLuaRegion(PRegion), onRegionEnter);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onRegionEnter: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Персонаж покидает активный регион                                    *
     *                                                                       *
     ************************************************************************/

    int32 OnRegionLeave(CCharEntity* PChar, CRegion* PRegion)
    {
        TracyZoneScoped;

        std::string filename;
        if (PChar->PInstance)
        {
            filename =
                std::string("scripts/zones/") + (const char*)PChar->loc.zone->GetName() + "/instances/" + (const char*)PChar->PInstance->GetName() + ".lua";
        }
        else
        {
            filename = std::string("scripts/zones/") + (const char*)PChar->loc.zone->GetName() + "/Zone.lua";
        }

        // player may be leaving because of an earlier event (event that changes position)
        if (PChar->m_event.EventID == -1)
        {
            PChar->m_event.Script = filename;
        }

        auto name   = (const char*)PChar->loc.zone->GetName();
        auto zoneId = (const uint16*)PChar->loc.zone->GetID();

        sol::function onRegionLeave;
        if (PChar->PInstance && zoneId == (const uint16*)PChar->PInstance->GetZone()->GetID())
        {
            auto instance_name = (const char*)PChar->PInstance->GetName();
            onRegionLeave      = lua["xi"]["zones"][name]["instance"][instance_name]["onRegionLeave"];
        }
        else
        {
            onRegionLeave = lua["xi"]["zones"][name]["Zone"]["onRegionLeave"];
        }

        auto onRegionLeaveFramework = lua["xi"]["globals"]["interaction"]["interaction_global"]["onRegionLeave"];
        auto result                 = onRegionLeaveFramework(CLuaBaseEntity(PChar), CLuaRegion(PRegion), onRegionLeave);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onRegionLeave: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     * The character refers to some npc. Trying to respond to its action.    *
     *                                                                       *
     ************************************************************************/

    int32 OnTrigger(CCharEntity* PChar, CBaseEntity* PNpc)
    {
        TracyZoneScoped;

        auto zone     = (const char*)PChar->loc.zone->GetName();
        auto name     = (const char*)PNpc->GetName();
        auto filename = fmt::format("./scripts/zones/{}/npcs/{}.lua", zone, name);

        PChar->m_event.reset();
        PChar->m_event.Target = PNpc;
        PChar->m_event.Script = filename;

        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_BOOST);

        auto onTriggerFramework = lua["xi"]["globals"]["interaction"]["interaction_global"]["onTrigger"];
        auto onTrigger = GetCacheEntryFromFilename(filename)["onTrigger"];

        auto result = onTriggerFramework(CLuaBaseEntity(PChar), CLuaBaseEntity(PNpc), onTrigger);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTrigger: %s\n", err.what());
            return -1;
        }

        return result.get_type() == sol::type::number ? result.get<int32>() : 0;
    }

    /************************************************************************
     *  Запущенное событие нуждается в дополнительных параметрах             *
     *  A triggered event needs additional parameters  (battlefield extras)  *
     ************************************************************************/

    int32 OnEventUpdate(CCharEntity* PChar, uint16 eventID, uint32 result, uint16 extras)
    {
        TracyZoneScoped;

        auto onEventUpdate = LoadEventScript(PChar, "onEventUpdate");
        if (!onEventUpdate.valid())
        {
            ShowError("luautils::onEventUpdate: undefined procedure onEventUpdate\n");
            return -1;
        }

        std::optional<CLuaBaseEntity> optTarget = std::nullopt;
        if (PChar->m_event.Target)
        {
            optTarget = CLuaBaseEntity(PChar->m_event.Target);
        }

        auto func_result = onEventUpdate(CLuaBaseEntity(PChar), eventID, result, extras, optTarget);
        if (!func_result.valid())
        {
            sol::error err = func_result;
            ShowError("luautils::onEventUpdate: %s\n", err.what());
            return -1;
        }

        return func_result.get_type() == sol::type::number ? func_result.get<int32>() : 1;
    }

    /************************************************************************
     *  Запущенное событие нуждается в дополнительных параметрах             *
     *  A triggered event needs additional parameters                        *
     ************************************************************************/

    int32 OnEventUpdate(CCharEntity* PChar, uint16 eventID, uint32 result)
    {
        TracyZoneScoped;

        auto onEventUpdateFramework = lua["xi"]["globals"]["interaction"]["interaction_global"]["onEventUpdate"];
        auto onEventUpdate = LoadEventScript(PChar, "onEventUpdate");

        std::optional<CLuaBaseEntity> optTarget = std::nullopt;
        if (PChar->m_event.Target)
        {
            optTarget = CLuaBaseEntity(PChar->m_event.Target);
        }

        auto func_result = onEventUpdateFramework(CLuaBaseEntity(PChar), eventID, result, optTarget, onEventUpdate);
        if (!func_result.valid())
        {
            sol::error err = func_result;
            ShowError("luautils::onEventUpdate: %s\n", err.what());
            return -1;
        }

        return func_result.get_type() == sol::type::number ? func_result.get<int32>() : 1;
    }

    int32 OnEventUpdate(CCharEntity* PChar, std::string const& updateString)
    {
        TracyZoneScoped;

        auto onEventUpdateFramework = lua["xi"]["globals"]["interaction"]["interaction_global"]["onEventUpdate"];
        auto onEventUpdate = LoadEventScript(PChar, "onEventUpdate");

        std::optional<CLuaBaseEntity> optTarget = std::nullopt;
        if (PChar->m_event.Target)
        {
            optTarget = CLuaBaseEntity(PChar->m_event.Target);
        }

        auto result = onEventUpdateFramework(CLuaBaseEntity(PChar), PChar->m_event.EventID, updateString, optTarget, onEventUpdate);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onEventUpdate: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Событие завершилось, результат события хранится в result             *
     *                                                                       *
     ************************************************************************/

    int32 OnEventFinish(CCharEntity* PChar, uint16 eventID, uint32 result)
    {
        TracyZoneScoped;

        auto onEventFinishFramework = lua["xi"]["globals"]["interaction"]["interaction_global"]["onEventFinish"];
        auto onEventFinish = LoadEventScript(PChar, "onEventFinish");

        std::optional<CLuaBaseEntity> optTarget = std::nullopt;
        if (PChar->m_event.Target)
        {
            if (PChar->m_event.Target->objtype == TYPE_NPC)
            {
                PChar->m_event.Target->SetLocalVar("pauseNPCPathing", 0);
            }

            optTarget = CLuaBaseEntity(PChar->m_event.Target);
        }

        auto func_result = onEventFinishFramework(CLuaBaseEntity(PChar), eventID, result, optTarget, onEventFinish);
        if (!func_result.valid())
        {
            sol::error err = func_result;
            ShowError("luautils::onEventFinish %s\n", err.what());
            return -1;
        }

        if (PChar->m_event.Script.find("/bcnms/") > 0 && PChar->health.hp <= 0)
        { // for some reason the event doesnt enforce death afterwards
            PChar->animation = ANIMATION_DEATH;
            PChar->pushPacket(new CRaiseTractorMenuPacket(PChar, TYPE_HOMEPOINT));
            PChar->updatemask |= UPDATE_HP;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Персонаж пытается передать предмет npc                               *
     *                                                                       *
     ************************************************************************/

    int32 OnTrade(CCharEntity* PChar, CBaseEntity* PNpc)
    {
        TracyZoneScoped;

        auto zone     = (const char*)PChar->loc.zone->GetName();
        auto name     = (const char*)PNpc->GetName();
        auto filename = fmt::format("./scripts/zones/{}/npcs/{}.lua", zone, name);

        PChar->m_event.reset();
        PChar->m_event.Target = PNpc;
        PChar->m_event.Script = filename;

        auto onTradeFramework = lua["xi"]["globals"]["interaction"]["interaction_global"]["onTrade"];
        auto onTrade = lua["xi"]["zones"][zone]["npcs"][name]["onTrade"];

        auto result = onTradeFramework(CLuaBaseEntity(PChar), CLuaBaseEntity(PNpc), CLuaTradeContainer(PChar->TradeContainer), onTrade);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTrade: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnNpcSpawn(CBaseEntity* PNpc)
    {
        TracyZoneScoped;

        if (PNpc == nullptr)
        {
            ShowError("luautils::onNpcSpawn: Npc not found!\n");
            return 0;
        }

        auto onSpawn = getEntityCachedFunction(PNpc, "onSpawn");
        if (!onSpawn.valid())
        {
            return -1;
        }

        auto result = onSpawn(CLuaBaseEntity(PNpc));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onNpcSpawn: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnAdditionalEffect(CBattleEntity* PAttacker, CBattleEntity* PDefender, CItemWeapon* PItem, actionTarget_t* Action, int32 damage)
    {
        TracyZoneScoped;

        sol::function onAdditionalEffect;
        if (PAttacker->objtype == TYPE_PC)
        {
            auto name          = (const char*)PItem->getName();
            onAdditionalEffect = lua[sol::create_if_nil]["xi"]["globals"]["items"][name]["onAdditionalEffect"];
        }
        else
        {
            auto zone          = (const char*)PAttacker->loc.zone->GetName();
            auto name          = (const char*)PAttacker->GetName();
            onAdditionalEffect = lua[sol::create_if_nil]["xi"]["zones"][zone]["mobs"][name]["onAdditionalEffect"];
        }

        if (!onAdditionalEffect.valid())
        {
            return -1;
        }

        auto result = onAdditionalEffect(CLuaBaseEntity(PAttacker), CLuaBaseEntity(PDefender), damage);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onAdditionalEffect: %s\n", err.what());
            return -1;
        }

        Action->additionalEffect = (SUBEFFECT)(result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0);
        Action->addEffectMessage = result.get_type(1) == sol::type::number ? result.get<int32>(1) : 0;
        Action->addEffectParam   = result.get_type(2) == sol::type::number ? result.get<int32>(2) : 0;

        return 0;
    }

    int32 OnSpikesDamage(CBattleEntity* PDefender, CBattleEntity* PAttacker, actionTarget_t* Action, uint32 damage)
    {
        TracyZoneScoped;

        auto zone = (const char*)PDefender->loc.zone->GetName();
        auto name = (const char*)PDefender->GetName();

        auto onSpikesDamage = lua["xi"]["zones"][zone]["mobs"][name]["onSpikesDamage"];
        if (!onSpikesDamage.valid())
        {
            return -1;
        }

        auto result = onSpikesDamage(CLuaBaseEntity(PDefender), CLuaBaseEntity(PAttacker), damage);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onSpikesDamage: %s\n", err.what());
            return -1;
        }

        Action->additionalEffect = (SUBEFFECT)(result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0);
        Action->addEffectMessage = result.get_type(1) == sol::type::number ? result.get<int32>(1) : 0;
        Action->addEffectParam   = result.get_type(2) == sol::type::number ? result.get<int32>(2) : 0;

        return 0;
    }

    int32 OnEffectGain(CBattleEntity* PEntity, CStatusEffect* PStatusEffect)
    {
        TracyZoneScoped;

        std::string filename = fmt::format("./scripts/{}.lua", PStatusEffect->GetName());

        sol::function onEffectGain = GetCacheEntryFromFilename(filename)["onEffectGain"].get<sol::function>();
        if (!onEffectGain.valid())
        {
            return -1;
        }

        auto result = onEffectGain(CLuaBaseEntity(PEntity), CLuaStatusEffect(PStatusEffect));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onEffectGain: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnEffectTick(CBattleEntity* PEntity, CStatusEffect* PStatusEffect)
    {
        TracyZoneScoped;

        std::string filename = fmt::format("./scripts/{}.lua", PStatusEffect->GetName());

        sol::function onEffectTick = GetCacheEntryFromFilename(filename)["onEffectTick"].get<sol::function>();
        if (!onEffectTick.valid())
        {
            return -1;
        }

        auto result = onEffectTick(CLuaBaseEntity(PEntity), CLuaStatusEffect(PStatusEffect));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onEffectTick: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnEffectLose(CBattleEntity* PEntity, CStatusEffect* PStatusEffect)
    {
        TracyZoneScoped;

        std::string filename = fmt::format("./scripts/{}.lua", PStatusEffect->GetName());

        sol::function onEffectLose = GetCacheEntryFromFilename(filename)["onEffectLose"].get<sol::function>();
        if (!onEffectLose.valid())
        {
            return -1;
        }

        auto result = onEffectLose(CLuaBaseEntity(PEntity), CLuaStatusEffect(PStatusEffect));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onEffectLose: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnAttachmentEquip(CBattleEntity* PEntity, CItemPuppet* attachment)
    {
        TracyZoneScoped;

        auto name = (const char*)attachment->getName();

        auto onEquip = lua["xi"]["globals"]["abilities"]["pets"]["attachments"][name]["onEquip"];
        if (!onEquip.valid())
        {
            return -1;
        }

        auto result = onEquip(CLuaBaseEntity(PEntity));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onEquip: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnAttachmentUnequip(CBattleEntity* PEntity, CItemPuppet* attachment)
    {
        TracyZoneScoped;

        auto name = (const char*)attachment->getName();

        auto onUnequip = lua["xi"]["globals"]["abilities"]["pets"]["attachments"][name]["onUnequip"];
        if (!onUnequip.valid())
        {
            return -1;
        }

        auto result = onUnequip(CLuaBaseEntity(PEntity));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onUnequip: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnManeuverGain(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers)
    {
        TracyZoneScoped;

        auto name = (const char*)attachment->getName();

        auto onManeuverGain = lua["xi"]["globals"]["abilities"]["pets"]["attachments"][name]["onManeuverGain"];
        if (!onManeuverGain.valid())
        {
            return -1;
        }

        auto result = onManeuverGain(CLuaBaseEntity(PEntity), maneuvers);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onManeuverGain: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnManeuverLose(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers)
    {
        TracyZoneScoped;

        auto name = (const char*)attachment->getName();

        auto onManeuverLose = lua["xi"]["globals"]["abilities"]["pets"]["attachments"][name]["onManeuverLose"];
        if (!onManeuverLose.valid())
        {
            return -1;
        }

        auto result = onManeuverLose(CLuaBaseEntity(PEntity), maneuvers);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onManeuverLose: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnUpdateAttachment(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers)
    {
        TracyZoneScoped;

        auto name = (const char*)attachment->getName();

        auto onUpdate = lua["xi"]["globals"]["abilities"]["pets"]["attachments"][name]["onUpdate"];
        if (!onUpdate.valid())
        {
            return -1;
        }

        auto result = onUpdate(CLuaBaseEntity(PEntity), maneuvers);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onUpdate: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    // We check the possibility of using the item.
    // If all is well, then return value - 0, in case of failure - error message number
    std::tuple<int32, int32, int32> OnItemCheck(CBaseEntity* PTarget, CItem* PItem, ITEMCHECK param, CBaseEntity* PCaster)
    {
        TracyZoneScoped;

        auto filename = fmt::format("./scripts/globals/items/{}.lua", PItem->getName());

        sol::function onItemCheck = GetCacheEntryFromFilename(filename)["onItemCheck"].get<sol::function>();
        if (!onItemCheck.valid())
        {
            return { 56, 0, 0 };
        }

        std::optional<CLuaBaseEntity> caster = std::nullopt;
        if (PCaster)
        {
            caster = CLuaBaseEntity(PCaster);
        }

        auto result = onItemCheck(CLuaBaseEntity(PTarget), static_cast<uint32>(param), caster);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onItemCheck: %s\n", err.what());
            return { 56, 0, 0 };
        }

        uint32 messageId = result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
        uint32 param1    = result.get_type(1) == sol::type::number ? result.get<int32>(1) : 0;
        uint32 param2    = result.get_type(2) == sol::type::number ? result.get<int32>(2) : 0;

        return { messageId, param1, param2 };
    }

    // We use the subject. The return value is the message number or 0.
    // It is also necessary to somehow pass the message parameter (for example,
    // number of recovered MP)
    int32 OnItemUse(CBaseEntity* PTarget, CItem* PItem)
    {
        TracyZoneScoped;

        auto filename = fmt::format("./scripts/globals/items/{}.lua", PItem->getName());

        sol::function onItemUse = GetCacheEntryFromFilename(filename)["onItemUse"].get<sol::function>();
        if (!onItemUse.valid())
        {
            return -1;
        }

        auto result = onItemUse(CLuaBaseEntity(PTarget));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onItemUse: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    // Check for gear sets  (e.g Set: enhances haste effect)
    int32 CheckForGearSet(CBaseEntity* PTarget)
    {
        TracyZoneScoped;

        // TODO: This shouldn't be global, attach to xi.gear_sets or similar
        auto checkForGearSet = lua["checkForGearSet"];
        if (!checkForGearSet.valid())
        {
            return 56;
        }

        auto result = checkForGearSet(CLuaBaseEntity(PTarget));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::CheckForGearSet: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    uint32 OnSpellCast(CBattleEntity* PCaster, CBattleEntity* PTarget, CSpell* PSpell)
    {
        TracyZoneScoped;

        if (PSpell == nullptr)
        {
            ShowError("luautils::OnSpellCast: Spell not found!\n");
            return -1;
        }

        auto onSpellCast = getSpellCachedFunction(PSpell, "onSpellCast");
        if (!onSpellCast.valid())
        {
            return -1;
        }

        auto result = onSpellCast(CLuaBaseEntity(PCaster), CLuaBaseEntity(PTarget), CLuaSpell(PSpell));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onSpellCast: %s\n", err.what());
            return -1;
        }

        uint32 retVal = result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
        return retVal;
    }

    int32 OnSpellPrecast(CBattleEntity* PCaster, CSpell* PSpell)
    {
        TracyZoneScoped;

        if (PCaster->objtype != TYPE_MOB)
        {
            return -1;
        }

        sol::function onSpellPrecast = getEntityCachedFunction(PCaster, "onSpellPrecast");
        if (!onSpellPrecast.valid())
        {
            return 0;
        }

        auto result = onSpellPrecast(CLuaBaseEntity(PCaster), CLuaSpell(PSpell));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onSpellPrecast: %s\n", err.what());
            return 0;
        }

        return 0;
    }

    std::optional<SpellID> OnMonsterMagicPrepare(CBattleEntity* PCaster, CBattleEntity* PTarget)
    {
        TracyZoneScoped;

        if (PCaster == nullptr || PTarget == nullptr)
        {
            return {};
        }

        sol::function onMonsterMagicPrepare = getEntityCachedFunction(PCaster, "onMonsterMagicPrepare");
        if (!onMonsterMagicPrepare.valid())
        {
            return {};
        }

        auto result = onMonsterMagicPrepare(CLuaBaseEntity(PCaster), CLuaBaseEntity(PTarget));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMonsterMagicPrepare: %s\n", err.what());
            return {};
        }

        uint32 retVal = result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
        if (retVal > 0)
        {
            return static_cast<SpellID>(retVal);
        }

        return {};
    }

    // Called when mob is targeted by a spell.
    // Note: does not differentiate between offensive and defensive spells
    int32 OnMagicHit(CBattleEntity* PCaster, CBattleEntity* PTarget, CSpell* PSpell)
    {
        TracyZoneScoped;

        if (PSpell == nullptr)
        {
            return -1;
        }

        PTarget->PAI->EventHandler.triggerListener("MAGIC_TAKE", CLuaBaseEntity(PTarget), CLuaBaseEntity(PCaster), CLuaSpell(PSpell));

        sol::function onMagicHit = getEntityCachedFunction(PTarget, "onMagicHit");
        if (!onMagicHit.valid())
        {
            return 0;
        }

        auto result = onMagicHit(CLuaBaseEntity(PCaster), CLuaBaseEntity(PTarget), CLuaSpell(PSpell));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMagicHit: %s\n", err.what());
            return -1;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
    }

    // Called when mob is struck by a Weaponskill
    int32 OnWeaponskillHit(CBattleEntity* PMob, CBaseEntity* PAttacker, uint16 PWeaponskill)
    {
        TracyZoneScoped;

        sol::function onWeaponskillHit = getEntityCachedFunction(PMob, "onWeaponskillHit");
        if (!onWeaponskillHit.valid())
        {
            return 0;
        }

        auto result = onWeaponskillHit(CLuaBaseEntity(PMob), CLuaBaseEntity(PAttacker), PWeaponskill);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onWeaponskillHit: %s\n", err.what());
            return 0;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
    }

    int32 OnMobInitialize(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        sol::function onMobInitialize = getEntityCachedFunction(PMob, "onMobInitialize");
        if (!onMobInitialize.valid())
        {
            return -1;
        }

        auto result = onMobInitialize(CLuaBaseEntity(PMob));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobInitialize: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    // Called during server startup, file reads are OK!
    int32 ApplyMixins(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr || PMob->objtype != TYPE_MOB)
        {
            return -1;
        }

        // Clear out globals
        lua.set("mixins", sol::nil);
        lua.set("mixinOptions", sol::nil);

        auto zone_name = (const char*)PMob->loc.zone->GetName();
        auto name      = (const char*)PMob->GetName();

        auto filename = fmt::format("./scripts/zones/{}/mobs/{}.lua", zone_name, name);

        auto script_result = lua.script_file(filename);
        if (!script_result.valid())
        {
            return -1;
        }

        // get the global function "applyMixins"
        sol::function applyMixins = lua["applyMixins"];
        if (!applyMixins.valid())
        {
            return -1;
        }

        // get the parameter "mixins"
        auto mixins = lua["mixins"];
        if (!mixins.valid())
        {
            return -1;
        }

        // get the parameter "mixinOptions" (optional)
        auto mixinOptions = lua["mixinOptions"];

        auto result = applyMixins(CLuaBaseEntity(PMob), mixins, mixinOptions);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::applyMixins: %s\n", err.what());
        }

        return 0;
    }

    // Called during server startup, file reads are OK!
    int32 ApplyZoneMixins(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr || PMob->objtype != TYPE_MOB)
        {
            return -1;
        }

        // Clear out any previous global definitions
        lua.set("mixins", sol::nil);
        lua.set("mixinOptions", sol::nil);

        auto filename = fmt::format("./scripts/mixins/zones/{}.lua", PMob->loc.zone->GetName());

        auto script_result = lua.script_file(filename);
        if (!script_result.valid())
        {
            return -1;
        }

        // get the global function "applyMixins"
        sol::function applyMixins = lua["applyMixins"];
        if (!applyMixins.valid())
        {
            return -1;
        }

        // get the parameter "mixins"
        auto mixins = lua["mixins"];
        if (!mixins.valid())
        {
            return -1;
        }

        // get the parameter "mixinOptions" (optional)
        auto mixinOptions = lua["mixinOptions"];

        auto result = applyMixins(CLuaBaseEntity(PMob), mixins, mixinOptions);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::applyMixins %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnPath(CBaseEntity* PEntity)
    {
        TracyZoneScoped;

        if (PEntity == nullptr || PEntity->objtype == TYPE_PC)
        {
            return -1;
        }

        sol::function onPath = getEntityCachedFunction(PEntity, "onPath");
        if (!onPath.valid())
        {
            return -1;
        }

        auto result = onPath(CLuaBaseEntity(PEntity));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPath: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnBattlefieldHandlerInitialise(CZone* PZone)
    {
        TracyZoneScoped;

        if (PZone == nullptr)
        {
            return -1;
        }

        int32 MaxAreas = 3;

        // TODO: This is loaded globally, fix this
        auto onBattlefieldHandlerInitialise = lua["onBattlefieldHandlerInitialise"];
        if (!onBattlefieldHandlerInitialise.valid())
        {
            return MaxAreas;
        }

        CLuaZone LuaZone(PZone);

        auto result = onBattlefieldHandlerInitialise(CLuaZone(PZone));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onBattlefieldHandlerInitialise: %s\n", err.what());
            return MaxAreas;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : MaxAreas;
    }

    int32 OnBattlefieldInitialise(CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        if (PBattlefield == nullptr)
        {
            return -1;
        }

        auto zone = (const char*)PBattlefield->GetZone()->GetName();
        auto name = PBattlefield->GetName();

        // TODO: This will happen more often than needed, but not so often that it's a performance concern
        auto filename = fmt::format("./scripts/zones/{}/bcnms/{}.lua", zone, name);
        CacheLuaObjectFromFile(filename);

        auto onBattlefieldInitialise = lua["xi"]["zones"][zone]["bcnms"][name]["onBattlefieldInitialise"];
        if (!onBattlefieldInitialise.valid())
        {
            return -1;
        }

        auto result = onBattlefieldInitialise(CLuaBattlefield(PBattlefield));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onBattlefieldInitialise: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnBattlefieldTick(CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        if (PBattlefield == nullptr)
        {
            return -1;
        }

        auto zone = (const char*)PBattlefield->GetZone()->GetName();
        auto name = PBattlefield->GetName();

        auto onBattlefieldTick = lua["xi"]["zones"][zone]["bcnms"][name]["onBattlefieldTick"];
        if (!onBattlefieldTick.valid())
        {
            ShowError("luautils::onBattlefieldTick: Unable to find onBattlefieldTick function for %s\n", name);
            return -1;
        }

        auto seconds = std::chrono::duration_cast<std::chrono::seconds>(PBattlefield->GetTimeInside()).count();
        auto result  = onBattlefieldTick(CLuaBattlefield(PBattlefield), seconds);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onBattlefieldTick: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnBattlefieldStatusChange(CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        if (PBattlefield == nullptr)
        {
            return -1;
        }

        auto zone = (const char*)PBattlefield->GetZone()->GetName();
        auto name = PBattlefield->GetName();

        auto onBattlefieldStatusChange = lua["xi"]["zones"][zone]["bcnms"][name]["onBattlefieldStatusChange"];
        if (!onBattlefieldStatusChange.valid())
        {
            return -1;
        }

        auto result = onBattlefieldStatusChange(CLuaBattlefield(PBattlefield), PBattlefield->GetStatus());
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onBattlefieldStatusChange: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Сalled when a monster engages a target for the first time            *
     *                                                                       *
     ************************************************************************/

    int32 OnMobEngaged(CBaseEntity* PMob, CBaseEntity* PTarget)
    {
        TracyZoneScoped;

        if (PTarget == nullptr || PMob == nullptr)
        {
            return -1;
        }

        std::string filename;
        if (PMob->objtype == TYPE_PET)
        {
            filename = fmt::format("./scripts/globals/pets/{}.lua", static_cast<CPetEntity*>(PMob)->GetScriptName());
        }
        else
        {
            filename = fmt::format("./scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());
        }

        if (PTarget->objtype == TYPE_PC)
        {
            ((CCharEntity*)PTarget)->m_event.reset();
            ((CCharEntity*)PTarget)->m_event.Target = PMob;
            ((CCharEntity*)PTarget)->m_event.Script = filename;
        }

        sol::function onMobEngaged = getEntityCachedFunction(PMob, "onMobEngaged");
        if (!onMobEngaged.valid())
        {
            return -1;
        }

        auto result = onMobEngaged(CLuaBaseEntity(PMob), CLuaBaseEntity(PTarget));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobEngaged: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Calls a lua script when a mob has disengaged from a target           *
     *                                                                       *
     ************************************************************************/

    int32 OnMobDisengage(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr)
        {
            return -1;
        }

        sol::function onMobDisengage = getEntityCachedFunction(PMob, "onMobDisengage");
        if (!onMobDisengage.valid())
        {
            return -1;
        }

        uint8 weather = PMob->loc.zone->GetWeather();

        auto result = onMobDisengage(CLuaBaseEntity(PMob), weather);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobDisengage: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnMobDrawIn(CBaseEntity* PMob, CBaseEntity* PTarget)
    {
        TracyZoneScoped;

        if (PTarget == nullptr || PMob == nullptr)
        {
            return -1;
        }

        auto filename = fmt::format("./scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (PTarget->objtype == TYPE_PC)
        {
            ((CCharEntity*)PTarget)->m_event.reset();
            ((CCharEntity*)PTarget)->m_event.Target = PMob;
            ((CCharEntity*)PTarget)->m_event.Script = filename;
        }

        sol::function onMobDrawIn = getEntityCachedFunction(PMob, "onMobDrawIn");
        if (!onMobDrawIn.valid())
        {
            return -1;
        }

        auto result = onMobDrawIn(CLuaBaseEntity(PMob), CLuaBaseEntity(PTarget));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobDrawIn: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Сalled every 3 sec when a player fight monster                       *
     *                                                                       *
     ************************************************************************/

    int32 OnMobFight(CBaseEntity* PMob, CBaseEntity* PTarget)
    {
        TracyZoneScoped;

        if (PTarget == nullptr || PMob == nullptr)
        {
            return -1;
        }

        sol::function onMobFight = getEntityCachedFunction(PMob, "onMobFight");
        if (!onMobFight.valid())
        {
            return -1;
        }

        auto result = onMobFight(CLuaBaseEntity(PMob), CLuaBaseEntity(PTarget));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobFight: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnCriticalHit(CBattleEntity* PMob, CBattleEntity* PAttacker)
    {
        TracyZoneScoped;

        if (PMob == nullptr)
        {
            return -1;
        }

        sol::function onCriticalHit = getEntityCachedFunction(PMob, "onCriticalHit");
        if (!onCriticalHit.valid())
        {
            return -1;
        }

        std::optional<CLuaBaseEntity> optionalKiller = std::nullopt;
        if (PAttacker)
        {
            optionalKiller = CLuaBaseEntity(PAttacker);
        }

        auto result = onCriticalHit(CLuaBaseEntity(PMob), optionalKiller);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onCriticalHit %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  The script is executed after the death of any monster in the game    *
     *                                                                       *
     ************************************************************************/

    int32 OnMobDeath(CBaseEntity* PMob, CBaseEntity* PKiller)
    {
        TracyZoneScoped;

        if (PMob == nullptr)
        {
            return -1;
        }

        // TODO: These int8 string need to die.
        std::string zone_name = (const char*)PMob->loc.zone->GetName();
        std::string mob_name  = (const char*)PMob->GetName();

        CCharEntity* PChar = dynamic_cast<CCharEntity*>(PKiller);
        if (PChar && PMob->objtype == TYPE_MOB)
        {
            // TODO: Don't save this globally
            auto onMobDeathEx = lua["onMobDeathEx"];
            if (!onMobDeathEx.valid())
            {
                return -1;
            }

            PChar->ForAlliance([PMob, PChar, &onMobDeathEx](CBattleEntity* PMember) {
                if (PMember->getZone() == PChar->getZone())
                {
                    CLuaBaseEntity LuaMobEntity(PMob);
                    CLuaBaseEntity LuaAllyEntity(PMember);
                    bool           isKiller          = PMember == PChar;
                    bool           isWeaponSkillKill = PChar->getWeaponSkillKill();

                    auto result = onMobDeathEx(LuaMobEntity, LuaAllyEntity, isKiller, isWeaponSkillKill);
                    if (!result.valid())
                    {
                        sol::error err = result;
                        ShowError("luautils::onMobDeathEx: %s\n", err.what());
                    }
                }
            });

            auto filename = fmt::format("./scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());

            auto onMobDeathFramework = lua["xi"]["globals"]["interaction"]["interaction_global"]["onMobDeath"];
            sol::function onMobDeath = getEntityCachedFunction(PMob, "onMobDeath");

            PChar->ForAlliance([PMob, PChar, &onMobDeathFramework, &onMobDeath, &filename](CBattleEntity* PPartyMember) {
                CCharEntity* PMember = (CCharEntity*)PPartyMember;
                if (PMember && PMember->getZone() == PChar->getZone())
                {
                    CLuaBaseEntity                LuaMobEntity(PMob);
                    std::optional<CLuaBaseEntity> optLuaAllyEntity = std::nullopt;
                    if (PMember)
                    {
                        optLuaAllyEntity = CLuaBaseEntity(PMember);
                    }
                    bool isKiller = PMember == PChar;
                    bool noKiller = false;

                    PMember->m_event.reset();
                    PMember->m_event.Target = PMob;
                    PMember->m_event.Script = filename;

                    // onMobDeath(mob, player, isKiller, noKiller)
                    auto result = onMobDeathFramework(LuaMobEntity, optLuaAllyEntity, isKiller, noKiller, onMobDeath);
                    if (!result.valid())
                    {
                        sol::error err = result;
                        ShowError("luautils::onMobDeath: %s\n", err.what());
                    }
                }
            });
        }
        else
        {
            auto onMobDeathFramework = lua["xi"]["globals"]["interaction"]["interaction_global"]["onMobDeath"];
            sol::function onMobDeath = getEntityCachedFunction(PMob, "onMobDeath");

            // onMobDeath(mob, player, isKiller, noKiller)
            auto result = onMobDeathFramework(CLuaBaseEntity(PMob), sol::nil, sol::nil, true, onMobDeath);
            if (!result.valid())
            {
                sol::error err = result;
                ShowError("luautils::onMobDeath: %s\n", err.what());
                return -1;
            }
        }

        return 0;
    }

    int32 OnMobSpawn(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr)
        {
            return -1;
        }

        sol::function onMobSpawn = getEntityCachedFunction(PMob, "onMobSpawn");
        if (!onMobSpawn.valid())
        {
            return -1;
        }

        auto result = onMobSpawn(CLuaBaseEntity(PMob));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobSpawn: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnMobRoamAction(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr || PMob->objtype != TYPE_MOB)
        {
            return -1;
        }

        sol::function onMobRoamAction = getEntityCachedFunction(PMob, "onMobRoamAction");
        if (!onMobRoamAction.valid())
        {
            return -1;
        }

        auto result = onMobRoamAction(CLuaBaseEntity(PMob));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobRoonMobRoamActionam: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnMobRoam(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        sol::function onMobRoam = getEntityCachedFunction(PMob, "onMobRoam");
        if (!onMobRoam.valid())
        {
            return -1;
        }

        auto result = onMobRoam(CLuaBaseEntity(PMob));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobRoam: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnMobDespawn(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr)
        {
            return -1;
        }

        auto onMobDespawn = getEntityCachedFunction(PMob, "onMobDespawn");
        if (!onMobDespawn.valid())
        {
            return -1;
        }

        auto result = onMobDespawn(CLuaBaseEntity(PMob));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobDespawn: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *   OnGameDayAutomatisation()                                           *
     *   used for creating action of npc every game day                      *
     *                                                                       *
     ************************************************************************/

    int32 OnGameDay(CZone* PZone)
    {
        TracyZoneScoped;

        auto name = (const char*)PZone->GetName();

        auto onGameDay = lua["xi"]["zones"][name]["Zone"]["onGameDay"];
        if (!onGameDay.valid())
        {
            return -1;
        }

        auto result = onGameDay();
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onGameDay: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *   OnGameHourAutomatisation()                                          *
     *   used for creating action of npc every game hour                     *
     *                                                                       *
     ************************************************************************/

    int32 OnGameHour(CZone* PZone)
    {
        TracyZoneScoped;

        auto name = (const char*)PZone->GetName();

        auto onGameHour = lua["xi"]["zones"][name]["Zone"]["onGameHour"];
        if (!onGameHour.valid())
        {
            return -1;
        }

        auto result = onGameHour(CLuaZone(PZone));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onGameHour: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnZoneWeatherChange(uint16 ZoneID, uint8 weather)
    {
        TracyZoneScoped;

        auto name = (const char*)zoneutils::GetZone(ZoneID)->GetName();

        auto onZoneWeatherChange = lua["xi"]["zones"][name]["Zone"]["onZoneWeatherChange"];
        if (!onZoneWeatherChange.valid())
        {
            return -1;
        }

        auto result = onZoneWeatherChange(weather);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onZoneWeatherChange: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnTOTDChange(uint16 ZoneID, uint8 TOTD)
    {
        TracyZoneScoped;

        auto name = (const char*)zoneutils::GetZone(ZoneID)->GetName();

        auto onTOTDChange = lua["xi"]["zones"][name]["Zone"]["onTOTDChange"];
        if (!onTOTDChange.valid())
        {
            return -1;
        }

        auto result = onTOTDChange(TOTD);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTOTDChange: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    std::tuple<int32, uint8, uint8> OnUseWeaponSkill(CBattleEntity* PChar, CBaseEntity* PMob, CWeaponSkill* wskill, uint16 tp, bool primary, action_t& action,
                                                     CBattleEntity* taChar)
    {
        TracyZoneScoped;

        auto name = (const char*)wskill->getName();

        auto onUseWeaponSkill = lua["xi"]["globals"]["weaponskills"][name]["onUseWeaponSkill"];
        if (!onUseWeaponSkill.valid())
        {
            return std::tuple<int32, uint8, uint8>();
        }

        std::optional<CLuaBaseEntity> optTrickAttackLuaChar = std::nullopt;
        if (taChar)
        {
            optTrickAttackLuaChar = CLuaBaseEntity(taChar);
        }

        auto result = onUseWeaponSkill(CLuaBaseEntity(PChar), CLuaBaseEntity(PMob), wskill->getID(), tp, primary, CLuaAction(&action), optTrickAttackLuaChar);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onUseWeaponSkill: %s\n", err.what());
            return std::tuple<int32, uint8, uint8>();
        }

        uint8 tpHitsLanded    = result.get_type(0) == sol::type::number ? result.get<uint8>(0) : 0;
        uint8 extraHitsLanded = result.get_type(1) == sol::type::number ? result.get<uint8>(1) : 0;
        bool  criticalHit     = result.get_type(2) == sol::type::boolean ? result.get<bool>(2) : false;
        int32 dmg             = result.get_type(3) == sol::type::number ? result.get<int32>(3) : 0;

        if (criticalHit)
        {
            luautils::OnCriticalHit((CBattleEntity*)PMob, (CBattleEntity*)PChar);
        }

        return std::make_tuple(dmg, tpHitsLanded, extraHitsLanded);
    }

    int32 OnMobWeaponSkill(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill, action_t* action)
    {
        TracyZoneScoped;

        // Mob Script
        {
            auto zone = (const char*)PMob->loc.zone->GetName();
            auto name = (const char*)PMob->GetName();

            auto onMobWeaponSkill = lua["xi"]["zones"][zone]["mobs"][name]["onMobWeaponSkill"];
            if (onMobWeaponSkill.valid())
            {
                auto result = onMobWeaponSkill(CLuaBaseEntity(PTarget), CLuaBaseEntity(PMob), CLuaMobSkill(PMobSkill), CLuaAction(action));
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError("luautils::onMobWeaponSkill (mob) %s\n", err.what());
                    return 0;
                }
            }
        }

        // Mob Skill Script
        auto mobskill_name = (const char*)PMobSkill->getName();

        auto onMobWeaponSkill = lua["xi"]["globals"]["mobskills"][mobskill_name]["onMobWeaponSkill"];
        if (!onMobWeaponSkill.valid())
        {
            return 0;
        }

        auto result = onMobWeaponSkill(CLuaBaseEntity(PTarget), CLuaBaseEntity(PMob), CLuaMobSkill(PMobSkill));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobWeaponSkill (mobskill) %s\n", err.what());
            return 0;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
    }

    int32 OnMobSkillCheck(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill)
    {
        TracyZoneScoped;

        auto name = (const char*)PMobSkill->getName();

        auto onMobSkillCheck = lua["xi"]["globals"]["mobskills"][name]["onMobSkillCheck"];
        if (!onMobSkillCheck.valid())
        {
            return 1;
        }

        auto result = onMobSkillCheck(CLuaBaseEntity(PTarget), CLuaBaseEntity(PMob), CLuaMobSkill(PMobSkill));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobSkillCheck: %s\n", err.what());
            return 1;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : -5;
    }

    int32 OnMobAutomatonSkillCheck(CBaseEntity* PTarget, CAutomatonEntity* PAutomaton, CMobSkill* PMobSkill)
    {
        TracyZoneScoped;

        auto name = (const char*)PMobSkill->getName();

        auto onMobSkillCheck = lua["xi"]["globals"]["abilities"]["pets"][name]["onMobSkillCheck"];
        if (!onMobSkillCheck.valid())
        {
            return 1;
        }

        auto result = onMobSkillCheck(CLuaBaseEntity(PTarget), CLuaBaseEntity(PAutomaton), CLuaMobSkill(PMobSkill));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobSkillCheck: %s\n", err.what());
            return 1;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : -5;
    }

    /***********************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnMagicCastingCheck(CBaseEntity* PChar, CBaseEntity* PTarget, CSpell* PSpell)
    {
        TracyZoneScoped;

        auto onMagicCastingCheck = getSpellCachedFunction(PSpell, "onMagicCastingCheck");
        if (!onMagicCastingCheck.valid())
        {
            ShowWarning("luautils::onMagicCastingCheck\n");
            return 47;
        }

        auto result = onMagicCastingCheck(CLuaBaseEntity(PChar), CLuaBaseEntity(PTarget), CLuaSpell(PSpell));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMagicCastingCheck (%s): %s\n", PSpell->getName(), err.what());
            return 47;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : -5;
    }

    /***********************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnAbilityCheck(CBaseEntity* PChar, CBaseEntity* PTarget, CAbility* PAbility, CBaseEntity** PMsgTarget)
    {
        TracyZoneScoped;

        if (PAbility == nullptr)
        {
            ShowError("luautils::OnAbilityCheck: Invalid PAbility\n");
            return 87;
        }

        std::string filename;
        if (PAbility->isPetAbility())
        {
            filename = fmt::format("./scripts/globals/abilities/pets/{}.lua", PAbility->getName());
        }
        else
        {
            filename = fmt::format("./scripts/globals/abilities/{}.lua", PAbility->getName());
        }

        sol::function onAbilityCheck = GetCacheEntryFromFilename(filename)["onAbilityCheck"];
        if (!onAbilityCheck.valid())
        {
            // TODO: We rely on this to fail silently in certain cases, but this is bad :(
            //ShowWarning("luautils::onAbilityCheck - Ability %s not found.\n", PAbility->getName());
            return 0;
        }

        auto result = onAbilityCheck(CLuaBaseEntity(PChar), CLuaBaseEntity(PTarget), CLuaAbility(PAbility));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onAbilityCheck (%s): %s\n", PAbility->getName(), err.what());
            return 87;
        }

        auto result0 = result.get<int32>(0); // Message (0 = None)
        auto result1 = result.get<int32>(1);
        if (result1 != 0)
        {
            *PMsgTarget = (CBaseEntity*)PTarget;
        }

        return result0 ? result0 : 0; // Default to no Message
    }

    /***********************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnPetAbility(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill, CBaseEntity* PMobMaster, action_t* action)
    {
        TracyZoneScoped;

        std::string filename = fmt::format("./scripts/globals/abilities/pets/{}.lua", PMobSkill->getName());

        sol::function onPetAbility = GetCacheEntryFromFilename(filename)["onPetAbility"];
        if (!onPetAbility.valid())
        {
            return 0;
        }

        auto result = onPetAbility(CLuaBaseEntity(PTarget), CLuaBaseEntity(PMob), CLuaMobSkill(PMobSkill), CLuaBaseEntity(PMobMaster), CLuaAction(action));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPetAbility: %s\n", err.what());
            return 0;
        }

        // Bloodpact Skillups
        // TODO: This probably shouldn't be in here
        if (PMob->objtype == TYPE_PET && map_config.skillup_bloodpact)
        {
            CPetEntity* PPet = (CPetEntity*)PMob;
            if (PPet->getPetType() == PET_TYPE::AVATAR && PPet->PMaster->objtype == TYPE_PC)
            {
                CCharEntity* PMaster = (CCharEntity*)PPet->PMaster;
                if (PMaster->GetMJob() == JOB_SMN)
                {
                    charutils::TrySkillUP(PMaster, SKILL_SUMMONING_MAGIC, PMaster->GetMLevel());
                }
            }
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
    }

    /************************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnUseAbility(CBattleEntity* PUser, CBattleEntity* PTarget, CAbility* PAbility, action_t* action)
    {
        TracyZoneScoped;

        std::string filename;
        if (PAbility->isPetAbility())
        {
            filename = fmt::format("./scripts/globals/abilities/pets/{}.lua", PAbility->getName());
        }
        else
        {
            filename = fmt::format("./scripts/globals/abilities/{}.lua", PAbility->getName());
        }

        sol::function onUseAbility = GetCacheEntryFromFilename(filename)["onUseAbility"];
        if (!onUseAbility.valid())
        {
            ShowWarning("luautils::onUseAbility - Ability %s not found.\n", PAbility->getName());
            return 0;
        }

        auto result = onUseAbility(CLuaBaseEntity(PUser), CLuaBaseEntity(PTarget), CLuaAbility(PAbility), CLuaAction(action));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onUseAbility: %s\n", err.what());
            return 0;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
    }

    void ClearVarFromAll(std::string varName)
    {
        TracyZoneScoped;
        Sql_Query(SqlHandle, "DELETE FROM char_vars WHERE varname = '%s';", varName);
    }

    void Terminate()
    {
        TracyZoneScoped;
        zoneutils::ForEachZone([](CZone* PZone) {
            PZone->ForEachChar([](CCharEntity* PChar) {
                charutils::SaveCharPosition(PChar);
                charutils::SaveCharStats(PChar);
                charutils::SaveCharExp(PChar, PChar->GetMJob());
            });
        });
        exit(1);
    }

    int32 OnInstanceZoneIn(CCharEntity* PChar, CInstance* PInstance)
    {
        TracyZoneScoped;

        CZone* PZone = PInstance->GetZone();

        auto name = (const char*)PZone->GetName();

        auto onInstanceZoneIn = lua["xi"]["zones"][name]["Zone"]["onInstanceZoneIn"];
        if (!onInstanceZoneIn.valid())
        {
            return -1;
        }

        auto result = onInstanceZoneIn(CLuaBaseEntity(PChar), CLuaInstance(PInstance));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceZoneIn %s\n", err.what());
            return -1;
        }

        return 0;
    }

    void AfterInstanceRegister(CBaseEntity* PChar)
    {
        XI_DEBUG_BREAK_IF(!PChar->PInstance);

        TracyZoneScoped;

        auto zone     = (const char*)PChar->loc.zone->GetName();
        auto instance = (const char*)PChar->PInstance->GetName();

        auto afterInstanceRegister = lua["xi"]["zones"][zone]["instances"][instance]["afterInstanceRegister"];
        if (!afterInstanceRegister.valid())
        {
            return;
        }

        auto result = afterInstanceRegister(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::afterInstanceRegister %s\n", err.what());
        }
    }

    int32 OnInstanceLoadFailed(CZone* PZone)
    {
        TracyZoneScoped;

        auto name = (const char*)PZone->GetName();

        auto onInstanceLoadFailed = lua["xi"]["zones"][name]["Zone"]["onInstanceLoadFailed"];
        if (!onInstanceLoadFailed.valid())
        {
            return -1;
        }

        auto result = onInstanceLoadFailed();
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::afterInstanceRegister %s\n", err.what());
            return 0;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
    }

    int32 OnInstanceTimeUpdate(CZone* PZone, CInstance* PInstance, uint32 time)
    {
        TracyZoneScoped;

        auto zone = (const char*)PInstance->GetZone()->GetName();
        auto name = (const char*)PInstance->GetName();

        auto onInstanceTimeUpdate = lua["xi"]["zones"][zone]["instances"][name]["onInstanceTimeUpdate"];
        if (!onInstanceTimeUpdate.valid())
        {
            return -1;
        }

        auto result = onInstanceTimeUpdate(CLuaInstance(PInstance), time);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceTimeUpdate %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnInstanceFailure(CInstance* PInstance)
    {
        TracyZoneScoped;

        auto zone = (const char*)PInstance->GetZone()->GetName();
        auto name = (const char*)PInstance->GetName();

        auto onInstanceFailure = lua["xi"]["zones"][zone]["instances"][name]["onInstanceFailure"];
        if (!onInstanceFailure.valid())
        {
            return -1;
        }

        auto result = onInstanceFailure(CLuaInstance(PInstance));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceFailure %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  When instance is created, let player know it's finished              *
     *                                                                       *
     ************************************************************************/

    int32 OnInstanceCreated(CCharEntity* PChar, CInstance* PInstance)
    {
        TracyZoneScoped;

        auto onInstanceCreated = GetCacheEntryFromFilename(PChar->m_event.Script)["onInstanceCreated"];
        if (!onInstanceCreated.valid())
        {
            // If you can't load from PChar->m_event.Script, try from the zone
            auto filename     = fmt::format("./scripts/zones/{}/Zone.lua", PChar->loc.zone->GetName());
            onInstanceCreated = GetCacheEntryFromFilename(filename)["onInstanceCreated"];
            if (!onInstanceCreated.valid())
            {
                ShowError("luautils::onInstanceCreated: undefined procedure onInstanceCreated\n");
                return -1;
            }
        }

        std::optional<CLuaInstance> optLuaInstance = std::nullopt;
        if (PInstance)
        {
            optLuaInstance = CLuaInstance(PInstance);
        }

        auto result = onInstanceCreated(CLuaBaseEntity(PChar), CLuaBaseEntity(PChar->m_event.Target), optLuaInstance);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceCreated %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  When instance is created, run setup script for instance              *
     *                                                                       *
     ************************************************************************/

    int32 OnInstanceCreated(CInstance* PInstance)
    {
        TracyZoneScoped;

        auto zone = (const char*)PInstance->GetZone()->GetName();
        auto name = (const char*)PInstance->GetName();

        auto onInstanceCreated = lua["xi"]["zones"][zone]["instances"][name]["onInstanceCreated"];
        if (!onInstanceCreated.valid())
        {
            return -1;
        }

        auto result = onInstanceCreated(CLuaInstance(PInstance));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceCreated %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnInstanceProgressUpdate(CInstance* PInstance)
    {
        TracyZoneScoped;

        auto zone = (const char*)PInstance->GetZone()->GetName();
        auto name = (const char*)PInstance->GetName();

        auto onInstanceProgressUpdate = lua["xi"]["zones"][zone]["instances"][name]["onInstanceProgressUpdate"];
        if (!onInstanceProgressUpdate.valid())
        {
            return -1;
        }

        auto result = onInstanceProgressUpdate(CLuaInstance(PInstance), PInstance->GetProgress());
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceProgressUpdate %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnInstanceStageChange(CInstance* PInstance)
    {
        TracyZoneScoped;

        auto zone = (const char*)PInstance->GetZone()->GetName();
        auto name = (const char*)PInstance->GetName();

        auto onInstanceStageChange = lua["xi"]["zones"][zone]["instances"][name]["onInstanceStageChange"];
        if (!onInstanceStageChange.valid())
        {
            return -1;
        }

        auto result = onInstanceStageChange(CLuaInstance(PInstance), PInstance->GetStage());
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceStageChange %s\n", err.what());
            return -1;
        }

        return 0;
    }

    int32 OnInstanceComplete(CInstance* PInstance)
    {
        TracyZoneScoped;

        auto zone = (const char*)PInstance->GetZone()->GetName();
        auto name = (const char*)PInstance->GetName();

        auto onInstanceComplete = lua["xi"]["zones"][zone]["instances"][name]["onInstanceComplete"];
        if (!onInstanceComplete.valid())
        {
            return -1;
        }

        auto result = onInstanceComplete(CLuaInstance(PInstance));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceComplete %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    void StartElevator(uint32 ElevatorID)
    {
        TracyZoneScoped;
        CTransportHandler::getInstance()->startElevator(ElevatorID);
    }

    /************************************************************************
     *                                                                       *
     *  Получаем значение глобальной переменной сервера.                     *
     *  Переменная действительна лишь в пределах зоны, в которой установлена *
     *                                                                       *
     ************************************************************************/

    int32 GetServerVariable(std::string varName)
    {
        TracyZoneScoped;

        int32 value = 0;

        int32 ret = Sql_Query(SqlHandle, "SELECT value FROM server_variables WHERE name = '%s' LIMIT 1;", varName);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            value = (int32)Sql_GetIntData(SqlHandle, 0);
        }

        return value;
    }

    /************************************************************************
     *                                                                       *
     *  Устанавливаем значение глобальной переменной сервера.                *
     *                                                                       *
     ************************************************************************/

    void SetServerVariable(std::string name, int32 value)
    {
        TracyZoneScoped;

        if (value == 0)
        {
            Sql_Query(SqlHandle, "DELETE FROM server_variables WHERE name = '%s' LIMIT 1;", name);
            return;
        }
        Sql_Query(SqlHandle, "INSERT INTO server_variables VALUES ('%s', %i) ON DUPLICATE KEY UPDATE value = %i;", name, value, value);
    }

    int32 OnTransportEvent(CCharEntity* PChar, uint32 TransportID)
    {
        TracyZoneScoped;

        auto name = (const char*)PChar->loc.zone->GetName();

        auto onTransportEvent = lua["xi"]["zones"][name]["Zone"]["onTransportEvent"];
        if (!onTransportEvent.valid())
        {
            return -1;
        }

        auto result = onTransportEvent(CLuaBaseEntity(PChar), TransportID);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTransportEvent: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    void OnTimeTrigger(CNpcEntity* PNpc, uint8 triggerID)
    {
        TracyZoneScoped;

        auto onTimeTrigger = getEntityCachedFunction(PNpc, "onTimeTrigger");
        if (!onTimeTrigger.valid())
        {
            return;
        }

        auto result = onTimeTrigger(CLuaBaseEntity(PNpc), triggerID);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTimeTrigger: %s\n", err.what());
            return;
        }
    }

    int32 OnConquestUpdate(CZone* PZone, ConquestUpdate type)
    {
        TracyZoneScoped;

        auto name = (const char*)PZone->GetName();

        auto onConquestUpdate = lua["xi"]["zones"][name]["Zone"]["onConquestUpdate"];
        if (!onConquestUpdate.valid())
        {
            return -1;
        }

        CLuaZone LuaZone(PZone);

        auto result = onConquestUpdate(LuaZone, type);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onConquestUpdate: %s\n", err.what());
            return -1;
        }

        return 0;
    }

    /********************************************************************
        onBattlefieldEnter - callback when you enter a BCNM via a lua call to bcnmEnter(bcnmid)
    *********************************************************************/
    void OnBattlefieldEnter(CCharEntity* PChar, CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        CZone* PZone = PChar->loc.zone == nullptr ? zoneutils::GetZone(PChar->loc.destination) : PChar->loc.zone;

        auto zone = (const char*)PZone->GetName();
        auto name = PBattlefield->GetName();

        auto onBattlefieldEnter = lua["xi"]["zones"][zone]["bcnms"][name]["onBattlefieldEnter"];
        if (!onBattlefieldEnter.valid())
        {
            return;
        }

        auto result = onBattlefieldEnter(CLuaBaseEntity(PChar), CLuaBattlefield(PBattlefield));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onBattlefieldEnter: %s\n", err.what());
        }
    }

    /********************************************************************
        onBattlefieldLeave - callback when you leave a BCNM via multiple means.
        The method of leaving is given by the LeaveCode as follows:
        1 - Leaving via burning circle e.g. "run away"
        2 - Leaving via win
        3 - Leaving via warp or d/c
        4 - Leaving via lose
        This callback is executed for everyone in the BCNM when they leave
        so if they leave via win, this will be called for each char.
    *********************************************************************/
    void OnBattlefieldLeave(CCharEntity* PChar, CBattlefield* PBattlefield, uint8 LeaveCode)
    {
        TracyZoneScoped;

        CZone* PZone = PChar->loc.zone == nullptr ? zoneutils::GetZone(PChar->loc.destination) : PChar->loc.zone;

        auto filename = fmt::format("./scripts/zones/{}/bcnms/{}.lua", PZone->GetName(), PBattlefield->GetName());

        auto zone = (const char*)PZone->GetName();
        auto name = PBattlefield->GetName();

        auto onBattlefieldLeave = lua["xi"]["zones"][zone]["bcnms"][name]["onBattlefieldLeave"];
        if (!onBattlefieldLeave.valid())
        {
            return;
        }

        PChar->m_event.reset();
        PChar->m_event.Target = PChar;
        PChar->m_event.Script = filename;

        auto result = onBattlefieldLeave(CLuaBaseEntity(PChar), CLuaBattlefield(PBattlefield), LeaveCode);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onBattlefieldLeave: %s\n", err.what());
        }
    }

    /********************************************************************
        onBattlefieldRegister - callback when you successfully register a BCNM.
        For example, trading an orb, selecting the battle.
        Called AFTER assigning BCNM status to all valid characters.
        This callback is called only for the character initiating the
        registration, and after CBattlefield:init() procedure.
    *********************************************************************/
    void OnBattlefieldRegister(CCharEntity* PChar, CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        CZone* PZone = PChar->loc.zone == nullptr ? zoneutils::GetZone(PChar->loc.destination) : PChar->loc.zone;

        auto zone = (const char*)PZone->GetName();
        auto name = PBattlefield->GetName();

        auto onBattlefieldRegister = lua["xi"]["zones"][zone]["bcnms"][name]["onBattlefieldRegister"];
        if (!onBattlefieldRegister.valid())
        {
            return;
        }

        auto result = onBattlefieldRegister(CLuaBaseEntity(PChar), CLuaBattlefield(PBattlefield));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onBattlefieldRegister: %s\n", err.what());
        }
    }

    /********************************************************************
    onBattlefieldDestroy - called when BCNM is destroyed (cleanup)
    *********************************************************************/
    void OnBattlefieldDestroy(CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        auto zone = (const char*)PBattlefield->GetZone()->GetName();
        auto name = PBattlefield->GetName();

        auto onBattlefieldDestroy = lua["xi"]["zones"][zone]["bcnms"][name]["onBattlefieldDestroy"];
        if (!onBattlefieldDestroy.valid())
        {
            return;
        }

        auto result = onBattlefieldDestroy(CLuaBattlefield(PBattlefield));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onBattlefieldDestroy: %s\n", err.what());
        }
    }
    /************************************************************************
     *                                                                       *
     * Set SpawnType of mob to scripted (128) or normal (0) usind mob id     *
     *                                                                       *
     ************************************************************************/
    void DisallowRespawn(uint32 mobid, bool allowRespawn)
    {
        TracyZoneScoped;

        CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB);
        if (PMob != nullptr)
        {
            PMob->m_AllowRespawn = !allowRespawn;
        }
        else
        {
            ShowDebug(CL_RED "DisallowRespawn: mob <%u> not found\n" CL_RESET, mobid);
        }
    }

    /************************************************************************
     *                                                                       *
     * Update the NM spawn point to a new point, retrieved from the database *
     *                                                                       *
     ************************************************************************/

    void UpdateNMSpawnPoint(uint32 mobid)
    {
        TracyZoneScoped;

        CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB);
        if (PMob != nullptr)
        {
            int32 r   = 0;
            int32 ret = Sql_Query(SqlHandle, "SELECT count(mobid) FROM `nm_spawn_points` where mobid=%u", mobid);
            if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS && Sql_GetUIntData(SqlHandle, 0) > 0)
            {
                r = xirand::GetRandomNumber(Sql_GetUIntData(SqlHandle, 0));
            }
            else
            {
                ShowDebug(CL_RED "UpdateNMSpawnPoint: SQL error: No entries for mobid <%u> found.\n" CL_RESET, mobid);
                return;
            }

            ret = Sql_Query(SqlHandle, "SELECT pos_x, pos_y, pos_z FROM `nm_spawn_points` WHERE mobid=%u AND pos=%i", mobid, r);
            if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                PMob->m_SpawnPoint.rotation = xirand::GetRandomNumber(256);
                PMob->m_SpawnPoint.x        = Sql_GetFloatData(SqlHandle, 0);
                PMob->m_SpawnPoint.y        = Sql_GetFloatData(SqlHandle, 1);
                PMob->m_SpawnPoint.z        = Sql_GetFloatData(SqlHandle, 2);
                // ShowDebug(CL_RED"UpdateNMSpawnPoint: After %i - %f, %f, %f, %i\n" CL_RESET, r,
                // PMob->m_SpawnPoint.x,PMob->m_SpawnPoint.y,PMob->m_SpawnPoint.z,PMob->m_SpawnPoint.rotation);
            }
            else
            {
                ShowDebug(CL_RED "UpdateNMSpawnPoint: SQL error or NM <%u> not found in nmspawnpoints table.\n" CL_RESET, mobid);
            }
        }
        else
        {
            ShowDebug(CL_RED "UpdateNMSpawnPoint: mob <%u> not found\n" CL_RESET, mobid);
        }
    }

    /************************************************************************
     *                                                                       *
     *  Get Mob Respawn Time in seconds by Mob ID.                           *
     *                                                                       *
     ************************************************************************/

    uint32 GetMobRespawnTime(uint32 mobid)
    {
        TracyZoneScoped;

        CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB);

        if (PMob != nullptr)
        {
            return PMob->m_RespawnTime / 1000;
        }

        ShowError(CL_RED "luautils::GetMobAction: mob <%u> was not found\n" CL_RESET, mobid);
        return 0;
    }

    /************************************************************************
     *   Change drop rate of a mob                                           *
     *   1st number: dropid in mob_droplist.sql                              *
     *   2nd number: itemid in mob_droplist.sql                              *
     *   3rd number: new rate                                                *
     ************************************************************************/

    void SetDropRate(uint16 dropid, uint16 itemid, uint16 rate)
    {
        TracyZoneScoped;

        DropList_t* DropList = itemutils::GetDropList(dropid);

        if (DropList != nullptr)
        {
            for (auto& Item : DropList->Items)
            {
                if (Item.ItemID == itemid)
                {
                    Item.DropRate = rate;
                }
            }
        }
    }

    uint8 GetHealingTickDelay()
    {
        TracyZoneScoped;
        return map_config.healing_tick_delay;
    }

    /***************************************************************************
     *                                                                          *
     *  Creates an item object of the type specified by the itemID.             *
     *  This item is ephemeral, and doesn't exist in-game but can and should    *
     *  be used to lookup item information or access item functions when only   *
     *  the ItemID is known.                                                    *
     *                                                                          *
     *  ## These items should be used to READ ONLY!                             *
     *  ## Should lua functions be written which modify items, care must be     *
     *     taken to ensure these are NEVER modified.                            *
     *                                                                          *
     *  example: local item = GetReadOnlyItem(16448)                            *
     *           item:GetName()                 --Bronze Dagger                 *
     *           item:isTwoHanded()             --False                         *
     *                                                                          *
     ***************************************************************************/

    std::optional<CLuaItem> GetReadOnlyItem(uint32 id)
    {
        TracyZoneScoped;
        CItem* PItem = itemutils::GetItemPointer(id);
        return PItem ? std::optional<CLuaItem>(PItem) : std::nullopt;
    }

    std::optional<CLuaAbility> GetAbility(uint16 id)
    {
        TracyZoneScoped;
        CAbility* PAbility = ability::GetAbility(id);
        return PAbility ? std::optional<CLuaAbility>(PAbility) : std::nullopt;
    }

    std::optional<CLuaSpell> GetSpell(uint16 id)
    {
        TracyZoneScoped;
        CSpell* PSpell = spell::GetSpell(static_cast<SpellID>(id));
        return PSpell ? std::optional<CLuaSpell>(PSpell) : std::nullopt;
    }

    int32 UpdateServerMessage()
    {
        TracyZoneScoped;

        int8  line[1024];
        FILE* fp;

        // Clear old messages..
        map_config.server_message.clear();

        // Load the English server message..
        fp = fopen("./conf/server_message.conf", "rb");
        if (fp == nullptr)
        {
            ShowError("Could not read English server message from: ./conf/server_message.conf\n");
            return 1;
        }

        while (fgets((char*)line, sizeof(line), fp))
        {
            string_t sline((const char*)line);
            map_config.server_message += sline;
        }

        fclose(fp);

        // Ensure both messages have NULL terminates..
        if (map_config.server_message.at(map_config.server_message.length() - 1) != 0x00)
        {
            map_config.server_message += (char)0x00;
        }

        return 0;
    }

    sol::table GetServerVersion()
    {
        sol::table version = lua.create_table();
        version["branch"]  = XI_RELEASE_FLAG;
        version["major"]   = XI_MAJOR_VERSION;
        version["minor"]   = XI_MINOR_VERSION;
        version["rev"]     = XI_REVISION;
        return version;
    }

    sol::table NearLocation(sol::table const& table, float radius, float theta)
    {
        TracyZoneScoped;

        position_t center;
        center.x        = table.get<float>("x");
        center.y        = table.get<float>("y");
        center.z        = table.get<float>("z");
        center.rotation = table.get<uint8>("rot");

        position_t pos = nearPosition(center, radius, theta);

        sol::table nearPos = lua.create_table();
        nearPos["x"]       = pos.x;
        nearPos["y"]       = pos.y;
        nearPos["z"]       = pos.z;

        return nearPos;
    }

    void OnPlayerLevelUp(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto onPlayerLevelUp = lua["xi"]["player"]["onPlayerLevelUp"];
        if (!onPlayerLevelUp.valid())
        {
            ShowWarning("luautils::onPlayerLevelUp\n");
            return;
        }

        auto result = onPlayerLevelUp(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPlayerLevelUp: %s\n", err.what());
            return;
        }
    }

    void OnPlayerLevelDown(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto onPlayerLevelDown = lua["xi"]["player"]["onPlayerLevelDown"];
        if (!onPlayerLevelDown.valid())
        {
            ShowWarning("luautils::onPlayerLevelDown\n");
            return;
        }

        auto result = onPlayerLevelDown(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPlayerLevelDown: %s\n", err.what());
            return;
        }
    }

    bool OnChocoboDig(CCharEntity* PChar, bool pre)
    {
        TracyZoneScoped;

        auto name = (const char*)PChar->loc.zone->GetName();

        auto onChocoboDig = lua["xi"]["zones"][name]["Zone"]["onChocoboDig"];
        if (!onChocoboDig.valid())
        {
            ShowWarning("luautils::onChocoboDig\n");
            return false;
        }

        auto result = onChocoboDig(CLuaBaseEntity(PChar), pre);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onChocoboDig: %s\n", err.what());
            return false;
        }

        return result.get_type(0) == sol::type::boolean ? result.get<bool>() : false;
    }

    // Loads a Lua function with a fallback hierarchy
    //
    // 1) 1st try: PChar->m_event.Script
    // 2) 2nd try: The instance script if the player is in one
    // 3) 3rd try: The battlefield script if the player is in one
    // 4) 4th try: The zone script for the zone the player is in
    sol::function LoadEventScript(CCharEntity* PChar, const char* functionName)
    {
        TracyZoneScoped;

        auto funcFromChar = GetCacheEntryFromFilename(PChar->m_event.Script)[functionName];
        if (funcFromChar.valid())
        {
            return funcFromChar;
        }

        if (PChar->PInstance)
        {
            auto instance_filename = fmt::format("./scripts/zones/{}/instances/{}", PChar->loc.zone->GetName(), PChar->PInstance->GetName());

            auto funcFromInstance = GetCacheEntryFromFilename(instance_filename)[functionName];
            if (funcFromInstance.valid())
            {
                return funcFromInstance;
            }
        }

        if (PChar->PBattlefield)
        {
            auto battlefield_filename = fmt::format("./scripts/zones/{}/bcnms/{}", PChar->loc.zone->GetName(), PChar->PBattlefield->GetName());

            auto funcFromBattlefield = GetCacheEntryFromFilename(battlefield_filename)[functionName];
            if (funcFromBattlefield.valid())
            {
                return funcFromBattlefield;
            }
        }

        auto zone_filename = fmt::format("./scripts/zones/{}/Zone.lua", PChar->loc.zone->GetName());
        auto funcFromZone  = GetCacheEntryFromFilename(zone_filename)[functionName];
        if (funcFromZone.valid())
        {
            return funcFromZone;
        }

        return sol::nil;
    }

    uint16 GetDespoilDebuff(uint16 itemId)
    {
        TracyZoneScoped;

        uint16 effectId = 0;
        int32  ret      = Sql_Query(SqlHandle, "SELECT effectId FROM despoil_effects WHERE itemId = %u", itemId);
        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            effectId = (uint16)Sql_GetUIntData(SqlHandle, 0);
        }

        return effectId;
    }

    void OnFurniturePlaced(CCharEntity* PChar, CItemFurnishing* PItem)
    {
        TracyZoneScoped;

        auto name = (const char*)PItem->getName();

        auto onFurniturePlaced = lua["xi"]["globals"]["items"][name]["onFurniturePlaced"];
        if (!onFurniturePlaced.valid())
        {
            return;
        }

        auto result = onFurniturePlaced(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onFurniturePlaced: %s\n", err.what());
            return;
        }
    }

    void OnFurnitureRemoved(CCharEntity* PChar, CItemFurnishing* PItem)
    {
        TracyZoneScoped;

        auto name = (const char*)PItem->getName();

        auto onFurnitureRemoved = lua["xi"]["globals"]["items"][name]["onFurnitureRemoved"];
        if (!onFurnitureRemoved.valid())
        {
            return;
        }

        auto result = onFurnitureRemoved(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onFurnitureRemoved: %s\n", err.what());
            return;
        }
    }

    uint16 SelectDailyItem(CLuaBaseEntity* PLuaBaseEntity, uint8 dial)
    {
        TracyZoneScoped;
        CCharEntity* player = dynamic_cast<CCharEntity*>(PLuaBaseEntity->GetBaseEntity());
        return daily::SelectItem(player, dial);
    }

    void OnPlayerEmote(CCharEntity* PChar, Emote EmoteID)
    {
        TracyZoneScoped;

        auto onPlayerEmote = lua["xi"]["player"]["onPlayerEmote"];
        if (!onPlayerEmote.valid())
        {
            ShowWarning("luautils::onPlayerEmote\n");
            return;
        }

        auto result = onPlayerEmote(CLuaBaseEntity(PChar), static_cast<uint8>(EmoteID));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPlayerEmote: %s\n", err.what());
            return;
        }
    }

}; // namespace luautils
