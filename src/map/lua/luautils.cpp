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
#include "../../common/timer.h"
#include "../../common/utils.h"

#include <array>
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
#include <optional>

namespace luautils
{
    sol::state lua;
    lua_State* LuaHandle = nullptr;

    bool                                  contentRestrictionEnabled;
    std::unordered_map<std::string, bool> contentEnabledMap;

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
            sol::overload([]() { return tpzrand::GetRandomNumber(1.0f); },
                          [](int n) { return tpzrand::GetRandomNumber<int>(1, n); },
                          [](float n) { return tpzrand::GetRandomNumber<float>(0.0f, n); },
                          [](int n, int m) { return tpzrand::GetRandomNumber<int>(n, m + 1); },
                          [](float n, float m) { return tpzrand::GetRandomNumber<float>(n, m); });
        // clang-format on

        // Get-or-create tpz.core
        auto tpz      = lua["tpz"].get_or_create<sol::table>();
        auto tpz_core = tpz["core"].get_or_create<sol::table>();

        // Set functions in both global namespace and as part of tpz.core
        // Example:
        // set_function("getNPCByID", &luautils::GetNPCByID);
        // -> GetNPCByID() or tpz.core.getNPCByID()
        auto set_function = [&](std::string name, auto&& func) {
            auto lowerName = name;
            auto upperName = name;

            lowerName[0] = std::tolower(lowerName[0]);
            upperName[0] = std::toupper(upperName[0]);

            tpz_core.set_function(lowerName, func);
            lua.set_function(upperName, func);
        };

        set_function("garbageCollectStep", &luautils::garbageCollectStep);
        set_function("garbageCollectFull", &luautils::garbageCollectFull);
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
        set_function("vanadielTime", &luautils::VanadielTime);
        set_function("vanadielTOTD", &luautils::VanadielTOTD);
        set_function("vanadielHour", &luautils::VanadielHour);
        set_function("vanadielMinute", &luautils::VanadielMinute);
        set_function("vanadielDayOfTheWeek", &luautils::VanadielDayOfTheWeek);
        set_function("vanadielDayOfTheMonth", &luautils::VanadielDayOfTheMonth);
        set_function("vanadielDayOfTheYear", &luautils::VanadielDayOfTheYear);
        set_function("vanadielYear", &luautils::VanadielYear);
        set_function("vanadielMonth", &luautils::VanadielMonth);
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
        lua.script_file("scripts/globals/conquest.lua");
        lua.script_file("scripts/globals/player.lua");

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

    int32 free()
    {
        if (LuaHandle)
        {
            ShowStatus(CL_WHITE "luautils::free" CL_RESET ":lua free...");
            // sol::state will clean itself up on the way out
            LuaHandle = nullptr;
            ShowMessage("\t - " CL_GREEN "[OK]" CL_RESET "\n");
        }
        return 0;
    }

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

    /************************************************************************
     *                                                                       *
     *  Переопределение официальной lua функции print                        *
     *                                                                       *
     ************************************************************************/

    template <typename T>
    void print(T const& item)
    {
        ShowScript(fmt::format("{}\n", item));
    }

    sol::function loadFunctionFromFile(std::string funcName, std::string fileName)
    {
        TracyZoneScoped;
        TracyZoneString(funcName);
        TracyZoneString(fileName);
        TracyReportLuaMemory(lua.lua_state());

        // Erase previous copies of the function, if they're left over from previous calls
        lua.set(funcName, sol::nil);

        // Run script
        lua.script_file(fileName);

        return lua.get<sol::function>(funcName);
    }

    // temporary solution for geysers in Dangruf_Wadi
    void SendEntityVisualPacket(uint32 npcid, const char* command)
    {
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

    /************************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

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

        auto setRegionalConquestOverseers = lua["tpz"]["conquest"]["setRegionalConquestOverseers"];
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

        auto file_result = lua.script_file("scripts/globals/settings.lua");
        if (!file_result.valid())
        {
            sol::error err = file_result;
            ShowError("luautils::GetSettingsVariable: %s\n", err.what());
            return 0;
        }

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

        auto filename = fmt::format("scripts/zones/{}/Zone.lua", PZone->GetName());

        auto onInitialize = loadFunctionFromFile("onInitialize", filename);
        if (!onInitialize.valid())
        {
            return -1;
        }

        CLuaZone LuaZone(PZone);

        auto result = onInitialize(LuaZone);
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

        auto onGameIn = lua["tpz"]["player"]["onGameIn"];
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

        auto filename = fmt::format("scripts/zones/{}/Zone.lua",
                                    PChar->m_moghouseID ? "Residential_Area" : (const char*)zoneutils::GetZone(PChar->loc.destination)->GetName());

        auto onZoneIn = loadFunctionFromFile("onZoneIn", filename);
        if (!onZoneIn.valid())
        {
            return -1;
        }

        auto result = onZoneIn(CLuaBaseEntity(PChar), PChar->loc.prevzone);
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

        auto filename = fmt::format("scripts/zones/{}/Zone.lua", PChar->loc.zone->GetName());

        auto afterZoneIn = loadFunctionFromFile("afterZoneIn", filename);
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
                std::string("scripts/zones/") + (const char*)PChar->loc.zone->GetName() + "/instances/" + (const char*)PChar->PInstance->GetName() + ".lua";
        }
        else
        {
            filename = std::string("scripts/zones/") + (const char*)PChar->loc.zone->GetName() + "/Zone.lua";
        }

        // player may be entering because of an earlier event (event that changes position)
        // these should probably not call another event from onRegionEnter (use onEventFinish instead)
        if (PChar->m_event.EventID == -1)
        {
            PChar->m_event.Script = filename;
        }

        auto onRegionEnter = loadFunctionFromFile("onRegionEnter", filename);
        if (!onRegionEnter.valid())
        {
            return -1;
        }

        auto result = onRegionEnter(CLuaBaseEntity(PChar), CLuaRegion(PRegion));
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

        auto onRegionLeave = loadFunctionFromFile("onRegionLeave", filename);
        if (!onRegionLeave.valid())
        {
            return -1;
        }

        auto result = onRegionLeave(CLuaBaseEntity(PChar), CLuaRegion(PRegion));
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

        auto filename = fmt::format("scripts/zones/{}/npcs/{}.lua", PChar->loc.zone->GetName(), PNpc->GetName());

        PChar->m_event.reset();
        PChar->m_event.Target = PNpc;
        PChar->m_event.Script = filename;

        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_BOOST);

        auto onTrigger = loadFunctionFromFile("onTrigger", filename);
        if (!onTrigger.valid())
        {
            ShowWarning("luautils::onTrigger - No Valid Function for %s in %s\n", PNpc->GetName(), PChar->loc.zone->GetName());
            return -1;
        }

        auto result = onTrigger(CLuaBaseEntity(PChar), CLuaBaseEntity(PNpc));
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

        auto func_result = onEventUpdate(CLuaBaseEntity(PChar), eventID, result, extras, CLuaBaseEntity(PChar->m_event.Target));
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

        auto onEventUpdate = LoadEventScript(PChar, "onEventUpdate");
        if (!onEventUpdate.valid())
        {
            ShowError("luautils::onEventUpdate: undefined procedure onEventUpdate\n");
            return -1;
        }

        auto func_result = onEventUpdate(CLuaBaseEntity(PChar), eventID, result, CLuaBaseEntity(PChar->m_event.Target));
        if (!func_result.valid())
        {
            sol::error err = func_result;
            ShowError("luautils::onEventUpdate: %s\n", err.what());
            return -1;
        }

        return func_result.get_type() == sol::type::number ? func_result.get<int32>() : 1;
    }

    int32 OnEventUpdate(CCharEntity* PChar, int8* string)
    {
        TracyZoneScoped;

        auto onEventUpdate = LoadEventScript(PChar, "onEventUpdate");
        if (!onEventUpdate.valid())
        {
            ShowError("luautils::onEventUpdate: undefined procedure onEventUpdate\n");
            return -1;
        }

        auto result = onEventUpdate(CLuaBaseEntity(PChar), PChar->m_event.EventID, string, CLuaBaseEntity(PChar->m_event.Target));
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

        auto onEventFinish = LoadEventScript(PChar, "onEventFinish");
        if (!onEventFinish.valid())
        {
            ShowError("luautils::onEventFinish: undefined procedure onEventFinish\n");
            return -1;
        }

        auto func_result = onEventFinish(CLuaBaseEntity(PChar), eventID, result, CLuaBaseEntity(PChar->m_event.Target));
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

        auto filename = fmt::format("scripts/zones/{}/npcs/{}.lua", PChar->loc.zone->GetName(), PNpc->GetName());

        PChar->m_event.reset();
        PChar->m_event.Target = PNpc;
        PChar->m_event.Script = filename;

        auto onTrade = loadFunctionFromFile("onTrade", filename);
        if (!onTrade.valid())
        {
            return -1;
        }

        auto result = onTrade(CLuaBaseEntity(PChar), CLuaBaseEntity(PNpc), CLuaTradeContainer(PChar->TradeContainer));
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

        auto filename = fmt::format("scripts/zones/{}/npcs/{}.lua", PNpc->loc.zone->GetName(), PNpc->GetName());

        auto onSpawn = loadFunctionFromFile("onSpawn", filename);
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

    int32 OnAdditionalEffect(CBattleEntity* PAttacker, CBattleEntity* PDefender, CItemWeapon* PItem, actionTarget_t* Action, uint32 damage)
    {
        TracyZoneScoped;

        auto filename = fmt::format(PAttacker->objtype == TYPE_PC ? "scripts/globals/items/{}.lua" : "scripts/zones/{}/mobs/{}.lua",
                                    PAttacker->objtype == TYPE_PC ? PItem->getName() : PAttacker->loc.zone->GetName(), PAttacker->GetName());

        auto onAdditionalEffect = loadFunctionFromFile("onAdditionalEffect", filename);
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

        auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PDefender->loc.zone->GetName(), PDefender->GetName());

        auto onSpikesDamage = loadFunctionFromFile("onSpikesDamage", filename);
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

        auto filename = fmt::format("scripts/{}.lua", PStatusEffect->GetName());

        auto onEffectGain = loadFunctionFromFile("onEffectGain", filename);
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

        auto filename = fmt::format("scripts/{}.lua", PStatusEffect->GetName());

        auto onEffectTick = loadFunctionFromFile("onEffectTick", filename);
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

        auto filename = fmt::format("scripts/{}.lua", PStatusEffect->GetName());

        auto onEffectLose = loadFunctionFromFile("onEffectLose", filename);
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

        auto filename = fmt::format("scripts/globals/abilities/pets/attachments/{}.lua", attachment->getName());

        auto onEquip = loadFunctionFromFile("onEquip", filename);
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

        auto filename = fmt::format("scripts/globals/abilities/pets/attachments/{}.lua", attachment->getName());

        auto onUnequip = loadFunctionFromFile("onUnequip", filename);
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

        auto filename = fmt::format("scripts/globals/abilities/pets/attachments/{}.lua", attachment->getName());

        auto onManeuverGain = loadFunctionFromFile("onManeuverGain", filename);
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

        auto filename = fmt::format("scripts/globals/abilities/pets/attachments/{}.lua", attachment->getName());

        auto onManeuverLose = loadFunctionFromFile("onManeuverLose", filename);
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

        auto filename = fmt::format("scripts/globals/abilities/pets/attachments/{}.lua", attachment->getName());

        auto onUpdate = loadFunctionFromFile("onUpdate", filename);
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

    /************************************************************************
     *                                                                       *
     *  Проверяем возможность использования предмета. Если все хорошо, то    *
     *  возвращаемое значение - 0, в случае отказа - номер сообщения ошибки  *
     *                                                                       *
     ************************************************************************/

    std::tuple<int32, int32, int32> OnItemCheck(CBaseEntity* PTarget, CItem* PItem, ITEMCHECK param, CBaseEntity* PCaster)
    {
        TracyZoneScoped;

        auto filename = fmt::format("scripts/globals/items/{}.lua", PItem->getName());

        auto onItemCheck = loadFunctionFromFile("onItemCheck", filename);
        if (!onItemCheck.valid())
        {
            return { 56, 0, 0 };
        }

        auto result = onItemCheck(CLuaBaseEntity(PTarget), static_cast<uint32>(param), CLuaBaseEntity(PCaster));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onItemCheck: %s\n", err.what());
            return { 56, 0, 0 };
        }

        uint32 messageId = result.return_count() > 0 ? result.get<int32>() : 0;
        uint32 param1    = result.return_count() > 1 ? result.get<int32>() : 0;
        uint32 param2    = result.return_count() > 2 ? result.get<int32>() : 0;

        return { messageId, param1, param2 };
    }

    /************************************************************************
     *                                                                       *
     *  Используем предмет. Возврадаемое значение - номер сообщения или 0.   *
     *  Так же необходимо как-то передавать параметр сообщения (например,    *
     *  количество восстановленных MP)                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnItemUse(CBaseEntity* PTarget, CItem* PItem)
    {
        TracyZoneScoped;

        auto filename = fmt::format("scripts/globals/items/{}.lua", PItem->getName());

        auto onItemUse = loadFunctionFromFile("onItemUse", filename);
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

    /************************************************************************
     *                                                                       *
     *  check for gear sets  (e.g Set: enhances haste effect)                *
     *                                                                       *
     ************************************************************************/

    int32 CheckForGearSet(CBaseEntity* PTarget)
    {
        TracyZoneScoped;

        auto filename = "scripts/globals/gear_sets.lua";

        auto checkForGearSet = loadFunctionFromFile("checkForGearSet", filename);
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

        auto filename = fmt::format(PSpell->getSpellGroup() == SPELLGROUP_BLUE    ? "scripts/globals/spells/bluemagic/{}.lua"
                                    : PSpell->getSpellGroup() == SPELLGROUP_TRUST ? "scripts/globals/spells/trust/{}.lua"
                                                                                  : "scripts/globals/spells/{}.lua",
                                    PSpell->getName());

        auto onSpellCast = loadFunctionFromFile("onSpellCast", filename);
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

        uint32 retVal = result.return_count() ? result.get<int32>() : 0;
        return retVal;
    }

    int32 OnSpellPrecast(CBattleEntity* PCaster, CSpell* PSpell)
    {
        TracyZoneScoped;

        if (PCaster->objtype != TYPE_MOB)
        {
            return -1;
        }

        auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PCaster->loc.zone->GetName(), PCaster->GetName());

        auto onSpellPrecast = loadFunctionFromFile("onSpellPrecast", filename);
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

        auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PCaster->loc.zone->GetName(), PCaster->GetName());

        auto onMonsterMagicPrepare = loadFunctionFromFile("onMonsterMagicPrepare", filename);
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

        uint32 retVal = result.return_count() ? result.get<int32>() : 0;
        if (retVal > 0)
        {
            return static_cast<SpellID>(retVal);
        }

        return {};
    }

    /************************************************************************
     *                                                                       *
     *  Called when mob is targeted by a spell.                              *
     *  Note: does not differentiate between offensive and defensive spells  *
     *                                                                       *
     ************************************************************************/

    int32 OnMagicHit(CBattleEntity* PCaster, CBattleEntity* PTarget, CSpell* PSpell)
    {
        TracyZoneScoped;

        if (PSpell == nullptr)
        {
            return -1;
        }

        PTarget->PAI->EventHandler.triggerListener("MAGIC_TAKE", PTarget, PCaster, PSpell);

        auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PTarget->loc.zone->GetName(), PTarget->GetName());

        auto onMagicHit = loadFunctionFromFile("onMagicHit", filename);
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

        return result.return_count() ? result.get<int32>() : 0;
    }

    /************************************************************************
     *                                                                       *
     *  Called when mob is struck by a Weaponskill                           *
     *                                                                       *
     ************************************************************************/

    int32 OnWeaponskillHit(CBattleEntity* PMob, CBaseEntity* PAttacker, uint16 PWeaponskill)
    {
        TracyZoneScoped;

        auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());

        auto onWeaponskillHit = loadFunctionFromFile("onWeaponskillHit", filename);
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

        return result.return_count() ? result.get<int32>() : 0;
    }

    /************************************************************************
     *  onMobInitialize                                                      *
     *  Used for passive trait                                               *
     *                                                                       *
     ************************************************************************/

    int32 OnMobInitialize(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());

        auto onMobInitialize = loadFunctionFromFile("onMobInitialize", filename);
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

    int32 ApplyMixins(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr || PMob->objtype == TYPE_MOB)
        {
            return -1;
        }

        // Clear out globals
        lua["mixins"]       = sol::nil;
        lua["mixinOptions"] = sol::nil;

        auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());

        auto script_result = lua.script_file(filename);
        if (!script_result.valid())
        {
            sol::error err = script_result;
            ShowError("luautils::%s: %s\n", "applyMixins", err.what());
            return -1;
        }

        // get the function "applyMixins"
        auto applyMixins = lua.get<sol::function>("applyMixins");
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

    int32 ApplyZoneMixins(CBaseEntity* PMob)
    {
        TracyZoneScoped;

        if (PMob == nullptr || PMob->objtype == TYPE_MOB)
        {
            return -1;
        }

        // Clear out any previous global definitions
        lua.set("mixins", sol::nil);
        lua.set("mixinOptions", sol::nil);

        auto filename = fmt::format("scripts/mixins/zones/%s.lua", PMob->loc.zone->GetName());

        // get the function "applyMixins"
        // Will be found through requires in globals/mixins
        auto applyMixins = loadFunctionFromFile("applyMixins", filename);
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

        // call
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

        auto filename = fmt::format("scripts/zones/{}/{}/{}.lua", PEntity->loc.zone->GetName(), (PEntity->objtype == TYPE_MOB ? "mobs" : "npcs"), PEntity->GetName());

        auto onPath = loadFunctionFromFile("onPath", filename);
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

        std::string filename = "scripts/globals/battlefield.lua";
        int32       MaxAreas = 3;

        auto onBattlefieldHandlerInitialise = loadFunctionFromFile("onBattlefieldHandlerInitialise", filename);
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

        return result.return_count() ? result.get<int32>() : 0;
    }

    int32 OnBattlefieldInitialise(CBattlefield* PBattlefield)
    {
        TracyZoneScoped;

        if (PBattlefield == nullptr)
        {
            return -1;
        }

        auto filename = fmt::format("scripts/zones/{}/bcnms/{}.lua", PBattlefield->GetZone()->GetName(), PBattlefield->GetName());

        auto onBattlefieldInitialise = loadFunctionFromFile("onBattlefieldInitialise", filename);
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

        auto filename = fmt::format("scripts/zones/{}/bcnms/{}.lua", PBattlefield->GetZone()->GetName(), PBattlefield->GetName());

        auto onBattlefieldTick = loadFunctionFromFile("onBattlefieldTick", filename);
        if (!onBattlefieldTick.valid())
        {
            ShowError("luautils::onBattlefieldTick: Unable to find onBattlefieldTick function for %s\n", filename);
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

        auto filename = fmt::format("scripts/zones/{}/bcnms/{}.lua", PBattlefield->GetZone()->GetName(), PBattlefield->GetName());

        auto onBattlefieldStatusChange = loadFunctionFromFile("onBattlefieldStatusChange", filename);
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
            filename = fmt::format("scripts/globals/pets/{}.lua", static_cast<CPetEntity*>(PMob)->GetScriptName());
        }
        else
        {
            filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());
        }

        if (PTarget->objtype == TYPE_PC)
        {
            ((CCharEntity*)PTarget)->m_event.reset();
            ((CCharEntity*)PTarget)->m_event.Target = PMob;
            ((CCharEntity*)PTarget)->m_event.Script = filename;
        }

        auto onMobEngaged = loadFunctionFromFile("onMobEngaged", filename);
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

        std::string filename;
        if (PMob->objtype == TYPE_PET)
        {
            filename = fmt::format("scripts/globals/pets/{}.lua", static_cast<CPetEntity*>(PMob)->GetScriptName());
        }
        else
        {
            filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());
        }

        auto onMobDisengage = loadFunctionFromFile("onMobDisengage", filename);
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

        auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (PTarget->objtype == TYPE_PC)
        {
            ((CCharEntity*)PTarget)->m_event.reset();
            ((CCharEntity*)PTarget)->m_event.Target = PMob;
            ((CCharEntity*)PTarget)->m_event.Script = filename;
        }

        auto onMobDrawIn = loadFunctionFromFile("onMobDrawIn", filename);
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

        std::string filename;
        if (PMob->objtype == TYPE_PET)
        {
            filename = fmt::format("scripts/globals/pets/{}.lua", static_cast<CPetEntity*>(PMob)->GetScriptName());
        }
        else
        {
            filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());
        }

        auto onMobFight = loadFunctionFromFile("onMobFight", filename);
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

        auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());

        auto onCriticalHit = loadFunctionFromFile("onCriticalHit", filename);
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

        CCharEntity* PChar = dynamic_cast<CCharEntity*>(PKiller);
        if (PChar && PMob->objtype == TYPE_MOB)
        {
            auto onMobDeathEx = loadFunctionFromFile("onMobDeathEx", "scripts/globals/mobs.lua");
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

            auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());

            auto onMobDeath = loadFunctionFromFile("onMobDeath", filename);
            if (!onMobDeath.valid())
            {
                ShowError("luautils::onMobDeath (%s): undefined procedure onMobDeath\n", filename);
                return -1;
            }

            PChar->ForAlliance([PMob, PChar, &onMobDeath, &filename](CBattleEntity* PPartyMember) {
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
                    auto result = onMobDeath(LuaMobEntity, optLuaAllyEntity, isKiller, noKiller);
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
            std::string filename;
            switch (PMob->objtype)
            {
                case TYPE_MOB:
                    filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());
                    break;
                case TYPE_PET:
                    filename = fmt::format("scripts/globals/pets/{}.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str());
                    break;
                case TYPE_TRUST:
                    filename = fmt::format("scripts/globals/spells/trust/{}.lua", PMob->GetName());
                    break;
                default:
                    ShowWarning("luautils::onMobSpawn (%d): unknown objtype\n", PMob->objtype);
                    break;
            }

            auto onMobDeath = loadFunctionFromFile("onMobDeath", filename);
            if (!onMobDeath.valid())
            {
                ShowError("luautils::onMobDeath (%s): undefined procedure onMobDeath\n", filename);
                return -1;
            }

            // onMobDeath(mob, player, isKiller, noKiller)
            auto result = onMobDeath(CLuaBaseEntity(PMob), sol::nil, sol::nil, true);
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

        std::string filename;
        switch (PMob->objtype)
        {
            case TYPE_MOB:
                filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());
                break;
            case TYPE_PET:
                filename = fmt::format("scripts/globals/pets/{}.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str());
                break;
            case TYPE_TRUST:
                filename = fmt::format("scripts/globals/spells/trust/{}.lua", PMob->GetName());
                break;
            default:
                ShowWarning("luautils::onMobSpawn (%d): unknown objtype\n", PMob->objtype);
                break;
        }

        auto onMobSpawn = loadFunctionFromFile("onMobSpawn", filename);
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

        CLuaBaseEntity LuaMobEntity(PMob);

        auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());

        auto onMobRoamAction = loadFunctionFromFile("onMobRoamAction", filename);
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

        auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());

        auto onMobRoam = loadFunctionFromFile("onMobRoam", filename);
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

        std::string filename;
        switch (PMob->objtype)
        {
            case TYPE_MOB:
                filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());
                break;
            case TYPE_PET:
                filename = fmt::format("scripts/globals/pets/{}.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str());
                break;
            case TYPE_TRUST:
                filename = fmt::format("scripts/globals/spells/trust/{}.lua", PMob->GetName());
                break;
            default:
                ShowWarning("luautils::onMobSpawn (%d): unknown objtype\n", PMob->objtype);
                break;
        }

        auto onMobDespawn = loadFunctionFromFile("onMobDespawn", filename);
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

        auto filename = fmt::format("scripts/zones/{}/Zone.lua", PZone->GetName());

        auto onGameDay = loadFunctionFromFile("onGameDay", filename);
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

        auto filename = fmt::format("scripts/zones/{}/Zone.lua", PZone->GetName());

        auto onGameHour = loadFunctionFromFile("onGameHour", filename);
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

        auto filename = fmt::format("scripts/zones/{}/Zone.lua", zoneutils::GetZone(ZoneID)->GetName());

        auto onZoneWeatherChange = loadFunctionFromFile("onZoneWeatherChange", filename);
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

        auto filename = fmt::format("scripts/zones/{}/Zone.lua", zoneutils::GetZone(ZoneID)->GetName());

        auto onTOTDChange = loadFunctionFromFile("onTOTDChange", filename);
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

        auto filename = fmt::format("scripts/globals/weaponskills/{}.lua", wskill->getName());

        auto onUseWeaponSkill = loadFunctionFromFile("onUseWeaponSkill", filename);
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
            auto filename = fmt::format("scripts/zones/{}/mobs/{}.lua", PMob->loc.zone->GetName(), PMob->GetName());

            auto onMobWeaponSkill = loadFunctionFromFile("onMobWeaponSkill", filename);
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
        auto filename = fmt::format("scripts/globals/mobskills/{}.lua", PMobSkill->getName());

        auto onMobWeaponSkill = loadFunctionFromFile("onMobWeaponSkill", filename);
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

        return result.return_count() ? result.get<int32>() : 0;
    }

    int32 OnMobSkillCheck(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill)
    {
        TracyZoneScoped;

        auto filename = fmt::format("scripts/globals/mobskills/{}.lua", PMobSkill->getName());

        auto onMobSkillCheck = loadFunctionFromFile("onMobSkillCheck", filename);
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

        return result.return_count() ? result.get<int32>() : -5;
    }

    int32 OnMobAutomatonSkillCheck(CBaseEntity* PTarget, CAutomatonEntity* PAutomaton, CMobSkill* PMobSkill)
    {
        TracyZoneScoped;

        auto filename = fmt::format("scripts/globals/abilities/pets/{}.lua", PMobSkill->getName());

        auto onMobSkillCheck = loadFunctionFromFile("onMobSkillCheck", filename);
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

        return result.return_count() ? result.get<int32>() : -5;
    }

    /***********************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnMagicCastingCheck(CBaseEntity* PChar, CBaseEntity* PTarget, CSpell* PSpell)
    {
        TracyZoneScoped;

        auto filename = fmt::format(PSpell->getSpellGroup() == SPELLGROUP_BLUE    ? "scripts/globals/spells/bluemagic/{}.lua"
                                    : PSpell->getSpellGroup() == SPELLGROUP_TRUST ? "scripts/globals/spells/trust/{}.lua"
                                                                                  : "scripts/globals/spells/{}.lua",
                                    PSpell->getName());

        auto onMagicCastingCheck = loadFunctionFromFile("onMagicCastingCheck", filename);
        if (!onMagicCastingCheck.valid())
        {
            ShowWarning("luautils::onTrigger\n");
            return 47;
        }

        auto result = onMagicCastingCheck(CLuaBaseEntity(PChar), CLuaBaseEntity(PTarget), CLuaSpell(PSpell));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onMagicCastingCheck (%s): %s\n", PSpell->getName(), err.what());
            return 47;
        }

        return result.return_count() ? result.get<uint32>() : -5;
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
            filename = fmt::format("scripts/globals/abilities/pets/{}.lua", PAbility->getName());
        }
        else
        {
            filename = fmt::format("scripts/globals/abilities/{}.lua", PAbility->getName());
        }

        auto onAbilityCheck = loadFunctionFromFile("onAbilityCheck", filename);
        if (!onAbilityCheck.valid())
        {
            ShowWarning("luautils::onAbilityCheck\n");
            return 87;
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

        auto filename = fmt::format("scripts/globals/abilities/pets/{}.lua", PMobSkill->getName());

        auto onPetAbility = loadFunctionFromFile("onPetAbility", filename);
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

        return result.return_count() ? result.get<int32>() : 0;
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
        if (PUser->objtype == TYPE_PET)
        {
            filename = fmt::format("scripts/globals/abilities/pets/{}.lua", PAbility->getName());
        }
        else
        {
            filename = fmt::format("scripts/globals/abilities/{}.lua", PAbility->getName());
        }

        auto onUseAbility = loadFunctionFromFile("onUseAbility", filename);
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

        return result.return_count() ? result.get<int32>() : 0;
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

        auto filename = fmt::format("scripts/zones/{}/Zone.lua", PZone->GetName());

        auto onInstanceZoneIn = loadFunctionFromFile("onInstanceZoneIn", filename);
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
        TPZ_DEBUG_BREAK_IF(!PChar->PInstance);

        TracyZoneScoped;

        auto filename = fmt::format("scripts/zones/{}/instances/{}.lua", PChar->loc.zone->GetName(), PChar->PInstance->GetName());

        auto afterInstanceRegister = loadFunctionFromFile("afterInstanceRegister", filename);
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

        auto filename = fmt::format("scripts/zones/{}/Zone.lua", PZone->GetName());

        auto onInstanceLoadFailed = loadFunctionFromFile("onInstanceLoadFailed", filename);
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

        return result.return_count() ? result.get<int32>() : 0;
    }

    int32 OnInstanceTimeUpdate(CZone* PZone, CInstance* PInstance, uint32 time)
    {
        TracyZoneScoped;

        auto filename = fmt::format("scripts/zones/{}/instances/{}.lua", PInstance->GetZone()->GetName(), PInstance->GetName());

        auto onInstanceTimeUpdate = loadFunctionFromFile("onInstanceTimeUpdate", filename);
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

        auto filename = fmt::format("scripts/zones/{}/instances/{}.lua", PInstance->GetZone()->GetName(), PInstance->GetName());

        auto onInstanceFailure = loadFunctionFromFile("onInstanceFailure", filename);
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

        auto onInstanceCreated = loadFunctionFromFile("onInstanceCreated", PChar->m_event.Script);
        if (!onInstanceCreated.valid())
        {
            // If you can't load from PChar->m_event.Script, try from the zone
            auto filename     = fmt::format("scripts/zones/{}/Zone.lua", PChar->loc.zone->GetName());
            onInstanceCreated = loadFunctionFromFile("onInstanceCreated", filename);
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

        auto filename = fmt::format("scripts/zones/{}/instances/{}.lua", PInstance->GetZone()->GetName(), PInstance->GetName());

        auto onInstanceCreated = loadFunctionFromFile("onInstanceCreated", filename);
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

        auto filename = fmt::format("scripts/zones/{}/instances/{}.lua", PInstance->GetZone()->GetName(), PInstance->GetName());

        auto onInstanceProgressUpdate = loadFunctionFromFile("onInstanceProgressUpdate", filename);
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

        auto filename = fmt::format("scripts/zones/{}/instances/{}.lua", PInstance->GetZone()->GetName(), PInstance->GetName());

        auto onInstanceStageChange = loadFunctionFromFile("onInstanceStageChange", filename);
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

        auto filename = fmt::format("scripts/zones/{}/instances/{}.lua", PInstance->GetZone()->GetName(), PInstance->GetName());

        auto onInstanceComplete = loadFunctionFromFile("onInstanceComplete", filename);
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

        auto filename = fmt::format("scripts/zones/{}/Zone.lua", PChar->loc.zone->GetName());

        auto onTransportEvent = loadFunctionFromFile("onTransportEvent", filename);
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

        auto filename = fmt::format("scripts/zones/{}/npcs/{}.lua", PNpc->loc.zone->GetName(), PNpc->GetName());

        auto onTimeTrigger = loadFunctionFromFile("onTimeTrigger", filename);
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

        auto filename = fmt::format("scripts/zones/{}/Zone.lua", PZone->GetName());

        auto onConquestUpdate = loadFunctionFromFile("onConquestUpdate", filename);
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

        auto filename = fmt::format("scripts/zones/{}/bcnms/{}.lua", PZone->GetName(), PBattlefield->GetName());

        auto onBattlefieldEnter = loadFunctionFromFile("onBattlefieldEnter", filename);
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

        auto filename = fmt::format("scripts/zones/{}/bcnms/{}.lua", PZone->GetName(), PBattlefield->GetName());

        auto onBattlefieldLeave = loadFunctionFromFile("onBattlefieldLeave", filename);
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

        auto filename = fmt::format("scripts/zones/{}/bcnms/{}.lua", PZone->GetName(), PBattlefield->GetName());

        auto onBattlefieldRegister = loadFunctionFromFile("onBattlefieldRegister", filename);
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

        auto filename = fmt::format("scripts/zones/{}/bcnms/{}.lua", PBattlefield->GetZone()->GetName(), PBattlefield->GetName());

        auto onBattlefieldDestroy = loadFunctionFromFile("onBattlefieldDestroy", filename);
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
                r = tpzrand::GetRandomNumber(Sql_GetUIntData(SqlHandle, 0));
            }
            else
            {
                ShowDebug(CL_RED "UpdateNMSpawnPoint: SQL error: No entries for mobid <%u> found.\n" CL_RESET, mobid);
                return;
            }

            ret = Sql_Query(SqlHandle, "SELECT pos_x, pos_y, pos_z FROM `nm_spawn_points` WHERE mobid=%u AND pos=%i", mobid, r);
            if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                PMob->m_SpawnPoint.rotation = tpzrand::GetRandomNumber(256);
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
        nearPos.add("x", pos.x);
        nearPos.add("y", pos.y);
        nearPos.add("z", pos.z);

        return nearPos;
    }

    void OnPlayerLevelUp(CCharEntity* PChar)
    {
        TracyZoneScoped;

        auto onPlayerLevelUp = lua["tpz"]["player"]["onPlayerLevelUp"];
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

        auto onPlayerLevelDown = lua["tpz"]["player"]["onPlayerLevelDown"];
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

        auto filename = fmt::format("scripts/zones/{}/Zone.lua", PChar->loc.zone->GetName());

        auto onChocoboDig = loadFunctionFromFile("onChocoboDig", filename);
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

        return result.return_count() ? result.get<bool>() : false;
    }

    /************************************************************************
     *   Loads a Lua function with a fallback hierarchy                      *
     *                                                                       *
     *   1) 1st try: PChar->m_event.Script                                   *
     *   2) 2nd try: The instance script if the player is in one             *
     *   3) 3rd try: The zone script for the zone the player is in           *
     *                                                                       *
     ************************************************************************/
    sol::function LoadEventScript(CCharEntity* PChar, const char* functionName)
    {
        TracyZoneScoped;

        auto funcFromChar = loadFunctionFromFile(functionName, PChar->m_event.Script);
        if (funcFromChar.valid())
        {
            return funcFromChar;
        }

        if (PChar->PInstance)
        {
            auto instance_filename = fmt::format("scripts/zones/{}/instances/{}", PChar->loc.zone->GetName(), PChar->PInstance->GetName());

            auto funcFromInstance = loadFunctionFromFile(functionName, instance_filename);
            if (funcFromInstance.valid())
            {
                return funcFromInstance;
            }
        }

        auto zone_filename = fmt::format("scripts/zones/{}/Zone.lua", PChar->loc.zone->GetName());

        auto funcFromZone = loadFunctionFromFile(functionName, zone_filename);
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

        auto filename = fmt::format("scripts/globals/items/{}.lua", PItem->getName());

        auto onFurniturePlaced = loadFunctionFromFile("onFurniturePlaced", filename);
        if (!onFurniturePlaced.valid())
        {
            ShowWarning("luautils::onFurniturePlaced\n");
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

        auto filename = fmt::format("scripts/globals/items/{}.lua", PItem->getName());

        auto onFurnitureRemoved = loadFunctionFromFile("onFurnitureRemoved", filename);
        if (!onFurnitureRemoved.valid())
        {
            ShowWarning("luautils::onFurnitureRemoved\n");
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

        auto onPlayerEmote = lua["tpz"]["player"]["onPlayerEmote"];
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
