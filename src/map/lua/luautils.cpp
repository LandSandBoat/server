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

#include <unordered_map>

#include "luautils.h"
#include "lua_action.h"
#include "lua_battlefield.h"
#include "lua_region.h"
#include "lua_instance.h"
#include "lua_spell.h"
#include "lua_statuseffect.h"
#include "lua_mobskill.h"
#include "lua_trade_container.h"
#include "lua_zone.h"
#include "lua_item.h"

#include "../ability.h"
#include "../entities/baseentity.h"
#include "../utils/battleutils.h"
#include "../entities/charentity.h"
#include "../conquest_system.h"
#include "../map.h"
#include "../mobskill.h"
#include "../party.h"
#include "../alliance.h"
#include "../entities/mobentity.h"
#include "../spell.h"
#include "../weapon_skill.h"
#include "../vana_time.h"
#include "../utils/zoneutils.h"
#include "../timetriggers.h"
#include "../transport.h"
#include "../packets/action.h"
#include "../packets/char_update.h"
#include "../packets/entity_update.h"
#include "../packets/menu_raisetractor.h"
#include "../packets/entity_visual.h"
#include "../items/item_puppet.h"
#include "../entities/automatonentity.h"
#include "../utils/itemutils.h"
#include "../utils/charutils.h"
#include "../conquest_system.h"
#include "../weapon_skill.h"
#include "../status_effect_container.h"
#include "../instance.h"
#include "../ai/ai_container.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/death_state.h"
#include "../ai/states/inactive_state.h"
#include "../ai/states/raise_state.h"
#include "../ai/states/item_state.h"
#include "../ai/states/range_state.h"
#include "../ai/states/respawn_state.h"
#include "../ai/states/weaponskill_state.h"
#include "../ai/states/ability_state.h"
#include "../ai/states/mobskill_state.h"
#include "../ai/states/magic_state.h"
#include <optional>
#include "../battlefield.h"

namespace luautils
{
#define lua_prepscript(n,...) int8 File[255]; \
                              snprintf((char*)File, sizeof(File), n, ##__VA_ARGS__);
    lua_State*  LuaHandle = nullptr;

    bool contentRestrictionEnabled;
    std::unordered_map<std::string, bool> contentEnabledMap;

    /************************************************************************
    *                                                                       *
    *  Инициализация lua, пользовательских классов и глобальных функций     *
    *                                                                       *
    ************************************************************************/

    int32 init()
    {
        ShowStatus("luautils::init:lua initializing...");
        LuaHandle = luaL_newstate();
        luaL_openlibs(LuaHandle);

        lua_register(LuaHandle, "print", luautils::print);
        lua_register(LuaHandle, "GetNPCByID", luautils::GetNPCByID);
        lua_register(LuaHandle, "GetMobByID", luautils::GetMobByID);
        lua_register(LuaHandle, "WeekUpdateConquest", luautils::WeekUpdateConquest);
        lua_register(LuaHandle, "GetRegionOwner", luautils::GetRegionOwner);
        lua_register(LuaHandle, "GetRegionInfluence", luautils::GetRegionInfluence);
        lua_register(LuaHandle, "getNationRank", luautils::getNationRank);
        lua_register(LuaHandle, "getConquestBalance", luautils::getConquestBalance);
        lua_register(LuaHandle, "isConquestAlliance", luautils::isConquestAlliance);
        lua_register(LuaHandle, "setMobPos", luautils::setMobPos);
        lua_register(LuaHandle, "SpawnMob", luautils::SpawnMob);
        lua_register(LuaHandle, "DespawnMob", luautils::DespawnMob);
        lua_register(LuaHandle, "GetPlayerByName", luautils::GetPlayerByName);
        lua_register(LuaHandle, "GetPlayerByID", luautils::GetPlayerByID);
        lua_register(LuaHandle, "GetMobAction", luautils::GetMobAction);
        lua_register(LuaHandle, "VanadielTime", luautils::VanadielTime);
        lua_register(LuaHandle, "VanadielTOTD", luautils::VanadielTOTD);
        lua_register(LuaHandle, "VanadielHour", luautils::VanadielHour);
        lua_register(LuaHandle, "VanadielMinute", luautils::VanadielMinute);
        lua_register(LuaHandle, "VanadielDayOfTheMonth", luautils::VanadielDayOfTheMonth);
        lua_register(LuaHandle, "VanadielDayOfTheYear", luautils::VanadielDayOfTheYear);
        lua_register(LuaHandle, "VanadielYear", luautils::VanadielYear);
        lua_register(LuaHandle, "VanadielMonth", luautils::VanadielMonth);
        lua_register(LuaHandle, "VanadielDayElement", luautils::VanadielDayElement);
        lua_register(LuaHandle, "VanadielMoonPhase", luautils::VanadielMoonPhase);
        lua_register(LuaHandle, "VanadielMoonDirection", luautils::VanadielMoonDirection);
        lua_register(LuaHandle, "VanadielRSERace", luautils::VanadielRSERace);
        lua_register(LuaHandle, "VanadielRSELocation", luautils::VanadielRSELocation);
        lua_register(LuaHandle, "SetVanadielTimeOffset", luautils::SetVanadielTimeOffset);
        lua_register(LuaHandle, "IsMoonNew", luautils::IsMoonNew);
        lua_register(LuaHandle, "IsMoonFull", luautils::IsMoonFull);
        lua_register(LuaHandle, "RunElevator", luautils::StartElevator);
        lua_register(LuaHandle, "GetServerVariable", luautils::GetServerVariable);
        lua_register(LuaHandle, "SetServerVariable", luautils::SetServerVariable);
        lua_register(LuaHandle, "clearVarFromAll", luautils::clearVarFromAll);
        lua_register(LuaHandle, "SendEntityVisualPacket", luautils::SendEntityVisualPacket);
        lua_register(LuaHandle, "UpdateServerMessage", luautils::UpdateServerMessage);
        lua_register(LuaHandle, "GetMobRespawnTime", luautils::GetMobRespawnTime);
        lua_register(LuaHandle, "DisallowRespawn", luautils::DisallowRespawn);
        lua_register(LuaHandle, "UpdateNMSpawnPoint", luautils::UpdateNMSpawnPoint);
        lua_register(LuaHandle, "SetDropRate", luautils::SetDropRate);
        lua_register(LuaHandle, "NearLocation", luautils::nearLocation);
        lua_register(LuaHandle, "terminate", luautils::terminate);

        lua_register(LuaHandle, "GetHealingTickDelay", luautils::GetHealingTickDelay);

        lua_register(LuaHandle, "getAbility", luautils::getAbility);
        lua_register(LuaHandle, "getSpell", luautils::getSpell);

        Lunar<CLuaAbility>::Register(LuaHandle);
        Lunar<CLuaAction>::Register(LuaHandle);
        Lunar<CLuaBaseEntity>::Register(LuaHandle);
        Lunar<CLuaBattlefield>::Register(LuaHandle);
        Lunar<CLuaInstance>::Register(LuaHandle);
        Lunar<CLuaMobSkill>::Register(LuaHandle);
        Lunar<CLuaRegion>::Register(LuaHandle);
        Lunar<CLuaSpell>::Register(LuaHandle);
        Lunar<CLuaStatusEffect>::Register(LuaHandle);
        Lunar<CLuaTradeContainer>::Register(LuaHandle);
        Lunar<CLuaZone>::Register(LuaHandle);
        Lunar<CLuaItem>::Register(LuaHandle);

        luaL_dostring(LuaHandle, "if not bit then bit = require('bit') end");

        lua_getglobal(LuaHandle, "math");
        lua_pushstring(LuaHandle, "random");
        lua_pushcfunction(LuaHandle, luautils::random);
        lua_rawset(LuaHandle, -3);
        lua_pop(LuaHandle, 1);

        contentRestrictionEnabled = (GetSettingsVariable("RESTRICT_CONTENT") != 0);

        ShowMessage("\t\t - " CL_GREEN"[OK]" CL_RESET"\n");
        return 0;
    }

    /************************************************************************
    *                                                                       *
    *  Освобождение lua                                                     *
    *                                                                       *
    ************************************************************************/

    int32 free()
    {
        ShowStatus(CL_WHITE"luautils::free" CL_RESET":lua free...");
        lua_close(LuaHandle);
        ShowMessage("\t - " CL_GREEN"[OK]" CL_RESET"\n");
        return 0;
    }

    int32 garbageCollect()
    {

        int32 top = lua_gettop(LuaHandle);
        ShowDebug(CL_CYAN"[Lua] Garbage Collected. Current State Top: %d\n" CL_RESET, top);

        lua_gc(LuaHandle, LUA_GCSTEP, 10);

        return 0;
    }

    int register_fp(int index)
    {
        if (lua_isfunction(LuaHandle, index))
        {
            lua_pushvalue(LuaHandle, index);
            return luaL_ref(LuaHandle, LUA_REGISTRYINDEX);
        }
        else
        {
            ShowWarning("[Lua] register_fp: index %d not a function\n", index);
        }
        return 0;
    }

    void unregister_fp(int r)
    {
        luaL_unref(LuaHandle, LUA_REGISTRYINDEX, r);
    }

    /************************************************************************
    *                                                                       *
    *  Переопределение официальной lua функции print                        *
    *                                                                       *
    ************************************************************************/

    int32 print(lua_State* LuaHandle)
    {
        if (!lua_isnil(LuaHandle, -1) && lua_isstring(LuaHandle, -1))
        {
            ShowScript("%s\n", lua_tostring(LuaHandle, -1));
        }
        return 0;
    }

    int32 prepFile(int8* File, const char* function)
    {
        lua_pushnil(LuaHandle);
        lua_setglobal(LuaHandle, function);

        auto ret = luaL_loadfile(LuaHandle, (const char*)File);
        if (ret)
        {
            if (ret != LUA_ERRFILE)
                ShowError("luautils::%s: %s\n", function, lua_tostring(LuaHandle, -1));
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

    void pushFunc(int lua_func, int index)
    {
        lua_rawgeti(LuaHandle, LUA_REGISTRYINDEX, lua_func);
        lua_insert(LuaHandle, -(index + 1));
    }

    void callFunc(int nargs)
    {
        if (lua_pcall(LuaHandle, nargs, 0, 0))
        {
            ShowError("[Lua] Anonymous function: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
        }
    }

    int32 SendEntityVisualPacket(lua_State* L)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint32 npcid = (uint32)lua_tointeger(L, 1);
            const char* command = lua_tostring(L, 2);

            CBaseEntity* PNpc = zoneutils::GetEntity(npcid, TYPE_NPC);

            if (PNpc != nullptr)
            {
                PNpc->loc.zone->PushPacket(PNpc, CHAR_INRANGE, new CEntityVisualPacket(PNpc, command));
            }
            return 0;
        }
        lua_pushnil(L);
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *                                                                       *
    *                                                                       *
    ************************************************************************/

    int32 random(lua_State* L)
    {
        switch (lua_gettop(L))
        {
        case 0:
            lua_pushnumber(L, tpzrand::GetRandomNumber(1.));
            break;
        case 1:
            luaL_checkinteger(L, 1);
            lua_pushinteger(L, tpzrand::GetRandomNumber<lua_Integer>(1, lua_tointeger(L, 1) + 1));
            break;
        default:
            luaL_checkinteger(L, 1);
            luaL_checkinteger(L, 2);
            lua_pushinteger(L, tpzrand::GetRandomNumber<lua_Integer>(lua_tointeger(L, 1), lua_tointeger(L, 2) + 1));
            break;
        }
        return 1;
    }

    int32 GetNPCByID(lua_State* L)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint32 npcid = (uint32)lua_tointeger(L, 1);

            CInstance* PInstance = nullptr;

            if (!lua_isnil(L, 2) && lua_isuserdata(L, 2))
            {
                CLuaBaseEntity* PLuaBaseEntity = Lunar<CLuaBaseEntity>::check(L, 2);
                PInstance = PLuaBaseEntity->GetBaseEntity()->PInstance;
            }

            CBaseEntity* PNpc = nullptr;

            if (PInstance)
            {
                PNpc = PInstance->GetEntity(npcid & 0xFFF, TYPE_NPC);
            }
            else
            {
                PNpc = zoneutils::GetEntity(npcid, TYPE_NPC);
            }

            if (PNpc == nullptr)
            {
                lua_pushnil(L);
            }
            else
            {
                lua_getglobal(L, CLuaBaseEntity::className);
                lua_pushstring(L, "new");
                lua_gettable(L, -2);
                lua_insert(L, -2);
                lua_pushlightuserdata(L, (void*)PNpc);
                lua_pcall(L, 2, 1, 0);
            }

            return 1;
        }
        lua_pushnil(L);
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *                                                                       *
    *                                                                       *
    ************************************************************************/

    int32 GetMobByID(lua_State* L)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint32 mobid = (uint32)lua_tointeger(L, 1);
            CInstance* PInstance{ nullptr };
            CBaseEntity* PMob{ nullptr };

            if (!lua_isnil(L, 2) && lua_isuserdata(L, 2))
            {
                CLuaInstance* PLuaInstance = Lunar<CLuaInstance>::check(L, 2);
                PInstance = PLuaInstance->GetInstance();
            }
            if (PInstance)
            {
                PInstance->GetEntity(mobid & 0xFFF, TYPE_MOB | TYPE_PET);
            }
            else
            {
                PMob = zoneutils::GetEntity(mobid, TYPE_MOB | TYPE_PET);
            }

            if (!PMob)
            {
                ShowWarning("luautils::GetMobByID Mob doesn't exist (%d)\n", mobid);
                lua_pushnil(L);
            }
            else
            {
                lua_getglobal(L, CLuaBaseEntity::className);
                lua_pushstring(L, "new");
                lua_gettable(L, -2);
                lua_insert(L, -2);
                lua_pushlightuserdata(L, (void*)PMob);
                lua_pcall(L, 2, 1, 0);
            }

            return 1;
        }
        lua_pushnil(L);
        return 1;
    }


    /************************************************************************
    *                                                                       *
    * WeekUpdateConquest        *
    *                                                                       *
    ************************************************************************/

    int32 WeekUpdateConquest(lua_State* L)
    {
        ConquestUpdate type = Conquest_Tally_Start;
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            type = (ConquestUpdate)lua_tointeger(L, 1);
        }
        conquest::UpdateConquestGM(type);

        return 0;
    }

    /************************************************************************
    *                                                                       *
    *  Узнаем страну, владеющую текущим регионом                            *
    *                                                                       *
    ************************************************************************/

    int32 GetRegionOwner(lua_State* L)
    {
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

        lua_pushinteger(L, conquest::GetRegionOwner((REGIONTYPE)lua_tointeger(L, 1)));
        return 1;
    }

    int32 GetRegionInfluence(lua_State* L)
    {
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

        lua_pushinteger(L, conquest::GetInfluenceGraphics((REGIONTYPE)lua_tointeger(L, 1)));
        return 1;
    }

    /************************************************************************
    *                                                                       *
    * Get Rank of Nations in Conquest       *
    *                                                                       *
    ************************************************************************/

    int32 getNationRank(lua_State* L)
    {
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

        uint8 balance = conquest::GetBalance();
        switch (lua_tointeger(L, 1))
        {
        case SANDORIA:
            balance &= 0x3U;
            lua_pushinteger(L, balance);
            return 1;
        case BASTOK:
            balance &= 0xCU;
            balance >>= 2;
            lua_pushinteger(L, balance);
            return 1;
        case WINDURST:
            balance >>= 4;
            lua_pushinteger(L, balance);
            return 1;
        default:
            lua_pushinteger(L, 0);
            return 1;
        }
    }

    int32 getConquestBalance(lua_State* L)
    {
        lua_pushinteger(L, conquest::GetBalance());
        return 1;
    }

    int32 isConquestAlliance(lua_State* L)
    {
        lua_pushboolean(L, conquest::IsAlliance());
        return 1;
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

        lua_getfield(LuaHandle,-1,"conquest");
        if (lua_isnil(LuaHandle, -1))
        {
            lua_pop(LuaHandle, 2);
            ShowError("luautils::SetRegionalConquestOverseers: undefined field tpz.conquest\n");
            return -1;
        }

        lua_getfield(LuaHandle,-1,"setRegionalConquestOverseers");
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

    int32 VanadielTime(lua_State* L)
    {
        lua_pushinteger(L, CVanaTime::getInstance()->getVanaTime());
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *  Получаем текущее время суток Vana'diel                               *
    *                                                                       *
    ************************************************************************/

    int32 VanadielTOTD(lua_State* L)
    {
        lua_pushinteger(L, CVanaTime::getInstance()->GetCurrentTOTD());
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *   Return Vanadiel Year                                                *
    *                                                                       *
    ************************************************************************/

    int32 VanadielYear(lua_State* L)
    {
        lua_pushinteger(L, CVanaTime::getInstance()->getYear());
        return 1;
    }


    /************************************************************************
    *                                                                       *
    *   Return Vanadiel Month                                               *
    *                                                                       *
    ************************************************************************/

    int32 VanadielMonth(lua_State* L)
    {
        lua_pushinteger(L, CVanaTime::getInstance()->getMonth());
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *   Return Vanadiel Day of Year                                         *
    *                                                                       *
    ************************************************************************/

    int32 VanadielDayOfTheYear(lua_State* L)
    {
        int32 day;
        int32 month;

        day = CVanaTime::getInstance()->getDayOfTheMonth();
        month = CVanaTime::getInstance()->getMonth();

        lua_pushinteger(L, (month * 30 - 30) + day);
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *   Return Vanadiel Day of the Month                                    *
    *                                                                       *
    ************************************************************************/

    int32 VanadielDayOfTheMonth(lua_State* L)
    {
        lua_pushinteger(L, CVanaTime::getInstance()->getDayOfTheMonth());
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *   Return Vanadiel Hour                                                *
    *                                                                       *
    ************************************************************************/

    int32 VanadielHour(lua_State* L)
    {
        lua_pushinteger(L, CVanaTime::getInstance()->getHour());
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *   Return Vanadiel Minute                                              *
    *                                                                       *
    ************************************************************************/

    int32 VanadielMinute(lua_State* L)
    {
        lua_pushinteger(L, CVanaTime::getInstance()->getMinute());
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *   Return Vanadiel Day element                                         *
    *                                                                       *
    ************************************************************************/

    int32 VanadielDayElement(lua_State* L)
    {
        lua_pushinteger(L, CVanaTime::getInstance()->getWeekday());
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *   Return Moon Phase                                                   *
    *                                                                       *
    ************************************************************************/

    int32 VanadielMoonPhase(lua_State* L)
    {
        lua_pushinteger(L, CVanaTime::getInstance()->getMoonPhase());
        return 1;
    }

    int32 SetVanadielTimeOffset(lua_State* L)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            int32 offset = (int32)lua_tointeger(L, 1);

            CVanaTime::getInstance()->setCustomOffset(offset);

            lua_pushboolean(L, true);
            return 1;
        }
        lua_pushnil(L);
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *   Return Moon Phasing Direction                                       *
    *                                                                       *
    ************************************************************************/

    int32 VanadielMoonDirection(lua_State* L)
    {
        lua_pushinteger(L, CVanaTime::getInstance()->getMoonDirection());
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *   Return RSE Race                                                     *
    *                                                                       *
    ************************************************************************/

    int32 VanadielRSERace(lua_State* L)
    {
        lua_pushinteger(L, CVanaTime::getInstance()->getRSERace());
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *   Return RSE Location                                                 *
    *                                                                       *
    ************************************************************************/

    int32 VanadielRSELocation(lua_State* L)
    {
        lua_pushinteger(L, CVanaTime::getInstance()->getRSELocation());
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *   is new moon?                                                        *
    *                                                                       *
    ************************************************************************/

    int32 IsMoonNew(lua_State* L)
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
                lua_pushboolean(L, true);
                return 1;
            }

        case 1: // Waning (decending)
            if (phase <= 10 && phase >= 0)
            {
                lua_pushboolean(L, true);
                return 1;
            }

        case 2: // Waxing (increasing)
            if (phase >= 0 && phase <= 5)
            {
                lua_pushboolean(L, true);
                return 1;
            }
        }
        lua_pushboolean(L, false);
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *   is full moon?                                                       *
    *                                                                       *
    ************************************************************************/

    int32 IsMoonFull(lua_State* L)
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
                lua_pushboolean(L, true);
                return 1;
            }

        case 1: // Waning (decending)
            if (phase >= 95 && phase <= 100)
            {
                lua_pushboolean(L, true);
                return 1;
            }

        case 2: // Waxing (increasing)
            if (phase >= 90 && phase <= 100)
            {
                lua_pushboolean(L, true);
                return 1;
            }
        }
        lua_pushboolean(L, false);
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *  Spawn a mob using mob ID.                                            *
    *                                                                       *
    ************************************************************************/
    int32 SpawnMob(lua_State* L)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint32 mobid = (uint32)lua_tointeger(L, 1);

            CMobEntity* PMob = nullptr;

            if (!lua_isnil(L, 2) && lua_isuserdata(L, 2))
            {
                CLuaInstance* PLuaInstance = Lunar<CLuaInstance>::check(L, 2);
                PMob = (CMobEntity*)PLuaInstance->GetInstance()->GetEntity(mobid & 0xFFF, TYPE_MOB);
            }
            else if (((mobid >> 12) & 0x0FFF) < MAX_ZONEID)
            {
                PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB);
            }
            if (PMob != nullptr)
            {

                if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
                {
                    PMob->SetDespawnTime(std::chrono::seconds(lua_tointeger(L, 2)));
                }

                if (!lua_isnil(L, 3) && lua_isnumber(L, 3))
                {
                    PMob->m_RespawnTime = (uint32)lua_tointeger(L, 3) * 1000;
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
                        ShowDebug(CL_CYAN"SpawnMob: %u <%s> is already spawned\n" CL_RESET, PMob->id, PMob->GetName());
                    }
                }
                lua_getglobal(L, CLuaBaseEntity::className);
                lua_pushstring(L, "new");
                lua_gettable(L, -2);
                lua_insert(L, -2);
                lua_pushlightuserdata(L, (void*)PMob);
                lua_pcall(L, 2, 1, 0);
                return 1;
            }
            else
            {
                ShowDebug(CL_RED"SpawnMob: mob <%u> not found\n" CL_RESET, mobid);
            }
            return 0;
        }
        lua_pushnil(L);
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *  DeSpawn mob using mob ID.                                            *
    *                                                                       *
    ************************************************************************/

    int32 DespawnMob(lua_State* L)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint32 mobid = (uint32)lua_tointeger(L, 1);
            CMobEntity* PMob = nullptr;

            if (!lua_isnil(L, 2) && lua_isuserdata(L, 2))
            {
                CLuaInstance* PLuaInstance = Lunar<CLuaInstance>::check(L, 2);
                PMob = (CMobEntity*)PLuaInstance->GetInstance()->GetEntity(mobid & 0xFFF, TYPE_MOB);
            }
            else
            {
                PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB);
            }
            if (PMob != nullptr)
            {
                if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
                {
                    PMob->SetDespawnTime(std::chrono::seconds(lua_tointeger(L, 2)));
                }
                else
                {
                    PMob->PAI->Despawn();
                }
            }
            return 0;
        }
        lua_pushnil(L);
        return 1;
    }


    /************************************************************************
    *                                                                       *
    *  set a mobs position                                                  *
    *                                                                       *
    ************************************************************************/

    int32 setMobPos(lua_State *L)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint32 mobid = (uint32)lua_tointeger(L, 1);

            CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB);
            if (PMob != nullptr)
            {
                //if mob is in battle, do not warp it
                if (!PMob->PAI->IsEngaged())
                {
                    if (!lua_isnil(L, 2) && lua_isnumber(L, 2))
                        PMob->loc.p.x = (float)lua_tonumber(L, 2);

                    if (!lua_isnil(L, 3) && lua_isnumber(L, 3))
                        PMob->loc.p.y = (float)lua_tonumber(L, 3);

                    if (!lua_isnil(L, 4) && lua_isnumber(L, 4))
                        PMob->loc.p.z = (float)lua_tonumber(L, 4);

                    if (!lua_isnil(L, 5) && lua_isnumber(L, 5))
                        PMob->loc.p.rotation = (uint8)lua_tointeger(L, 5);
                }
                else
                {
                    ShowDebug(CL_CYAN"setMobPos: <%s> is currently in battle, will not warp it!\n" CL_RESET, PMob->GetName());
                    return 1;
                }
            }
            lua_pushnil(L);
            return 1;
        }
        ShowError(CL_RED"setMobPos :: Mob ID is not valid." CL_RESET);
        return 1;
    }


    /************************************************************************
    *                                                                       *
    *  Gets a player object via the player's name. Used for GM commands.    *
    *                                                                       *
    ************************************************************************/

    int32 GetPlayerByName(lua_State* L)
    {
        if (!lua_isnil(L, -1) && lua_isstring(L, -1))
        {
            int8* name = (int8*)lua_tolstring(L, -1, nullptr);

            CCharEntity* PTargetChar = zoneutils::GetCharByName(name);

            if (PTargetChar != nullptr)
            {
                lua_getglobal(L, CLuaBaseEntity::className);
                lua_pushstring(L, "new");
                lua_gettable(L, -2);
                lua_insert(L, -2);
                lua_pushlightuserdata(L, (void*)PTargetChar);
                lua_pcall(L, 2, 1, 0);
                return 1;
            }
        }
        ShowError(CL_RED"GetPlayerByName :: Input string is not valid.\n" CL_RESET);
        lua_pushnil(L);
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *  Gets a player object via the player's ID.                            *
    *                                                                       *
    ************************************************************************/

    int32 GetPlayerByID(lua_State* L)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint32 pid = (uint32)lua_tointeger(L, 1);

            CCharEntity* PTargetChar = zoneutils::GetChar(pid);

            if (PTargetChar != nullptr)
            {
                lua_getglobal(L, CLuaBaseEntity::className);
                lua_pushstring(L, "new");
                lua_gettable(L, -2);
                lua_insert(L, -2);
                lua_pushlightuserdata(L, (void*)PTargetChar);
                lua_pcall(L, 2, 1, 0);
                return 1;
            }
        }
        lua_pushnil(L);
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *  ** DEPRECATED **                                                     *
    *  Get Current Mob Action by Mob ID.                                    *
    *                                                                       *
    ************************************************************************/

    int32 GetMobAction(lua_State* L)
    {
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

        uint32 mobid = (uint32)lua_tointeger(L, -1);

        CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB | TYPE_PET);
        if (PMob != nullptr)
        {
            if (PMob->PAI->IsStateStackEmpty())
            {
                lua_pushinteger(L, 16);
            }
            else if (PMob->PAI->IsCurrentState<CRespawnState>())
            {
                lua_pushinteger(L, 0);
            }
            else if (PMob->PAI->IsCurrentState<CAttackState>())
            {
                lua_pushinteger(L, 1);
            }
            else if (PMob->PAI->IsCurrentState<CRangeState>())
            {
                lua_pushinteger(L, 12);
            }
            else if (PMob->PAI->IsCurrentState<CWeaponSkillState>())
            {
                lua_pushinteger(L, 3);
            }
            else if (PMob->PAI->IsCurrentState<CMagicState>())
            {
                lua_pushinteger(L, 30);
            }
            else if (PMob->PAI->IsCurrentState<CItemState>())
            {
                lua_pushinteger(L, 28);
            }
            else if (PMob->PAI->IsCurrentState<CAbilityState>())
            {
                lua_pushinteger(L, 6);
            }
            else if (PMob->PAI->IsCurrentState<CInactiveState>())
            {
                lua_pushinteger(L, 27);
            }
            else if (PMob->PAI->IsCurrentState<CDeathState>())
            {
                lua_pushinteger(L, 22);
            }
            else if (PMob->PAI->IsCurrentState<CRaiseState>())
            {
                lua_pushinteger(L, 37);
            }
            else if (PMob->PAI->IsCurrentState<CMobSkillState>())
            {
                lua_pushinteger(L, 34);
            }
            else
            {
                lua_pushnil(L);
            }
            return 1;
        }
        ShowError(CL_RED"luautils::GetMobAction: mob <%u> was not found\n" CL_RESET, mobid);
        lua_pushnil(L);
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

            if (auto contentEnabledIter = contentEnabledMap.find(contentVariable);  contentEnabledIter != contentEnabledMap.end())
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

        lua_prepscript("scripts/zones/%s/Zone.lua", PZone->GetName());

        if (prepFile(File, "onInitialize"))
        {
            return -1;
        }

        CLuaZone LuaZone(PZone);
        Lunar<CLuaZone>::push(LuaHandle, &LuaZone);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onInitialize: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        lua_prepscript("scripts/globals/player.lua");

        if (prepFile(File, "onGameIn"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushboolean(LuaHandle, PChar->GetPlayTime(false) == 0); // first login
        lua_pushboolean(LuaHandle, zoning);

        if (lua_pcall(LuaHandle, 3, 0, 0))
        {
            ShowError("luautils::onGameIn: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        lua_prepscript("scripts/zones/%s/Zone.lua", PChar->m_moghouseID ? "Residential_Area" : (const char*)zoneutils::GetZone(PChar->loc.destination)->GetName());

        if (prepFile(File, "onZoneIn"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushinteger(LuaHandle, PChar->loc.prevzone);

        if (lua_pcall(LuaHandle, 2, 1, 0))
        {
            ShowError("luautils::onZoneIn: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 1);
        return retVal;
    }

    void AfterZoneIn(CBaseEntity* PChar)
    {
        lua_prepscript("scripts/zones/%s/Zone.lua", PChar->loc.zone->GetName());

        if (prepFile(File, "afterZoneIn"))
        {
            return;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::afterZoneIn: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return;
        }

        return;
    }

    /************************************************************************
    *                                                                       *
    *  Персонаж входит в активный регион                                    *
    *                                                                       *
    ************************************************************************/

    int32 OnRegionEnter(CCharEntity* PChar, CRegion* PRegion)
    {
        std::string filename;
        if (PChar->PInstance)
        {
            filename = std::string("scripts/zones/") + (const char*)PChar->loc.zone->GetName() + "/instances/" + (const char*)PChar->PInstance->GetName() + ".lua";
        }
        else
        {
            filename = std::string("scripts/zones/") + (const char*)PChar->loc.zone->GetName() + "/Zone.lua";
        }

        //player may be entering because of an earlier event (event that changes position)
        // these should probably not call another event from onRegionEnter (use onEventFinish instead)
        if (PChar->m_event.EventID == -1)
            PChar->m_event.Script = filename;

        if (prepFile((int8*)filename.c_str(), "onRegionEnter"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);
        CLuaRegion LuaRegion(PRegion);
        Lunar<CLuaRegion>::push(LuaHandle, &LuaRegion);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onRegionEnter: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        std::string filename;
        if (PChar->PInstance)
        {
            filename = std::string("scripts/zones/") + (const char*)PChar->loc.zone->GetName() + "/instances/" + (const char*)PChar->PInstance->GetName() + ".lua";
        }
        else
        {
            filename = std::string("scripts/zones/") + (const char*)PChar->loc.zone->GetName() + "/Zone.lua";
        }

        //player may be leaving because of an earlier event (event that changes position)
        if (PChar->m_event.EventID == -1)
            PChar->m_event.Script = filename;

        if (prepFile((int8*)filename.c_str(), "onRegionLeave"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);
        CLuaRegion LuaRegion(PRegion);
        Lunar<CLuaRegion>::push(LuaHandle, &LuaRegion);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onRegionLeave: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        return 0;
    }

    /************************************************************************
    *                                                                       *
    *  Персонаж обращается к какому-либо npc. Пытаемся отреагировать на     *
    *  его действие                                                         *
    *                                                                       *
    ************************************************************************/

    int32 OnTrigger(CCharEntity* PChar, CBaseEntity* PNpc)
    {
        lua_prepscript("scripts/zones/%s/npcs/%s.lua", PChar->loc.zone->GetName(), PNpc->GetName());

        PChar->m_event.reset();
        PChar->m_event.Target = PNpc;
        PChar->m_event.Script.insert(0, (const char*)File);
        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_BOOST);

        lua_pushnil(LuaHandle);
        lua_setglobal(LuaHandle, "onTrigger");

        auto ret = luaL_loadfile(LuaHandle, (const char*)File);
        if (ret)
        {
            ShowWarning("luautils::%s: %s\n", "onTrigger", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        ret = lua_pcall(LuaHandle, 0, 0, 0);
        if (ret)
        {
            ShowError("luautils::%s: %s\n", "onTrigger", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        lua_getglobal(LuaHandle, "onTrigger");
        if (lua_isnil(LuaHandle, -1))
        {
            lua_pop(LuaHandle, 1);
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaBaseEntityTarg(PNpc);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntityTarg);

        if (lua_pcall(LuaHandle, 2, 1, 0))
        {
            ShowError("luautils::onTrigger: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 1);
        return retVal;
    }

    /************************************************************************
    *  Запущенное событие нуждается в дополнительных параметрах             *
    *  A triggered event needs additional parameters  (battlefield extras)  *
    ************************************************************************/

    int32 OnEventUpdate(CCharEntity* PChar, uint16 eventID, uint32 result, uint16 extras)
    {
        int32 oldtop = lua_gettop(LuaHandle);

        lua_pushnil(LuaHandle);
        lua_setglobal(LuaHandle, "onEventUpdate");

        auto loadResult = LoadEventScript(PChar, "onEventUpdate");

        if (!loadResult)
        {
            ShowError("luautils::onEventUpdate: undefined procedure onEventUpdate\n");
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushinteger(LuaHandle, eventID);
        lua_pushinteger(LuaHandle, result);
        lua_pushinteger(LuaHandle, extras);

        CLuaBaseEntity LuaTargetEntity(PChar->m_event.Target);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaTargetEntity);

        if (lua_pcall(LuaHandle, 5, 1, 0))
        {
            ShowError("luautils::onEventUpdate: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        int32 updatePosition = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 1);
        lua_pop(LuaHandle, 1);

        return updatePosition;
    }

    /************************************************************************
    *  Запущенное событие нуждается в дополнительных параметрах             *
    *  A triggered event needs additional parameters                        *
    ************************************************************************/

    int32 OnEventUpdate(CCharEntity* PChar, uint16 eventID, uint32 result)
    {
        lua_pushnil(LuaHandle);
        lua_setglobal(LuaHandle, "onEventUpdate");

        auto loadResult = LoadEventScript(PChar, "onEventUpdate");

        if (!loadResult)
        {
            ShowError("luautils::onEventUpdate: undefined procedure onEventUpdate\n");
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushinteger(LuaHandle, eventID);
        lua_pushinteger(LuaHandle, result);

        CLuaBaseEntity LuaTargetEntity(PChar->m_event.Target);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaTargetEntity);

        if (lua_pcall(LuaHandle, 4, 1, 0))
        {
            ShowError("luautils::onEventUpdate: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        int32 updatePosition = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 1);
        lua_pop(LuaHandle, 1);

        return updatePosition;
    }

    int32 OnEventUpdate(CCharEntity* PChar, int8* string)
    {
        lua_pushnil(LuaHandle);
        lua_setglobal(LuaHandle, "onEventUpdate");

        bool loadResult = LoadEventScript(PChar, "onEventUpdate");

        if (!loadResult)
        {
            ShowError("luautils::onEventUpdate: undefined procedure onEventUpdate\n");
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushinteger(LuaHandle, PChar->m_event.EventID);
        lua_pushstring(LuaHandle, (const char*)string);

        CLuaBaseEntity LuaTargetEntity(PChar->m_event.Target);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaTargetEntity);

        if (lua_pcall(LuaHandle, 4, 0, 0))
        {
            ShowError("luautils::onEventUpdate: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        lua_pushnil(LuaHandle);
        lua_setglobal(LuaHandle, "onEventFinish");

        bool loadResult = LoadEventScript(PChar, "onEventFinish");

        if (!loadResult)
        {
            ShowError("luautils::onEventFinish: undefined procedure onEventFinish\n");
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushinteger(LuaHandle, eventID);
        lua_pushinteger(LuaHandle, result);

        CLuaBaseEntity LuaTargetEntity(PChar->m_event.Target);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaTargetEntity);

        if (lua_pcall(LuaHandle, 4, 0, 0))
        {
            ShowError("luautils::onEventFinish %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        if (PChar->m_event.Script.find("/bcnms/") > 0 && PChar->health.hp <= 0) { //for some reason the event doesnt enforce death afterwards
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
        lua_prepscript("scripts/zones/%s/npcs/%s.lua", PChar->loc.zone->GetName(), PNpc->GetName());

        PChar->m_event.reset();
        PChar->m_event.Target = PNpc;
        PChar->m_event.Script.insert(0, (const char*)File);

        if (prepFile(File, "onTrade"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaBaseEntityTarg(PNpc);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntityTarg);

        CLuaTradeContainer LuaTradeContainer(PChar->TradeContainer);
        Lunar<CLuaTradeContainer>::push(LuaHandle, &LuaTradeContainer);

        if (lua_pcall(LuaHandle, 3, 0, 0))
        {
            ShowError("luautils::onTrade: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    int32 OnNpcSpawn(CBaseEntity* PNpc)
    {
        TPZ_DEBUG_BREAK_IF(PNpc == nullptr);

        lua_prepscript("scripts/zones/%s/npcs/%s.lua", PNpc->loc.zone->GetName(), PNpc->GetName());

        if (prepFile(File, "onSpawn"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PNpc);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onNpcSpawn: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaMobEntity(PDefender);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        lua_pushinteger(LuaHandle, damage);

        if (lua_pcall(LuaHandle, 3, 3, 0))
        {
            ShowError("luautils::onAdditionalEffect: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        Action->additionalEffect = (SUBEFFECT)(!lua_isnil(LuaHandle, -3) && lua_isnumber(LuaHandle, -3) ? (int32)lua_tonumber(LuaHandle, -3) : 0);
        Action->addEffectMessage = (!lua_isnil(LuaHandle, -2) && lua_isnumber(LuaHandle, -2) ? (int32)lua_tonumber(LuaHandle, -2) : 0);
        Action->addEffectParam = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaMobEntity(PAttacker);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        lua_pushinteger(LuaHandle, damage);

        if (lua_pcall(LuaHandle, 3, 3, 0))
        {
            ShowError("luautils::onSpikesDamage: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        Action->spikesEffect = (SUBEFFECT)(!lua_isnil(LuaHandle, -3) && lua_isnumber(LuaHandle, -3) ? (int32)lua_tonumber(LuaHandle, -3) : 0);
        Action->spikesMessage = (!lua_isnil(LuaHandle, -2) && lua_isnumber(LuaHandle, -2) ? (int32)lua_tonumber(LuaHandle, -2) : 0);
        Action->spikesParam = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 3);

        return 0;
    }

    /************************************************************************
    *                                                                       *
    *  Начало работы статус-эффекта. Возвращаемое значение 0 или номер      *
    *  сообщения                                                            *
    *                                                                       *
    ************************************************************************/

    int32 OnEffectGain(CBattleEntity* PEntity, CStatusEffect* PStatusEffect)
    {
        lua_prepscript("scripts/%s.lua", PStatusEffect->GetName());

        if (prepFile(File, "onEffectGain"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PEntity);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaStatusEffect LuaStatusEffect(PStatusEffect);
        Lunar<CLuaStatusEffect>::push(LuaHandle, &LuaStatusEffect);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onEffectGain: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    /************************************************************************
    *                                                                       *
    *  Повторяемое действие в процессе работы статус-оффекта                *
    *                                                                       *
    ************************************************************************/

    int32 OnEffectTick(CBattleEntity* PEntity, CStatusEffect* PStatusEffect)
    {
        lua_prepscript("scripts/%s.lua", PStatusEffect->GetName());

        if (prepFile(File, "onEffectTick"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PEntity);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaStatusEffect LuaStatusEffect(PStatusEffect);
        Lunar<CLuaStatusEffect>::push(LuaHandle, &LuaStatusEffect);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onEffectTick: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    /************************************************************************
    *                                                                       *
    *  Завершение работы статус-эффекта. Возвращаемое значение -1 или       *
    *  номер сообщения                                                      *
    *                                                                       *
    ************************************************************************/

    int32 OnEffectLose(CBattleEntity* PEntity, CStatusEffect* PStatusEffect)
    {
        lua_prepscript("scripts/%s.lua", PStatusEffect->GetName());

        if (prepFile(File, "onEffectLose"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PEntity);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaStatusEffect LuaStatusEffect(PStatusEffect);
        Lunar<CLuaStatusEffect>::push(LuaHandle, &LuaStatusEffect);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onEffectLose: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

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
        lua_prepscript("scripts/globals/items/%s.lua", PItem->getName());

        if (prepFile(File, "onItemCheck"))
        {
            return { 56, 0, 0 };
        }

        CLuaBaseEntity LuaBaseEntityTarget(PTarget);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntityTarget);
        CLuaBaseEntity LuaBaseEntityCaster(PCaster);

        lua_pushinteger(LuaHandle, static_cast<uint32>(param));

        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntityCaster);

        if (lua_pcall(LuaHandle, 3, 3, 0))
        {
            ShowError("luautils::onItemCheck: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return { 56, 0, 0 };
        }

        uint32 messageId = (!lua_isnil(LuaHandle, -3) && lua_isnumber(LuaHandle, -3) ? (int32)lua_tonumber(LuaHandle, -3) : 0);
        uint32 param1 = (!lua_isnil(LuaHandle, -2) && lua_isnumber(LuaHandle, -2) ? (int32)lua_tonumber(LuaHandle, -2) : 0);
        uint32 param2 = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 3);

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
        lua_prepscript("scripts/globals/items/%s.lua", PItem->getName());

        if (prepFile(File, "onItemUse"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PTarget);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onItemUse: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        lua_prepscript("scripts/globals/gear_sets.lua");

        if (prepFile(File, "checkForGearSet"))
        {
            return 56;
        }

        CLuaBaseEntity LuaBaseEntity(PTarget);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushinteger(LuaHandle, 0);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::CheckForGearSet: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 56;
        }

        return 0;
    }


    /************************************************************************
    *                                                                       *
    *  Чтение заклинаний                                                    *
    *                                                                       *
    ************************************************************************/

    int32 OnSpellCast(CBattleEntity* PCaster, CBattleEntity* PTarget, CSpell* PSpell)
    {
        TPZ_DEBUG_BREAK_IF(PSpell == nullptr);

        lua_prepscript(
            PSpell->getSpellGroup() == SPELLGROUP_BLUE ? "scripts/globals/spells/bluemagic/%s.lua" :
            PSpell->getSpellGroup() == SPELLGROUP_TRUST ? "scripts/globals/spells/trust/%s.lua" :
            "scripts/globals/spells/%s.lua", PSpell->getName()
        );

        if (prepFile(File, "onSpellCast"))
        {
            return 0;
        }

        CLuaBaseEntity LuaCasterEntity(PCaster);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaCasterEntity);

        CLuaBaseEntity LuaTargetEntity(PTarget);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaTargetEntity);

        CLuaSpell LuaSpell(PSpell);
        Lunar<CLuaSpell>::push(LuaHandle, &LuaSpell);

        if (lua_pcall(LuaHandle, 3, 1, 0))
        {
            ShowError("luautils::onSpellCast: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 1);
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
            lua_prepscript("scripts/zones/%s/mobs/%s.lua", PCaster->loc.zone->GetName(), PCaster->GetName());

            if (prepFile(File, "onSpellPrecast"))
            {
                return 0;
            }

            CLuaBaseEntity LuaCasterEntity(PCaster);
            Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaCasterEntity);

            CLuaSpell LuaSpell(PSpell);
            Lunar<CLuaSpell>::push(LuaHandle, &LuaSpell);

            if (lua_pcall(LuaHandle, 2, 0, 0))
            {
                ShowError("luautils::onSpellPrecast: %s\n", lua_tostring(LuaHandle, -1));
                lua_pop(LuaHandle, 1);
                return 0;
            }
        }
        return 0;
    }

    std::optional<SpellID> OnMonsterMagicPrepare(CBattleEntity* PCaster, CBattleEntity* PTarget)
    {
        TPZ_DEBUG_BREAK_IF(PCaster == nullptr || PTarget == nullptr);

        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PCaster->loc.zone->GetName(), PCaster->GetName());

        if (prepFile(File, "onMonsterMagicPrepare"))
        {
            return {};
        }

        CLuaBaseEntity LuaMobEntity(PCaster);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        CLuaBaseEntity LuaTargetEntity(PTarget);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaTargetEntity);


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
        TPZ_DEBUG_BREAK_IF(PSpell == nullptr);

        PTarget->PAI->EventHandler.triggerListener("MAGIC_TAKE", PTarget, PCaster, PSpell);

        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PTarget->loc.zone->GetName(), PTarget->GetName());

        if (prepFile(File, "onMagicHit"))
        {
            return 0;
        }

        CLuaBaseEntity LuaCasterEntity(PCaster);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaCasterEntity);

        CLuaBaseEntity LuaTargetEntity(PTarget);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaTargetEntity);

        CLuaSpell LuaSpell(PSpell);
        Lunar<CLuaSpell>::push(LuaHandle, &LuaSpell);

        if (lua_pcall(LuaHandle, 3, 1, 0))
        {
            ShowError("luautils::onMagicHit: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 1);
        return retVal;
    }

    /************************************************************************
    *                                                                       *
    *  Called when mob is struck by a Weaponskill                           *
    *                                                                       *
    ************************************************************************/

    int32 OnWeaponskillHit(CBattleEntity* PMob, CBaseEntity* PAttacker, uint16 PWeaponskill)
    {
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);
        TPZ_DEBUG_BREAK_IF(PAttacker == nullptr);
        TPZ_DEBUG_BREAK_IF(PWeaponskill == NULL);

        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (prepFile(File, "onWeaponskillHit"))
        {
            return 0;
        }

        CLuaBaseEntity LuaMobEntity(PMob);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        CLuaBaseEntity LuaBaseEntity(PAttacker);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushinteger(LuaHandle, PWeaponskill);

        if (lua_pcall(LuaHandle, 3, 1, 0))
        {
            ShowError("luautils::onWeaponskillHit: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 1);
        return retVal;
    }

    /************************************************************************
    *  onMobInitialize                                                      *
    *  Used for passive trait                                               *
    *                                                                       *
    ************************************************************************/

    int32 OnMobInitialize(CBaseEntity* PMob)
    {
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);

        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (prepFile(File, "onMobInitialize"))
        {
            return -1;
        }

        CLuaBaseEntity LuaMobEntity(PMob);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onMobInitialize: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    int32 ApplyMixins(CBaseEntity* PMob)
    {
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);

        if (PMob->objtype == TYPE_MOB)
        {
            lua_prepscript("scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

            lua_pushnil(LuaHandle);
            lua_setglobal(LuaHandle, "mixins");
            lua_pushnil(LuaHandle);
            lua_setglobal(LuaHandle, "mixinOptions");

            //remove any previous definition of the global "mixins"

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

            //get the function "applyMixins"
            lua_getglobal(LuaHandle, "applyMixins");
            if (lua_isnil(LuaHandle, -1))
            {
                lua_pop(LuaHandle, 1);
                return -1;
            }

            CLuaBaseEntity LuaMobEntity(PMob);
            Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

            //get the parameter "mixins"
            lua_getglobal(LuaHandle, "mixins");
            if (lua_isnil(LuaHandle, -1))
            {
                lua_pop(LuaHandle, 3);
                return -1;
            }
            //get the parameter "mixinOptions" (optional)
            lua_getglobal(LuaHandle, "mixinOptions");

            if (lua_pcall(LuaHandle, 3, 0, 0))
            {
                ShowError("luautils::applyMixins: %s\n", lua_tostring(LuaHandle, -1));
                lua_pop(LuaHandle, 1);
            }
        }
        return 0;
    }

    int32 ApplyZoneMixins(CBaseEntity* PMob)
    {
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

                    //remove any previous definition of the global "mixins"

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

                    //get the function "applyMixins"
                    lua_getglobal(LuaHandle, "applyMixins");
                    if (lua_isnil(LuaHandle, -1))
                    {
                        lua_pop(LuaHandle, 1);
                        return -1;
                    }

                    CLuaBaseEntity LuaMobEntity(PMob);
                    Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

                    //get the parameter "mixins"
                    lua_getglobal(LuaHandle, "mixins");
                    if (lua_isnil(LuaHandle, -1))
                    {
                        lua_pop(LuaHandle, 3);
                        return -1;
                    }
                    //get the parameter "mixinOptions" (optional)
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

                //remove any previous definition of the global "mixins"

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

                //get the function "applyMixins"
                lua_getglobal(LuaHandle, "applyMixins");
                if (lua_isnil(LuaHandle, -1))
                {
                    lua_pop(LuaHandle, 1);
                    return -1;
                }

                CLuaBaseEntity LuaMobEntity(PMob);
                Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

                //get the parameter "mixins"
                lua_getglobal(LuaHandle, "mixins");
                if (lua_isnil(LuaHandle, -1))
                {
                    lua_pop(LuaHandle, 3);
                    return -1;
                }
                //get the parameter "mixinOptions" (optional)
                lua_getglobal(LuaHandle, "mixinOptions");

                if (lua_pcall(LuaHandle, 3, 0, 0))
                {
                    ShowError("luautils::applyMixins: %s\n", lua_tostring(LuaHandle, -1));
                    lua_pop(LuaHandle, 1);
                }
            }
        }
        return 0;
    }

    int32 OnPath(CBaseEntity* PEntity)
    {
        TPZ_DEBUG_BREAK_IF(PEntity == nullptr);

        if (PEntity->objtype != TYPE_PC)
        {
            lua_prepscript("scripts/zones/%s/%s/%s.lua", PEntity->loc.zone->GetName(), (PEntity->objtype == TYPE_MOB ? "mobs" : "npcs"), PEntity->GetName());

            if (prepFile(File, "onPath"))
            {
                return -1;
            }

            CLuaBaseEntity LuaMobEntity(PEntity);
            Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

            if (lua_pcall(LuaHandle, 1, 0, 0))
            {
                ShowError("luautils::onPath: %s\n", lua_tostring(LuaHandle, -1));
                lua_pop(LuaHandle, 1);
                return -1;
            }
        }
        return 0;
    }

    int32 OnBattlefieldHandlerInitialise(CZone* PZone)
    {
        TPZ_DEBUG_BREAK_IF(PZone == nullptr);

        lua_prepscript("scripts/globals/battlefield.lua");

        int32 MaxAreas = 3;

        if (prepFile(File, "onBattlefieldHandlerInitialise"))
        {
            return MaxAreas;
        }

        CLuaZone LuaZone(PZone);
        Lunar<CLuaZone>::push(LuaHandle, &LuaZone);

        if (lua_pcall(LuaHandle, 1, LUA_MULTRET, 0))
        {
            ShowError("luautils::onBattlefieldHandlerInitialise: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return MaxAreas;
        }

        MaxAreas = (int32)lua_tointeger(LuaHandle, -1);
        lua_pop(LuaHandle, 1);
        return MaxAreas;
    }

    int32 OnBattlefieldInitialise(CBattlefield* PBattlefield)
    {
        TPZ_DEBUG_BREAK_IF(PBattlefield == nullptr);

        lua_prepscript("scripts/zones/%s/bcnms/%s.lua", PBattlefield->GetZone()->GetName(), PBattlefield->GetName().c_str());

        if (prepFile(File, "onBattlefieldInitialise"))
        {
            return -1;
        }

        CLuaBattlefield LuaBattlefield(PBattlefield);
        Lunar<CLuaBattlefield>::push(LuaHandle, &LuaBattlefield);

        if (lua_pcall(LuaHandle, 1, LUA_MULTRET, 0))
        {
            ShowError("luautils::onBattlefieldInitialise: %s\n", lua_tostring(LuaHandle, -1));
            return -1;
        }
        return 0;
    }

    int32 OnBattlefieldTick(CBattlefield* PBattlefield)
    {
        TPZ_DEBUG_BREAK_IF(PBattlefield == nullptr);

        lua_prepscript("scripts/zones/%s/bcnms/%s.lua", PBattlefield->GetZone()->GetName(), PBattlefield->GetName().c_str());

        if (prepFile(File, "onBattlefieldTick"))
        {
            ShowError("luautils::onBattlefieldTick: Unable to find onBattlefieldTick function for %s\n", &File[0]);
            return -1;
        }

        CLuaBattlefield LuaBattlefield(PBattlefield);
        Lunar<CLuaBattlefield>::push(LuaHandle, &LuaBattlefield);
        lua_pushinteger(LuaHandle, (lua_Integer)std::chrono::duration_cast<std::chrono::seconds>(PBattlefield->GetTimeInside()).count());

        if (lua_pcall(LuaHandle, 2, LUA_MULTRET, 0))
        {
            ShowError("luautils::onBattlefieldTick: %s\n", lua_tostring(LuaHandle, -1));
            return -1;
        }
        return 0;
    }

    int32 OnBattlefieldStatusChange(CBattlefield* PBattlefield)
    {
        TPZ_DEBUG_BREAK_IF(PBattlefield == nullptr);

        lua_prepscript("scripts/zones/%s/bcnms/%s.lua", PBattlefield->GetZone()->GetName(), PBattlefield->GetName().c_str());

        if (prepFile(File, "onBattlefieldStatusChange"))
        {
            return -1;
        }

        CLuaBattlefield LuaBattlefield(PBattlefield);
        Lunar<CLuaBattlefield>::push(LuaHandle, &LuaBattlefield);
        lua_pushinteger(LuaHandle, PBattlefield->GetStatus());

        if (lua_pcall(LuaHandle, 2, LUA_MULTRET, 0))
        {
            ShowError("luautils::onBattlefieldStatusChange: %s\n", lua_tostring(LuaHandle, -1));
            return -1;
        }
        return 0;
    }

    /************************************************************************
    *                                                                       *
    *  Сalled when a monster engages a target for the first time            *
    *       Added by request (for doing stuff when mobs first engage)       *
    ************************************************************************/

    int32 OnMobEngaged(CBaseEntity* PMob, CBaseEntity* PTarget)
    {
        TPZ_DEBUG_BREAK_IF(PTarget == nullptr || PMob == nullptr);

        CLuaBaseEntity LuaMobEntity(PMob);
        CLuaBaseEntity LuaKillerEntity(PTarget);

        int8 File[255];
        PMob->objtype == TYPE_PET ? snprintf((char*)File, sizeof(File), "scripts/globals/pets/%s.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str()) :
            snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

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

        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaKillerEntity);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onMobEngaged: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        return 0;
    }

    /************************************************************************
    *                                                                       *
    *  Calls a lua script when a mob has disengaged from a target   *       *
    *                                                                       *
    ************************************************************************/

    int32 OnMobDisengage(CBaseEntity* PMob)
    {
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);

        uint8 weather = PMob->loc.zone->GetWeather();

        int8 File[255];
        PMob->objtype == TYPE_PET ? snprintf((char*)File, sizeof(File), "scripts/globals/pets/%s.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str()) :
            snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (prepFile(File, "onMobDisengage"))
        {
            return -1;
        }

        CLuaBaseEntity LuaMobEntity(PMob);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        lua_pushinteger(LuaHandle, weather);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onMobDisengage: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        return 0;
    }

    int32 OnMobDrawIn(CBaseEntity* PMob, CBaseEntity* PTarget)
    {
        TPZ_DEBUG_BREAK_IF(PTarget == nullptr || PMob == nullptr);

        CLuaBaseEntity LuaMobEntity(PMob);
        CLuaBaseEntity LuaKillerEntity(PTarget);

        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (PTarget->objtype != TYPE_PET && PTarget->objtype != TYPE_MOB)
        {
            ((CCharEntity*)PTarget)->m_event.reset();
            ((CCharEntity*)PTarget)->m_event.Target = PMob;
            ((CCharEntity*)PTarget)->m_event.Script.insert(0, (const char*)File);
        }

        if (prepFile(File, "onMobDrawIn"))
        {
            return -1;
        }

        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaKillerEntity);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onMobDrawIn: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);
        TPZ_DEBUG_BREAK_IF(PTarget == nullptr || PTarget->objtype == TYPE_NPC);

        CLuaBaseEntity LuaMobEntity(PMob);
        CLuaBaseEntity LuaKillerEntity(PTarget);

        int8 File[255];
        PMob->objtype == TYPE_PET ? snprintf((char*)File, sizeof(File), "scripts/globals/pets/%s.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str()) :
            snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (prepFile(File, "onMobFight"))
        {
            return -1;
        }

        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaKillerEntity);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onMobFight: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
        return 0;
    }

    int32 OnCriticalHit(CBattleEntity* PMob, CBattleEntity* PAttacker)
    {
        TPZ_DEBUG_BREAK_IF(PMob == nullptr || PMob->objtype != TYPE_MOB)

        CLuaBaseEntity LuaMobEntity(PMob);
        CLuaBaseEntity LuaKillerEntity(PAttacker);

        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (prepFile(File, "onCriticalHit"))
        {
            return -1;
        }

        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
        if (PAttacker)
            Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaKillerEntity);
        else
            lua_pushnil(LuaHandle);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onCriticalHit: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);

        CCharEntity* PChar = dynamic_cast<CCharEntity*>(PKiller);

        if (PChar && PMob->objtype == TYPE_MOB)
        {
            // onMobDeathEx
            lua_prepscript("scripts/globals/mobs.lua");

            PChar->ForAlliance([PMob, PChar, &File](CBattleEntity* PMember)
            {
                if (PMember->getZone() == PChar->getZone())
                {
                    if (prepFile(File, "onMobDeathEx"))
                    {
                        return;
                    }

                    CLuaBaseEntity LuaMobEntity(PMob);
                    CLuaBaseEntity LuaAllyEntity(PMember);
                    bool isKiller = PMember == PChar;
                    bool isWeaponSkillKill = PChar->getWeaponSkillKill();

                    Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
                    Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaAllyEntity);
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

            PChar->ForAlliance([PMob, PChar, &File](CBattleEntity* PPartyMember)
            {
                CCharEntity* PMember = (CCharEntity*)PPartyMember;
                if (PMember->getZone() == PChar->getZone())
                {
                    CLuaBaseEntity LuaMobEntity(PMob);
                    CLuaBaseEntity LuaAllyEntity(PMember);
                    bool isKiller = PMember == PChar;

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

                    Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
                    if (PMember)
                    {
                        CLuaBaseEntity LuaAllyEntity(PMember);
                        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaAllyEntity);
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
            memset(File, 0, sizeof(File));
            PMob->objtype == TYPE_PET ? snprintf((char*)File, sizeof(File), "scripts/globals/pets/%s.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str()) :
                snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());;

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

            Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
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

        return 0;
    }

    /************************************************************************
    *                                                                       *
    *                                                                       *
    *                                                                       *
    ************************************************************************/

    int32 OnMobSpawn(CBaseEntity* PMob)
    {
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);

        int8 File[255];
        PMob->objtype == TYPE_PET ? snprintf((char*)File, sizeof(File), "scripts/globals/pets/%s.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str()) :
            snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());
        if (prepFile(File, "onMobSpawn"))
        {
            return -1;
        }

        CLuaBaseEntity LuaMobEntity(PMob);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);


        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onMobSpawn: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }
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

        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

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
        TPZ_DEBUG_BREAK_IF(PMob == nullptr || PMob->objtype != TYPE_MOB)

            CLuaBaseEntity LuaMobEntity(PMob);

        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (prepFile(File, "onMobRoam"))
        {
            return -1;
        }

        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onMobRoam: %s\n", lua_tostring(LuaHandle, -1));
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

    int32 OnMobDespawn(CBaseEntity* PMob)
    {
        TPZ_DEBUG_BREAK_IF(PMob == nullptr);

        int8 File[255];
        PMob->objtype == TYPE_PET ? snprintf((char*)File, sizeof(File), "scripts/globals/pets/%s.lua", static_cast<CPetEntity*>(PMob)->GetScriptName().c_str()) :
            snprintf((char*)File, sizeof(File), "scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (prepFile(File, "onMobDespawn"))
        {
            return -1;
        }

        CLuaBaseEntity LuaMobEntity(PMob);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onMobDespawn: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
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
        lua_prepscript("scripts/zones/%s/Zone.lua", PZone->GetName());

        if (prepFile(File, "onGameHour"))
        {
            return -1;
        }
        CLuaZone LuaZone(PZone);
        Lunar<CLuaZone>::push(LuaHandle, &LuaZone);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onGameHour: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    int32 OnZoneWeatherChange(uint16 ZoneID, uint8 weather)
    {
        lua_prepscript("scripts/zones/%s/Zone.lua", zoneutils::GetZone(ZoneID)->GetName());

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

        return 0;
    }

    int32 OnTOTDChange(uint16 ZoneID, uint8 TOTD)
    {
        lua_prepscript("scripts/zones/%s/Zone.lua", zoneutils::GetZone(ZoneID)->GetName());

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

        return 0;
    }

    /************************************************************************
    *                                                                       *
    *                                                                       *
    *                                                                       *
    ************************************************************************/

    std::tuple<int32, uint8, uint8> OnUseWeaponSkill(CCharEntity* PChar, CBaseEntity* PMob, CWeaponSkill* wskill, uint16 tp, bool primary, action_t& action, CBattleEntity* taChar)
    {
        lua_prepscript("scripts/globals/weaponskills/%s.lua", wskill->getName());

        if (prepFile(File, "onUseWeaponSkill"))
        {
            return std::tuple<int32, uint8, uint8>();
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaMobEntity(PMob);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        lua_pushinteger(LuaHandle, wskill->getID());
        lua_pushnumber(LuaHandle, tp);
        lua_pushboolean(LuaHandle, primary);

        CLuaAction LuaAction(&action);
        Lunar<CLuaAction>::push(LuaHandle, &LuaAction);

        if (taChar == nullptr)
        {
            lua_pushnil(LuaHandle);
        }
        else
        {
            CLuaBaseEntity LuaTrickAttackEntity(taChar);
            Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaTrickAttackEntity);
        }


        if (lua_pcall(LuaHandle, 7, 4, 0))
        {
            ShowError("luautils::onUseWeaponSkill: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return std::tuple<int32, uint8, uint8>();
        }

        uint8 tpHitsLanded = (uint8)lua_tonumber(LuaHandle, -4);
        uint8 extraHitsLanded = (uint8)lua_tonumber(LuaHandle, -3);
        bool criticalHit = lua_toboolean(LuaHandle, -2);
        int32 dmg = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);

        if (criticalHit == true)
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
        lua_prepscript("scripts/zones/%s/mobs/%s.lua", PMob->loc.zone->GetName(), PMob->GetName());

        if (!prepFile(File, "onMobWeaponSkill"))
        {
            CLuaBaseEntity LuaBaseEntity(PTarget);
            Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

            CLuaBaseEntity LuaMobEntity(PMob);
            Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

            CLuaMobSkill LuaMobSkill(PMobSkill);
            Lunar<CLuaMobSkill>::push(LuaHandle, &LuaMobSkill);

            CLuaAction LuaAction(action);
            Lunar<CLuaAction>::push(LuaHandle, &LuaAction);

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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);
        CLuaBaseEntity LuaMobEntity(PMob);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);
        CLuaMobSkill LuaMobSkill(PMobSkill);
        Lunar<CLuaMobSkill>::push(LuaHandle, &LuaMobSkill);

        if (lua_pcall(LuaHandle, 3, 1, 0))
        {
            ShowError("luautils::onMobWeaponSkill: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        int32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 1);
        return retVal;
    }

    /***********************************************************************
    *                                                                       *
    *                                                                       *
    *                                                                       *
    ************************************************************************/

    int32 OnMobSkillCheck(CBaseEntity* PTarget, CBaseEntity* PMob, CMobSkill* PMobSkill)
    {
        lua_prepscript("scripts/globals/mobskills/%s.lua", PMobSkill->getName());

        if (prepFile(File, "onMobSkillCheck"))
        {
            return 1;
        }

        CLuaBaseEntity LuaBaseEntity(PTarget);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaMobEntity(PMob);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        CLuaMobSkill LuaMobSkill(PMobSkill);
        Lunar<CLuaMobSkill>::push(LuaHandle, &LuaMobSkill);

        if (lua_pcall(LuaHandle, 3, 1, 0))
        {
            ShowError("luautils::onMobSkillCheck (%s): %s\n", PMobSkill->getName(), lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 1;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : -5);
        lua_pop(LuaHandle, 1);
        return retVal;
    }

    int32 OnMobAutomatonSkillCheck(CBaseEntity* PTarget, CAutomatonEntity* PAutomaton, CMobSkill* PMobSkill)
    {
        lua_prepscript("scripts/globals/abilities/pets/%s.lua", PMobSkill->getName());

        if (prepFile(File, "onMobSkillCheck"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PTarget);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaMobEntity(PAutomaton);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        CLuaMobSkill LuaMobSkill(PMobSkill);
        Lunar<CLuaMobSkill>::push(LuaHandle, &LuaMobSkill);

        if (lua_pcall(LuaHandle, 3, 1, 0))
        {
            ShowError("luautils::OnMobAutomatonSkillCheck (%s): %s\n", PMobSkill->getName(), lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : -5);
        lua_pop(LuaHandle, 1);
        return retVal;
    }

    /***********************************************************************
    *                                                                       *
    *                                                                       *
    *                                                                       *
    ************************************************************************/

    int32 OnMagicCastingCheck(CBaseEntity* PChar, CBaseEntity* PTarget, CSpell* PSpell)
    {
        lua_prepscript(
            PSpell->getSpellGroup() == SPELLGROUP_BLUE ? "scripts/globals/spells/bluemagic/%s.lua" :
            PSpell->getSpellGroup() == SPELLGROUP_TRUST ? "scripts/globals/spells/trust/%s.lua" :
            "scripts/globals/spells/%s.lua", PSpell->getName()
        );

        if (prepFile(File, "onMagicCastingCheck"))
        {
            // ShowDebug("luautils::OnMagicCastingCheck: could not load %s/%s.lua \n", scriptPath, PSpell->getName());
            return 47;
        }

        CLuaBaseEntity LuaCharEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaCharEntity);

        CLuaBaseEntity LuaBaseEntity(PTarget);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaSpell LuaSpell(PSpell);
        Lunar<CLuaSpell>::push(LuaHandle, &LuaSpell);

        if (lua_pcall(LuaHandle, 3, 1, 0))
        {
            ShowError("luautils::onMagicCastingCheck (%s): %s\n", PSpell->getName(), lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 47;
        }

        uint32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : -5);
        lua_pop(LuaHandle, 1);
        return retVal;
    }

    /***********************************************************************
    *                                                                       *
    *                                                                       *
    *                                                                       *
    ************************************************************************/

    int32 OnAbilityCheck(CBaseEntity* PChar, CBaseEntity* PTarget, CAbility* PAbility, CBaseEntity** PMsgTarget)
    {
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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaCharEntity);

        CLuaBaseEntity LuaBaseEntity(PTarget);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaAbility LuaAbility(PAbility);
        Lunar<CLuaAbility>::push(LuaHandle, &LuaAbility);

        if (lua_pcall(LuaHandle, 3, 2, 0))
        {
            ShowError("luautils::onAbilityCheck (%s): %s\n", PAbility->getName(), lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 87;
        }

        if ((!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0) != 0)
            *PMsgTarget = (CBaseEntity*)PTarget;

        uint32 retVal = (!lua_isnil(LuaHandle, -2) && lua_isnumber(LuaHandle, -2) ? (int32)lua_tonumber(LuaHandle, -2) : -5);
        lua_pop(LuaHandle, 2);
        return retVal;
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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaMobEntity(PMob);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        CLuaMobSkill LuaMobSkill(PMobSkill);
        Lunar<CLuaMobSkill>::push(LuaHandle, &LuaMobSkill);

        CLuaBaseEntity LuaMasterEntity(PMobMaster);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMasterEntity);

        CLuaAction LuaAction(action);
        Lunar<CLuaAction>::push(LuaHandle, &LuaAction);

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
            if (PPet->getPetType() == PETTYPE_AVATAR && PPet->PMaster->objtype == TYPE_PC)
            {
                CCharEntity* PMaster = (CCharEntity*)PPet->PMaster;
                if (PMaster->GetMJob() == JOB_SMN) charutils::TrySkillUP(PMaster, SKILL_SUMMONING_MAGIC, PMaster->GetMLevel());
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
        std::string path = "scripts/globals/abilities/%s.lua";
        if (PUser->objtype == TYPE_PET) path = "scripts/globals/abilities/pets/%s.lua";
        lua_prepscript(path.c_str(), PAbility->getName());

        if (prepFile(File, "onUseAbility"))
        {
            return 0;
        }

        CLuaBaseEntity LuaBaseEntity(PUser);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaMobEntity(PTarget);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaMobEntity);

        CLuaAbility LuaAbility(PAbility);
        Lunar<CLuaAbility>::push(LuaHandle, &LuaAbility);

        CLuaAction LuaAction(action);
        Lunar<CLuaAction>::push(LuaHandle, &LuaAction);

        if (lua_pcall(LuaHandle, 4, 1, 0))
        {
            ShowError("luautils::onUseAbility: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        int32 retVal = (!lua_isnil(LuaHandle, -1) && lua_isnumber(LuaHandle, -1) ? (int32)lua_tonumber(LuaHandle, -1) : 0);
        lua_pop(LuaHandle, 1);
        return retVal;
    }

    int32 clearVarFromAll(lua_State *L)
    {
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isstring(L, -1));

        const char* varname = lua_tostring(L, -1);

        Sql_Query(SqlHandle, "DELETE FROM char_vars WHERE varname = '%s';", varname);

        return 0;
    }

    int32 terminate(lua_State*)
    {
        zoneutils::ForEachZone([](CZone* PZone)
        {
            PZone->ForEachChar([](CCharEntity* PChar)
            {
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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaEntity);

        CLuaInstance LuaInstance(PInstance);
        Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::afterInstanceRegister: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return;
        }

        return;
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
        Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

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
        Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

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
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBaseEntity LuaTargetEntity(PChar->m_event.Target);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaTargetEntity);

        if (PInstance)
        {
            CLuaInstance LuaInstance(PInstance);
            Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);
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
        Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

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
        Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

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
        Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

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
        Lunar<CLuaInstance>::push(LuaHandle, &LuaInstance);

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

    int32 StartElevator(lua_State* L)
    {
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

        uint32 ElevatorID = (uint32)lua_tointeger(L, -1);
        CTransportHandler::getInstance()->startElevator(ElevatorID);
        return 0;
    }

    /************************************************************************
    *                                                                       *
    *  Получаем значение глобальной переменной сервера.                     *
    *  Переменная действительна лишь в пределах зоны, в которой установлена *
    *                                                                       *
    ************************************************************************/

    int32 GetServerVariable(lua_State *L)
    {
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isstring(L, -1));

        int32 value = 0;

        int32 ret = Sql_Query(SqlHandle, "SELECT value FROM server_variables WHERE name = '%s' LIMIT 1;", lua_tostring(L, -1));

        if (ret != SQL_ERROR &&
            Sql_NumRows(SqlHandle) != 0 &&
            Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            value = (int32)Sql_GetIntData(SqlHandle, 0);
        }
        lua_pushinteger(L, value);
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *  Устанавливаем значение глобальной переменной сервера.                *
    *                                                                       *
    ************************************************************************/

    int32 SetServerVariable(lua_State *L)
    {
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, -2) || !lua_isstring(L, -2));

        const char* name = lua_tostring(L, -2);
        int32 value = (int32)lua_tointeger(L, -1);

        if (value == 0)
        {
            Sql_Query(SqlHandle, "DELETE FROM server_variables WHERE name = '%s' LIMIT 1;", name);
            return 0;
        }
        Sql_Query(SqlHandle, "INSERT INTO server_variables VALUES ('%s', %i) ON DUPLICATE KEY UPDATE value = %i;", name, value, value);

        return 0;
    }

    /************************************************************************
    *                                                                       *
    *                                                                       *
    *                                                                       *
    ************************************************************************/

    int32 OnTransportEvent(CCharEntity* PChar, uint32 TransportID)
    {
        lua_prepscript("scripts/zones/%s/Zone.lua", PChar->loc.zone->GetName());

        if (prepFile(File, "onTransportEvent"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushinteger(LuaHandle, TransportID);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onTransportEvent: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    int32 OnTimeTrigger(CNpcEntity* PNpc, uint8 triggerID)
    {
        lua_prepscript("scripts/zones/%s/npcs/%s.lua", PNpc->loc.zone->GetName(), PNpc->GetName());

        if (prepFile(File, "onTimeTrigger"))
        {
            return -1;
        }

        CLuaBaseEntity LuaBaseEntity(PNpc);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushinteger(LuaHandle, triggerID);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onTimeTrigger: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    int32 OnConquestUpdate(CZone* PZone, ConquestUpdate type)
    {
        lua_prepscript("scripts/zones/%s/Zone.lua", PZone->GetName());

        if (prepFile(File, "onConquestUpdate"))
        {
            return -1;
        }
        CLuaZone LuaZone(PZone);
        Lunar<CLuaZone>::push(LuaHandle, &LuaZone);

        lua_pushinteger(LuaHandle, type);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onConquestUpdate: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    /********************************************************************
        onBattlefieldEnter - callback when you enter a BCNM via a lua call to bcnmEnter(bcnmid)
    *********************************************************************/
    int32 OnBattlefieldEnter(CCharEntity* PChar, CBattlefield* PBattlefield)
    {

        CZone* PZone = PChar->loc.zone == nullptr ? zoneutils::GetZone(PChar->loc.destination) : PChar->loc.zone;

        lua_prepscript("scripts/zones/%s/bcnms/%s.lua", PZone->GetName(), PBattlefield->GetName().c_str());

        if (prepFile(File, "onBattlefieldEnter"))
        {
            return 0;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBattlefield LuaBattlefieldEntity(PBattlefield);
        Lunar<CLuaBattlefield>::push(LuaHandle, &LuaBattlefieldEntity);

        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onBattlefieldEnter: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        return 0;
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
    int32 OnBattlefieldLeave(CCharEntity* PChar, CBattlefield* PBattlefield, uint8 LeaveCode)
    {

        CZone* PZone = PChar->loc.zone == nullptr ? zoneutils::GetZone(PChar->loc.destination) : PChar->loc.zone;

        lua_prepscript("scripts/zones/%s/bcnms/%s.lua", PZone->GetName(), PBattlefield->GetName().c_str());

        if (prepFile(File, "onBattlefieldLeave"))
        {
            return 0;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBattlefield LuaBattlefieldEntity(PBattlefield);
        Lunar<CLuaBattlefield>::push(LuaHandle, &LuaBattlefieldEntity);

        lua_pushinteger(LuaHandle, LeaveCode);

        PChar->m_event.reset();
        PChar->m_event.Target = PChar;
        PChar->m_event.Script.insert(0, (const char*)File);

        if (lua_pcall(LuaHandle, 3, 0, 0))
        {
            ShowError("luautils::onBattlefieldLeave: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        return 0;
    }

    /********************************************************************
        onBattlefieldRegister - callback when you successfully register a BCNM.
        For example, trading an orb, selecting the battle.
        Called AFTER assigning BCNM status to all valid characters.
        This callback is called only for the character initiating the
        registration, and after CBattlefield:init() procedure.
    *********************************************************************/
    int32 OnBattlefieldRegister(CCharEntity* PChar, CBattlefield* PBattlefield)
    {
        CZone* PZone = PChar->loc.zone == nullptr ? zoneutils::GetZone(PChar->loc.destination) : PChar->loc.zone;

        lua_prepscript("scripts/zones/%s/bcnms/%s.lua", PZone->GetName(), PBattlefield->GetName().c_str());

        if (prepFile(File, "onBattlefieldRegister"))
        {
            return 0;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        CLuaBattlefield LuaBattlefieldEntity(PBattlefield);
        Lunar<CLuaBattlefield>::push(LuaHandle, &LuaBattlefieldEntity);
        if (lua_pcall(LuaHandle, 2, 0, 0))
        {
            ShowError("luautils::onBattlefieldRegister: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        return 0;
    }

    /********************************************************************
    onBattlefieldDestroy - called when BCNM is destroyed (cleanup)
    *********************************************************************/
    int32 OnBattlefieldDestroy(CBattlefield* PBattlefield)
    {
        lua_prepscript("scripts/zones/%s/bcnms/%s.lua", PBattlefield->GetZone()->GetName(), PBattlefield->GetName().c_str());

        if (prepFile(File, "onBattlefieldDestroy"))
        {
            return 0;
        }

        CLuaBattlefield LuaBattlefieldEntity(PBattlefield);
        Lunar<CLuaBattlefield>::push(LuaHandle, &LuaBattlefieldEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onBattlefieldDestroy: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return 0;
        }

        return 0;
    }
    /************************************************************************
    *                                                                       *
    * Set SpawnType of mob to scripted (128) or normal (0) usind mob id     *
    *                                                                       *
    ************************************************************************/
    int32 DisallowRespawn(lua_State* L)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint32 mobid = (uint32)lua_tointeger(L, 1);
            CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB);

            if (PMob != nullptr)
            {
                if (!lua_isnil(L, 2) && lua_isboolean(L, 2))
                {
                    PMob->m_AllowRespawn = !lua_toboolean(L, 2);
                    //ShowDebug(CL_RED"DisallowRespawn: Mob <%u> DisallowRespawn is now <%s>.\n" CL_RESET, mobid, PMob->m_AllowRespawn ? "true" : "false");
                    return 0;
                }
                else
                {
                    ShowDebug(CL_RED"DisallowRespawn: Boolean parameter not given, mob <%u> SpawnType unchanged.\n" CL_RESET, mobid);
                }
            }
            else
            {
                ShowDebug(CL_RED"DisallowRespawn: mob <%u> not found\n" CL_RESET, mobid);
            }
            return 0;
        }
        lua_pushnil(L);
        return 1;
    }

    /************************************************************************
    *                                                                       *
    * Update the NM spawn point to a new point, retrieved from the database *
    *                                                                       *
    ************************************************************************/

    int32 UpdateNMSpawnPoint(lua_State* L)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            uint32 mobid = (uint32)lua_tointeger(L, 1);
            CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB);

            if (PMob != nullptr)
            {
                int32 r = 0;
                int32 ret = Sql_Query(SqlHandle, "SELECT count(mobid) FROM `nm_spawn_points` where mobid=%u", mobid);
                if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS && Sql_GetUIntData(SqlHandle, 0) > 0)
                {
                    r = tpzrand::GetRandomNumber(Sql_GetUIntData(SqlHandle, 0));
                }
                else
                {
                    ShowDebug(CL_RED"UpdateNMSpawnPoint: SQL error: No entries for mobid <%u> found.\n" CL_RESET, mobid);
                    return 0;
                }

                ret = Sql_Query(SqlHandle, "SELECT pos_x, pos_y, pos_z FROM `nm_spawn_points` WHERE mobid=%u AND pos=%i", mobid, r);
                if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    PMob->m_SpawnPoint.rotation = tpzrand::GetRandomNumber(256);
                    PMob->m_SpawnPoint.x = Sql_GetFloatData(SqlHandle, 0);
                    PMob->m_SpawnPoint.y = Sql_GetFloatData(SqlHandle, 1);
                    PMob->m_SpawnPoint.z = Sql_GetFloatData(SqlHandle, 2);
                    //ShowDebug(CL_RED"UpdateNMSpawnPoint: After %i - %f, %f, %f, %i\n" CL_RESET, r, PMob->m_SpawnPoint.x,PMob->m_SpawnPoint.y,PMob->m_SpawnPoint.z,PMob->m_SpawnPoint.rotation);
                }
                else
                {
                    ShowDebug(CL_RED"UpdateNMSpawnPoint: SQL error or NM <%u> not found in nmspawnpoints table.\n" CL_RESET, mobid);
                }
            }
            else
            {
                ShowDebug(CL_RED"UpdateNMSpawnPoint: mob <%u> not found\n" CL_RESET, mobid);
            }
            return 0;
        }
        lua_pushnil(L);
        return 1;
    }

    /************************************************************************
    *                                                                       *
    *  Get Mob Respawn Time in seconds by Mob ID.                           *
    *                                                                       *
    ************************************************************************/

    int32 GetMobRespawnTime(lua_State* L)
    {
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, -1) || !lua_isnumber(L, -1));

        uint32 mobid = (uint32)lua_tointeger(L, -1);
        CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB);

        if (PMob != nullptr)
        {
            uint32 RespawnTime = (uint32)PMob->m_RespawnTime / 1000;
            lua_pushinteger(L, RespawnTime);
            return 1;
        }
        ShowError(CL_RED"luautils::GetMobAction: mob <%u> was not found\n" CL_RESET, mobid);
        lua_pushnil(L);
        return 1;
    }

    /************************************************************************
    *   Change drop rate of a mob                                           *
    *   1st number: dropid in mob_droplist.sql                              *
    *   2nd number: itemid in mob_droplist.sql                              *
    *   3rd number: new rate                                                *
    ************************************************************************/

    int32 SetDropRate(lua_State *L)
    {
        DropList_t* DropList = itemutils::GetDropList((uint16)lua_tointeger(L, 1));

        if (DropList != nullptr)
        {
            for (uint8 i = 0; i < DropList->Items.size(); ++i)
            {
                if (DropList->Items.at(i).ItemID == lua_tointeger(L, 2))
                {
                    DropList->Items.at(i).DropRate = (uint16)lua_tointeger(L, 3);
                    return 1;
                }
            }
        }

        return 0;
    }

    int32 GetHealingTickDelay(lua_State* L) {
        lua_pushnumber(L, map_config.healing_tick_delay);
        return 1;
    }

    int32 getAbility(lua_State* L)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            CAbility* PAbility = ability::GetAbility((uint16)lua_tointeger(L, 1));

            lua_getglobal(L, CLuaAbility::className);
            lua_pushstring(L, "new");
            lua_gettable(L, -2);
            lua_insert(L, -2);
            lua_pushlightuserdata(L, (void*)PAbility);
            lua_pcall(L, 2, 1, 0);

            return 1;
        }
        return 0;
    }

    int32 getSpell(lua_State* L)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1))
        {
            CSpell* PSpell = spell::GetSpell(static_cast<SpellID>(lua_tointeger(L, 1)));

            lua_getglobal(L, CLuaSpell::className);
            lua_pushstring(L, "new");
            lua_gettable(L, -2);
            lua_insert(L, -2);
            lua_pushlightuserdata(L, (void*)PSpell);
            lua_pcall(L, 2, 1, 0);

            return 1;
        }
        return 0;
    }

    int32 UpdateServerMessage(lua_State* L)
    {
        int8 line[1024];
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

        // Ensure both messages have nullptr terminates..
        if (map_config.server_message.at(map_config.server_message.length() - 1) != 0x00)
        {
            map_config.server_message += (char)0x00;
        }

        return 0;
    }

    inline int32 nearLocation(lua_State* L)
    {
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1));
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, 2) || !lua_isnumber(L, 2));
        TPZ_DEBUG_BREAK_IF(lua_isnil(L, 3) || !lua_isnumber(L, 3));

        position_t center;
        lua_getfield(L, 1, "x");
        center.x = (float)lua_tonumber(L, -1);
        lua_getfield(L, 1, "y");
        center.y = (float)lua_tonumber(L, -1);
        lua_getfield(L, 1, "z");
        center.z = (float)lua_tonumber(L, -1);
        lua_getfield(L, 1, "rot");
        center.rotation = (uint8)lua_tonumber(L, -1);

        float radius = (float)lua_tonumber(L, 2);
        float theta = (float)lua_tonumber(L, 3);

        position_t pos = nearPosition(center, radius, theta);

        lua_createtable(L, 3, 0);
        int8 newTable = lua_gettop(L);

        lua_pushnumber(L, pos.x);
        lua_setfield(L, newTable, "x");

        lua_pushnumber(L, pos.y);
        lua_setfield(L, newTable, "y");

        lua_pushnumber(L, pos.z);
        lua_setfield(L, newTable, "z");

        return 1;
    }


    int32 OnPlayerLevelUp(CCharEntity* PChar)
    {
        lua_prepscript("scripts/globals/player.lua");
        if (prepFile(File, "onPlayerLevelUp"))
            return -1;

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onPlayerLevelUp: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    int32 OnPlayerLevelDown(CCharEntity* PChar)
    {
        lua_prepscript("scripts/globals/player.lua");
        if (prepFile(File, "onPlayerLevelDown"))
            return -1;

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onPlayerLevelDown: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return -1;
        }

        return 0;
    }

    bool OnChocoboDig(CCharEntity* PChar, bool pre)
    {
        lua_prepscript("scripts/zones/%s/Zone.lua", PChar->loc.zone->GetName());

        if (prepFile(File, "onChocoboDig"))
            return false;

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        lua_pushboolean(LuaHandle, pre);

        if (lua_pcall(LuaHandle, 2, 1, 0))
        {
            ShowError("luautils::onChocoboDig: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
            return false;
        }

        bool canDig = lua_toboolean(LuaHandle, -1);
        lua_pop(LuaHandle, 1);

        return canDig;
    }

    /************************************************************************
    *   Loads a Lua function with a fallback hierarchy                      *
    *                                                                       *
    *   1) 1st try: PChar->m_event.Script                                   *
    *   2) 2nd try: The instance script if the player is in one             *
    *   3) 3rd try: The zone script for the zone the player is in           *
    *                                                                       *
    ************************************************************************/
    bool LoadEventScript(CCharEntity* PChar, const char* functionName)
    {
        auto searchLuaFileForFunction = [&functionName](std::string filename)
        {
            if (!(luaL_loadfile(LuaHandle, filename.c_str()) || lua_pcall(LuaHandle, 0, 0, 0)))
            {
                lua_getglobal(LuaHandle, functionName);
                if (!(lua_isnil(LuaHandle, -1)))
                {
                    return true;
                }
            }
            lua_pop(LuaHandle, 1);
            return false;
        };

        return searchLuaFileForFunction(PChar->m_event.Script) ||
            (PChar->PInstance && searchLuaFileForFunction(std::string("scripts/zones/") + (const char*)PChar->loc.zone->GetName() + "/instances/" + (const char*)PChar->PInstance->GetName())) ||
            (searchLuaFileForFunction(std::string("scripts/zones/") + (const char*)PChar->loc.zone->GetName() + "/Zone.lua"));
    }

    uint16 GetDespoilDebuff(uint16 itemId)
    {
        uint16 effectId = 0;
        int32 ret = Sql_Query(SqlHandle, "SELECT effectId FROM despoil_effects WHERE itemId = %u", itemId);
        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            effectId = (uint16)Sql_GetUIntData(SqlHandle, 0);
        }

        return effectId;
    }

    void OnFurniturePlaced(CCharEntity* PChar, CItemFurnishing* PItem)
    {
        lua_prepscript("scripts/globals/items/%s.lua", PItem->getName());

        if (prepFile(File, "onFurniturePlaced"))
        {
            return;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onFurniturePlaced: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
        }
    }

    void OnFurnitureRemoved(CCharEntity* PChar, CItemFurnishing* PItem)
    {
        lua_prepscript("scripts/globals/items/%s.lua", PItem->getName());

        if (prepFile(File, "onFurnitureRemoved"))
        {
            return;
        }

        CLuaBaseEntity LuaBaseEntity(PChar);
        Lunar<CLuaBaseEntity>::push(LuaHandle, &LuaBaseEntity);

        if (lua_pcall(LuaHandle, 1, 0, 0))
        {
            ShowError("luautils::onFurnitureRemoved: %s\n", lua_tostring(LuaHandle, -1));
            lua_pop(LuaHandle, 1);
        }
    }

}; // namespace luautils
