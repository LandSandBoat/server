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

#include "luautils.h"

#include "common/filewatcher.h"
#include "common/logging.h"
#include "common/utils.h"
#include "common/vana_time.h"
#include "common/version.h"

#include <array>
#include <filesystem>
#include <numeric>
#include <optional>
#include <string>
#include <unordered_map>

#include "lua_action.h"
#include "lua_battlefield.h"
#include "lua_instance.h"
#include "lua_item.h"
#include "lua_loot.h"
#include "lua_mobskill.h"
#include "lua_petskill.h"
#include "lua_spell.h"
#include "lua_statuseffect.h"
#include "lua_trade_container.h"
#include "lua_trigger_area.h"
#include "lua_zone.h"

#include "ability.h"
#include "ai/ai_container.h"
#include "ai/states/ability_state.h"
#include "ai/states/attack_state.h"
#include "ai/states/death_state.h"
#include "ai/states/inactive_state.h"
#include "ai/states/item_state.h"
#include "ai/states/magic_state.h"
#include "ai/states/mobskill_state.h"
#include "ai/states/raise_state.h"
#include "ai/states/range_state.h"
#include "ai/states/respawn_state.h"
#include "ai/states/weaponskill_state.h"
#include "alliance.h"
#include "battlefield.h"
#include "campaign_system.h"
#include "common/vana_time.h"
#include "conquest_system.h"
#include "daily_system.h"
#include "entities/automatonentity.h"
#include "entities/baseentity.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "fishingcontest.h"
#include "instance.h"
#include "items/item_puppet.h"
#include "map.h"
#include "message.h"
#include "mobskill.h"
#include "monstrosity.h"
#include "packets/action.h"
#include "packets/char_emotion.h"
#include "packets/char_update.h"
#include "packets/chat_message.h"
#include "packets/entity_update.h"
#include "packets/entity_visual.h"
#include "packets/menu_raisetractor.h"
#include "party.h"
#include "petskill.h"
#include "roe.h"
#include "spell.h"
#include "status_effect_container.h"
#include "timetriggers.h"
#include "trade_container.h"
#include "transport.h"
#include "weapon_skill.h"
#include "zone.h"
#include "zone_entities.h"
#include "zone_instance.h"

#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "utils/instanceutils.h"
#include "utils/itemutils.h"
#include "utils/mobutils.h"
#include "utils/moduleutils.h"
#include "utils/serverutils.h"
#include "utils/synergyutils.h"
#include "utils/synthutils.h"
#include "utils/zoneutils.h"

void ReportErrorToPlayer(CBaseEntity* PEntity, std::string const& message = "") noexcept
{
    try
    {
        if (auto* PChar = dynamic_cast<CCharEntity*>(PEntity))
        {
            if (settings::get<uint8>("map.REPORT_LUA_ERRORS_TO_PLAYER_LEVEL") <= PChar->m_GMlevel)
            {
                if (!message.empty())
                {
                    auto        channel = MESSAGE_NS_SHOUT;
                    std::string breaker = "================";
                    PChar->pushPacket<CChatMessagePacket>(PChar, channel, breaker.c_str());
                    PChar->pushPacket<CChatMessagePacket>(PChar, channel, "!!! Lua error !!!");
                    for (auto const& part : split(message, "\n"))
                    {
                        auto str = replace(part, "\t", "    ");
                        PChar->pushPacket<CChatMessagePacket>(PChar, channel, str.c_str());
                    }
                    PChar->pushPacket<CChatMessagePacket>(PChar, channel, breaker.c_str());
                }
            }
        }
    }
    catch (std::exception const& e)
    {
        ShowError(e.what());
    }
}

namespace luautils
{
    std::unique_ptr<Filewatcher> filewatcher;

    std::unordered_map<uint32, sol::table> customMenuContext;

    /**
     * @brief Initialization of Lua user classes and global functions.
     */
    void init()
    {
        TracyZoneScoped;

        ShowInfo("luautils: Lua initializing");

        // Bind math.randon(...) globally
        // clang-format off
        lua["math"]["random"] =
            sol::overload([]() { return xirand::GetRandomNumber(1.0f); },
                          [](int n) { return xirand::GetRandomNumber<int>(1, n + 1); },
                          [](float n) { return xirand::GetRandomNumber<float>(0.0f, n); },
                          [](int n, int m) { return xirand::GetRandomNumber<int>(n, m + 1); },
                          [](float n, float m) { return xirand::GetRandomNumber<float>(n, m); });
        // clang-format on

        lua.set_function("GarbageCollectStep", &luautils::garbageCollectStep);
        lua.set_function("GarbageCollectFull", &luautils::garbageCollectFull);
        lua.set_function("GetZone", &luautils::GetZone);
        lua.set_function("GetItemByID", &luautils::GetItemByID);
        lua.set_function("GetNPCByID", &luautils::GetNPCByID);
        lua.set_function("GetMobByID", &luautils::GetMobByID);
        lua.set_function("GetEntityByID", &luautils::GetEntityByID);
        lua.set_function("WeekUpdateConquest", &luautils::WeekUpdateConquest);
        lua.set_function("GetRegionOwner", &luautils::GetRegionOwner);
        lua.set_function("GetRegionInfluence", &luautils::GetRegionInfluence);
        lua.set_function("GetNationRank", &luautils::GetNationRank);
        lua.set_function("GetConquestBalance", &luautils::GetConquestBalance);
        lua.set_function("IsConquestAlliance", &luautils::IsConquestAlliance);
        lua.set_function("SpawnMob", &luautils::SpawnMob);
        lua.set_function("DespawnMob", &luautils::DespawnMob);
        lua.set_function("GetPlayerByName", &luautils::GetPlayerByName);
        lua.set_function("GetPlayerByID", &luautils::GetPlayerByID);
        lua.set_function("PlayerHasValidSession", &luautils::PlayerHasValidSession);
        lua.set_function("GetPlayerIDByName", &luautils::GetPlayerIDByName);
        lua.set_function("SendToJailOffline", &luautils::SendToJailOffline);
        lua.set_function("DrawIn", &luautils::DrawIn);
        lua.set_function("GetSystemTime", &luautils::GetSystemTime);
        lua.set_function("JstMidnight", &luautils::JstMidnight);
        lua.set_function("JstWeekday", &luautils::JstWeekday);
        lua.set_function("NextConquestTally", &luautils::NextJstWeek);
        lua.set_function("NextGameTime", &luautils::NextGameTime);
        lua.set_function("NextJstDay", &luautils::JstMidnight);
        lua.set_function("NextJstWeek", &luautils::NextJstWeek);
        lua.set_function("VanadielTime", &luautils::VanadielTime);
        lua.set_function("VanadielTOTD", &luautils::VanadielTOTD);
        lua.set_function("VanadielHour", &luautils::VanadielHour);
        lua.set_function("VanadielMinute", &luautils::VanadielMinute);
        lua.set_function("VanadielDayOfTheWeek", &luautils::VanadielDayOfTheWeek);
        lua.set_function("VanadielDayOfTheMonth", &luautils::VanadielDayOfTheMonth);
        lua.set_function("VanadielDayOfTheYear", &luautils::VanadielDayOfTheYear);
        lua.set_function("VanadielYear", &luautils::VanadielYear);
        lua.set_function("VanadielMonth", &luautils::VanadielMonth);
        lua.set_function("VanadielUniqueDay", &luautils::VanadielUniqueDay);
        lua.set_function("VanadielDayElement", &luautils::VanadielDayElement);
        lua.set_function("VanadielMoonPhase", &luautils::VanadielMoonPhase);
        lua.set_function("VanadielMoonDirection", &luautils::VanadielMoonDirection);
        lua.set_function("VanadielRSERace", &luautils::VanadielRSERace);
        lua.set_function("VanadielRSELocation", &luautils::VanadielRSELocation);
        lua.set_function("SetVanadielTimeOffset", &luautils::SetVanadielTimeOffset);
        lua.set_function("IsMoonNew", &luautils::IsMoonNew);
        lua.set_function("IsMoonFull", &luautils::IsMoonFull);
        lua.set_function("RunElevator", &luautils::StartElevator);
        lua.set_function("GetElevatorState", &luautils::GetElevatorState);
        lua.set_function("GetServerVariable", &luautils::GetServerVariable);
        lua.set_function("SetServerVariable", &luautils::SetServerVariable);
        lua.set_function("GetVolatileServerVariable", &luautils::GetVolatileServerVariable);
        lua.set_function("SetVolatileServerVariable", &luautils::SetVolatileServerVariable);
        lua.set_function("GetCharVar", &luautils::GetCharVar);
        lua.set_function("SetCharVar", &luautils::SetCharVar);
        lua.set_function("ClearCharVarFromAll", &luautils::ClearCharVarFromAll);
        lua.set_function("SendEntityVisualPacket", &luautils::SendEntityVisualPacket);
        lua.set_function("GetMobRespawnTime", &luautils::GetMobRespawnTime);
        lua.set_function("DisallowRespawn", &luautils::DisallowRespawn);
        lua.set_function("UpdateNMSpawnPoint", &luautils::UpdateNMSpawnPoint);
        lua.set_function("GetRecentFishers", &luautils::GetRecentFishers);
        lua.set_function("NearLocation", &luautils::NearLocation);
        lua.set_function("GetFurthestValidPosition", &luautils::GetFurthestValidPosition);
        lua.set_function("Terminate", &luautils::Terminate);
        lua.set_function("GetReadOnlyItem", &luautils::GetReadOnlyItem);
        lua.set_function("GetAbility", &luautils::GetAbility);
        lua.set_function("GetSpell", &luautils::GetSpell);
        lua.set_function("SelectDailyItem", &luautils::SelectDailyItem);
        lua.set_function("GetContainerFilenamesList", &luautils::GetContainerFilenamesList);
        lua.set_function("GetCachedInstanceScript", &luautils::GetCachedInstanceScript);
        lua.set_function("GetItemIDByName", &luautils::GetItemIDByName);
        lua.set_function("SendItemToDeliveryBox", &luautils::SendItemToDeliveryBox);
        lua.set_function("SendLuaFuncStringToZone", &luautils::SendLuaFuncStringToZone);
        lua.set_function("RoeParseRecords", &roeutils::ParseRecords);
        lua.set_function("RoeParseTimed", &roeutils::ParseTimedSchedule);
        lua.set_function("GetSynergyRecipeByID", &luautils::GetSynergyRecipeByID);
        lua.set_function("GetSynergyRecipeByTrade", &luautils::GetSynergyRecipeByTrade);
        lua.set_function("ReloadSynthRecipes", &synthutils::LoadSynthRecipes);

        // Fishing Contest Functions
        lua.set_function("GetFishingContest", &luautils::GetFishingContest);
        lua.set_function("InitNewFishingContest", &luautils::InitNewFishingContest);
        lua.set_function("SetContestParameters", &luautils::SetContestParameters);
        lua.set_function("ProgressFishingContest", &luautils::ProgressFishingContest);
        lua.set_function("InitializeFishingContestSystem", &luautils::InitializeFishingContestSystem);

        // This binding specifically exists to forcefully crash the server.
        // clang-format off
        lua.set_function("ForceCrash", []() { crash(); });
        // clang-format on

        // clang-format off
        lua.set_function("BuildString", []()
        {
            return fmt::format("{}-{}\n{}\n{}",
                version::GetGitBranch(),
                version::GetGitSha(),
                version::GetGitCommitSubject(),
                version::GetGitDate());
        });

        // Register Sol Bindings
        CLuaAbility::Register();
        CLuaAction::Register();
        CLuaAttack::Register();
        CLuaBaseEntity::Register();
        CLuaBattlefield::Register();
        CLuaInstance::Register();
        CLuaLootContainer::Register();
        CLuaMobSkill::Register();
        CLuaPetSkill::Register();
        CLuaTriggerArea::Register();
        CLuaSpell::Register();
        CLuaStatusEffect::Register();
        CLuaTradeContainer::Register();
        CLuaZone::Register();
        CLuaItem::Register();

        // Load globals
        // Truly global files first
        lua.safe_script_file("./scripts/globals/common.lua");
        lua.safe_script_file("./scripts/globals/utils.lua");

        // Load global enums
        for (auto const& entry : sorted_directory_iterator<std::filesystem::directory_iterator>("./scripts/enum"))
        {
            if (entry.extension() == ".lua")
            {
                auto relative_path_string = entry.relative_path().generic_string();

                ShowTrace("Loading enum script %s", relative_path_string);

                auto result = lua.safe_script_file(relative_path_string);
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError(err.what());
                }
            }
        }

        PopulateIDLookupsByFilename();

        // Then the rest...
        for (auto const& entry : sorted_directory_iterator<std::filesystem::recursive_directory_iterator>("./scripts/globals"))
        {
            if (entry.extension() == ".lua")
            {
                auto relative_path_string = entry.relative_path().generic_string();

                ShowTrace("Loading global script %s", relative_path_string);

                auto result = lua.safe_script_file(relative_path_string);
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError(err.what());
                }
            }
        }

        // Load Commands
        for (auto const& entry : sorted_directory_iterator<std::filesystem::directory_iterator>("./scripts/commands"))
        {
            if (entry.extension() == ".lua")
            {
                CacheLuaObjectFromFile(entry.relative_path().generic_string());
            }
        }

        if (gLoadAllLua) // Load all lua files (for sanity testing, no need for during regular use)
        {
            ShowInfo("*** CI ONLY: Smoke testing by running all Lua files. ***");
            for (auto const& entry : sorted_directory_iterator<std::filesystem::recursive_directory_iterator>("./scripts"))
            {

                // Break apart path so that we can verify and ignore specific subdirectories
                std::vector<std::string> parts;
                for (auto part : entry)
                {
                    part.replace_extension("");
                    parts.emplace_back(part.string());
                }

                // Spec meta files should not be cached, and are only used
                // for Lua Language Server parsing
                if (!parts.empty() && parts[2] == "specs")
                {
                    continue;
                }

                // If we try to reload IDs.lua files, we'll wipe out the results
                // of GetFirstID() calls, so lets skip over those.
                if (entry.extension() == ".lua" && entry.filename() != "IDs.lua")
                {
                    auto result = lua.safe_script_file(entry.relative_path().generic_string());
                    if (!result.valid())
                    {
                        sol::error err = result;
                        ShowError(err.what());
                    }
                }
            }
        }

        // Handle settings
        moduleutils::LoadLuaModules();

        filewatcher = std::make_unique<Filewatcher>(std::vector<std::string>{ "scripts", "modules", "settings" });

        TracyReportLuaMemory(lua.lua_state());
    }

    void cleanup()
    {
        moduleutils::CleanupLuaModules();
    }

    void garbageCollectStep()
    {
        TracyZoneScoped;
        TracyReportLuaMemory(lua.lua_state());

        lua.step_gc(10); // LUA_GCSTEP 10 (performs an incremental step of garbage collection. Step size 10kb.)

        // NOTE: This is just requesting that an incremental step starts. There won't be a before/after change from
        //       this request!

        ShowInfo("Garbage Collected (Step)");
        ShowInfo("Current State Top: %d, Total Memory Used: %dkb", lua_gettop(lua.lua_state()), lua.memory_used() / 1024);

        TracyReportLuaMemory(lua.lua_state());
    }

    void garbageCollectFull()
    {
        TracyZoneScoped;
        TracyReportLuaMemory(lua.lua_state());

        auto before_mem_kb = lua.memory_used() / 1024;

        lua.collect_garbage(); // LUA_GCCOLLECT (performs a full garbage-collection cycle.)

        auto after_mem_kb = lua.memory_used() / 1024;

        ShowInfo("Garbage Collected (Full)");
        ShowInfo("Current State Top: %d, Total Memory Used: %dkb -> %dkb", lua_gettop(lua.lua_state()), before_mem_kb, after_mem_kb);

        TracyReportLuaMemory(lua.lua_state());
    }

    void ReloadFilewatchList()
    {
        for (const auto& [filename, action] : filewatcher->getChangedLuaFiles())
        {
            const auto pathStr = filename.generic_string();
            if (action == Filewatcher::Action::Add || action == Filewatcher::Action::Modified)
            {
                ShowInfo("[FileWatcher] %s", pathStr.c_str());
                CacheLuaObjectFromFile(pathStr, true);
            }

            // TODO: Handle moved and deleted files
        }
    }

    std::vector<std::string> GetContainerFilenamesList()
    {
        TracyZoneScoped;
        std::vector<std::string> outVec;

        // Scrape for files of the form:
        // "scripts/quests/(area|expansion)/(filename).lua"
        // "scripts/missions/(area|expansion)/(filename).lua"
        // "scripts/battlefields/(zone)/(filename).lua"
        auto scrapeSubdir = [&](std::string const& subFolder) -> void
        {
            for (auto const& entry : sorted_directory_iterator<std::filesystem::recursive_directory_iterator>(subFolder))
            {
                auto path = entry.relative_path();

                // TODO(compiler updates):
                // entry.depth() is not yet available in all of our compilers
                auto depth = std::distance(path.begin(), path.end());

                bool isHelpersFile = path.filename() == "helpers.lua";

                if (!std::filesystem::is_directory(path) &&
                    path.extension() == ".lua" &&
                    depth == 4 &&
                    !isHelpersFile)
                {
                    outVec.emplace_back(path.replace_extension("").make_preferred().string());
                }
            }
        };

        scrapeSubdir("scripts/battlefields");
        scrapeSubdir("scripts/missions");
        scrapeSubdir("scripts/quests");

        return outVec;
    }

    sol::function getEntityCachedFunction(CBaseEntity* PEntity, std::string funcName)
    {
        TracyZoneScoped;
        TracyZoneString(funcName);
        TracyZoneString(PEntity->getName());

        if (PEntity->objtype == TYPE_NPC)
        {
            std::string zone_name = PEntity->loc.zone->getName();
            std::string npc_name  = PEntity->getName();

            if (auto cached_func = lua["xi"]["zones"][zone_name]["npcs"][npc_name][funcName]; cached_func.valid())
            {
                return cached_func;
            }
        }
        else if (PEntity->objtype == TYPE_MOB)
        {
            std::string zone_name = PEntity->loc.zone->getName();
            std::string mob_name  = PEntity->getName();

            if (auto cached_func = lua["xi"]["zones"][zone_name]["mobs"][mob_name][funcName]; cached_func.valid())
            {
                return cached_func;
            }
        }
        else if (PEntity->objtype == TYPE_PET)
        {
            std::string mob_name = static_cast<CPetEntity*>(PEntity)->GetScriptName();

            if (auto cached_func = lua["xi"]["pets"][mob_name][funcName]; cached_func.valid())
            {
                return cached_func;
            }
        }
        else if (PEntity->objtype == TYPE_TRUST)
        {
            std::string mob_name = PEntity->getName();

            if (auto cached_func = lua["xi"]["actions"]["spells"]["trust"][mob_name][funcName]; cached_func.valid())
            {
                return cached_func;
            }
        }

        // Didn't find it
        return sol::lua_nil;
    }

    sol::function getSpellCachedFunction(CSpell* PSpell, std::string funcName)
    {
        TracyZoneScoped;
        TracyZoneString(funcName);
        TracyZoneString(PSpell->getName());

        auto name = PSpell->getName();

        std::string switchKey = "";
        switch (PSpell->getSpellGroup())
        {
            case SPELLGROUP_WHITE:
            {
                switchKey = "white";
            }
            break;
            case SPELLGROUP_BLACK:
            {
                switchKey = "black";
            }
            break;
            case SPELLGROUP_SONG:
            {
                switchKey = "songs";
            }
            break;
            case SPELLGROUP_NINJUTSU:
            {
                switchKey = "ninjutsu";
            }
            break;
            case SPELLGROUP_SUMMONING:
            {
                switchKey = "summoning";
            }
            break;
            case SPELLGROUP_BLUE:
            {
                switchKey = "blue";
            }
            break;
            case SPELLGROUP_GEOMANCY:
            {
                switchKey = "geomancy";
            }
            break;
            case SPELLGROUP_TRUST:
            {
                switchKey = "trust";
            }
            break;
            default:
            {
                ShowError("luautils::getSpellCachedFunction: Spell %s not inside a folder or doesnt have a SpellGroup", name);
            }
            break;
        }

        if (auto cached_func = lua["xi"]["actions"]["spells"][switchKey][name][funcName]; cached_func.valid())
        {
            return cached_func;
        }

        // Didn't find it
        return sol::lua_nil;
    }

    // Assumes filename in the form "./scripts/folder0/folder1/folder2/mob_name.lua
    // Object returned form that script will be cached to:
    // xi.folder0.folder1.folder2.mob_name
    void CacheLuaObjectFromFile(std::string const& filename, bool overwriteCurrentEntry /* = false*/)
    {
        TracyZoneScoped;
        TracyZoneString(filename);

        auto path = std::filesystem::path(filename);
        if (path.empty() || path.extension() == "")
        {
            return;
        }

        // Handle filename -> path conversion
        std::vector<std::string> parts;
        for (auto part : path)
        {
            part.replace_extension("");
            parts.emplace_back(part.string());
        }

        // Handle Lua module files, then return
        if (!parts.empty() && parts[0] == "modules")
        {
            auto result = lua.safe_script_file(filename);
            if (!result.valid())
            {
                sol::error err = result;
                ShowError("luautils::CacheLuaObjectFromFile: Load module error: %s: %s", filename, err.what());
                return;
            }

            // Commands are a special case, since they are not a "true" module
            sol::table cmdTable = result;
            if (cmdTable["cmdprops"].valid() && cmdTable["onTrigger"].valid())
            {
                lua[sol::create_if_nil]["xi"]["commands"][parts.back()] = cmdTable;
            }

            ShowInfo("[FileWatcher] RE-RUNNING MODULE FILE %s", filename);
            return;
        }

        // Handle Lua settings files, then return
        if (!parts.empty() && parts[0] == "settings")
        {
            auto result = lua.safe_script_file(filename);
            if (!result.valid())
            {
                sol::error err = result;
                ShowError("luautils::CacheLuaObjectFromFile: Load settings error: %s: %s", filename, err.what());
                return;
            }

            ShowInfo("[FileWatcher] RELOADING ALL LUA SETTINGS FILES");

            settings::init();

            return;
        }

        auto it = std::find(parts.begin(), parts.end(), "scripts");
        if (it == parts.end())
        {
            ShowError("luautils::CacheLuaObjectFromFile: Invalid filename: %s", filename);
            return;
        }

        // Now that the list is verified, overwrite it with the same list; without "scripts"
        parts = std::vector<std::string>(it + 1, parts.end());

        // Handle Globals then return
        // Globals need to be nil'd before they're reloaded
        if (parts[0] == "globals" && path.extension() == ".lua")
        {
            std::string requireName("scripts/globals");

            for (std::size_t i = 1; i < parts.size(); ++i)
            {
                requireName = fmt::format("{}/{}", requireName, parts[i]);
            }

            auto result = lua.safe_script(fmt::format(R"(package.loaded["{}"] = nil; require("{}");)", requireName, requireName));
            if (!result.valid())
            {
                sol::error err = result;
                ShowError("luautils::CacheLuaObjectFromFile: Load global error: %s: %s", filename, err.what());
                return;
            }

            ShowInfo("[FileWatcher] GLOBAL %s -> \"%s\"", filename, requireName);
            return;
        }

        // Handle IDs then return
        if (parts.size() == 3 && parts[2] == "IDs")
        {
            // Strip down to just the zone name
            auto zoneName = path.parent_path().stem().generic_string();

            PopulateIDLookupsByFilename(zoneName);
            ShowInfo("[FileWatcher] IDs %s", filename);
            return;
        }

        // Handle Quests and Missions then return
        if (parts.size() == 3 &&
            (parts[0] == "quests" || parts[0] == "missions" || parts[0] == "battlefields"))
        {
            if (parts[2] == "helpers")
            {
                std::string requireName = fmt::format("scripts/{}/{}/{}", parts[0], parts[1], parts[2]);

                // clang-format off
                auto result = lua.safe_script(fmt::format(R"(
                    package.loaded["{0}"] = nil
                    utils.prequire("{0}")
                )", requireName));
                // clang-format on

                ShowInfo("[FileWatcher] INTERACTION HELPERS %s", parts[1]);
            }
            else // Regular interaction files
            {
                std::string requireName = fmt::format("scripts/{}/{}/{}", parts[0], parts[1], parts[2]);

                auto result = lua.safe_script(fmt::format(R"(
                    if package.loaded["{0}"] then
                        local old = package.loaded["{0}"]
                        package.loaded["{0}"] = nil
                        if InteractionGlobal and old then
                            InteractionGlobal.lookup:removeContainer(old)
                        end
                    end

                    local res = utils.prequire("{0}")
                    if InteractionGlobal and res then
                        InteractionGlobal.lookup:addContainer(res)
                    end
                )",
                                                          requireName));

                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError("luautils::CacheLuaObjectFromFile: Load interaction error: %s: %s", filename, err.what());
                    return;
                }

                ShowInfo("[FileWatcher] INTERACTION %s -> %s", requireName, parts[2]);
            }

            return;
        }

        if (!std::filesystem::exists(filename))
        {
            ShowTrace("luautils::CacheLuaObjectFromFile: Tried to load file but it does not exist: %s", filename);
            return;
        }

        // Try and load script
        auto file_result = lua.safe_script_file(filename);
        if (!file_result.valid())
        {
            sol::error err = file_result;
            ShowError("luautils::CacheLuaObjectFromFile: Load error: %s: %s", filename, err.what());
            return;
        }

        if (!file_result.return_count())
        {
            ShowError("luautils::CacheLuaObjectFromFile: No returned object to cache: %s", filename);
            return;
        }

        // file_result should be good, cache it!

        auto        table   = lua["xi"].get_or_create<sol::table>();
        std::string out_str = "xi";
        for (auto& part : parts)
        {
            if (part == parts.back())
            {
                if (overwriteCurrentEntry)
                {
                    table[sol::override_value][part] = file_result;
                }
                else
                {
                    table[sol::update_if_empty][part] = file_result;
                }
            }
            else
            {
                table = table[part].get_or_create<sol::table>(lua.create_table());
            }
            out_str += "." + part;
        }

        moduleutils::TryApplyLuaModules();
    }

    sol::table GetCacheEntryFromFilename(std::string const& filename)
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
            ShowError("luautils::GetCacheEntryFromFilename: Invalid filename: %s", filename);
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
            // clang-format off
            auto isNamePrintable = [](const std::string& name)
            {
                // Match non-printable ASCII
                for (const char& c : name)
                {
                    if ((c >= 0 && c <= 0x20) || c >= 0x7F)
                    {
                        return false;
                    }
                }
                return true;
            };
            // clang-format on

            // Don't bother even trying to load the script if the NPC name is non printable,
            // and therefore impossible for a filesystem to load.
            // TODO: Change name to "0x%X" instead so non-printables could get a script?
            if (!isNamePrintable(PEntity->getName()))
            {
                return;
            }
            std::string zone_name = PEntity->loc.zone->getName();
            std::string npc_name  = PEntity->getName();
            filename              = fmt::format("./scripts/zones/{}/npcs/{}.lua", zone_name, npc_name);
        }
        else if (PEntity->objtype == TYPE_MOB)
        {
            std::string zone_name = PEntity->loc.zone->getName();
            std::string mob_name  = PEntity->getName();
            filename              = fmt::format("./scripts/zones/{}/mobs/{}.lua", zone_name, mob_name);
        }
        else if (PEntity->objtype == TYPE_PET)
        {
            std::string mob_name = static_cast<CPetEntity*>(PEntity)->GetScriptName();
            filename             = fmt::format("./scripts/globals/pets/{}.lua", static_cast<CPetEntity*>(PEntity)->GetScriptName());
        }
        else if (PEntity->objtype == TYPE_TRUST)
        {
            std::string mob_name = PEntity->getName();
            filename             = fmt::format("./scripts/actions/spells/trust/{}.lua", PEntity->getName());
        }

        CacheLuaObjectFromFile(filename);
    }

    void PopulateIDLookups(uint16 zoneId, std::string const& zoneName)
    {
        TracyZoneScoped;

        // NOTE:
        // This has an entry in zone_settings, but going there crashes the client, so don't bother loading anything for it.
        // So bail out now.
        if (zoneName == "286")
        {
            return;
        }

        // Load all Name/ID pairs from mobs and npcs
        std::unordered_map<std::string, std::vector<uint32>> lookup;

        // Mobs
        {
            auto query = fmt::sprintf("SELECT mobname, mobid FROM mob_spawn_points "
                                      "WHERE ((mobid >> 12) & 0xFFF) = %i ORDER BY mobid ASC",
                                      zoneId);
            auto ret   = _sql->Query(query.c_str());
            while (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
            {
                auto name = _sql->GetStringData(0);
                auto id   = _sql->GetUIntData(1);

                lookup[name].emplace_back(id);
            }
        }

        // NPCs
        {
            auto query = fmt::sprintf("SELECT name, npcid FROM npc_list "
                                      "WHERE ((npcid >> 12) & 0xFFF) = %i ORDER BY npcid ASC",
                                      zoneId);
            auto ret   = _sql->Query(query.c_str());
            while (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
            {
                auto name = _sql->GetStringData(0);
                auto id   = _sql->GetUIntData(1);

                lookup[name].emplace_back(id);
            }
        }

        // Update GetFirstID to use this new lookup
        // clang-format off
        lua.set_function("GetFirstID", [&](std::string const& name) -> std::optional<uint32>
        {
            if (lookup.find(name) != lookup.end())
            {
                return lookup[name].front();
            }
            else
            {
                ShowError(fmt::format("GetFirstID({}) in zone {}: Returning nil", name, zoneName));
                return std::nullopt;
            }
        });

        std::unordered_map<std::string, sol::table> idLuaTables;

        lua.set_function("GetTableOfIDs", [&](std::string const& name) -> sol::table
        {
            // Is it already built and cached: return it
            if (idLuaTables.find(name) != idLuaTables.end())
            {
                return idLuaTables[name];
            }

            // If we have no entries, bail out and return nil
            if (lookup.find(name) == lookup.end())
            {
                ShowError(fmt::format("GetTableOfIDs({}) in zone {}: Returning nil", name, zoneName));
                return sol::lua_nil;
            }

            // Otherwise, let's start building it and then cache it
            auto table = lua.create_table();

            auto entriesVec = lookup[name];
            if (entriesVec.empty())
            {
                ShowError(fmt::format("GetTableOfIDs({}) in zone {}: Returning empty table", name, zoneName));
                return table;
            }

            // Look up all that match name
            for (auto const& [lookupName, lookupVec] : lookup)
            {
                if (name == lookupName)
                {
                    for (auto const& entryId : lookupVec)
                    {
                        table.add(entryId);
                    }
                }
            }

            if (table.empty())
            {
                ShowError(fmt::format("GetTableOfIDs({}) in zone {}: Tried to look do ID lookup, but found nothing.", name, zoneName));
            }

            // Add to cache
            idLuaTables[name] = table;

            return table;
        });
        // clang-format on

        // Pre-require
        auto result = lua.safe_script_file(fmt::format("scripts/zones/{}/IDs.lua", zoneName.c_str()));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError(err.what());
        }

        // clang-format off
        lua.set_function("GetFirstID", [&](std::string const& name) -> void
        {
            ShowWarning("GetFirstID is designed to be used at load/reload-time only!");
        });

        lua.set_function("GetTableOfIDs", [&](std::string const& name, std::optional<int> optRange) -> void
        {
            ShowWarning("GetTableOfIDs is designed to be used at load/reload-time only!");
        });
        // clang-format on

        // Re-publish to package.loaded. This is the same as loading the contents of a script with require("name").
        lua["package"]["loaded"][fmt::format("scripts/zones/{}/IDs", zoneName)] = lua["zones"][zoneId];
    }

    void PopulateIDLookupsByFilename(std::optional<std::string> maybeFilename)
    {
        TracyZoneScoped;

        // clang-format off
        auto handleZone = [&](std::string const& zoneName)
        {
            uint16 zoneId = 0;
            {
                auto query = fmt::sprintf("SELECT zoneid FROM zone_settings WHERE name = '%s'", zoneName.c_str());
                auto ret = _sql->Query(query.c_str());
                if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
                {
                    zoneId = _sql->GetUIntData(0);
                }
            }

            PopulateIDLookups(zoneId, zoneName);
        };

        if (!maybeFilename)
        {
            // Pre-load all zone/IDs files so we can pre-populate their GetFirstID lookups
            for (auto const& zoneDirEntry : sorted_directory_iterator<std::filesystem::directory_iterator>("./scripts/zones"))
            {
                for (auto const& fileEntry : sorted_directory_iterator<std::filesystem::directory_iterator>(zoneDirEntry.relative_path().generic_string()))
                {
                    if (fileEntry.stem() == "IDs")
                    {
                        // Prepare which zone we're in using the file path
                        auto relative_path_string = fileEntry.relative_path().generic_string();
                        auto zoneName = fileEntry.parent_path().stem().generic_string();

                        handleZone(zoneName);
                    }
                }
            }
        }
        else
        {
            handleZone(maybeFilename.value());
        }
        // clang-format on
    }

    void PopulateIDLookupsByZone(std::optional<uint16> maybeZoneId)
    {
        TracyZoneScoped;

        // clang-format off
        auto handleZone = [&](CZone* PZone)
        {
            auto zoneId   = PZone->GetID();
            auto zoneName = PZone->getName();
            PopulateIDLookups(zoneId, zoneName);
        };

        if (!maybeZoneId.has_value())
        {
            zoneutils::ForEachZone([&](CZone* PZone)
            {
                if (PZone->GetIP() != 0)
                {
                    handleZone(PZone);
                }
            });
        }
        else
        {
            handleZone(zoneutils::GetZone(maybeZoneId.value()));
        }
        // clang-format on
    }

    // temporary solution for geysers in Dangruf_Wadi
    void SendEntityVisualPacket(uint32 npcid, const char* command)
    {
        TracyZoneScoped;
        if (CBaseEntity* PNpc = zoneutils::GetEntity(npcid, TYPE_NPC))
        {
            PNpc->loc.zone->PushPacket(PNpc, CHAR_INRANGE, std::make_unique<CEntityVisualPacket>(PNpc, command));
        }
    }

    std::optional<CLuaItem> GetItemByID(uint32 itemId)
    {
        if (auto* PItem = itemutils::GetItemPointer(itemId))
        {
            return CLuaItem(PItem);
        }

        return std::nullopt;
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
            ShowWarning("luautils::GetNPCByID NPC doesn't exist (%d)", npcid);
            return std::nullopt;
        }

        return std::optional<CLuaBaseEntity>(PNpc);
    }

    void InitInteractionGlobal()
    {
        auto initZones = lua["InteractionGlobal"]["initZones"];

        std::vector<uint16> zoneIds;
        // clang-format off
        zoneutils::ForEachZone([&zoneIds](CZone* PZone)
        {
            zoneIds.emplace_back(PZone->GetID());
        });
        // clang-format on

        auto result = initZones(zoneIds);

        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::InitInteractionGlobal: %s", err.what());
        }
    }

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
            ShowWarning("luautils::GetMobByID Mob doesn't exist (%d)", mobid);
            return std::nullopt;
        }

        return std::optional<CLuaBaseEntity>(PMob);
    }

    std::optional<CLuaBaseEntity> GetEntityByID(uint32 entityid, sol::object const& instanceObj, sol::object const& arg3)
    {
        TracyZoneScoped;

        CInstance* PInstance = nullptr;
        if (instanceObj.is<CLuaInstance>())
        {
            PInstance = instanceObj.as<CLuaInstance>().GetInstance();
        }

        bool silenceWarning = arg3.get_type() == sol::type::boolean ? arg3.as<bool>() : false;

        CBaseEntity* PEntity{ nullptr };

        if (PInstance)
        {
            PEntity = PInstance->GetEntity(entityid & 0xFFF, TYPE_MOB | TYPE_PET | TYPE_NPC);
        }
        else
        {
            PEntity = zoneutils::GetEntity(entityid, TYPE_MOB | TYPE_PET | TYPE_NPC);
        }

        if (!PEntity)
        {
            if (!silenceWarning)
            {
                ShowWarning("luautils::GetEntityByID Mob doesn't exist (%d)", entityid);
            }
            return std::nullopt;
        }

        return std::optional<CLuaBaseEntity>(PEntity);
    }

    void WeekUpdateConquest(uint8 updateType)
    {
        TracyZoneScoped;
        conquest::UpdateConquestGM(static_cast<ConquestUpdate>(updateType));
    }

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

    void SetRegionalConquestOverseers(uint8 regionID)
    {
        TracyZoneScoped;

        auto setRegionalConquestOverseers = lua["xi"]["conquest"]["setRegionalConquestOverseers"];
        if (!setRegionalConquestOverseers.valid())
        {
            sol::error err = setRegionalConquestOverseers;
            ShowError("luautils::setRegionalConquestOverseers: %s", err.what());
            return;
        }

        auto result = setRegionalConquestOverseers(regionID);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::setRegionalConquestOverseers: %s", err.what());
        }
    }

    void SendLuaFuncStringToZone(uint16 zoneId, std::string const& str)
    {
        message::send(zoneId, str);
    }

    uint32 VanadielTime()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getVanaTime();
    }

    uint8 VanadielTOTD()
    {
        TracyZoneScoped;
        return static_cast<uint8>(CVanaTime::getInstance()->GetCurrentTOTD());
    }

    uint32 VanadielYear()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getYear();
    }

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

        int32 day   = CVanaTime::getInstance()->getDayOfTheMonth();
        int32 month = CVanaTime::getInstance()->getMonth();
        int32 year  = CVanaTime::getInstance()->getYear();

        return (year * 360) + (month * 30 - 30) + day;
    }

    uint32 VanadielDayOfTheYear()
    {
        TracyZoneScoped;

        int32 day   = CVanaTime::getInstance()->getDayOfTheMonth();
        int32 month = CVanaTime::getInstance()->getMonth();

        return (month * 30 - 30) + day;
    }

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

    uint32 VanadielHour()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getHour();
    }

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
     * Returns current UTC timestamp                                         *
     *                                                                       *
     ************************************************************************/
    uint32 GetSystemTime()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getSysTime();
    }

    /************************************************************************
     *                                                                       *
     * Returns UTC timestamp of upcoming JST midnight                        *
     *                                                                       *
     ************************************************************************/

    uint32 JstMidnight()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getJstMidnight();
    }

    /************************************************************************
     *                                                                       *
     * Returns days since Sunday JST                                         *
     *                                                                       *
     ************************************************************************/

    uint32 JstWeekday()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getJstWeekDay();
    }

    /************************************************************************
     *                                                                       *
     * NextGameTime - Returns System Time for the next Vana'diel interval    *
     * See: VTIME_x definitions, or xi.vanaTime for the values to pass       *
     *                                                                       *
     ************************************************************************/
    uint32 NextGameTime(uint32 intervalSeconds)
    {
        TracyZoneScoped;
        uint32 timeElapsed      = CVanaTime::getInstance()->getVanaTime();
        uint32 numPassed        = timeElapsed / intervalSeconds;
        uint32 secondsRemaining = intervalSeconds - (timeElapsed - (numPassed * intervalSeconds));

        return CVanaTime::getInstance()->getSysTime() + secondsRemaining;
    }

    // NOTE: NextJstDay is also defined, and maps to JstMidnight

    uint32 NextJstWeek()
    {
        TracyZoneScoped;
        uint32 jstWeekday      = (CVanaTime::getInstance()->getJstWeekDay() + 6) % 7;
        uint32 nextJstMidnight = CVanaTime::getInstance()->getJstMidnight();

        // Start with the "Next" Midnight, and apply N days worth of time to it
        // jstWeekday is offset by 1 here, so that Monday (JST) is the reference.

        return nextJstMidnight + (6 - jstWeekday) * 60 * 60 * 24;
    }

    // NOTE: NextConquestTally exists for clarity, and is bound to the above function

    uint32 VanadielMoonPhase()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getMoonPhase();
    }

    bool SetVanadielTimeOffset(int32 offset)
    {
        TracyZoneScoped;
        uint32 custom = CVanaTime::getInstance()->getCustomEpoch();
        CVanaTime::getInstance()->setCustomEpoch((custom ? custom : VTIME_BASEDATE) - offset);
        return true;
    }

    uint8 VanadielMoonDirection()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getMoonDirection();
    }

    uint8 VanadielRSERace()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getRSERace();
    }

    uint8 VanadielRSELocation()
    {
        TracyZoneScoped;
        return CVanaTime::getInstance()->getRSELocation();
    }

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
                break;
            case 1: // Waning (decending)
                if (phase <= 10)
                {
                    return true;
                }
                break;
            case 2: // Waxing (increasing)
                if (phase <= 5)
                {
                    return true;
                }
                break;
        }

        return false;
    }

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
                break;
            case 1: // Waning (decending)
                if (phase >= 95 && phase <= 100)
                {
                    return true;
                }
                break;
            case 2: // Waxing (increasing)
                if (phase >= 90 && phase <= 100)
                {
                    return true;
                }
                break;
        }

        return false;
    }

    /************************************************************************
     *                                                                       *
     *  Spawn a mob using mob ID                                             *
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
                    ShowDebug("SpawnMob: %u <%s> is already spawned", PMob->id, PMob->getName());
                }
            }
        }
        else
        {
            ShowDebug("SpawnMob: mob <%u> not found", mobid);
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
     *  Gets a player object via the player's name (used for GM commands)    *
     *                                                                       *
     ************************************************************************/

    std::optional<CLuaBaseEntity> GetPlayerByName(std::string const& name)
    {
        TracyZoneScoped;

        CCharEntity* PTargetChar = zoneutils::GetCharByName(name.c_str());

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

    /************************************************************************
     *                                                                       *
     *  Indicates if a player has a valid account sessions                   *
     *                                                                       *
     ************************************************************************/

    bool PlayerHasValidSession(uint32 playerId)
    {
        TracyZoneScoped;

        bool hasSession = false;

        const char* getPlayerSession = "SELECT 1 FROM accounts_sessions WHERE charid = %d LIMIT 1";
        int32       queryRet         = _sql->Query(getPlayerSession, playerId);

        if (queryRet != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            hasSession = true;
        }

        return hasSession;
    }

    /************************************************************************
     *                                                                       *
     *  Gets a player ID from any zone, regardless of online status          *
     *                                                                       *
     ************************************************************************/

    uint32 GetPlayerIDByName(std::string const& playerName)
    {
        TracyZoneScoped;

        const char* getPlayerIDQuery = "SELECT charid FROM chars WHERE charname = '%s'";
        int32       queryRet         = _sql->Query(getPlayerIDQuery, playerName);
        uint32      playerID         = 0;

        if (queryRet != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            playerID = _sql->GetUIntData(0);
        }

        return playerID;
    }

    /************************************************************************
     *                                                                       *
     *  Send a player to jail if they are offline                            *
     *                                                                       *
     ************************************************************************/

    void SendToJailOffline(uint32 playerId, int8 cellId, float posX, float posY, float posZ, uint8 rot)
    {
        TracyZoneScoped;
        charutils::PersistCharVar(playerId, "inJail", cellId);
        _sql->Query("UPDATE chars SET pos_x=%f, pos_y=%f, pos_z=%f, pos_rot=%u, pos_zone=%d, moghouse=0 WHERE charid=%u", posX, posY, posZ, rot, ZONEID::ZONE_MORDION_GAOL, playerId);
    }

    void DrawIn(CLuaBaseEntity* PLuaBaseEntity, sol::table const& table, float offset, float degrees)
    {
        TracyZoneScoped;
        if (auto* PBattleEntity = dynamic_cast<CBattleEntity*>(PLuaBaseEntity->GetBaseEntity()))
        {
            position_t pos;
            pos.x        = table.get<float>("x");
            pos.y        = table.get<float>("y");
            pos.z        = table.get<float>("z");
            pos.rotation = table.get<uint8>("rot");
            battleutils::DrawIn(PBattleEntity, pos, offset, degrees);
        }
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
     *  Check if an something is restricted in Settings.lua                  *
     *  ENABLE_ is subject to RESTRICT_BY_EXPANSION                          *
     *  ALLOW_ is NOT subject to RESTRICT_BY_EXPANSION                       *
     *                                                                       *
     ************************************************************************/

    bool IsContentEnabled(const char* contentTag)
    {
        TracyZoneScoped;

        if (contentTag == nullptr || std::strlen(contentTag) == 0)
        {
            return true;
        }

        std::string contentVariable("ENABLE_");
        contentVariable.append(contentTag);

        bool contentEnabled            = settings::get<bool>(fmt::format("main.{}", contentVariable));
        bool contentRestrictionEnabled = settings::get<bool>("main.RESTRICT_CONTENT");
        if (!contentEnabled && contentRestrictionEnabled)
        {
            return false;
        }

        return true;
    }

    void OnZoneInitialize(uint16 ZoneID)
    {
        TracyZoneScoped;

        CZone* PZone = zoneutils::GetZone(ZoneID);

        if (PZone == nullptr)
        {
            ShowWarning("Skipping init for disabled zone %d.", ZoneID);
            return;
        }

        auto name     = PZone->getName();
        auto filename = fmt::format("./scripts/zones/{}/Zone.lua", name);

        ShowTraceFmt("luautils::OnZoneInitialize: {}", name);

        CacheLuaObjectFromFile(filename);

        auto onInitialize = lua["xi"]["zones"][name]["Zone"]["onInitialize"];
        if (!onInitialize.valid())
        {
            return;
        }

        auto result = onInitialize(CLuaZone(PZone));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInitialize: %s", err.what());
        }
    }

    void OnZoneTick(CZone* PZone)
    {
        TracyZoneScoped;

        auto name     = PZone->getName();
        auto filename = fmt::format("./scripts/zones/{}/Zone.lua", name);

        ShowTraceFmt("luautils::OnZoneTick: {}", name);

        auto onZoneTick = GetCacheEntryFromFilename(filename)["onZoneTick"];
        if (!onZoneTick.valid())
        {
            return;
        }

        auto result = onZoneTick(CLuaZone(PZone));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onZoneTick: %s", err.what());
        }
    }

    void OnGameIn(CCharEntity* PChar, bool zoning)
    {
        TracyZoneScoped;

        ShowTraceFmt("luautils::OnGameIn: {}", PChar->getName());

        auto onGameIn = lua["xi"]["player"]["onGameIn"];
        if (!onGameIn.valid())
        {
            ShowError("luautils::onGameIn");
            return;
        }

        auto result = onGameIn(CLuaBaseEntity(PChar), PChar->GetPlayTime(false) == 0, zoning);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onGameIn: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
        }
    }

    void OnZoneIn(CCharEntity* PChar)
    {
        TracyZoneScoped;

        CZone* destinationZone = zoneutils::GetZone(PChar->loc.destination);
        if (!PChar->m_moghouseID && destinationZone == nullptr)
        {
            ShowWarning("Attempt to Zone In player to invalid/disabled zone %d.", PChar->loc.destination);
            return;
        }

        CZone*      prevZone    = zoneutils::GetZone(PChar->loc.prevzone);
        std::string prevZoneStr = "Unknown";
        if (prevZone)
        {
            prevZoneStr = prevZone->getName();
        }

        auto name     = PChar->m_moghouseID ? "Residential_Area" : destinationZone->getName();
        auto filename = fmt::format("./scripts/zones/{}/Zone.lua", name);

        ShowTraceFmt("luautils::OnZoneIn: {}: {} -> {}", PChar->getName(), prevZoneStr, name);

        auto onZoneInFramework = lua["InteractionGlobal"]["onZoneIn"];
        auto onZoneIn          = GetCacheEntryFromFilename(filename)["onZoneIn"];

        auto result = onZoneInFramework(CLuaBaseEntity(PChar), PChar->loc.prevzone, onZoneIn);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onZoneIn: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return;
        }

        if (result.get_type() == sol::type::table)
        {
            auto resultTable = result.get<sol::table>();

            PChar->currentEvent->eventId    = resultTable.get_or(1, -1);
            PChar->currentEvent->textTable  = resultTable.get_or(2, -1);
            PChar->currentEvent->eventFlags = resultTable.get_or(3, 0);
        }
        else if (result.get_type() == sol::type::number)
        {
            PChar->currentEvent->eventId = result.get<int32>();
        }
    }

    void AfterZoneIn(CBaseEntity* PChar)
    {
        TracyZoneScoped;

        auto name     = PChar->loc.zone->getName();
        auto filename = fmt::format("./scripts/zones/{}/Zone.lua", name);

        ShowTraceFmt("luautils::AfterZoneIn: {} ({})", PChar->getName(), name);

        auto afterZoneInFramework = lua["InteractionGlobal"]["afterZoneIn"];
        auto afterZoneIn          = GetCacheEntryFromFilename(filename)["afterZoneIn"];

        auto result = afterZoneInFramework(CLuaBaseEntity(PChar), afterZoneIn);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::afterZoneIn: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
        }
    }

    void OnZoneOut(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto name     = PChar->loc.zone->getName();
        auto filename = fmt::format("./scripts/zones/{}/Zone.lua", name);

        ShowTraceFmt("luautils::OnZoneOut: {} ({})", PChar->getName(), name);

        auto onZoneOutFramework = lua["InteractionGlobal"]["onZoneOut"];
        auto onZoneOut          = GetCacheEntryFromFilename(filename)["onZoneOut"];

        auto result = onZoneOutFramework(CLuaBaseEntity(PChar), onZoneOut);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onZoneOut: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return;
        }
    }

    void OnTriggerAreaEnter(CCharEntity* PChar, CTriggerArea* PTriggerArea)
    {
        TracyZoneScoped;

        // Do not enter trigger areas while loading in. Set in xi.player.onGameIn
        if (PChar->GetLocalVar("ZoningIn") > 0)
        {
            return;
        }

        std::string                 filename;
        std::optional<CLuaInstance> optInstance = std::nullopt;
        if (PChar->PInstance)
        {
            filename =
                std::string("./scripts/zones/") + PChar->loc.zone->getName() + "/instances/" + PChar->PInstance->GetName() + ".lua";

            optInstance = CLuaInstance(PChar->PInstance);
        }
        else
        {
            filename = std::string("./scripts/zones/") + PChar->loc.zone->getName() + "/Zone.lua";
        }

        // player may be entering because of an earlier event (event that changes position)
        // these should probably not call another event from onTriggerAreaEnter (use onEventFinish instead)
        if (!PChar->isInEvent())
        {
            PChar->eventPreparation->scriptFile = filename;
        }

        auto name = PChar->loc.zone->getName();

        sol::function onTriggerAreaEnter;
        if (PChar->PInstance)
        {
            auto instance_name = PChar->PInstance->GetName();
            onTriggerAreaEnter = lua["xi"]["zones"][name]["instances"][instance_name]["onTriggerAreaEnter"];
        }
        else
        {
            onTriggerAreaEnter = lua["xi"]["zones"][name]["Zone"]["onTriggerAreaEnter"];
        }

        auto onTriggerAreaEnterFramework = lua["InteractionGlobal"]["onTriggerAreaEnter"];
        auto result                      = onTriggerAreaEnterFramework(CLuaBaseEntity(PChar), CLuaTriggerArea(PTriggerArea), optInstance, onTriggerAreaEnter);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTriggerAreaEnter: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
        }
    }

    void OnTriggerAreaLeave(CCharEntity* PChar, CTriggerArea* PTriggerArea)
    {
        TracyZoneScoped;

        std::string                 filename;
        std::optional<CLuaInstance> optInstance = std::nullopt;
        if (PChar->PInstance)
        {
            filename =
                std::string("scripts/zones/") + PChar->loc.zone->getName() + "/instances/" + PChar->PInstance->GetName() + ".lua";

            optInstance = CLuaInstance(PChar->PInstance);
        }
        else
        {
            filename = std::string("scripts/zones/") + PChar->loc.zone->getName() + "/Zone.lua";
        }

        // player may be leaving because of an earlier event (event that changes position)
        if (!PChar->isInEvent())
        {
            PChar->eventPreparation->scriptFile = filename;
        }

        auto name   = PChar->loc.zone->getName();
        auto zoneId = PChar->loc.zone->GetID();

        sol::function onTriggerAreaLeave;
        if (PChar->PInstance && zoneId == PChar->PInstance->GetZone()->GetID())
        {
            auto instance_name = PChar->PInstance->GetName();
            onTriggerAreaLeave = lua["xi"]["zones"][name]["instances"][instance_name]["onTriggerAreaLeave"];
        }
        else
        {
            onTriggerAreaLeave = lua["xi"]["zones"][name]["Zone"]["onTriggerAreaLeave"];
        }

        auto onTriggerAreaLeaveFramework = lua["InteractionGlobal"]["onTriggerAreaLeave"];
        auto result                      = onTriggerAreaLeaveFramework(CLuaBaseEntity(PChar), CLuaTriggerArea(PTriggerArea), optInstance, onTriggerAreaLeave);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTriggerAreaLeave: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
        }
    }

    int32 OnTrigger(CCharEntity* PChar, CBaseEntity* PNpc)
    {
        TracyZoneScoped;

        // Clicking objects does nothing if the player is mid synthesis
        if (PChar->animation == ANIMATION_SYNTH)
        {
            return 0;
        }

        auto        zone = PChar->loc.zone->getName();
        auto        name = PNpc->getName();
        std::string pathFormat;
        switch (PNpc->objtype)
        {
            case TYPE_NPC:
                pathFormat = "./scripts/zones/{}/npcs/{}.lua";
                break;
            case TYPE_MOB:
                pathFormat = "./scripts/zones/{}/mobs/{}.lua";
                break;
            default:
                // Should never hit this
                ShowError("Invalid objtype for entity received.");
                return -1;
        }
        auto filename = fmt::format(fmt::runtime(pathFormat), zone, name);

        ShowTraceFmt("luautils::OnTrigger: {} ({}) -> {}", name, zone, PNpc->getName());

        PChar->eventPreparation->targetEntity = PNpc;
        PChar->eventPreparation->scriptFile   = filename;

        auto onTriggerFramework = lua["InteractionGlobal"]["onTrigger"];
        auto onTrigger          = GetCacheEntryFromFilename(filename)["onTrigger"];

        auto result = onTriggerFramework(CLuaBaseEntity(PChar), CLuaBaseEntity(PNpc), onTrigger);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTrigger: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return -1;
        }

        return result.get_type() == sol::type::number ? result.get<int32>() : 0;
    }

    int32 OnEventUpdate(CCharEntity* PChar, uint16 eventID, uint32 result)
    {
        TracyZoneScoped;

        ShowTraceFmt("luautils::OnEventUpdate: {} ({}), id: {}, result: {}",
                     PChar->getName(), PChar->loc.zone->getName(), eventID, result);

        EventPrep* previousPrep = PChar->eventPreparation;
        PChar->eventPreparation = PChar->currentEvent;

        auto onEventUpdateFramework = lua["InteractionGlobal"]["onEventUpdate"];
        auto onEventUpdate          = LoadEventScript(PChar, "onEventUpdate");

        std::optional<CLuaBaseEntity> optTarget = std::nullopt;
        if (PChar->currentEvent->targetEntity)
        {
            optTarget = CLuaBaseEntity(PChar->currentEvent->targetEntity);
        }

        auto func_result = onEventUpdateFramework(CLuaBaseEntity(PChar), eventID, result, optTarget, onEventUpdate);

        PChar->eventPreparation = previousPrep;

        if (!func_result.valid())
        {
            sol::error err = func_result;
            ShowError("luautils::onEventUpdate: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return -1;
        }

        return func_result.get_type() == sol::type::number ? func_result.get<int32>() : 1;
    }

    int32 OnEventUpdate(CCharEntity* PChar, std::string const& updateString)
    {
        TracyZoneScoped;

        ShowTraceFmt("luautils::OnEventUpdate: {} ({}), string: {}",
                     PChar->getName(), PChar->loc.zone->getName(), updateString);

        EventPrep* previousPrep = PChar->eventPreparation;
        PChar->eventPreparation = PChar->currentEvent;

        auto onEventUpdateFramework = lua["InteractionGlobal"]["onEventUpdate"];
        auto onEventUpdate          = LoadEventScript(PChar, "onEventUpdate");

        std::optional<CLuaBaseEntity> optTarget = std::nullopt;
        if (PChar->currentEvent->targetEntity)
        {
            optTarget = CLuaBaseEntity(PChar->currentEvent->targetEntity);
        }

        auto result = onEventUpdateFramework(CLuaBaseEntity(PChar), PChar->currentEvent->eventId, updateString, optTarget, onEventUpdate);

        PChar->eventPreparation = previousPrep;

        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onEventUpdate: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return -1;
        }

        return 0;
    }

    int32 OnEventFinish(CCharEntity* PChar, uint16 eventID, uint32 result)
    {
        TracyZoneScoped;

        ShowTraceFmt("luautils::OnEventFinish: {} ({}), id: {}, result: {}",
                     PChar->getName(), PChar->loc.zone->getName(), eventID, result);

        EventPrep* previousPrep = PChar->eventPreparation;
        PChar->eventPreparation = PChar->currentEvent;

        auto onEventFinishFramework = lua["InteractionGlobal"]["onEventFinish"];
        auto onEventFinish          = LoadEventScript(PChar, "onEventFinish");

        std::optional<CLuaBaseEntity> optTarget = std::nullopt;
        if (PChar->currentEvent->targetEntity)
        {
            if (PChar->currentEvent->targetEntity->objtype == TYPE_NPC)
            {
                PChar->currentEvent->targetEntity->SetLocalVar("pauseNPCPathing", 0);
            }

            optTarget = CLuaBaseEntity(PChar->currentEvent->targetEntity);
        }

        auto func_result = onEventFinishFramework(CLuaBaseEntity(PChar), eventID, result, optTarget, onEventFinish);

        // Restore eventPreparation before potentially bailing out of function due to errors
        PChar->eventPreparation = previousPrep;

        if (!func_result.valid())
        {
            sol::error err = func_result;
            ShowError("luautils::onEventFinish %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return -1;
        }

        if (PChar->currentEvent->scriptFile.find("/bcnms/") > 0 && PChar->health.hp <= 0)
        { // for some reason the event doesnt enforce death afterwards
            PChar->animation = ANIMATION_DEATH;
            PChar->pushPacket<CRaiseTractorMenuPacket>(PChar, TYPE_HOMEPOINT);
            PChar->updatemask |= UPDATE_HP;
        }

        return 0;
    }

    void OnTrade(CCharEntity* PChar, CBaseEntity* PNpc)
    {
        TracyZoneScoped;

        auto zone     = PChar->loc.zone->getName();
        auto name     = PNpc->getName();
        auto filename = fmt::format("./scripts/zones/{}/npcs/{}.lua", zone, name);

        ShowTrace("luautils::OnTrade: {} ({}) -> {}", PChar->getName(), zone, name);

        PChar->eventPreparation->targetEntity = PNpc;
        PChar->eventPreparation->scriptFile   = filename;

        auto onTradeFramework = lua["InteractionGlobal"]["onTrade"];
        auto onTrade          = GetCacheEntryFromFilename(filename)["onTrade"];

        auto result = onTradeFramework(CLuaBaseEntity(PChar), CLuaBaseEntity(PNpc), CLuaTradeContainer(PChar->TradeContainer), onTrade);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTrade: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
        }
    }

    void OnNpcSpawn(CBaseEntity* PNpc)
    {
        TracyZoneScoped;

        if (PNpc == nullptr)
        {
            ShowError("luautils::onNpcSpawn: Npc not found!");
            return;
        }

        auto onSpawn = getEntityCachedFunction(PNpc, "onSpawn");
        if (!onSpawn.valid())
        {
            return;
        }

        auto result = onSpawn(CLuaBaseEntity(PNpc));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onNpcSpawn: %s", err.what());
        }
    }

    // Used by mobs
    void OnAdditionalEffect(CBattleEntity* PAttacker, CBattleEntity* PDefender, actionTarget_t* Action, int32 damage)
    {
        TracyZoneScoped;

        sol::function onAdditionalEffect;
        if (PAttacker->objtype == TYPE_MOB)
        {
            auto zone          = PAttacker->loc.zone->getName();
            auto name          = PAttacker->getName();
            onAdditionalEffect = lua[sol::create_if_nil]["xi"]["zones"][zone]["mobs"][name]["onAdditionalEffect"];
        }

        if (!onAdditionalEffect.valid())
        {
            return;
        }

        auto result = onAdditionalEffect(CLuaBaseEntity(PAttacker), CLuaBaseEntity(PDefender), damage);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onAdditionalEffect: %s", err.what());
            return;
        }

        Action->additionalEffect = (SUBEFFECT)(result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0);
        Action->addEffectMessage = result.get_type(1) == sol::type::number ? result.get<int32>(1) : 0;
        Action->addEffectParam   = result.get_type(2) == sol::type::number ? result.get<int32>(2) : 0;
    }

    // Used by mobs
    void OnSpikesDamage(CBattleEntity* PDefender, CBattleEntity* PAttacker, actionTarget_t* Action, int32 damage)
    {
        TracyZoneScoped;

        auto zone = PDefender->loc.zone->getName();
        auto name = PDefender->getName();

        auto onSpikesDamage = lua["xi"]["zones"][zone]["mobs"][name]["onSpikesDamage"];
        if (!onSpikesDamage.valid())
        {
            return;
        }

        auto result = onSpikesDamage(CLuaBaseEntity(PDefender), CLuaBaseEntity(PAttacker), damage);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onSpikesDamage: %s", err.what());
            return;
        }

        Action->spikesEffect  = (SUBEFFECT)(result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0);
        Action->spikesMessage = result.get_type(1) == sol::type::number ? result.get<int32>(1) : 0;
        Action->spikesParam   = result.get_type(2) == sol::type::number ? result.get<int32>(2) : 0;
    }

    // Used by items
    int32 additionalEffectAttack(CBattleEntity* PAttacker, CBattleEntity* PDefender, CItemWeapon* PItem, actionTarget_t* Action, int32 baseAttackDamage)
    {
        TracyZoneScoped;

        sol::function additionalEffectAttack;
        if (PAttacker->objtype == TYPE_PC)
        {
            additionalEffectAttack = lua[sol::create_if_nil]["xi"]["additionalEffect"]["attack"];
        }

        if (!additionalEffectAttack.valid())
        {
            return -1;
        }

        auto result = additionalEffectAttack(CLuaBaseEntity(PAttacker), CLuaBaseEntity(PDefender), baseAttackDamage, CLuaItem(PItem));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::additionalEffectAttack: %s", err.what());
            return -1;
        }

        Action->additionalEffect = (SUBEFFECT)(result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0);
        Action->addEffectMessage = result.get_type(1) == sol::type::number ? result.get<int32>(1) : 0;
        Action->addEffectParam   = result.get_type(2) == sol::type::number ? result.get<int32>(2) : 0;

        return 0;
    }

    // NOTE: This is currently unused
    // future use: migrating items to scripts\globals\additional_effects.lua
    void additionalEffectSpikes(CBattleEntity* PDefender, CBattleEntity* PAttacker, CItemEquipment* PItem, actionTarget_t* Action, int32 baseAttackDamage)
    {
        TracyZoneScoped;

        auto additionalEffectSpikes = lua["xi"]["additionalEffect"]["spikes"];
        if (!additionalEffectSpikes.valid())
        {
            return;
        }

        auto result = additionalEffectSpikes(CLuaBaseEntity(PDefender), CLuaBaseEntity(PAttacker), baseAttackDamage, CLuaItem(PItem));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::additionalEffectSpikes: %s", err.what());
            return;
        }

        Action->additionalEffect = (SUBEFFECT)(result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0);
        Action->addEffectMessage = result.get_type(1) == sol::type::number ? result.get<int32>(1) : 0;
        Action->addEffectParam   = result.get_type(2) == sol::type::number ? result.get<int32>(2) : 0;
    }

    void OnEffectGain(CBattleEntity* PEntity, CStatusEffect* PStatusEffect)
    {
        TracyZoneScoped;

        std::string filename = fmt::format("./scripts/{}.lua", PStatusEffect->GetName());

        sol::function onEffectGain = GetCacheEntryFromFilename(filename)["onEffectGain"].get<sol::function>();
        if (!onEffectGain.valid())
        {
            return;
        }

        auto result = onEffectGain(CLuaBaseEntity(PEntity), CLuaStatusEffect(PStatusEffect));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onEffectGain: %s", err.what());
            ReportErrorToPlayer(PEntity, err.what());
        }
    }

    void OnEffectTick(CBattleEntity* PEntity, CStatusEffect* PStatusEffect)
    {
        TracyZoneScoped;

        std::string filename = fmt::format("./scripts/{}.lua", PStatusEffect->GetName());

        sol::function onEffectTick = GetCacheEntryFromFilename(filename)["onEffectTick"].get<sol::function>();
        if (!onEffectTick.valid())
        {
            return;
        }

        auto result = onEffectTick(CLuaBaseEntity(PEntity), CLuaStatusEffect(PStatusEffect));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onEffectTick: %s", err.what());
            ReportErrorToPlayer(PEntity, err.what());
        }
    }

    void OnEffectLose(CBattleEntity* PEntity, CStatusEffect* PStatusEffect)
    {
        TracyZoneScoped;

        std::string filename = fmt::format("./scripts/{}.lua", PStatusEffect->GetName());

        sol::function onEffectLose = GetCacheEntryFromFilename(filename)["onEffectLose"].get<sol::function>();
        if (!onEffectLose.valid())
        {
            return;
        }

        auto result = onEffectLose(CLuaBaseEntity(PEntity), CLuaStatusEffect(PStatusEffect));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onEffectLose: %s", err.what());
            ReportErrorToPlayer(PEntity, err.what());
        }
    }

    void OnAttachmentEquip(CBattleEntity* PEntity, CItemPuppet* attachment)
    {
        TracyZoneScoped;

        auto name = attachment->getName();

        auto onEquip = lua["xi"]["actions"]["abilities"]["pets"]["attachments"][name]["onEquip"];
        if (!onEquip.valid())
        {
            return;
        }

        auto result = onEquip(CLuaBaseEntity(PEntity), CLuaItem(attachment));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onEquip: %s", err.what());
        }
    }

    void OnAttachmentUnequip(CBattleEntity* PEntity, CItemPuppet* attachment)
    {
        TracyZoneScoped;

        auto name = attachment->getName();

        auto onUnequip = lua["xi"]["actions"]["abilities"]["pets"]["attachments"][name]["onUnequip"];
        if (!onUnequip.valid())
        {
            return;
        }

        auto result = onUnequip(CLuaBaseEntity(PEntity), CLuaItem(attachment));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onUnequip: %s", err.what());
        }
    }

    void OnManeuverGain(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers)
    {
        TracyZoneScoped;

        auto name = attachment->getName();

        auto onManeuverGain = lua["xi"]["actions"]["abilities"]["pets"]["attachments"][name]["onManeuverGain"];
        if (!onManeuverGain.valid())
        {
            return;
        }

        auto result = onManeuverGain(CLuaBaseEntity(PEntity), CLuaItem(attachment), maneuvers);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onManeuverGain: %s", err.what());
        }
    }

    void OnManeuverLose(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers)
    {
        TracyZoneScoped;

        auto name = attachment->getName();

        auto onManeuverLose = lua["xi"]["actions"]["abilities"]["pets"]["attachments"][name]["onManeuverLose"];
        if (!onManeuverLose.valid())
        {
            return;
        }

        auto result = onManeuverLose(CLuaBaseEntity(PEntity), CLuaItem(attachment), maneuvers);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onManeuverLose: %s", err.what());
        }
    }

    void OnUpdateAttachment(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers)
    {
        TracyZoneScoped;

        auto name = attachment->getName();

        auto onUpdate = lua["xi"]["actions"]["abilities"]["pets"]["attachments"][name]["onUpdate"];
        if (!onUpdate.valid())
        {
            return;
        }

        auto result = onUpdate(CLuaBaseEntity(PEntity), CLuaItem(attachment), maneuvers);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onUpdate: %s", err.what());
        }
    }

    // We check the possibility of using the item.
    // If all is well, then return value - 0, in case of failure - error message number
    auto OnItemCheck(CBaseEntity* PTarget, CItem* PItem, ITEMCHECK param, CBaseEntity* PCaster) -> std::tuple<int32, int32, int32>
    {
        TracyZoneScoped;

        auto filename = fmt::format("./scripts/items/{}.lua", PItem->getName());

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

        auto result = onItemCheck(CLuaBaseEntity(PTarget), CLuaItem(PItem), static_cast<uint32>(param), caster);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onItemCheck: %s", err.what());
            ReportErrorToPlayer(PTarget, err.what());
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
    void OnItemUse(CBaseEntity* PUser, CBaseEntity* PTarget, CItem* PItem)
    {
        TracyZoneScoped;

        auto filename = fmt::format("./scripts/items/{}.lua", PItem->getName());

        sol::function onItemUse = GetCacheEntryFromFilename(filename)["onItemUse"].get<sol::function>();
        if (!onItemUse.valid())
        {
            return;
        }

        // using an item removes invisible status effect
        if (auto* PBattleEntity = dynamic_cast<CBattleEntity*>(PUser))
        {
            if (PBattleEntity->StatusEffectContainer->HasStatusEffect(EFFECT_INVISIBLE))
            {
                PBattleEntity->StatusEffectContainer->DelStatusEffect(EFFECT_INVISIBLE);
            }
        }

        auto result = onItemUse(CLuaBaseEntity(PTarget), CLuaBaseEntity(PUser), CLuaItem(PItem));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onItemUse: %s", err.what());
            ReportErrorToPlayer(PUser, err.what());
        }
    }

    // Trigger Code on an item when it has been dropped
    void OnItemDrop(CBaseEntity* PUser, CItem* PItem)
    {
        TracyZoneScoped;

        auto filename = fmt::format("./scripts/items/{}.lua", PItem->getName());

        sol::function onItemDrop = GetCacheEntryFromFilename(filename)["onItemDrop"].get<sol::function>();
        if (!onItemDrop.valid())
        {
            return;
        }

        auto result = onItemDrop(CLuaBaseEntity(PUser), CLuaItem(PItem));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onItemDrop: %s", err.what());
            ReportErrorToPlayer(PUser, err.what());
        }
    }

    void OnItemEquip(CBaseEntity* PUser, CItem* PItem)
    {
        TracyZoneScoped;

        auto filename = fmt::format("./scripts/items/{}.lua", PItem->getName());

        sol::function onItemEquip = GetCacheEntryFromFilename(filename)["onItemEquip"].get<sol::function>();
        if (!onItemEquip.valid())
        {
            return;
        }

        auto result = onItemEquip(CLuaBaseEntity(PUser), CLuaItem(PItem));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onItemEquip: %s", err.what());
            ReportErrorToPlayer(PUser, err.what());
        }
    }

    void OnItemUnequip(CBaseEntity* PUser, CItem* PItem)
    {
        TracyZoneScoped;

        auto filename = fmt::format("./scripts/items/{}.lua", PItem->getName());

        sol::function onItemUnequip = GetCacheEntryFromFilename(filename)["onItemUnequip"].get<sol::function>();
        if (!onItemUnequip.valid())
        {
            return;
        }

        auto result = onItemUnequip(CLuaBaseEntity(PUser), CLuaItem(PItem));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onItemUnequip: %s", err.what());
            ReportErrorToPlayer(PUser, err.what());
        }
    }

    // Check for gear sets  (e.g Set: enhances haste effect)
    void CheckForGearSet(CBaseEntity* PTarget)
    {
        TracyZoneScoped;

        auto checkForGearSet = lua["xi"]["gear_sets"]["checkForGearSet"];
        if (!checkForGearSet.valid())
        {
            return;
        }

        auto result = checkForGearSet(CLuaBaseEntity(PTarget));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::CheckForGearSet: %s", err.what());
            ReportErrorToPlayer(PTarget, err.what());
        }
    }

    int32 OnSpellCast(CBattleEntity* PCaster, CBattleEntity* PTarget, CSpell* PSpell)
    {
        TracyZoneScoped;

        if (PSpell == nullptr)
        {
            ShowError("luautils::OnSpellCast: Spell not found!");
            return 0;
        }

        auto onSpellCast = getSpellCachedFunction(PSpell, "onSpellCast");
        if (!onSpellCast.valid())
        {
            return 0;
        }

        auto result = onSpellCast(CLuaBaseEntity(PCaster), CLuaBaseEntity(PTarget), CLuaSpell(PSpell));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onSpellCast: %s", err.what());
            ReportErrorToPlayer(PCaster, err.what());
            return 0;
        }

        int32 retVal = result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
        return retVal;
    }

    void OnSpellPrecast(CBattleEntity* PCaster, CSpell* PSpell)
    {
        TracyZoneScoped;

        if (PCaster->objtype != TYPE_MOB)
        {
            return;
        }

        sol::function onSpellPrecast = getEntityCachedFunction(PCaster, "onSpellPrecast");
        if (!onSpellPrecast.valid())
        {
            return;
        }

        auto result = onSpellPrecast(CLuaBaseEntity(PCaster), CLuaSpell(PSpell));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onSpellPrecast: %s", err.what());
            ReportErrorToPlayer(PCaster, err.what());
        }
    }

    std::optional<SpellID> OnMobMagicPrepare(CBattleEntity* PCaster, CBattleEntity* PTarget, std::optional<SpellID> startingSpellId)
    {
        TracyZoneScoped;

        if (PCaster == nullptr)
        {
            return {};
        }

        sol::function onMobMagicPrepare = getEntityCachedFunction(PCaster, "onMobMagicPrepare");
        if (!onMobMagicPrepare.valid())
        {
            return {};
        }

        std::optional<CLuaSpell> luaSpell;
        if (startingSpellId.has_value())
        {
            luaSpell = spell::GetSpell(startingSpellId.value());
        }

        auto result = onMobMagicPrepare(CLuaBaseEntity(PCaster), CLuaBaseEntity(PTarget), luaSpell);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::OnMobMagicPrepare: %s", err.what());
            ReportErrorToPlayer(PCaster, err.what());
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
    void OnMagicHit(CBattleEntity* PCaster, CBattleEntity* PTarget, CSpell* PSpell)
    {
        TracyZoneScoped;

        if (PSpell == nullptr)
        {
            return;
        }

        sol::function onMagicHit = getEntityCachedFunction(PTarget, "onMagicHit");
        if (!onMagicHit.valid())
        {
            return;
        }

        auto result = onMagicHit(CLuaBaseEntity(PCaster), CLuaBaseEntity(PTarget), CLuaSpell(PSpell));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMagicHit: %s", err.what());
            return;
        }
    }

    // Called when mob is struck by a Weaponskill
    void OnWeaponskillHit(CBattleEntity* PMob, CBaseEntity* PAttacker, uint16 PWeaponskill)
    {
        TracyZoneScoped;

        sol::function onWeaponskillHit = getEntityCachedFunction(PMob, "onWeaponskillHit");
        if (!onWeaponskillHit.valid())
        {
            return;
        }

        auto result = onWeaponskillHit(CLuaBaseEntity(PMob), CLuaBaseEntity(PAttacker), PWeaponskill);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onWeaponskillHit: %s", err.what());
            return;
        }
    }

    bool OnTrustSpellCastCheckBattlefieldTrusts(CBattleEntity* PCaster) // Check if trust count would go over the limit when cast finishes (for simultaneous multi-party casts
    {
        TracyZoneScoped;

        sol::function checkBattlefieldTrustCount = lua["xi"]["trust"]["checkBattlefieldTrustCount"];

        if (!checkBattlefieldTrustCount.valid())
        {
            return false;
        }

        auto result = checkBattlefieldTrustCount(CLuaBaseEntity(PCaster));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::OnTrustSpellCastCheckBattlefieldTrusts: %s", err.what());
            return 0;
        }

        return result.get_type(0) == sol::type::boolean ? result.get<bool>(0) : true;
    }

    void OnMobInitialize(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        sol::function onMobInitialize = getEntityCachedFunction(PMob, "onMobInitialize");
        if (!onMobInitialize.valid())
        {
            return;
        }

        auto result = onMobInitialize(CLuaBaseEntity(PMob));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobInitialize: %s", err.what());
        }
    }

    // Called during server startup, file reads are OK!
    void ApplyMixins(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr || PMob->objtype != TYPE_MOB)
        {
            return;
        }

        // Clear out globals
        lua.set("mixins", sol::lua_nil);
        lua.set("mixinOptions", sol::lua_nil);

        auto zone_name = PMob->loc.zone->getName();
        auto name      = PMob->getName();

        auto filename = fmt::format("./scripts/zones/{}/mobs/{}.lua", zone_name, name);

        auto script_result = lua.safe_script_file(filename);
        if (!script_result.valid())
        {
            return;
        }

        // get the global function "applyMixins"
        sol::function applyMixins = lua["applyMixins"];
        if (!applyMixins.valid())
        {
            return;
        }

        // get the parameter "mixins"
        auto mixins = lua["mixins"];
        if (!mixins.valid())
        {
            return;
        }

        // get the parameter "mixinOptions" (optional)
        auto mixinOptions = lua["mixinOptions"];

        auto result = applyMixins(CLuaBaseEntity(PMob), mixins, mixinOptions);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::applyMixins: %s", err.what());
        }
    }

    // Called during server startup, file reads are OK!
    void ApplyZoneMixins(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr || PMob->objtype != TYPE_MOB)
        {
            return;
        }

        // Clear out any previous global definitions
        lua.set("mixins", sol::lua_nil);
        lua.set("mixinOptions", sol::lua_nil);

        auto filename = fmt::format("./scripts/mixins/zones/{}.lua", PMob->loc.zone->getName());

        auto script_result = lua.safe_script_file(filename);
        if (!script_result.valid())
        {
            return;
        }

        // get the global function "applyMixins"
        sol::function applyMixins = lua["applyMixins"];
        if (!applyMixins.valid())
        {
            return;
        }

        // get the parameter "mixins"
        auto mixins = lua["mixins"];
        if (!mixins.valid())
        {
            return;
        }

        // get the parameter "mixinOptions" (optional)
        auto mixinOptions = lua["mixinOptions"];

        auto result = applyMixins(CLuaBaseEntity(PMob), mixins, mixinOptions);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::applyMixins %s", err.what());
        }
    }

    void OnPath(CBaseEntity* PEntity)
    {
        TracyZoneScoped;

        if (PEntity == nullptr || PEntity->objtype == TYPE_PC)
        {
            return;
        }

        sol::function onPath = getEntityCachedFunction(PEntity, "onPath");
        if (!onPath.valid())
        {
            return;
        }

        auto result = onPath(CLuaBaseEntity(PEntity));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPath: %s", err.what());
        }
    }

    void OnPathPoint(CBaseEntity* PEntity)
    {
        TracyZoneScoped;

        if (PEntity == nullptr || PEntity->objtype == TYPE_PC)
        {
            return;
        }

        sol::function onPathPoint = getEntityCachedFunction(PEntity, "onPathPoint");
        if (!onPathPoint.valid())
        {
            return;
        }

        auto result = onPathPoint(CLuaBaseEntity(PEntity));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::OnPathPoint: %s", err.what());
        }
    }

    void OnPathComplete(CBaseEntity* PEntity)
    {
        TracyZoneScoped;

        if (PEntity == nullptr || PEntity->objtype == TYPE_PC)
        {
            return;
        }

        sol::function onPathComplete = getEntityCachedFunction(PEntity, "onPathComplete");
        if (!onPathComplete.valid())
        {
            return;
        }

        auto result = onPathComplete(CLuaBaseEntity(PEntity));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::OnPathComplete: %s", err.what());
        }
    }

    int32 OnBattlefieldHandlerInitialize(CZone* PZone)
    {
        TracyZoneScoped;

        if (PZone == nullptr)
        {
            return -1;
        }

        int32 MaxAreas = 3;

        // TODO: This is loaded globally, fix this
        auto onBattlefieldHandlerInitialize = lua["onBattlefieldHandlerInitialize"];
        if (!onBattlefieldHandlerInitialize.valid())
        {
            return MaxAreas;
        }

        CLuaZone LuaZone(PZone);

        auto result = onBattlefieldHandlerInitialize(CLuaZone(PZone));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onBattlefieldHandlerInitialize: %s", err.what());
            return MaxAreas;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : MaxAreas;
    }

    void OnBattlefieldInitialize(CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        if (PBattlefield == nullptr)
        {
            return;
        }

        invokeBattlefieldEvent(PBattlefield->GetID(), "onBattlefieldInitialize", CLuaBattlefield(PBattlefield));
    }

    void OnBattlefieldTick(CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        if (PBattlefield == nullptr)
        {
            return;
        }

        auto name    = PBattlefield->GetName();
        auto seconds = std::chrono::duration_cast<std::chrono::seconds>(PBattlefield->GetTimeInside()).count();

        if (invokeBattlefieldEvent(PBattlefield->GetID(), "onBattlefieldTick", CLuaBattlefield(PBattlefield), seconds) == 0)
        {
            return;
        }

        ShowError("luautils::onBattlefieldTick: Unable to find onBattlefieldTick function for %s", name);
    }

    void OnBattlefieldStatusChange(CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        if (PBattlefield == nullptr)
        {
            return;
        }

        invokeBattlefieldEvent(PBattlefield->GetID(), "onBattlefieldStatusChange", CLuaBattlefield(PBattlefield), PBattlefield->GetStatus());
    }

    void OnMobEngage(CBaseEntity* PMob, CBaseEntity* PTarget)
    {
        TracyZoneScoped;

        if (PTarget == nullptr || PMob == nullptr)
        {
            return;
        }

        std::string filename;
        if (PMob->objtype == TYPE_PET)
        {
            filename = fmt::format("./scripts/globals/pets/{}.lua", static_cast<CPetEntity*>(PMob)->GetScriptName());
        }
        else
        {
            filename = fmt::format("./scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->getName(), PMob->getName());
        }

        if (PTarget->objtype == TYPE_PC)
        {
            ((CCharEntity*)PTarget)->eventPreparation->targetEntity = PMob;
            ((CCharEntity*)PTarget)->eventPreparation->scriptFile   = filename;
        }

        sol::function onMobEngage = getEntityCachedFunction(PMob, "onMobEngage");
        if (!onMobEngage.valid())
        {
            return;
        }

        auto result = onMobEngage(CLuaBaseEntity(PMob), CLuaBaseEntity(PTarget));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobEngage: %s", err.what());
        }
    }

    void OnMobDisengage(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr)
        {
            return;
        }

        sol::function onMobDisengage = getEntityCachedFunction(PMob, "onMobDisengage");
        if (!onMobDisengage.valid())
        {
            return;
        }

        uint8 weather = PMob->loc.zone->GetWeather();

        auto result = onMobDisengage(CLuaBaseEntity(PMob), weather);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobDisengage: %s", err.what());
        }
    }

    void OnMobFollow(CBaseEntity* PMob, CBaseEntity* PTarget)
    {
        TracyZoneScoped;
        if (PTarget == nullptr || PMob == nullptr)
        {
            return;
        }

        sol::function onMobFollow = getEntityCachedFunction(PMob, "onMobFollow");
        if (!onMobFollow.valid())
        {
            return;
        }

        auto result = onMobFollow(CLuaBaseEntity(PMob), CLuaBaseEntity(PTarget));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobFollow: %s", err.what());
        }
    }

    void OnMobUnfollow(CBaseEntity* PMob, CBaseEntity* PTarget)
    {
        TracyZoneScoped;
        if (PTarget == nullptr || PMob == nullptr)
        {
            return;
        }

        sol::function onMobUnfollow = getEntityCachedFunction(PMob, "onMobUnfollow");
        if (!onMobUnfollow.valid())
        {
            return;
        }

        auto result = onMobUnfollow(CLuaBaseEntity(PMob), CLuaBaseEntity(PTarget));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobUnfollow: %s", err.what());
        }
    }

    void OnMobFight(CBaseEntity* PMob, CBaseEntity* PTarget)
    {
        TracyZoneScoped;

        if (PTarget == nullptr || PMob == nullptr)
        {
            return;
        }

        sol::function onMobFight = getEntityCachedFunction(PMob, "onMobFight");
        if (!onMobFight.valid())
        {
            return;
        }

        auto result = onMobFight(CLuaBaseEntity(PMob), CLuaBaseEntity(PTarget));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobFight: %s", err.what());
        }
    }

    void OnCriticalHit(CBattleEntity* PMob, CBattleEntity* PAttacker)
    {
        TracyZoneScoped;

        if (PMob == nullptr)
        {
            return;
        }

        sol::function onCriticalHit = getEntityCachedFunction(PMob, "onCriticalHit");
        if (!onCriticalHit.valid())
        {
            return;
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
            ShowError("luautils::onCriticalHit %s", err.what());
        }
    }

    void OnMobDeath(CBaseEntity* PMob, CBaseEntity* PKiller)
    {
        TracyZoneScoped;

        if (PMob == nullptr)
        {
            return;
        }

        std::string zone_name = PMob->loc.zone->getName();
        std::string mob_name  = PMob->getName();

        CCharEntity* PChar = dynamic_cast<CCharEntity*>(PKiller);

        auto optParams = lua.create_table();

        optParams["isKiller"]          = false;
        optParams["noKiller"]          = true;
        optParams["isWeaponSkillKill"] = false;

        if (PChar && PMob->objtype == TYPE_MOB)
        {
            auto onMobDeathEx = lua["xi"]["mob"]["onMobDeathEx"];
            if (!onMobDeathEx.valid())
            {
                return;
            }

            // clang-format off
            PChar->ForAlliance([PMob, PChar, &onMobDeathEx](CBattleEntity* PMember)
            {
                if (PMember->getZone() == PChar->getZone())
                {
                    CLuaBaseEntity LuaMobEntity(PMob);
                    CLuaBaseEntity LuaAllyEntity(PMember);
                    bool           isKiller          = PMember == PChar;
                    bool           isWeaponSkillKill = (PMob->GetLocalVar("weaponskillHit") & 0xFFFFFF) > 0;

                    auto result = onMobDeathEx(LuaMobEntity, LuaAllyEntity, isKiller, isWeaponSkillKill);
                    if (!result.valid())
                    {
                        sol::error err = result;
                        ShowError("luautils::onMobDeathEx: %s", err.what());
                    }
                }
            });
            // clang-format on

            auto filename = fmt::format("./scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->getName(), PMob->getName());

            auto          onMobDeathFramework = lua["InteractionGlobal"]["onMobDeath"];
            sol::function onMobDeath          = getEntityCachedFunction(PMob, "onMobDeath");

            // clang-format off
            PChar->ForAlliance([PMob, PChar, &onMobDeathFramework, &onMobDeath, &filename, &optParams](CBattleEntity* PPartyMember)
            {
                CCharEntity* PMember = (CCharEntity*)PPartyMember;
                if (PMember && PMember->getZone() == PChar->getZone())
                {
                    CLuaBaseEntity                LuaMobEntity(PMob);
                    std::optional<CLuaBaseEntity> optLuaAllyEntity  = std::nullopt;
                    uint32                        weaponskillVar    = PMob->GetLocalVar("weaponskillHit");
                    uint16                        weaponskillUsed   = weaponskillVar >> 24;
                    uint32                        weaponskillDamage = weaponskillVar & 0xFFFFFF;

                    if (PMember)
                    {
                        optLuaAllyEntity = CLuaBaseEntity(PMember);
                    }

                    optParams["isKiller"]          = PMember == PChar;
                    optParams["noKiller"]          = false;
                    optParams["isWeaponSkillKill"] = weaponskillUsed > 0;
                    optParams["weaponskillUsed"]   = weaponskillUsed;
                    optParams["weaponskillDamage"] = weaponskillDamage;

                    PChar->eventPreparation->targetEntity = PMob;
                    PChar->eventPreparation->scriptFile   = filename;

                    // onMobDeath(mob, player, optParams)
                    auto result = onMobDeathFramework(LuaMobEntity, optLuaAllyEntity, optParams, onMobDeath);

                    // NOTE: result is only NOT valid if the function call fails. If it returns nil its still valid (this is expected)
                    if (!result.valid())
                    {
                        sol::error err = result;
                        ShowError("luautils::onMobDeath: %s", err.what());
                    }

                    PChar->PAI->EventHandler.triggerListener("DEFEATED_MOB", LuaMobEntity, optLuaAllyEntity, optParams);
                }
            });
            // clang-format on
        }
        else
        {
            auto          onMobDeathFramework = lua["InteractionGlobal"]["onMobDeath"];
            sol::function onMobDeath          = getEntityCachedFunction(PMob, "onMobDeath");

            // onMobDeath(mob, player, optParams)
            auto result = onMobDeathFramework(CLuaBaseEntity(PMob), sol::lua_nil, optParams, onMobDeath);

            // NOTE: result is only NOT valid if the function call fails. If it returns nil its still valid (this is expected)
            if (!result.valid())
            {
                sol::error err = result;
                ShowError("luautils::onMobDeath: %s", err.what());
            }
        }
    }

    void OnMobSpawn(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr)
        {
            return;
        }

        sol::function onMobSpawn = getEntityCachedFunction(PMob, "onMobSpawn");
        if (!onMobSpawn.valid())
        {
            return;
        }

        auto result = onMobSpawn(CLuaBaseEntity(PMob));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobSpawn: %s", err.what());
        }
    }

    void OnMobRoamAction(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr || PMob->objtype != TYPE_MOB)
        {
            return;
        }

        sol::function onMobRoamAction = getEntityCachedFunction(PMob, "onMobRoamAction");
        if (!onMobRoamAction.valid())
        {
            return;
        }

        auto result = onMobRoamAction(CLuaBaseEntity(PMob));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobRoonMobRoamActionam: %s", err.what());
        }
    }

    void OnMobRoam(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        sol::function onMobRoam = getEntityCachedFunction(PMob, "onMobRoam");
        if (!onMobRoam.valid())
        {
            return;
        }

        auto result = onMobRoam(CLuaBaseEntity(PMob));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobRoam: %s", err.what());
        }
    }

    void OnMobDespawn(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr)
        {
            return;
        }

        auto onMobDespawn = getEntityCachedFunction(PMob, "onMobDespawn");
        if (!onMobDespawn.valid())
        {
            return;
        }

        auto result = onMobDespawn(CLuaBaseEntity(PMob));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobDespawn: %s", err.what());
        }
    }

    void OnPlayerAbilityUse(CBaseEntity* PMob, CBaseEntity* PPlayer, CAbility* PAbility)
    {
        TracyZoneScoped;

        if (PMob == nullptr || PPlayer == nullptr || PAbility == nullptr)
        {
            return;
        }

        auto onPlayerAbilityUse = getEntityCachedFunction(PMob, "onPlayerAbilityUse");
        if (!onPlayerAbilityUse.valid())
        {
            return;
        }

        auto result = onPlayerAbilityUse(CLuaBaseEntity(PMob), CLuaBaseEntity(PPlayer), CLuaAbility(PAbility));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPlayerAbilityUse: %s", err.what());
        }
    }

    void OnPetLevelRestriction(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr || PMob->objtype != TYPE_PET)
        {
            return;
        }

        sol::function onPetLevelRestriction = getEntityCachedFunction(PMob, "onPetLevelRestriction");
        if (!onPetLevelRestriction.valid())
        {
            return;
        }

        auto result = onPetLevelRestriction(CLuaBaseEntity(PMob));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPetLevelRestriction: %s", err.what());
        }
    }

    void OnGameDay(CZone* PZone)
    {
        TracyZoneScoped;

        auto name = PZone->getName();

        auto onGameDay = lua["xi"]["zones"][name]["Zone"]["onGameDay"];
        if (!onGameDay.valid())
        {
            return;
        }

        auto result = onGameDay();
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onGameDay: %s", err.what());
        }
    }

    void OnGameHour(CZone* PZone)
    {
        TracyZoneScoped;

        auto name = PZone->getName();

        auto onGameHour = lua["xi"]["zones"][name]["Zone"]["onGameHour"];
        if (!onGameHour.valid())
        {
            return;
        }

        auto result = onGameHour(CLuaZone(PZone));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onGameHour: %s", err.what());
        }
    }

    void OnZoneWeatherChange(uint16 ZoneID, uint8 weather)
    {
        TracyZoneScoped;

        CZone* PZone = zoneutils::GetZone(ZoneID);
        if (PZone == nullptr)
        {
            ShowWarning("Invalid ZoneID passed to function (%d).", ZoneID);
            return;
        }

        auto name = PZone->getName();

        auto onZoneWeatherChange = lua["xi"]["zones"][name]["Zone"]["onZoneWeatherChange"];
        if (!onZoneWeatherChange.valid())
        {
            return;
        }

        auto result = onZoneWeatherChange(weather);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onZoneWeatherChange: %s", err.what());
        }
    }

    void OnTOTDChange(uint16 ZoneID, uint8 TOTD)
    {
        TracyZoneScoped;

        CZone* PZone = zoneutils::GetZone(ZoneID);
        if (PZone == nullptr)
        {
            ShowWarning("Invalid ZoneID passed to function (%d).", ZoneID);
            return;
        }

        auto name = PZone->getName();

        auto onTOTDChange = lua["xi"]["zones"][name]["Zone"]["onTOTDChange"];
        if (!onTOTDChange.valid())
        {
            return;
        }

        auto result = onTOTDChange(TOTD);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTOTDChange: %s", err.what());
        }
    }

    std::tuple<int32, uint8, uint8> OnUseWeaponSkill(CBattleEntity* PChar, CBaseEntity* PMob, CWeaponSkill* wskill, uint16 tp, bool primary, action_t& action,
                                                     CBattleEntity* taChar)
    {
        TracyZoneScoped;

        auto name = wskill->getName();

        auto onUseWeaponSkill = lua["xi"]["actions"]["weaponskills"][name]["onUseWeaponSkill"];
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
            ShowError("luautils::onUseWeaponSkill: %s", err.what());
            return std::tuple<int32, uint8, uint8>();
        }

        uint8 tpHitsLanded    = result.get_type(0) == sol::type::number ? result.get<uint8>(0) : 0;
        uint8 extraHitsLanded = result.get_type(1) == sol::type::number ? result.get<uint8>(1) : 0;
        bool  criticalHit     = result.get_type(2) == sol::type::boolean ? result.get<bool>(2) : false;
        int32 dmg             = result.get_type(3) == sol::type::number ? result.get<int32>(3) : 0;

        if (criticalHit)
        {
            luautils::OnCriticalHit((CBattleEntity*)PMob, PChar);
        }

        return std::make_tuple(dmg, tpHitsLanded, extraHitsLanded);
    }

    uint16 OnMobWeaponSkillPrepare(CBattleEntity* PMob, CBattleEntity* PTarget)
    {
        TracyZoneScoped;

        if (PMob == nullptr || PTarget == nullptr)
        {
            return 0;
        }

        sol::function onMobWeaponSkillPrepare = getEntityCachedFunction(PMob, "onMobWeaponSkillPrepare");
        if (!onMobWeaponSkillPrepare.valid())
        {
            return 0;
        }

        auto result = onMobWeaponSkillPrepare(CLuaBaseEntity(PMob), CLuaBaseEntity(PTarget));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobWeaponSkillPrepare: %s", err.what());
            return 0;
        }

        uint16 retVal = result.get_type(0) == sol::type::number ? result.get<uint16>(0) : 0;
        if (retVal > 0)
        {
            return retVal;
        }

        return 0;
    }

    int32 OnMobWeaponSkill(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill, action_t* action)
    {
        TracyZoneScoped;

        // Mob Script
        {
            auto zone = PMob->loc.zone->getName();
            auto name = PMob->getName();

            auto onMobWeaponSkill = lua["xi"]["zones"][zone]["mobs"][name]["onMobWeaponSkill"];
            if (onMobWeaponSkill.valid())
            {
                auto result = onMobWeaponSkill(CLuaBaseEntity(PTarget), CLuaBaseEntity(PMob), CLuaMobSkill(PMobSkill), CLuaAction(action));
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError("luautils::onMobWeaponSkill (mob) %s", err.what());
                    return 0;
                }
            }
        }

        // Mob Skill Script
        auto mobskill_name = PMobSkill->getName();

        auto onMobWeaponSkill = lua["xi"]["actions"]["mobskills"][mobskill_name]["onMobWeaponSkill"];
        if (!onMobWeaponSkill.valid())
        {
            return 0;
        }

        auto result = onMobWeaponSkill(CLuaBaseEntity(PTarget), CLuaBaseEntity(PMob), CLuaMobSkill(PMobSkill));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobWeaponSkill (mobskill) %s", err.what());
            return 0;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
    }

    int32 OnMobSkillCheck(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill)
    {
        TracyZoneScoped;

        auto name = PMobSkill->getName();

        auto onMobSkillCheck = lua["xi"]["actions"]["mobskills"][name]["onMobSkillCheck"];
        if (!onMobSkillCheck.valid())
        {
            return 1;
        }

        auto result = onMobSkillCheck(CLuaBaseEntity(PTarget), CLuaBaseEntity(PMob), CLuaMobSkill(PMobSkill));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobSkillCheck: %s", err.what());
            return 1;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : -5;
    }

    CBattleEntity* OnMobSkillTarget(CBattleEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill)
    {
        TracyZoneScoped;

        auto zone = PMob->loc.zone->getName();
        auto name = PMob->getName();

        auto onMobSkillTarget = lua["xi"]["zones"][zone]["mobs"][name]["onMobSkillTarget"];
        if (!onMobSkillTarget.valid())
        {
            return PTarget;
        }

        auto result = onMobSkillTarget(CLuaBaseEntity(static_cast<CBaseEntity*>(PTarget)), CLuaBaseEntity(PMob), CLuaMobSkill(PMobSkill));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMobSkillTarget: %s", err.what());
            return PTarget;
        }

        if (result.get_type(0) == sol::type::userdata || result.get_type(0) == sol::type::lua_nil)
        {
            CLuaBaseEntity* PEntity = result.get<CLuaBaseEntity*>(0);

            return (PEntity && PEntity->GetBaseEntity()) ? static_cast<CBattleEntity*>(PEntity->GetBaseEntity()) : PTarget;
        }

        return PTarget;
    }

    int32 OnAutomatonAbilityCheck(CBaseEntity* PTarget, CAutomatonEntity* PAutomaton, CMobSkill* PMobSkill)
    {
        TracyZoneScoped;

        auto filename = fmt::format("./scripts/actions/abilities/pets/automaton/{}.lua", PMobSkill->getName());

        sol::function onAutomatonAbilityCheck = GetCacheEntryFromFilename(filename)["onAutomatonAbilityCheck"];
        if (!onAutomatonAbilityCheck.valid())
        {
            return 1;
        }

        auto result = onAutomatonAbilityCheck(CLuaBaseEntity(PTarget), CLuaBaseEntity(PAutomaton), CLuaMobSkill(PMobSkill));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onAutomatonAbilityCheck: %s", err.what());
            return 1;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : -5;
    }

    int32 OnAutomatonAbility(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill, CBaseEntity* PMobMaster, action_t* action)
    {
        auto filename = fmt::format("./scripts/actions/abilities/pets/automaton/{}.lua", PMobSkill->getName());

        sol::function onAutomatonAbility = GetCacheEntryFromFilename(filename)["onAutomatonAbility"];
        if (!onAutomatonAbility.valid())
        {
            return 0;
        }

        auto result = onAutomatonAbility(CLuaBaseEntity(PTarget), CLuaBaseEntity(PMob), CLuaMobSkill(PMobSkill), CLuaBaseEntity(PMobMaster), CLuaAction(action));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onAutomatonAbility: %s", err.what());
            return 0;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
    }

    auto GetMonstrosityLuaTable(CCharEntity* PChar) -> sol::table
    {
        TracyZoneScoped;

        // TODO: lua_monstrosity.cpp?
        auto table = lua.create_table();

        table["monstrosityId"] = PChar->m_PMonstrosity->MonstrosityId;
        table["species"]       = PChar->m_PMonstrosity->Species;
        table["flags"]         = PChar->m_PMonstrosity->Flags;
        table["entry_x"]       = PChar->m_PMonstrosity->EntryPos.x;
        table["entry_y"]       = PChar->m_PMonstrosity->EntryPos.y;
        table["entry_z"]       = PChar->m_PMonstrosity->EntryPos.z;
        table["entry_rot"]     = PChar->m_PMonstrosity->EntryPos.rotation;
        table["entry_zone_id"] = PChar->m_PMonstrosity->EntryZoneId;
        table["entry_mjob"]    = PChar->m_PMonstrosity->EntryMainJob;
        table["entry_sjob"]    = PChar->m_PMonstrosity->EntrySubJob;

        {
            std::size_t idx = 0;
            table["levels"] = lua.create_table();
            for (auto entry : PChar->m_PMonstrosity->levels)
            {
                table["levels"][idx++] = entry;
            }
        }

        {
            std::size_t idx    = 0;
            table["instincts"] = lua.create_table();
            for (auto entry : PChar->m_PMonstrosity->instincts)
            {
                table["instincts"][idx++] = entry;
            }
        }

        {
            std::size_t idx   = 0;
            table["variants"] = lua.create_table();
            for (auto entry : PChar->m_PMonstrosity->variants)
            {
                table["variants"][idx++] = entry;
            }
        }

        return table;
    }

    void SetMonstrosityLuaTable(CCharEntity* PChar, sol::table table)
    {
        TracyZoneScoped;

        if (table["monstrosityId"].valid())
        {
            PChar->m_PMonstrosity->MonstrosityId = table.get<uint8>("monstrosityId");
        }

        if (table["species"].valid())
        {
            PChar->m_PMonstrosity->Species = table.get<uint16>("species");
        }

        if (table["flags"].valid())
        {
            PChar->m_PMonstrosity->Flags = table.get<uint16>("flags");
        }

        if (table["entry_x"].valid())
        {
            PChar->m_PMonstrosity->EntryPos.x = table.get<float>("entry_x");
        }

        if (table["entry_y"].valid())
        {
            PChar->m_PMonstrosity->EntryPos.y = table.get<float>("entry_y");
        }

        if (table["entry_z"].valid())
        {
            PChar->m_PMonstrosity->EntryPos.z = table.get<float>("entry_z");
        }

        if (table["entry_rot"].valid())
        {
            PChar->m_PMonstrosity->EntryPos.rotation = table.get<uint8>("entry_rot");
        }

        if (table["entry_zone_id"].valid())
        {
            PChar->m_PMonstrosity->EntryZoneId = table.get<uint16>("entry_zone_id");
        }

        if (table["entry_mjob"].valid())
        {
            PChar->m_PMonstrosity->EntryMainJob = table.get<uint8>("entry_mjob");
        }

        if (table["entry_sjob"].valid())
        {
            PChar->m_PMonstrosity->EntrySubJob = table.get<uint8>("entry_sjob");
        }

        if (table["levels"].valid())
        {
            for (auto const& [keyObj, valObj] : table.get<sol::table>("levels"))
            {
                uint8 key = keyObj.as<uint8>();
                uint8 val = valObj.as<uint8>();
                PChar->m_PMonstrosity->levels[key] |= val;
            }
        }

        if (table["instincts"].valid())
        {
            for (auto const& [keyObj, valObj] : table.get<sol::table>("instincts"))
            {
                uint8 key = keyObj.as<uint8>();
                uint8 val = valObj.as<uint8>();
                PChar->m_PMonstrosity->instincts[key] |= val;
            }
        }

        if (table["variants"].valid())
        {
            for (auto const& [keyObj, valObj] : table.get<sol::table>("variants"))
            {
                uint8 key = keyObj.as<uint8>();
                uint8 val = valObj.as<uint8>();
                PChar->m_PMonstrosity->variants[key] |= val;
            }
        }
    }

    void OnMonstrosityUpdate(CCharEntity* PChar)
    {
        TracyZoneScoped;

        sol::function onMonstrosityUpdate = lua["xi"]["monstrosity"]["onMonstrosityUpdate"];
        if (!onMonstrosityUpdate.valid())
        {
            ShowError("luautils::OnMonstrosityUpdate");
            return;
        }

        auto result = onMonstrosityUpdate(CLuaBaseEntity(PChar), GetMonstrosityLuaTable(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::OnMonstrosityUpdate: %s", err.what());
            return;
        }
    }

    void OnMonstrosityReturnToEntrance(CCharEntity* PChar)
    {
        TracyZoneScoped;

        sol::function onMonstrosityReturnToEntrance = lua["xi"]["monstrosity"]["onMonstrosityReturnToEntrance"];
        if (!onMonstrosityReturnToEntrance.valid())
        {
            ShowError("luautils::retuonMonstrosityReturnToEntrancernToEntrance");
            return;
        }

        auto result = onMonstrosityReturnToEntrance(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMonstrosityReturnToEntrance: %s", err.what());
            return;
        }
    }

    int32 OnMagicCastingCheck(CBaseEntity* PChar, CBaseEntity* PTarget, CSpell* PSpell)
    {
        TracyZoneScoped;

        auto onMagicCastingCheck = getSpellCachedFunction(PSpell, "onMagicCastingCheck");
        if (!onMagicCastingCheck.valid())
        {
            ShowWarning("luautils::onMagicCastingCheck, spell (%s) has no lua file, it cannot be cast.", PSpell->getName());
            return 47;
        }

        auto result = onMagicCastingCheck(CLuaBaseEntity(PChar), CLuaBaseEntity(PTarget), CLuaSpell(PSpell));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMagicCastingCheck (%s): %s", PSpell->getName(), err.what());
            return 47;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : -5;
    }

    int32 OnAbilityCheck(CBaseEntity* PChar, CBaseEntity* PTarget, CAbility* PAbility, CBaseEntity** PMsgTarget)
    {
        TracyZoneScoped;

        if (PAbility == nullptr)
        {
            ShowError("luautils::OnAbilityCheck: Invalid PAbility");
            return 87;
        }

        std::string filename;
        if (PAbility->isPetAbility())
        {
            filename = fmt::format("./scripts/actions/abilities/pets/{}.lua", PAbility->getName());
        }
        else
        {
            filename = fmt::format("./scripts/actions/abilities/{}.lua", PAbility->getName());
        }

        sol::function onAbilityCheck = GetCacheEntryFromFilename(filename)["onAbilityCheck"];
        if (!onAbilityCheck.valid())
        {
            // TODO: We rely on this to fail silently in certain cases, but this is bad :(
            // ShowWarning("luautils::onAbilityCheck - Ability %s not found.", PAbility->getName());
            return 0;
        }

        auto result = onAbilityCheck(CLuaBaseEntity(PChar), CLuaBaseEntity(PTarget), CLuaAbility(PAbility));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onAbilityCheck (%s): %s", PAbility->getName(), err.what());
            return 87;
        }

        auto result0 = result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0; // Message (0 = None)
        auto result1 = result.get_type(1) == sol::type::number ? result.get<int32>(1) : 0;
        if (result1 != 0)
        {
            *PMsgTarget = PTarget;
        }

        return result0 ? result0 : 0; // Default to no Message
    }

    int32 OnPetAbility(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill, CBaseEntity* PMobMaster, action_t* action)
    {
        TracyZoneScoped;

        std::string filename = fmt::format("./scripts/actions/abilities/pets/{}.lua", PMobSkill->getName());

        sol::function onPetAbility = GetCacheEntryFromFilename(filename)["onPetAbility"];
        if (!onPetAbility.valid())
        {
            return 0;
        }

        auto result = onPetAbility(CLuaBaseEntity(PTarget), CLuaBaseEntity(PMob), CLuaMobSkill(PMobSkill), CLuaBaseEntity(PMobMaster), CLuaAction(action));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPetAbility: %s", err.what());
            return 0;
        }

        // Bloodpact Skillups
        // TODO: This probably shouldn't be in here
        if (PMob->objtype == TYPE_PET && settings::get<bool>("map.SKILLUP_BLOODPACT"))
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

    int32 OnPetAbility(CBaseEntity* PTarget, CPetEntity* PPet, CPetSkill* PPetSkill, CBaseEntity* PMobMaster, action_t* action)
    {
        TracyZoneScoped;

        std::string filename = fmt::format("./scripts/actions/abilities/pets/{}.lua", PPetSkill->getName());

        sol::function onPetAbility = GetCacheEntryFromFilename(filename)["onPetAbility"];
        if (!onPetAbility.valid())
        {
            return 0;
        }

        auto result = onPetAbility(CLuaBaseEntity(PTarget), CLuaBaseEntity(PPet), CLuaPetSkill(PPetSkill), CLuaBaseEntity(PMobMaster), CLuaAction(action));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPetAbility: %s", err.what());
            return 0;
        }

        if (PPet->getPetType() == PET_TYPE::AVATAR && PPet->PMaster->objtype == TYPE_PC)
        {
            CCharEntity* PMaster = (CCharEntity*)PPet->PMaster;
            if (PMaster->GetMJob() == JOB_SMN)
            {
                charutils::TrySkillUP(PMaster, SKILL_SUMMONING_MAGIC, PMaster->GetMLevel());
            }
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
    }

    int32 OnUseAbility(CBattleEntity* PUser, CBattleEntity* PTarget, CAbility* PAbility, action_t* action)
    {
        TracyZoneScoped;

        std::string filename;
        if (PAbility->isPetAbility())
        {
            filename = fmt::format("./scripts/actions/abilities/pets/{}.lua", PAbility->getName());
        }
        else
        {
            filename = fmt::format("./scripts/actions/abilities/{}.lua", PAbility->getName());
        }

        sol::function onUseAbility = GetCacheEntryFromFilename(filename)["onUseAbility"];
        if (!onUseAbility.valid())
        {
            ShowWarning("luautils::onUseAbility - Ability %s not found.", PAbility->getName());
            return 0;
        }

        auto result = onUseAbility(CLuaBaseEntity(PUser), CLuaBaseEntity(PTarget), CLuaAbility(PAbility), CLuaAction(action));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onUseAbility: %s", err.what());
            return 0;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
    }

    int32 OnSteal(CBattleEntity* PChar, CBattleEntity* PMob, CAbility* PAbility, action_t* action)
    {
        TracyZoneScoped;

        if (PChar == nullptr || PMob == nullptr)
        {
            return 0;
        }

        auto zone     = PChar->loc.zone->getName();
        auto name     = PMob->getName();
        auto filename = fmt::format("./scripts/zones/{}/mobs/{}.lua", zone, name);

        ShowTraceFmt("luautils::OnSteal: {} ({}) -> {}", PChar->getName(), zone, name);

        auto onStealFramework = lua["InteractionGlobal"]["onSteal"];
        auto onSteal          = GetCacheEntryFromFilename(filename)["onSteal"];

        auto result = onStealFramework(CLuaBaseEntity(PChar), CLuaBaseEntity(PMob), CLuaAbility(PAbility), CLuaAction(action), onSteal);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onSteal %s", err.what());
            return 0;
        }

        uint16 retVal = result.get_type(0) == sol::type::number ? result.get<uint16>(0) : 0;
        if (retVal > 0)
        {
            return retVal;
        }

        return 0;
    }

    bool OnCanUseSpell(CBattleEntity* PChar, CSpell* Spell) // triggers when CanUseSpell is invoked on spell.cpp for PCs only
    {
        TracyZoneScoped;

        sol::function canUseSpellOverride = lua["xi"]["spells"]["canUseSpellOverride"];

        if (!canUseSpellOverride.valid())
        {
            return false;
        }

        auto result = canUseSpellOverride(CLuaBaseEntity(PChar), CLuaSpell(Spell));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::OnCanUseSpell: %s", err.what());
            return false;
        }

        return result.get_type(0) == sol::type::boolean ? result.get<bool>(0) : true;
    }

    void Terminate()
    {
        TracyZoneScoped;
        // clang-format off
        zoneutils::ForEachZone([](CZone* PZone)
        {
            PZone->ForEachChar([](CCharEntity* PChar)
            {
                PChar->PersistData();
                charutils::SaveCharPosition(PChar);
                charutils::SaveCharStats(PChar);
                charutils::SaveCharExp(PChar, PChar->GetMJob());
            });
        });
        // clang-format on
        std::exit(1);
    }

    auto GetCachedInstanceScript(uint16 instanceId) -> sol::table
    {
        TracyZoneScoped;

        auto instanceData = instanceutils::GetInstanceData(instanceId);

        auto cachedInstanceScript = GetCacheEntryFromFilename(instanceData.filename);
        if (!cachedInstanceScript.valid())
        {
            ShowError("luautils::GetCachedInstanceScript: Could not retrieve cache entry for %d", instanceId);
            return sol::lua_nil;
        }

        return cachedInstanceScript;
    }

    void OnInstanceZoneIn(CCharEntity* PChar, CInstance* PInstance)
    {
        TracyZoneScoped;

        CZone* PZone = PInstance->GetZone();

        auto name = PZone->getName();

        auto onInstanceZoneIn = lua["xi"]["zones"][name]["Zone"]["onInstanceZoneIn"];
        if (!onInstanceZoneIn.valid())
        {
            return;
        }

        auto result = onInstanceZoneIn(CLuaBaseEntity(PChar), CLuaInstance(PInstance));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceZoneIn %s", err.what());
        }
    }

    void AfterInstanceRegister(CBaseEntity* PChar)
    {
        if (!PChar->PInstance)
        {
            ShowWarning("PInstance is null.");
            return;
        }

        TracyZoneScoped;

        auto zone     = PChar->loc.zone->getName();
        auto instance = PChar->PInstance->GetName();

        auto afterInstanceRegister = lua["xi"]["zones"][zone]["instances"][instance]["afterInstanceRegister"];
        if (!afterInstanceRegister.valid())
        {
            return;
        }

        auto result = afterInstanceRegister(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::afterInstanceRegister %s", err.what());
        }
    }

    int32 OnInstanceLoadFailed(CZone* PZone)
    {
        TracyZoneScoped;

        auto name = PZone->getName();

        auto onInstanceLoadFailed = lua["xi"]["zones"][name]["Zone"]["onInstanceLoadFailed"];
        if (!onInstanceLoadFailed.valid())
        {
            return -1;
        }

        auto result = onInstanceLoadFailed();
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceLoadFailed %s", err.what());
            return 0;
        }

        return result.get_type(0) == sol::type::number ? result.get<int32>(0) : 0;
    }

    void OnInstanceTimeUpdate(CZone* PZone, CInstance* PInstance, uint32 time)
    {
        TracyZoneScoped;

        auto instanceData = instanceutils::GetInstanceData(PInstance->GetID());

        auto onInstanceTimeUpdate = GetCacheEntryFromFilename(instanceData.filename)["onInstanceTimeUpdate"];
        if (!onInstanceTimeUpdate.valid())
        {
            return;
        }

        auto result = onInstanceTimeUpdate(CLuaInstance(PInstance), time);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceTimeUpdate %s", err.what());
        }
    }

    void OnInstanceFailure(CInstance* PInstance)
    {
        TracyZoneScoped;

        auto instanceData = instanceutils::GetInstanceData(PInstance->GetID());

        auto onInstanceFailure = GetCacheEntryFromFilename(instanceData.filename)["onInstanceFailure"];
        if (!onInstanceFailure.valid())
        {
            return;
        }

        auto result = onInstanceFailure(CLuaInstance(PInstance));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceFailure %s", err.what());
        }
    }

    /************************************************************************
     *                                                                       *
     *  When instance is created, let player know it's finished              *
     *                                                                       *
     ************************************************************************/

    void OnInstanceCreatedCallback(CCharEntity* PChar, CInstance* PInstance)
    {
        TracyZoneScoped;

        auto instanceData = instanceutils::GetInstanceData(PInstance->GetID());

        auto onInstanceCreatedCallback = GetCacheEntryFromFilename(instanceData.filename)["onInstanceCreatedCallback"];
        if (!onInstanceCreatedCallback.valid())
        {
            ShowError("luautils::OnInstanceCreatedCallback: undefined procedure onInstanceCreatedCallback");
            return;
        }

        auto result = onInstanceCreatedCallback(CLuaBaseEntity(PChar), CLuaInstance(PInstance));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::OnInstanceCreatedCallback %s", err.what());
        }
    }

    void OnInstanceCreated(CInstance* PInstance)
    {
        TracyZoneScoped;

        auto zone = PInstance->GetZone()->getName();
        auto name = PInstance->GetName();

        auto onInstanceCreated = lua["xi"]["zones"][zone]["instances"][name]["onInstanceCreated"];
        if (!onInstanceCreated.valid())
        {
            return;
        }

        auto result = onInstanceCreated(CLuaInstance(PInstance));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceCreated %s", err.what());
        }
    }

    void OnInstanceProgressUpdate(CInstance* PInstance)
    {
        TracyZoneScoped;

        auto zone = PInstance->GetZone()->getName();
        auto name = PInstance->GetName();

        auto onInstanceProgressUpdate = lua["xi"]["zones"][zone]["instances"][name]["onInstanceProgressUpdate"];
        if (!onInstanceProgressUpdate.valid())
        {
            return;
        }

        auto result = onInstanceProgressUpdate(CLuaInstance(PInstance), PInstance->GetProgress());
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceProgressUpdate %s", err.what());
        }
    }

    // TODO: This is currently unused
    void OnInstanceStageChange(CInstance* PInstance)
    {
        TracyZoneScoped;

        auto zone = PInstance->GetZone()->getName();
        auto name = PInstance->GetName();

        auto onInstanceStageChange = lua["xi"]["zones"][zone]["instances"][name]["onInstanceStageChange"];
        if (!onInstanceStageChange.valid())
        {
            return;
        }

        auto result = onInstanceStageChange(CLuaInstance(PInstance), PInstance->GetStage());
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceStageChange %s", err.what());
        }
    }

    void OnInstanceComplete(CInstance* PInstance)
    {
        TracyZoneScoped;

        auto zone = PInstance->GetZone()->getName();
        auto name = PInstance->GetName();

        auto onInstanceComplete = lua["xi"]["zones"][zone]["instances"][name]["onInstanceComplete"];
        if (!onInstanceComplete.valid())
        {
            return;
        }

        auto result = onInstanceComplete(CLuaInstance(PInstance));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onInstanceComplete %s", err.what());
        }
    }

    void StartElevator(uint32 ElevatorID)
    {
        TracyZoneScoped;
        CTransportHandler::getInstance()->startElevator(ElevatorID);
    }

    // Returns -1 if elevator is not found. Otherwise, returns the uint8 state.
    int16 GetElevatorState(uint8 id) // Returns -1 if elevator is not found. Otherwise, returns the uint8 state.
    {
        TracyZoneScoped;
        Elevator_t* elevator = CTransportHandler::getInstance()->getElevator(id);

        if (elevator)
        {
            return elevator->state;
        }

        return -1;
    }

    int32 GetServerVariable(std::string const& name)
    {
        return serverutils::GetServerVar(name);
    }

    void SetServerVariable(std::string const& name, int32 value, sol::object const& expiry)
    {
        uint32 varTimestamp = expiry.is<uint32>() ? expiry.as<uint32>() : 0;

        if (varTimestamp > 0 && varTimestamp <= CVanaTime::getInstance()->getSysTime())
        {
            ShowWarning(fmt::format("Attempting to set variable '{}' with an expired time: {}", name, varTimestamp));
            return;
        }

        serverutils::SetServerVar(name, value, varTimestamp);
    }

    int32 GetVolatileServerVariable(std::string const& varName)
    {
        return serverutils::GetVolatileServerVar(varName);
    }

    void SetVolatileServerVariable(std::string const& varName, int32 value, sol::object const& expiry)
    {
        uint32 varTimestamp = expiry.is<uint32>() ? expiry.as<uint32>() : 0;

        if (varTimestamp > 0 && varTimestamp <= CVanaTime::getInstance()->getSysTime())
        {
            ShowWarning(fmt::format("Attempting to set variable '{}' with an expired time: {}", varName, varTimestamp));
            return;
        }

        serverutils::SetVolatileServerVar(varName, value, varTimestamp);
    }

    int32 GetCharVar(uint32 charId, std::string const& varName)
    {
        return charutils::FetchCharVar(charId, varName).first;
    }

    // Using the charID set a char variable on the SQL DB
    void SetCharVar(uint32 charId, std::string const& varName, int32 value, sol::object const& expiry)
    {
        uint32 varTimestamp = expiry.is<uint32>() ? expiry.as<uint32>() : 0;

        if (varTimestamp > 0 && varTimestamp <= CVanaTime::getInstance()->getSysTime())
        {
            ShowWarning(fmt::format("Attempting to set variable '{}' with an expired time: {}", varName, varTimestamp));
            return;
        }

        charutils::SetCharVar(charId, varName, value, varTimestamp);
    }

    void ClearCharVarFromAll(std::string const& varName)
    {
        charutils::ClearCharVarFromAll(varName);
    }

    void OnTransportEvent(CCharEntity* PChar, uint32 TransportID)
    {
        TracyZoneScoped;

        auto name = PChar->loc.zone->getName();

        auto onTransportEvent = lua["xi"]["zones"][name]["Zone"]["onTransportEvent"];
        if (!onTransportEvent.valid())
        {
            return;
        }

        auto result = onTransportEvent(CLuaBaseEntity(PChar), TransportID);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTransportEvent: %s", err.what());
        }
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
            ShowError("luautils::onTimeTrigger: %s", err.what());
            return;
        }
    }

    void OnConquestUpdate(CZone* PZone, ConquestUpdate type, uint8 influence, uint8 owner, uint8 ranking, bool isConquestAlliance)
    {
        TracyZoneScoped;

        auto name = PZone->getName();

        auto onConquestUpdate = lua["xi"]["zones"][name]["Zone"]["onConquestUpdate"];
        if (!onConquestUpdate.valid())
        {
            return;
        }

        CLuaZone LuaZone(PZone);

        // xi.conquest.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
        auto result = onConquestUpdate(LuaZone, type, influence, owner, ranking, isConquestAlliance);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onConquestUpdate: %s", err.what());
        }
    }

    void OnServerStart()
    {
        TracyZoneScoped;

        auto onServerStart = lua["xi"]["server"]["onServerStart"];
        if (!onServerStart.valid())
        {
            ShowWarning("luautils::onServerStart");
            return;
        }

        auto result = onServerStart();
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onServerStart: %s", err.what());
            return;
        }
    }

    void OnJSTMidnight()
    {
        TracyZoneScoped;

        auto onJSTMidnight = lua["xi"]["server"]["onJSTMidnight"];
        if (!onJSTMidnight.valid())
        {
            ShowWarning("luautils::onJSTMidnight");
            return;
        }

        auto result = onJSTMidnight();
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onJSTMidnight: %s", err.what());
            return;
        }
    }

    /************************************************************************
     *                                                                       *
     *  Called on TimeServer Tick (every 2400ms)                             *
     *                                                                       *
     ************************************************************************/

    void OnTimeServerTick()
    {
        TracyZoneScoped;

        auto onTimeServerTick = lua["xi"]["server"]["onTimeServerTick"];
        if (!onTimeServerTick.valid())
        {
            ShowWarning("luautils::onTimeServerTick");
            return;
        }

        auto result = onTimeServerTick();
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTimeServerTick: %s", err.what());
            return;
        }
    }

    /************************************************************************
     *                                                                       *
     *  Callback when you enter a BCNM via a lua call to bcnmEnter(bcnmid)   *
     *                                                                       *
     ************************************************************************/
    void OnBattlefieldEnter(CCharEntity* PChar, CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        invokeBattlefieldEvent(PBattlefield->GetID(), "onBattlefieldEnter", CLuaBaseEntity(PChar), CLuaBattlefield(PBattlefield));
    }

    /************************************************************************
     *                                                                       *
     *  Callback when you leave a BCNM via multiple means                    *
     *  The method of leaving is given by the LeaveCode as follows:          *
     *  1 - Leaving via burning circle e.g. "run away"                       *
     *  2 - Leaving via win                                                  *
     *  3 - Leaving via warp or d/c                                          *
     *  4 - Leaving via lose                                                 *
     *  This callback is executed for everyone in the BCNM when they leave   *
     *  so if they leave via win, this will be called for each char.         *
     *                                                                       *
     ************************************************************************/
    void OnBattlefieldLeave(CCharEntity* PChar, CBattlefield* PBattlefield, uint8 LeaveCode)
    {
        TracyZoneScoped;

        invokeBattlefieldEvent(PBattlefield->GetID(), "onBattlefieldLeave", CLuaBaseEntity(PChar), CLuaBattlefield(PBattlefield), LeaveCode);
    }

    void OnBattlefieldKick(CCharEntity* PChar)
    {
        TracyZoneScoped;

        CStatusEffect* status = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_BATTLEFIELD);

        if (status != nullptr)
        {
            uint16 power = status->GetPower();

            invokeBattlefieldEvent(power, "onBattlefieldKick", CLuaBaseEntity(PChar));
        }
    }

    /************************************************************************
     *                                                                       *
     *  Callback when you successfully register a BCNM                       *
     *  Called AFTER assigning BCNM status to all valid characters           *
     *  This callback is called only for the character initiating the        *
     *  registration, and after CBattlefield:init() procedure                *
     *                                                                       *
     ************************************************************************/
    void OnBattlefieldRegister(CCharEntity* PChar, CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        invokeBattlefieldEvent(PBattlefield->GetID(), "onBattlefieldRegister", CLuaBaseEntity(PChar), CLuaBattlefield(PBattlefield));
    }

    /************************************************************************
     *                                                                       *
     *  Called when BCNM is destroyed (cleanup)                              *
     *                                                                       *
     ************************************************************************/
    void OnBattlefieldDestroy(CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        invokeBattlefieldEvent(PBattlefield->GetID(), "onBattlefieldDestroy", CLuaBattlefield(PBattlefield));
    }

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
            ShowDebug("DisallowRespawn: mob <%u> not found", mobid);
        }
    }

    void UpdateNMSpawnPoint(uint32 mobid)
    {
        TracyZoneScoped;

        CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB);
        if (PMob != nullptr)
        {
            int32 r   = 0;
            int32 ret = _sql->Query("SELECT count(mobid) FROM `nm_spawn_points` where mobid=%u", mobid);
            if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS && _sql->GetUIntData(0) > 0)
            {
                r = xirand::GetRandomNumber(_sql->GetUIntData(0));
            }
            else
            {
                ShowDebug("UpdateNMSpawnPoint: SQL error: No entries for mobid <%u> found.", mobid);
                return;
            }

            ret = _sql->Query("SELECT pos_x, pos_y, pos_z FROM `nm_spawn_points` WHERE mobid=%u AND pos=%i", mobid, r);
            if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
            {
                PMob->m_SpawnPoint.rotation = xirand::GetRandomNumber(256);
                PMob->m_SpawnPoint.x        = _sql->GetFloatData(0);
                PMob->m_SpawnPoint.y        = _sql->GetFloatData(1);
                PMob->m_SpawnPoint.z        = _sql->GetFloatData(2);
                // ShowDebug(CL_RED"UpdateNMSpawnPoint: After %i - %f, %f, %f, %i", r,
                // PMob->m_SpawnPoint.x,PMob->m_SpawnPoint.y,PMob->m_SpawnPoint.z,PMob->m_SpawnPoint.rotation);
            }
            else
            {
                ShowDebug("UpdateNMSpawnPoint: SQL error or NM <%u> not found in nmspawnpoints table.", mobid);
            }
        }
        else
        {
            ShowDebug("UpdateNMSpawnPoint: mob <%u> not found", mobid);
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

        ShowError("luautils::GetMobAction: mob <%u> was not found", mobid);
        return 0;
    }

    /************************************************************************
     *   Gets a list of players that have fished in the last specified mins *
     *   where the specified param is between 1 and 60 mins                 *
     ************************************************************************/

    sol::table GetRecentFishers(uint16 minutes)
    {
        // limit the lookback time to prevent huge queries
        uint16 lookbackTime = std::clamp<uint32>(minutes, 1, 60);

        sol::table  fishers = lua.create_table();
        const char* Query   = "SELECT cv.charid, c.charname, stats.mlvl, z.name, COALESCE(cs.value, 0) / 10 as skill "
                              "FROM char_vars cv "
                              "LEFT JOIN chars c ON c.charid  = cv.charid "
                              "LEFT JOIN char_skills cs ON cs.charid = cv.charid AND cs.skillid = 48 "
                              "INNER JOIN char_stats stats ON stats.charid = c.charid "
                              "INNER JOIN zone_settings z ON z.zoneid = c.pos_zone "
                              "WHERE "
                              "varname = '[Fish]LastCastTime' AND "
                              "FROM_UNIXTIME(cv.value) > NOW() - INTERVAL %u MINUTE "
                              "ORDER BY z.name, z.name, stats.mlvl, skill";

        if (_sql->Query(Query, lookbackTime) != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                auto fisher          = lua.create_table();
                auto charId          = _sql->GetUIntData(0);
                fisher["playerName"] = _sql->GetStringData(1);
                fisher["jobLevel"]   = _sql->GetUIntData(2);
                fisher["zoneName"]   = _sql->GetStringData(3);
                fisher["skill"]      = _sql->GetUIntData(4);
                fishers[charId]      = fisher;
            }
        }

        return fishers;
    }

    std::string GetServerMessage(uint8 language)
    {
        TracyZoneScoped;

        // xi.server.getServerMessage = function(language) ...
        auto getServerMessage = lua["xi"]["server"]["getServerMessage"];
        if (!getServerMessage.valid())
        {
            ShowWarning("luautils::getServerMessage");
            return "";
        }

        auto result = getServerMessage(language);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::getServerMessage: %s", err.what());
            return "";
        }

        return result.get_type() == sol::type::string ? result.get<std::string>() : "";
    }

    /************************************************************************
     *                                                                       *
     *  Creates an item object of the type specified by the itemID.          *
     *  This item is ephemeral, and doesn't exist in-game but can and should *
     *  be used to lookup item information or access item functions when     *
     *  only the ItemID is known.                                            *
     *                                                                       *
     *  ## These items should be used to READ ONLY!                          *
     *  ## Should lua functions be written which modify items, care must be  *
     *     taken to ensure these are NEVER modified.                         *
     *                                                                       *
     *  example: local item = GetReadOnlyItem(16448)                         *
     *           item:getName()                 --Bronze Dagger              *
     *           item:isTwoHanded()             --False                      *
     *                                                                       *
     ************************************************************************/

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

    sol::table GetFurthestValidPosition(CLuaBaseEntity* fromTarget, float distance, float theta)
    {
        CBaseEntity* entity = fromTarget->GetBaseEntity();
        position_t   pos    = nearPosition(entity->loc.p, distance, theta);

        float validPos[3];
        bool  success = entity->loc.zone->m_navMesh->findFurthestValidPoint(entity->loc.p, pos, validPos);
        if (!success)
        {
            return sol::lua_nil;
        }

        sol::table outPos = lua.create_table();
        outPos["x"]       = validPos[0];
        outPos["y"]       = validPos[1];
        outPos["z"]       = validPos[2];

        return outPos;
    }

    void OnPlayerDeath(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto onPlayerDeath = lua["xi"]["player"]["onPlayerDeath"];
        if (!onPlayerDeath.valid())
        {
            ShowWarning("luautils::onPlayerDeath");
            return;
        }

        auto result = onPlayerDeath(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPlayerDeath: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return;
        }
    }

    void OnPlayerLevelUp(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto onPlayerLevelUp = lua["xi"]["player"]["onPlayerLevelUp"];
        if (!onPlayerLevelUp.valid())
        {
            ShowWarning("luautils::onPlayerLevelUp");
            return;
        }

        auto result = onPlayerLevelUp(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPlayerLevelUp: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return;
        }
    }

    void OnPlayerLevelDown(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto onPlayerLevelDown = lua["xi"]["player"]["onPlayerLevelDown"];
        if (!onPlayerLevelDown.valid())
        {
            ShowWarning("luautils::onPlayerLevelDown");
            return;
        }

        auto result = onPlayerLevelDown(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPlayerLevelDown: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return;
        }
    }

    void OnPlayerMount(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto onPlayerMount = lua["xi"]["player"]["onPlayerMount"];
        if (!onPlayerMount.valid())
        {
            ShowWarning("luautils::onPlayerMount");
            return;
        }

        auto result = onPlayerMount(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPlayerMount: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return;
        }
    }

    void OnPlayerEmote(CCharEntity* PChar, Emote EmoteID)
    {
        TracyZoneScoped;

        auto onPlayerEmote = lua["xi"]["player"]["onPlayerEmote"];
        if (!onPlayerEmote.valid())
        {
            ShowWarning("luautils::onPlayerEmote");
            return;
        }

        auto result = onPlayerEmote(CLuaBaseEntity(PChar), static_cast<uint8>(EmoteID));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPlayerEmote: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return;
        }
    }

    void OnPlayerVolunteer(CCharEntity* PChar, std::string const& text)
    {
        TracyZoneScoped;

        auto onPlayerVolunteer = lua["xi"]["player"]["onPlayerVolunteer"];
        if (!onPlayerVolunteer.valid())
        {
            ShowWarning("luautils::onPlayerVolunteer");
            return;
        }

        auto result = onPlayerVolunteer(CLuaBaseEntity(PChar), text);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onPlayerVolunteer: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return;
        }
    }

    bool OnChocoboDig(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto onChocoboDig = lua["xi"]["chocoboDig"]["start"];

        // Check that the function exists.
        if (!onChocoboDig.valid())
        {
            ShowWarning("luautils::onChocoboDig");
            return false;
        }

        // Run lua-side chocobo digging.
        auto result = onChocoboDig(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onChocoboDig: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return false;
        }

        return result.get_type(0) == sol::type::boolean ? result.get<bool>() : false;
    }

    // Loads a Lua function with a fallback hierarchy
    //
    // 1) 1st try: PChar->currentEvent->scriptFile
    // 2) 2nd try: The instance script if the player is in one
    // 3) 3rd try: The battlefield script if the player is in one
    // 4) 4th try: The zone script for the zone the player is in
    sol::function LoadEventScript(CCharEntity* PChar, const char* functionName)
    {
        TracyZoneScoped;

        auto funcFromChar = GetCacheEntryFromFilename(PChar->currentEvent->scriptFile)[functionName];
        if (funcFromChar.valid())
        {
            return funcFromChar;
        }

        if (PChar->PInstance)
        {
            auto instance_filename = fmt::format(
                "./scripts/zones/{}/instances/{}",
                PChar->PInstance->GetZone()->getName(),
                PChar->PInstance->GetName());

            auto funcFromInstance = GetCacheEntryFromFilename(instance_filename)[functionName];
            if (funcFromInstance.valid())
            {
                return funcFromInstance;
            }
        }

        auto zone_filename = fmt::format("./scripts/zones/{}/Zone.lua", PChar->loc.zone->getName());
        auto funcFromZone  = GetCacheEntryFromFilename(zone_filename)[functionName];
        if (funcFromZone.valid())
        {
            return funcFromZone;
        }

        return sol::lua_nil;
    }

    uint16 GetDespoilDebuff(uint16 itemId)
    {
        TracyZoneScoped;

        uint16 effectId = 0;
        int32  ret      = _sql->Query("SELECT effectId FROM despoil_effects WHERE itemId = %u", itemId);
        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            effectId = (uint16)_sql->GetUIntData(0);
        }

        return effectId;
    }

    void OnFurniturePlaced(CCharEntity* PChar, CItemFurnishing* PItem)
    {
        TracyZoneScoped;

        auto name = PItem->getName();

        auto onFurniturePlaced = lua["xi"]["items"][name]["onFurniturePlaced"];
        if (!onFurniturePlaced.valid())
        {
            return;
        }

        auto result = onFurniturePlaced(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onFurniturePlaced: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return;
        }
    }

    void OnFurnitureRemoved(CCharEntity* PChar, CItemFurnishing* PItem)
    {
        TracyZoneScoped;

        auto name = PItem->getName();

        auto onFurnitureRemoved = lua["xi"]["items"][name]["onFurnitureRemoved"];
        if (!onFurnitureRemoved.valid())
        {
            return;
        }

        auto result = onFurnitureRemoved(CLuaBaseEntity(PChar));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onFurnitureRemoved: %s", err.what());
            ReportErrorToPlayer(PChar, err.what());
            return;
        }
    }

    uint16 SelectDailyItem(CLuaBaseEntity* PLuaBaseEntity, uint8 dial)
    {
        TracyZoneScoped;
        CCharEntity* player = dynamic_cast<CCharEntity*>(PLuaBaseEntity->GetBaseEntity());
        return daily::SelectItem(player, dial);
    }

    std::string SetCustomMenuContext(CCharEntity* PChar, sol::table table)
    {
        customMenuContext[PChar->id] = table;

        auto onStart = table["onStart"];
        if (onStart.valid())
        {
            onStart(CLuaBaseEntity(PChar));
        }

        auto escape = [](std::string const& s)
        {
            return fmt::format("\"{}\"", s);
        };

        std::string outStr;

        // Title
        outStr += escape(table["title"].get<std::string>());

        // Options
        for (auto& entry : table["options"].get<sol::table>())
        {
            outStr += escape(entry.second.as<sol::table>()[1]);
        }

        return outStr;
    }

    bool HasCustomMenuContext(CCharEntity* PChar)
    {
        auto context = customMenuContext.find(PChar->id);
        return context != customMenuContext.end();
    }

    void HandleCustomMenu(CCharEntity* PChar, const std::string& selection)
    {
        /*
        Japanese Responses:
            現在イベント中です。このgmtellは無効です。
            現在4つのgmtellを受け付けています。このgmtellは無効です。
            GMTELL(%s):質問(%s):結果(イベントが起動したためキャンセル)
            GMTELL(%s):質問(%s):結果(キャンセル)
            GMTELL(%s):質問(%s):結果(%s)

        English Responses:
            Currently in an event. This GMTELL was invalidated.
            Currently four GMTELL's have been received. This GMTELL was invalidated.
            GMTELL(%s): Question(%s): Result (Canceled due to event activation.)
            GMTELL(%s): Question(%s): Result (Canceled.)
            GMTELL(%s): Question(%s): Result (%s)

        French Responses:
            Evénement en cours. Ce GMTELL a été invalidé.
            Quatre GMTELL ont été reçus. Ce GMTELL a été invalidé.
            GMTELL(%s) : Question(%s) : Résultat (annulé pour cause d'activation d'événement)
            GMTELL(%s) : Question(%s) : Résultat (annulé)
            GMTELL(%s) : Question(%s) : Résultat (%s)

        German Responses:
            Es wird derzeit ein Ereignis ausgeführt. Dieser SLRUF ist nicht gültig.
            Er wurden vier SLRUFe empfangen. Dieser SLRUF ist nicht gültig.
            SLRUF(%s): Frage(%s): Ergebnis (Wegen Auslösen eines Ereignisses abgebrochen.)
            SLRUF(%s): Frage(%s): Ergebnis (Abgebrochen.)
            SLRUF(%s): Frage(%s): Ergebnis (%s)
        */

        if (selection.empty())
        {
            ShowWarning(fmt::format("Custom menu for {} was provided an empty string.", PChar->name));
            return;
        }

        // clang-format off
        // Messages used to denote the player cancelled the GM tell manually..
        const std::vector<std::string> cancelMsgs =
        {
            // JP: GMTELL(%s):質問(%s):結果(キャンセル)
            "\x3A\x8C\x8B\x89\xCA\x28\x83\x4C\x83\x83\x83\x93\x83\x5A\x83\x8B\x29",

            // NA: GMTELL(%s): Question(%s): Result (Canceled.)
            "\x3A\x20\x52\x65\x73\x75\x6C\x74\x20\x28\x43\x61\x6E\x63\x65\x6C\x65\x64\x2E\x29",
        };

        // Messages used to denote the player cancelled the GM tell automatically due to an event or other conditions..
        const std::vector<std::string> eventCancelMsgs =
        {
            // JP: 現在イベント中です。このgmtellは無効です。
            "\x8C\xBB\x8D\xDD\x83\x43\x83\x78\x83\x93\x83\x67\x92\x86\x82\xC5\x82\xB7\x81\x42\x82\xB1\x82\xCC\x67\x6D\x74\x65\x6C\x6C\x82\xCD\x96\xB3\x8C\xF8\x82\xC5\x82\xB7\x81\x42",
            // JP: 現在4つのgmtellを受け付けています。このgmtellは無効です。
            "\x8C\xBB\x8D\xDD\x34\x82\xC2\x82\xCC\x67\x6D\x74\x65\x6C\x6C\x82\xF0\x8E\xF3\x82\xAF\x95\x74\x82\xAF\x82\xC4\x82\xA2\x82\xDC\x82\xB7\x81\x42\x82\xB1\x82\xCC\x67\x6D\x74\x65\x6C\x6C\x82\xCD\x96\xB3\x8C\xF8\x82\xC5\x82\xB7\x81\x42",
            // JP: GMTELL(%s):質問(%s):結果(イベントが起動したためキャンセル)
            "\x3A\x8C\x8B\x89\xCA\x28\x83\x43\x83\x78\x83\x93\x83\x67\x82\xAA\x8B\x4E\x93\xAE\x82\xB5\x82\xBD\x82\xBD\x82\xDF\x83\x4C\x83\x83\x83\x93\x83\x5A\x83\x8B\x29",

            // NA: Currently in an event. This GMTELL was invalidated.
            "\x43\x75\x72\x72\x65\x6E\x74\x6C\x79\x20\x69\x6E\x20\x61\x6E\x20\x65\x76\x65\x6E\x74\x2E\x20\x54\x68\x69\x73\x20\x47\x4D\x54\x45\x4C\x4C\x20\x77\x61\x73\x20\x69\x6E\x76\x61\x6C\x69\x64\x61\x74\x65\x64\x2E",
            // NA: Currently four GMTELL's have been received. This GMTELL was invalidated.
            "\x43\x75\x72\x72\x65\x6E\x74\x6C\x79\x20\x66\x6F\x75\x72\x20\x47\x4D\x54\x45\x4C\x4C\x27\x73\x20\x68\x61\x76\x65\x20\x62\x65\x65\x6E\x20\x72\x65\x63\x65\x69\x76\x65\x64\x2E\x20\x54\x68\x69\x73\x20\x47\x4D\x54\x45\x4C\x4C\x20\x77\x61\x73\x20\x69\x6E\x76\x61\x6C\x69\x64\x61\x74\x65\x64\x2E",
            // NA: GMTELL(%s): Question(%s): Result (Canceled due to event activation.)
            "\x3A\x20\x52\x65\x73\x75\x6C\x74\x20\x28\x43\x61\x6E\x63\x65\x6C\x65\x64\x20\x64\x75\x65\x20\x74\x6F\x20\x65\x76\x65\x6E\x74\x20\x61\x63\x74\x69\x76\x61\x74\x69\x6F\x6E\x2E\x29",
        };

        const auto wasCancelled = std::any_of(cancelMsgs.begin(), cancelMsgs.end(), [&selection](const auto& s)
        {
            return selection.find(s) != selection.npos;
        });

        const auto wasCancelledEvent = std::any_of(eventCancelMsgs.begin(), eventCancelMsgs.end(), [&selection](const auto& s)
        {
            return selection.find(s) != selection.npos;
        });
        // clang-format on

        const auto context = customMenuContext[PChar->id];

        if (wasCancelled || wasCancelledEvent)
        {
            auto onCancelled = context["onCancelled"];
            if (onCancelled.valid())
            {
                onCancelled(CLuaBaseEntity(PChar), wasCancelledEvent);
            }
        }
        else
        {
            const std::string resultJp = "\x3A\x8C\x8B\x89\xCA\x28";
            const std::string resultNa = "\x3A\x20\x52\x65\x73\x75\x6C\x74\x20\x28";

            std::string result = selection.find(resultJp) != selection.npos ? selection.substr(selection.find(resultJp) + resultJp.size()) : "";
            if (result.empty())
            {
                result = selection.find(resultNa) != selection.npos ? selection.substr(selection.find(resultNa) + resultNa.size()) : "";
            }

            if (!result.empty())
            {
                result.pop_back();
            }

            for (const auto& entry : context["options"].get<sol::table>())
            {
                if (entry.second.get_type() == sol::type::table)
                {
                    auto table = entry.second.as<sol::table>();
                    auto name  = table[1].get<std::string>();
                    auto func  = table[2].get<sol::function>();

                    if (result.compare(name) == 0)
                    {
                        auto result = func(CLuaBaseEntity(PChar));
                        if (!result.valid())
                        {
                            sol::error err = result;
                            ShowError("Menu error: %s", err.what());
                            ReportErrorToPlayer(PChar, err.what());
                        }
                        break;
                    }
                }
            }
        }

        auto onEnd = context["onEnd"];
        if (onEnd.valid())
        {
            onEnd(CLuaBaseEntity(PChar));
        }

        customMenuContext.erase(PChar->id);
    }

    SendToDBoxReturnCode SendItemToDeliveryBox(const std::string& playerName, uint16 itemId, uint32 quantity, const std::string& senderText)
    {
        uint32 playerID = GetPlayerIDByName(playerName);
        if (playerID == 0)
        {
            return SendToDBoxReturnCode::PLAYER_NOT_FOUND;
        }

        auto isGil = itemId == 65535;

        // Check to confirm that the item legitimately exists
        // exclude gil as gil does not have an item pointer
        auto* PItem = itemutils::GetItemPointer(itemId);
        if (PItem == nullptr && !isGil)
        {
            return SendToDBoxReturnCode::ITEM_NOT_FOUND;
        }

        // default stack size of gil
        uint32 stackSize = 999999999;
        // if not gil then get the actual stack size
        if (!isGil)
        {
            stackSize = PItem->getStackSize();
        }

        bool quantityMoreThanStackSize = quantity > stackSize;

        // limit the quantity to the stack size of the item
        quantity = std::clamp<uint32>(quantity, 1, stackSize);

        bool isAutoCommitOn = _sql->GetAutoCommit();

        if (_sql->SetAutoCommit(false) && _sql->TransactionStart())
        {
            // NOTE: This will trigger SQL trigger: delivery_box_insert
            const char* Query = "INSERT INTO delivery_box (charid, box, itemid, quantity, senderid, sender) VALUES ("
                                "%u, "     // Player ID
                                "1, "      // Box ID == 1
                                "%u, "     // Item ID
                                "%u, "     // Quantity
                                "%u, "     // Sender ID ( =Player ID )
                                "'%s'); "; // Sender Text
            int32 ret = _sql->Query(Query, playerID, itemId, quantity, playerID, senderText);

            if (ret == SQL_ERROR)
            {
                _sql->TransactionRollback();
                _sql->SetAutoCommit(isAutoCommitOn);
                return SendToDBoxReturnCode::QUERY_ERROR;
            }
            else
            {
                _sql->TransactionCommit();
                _sql->SetAutoCommit(isAutoCommitOn);
            }

            if (quantityMoreThanStackSize)
            {
                return SendToDBoxReturnCode::SUCCESS_LIMITED_TO_STACK_SIZE;
            }
            else
            {
                return SendToDBoxReturnCode::SUCCESS;
            }
        }
        else
        {
            return SendToDBoxReturnCode::QUERY_ERROR;
        }
    }

    uint16 GetItemIDByName(std::string const& name)
    {
        uint16 id   = 0;
        auto   rset = db::preparedStmt("SELECT itemid FROM item_basic WHERE name LIKE ? OR sortname LIKE ?", name, name);

        const uint16 rowCount = (rset && rset->rowsCount()) ? static_cast<uint16>(rset->rowsCount()) : 0U;

        if (rset && rowCount == 1) // Found a single result
        {
            while (rset->next())
            {
                id = rset->get<uint16>("itemid");
            }
        }
        else if (rset && rowCount > 1)
        {
            // 0xFFFF is gil, so we will always return a value less than that as a warning
            id = 0xFFFF - rowCount + 1;
        }

        return id;
    }

    std::optional<CLuaBaseEntity> GenerateDynamicEntity(CZone* PZone, CInstance* PInstance, sol::table table)
    {
        CBaseEntity* PEntity = nullptr;
        if (table.get_or<uint8>("objtype", TYPE_NPC) == TYPE_NPC)
        {
            PEntity       = new CNpcEntity();
            PEntity->name = "DefaultName";
        }
        else
        {
            auto groupId     = table.get_or<uint32>("groupId", 0);
            auto groupZoneId = table.get_or<uint32>("groupZoneId", 0);

            PEntity = mobutils::InstantiateDynamicMob(groupId, groupZoneId, PZone->GetID());
        }

        // This can happen if the Target's Zone ID is invalid.
        if (PEntity == nullptr)
        {
            ShowWarning("Failed to insert Dynamic Entity.");
            return std::nullopt;
        }

        // NOTE: Mob allegiance is the default for NPCs
        PEntity->allegiance = static_cast<ALLEGIANCE_TYPE>(table.get_or<uint8>("allegiance", ALLEGIANCE_TYPE::MOB));

        if (PInstance)
        {
            PInstance->AssignDynamicTargIDandLongID(PEntity);
            PEntity->PInstance = PInstance;
        }
        else
        {
            PZone->GetZoneEntities()->AssignDynamicTargIDandLongID(PEntity);
        }

        PEntity->loc.p.rotation = table.get_or<uint8>("rotation", 0);
        PEntity->loc.p.x        = table.get_or<float>("x", 0.01);
        PEntity->loc.p.y        = table.get_or<float>("y", 0.01);
        PEntity->loc.p.z        = table.get_or<float>("z", 0.01);
        PEntity->loc.p.moving   = 0;

        auto name = table.get_or<std::string>("name", "");
        if (name.empty())
        {
            ShowWarning("Trying to spawn dynamic entity without a name! (%s - %s)",
                        PEntity->getName(), PZone->getName());

            // If the name hasn't been provided, use "DefaultName" for NPCs, and whatever comes from the mob_pool for Mobs
            name = PEntity->name;
        }

        auto lookupName = "DE_" + name;

        PEntity->name       = lookupName;
        PEntity->packetName = table.get_or<std::string>("packetName", name);

        PEntity->isRenamed = true;

        PEntity->m_bReleaseTargIDOnDisappear = table["releaseIdOnDisappear"].get_or(false);

        auto typeKey    = (PEntity->objtype == TYPE_NPC) ? "npcs" : "mobs";
        auto cacheEntry = lua[sol::create_if_nil]["xi"]["zones"][PZone->getName()][typeKey][lookupName];

        // Bind any functions that are passed in
        for (auto& [entryKey, entryValue] : table)
        {
            if (entryValue.get_type() == sol::type::function)
            {
                cacheEntry[entryKey] = entryValue.as<sol::function>();
            }
        }

        if (auto* PNpc = dynamic_cast<CNpcEntity*>(PEntity))
        {
            PNpc->namevis     = table.get_or<uint8>("namevis", 0);
            PNpc->status      = STATUS_TYPE::NORMAL;
            PNpc->name_prefix = 32;

            // TODO: Does this even work?
            PNpc->widescan = table.get_or<uint8>("widescan", 1);

            uint32 flags  = table.get_or<uint32>("entityFlags", 0);
            PNpc->m_flags = flags == 0 ? PNpc->m_flags : flags;

            // Ensure that the npc is triggerable if onTrigger is passed in
            auto onTrigger = table["onTrigger"].get_or<sol::function>(sol::lua_nil);
            if (onTrigger.valid())
            {
                PNpc->m_triggerable = true;
            }

            PZone->InsertNPC(PNpc);
        }
        else if (auto* PMob = dynamic_cast<CMobEntity*>(PEntity))
        {
            auto mixins = table["mixins"].get_or<sol::table>(sol::lua_nil);
            if (mixins.valid())
            {
                // Use the global function "applyMixins"
                auto result = lua["applyMixins"](CLuaBaseEntity(PMob), mixins);
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError("applyMixins: %s: %s", PMob->name.c_str(), err.what());
                }
            }

            luautils::OnEntityLoad(PMob);

            luautils::OnMobInitialize(PMob);
            luautils::ApplyMixins(PMob);
            luautils::ApplyZoneMixins(PMob);

            PMob->saveModifiers();
            PMob->saveMobModifiers();

            PMob->m_isAggroable = table["isAggroable"].get_or(false);

            PMob->spawnAnimation = static_cast<SPAWN_ANIMATION>(table["specialSpawnAnimation"].get_or(false) ? 1 : 0);

            uint32 flags  = table.get_or<uint32>("entityFlags", 0);
            PMob->m_flags = flags == 0 ? PMob->m_flags : flags;

            // Ensure mobs get a function for onMobDeath
            auto onMobDeath = table["onMobDeath"].get<sol::function>();
            if (!onMobDeath.valid())
            {
                // TODO: Using an empty C++ lambda here wasn't working.
                // Figure out why and fix.
                cacheEntry["onMobDeath"] = lua.safe_script("return function() end");
            }

            PZone->InsertMOB(PMob);
        }

        if (table["look"].get_type() == sol::type::number)
        {
            PEntity->SetModelId(table.get<uint16>("look"));
        }
        else if (table["look"].get_type() == sol::type::string)
        {
            auto lookStr  = table.get<std::string>("look");
            PEntity->look = stringToLook(lookStr);
        }

        PEntity->updatemask |= UPDATE_ALL_CHAR;

        return CLuaBaseEntity(PEntity);
    }

    // Fishing Contest utilities
    auto GetFishingContest() -> sol::table
    {
        sol::table table = lua.create_table();

        table["status"]     = fishingcontest::GetContestStatus();
        table["criteria"]   = fishingcontest::GetContestCriteria();
        table["measure"]    = fishingcontest::GetContestMeasure();
        table["fishid"]     = fishingcontest::GetContestFish();
        table["starttime"]  = fishingcontest::GetContestStartTime();
        table["changetime"] = fishingcontest::GetContestChangeTime();

        return table;
    }

    void InitNewFishingContest()
    {
        // This function will destroy the current contest and start a new one
        fishingcontest::InitNewContest();
    }

    void SetContestParameters(uint16 fishId, uint8 measure, uint8 criteria)
    {
        // Note: Validation of fish item id should be done in lua, since the fish table is also in lua
        fishingcontest::SetContestFish(fishId);
        fishingcontest::SetContestMeasure(static_cast<FISHING_CONTEST_MEASURE>(measure));
        fishingcontest::SetContestCriteria(static_cast<FISHING_CONTEST_CRITERIA>(criteria));
    }

    void ProgressFishingContest()
    {
        // This function will get called every tick when automatic progression is enabled
        fishingcontest::ProgressContest();
    }

    void InitializeFishingContestSystem()
    {
        // IMPORTANT: This should only be called on the Zone Init in Selbina
        // Do not run this from multiple server instances
        if (zoneutils::IsZoneOnThisProcess(ZONEID::ZONE_SELBINA))
        {
            fishingcontest::InitializeFishingContestSystem();
        }
        else
        {
            ShowWarning("Attempted to initialize fishing contest from outside of Selbina.");
        }
    }

    auto GetSynergyRecipeByID(uint32 id) -> sol::table
    {
        auto maybeResult = synergyutils::GetSynergyRecipeByID(id);
        if (!maybeResult.has_value())
        {
            return sol::lua_nil;
        }
        const auto result = *maybeResult;

        sol::table table = lua.create_table();

        table["id"]                    = result.id;
        table["primary_skill"]         = result.primary_skill;
        table["primary_rank"]          = result.primary_rank;
        table["secondary_skill"]       = result.secondary_skill;
        table["secondary_rank"]        = result.secondary_rank;
        table["tertiary_skill"]        = result.tertiary_skill;
        table["tertiary_rank"]         = result.tertiary_rank;
        table["cost_fire_fewell"]      = result.cost_fire_fewell;
        table["cost_ice_fewell"]       = result.cost_ice_fewell;
        table["cost_wind_fewell"]      = result.cost_wind_fewell;
        table["cost_earth_fewell"]     = result.cost_earth_fewell;
        table["cost_lightning_fewell"] = result.cost_lightning_fewell;
        table["cost_water_fewell"]     = result.cost_water_fewell;
        table["cost_light_fewell"]     = result.cost_light_fewell;
        table["cost_dark_fewell"]      = result.cost_dark_fewell;
        table["ingredient1"]           = result.ingredient1;
        table["ingredient2"]           = result.ingredient2;
        table["ingredient3"]           = result.ingredient3;
        table["ingredient4"]           = result.ingredient4;
        table["ingredient5"]           = result.ingredient5;
        table["ingredient6"]           = result.ingredient6;
        table["ingredient7"]           = result.ingredient7;
        table["ingredient8"]           = result.ingredient8;
        table["result"]                = result.result;
        table["resultHQ1"]             = result.resultHQ1;
        table["resultHQ2"]             = result.resultHQ2;
        table["resultHQ3"]             = result.resultHQ3;
        table["resultQty"]             = result.resultQty;
        table["resultHQ1Qty"]          = result.resultHQ1Qty;
        table["resultHQ2Qty"]          = result.resultHQ2Qty;
        table["resultHQ3Qty"]          = result.resultHQ3Qty;
        table["resultName"]            = result.resultName;

        return table;
    }

    auto GetSynergyRecipeByTrade(CLuaTradeContainer luaTradeContainer) -> sol::table
    {
        auto tradeContainer = luaTradeContainer.GetTradeContainer();

        std::vector<uint16> itemIds;
        for (uint8 i = 0; i < 8; i++)
        {
            auto itemId = tradeContainer->getItemID(i);
            if (itemId == 0)
            {
                continue;
            }
            itemIds.push_back(itemId);
        }

        // We will sort now, because we want to insert zeroes at the end of the vector for lookup
        std::sort(itemIds.begin(), itemIds.end());

        // We will still need to fill out the call to GetSynergyRecipeByIngredients
        // with zeroes for empty slots.
        while (itemIds.size() < 8)
        {
            itemIds.push_back(0);
        }

        auto maybeResult = synergyutils::GetSynergyRecipeByIngredients(
            itemIds[0], itemIds[1], itemIds[2], itemIds[3],
            itemIds[4], itemIds[5], itemIds[6], itemIds[7]);
        if (!maybeResult.has_value())
        {
            return sol::lua_nil;
        }
        const auto result = *maybeResult;

        sol::table table = lua.create_table();

        table["id"]                    = result.id;
        table["primary_skill"]         = result.primary_skill;
        table["primary_rank"]          = result.primary_rank;
        table["secondary_skill"]       = result.secondary_skill;
        table["secondary_rank"]        = result.secondary_rank;
        table["tertiary_skill"]        = result.tertiary_skill;
        table["tertiary_rank"]         = result.tertiary_rank;
        table["cost_fire_fewell"]      = result.cost_fire_fewell;
        table["cost_ice_fewell"]       = result.cost_ice_fewell;
        table["cost_wind_fewell"]      = result.cost_wind_fewell;
        table["cost_earth_fewell"]     = result.cost_earth_fewell;
        table["cost_lightning_fewell"] = result.cost_lightning_fewell;
        table["cost_water_fewell"]     = result.cost_water_fewell;
        table["cost_light_fewell"]     = result.cost_light_fewell;
        table["cost_dark_fewell"]      = result.cost_dark_fewell;
        table["ingredient1"]           = result.ingredient1;
        table["ingredient2"]           = result.ingredient2;
        table["ingredient3"]           = result.ingredient3;
        table["ingredient4"]           = result.ingredient4;
        table["ingredient5"]           = result.ingredient5;
        table["ingredient6"]           = result.ingredient6;
        table["ingredient7"]           = result.ingredient7;
        table["ingredient8"]           = result.ingredient8;
        table["result"]                = result.result;
        table["resultHQ1"]             = result.resultHQ1;
        table["resultHQ2"]             = result.resultHQ2;
        table["resultHQ3"]             = result.resultHQ3;
        table["resultQty"]             = result.resultQty;
        table["resultHQ1Qty"]          = result.resultHQ1Qty;
        table["resultHQ2Qty"]          = result.resultHQ2Qty;
        table["resultHQ3Qty"]          = result.resultHQ3Qty;
        table["resultName"]            = result.resultName;

        return table;
    }
}; // namespace luautils
