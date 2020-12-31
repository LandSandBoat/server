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
#define lua_prepscript(n, ...) \
    int8 File[255];            \
    snprintf((char*)File, sizeof(File), n, ##__VA_ARGS__);

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
        lua.set_function("print", &luautils::print);

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

        set_function("getNPCByID", &luautils::GetNPCByID);
        set_function("getMobByID", &luautils::GetMobByID);
        set_function("weekUpdateConquest", &luautils::WeekUpdateConquest);
        set_function("getRegionOwner", &luautils::GetRegionOwner);
        set_function("getRegionInfluence", &luautils::GetRegionInfluence);
        set_function("getNationRank", &luautils::getNationRank);
        set_function("getConquestBalance", &luautils::getConquestBalance);
        set_function("isConquestAlliance", &luautils::isConquestAlliance);
        set_function("spawnMob", &luautils::SpawnMob);
        set_function("despawnMob", &luautils::DespawnMob);
        set_function("getPlayerByName", &luautils::GetPlayerByName);
        set_function("getPlayerByID", &luautils::GetPlayerByID);
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
        lua.require_file("scripts/globals/player", "scripts/globals/player.lua");

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
            lua_close(LuaHandle);
            LuaHandle = nullptr;
            ShowMessage("\t - " CL_GREEN "[OK]" CL_RESET "\n");
        }
        return 0;
    }

    int32 garbageCollect()
    {
        TracyZoneScoped;
        TracyReportLuaMemory(LuaHandle);

        int32 top = lua_gettop(LuaHandle);
        ShowDebug(CL_CYAN "[Lua] Garbage Collected. Current State Top: %d\n" CL_RESET, top);

        lua_gc(LuaHandle, LUA_GCSTEP, 10);

        TracyReportLuaMemory(LuaHandle);

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Переопределение официальной lua функции print                        *
     *                                                                       *
     ************************************************************************/

    void print(std::string const& str)
    {
        ShowScript("%s\n", str);
    }

    int32 prepFile(int8* File, const char* function)
    {
        TracyZoneScoped;
        TracyZoneCString(function);
        TracyZoneIString(File);
        TracyReportLuaMemory(LuaHandle);

        lua_pushnil(LuaHandle);
        lua_setglobal(LuaHandle, function);

        auto ret = luaL_loadfile(LuaHandle, (const char*)File);
        if (ret)
        {
            if (ret != LUA_ERRFILE)
            {
                ShowError("luautils::%s: %s\n", function, lua_tostring(LuaHandle, -1));
            }
            lua_pop(LuaHandle, 1);
            return -1;
        }

        ret = lua_pcall(LuaHandle, 0, 0, 0);
        if (ret)
        {
            ShowError("luautils::%s: %s\n", function, lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        lua_getglobal(LuaHandle, function);
        if (lua_isnil(LuaHandle, -1))
        {
            lua_pop(LuaHandle, 1);
            return -1;
        }
        return 0;
    }

    sol::function loadFunctionFromFile(std::string funcName, std::string fileName)
    {
        // Erase previous copies of the function, if they're left over from previous calls
        lua.set(funcName, sol::nil);

        // Run script
        lua.script_file(fileName);

        auto func = lua.get<sol::function>(funcName);
        if (!func.valid())
        {
            return sol::nil;
        }
        return func;
    }

    // temporary solution for geysers in Dangruf_Wadi
    void SendEntityVisualPacket(uint32 npcid, const char* command)
    {
        if (CBaseEntity* PNpc = zoneutils::GetEntity(npcid, TYPE_NPC))
        {
            PNpc->loc.zone->PushPacket(PNpc, CHAR_INRANGE, new CEntityVisualPacket(PNpc, command));
        }
    }

    std::shared_ptr<CLuaBaseEntity> GetNPCByID(uint32 npcid, sol::object const& instanceObj)
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

        return std::make_shared<CLuaBaseEntity>(PNpc);
    }

    /************************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    std::shared_ptr<CLuaBaseEntity> GetMobByID(uint32 mobid, sol::object const& instanceObj)
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
            return nullptr;
        }

        return std::make_shared<CLuaBaseEntity>(PMob);
    }

    /************************************************************************
     *                                                                       *
     * WeekUpdateConquest                                                    *
     *                                                                       *
     ************************************************************************/

    void WeekUpdateConquest(sol::variadic_args va)
    {
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
        return conquest::GetRegionOwner(static_cast<REGION_TYPE>(type));
    }

    uint8 GetRegionInfluence(uint8 type)
    {
        return conquest::GetInfluenceGraphics(static_cast<REGION_TYPE>(type));
    }

    /************************************************************************
     *                                                                       *
     * Get Rank of Nations in Conquest                                       *
     *                                                                       *
     ************************************************************************/

    uint8 getNationRank(uint8 nation)
    {
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

    uint8 getConquestBalance()
    {
        return conquest::GetBalance();
    }

    bool isConquestAlliance()
    {
        return conquest::IsAlliance();
    }

    /************************************************************************
     *                                                                       *
     * SetRegionalConquestOverseers() used for updating conquest guards      *
     *                                                                       *
     ************************************************************************/

    int32 SetRegionalConquestOverseers(uint8 regionID)
    {
        char File[255];
        memset(File, 0, sizeof(File));

        lua_pushnil(LuaHandle);
        lua_setglobal(LuaHandle, "SetRegionalConquestOverseers");

        snprintf(File, sizeof(File), "scripts/globals/conquest.lua");

        if (luaL_loadfile(LuaHandle, File) || lua_pcall(LuaHandle, 0, 0, 0))
        {
            ShowError("luautils::SetRegionalConquestOverseers: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        lua_getglobal(LuaHandle, "tpz");
        if (lua_isnil(LuaHandle, -1))
        {
            lua_pop(LuaHandle, 1);
            ShowError("luautils::SetRegionalConquestOverseers: undefined global tpz\n");
            return -1;
        }

        lua_getfield(LuaHandle, -1, "conquest");
        if (lua_isnil(LuaHandle, -1))
        {
            lua_pop(LuaHandle, 2);
            ShowError("luautils::SetRegionalConquestOverseers: undefined field tpz.conquest\n");
            return -1;
        }

        lua_getfield(LuaHandle, -1, "setRegionalConquestOverseers");
        if (lua_isnil(LuaHandle, -1))
        {
            lua_pop(LuaHandle, 3);
            ShowError("luautils::SetRegionalConquestOverseers: undefined procedure tpz.conquest.setRegionalConquestOverseers\n");
            return -1;
        }

        lua_pushinteger(LuaHandle, regionID);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::SetRegionalConquestOverseers: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 3);
            return -1;
        }
        else
        {
            lua_pop(LuaHandle, 2);
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
        return CVanaTime::getInstance()->getVanaTime();
    }

    /************************************************************************
     *                                                                       *
     *  Получаем текущее время суток Vana'diel                               *
     *                                                                       *
     ************************************************************************/

    uint8 VanadielTOTD()
    {
        return static_cast<uint8>(CVanaTime::getInstance()->GetCurrentTOTD());
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Year                                                *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielYear()
    {
        return CVanaTime::getInstance()->getYear();
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Month                                               *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielMonth()
    {
        return CVanaTime::getInstance()->getMonth();
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Day of Year                                         *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielDayOfTheYear()
    {
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
        return CVanaTime::getInstance()->getWeekday();
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Hour                                                *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielHour()
    {
        return CVanaTime::getInstance()->getHour();
    }

    /************************************************************************
     *                                                                       *
     *   Return Vanadiel Minute                                              *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielMinute()
    {
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
        return static_cast<uint8>(battleutils::GetDayElement());
    }

    /************************************************************************
     *                                                                       *
     * JstMidnight - Returns UTC timestamp of upcoming JST midnight
     *                                                                       *
     ************************************************************************/

    uint32 JstMidnight()
    {
        return CVanaTime::getInstance()->getJstMidnight();
    }

    /************************************************************************
     *                                                                       *
     *   Return Moon Phase                                                   *
     *                                                                       *
     ************************************************************************/

    uint32 VanadielMoonPhase()
    {
        return CVanaTime::getInstance()->getMoonPhase();
    }

    bool SetVanadielTimeOffset(int32 offset)
    {
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
        return CVanaTime::getInstance()->getMoonDirection();
    }

    /************************************************************************
     *                                                                       *
     *   Return RSE Race                                                     *
     *                                                                       *
     ************************************************************************/

    uint8 VanadielRSERace()
    {
        return CVanaTime::getInstance()->getRSERace();
    }

    /************************************************************************
     *                                                                       *
     *   Return RSE Location                                                 *
     *                                                                       *
     ************************************************************************/

    uint8 VanadielRSELocation()
    {
        return CVanaTime::getInstance()->getRSELocation();
    }

    /************************************************************************
     *                                                                       *
     *   is new moon?                                                        *
     *                                                                       *
     ************************************************************************/

    bool IsMoonNew()
    {
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
    std::shared_ptr<CLuaBaseEntity> SpawnMob(uint32 mobid, sol::object const& arg2, sol::object const& arg3)
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
        }

        return std::make_shared<CLuaBaseEntity>(PMob);
    }

    /************************************************************************
     *                                                                       *
     *  DeSpawn mob using mob ID.                                            *
     *                                                                       *
     ************************************************************************/

    void DespawnMob(uint32 mobid, sol::object const& arg2)
    {
        TracyZoneScoped;

        CMobEntity* PMob  = nullptr;

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

    std::shared_ptr<CLuaBaseEntity> GetPlayerByName(std::string name)
    {
        CCharEntity* PTargetChar = zoneutils::GetCharByName((int8*)name.c_str());

        if (PTargetChar != nullptr)
        {
            return std::make_shared<CLuaBaseEntity>(PTargetChar);
        }

        return nullptr;
    }

    /************************************************************************
     *                                                                       *
     *  Gets a player object via the player's ID.                            *
     *                                                                       *
     ************************************************************************/

    std::shared_ptr<CLuaBaseEntity> GetPlayerByID(uint32 pid)
    {
        CCharEntity* PTargetChar = zoneutils::GetChar(pid);

        if (PTargetChar != nullptr)
        {
            return std::make_shared<CLuaBaseEntity>(PTargetChar);
        }

        return nullptr;
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

    int32 GetMagianTrial()
    {
        auto L = LuaHandle;

        if (!lua_isnil(L, 1))
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
                lua_pushnil(L);
                return 1;
            }

            const char* Query = "SELECT * FROM `magian` WHERE trialId = %u;";

            if (lua_isnumber(L, 1))
            {
                int32 trial = (lua_tointeger(L, 1));
                int32 field{ 0 };
                lua_newtable(L);
                if (Sql_Query(SqlHandle, Query, trial) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    for (auto column : magianColumns)
                    {
                        lua_pushstring(L, column.c_str());
                        lua_pushinteger(L, (int32)Sql_GetIntData(SqlHandle, field++));
                        lua_settable(L, -3);
                    }
                }
            }
            else if (lua_istable(L, 1))
            {
                // parse provided trial's from table
                std::vector<int32> trials;
                for (int i = 1, j = lua_objlen(L, 1); i <= j; i++)
                {
                    lua_pushinteger(L, i);
                    lua_gettable(L, 1);
                    if (!lua_tointeger(L, -1))
                    {
                        lua_pop(L, 1);
                        continue;
                    }
                    trials.push_back(lua_tointeger(L, -1));
                    lua_pop(L, 1);
                }

                // Build outer table
                lua_newtable(L);
                // one inner table each trial { trial# = { column = value, ... } }
                for (auto trial : trials)
                {
                    int32 ret = Sql_Query(SqlHandle, Query, trial);
                    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                    {
                        lua_pushinteger(L, trial);
                        lua_newtable(L);
                        int32 field{ 0 };
                        for (auto column : magianColumns)
                        {
                            lua_pushstring(L, column.c_str());
                            int t = (int32)Sql_GetIntData(SqlHandle, field++);
                            lua_pushinteger(L, t);
                            lua_settable(L, -3);
                        }
                        lua_settable(L, -3);
                    }
                }
            }
            else
            {
                return 0;
            }
            return 1;
        }
        lua_pushnil(L);
        return 1;
    }

    /*******************************************************************************
    *                                                                              *
    *  Returns a list of trial numbers who have the given parent trial             *
    *                                                                              *
    *******************************************************************************/

    int32 GetMagianTrialsWithParent()
    {
        auto L = LuaHandle;

        if (lua_isnumber(L, 1))
        {
            int32       parentTrial = lua_tointeger(L, 1);
            const char* Query       = "SELECT `trialId` from `magian` WHERE `previousTrial` = %u;";

            int32 ret = Sql_Query(SqlHandle, Query, parentTrial);
            if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0)
            {
                lua_newtable(L);
                int32 field{ 0 };
                while (Sql_NextRow(SqlHandle) == 0)
                {
                    int32 childTrial = Sql_GetIntData(SqlHandle, 0);
                    lua_pushinteger(L, ++field);
                    lua_pushinteger(L, childTrial);
                    lua_settable(L, -3);
                }
            }
            else
            {
                lua_pushnil(L);
            }
        }
        else
        {
            lua_pushnil(L);
        }
        return 1;
    }

    /************************************************************************
     *                                                                       *
     *  Загружаем значение переменной TextID указанной зоны                  *
     *                                                                       *
     ************************************************************************/

    int32 GetTextIDVariable(uint16 ZoneID, const char* variable)
    {
        lua_getglobal(LuaHandle, "zones");

        if (lua_isnil(LuaHandle, -1) || !lua_istable(LuaHandle, -1))
        {
            lua_pop(LuaHandle, 1);
            return 0;
        }

        lua_pushnumber(LuaHandle, ZoneID);
        lua_gettable(LuaHandle, -2);

        if (lua_isnil(LuaHandle, -1) || !lua_istable(LuaHandle, -1))
        {
            lua_pop(LuaHandle, 2);
            return 0;
        }

        lua_getfield(LuaHandle, -1, "text");

        if (lua_isnil(LuaHandle, -1) || !lua_istable(LuaHandle, -1))
        {
            lua_pop(LuaHandle, 3);
            return 0;
        }

        lua_getfield(LuaHandle, -1, variable);

        if (lua_isnil(LuaHandle, -1) || !lua_isnumber(LuaHandle, -1))
        {
            lua_pop(LuaHandle, 4);
            return 0;
        }

        int32 value = (int32)lua_tonumber(LuaHandle, -1);
        lua_pop(LuaHandle, 4);
        return value;
    }

    /************************************************************************
     *                                                                       *
     *  Get a Variable From Settings.lua                                     *
     *                                                                       *
     ************************************************************************/

    uint8 GetSettingsVariable(const char* variable)
    {
        lua_pushnil(LuaHandle);
        lua_setglobal(LuaHandle, variable);

        char File[255];
        memset(File, 0, sizeof(File));
        snprintf(File, sizeof(File), "scripts/globals/settings.lua");

        if (luaL_loadfile(LuaHandle, File) || lua_pcall(LuaHandle, 0, 0, 0))
        {
            lua_pop(LuaHandle, 1);
            return 0;
        }

        lua_getglobal(LuaHandle, variable);

        if (lua_isnil(LuaHandle, -1) || !lua_isnumber(LuaHandle, -1))
        {
            lua_pop(LuaHandle, 1);
            return 0;
        }

        uint8 value = (uint8)lua_tonumber(LuaHandle, -1);
        lua_pop(LuaHandle, -1);
        return value;
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
     *  Запускаем скрипт инициализации зоны.                                 *
     *  Выполняется во время старта сервера при загрузке зон.                *
     *  При разделенных lua стеках необходимо создавать их здесь             *
     *                                                                       *
     ************************************************************************/

    int32 OnZoneInitialise(uint16 ZoneID)
    {
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
        PChar->m_event.Script.insert(0, filename.c_str());

        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_BOOST);

        lua.script_file(filename);

        auto onTrigger = loadFunctionFromFile("onTrigger", filename);
        if (!onTrigger.valid())
        {
            ShowWarning("luautils::onTrigger\n");
            return -1;
        }

        auto result = onTrigger(CLuaBaseEntity(PChar), CLuaBaseEntity(PNpc));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onTrigger: %s\n", err.what());
            return -1;
        }

        return result.return_count() ? result.get<int32>() : 0;
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

        int32 updatePosition = func_result.return_count() ? func_result.get<int32>() : 0;
        return updatePosition;
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

        int32 updatePosition = func_result.return_count() ? func_result.get<int32>() : 0;
        return updatePosition;
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
        PChar->m_event.Script.insert(0, filename);

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
        lua_prepscript(PAttacker->objtype == TYPE_PC ? "scripts/globals/items/%s.lua" : "scripts/zones/%s/mobs/%s.lua",
                       PAttacker->objtype == TYPE_PC ? PItem->getName() : PAttacker->loc.zone->GetName(), PAttacker->GetName());

        if (prepFile(File, "onAdditionalEffect"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PAttacker);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaMobEntity(PDefender);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        lua_pushinteger(LuaHandle, damage);

        if (lua_pcall(LuaHandle, 3, 3, 0))
        {
            ShowError("luautils::onAdditionalEffect: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        Action->additionalEffect = (SUBEFFECT)(!lua_isnil(LuaHandle, -3) && lua_isnumber(LuaHandle, -3) ? (int32)lua_tonumber(LuaHandle, -3) : 0);
        Action->addEffectMessage = (!lua_isnil(LuaHandle, -2) && lua_isnumber(LuaHandle, -2) ? (int32)lua_tonumber(LuaHandle, -2) : 0);
        Action->addEffectParam   = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 3);

        return 0;
    }

    int32 OnSpikesDamage(CBattleEntity* PDefender, CBattleEntity* PAttacker, actionTarget_t* Action, uint32 damage)
    {
        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PDefender->loc.zone->GetName(), PDefender->GetName());

        if (prepFile(File, "onSpikesDamage"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PDefender);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaMobEntity(PAttacker);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        lua_pushinteger(LuaHandle, damage);

        if (lua_pcall(LuaHandle, 3, 3, 0))
        {
            ShowError("luautils::onSpikesDamage: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        Action->spikesEffect  = (SUBEFFECT)(!lua_isnil(LuaHandle, -3) && lua_isnumber(LuaHandle, -3) ? (int32)lua_tonumber(LuaHandle, -3) : 0);
        Action->spikesMessage = (!lua_isnil(LuaHandle, -2) && lua_isnumber(LuaHandle, -2) ? (int32)lua_tonumber(LuaHandle, -2) : 0);
        Action->spikesParam   = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 3);

        return 0;
    }

    int32 OnEffectGain(CBattleEntity* PEntity, CStatusEffect* PStatusEffect)
    {
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
        lua_prepscript("scripts/globals/abilities/pets/attachments/%s.lua", attachment->getName());

        if (prepFile(File, "onEquip"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PEntity);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onEquip: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        return 0;
    }

    int32 OnAttachmentUnequip(CBattleEntity* PEntity, CItemPuppet* attachment)
    {
        lua_prepscript("scripts/globals/abilities/pets/attachments/%s.lua", attachment->getName());

        if (prepFile(File, "onUnequip"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PEntity);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onUnequip: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        return 0;
    }

    int32 OnManeuverGain(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers)
    {
        lua_prepscript("scripts/globals/abilities/pets/attachments/%s.lua", attachment->getName());

        if (prepFile(File, "onManeuverGain"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PEntity);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushinteger(LuaHandle, maneuvers);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onManeuverGain: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    int32 OnManeuverLose(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers)
    {
        lua_prepscript("scripts/globals/abilities/pets/attachments/%s.lua", attachment->getName());

        if (prepFile(File, "onManeuverLose"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PEntity);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushinteger(LuaHandle, maneuvers);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onManeuverLose: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    int32 OnUpdateAttachment(CBattleEntity* PEntity, CItemPuppet* attachment, uint8 maneuvers)
    {
        lua_prepscript("scripts/globals/abilities/pets/attachments/%s.lua", attachment->getName());

        if (prepFile(File, "onUpdate"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PEntity);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushinteger(LuaHandle, maneuvers);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onUpdate: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        /*
        lua_prepscript("scripts/globals/items/%s.lua", PItem->getName());

        if (prepFile(File, "onItemCheck"))
        {
            return { 56, 0, 0 };
        }

        CLuaBaseEntity LuaBaseEntityTarget(PTarget);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntityTarget);
        CLuaBaseEntity LuaBaseEntityCaster(PCaster);

        lua_pushinteger(LuaHandle, static_cast<uint32>(param));

        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntityCaster);

        if (lua_pcall(LuaHandle, 3, 3, 0))
        {
            ShowError("luautils::onItemCheck: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return { 56, 0, 0 };
        }

        uint32 messageId = (!lua_isnil(LuaHandle, -3) && lua_isnumber(LuaHandle, -3) ? (int32)lua_tonumber(LuaHandle, -3) : 0);
        uint32 param1    = (!lua_isnil(LuaHandle, -2) && lua_isnumber(LuaHandle, -2) ? (int32)lua_tonumber(LuaHandle, -2) : 0);
        uint32 param2    = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 3);

        return { messageId, param1, param2 };
        */
        return { 0, 0, 0 };
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
        /*
        lua_prepscript("scripts/globals/items/%s.lua", PItem->getName());

        if (prepFile(File, "onItemUse"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PTarget);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onItemUse: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        */
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

    /************************************************************************
     *                                                                       *
     *  Чтение заклинаний                                                    *
     *                                                                       *
     ************************************************************************/

    uint32 OnSpellCast(CBattleEntity* PCaster, CBattleEntity* PTarget, CSpell* PSpell)
    {
        if (PSpell == nullptr)
        {
            ShowError("luautils::OnSpellCast: Spell not found!\n");
        }

        auto filename = fmt::format(PSpell->getSpellGroup() == SPELLGROUP_BLUE    ? "scripts/globals/spells/bluemagic/{}.lua"
                                    : PSpell->getSpellGroup() == SPELLGROUP_TRUST ? "scripts/globals/spells/trust/{}.lua"
                                                                                  : "scripts/globals/spells/{}.lua",
                                                                                    PSpell->getName());

        auto onSpellCast = loadFunctionFromFile("onSpellCast", filename);
        if (!onSpellCast.valid())
        {
            return 0;
        }

        auto result = onSpellCast(CLuaBaseEntity(PCaster), CLuaBaseEntity(PTarget), CLuaSpell(PSpell));
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onSpellCast: %s\n", err.what());
            return 0;
        }

        uint32 retVal = result.return_count() ? result.get<int32>() : 0;
        return retVal;
    }

    /************************************************************************
     *                                                                       *
     *  Чтение заклинаний                                                    *
     *                                                                       *
     ************************************************************************/

    int32 OnSpellPrecast(CBattleEntity* PCaster, CSpell* PSpell)
    {
        if (PCaster->objtype == TYPE_MOB)
        {
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
        }
        return 0;
    }

    std::optional<SpellID> OnMonsterMagicPrepare(CBattleEntity* PCaster, CBattleEntity* PTarget)
    {
        /*
        TPZ_DEBUG_BREAK_IF(PCaster == nullptr || PTarget == nullptr);

        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PCaster->loc.zone->GetName(), PCaster->GetName());

        if (prepFile(File, "onMonsterMagicPrepare"))
        {
            return {};
        }

        CLuaBaseEntity LuaMobEntity(PCaster);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        CLuaBaseEntity LuaTargetEntity(PTarget);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaTargetEntity);

        if (lua_pcall(LuaHandle, 2, 1, 0))
        {
            ShowError("luautils::onMonsterMagicPrepare: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return {};
        }
        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 1);
        if (retVal > 0)
        {
            return static_cast<SpellID>(retVal);
        }
        */
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
        /*
        TPZ_DEBUG_BREAK_IF(PSpell == nullptr);

        PTarget->PAI->EventHandler.triggerListener("MAGIC_TAKE", PTarget, PCaster, PSpell);

        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PTarget->loc.zone->GetName(), PTarget->GetName());

        if (prepFile(File, "onMagicHit"))
        {
            return 0;
        }

        CLuaBaseEntity LuaCasterEntity(PCaster);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaCasterEntity);

        CLuaBaseEntity LuaTargetEntity(PTarget);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaTargetEntity);

        CLuaSpell LuaSpell(PSpell);
        //Lunar<CLuaSpell>::push(LuaHandle, &LuaSpell);

        if (lua_pcall(LuaHandle, 3, 1, 0))
        {
            ShowError("luautils::onMagicHit: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 1);
        return retVal;
        */
        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Called when mob is struck by a Weaponskill                           *
     *                                                                       *
     ************************************************************************/

    int32 OnWeaponskillHit(CBattleEntity* PMob, CBaseEntity* PAttacker, uint16 PWeaponskill)
    {
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
        /*
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);

        if (PMob->objtype == TYPE_MOB)
        {
            lua_prepscript("scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

            lua_pushnil(LuaHandle);
            lua_setglobal(LuaHandle, "mixins");
            lua_pushnil(LuaHandle);
            lua_setglobal(LuaHandle, "mixinOptions");

            // remove any previous definition of the global "mixins"

            auto ret = luaL_loadfile(LuaHandle, (const char*)File);
            if (ret)
            {
                lua_pop(LuaHandle, 1);
                return -1;
            }

            ret = lua_pcall(LuaHandle, 0, 0, 0);
            if (ret)
            {
                ShowError("luautils::%s: %s\n", "applyMixins", lua_tostring(LuaHandle, -1));
                lua_pop(LuaHandle, 1);
                return -1;
            }

            // get the function "applyMixins"
            lua_getglobal(LuaHandle, "applyMixins");
            if (lua_isnil(LuaHandle, -1))
            {
                lua_pop(LuaHandle, 1);
                return -1;
            }

            CLuaBaseEntity LuaMobEntity(PMob);
            //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

            // get the parameter "mixins"
            lua_getglobal(LuaHandle, "mixins");
            if (lua_isnil(LuaHandle, -1))
            {
                lua_pop(LuaHandle, 3);
                return -1;
            }
            // get the parameter "mixinOptions" (optional)
            lua_getglobal(LuaHandle, "mixinOptions");

            if (lua_pcall(LuaHandle, 3, 0, 0))
            {
                ShowError("luautils::applyMixins: %s\n", lua_tostring(LuaHandle, -1));
                lua_pop(LuaHandle, 1);
            }
        }
        */
        return 0;
    }

    int32 ApplyZoneMixins(CBaseEntity* PMob)
    {
        /*
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);

        if (PMob->objtype == TYPE_MOB)
        {
            if (PMob->objtype == TYPE_PET)
            {
                CPetEntity* PPet = (CPetEntity*)PMob;

                if (PPet->PMaster != nullptr && PPet->PMaster->objtype != TYPE_PC)
                {
                    lua_prepscript("scripts/mixins/zones/%s.lua", PMob->loc.zone->GetName());

                    lua_pushnil(LuaHandle);
                    lua_setglobal(LuaHandle, "mixins");
                    lua_pushnil(LuaHandle);
                    lua_setglobal(LuaHandle, "mixinOptions");

                    // remove any previous definition of the global "mixins"

                    auto ret = luaL_loadfile(LuaHandle, (const char*)File);
                    if (ret)
                    {
                        lua_pop(LuaHandle, 1);
                        return -1;
                    }

                    ret = lua_pcall(LuaHandle, 0, 0, 0);
                    if (ret)
                    {
                        ShowError("luautils::%s: %s\n", "applyMixins", lua_tostring(LuaHandle, -1));
                        lua_pop(LuaHandle, 1);
                        return -1;
                    }

                    // get the function "applyMixins"
                    lua_getglobal(LuaHandle, "applyMixins");
                    if (lua_isnil(LuaHandle, -1))
                    {
                        lua_pop(LuaHandle, 1);
                        return -1;
                    }

                    CLuaBaseEntity LuaMobEntity(PMob);
                    //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

                    // get the parameter "mixins"
                    lua_getglobal(LuaHandle, "mixins");
                    if (lua_isnil(LuaHandle, -1))
                    {
                        lua_pop(LuaHandle, 3);
                        return -1;
                    }
                    // get the parameter "mixinOptions" (optional)
                    lua_getglobal(LuaHandle, "mixinOptions");

                    if (lua_pcall(LuaHandle, 3, 0, 0))
                    {
                        ShowError("luautils::applyMixins: %s\n", lua_tostring(LuaHandle, -1));
                        lua_pop(LuaHandle, 1);
                    }
                }
            }
            else
            {
                lua_prepscript("scripts/mixins/zones/%s.lua", PMob->loc.zone->GetName());

                lua_pushnil(LuaHandle);
                lua_setglobal(LuaHandle, "mixins");
                lua_pushnil(LuaHandle);
                lua_setglobal(LuaHandle, "mixinOptions");

                // remove any previous definition of the global "mixins"

                auto ret = luaL_loadfile(LuaHandle, (const char*)File);
                if (ret)
                {
                    lua_pop(LuaHandle, 1);
                    return -1;
                }

                ret = lua_pcall(LuaHandle, 0, 0, 0);
                if (ret)
                {
                    ShowError("luautils::%s: %s\n", "applyMixins", lua_tostring(LuaHandle, -1));
                    lua_pop(LuaHandle, 1);
                    return -1;
                }

                // get the function "applyMixins"
                lua_getglobal(LuaHandle, "applyMixins");
                if (lua_isnil(LuaHandle, -1))
                {
                    lua_pop(LuaHandle, 1);
                    return -1;
                }

                CLuaBaseEntity LuaMobEntity(PMob);
                //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

                // get the parameter "mixins"
                lua_getglobal(LuaHandle, "mixins");
                if (lua_isnil(LuaHandle, -1))
                {
                    lua_pop(LuaHandle, 3);
                    return -1;
                }
                // get the parameter "mixinOptions" (optional)
                lua_getglobal(LuaHandle, "mixinOptions");

                if (lua_pcall(LuaHandle, 3, 0, 0))
                {
                    ShowError("luautils::applyMixins: %s\n", lua_tostring(LuaHandle, -1));
                    lua_pop(LuaHandle, 1);
                }
            }
        }
        */
        return 0;
    }

    int32 OnPath(CBaseEntity* PEntity)
    {
        /*
        TracyZoneScoped;
        TPZ_DEBUG_BREAK_IF(PEntity == nullptr);

        if (PEntity->objtype != TYPE_PC)
        {
            lua_prepscript("scripts/zones/%s/%s/%s.lua", PEntity->loc.zone->GetName(), (PEntity->objtype == TYPE_MOB ? "mobs" : "npcs"), PEntity->GetName());

            if (prepFile(File, "onPath"))
            {
                return -1;
            }

            CLuaBaseEntity LuaMobEntity(PEntity);
            //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

            if (lua_pcall(LuaHandle, 1, 0, 0))
            {
                ShowError("luautils::onPath: %s\n", lua_tostring(LuaHandle, -1));
                lua_pop(LuaHandle, 1);
                return -1;
            }
        }
        */
        return 0;
    }

    int32 OnBattlefieldHandlerInitialise(CZone* PZone)
    {
        TPZ_DEBUG_BREAK_IF(PZone == nullptr);

        lua.load_file("scripts/globals/battlefield.lua");

        int32 MaxAreas = 3;

        if (!lua["onBattlefieldHandlerInitialise"].valid())
        {
            return MaxAreas;
        }

        CLuaZone LuaZone(PZone);

        auto result = lua["onBattlefieldHandlerInitialise"](LuaZone);
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
        /*
        TPZ_DEBUG_BREAK_IF(PBattlefield == nullptr);

        lua_prepscript("scripts/zones/%s/bcnms/%s.lua", PBattlefield->GetZone()->GetName(), PBattlefield->GetName().c_str());

        if (prepFile(File, "onBattlefieldInitialise"))
        {
            return -1;
        }

        CLuaBattlefield LuaBattlefield(PBattlefield);
        //Lunar<CLuaBattlefield>::push(LuaHandle, &LuaBattlefield);

        if (lua_pcall(LuaHandle, 1, LUA_MULTRET, 0))
        {
            ShowError("luautils::onBattlefieldInitialise: %s\n", lua_tostring(LuaHandle, -1));
            return -1;
        }
        */
        return 0;
    }

    int32 OnBattlefieldTick(CBattlefield* PBattlefield)
    {
        /*
        TPZ_DEBUG_BREAK_IF(PBattlefield == nullptr);

        lua_prepscript("scripts/zones/%s/bcnms/%s.lua", PBattlefield->GetZone()->GetName(), PBattlefield->GetName().c_str());

        if (prepFile(File, "onBattlefieldTick"))
        {
            ShowError("luautils::onBattlefieldTick: Unable to find onBattlefieldTick function for %s\n", &File[0]);
            return -1;
        }

        CLuaBattlefield LuaBattlefield(PBattlefield);
        //Lunar<CLuaBattlefield>::push(LuaHandle, &LuaBattlefield);
        lua_pushinteger(LuaHandle, (lua_Integer)std::chrono::duration_cast<std::chrono::seconds>(PBattlefield->GetTimeInside()).count());

        if (lua_pcall(LuaHandle, 2, LUA_MULTRET, 0))
        {
            ShowError("luautils::onBattlefieldTick: %s\n", lua_tostring(LuaHandle, -1));
            return -1;
        }
        */
        return 0;
    }

    int32 OnBattlefieldStatusChange(CBattlefield* PBattlefield)
    {
        /*
        TPZ_DEBUG_BREAK_IF(PBattlefield == nullptr);

        lua_prepscript("scripts/zones/%s/bcnms/%s.lua", PBattlefield->GetZone()->GetName(), PBattlefield->GetName().c_str());

        if (prepFile(File, "onBattlefieldStatusChange"))
        {
            return -1;
        }

        CLuaBattlefield LuaBattlefield(PBattlefield);
        //Lunar<CLuaBattlefield>::push(LuaHandle, &LuaBattlefield);
        lua_pushinteger(LuaHandle, PBattlefield->GetStatus());

        if (lua_pcall(LuaHandle, 2, LUA_MULTRET, 0))
        {
            ShowError("luautils::onBattlefieldStatusChange: %s\n", lua_tostring(LuaHandle, -1));
            return -1;
        }
        */
        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Сalled when a monster engages a target for the first time            *
     *                                                                       *
     ************************************************************************/

    int32 OnMobEngaged(CBaseEntity* PMob, CBaseEntity* PTarget)
    {
        /*
        TPZ_DEBUG_BREAK_IF(PTarget == nullptr || PMob == nullptr);

        CLuaBaseEntity LuaMobEntity(PMob);
        CLuaBaseEntity LuaKillerEntity(PTarget);

        int8 File[255];
        PMob->objtype == TYPE_PET ? snprintf((char*)File, sizeof(File), "scripts/globals/pets/%s.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str())
                                  : snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (PTarget->objtype == TYPE_PC)
        {
            ((CCharEntity*)PTarget)->m_event.reset();
            ((CCharEntity*)PTarget)->m_event.Target = PMob;
            ((CCharEntity*)PTarget)->m_event.Script.insert(0, (const char*)File);
        }

        if (prepFile(File, "onMobEngaged"))
        {
            return -1;
        }

        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaKillerEntity);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onMobEngaged: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        */
        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Calls a lua script when a mob has disengaged from a target   *       *
     *                                                                       *
     ************************************************************************/

    int32 OnMobDisengage(CBaseEntity* PMob)
    {
        /*
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);

        uint8 weather = PMob->loc.zone->GetWeather();

        int8 File[255];
        PMob->objtype == TYPE_PET ? snprintf((char*)File, sizeof(File), "scripts/globals/pets/%s.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str())
                                  : snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (prepFile(File, "onMobDisengage"))
        {
            return -1;
        }

        CLuaBaseEntity LuaMobEntity(PMob);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        lua_pushinteger(LuaHandle, weather);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onMobDisengage: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        */
        return 0;
    }

    int32 OnMobDrawIn(CBaseEntity* PMob, CBaseEntity* PTarget)
    {
        /*
        TPZ_DEBUG_BREAK_IF(PTarget == nullptr || PMob == nullptr);

        CLuaBaseEntity LuaMobEntity(PMob);
        CLuaBaseEntity LuaKillerEntity(PTarget);

        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (PTarget->objtype == TYPE_PC)
        {
            ((CCharEntity*)PTarget)->m_event.reset();
            ((CCharEntity*)PTarget)->m_event.Target = PMob;
            ((CCharEntity*)PTarget)->m_event.Script.insert(0, (const char*)File);
        }

        if (prepFile(File, "onMobDrawIn"))
        {
            return -1;
        }

        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaKillerEntity);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onMobDrawIn: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        */
        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  Сalled every 3 sec when a player fight monster                       *
     *                                                                       *
     ************************************************************************/

    int32 OnMobFight(CBaseEntity* PMob, CBaseEntity* PTarget)
    {
        /*
        TracyZoneScoped;
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);
        TPZ_DEBUG_BREAK_IF(PTarget == nullptr || PTarget->objtype == TYPE_NPC);

        CLuaBaseEntity LuaMobEntity(PMob);
        CLuaBaseEntity LuaKillerEntity(PTarget);

        int8 File[255];
        PMob->objtype == TYPE_PET ? snprintf((char*)File, sizeof(File), "scripts/globals/pets/%s.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str())
                                  : snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (prepFile(File, "onMobFight"))
        {
            return -1;
        }

        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaKillerEntity);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onMobFight: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        */
        return 0;
    }

    int32 OnCriticalHit(CBattleEntity* PMob, CBattleEntity* PAttacker)
    {
        /*
        TPZ_DEBUG_BREAK_IF(PMob == nullptr || PMob->objtype != TYPE_MOB)

        CLuaBaseEntity LuaMobEntity(PMob);
        CLuaBaseEntity LuaKillerEntity(PAttacker);

        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (prepFile(File, "onCriticalHit"))
        {
            return -1;
        }

        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
        if (PAttacker)
        {
            //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaKillerEntity);
        }
        else
        {
            lua_pushnil(LuaHandle);
        }

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onCriticalHit: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        */
        return 0;
    }

    /************************************************************************
     *                                                                       *
     *  The script is executed after the death of any monster in the game    *
     *                                                                       *
     ************************************************************************/

    int32 OnMobDeath(CBaseEntity* PMob, CBaseEntity* PKiller)
    {
        /*
        TracyZoneScoped;
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);

        CCharEntity* PChar = dynamic_cast<CCharEntity*>(PKiller);

        if (PChar && PMob->objtype == TYPE_MOB)
        {
            // onMobDeathEx
            lua_prepscript("scripts/globals/mobs.lua");

            PChar->ForAlliance([PMob, PChar, &File](CBattleEntity* PMember) {
                if (PMember->getZone() == PChar->getZone())
                {
                    if (prepFile(File, "onMobDeathEx"))
                    {
                        return;
                    }

                    CLuaBaseEntity LuaMobEntity(PMob);
                    CLuaBaseEntity LuaAllyEntity(PMember);
                    bool           isKiller          = PMember == PChar;
                    bool           isWeaponSkillKill = PChar->getWeaponSkillKill();

                    //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
                    //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaAllyEntity);
                    lua_pushboolean(LuaHandle, isKiller);

                    lua_pushboolean(LuaHandle, isWeaponSkillKill);
                    // lua_pushboolean(LuaHandle, isMagicKill);
                    // lua_pushboolean(LuaHandle, isPetKill);
                    // Todo: look at better way do do these than additional bools...

                    if (lua_pcall(LuaHandle, 4, 0, 0))
                    {
                        ShowError("luautils::onMobDeathEx: %s\n", lua_tostring(LuaHandle, -1));
                        lua_pop(LuaHandle, 1);
                    }
                }
            });

            // onMobDeath
            memset(File, 0, sizeof(File));

            lua_pushnil(LuaHandle);
            lua_setglobal(LuaHandle, "onMobDeath");

            snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

            PChar->ForAlliance([PMob, PChar, &File](CBattleEntity* PPartyMember) {
                CCharEntity* PMember = (CCharEntity*)PPartyMember;
                if (PMember->getZone() == PChar->getZone())
                {
                    CLuaBaseEntity LuaMobEntity(PMob);
                    CLuaBaseEntity LuaAllyEntity(PMember);
                    bool           isKiller = PMember == PChar;

                    PMember->m_event.reset();
                    PMember->m_event.Target = PMob;
                    PMember->m_event.Script.insert(0, (const char*)File);

                    if (luaL_loadfile(LuaHandle, (const char*)File) || lua_pcall(LuaHandle, 0, 0, 0))
                    {
                        lua_pop(LuaHandle, 1);
                        return;
                    }

                    lua_getglobal(LuaHandle, "onMobDeath");
                    if (lua_isnil(LuaHandle, -1))
                    {
                        ShowError("luautils::onMobDeath (%s): undefined procedure onMobDeath\n", File);
                        lua_pop(LuaHandle, 1);
                        return;
                    }

                    //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
                    if (PMember)
                    {
                        CLuaBaseEntity LuaAllyEntity(PMember);
                        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaAllyEntity);
                        lua_pushboolean(LuaHandle, isKiller);
                    }
                    else
                    {
                        lua_pushnil(LuaHandle);
                    }

                    if (lua_pcall(LuaHandle, 3, 0, 0))
                    {
                        ShowError("luautils::onMobDeath: %s\n", lua_tostring(LuaHandle, -1));
                        lua_pop(LuaHandle, 1);
                        return;
                    }
                }
            });
        }
        else
        {
            int8 File[255];
            switch (PMob->objtype)
            {
                case TYPE_MOB:
                    snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());
                    break;
                case TYPE_PET:
                    snprintf((char*)File, sizeof(File), "scripts/globals/pets/%s.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str());
                    break;
                case TYPE_TRUST:
                    snprintf((char*)File, sizeof(File), "scripts/globals/spells/trust/%s.lua", PMob->GetName());
                    break;
                default:
                    ShowWarning("luautils::onMobDeath (%d): unknown objtype\n", PMob->objtype);
                    break;
            }

            lua_pushnil(LuaHandle);
            lua_setglobal(LuaHandle, "onMobDeath");

            CLuaBaseEntity LuaMobEntity(PMob);

            if (luaL_loadfile(LuaHandle, (const char*)File) || lua_pcall(LuaHandle, 0, 0, 0))
            {
                lua_pop(LuaHandle, 1);
                return -1;
            }

            lua_getglobal(LuaHandle, "onMobDeath");
            if (lua_isnil(LuaHandle, -1))
            {
                ShowError("luautils::onMobDeath (%s): undefined procedure onMobDeath\n", File);
                lua_pop(LuaHandle, 1);
                return -1;
            }

            //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
            lua_pushnil(LuaHandle);
            lua_pushnil(LuaHandle);
            lua_pushboolean(LuaHandle, true);

            if (lua_pcall(LuaHandle, 4, 0, 0))
            {
                ShowError("luautils::onMobDeath: %s\n", lua_tostring(LuaHandle, -1));
                lua_pop(LuaHandle, 1);
                return -1;
            }
        }
        */
        return 0;
    }

    /************************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnMobSpawn(CBaseEntity* PMob)
    {
        /*
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);

        int8 File[255];
        switch (PMob->objtype)
        {
            case TYPE_MOB:
                snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());
                break;
            case TYPE_PET:
                snprintf((char*)File, sizeof(File), "scripts/globals/pets/%s.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str());
                break;
            case TYPE_TRUST:
                snprintf((char*)File, sizeof(File), "scripts/globals/spells/trust/%s.lua", PMob->GetName());
                break;
            default:
                ShowWarning("luautils::onMobSpawn (%d): unknown objtype\n", PMob->objtype);
                break;
        }

        if (prepFile(File, "onMobSpawn"))
        {
            return -1;
        }

        CLuaBaseEntity LuaMobEntity(PMob);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onMobSpawn: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        */
        return 0;
    }

    int32 OnMobRoamAction(CBaseEntity* PMob)
    {
        TPZ_DEBUG_BREAK_IF(PMob == nullptr || PMob->objtype != TYPE_MOB)

        CLuaBaseEntity LuaMobEntity(PMob);

        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (prepFile(File, "onMobRoamAction"))
        {
            return -1;
        }

        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onMobRoamAction: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    /************************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

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

    /************************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnMobDespawn(CBaseEntity* PMob)
    {
        /*
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);

        int8 File[255];
        switch (PMob->objtype)
        {
            case TYPE_MOB:
                snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());
                break;
            case TYPE_PET:
                snprintf((char*)File, sizeof(File), "scripts/globals/pets/%s.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str());
                break;
            case TYPE_TRUST:
                snprintf((char*)File, sizeof(File), "scripts/globals/spells/trust/%s.lua", PMob->GetName());
                break;
            default:
                ShowWarning("luautils::onMobDespawn (%d): unknown objtype\n", PMob->objtype);
                break;
        }

        if (prepFile(File, "onMobDespawn"))
        {
            return -1;
        }

        CLuaBaseEntity LuaMobEntity(PMob);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onMobDespawn: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        */
        return 0;
    }

    /************************************************************************
     *   OnGameDayAutomatisation()                                           *
     *   used for creating action of npc every game day                      *
     *                                                                       *
     ************************************************************************/

    int32 OnGameDay(CZone* PZone)
    {
        lua_prepscript("scripts/zones/%s/Zone.lua", PZone->GetName());

        if (prepFile(File, "onGameDay"))
        {
            return -1;
        }

        if (lua_pcall(LuaHandle, 0, 0, 0))
        {
            ShowError("luautils::onGameDay: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        /*
        TracyZoneScoped;
        lua.script_file(fmt::format("scripts/zones/{}/Zone.lua", PZone->GetName()));

        if (!lua["onGameHour"].valid())
        {
            return -1;
        }

        CLuaZone LuaZone(PZone);

        if (auto result = lua["onGameHour"](LuaZone); !result.valid())
        {
            sol::error err = result;
            ShowError("luautils::onGameHour: %s\n", err.what());
            return -1;
        }
        */
        return 0;
    }

    int32 OnZoneWeatherChange(uint16 ZoneID, uint8 weather)
    {
        /*
        lua_prepscript("scripts/zones/{}/Zone.lua", zoneutils::GetZone(ZoneID)->GetName());

        if (prepFile(File, "onZoneWeatherChange"))
        {
            return -1;
        }

        lua_pushinteger(LuaHandle, weather);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::OnZoneWeatherChange: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        */
        return 0;
    }

    int32 OnTOTDChange(uint16 ZoneID, uint8 TOTD)
    {
        /*
        lua_prepscript("scripts/zones/{}/Zone.lua", zoneutils::GetZone(ZoneID)->GetName());

        if (prepFile(File, "onTOTDChange"))
        {
            return -1;
        }

        lua_pushinteger(LuaHandle, TOTD);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::OnTOTDChange: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        */
        return 0;
    }

    /************************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    std::tuple<int32, uint8, uint8> OnUseWeaponSkill(CBattleEntity* PChar, CBaseEntity* PMob, CWeaponSkill* wskill, uint16 tp, bool primary, action_t& action,
                                                     CBattleEntity* taChar)
    {
        lua_prepscript("scripts/globals/weaponskills/%s.lua", wskill->getName());

        if (prepFile(File, "onUseWeaponSkill"))
        {
            return std::tuple<int32, uint8, uint8>();
        }

        sol::stack::push(LuaHandle, CLuaBaseEntity(PChar));

        lua_pushinteger(LuaHandle, wskill->getID());
        lua_pushnumber(LuaHandle, tp);
        lua_pushboolean(LuaHandle, primary);

        sol::stack::push(LuaHandle, CLuaAction(&action));

        if (taChar == nullptr)
        {
            lua_pushnil(LuaHandle);
        }
        else
        {
            sol::stack::push(LuaHandle, CLuaBaseEntity(taChar));
        }

        if (lua_pcall(LuaHandle, 7, 4, 0))
        {
            ShowError("luautils::onUseWeaponSkill: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return std::tuple<int32, uint8, uint8>();
        }

        uint8 tpHitsLanded    = (uint8)lua_tonumber(LuaHandle, -4);
        uint8 extraHitsLanded = (uint8)lua_tonumber(LuaHandle, -3);
        bool  criticalHit     = lua_toboolean(LuaHandle, -2);
        int32 dmg             = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);

        if (criticalHit)
        {
            luautils::OnCriticalHit((CBattleEntity*)PMob, (CBattleEntity*)PChar);
        }

        lua_pop(LuaHandle, 4);
        return std::make_tuple(dmg, tpHitsLanded, extraHitsLanded);
    }

    /***********************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnMobWeaponSkill(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill, action_t* action)
    {
        /*
        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (!prepFile(File, "onMobWeaponSkill"))
        {
            CLuaBaseEntity LuaBaseEntity(PTarget);
            //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

            CLuaBaseEntity LuaMobEntity(PMob);
            //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

            CLuaMobSkill LuaMobSkill(PMobSkill);
            //Lunar<CLuaMobSkill>::push(LuaHandle, &LuaMobSkill);

            CLuaAction LuaAction(action);
            //Lunar<CLuaAction>::push(LuaHandle, &LuaAction);

            if (lua_pcall(LuaHandle, 4, 0, 0))
            {
                ShowError("luautils::onMobWeaponSkill: %s\n", lua_tostring(LuaHandle, -1));
                lua_pop(LuaHandle, 1);
            }
        }

        snprintf((char*)File, sizeof(File), "scripts/globals/mobskills/%s.lua", PMobSkill->getName());

        if (prepFile(File, "onMobWeaponSkill"))
        {
            return 0;
        }
        CLuaBaseEntity LuaBaseEntity(PTarget);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);
        CLuaBaseEntity LuaMobEntity(PMob);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
        CLuaMobSkill LuaMobSkill(PMobSkill);
        //Lunar<CLuaMobSkill>::push(LuaHandle, &LuaMobSkill);

        if (lua_pcall(LuaHandle, 3, 1, 0))
        {
            ShowError("luautils::onMobWeaponSkill: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        int32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 1);
        return retVal;
        */
        return 0;
    }

    /***********************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnMobSkillCheck(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill)
    {
        /*
        lua_prepscript("scripts/globals/mobskills/%s.lua", PMobSkill->getName());

        if (prepFile(File, "onMobSkillCheck"))
        {
            return 1;
        }

        CLuaBaseEntity LuaBaseEntity(PTarget);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaMobEntity(PMob);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        CLuaMobSkill LuaMobSkill(PMobSkill);
        //Lunar<CLuaMobSkill>::push(LuaHandle, &LuaMobSkill);

        if (lua_pcall(LuaHandle, 3, 1, 0))
        {
            ShowError("luautils::onMobSkillCheck (%s): %s\n", PMobSkill->getName(), lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 1;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : -5);
        lua_pop(LuaHandle, 1);
        return retVal;
        */
        return 0;
    }

    int32 OnMobAutomatonSkillCheck(CBaseEntity* PTarget, CAutomatonEntity* PAutomaton, CMobSkill* PMobSkill)
    {
        /*
        lua_prepscript("scripts/globals/abilities/pets/%s.lua", PMobSkill->getName());

        if (prepFile(File, "onMobSkillCheck"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PTarget);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaMobEntity(PAutomaton);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        CLuaMobSkill LuaMobSkill(PMobSkill);
        // Lunar<CLuaMobSkill>::push(LuaHandle, &LuaMobSkill);

        if (lua_pcall(LuaHandle, 3, 1, 0))
        {
            ShowError("luautils::OnMobAutomatonSkillCheck (%s): %s\n", PMobSkill->getName(), lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : -5);
        lua_pop(LuaHandle, 1);
        return retVal;
        */
        return 0;
    }

    /***********************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnMagicCastingCheck(CBaseEntity* PChar, CBaseEntity* PTarget, CSpell* PSpell)
    {

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
        /*
        TPZ_DEBUG_BREAK_IF(PAbility == nullptr);

        char filePath[40] = "scripts/globals/abilities/%s.lua";

        if (PAbility->isPetAbility())
        {
            memcpy(filePath, "scripts/globals/abilities/pets/%s.lua", 38);
        }

        lua_prepscript(filePath, PAbility->getName());

        lua_pushnil(LuaHandle);
        lua_setglobal(LuaHandle, "onAbilityCheck");

        auto ret = luaL_loadfile(LuaHandle, (const char*)File);
        if (ret)
        {
            if (ret != LUA_ERRFILE)
            {
                lua_pop(LuaHandle, 1);
                ShowError("luautils::%s: %s\n", "onAbilityCheck", lua_tostring(LuaHandle, -1));
                return 87;
            }
            else
            {
                lua_pop(LuaHandle, 1);
                return 0;
            }
        }

        ret = lua_pcall(LuaHandle, 0, 0, 0);
        if (ret)
        {
            ShowError("luautils::%s: %s\n", "onAbilityCheck", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 87;
        }

        lua_getglobal(LuaHandle, "onAbilityCheck");
        if (lua_isnil(LuaHandle, -1))
        {
            lua_pop(LuaHandle, 1);
            return 87;
        }

        CLuaBaseEntity LuaCharEntity(PChar);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaCharEntity);

        CLuaBaseEntity LuaBaseEntity(PTarget);
        //Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaAbility LuaAbility(PAbility);
        //Lunar<CLuaAbility>::push(LuaHandle, &LuaAbility);

        if (lua_pcall(LuaHandle, 3, 2, 0))
        {
            ShowError("luautils::onAbilityCheck (%s): %s\n", PAbility->getName(), lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 87;
        }

        if ((!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0) != 0)
        {
            *PMsgTarget = (CBaseEntity*)PTarget;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -2) && lua_isnumber(LuaHandle, -2) ? (int32)lua_tonumber(LuaHandle, -2) : -5);
        lua_pop(LuaHandle, 2);
        return retVal;
        */
        return 0;
    }

    /***********************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnPetAbility(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill, CBaseEntity* PMobMaster, action_t* action)
    {
        lua_prepscript("scripts/globals/abilities/pets/%s.lua", PMobSkill->getName());

        if (prepFile(File, "onPetAbility"))
        {
            return 0;
        }

        CLuaBaseEntity LuaBaseEntity(PTarget);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaMobEntity(PMob);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        CLuaMobSkill LuaMobSkill(PMobSkill);
        // Lunar<CLuaMobSkill>::push(LuaHandle, &LuaMobSkill);

        CLuaBaseEntity LuaMasterEntity(PMobMaster);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMasterEntity);

        CLuaAction LuaAction(action);
        // Lunar<CLuaAction>::push(LuaHandle, &LuaAction);

        if (lua_pcall(LuaHandle, 5, 1, 0))
        {
            ShowError("luautils::onPetAbility: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        // Bloodpact Skillups
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

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 1);
        return retVal;
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

    /************************************************************************
     *                                                                       *
     *                                                                       *
     *                                                                       *
     ************************************************************************/

    int32 OnInstanceZoneIn(CCharEntity* PChar, CInstance* PInstance)
    {
        CZone* PZone = PInstance->GetZone();

        lua_prepscript("scripts/zones/%s/Zone.lua", PZone->GetName());

        if (prepFile(File, "onInstanceZoneIn"))
        {
            return -1;
        }

        CLuaBaseEntity LuaEntity(PChar);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaEntity);

        CLuaInstance LuaInstance(PInstance);
        // Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onInstanceZoneIn: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    void AfterInstanceRegister(CBaseEntity* PChar)
    {
        TPZ_DEBUG_BREAK_IF(!PChar->PInstance);

        lua_prepscript("scripts/zones/%s/instances/%s.lua", PChar->loc.zone->GetName(), PChar->PInstance->GetName());

        if (prepFile(File, "afterInstanceRegister"))
        {
            return;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::afterInstanceRegister: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return;
        }
    }

    int32 OnInstanceLoadFailed(CZone* PZone)
    {
        lua_prepscript("scripts/zones/%s/Zone.lua", PZone->GetName());

        if (prepFile(File, "onInstanceLoadFailed"))
        {
            return -1;
        }

        if (lua_pcall(LuaHandle, 0, 1, 0))
        {
            ShowError("luautils::onInstanceLoadFailed: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 1);
        return retVal;
    }

    int32 OnInstanceTimeUpdate(CZone* PZone, CInstance* PInstance, uint32 time)
    {
        lua_prepscript("scripts/zones/%s/instances/%s.lua", PZone->GetName(), PInstance->GetName());

        if (prepFile(File, "onInstanceTimeUpdate"))
        {
            return -1;
        }

        CLuaInstance LuaInstance(PInstance);
        // Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

        lua_pushinteger(LuaHandle, time);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onInstanceTimeUpdate: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        return 0;
    }

    int32 OnInstanceFailure(CInstance* PInstance)
    {
        lua_prepscript("scripts/zones/%s/instances/%s.lua", PInstance->GetZone()->GetName(), PInstance->GetName());

        if (prepFile(File, "onInstanceFailure"))
        {
            return -1;
        }

        CLuaInstance LuaInstance(PInstance);
        // Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onInstanceFailure: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
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
        lua_pushnil(LuaHandle);
        lua_setglobal(LuaHandle, "onInstanceCreated");

        int8 File[255];
        if (luaL_loadfile(LuaHandle, PChar->m_event.Script.c_str()) || lua_pcall(LuaHandle, 0, 0, 0))
        {
            memset(File, 0, sizeof(File));
            snprintf((char*)File, sizeof(File), "scripts/zones/%s/Zone.lua", PChar->loc.zone->GetName());

            if (luaL_loadfile(LuaHandle, (const char*)File) || lua_pcall(LuaHandle, 0, 0, 0))
            {
                ShowError("luautils::onInstanceCreated %s\n", lua_tostring(LuaHandle, -1));
                lua_pop(LuaHandle, 1);
                return -1;
            }
        }

        lua_getglobal(LuaHandle, "onInstanceCreated");
        if (lua_isnil(LuaHandle, -1))
        {
            ShowError("luautils::onInstanceCreated: undefined procedure onInstanceCreated\n");
            lua_pop(LuaHandle, 1);
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaTargetEntity(PChar->m_event.Target);
        // Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaTargetEntity);

        if (PInstance)
        {
            CLuaInstance LuaInstance(PInstance);
            // Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);
        }
        else
        {
            lua_pushnil(LuaHandle);
        }

        if (lua_pcall(LuaHandle, 3, 0, 0))
        {
            ShowError("luautils::onInstanceCreated %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        lua_prepscript("scripts/zones/%s/instances/%s.lua", PInstance->GetZone()->GetName(), PInstance->GetName());

        if (prepFile(File, "onInstanceCreated"))
        {
            return -1;
        }

        CLuaInstance LuaInstance(PInstance);
        // Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onInstanceCreated %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    int32 OnInstanceProgressUpdate(CInstance* PInstance)
    {
        lua_prepscript("scripts/zones/%s/instances/%s.lua", PInstance->GetZone()->GetName(), PInstance->GetName());

        if (prepFile(File, "onInstanceProgressUpdate"))
        {
            return -1;
        }

        CLuaInstance LuaInstance(PInstance);
        // Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

        lua_pushinteger(LuaHandle, PInstance->GetProgress());

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onInstanceProgressUpdate %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    int32 OnInstanceStageChange(CInstance* PInstance)
    {
        lua_prepscript("scripts/zones/%s/instances/%s.lua", PInstance->GetZone()->GetName(), PInstance->GetName());

        if (prepFile(File, "onInstanceStageChange"))
        {
            return -1;
        }

        CLuaInstance LuaInstance(PInstance);
        // Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

        lua_pushinteger(LuaHandle, PInstance->GetStage());

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onInstanceStageChange %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    int32 OnInstanceComplete(CInstance* PInstance)
    {
        lua_prepscript("scripts/zones/%s/instances/%s.lua", PInstance->GetZone()->GetName(), PInstance->GetName());

        if (prepFile(File, "onInstanceComplete"))
        {
            return -1;
        }

        CLuaInstance LuaInstance(PInstance);
        // Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onInstanceComplete %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        PChar->m_event.Script.insert(0, filename.c_str());

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

    std::shared_ptr<CLuaItem> GetReadOnlyItem(uint32 id)
    {
        TracyZoneScoped;
        CItem* PItem = itemutils::GetItemPointer(id);
        return PItem ? std::make_shared<CLuaItem>(PItem) : nullptr;
    }

    std::shared_ptr<CLuaAbility> GetAbility(uint16 id)
    {
        TracyZoneScoped;
        CAbility* PAbility = ability::GetAbility(id);
        return PAbility ? std::make_shared<CLuaAbility>(PAbility) : nullptr;
    }

    std::shared_ptr<CLuaSpell> GetSpell(uint16 id)
    {
        TracyZoneScoped;
        CSpell* PSpell = spell::GetSpell(static_cast<SpellID>(id));
        return PSpell ? std::make_shared<CLuaSpell>(PSpell) : nullptr;
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

        sol::table nearPos;
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
