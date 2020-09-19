/*
 * roe.cpp
 *      Author: Kreidos | github.com/kreidos
 *
===========================================================================

  Copyright (c) 2020 Topaz Dev Teams

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

#include "roe.h"
#include "../common/lua/lunar.h"
#include "lua/luautils.h"
#include "packets/chat_message.h"
#include "utils/charutils.h"

#include "packets/roe_questlog.h"
#include "packets/roe_sparkupdate.h"
#include "packets/roe_update.h"

std::array<RoeCheckHandler, ROE_NONE> RoeHandlers;
RoeSystemData roeutils::RoeCache;

namespace roeutils
{
void init()
{
    lua_State* L = luautils::LuaHandle;
    lua_register(L, "RoeRegisterHandler", roeutils::RegisterHandler);
    lua_register(L, "RoeParseRecords", roeutils::ParseRecords);
    RoeHandlers.fill(RoeCheckHandler());
}

int32 RegisterHandler(lua_State* L)
{
    if (lua_gettop(L) < 1 || !lua_isnumber(L, 1))
    {
        ShowError("ROEUtils: Invalid call to RegisterHandler.");
    }

    // Get Handler Event Type
    auto event = lua_tointeger(L, 1);
    if (event == 0 || event >= ROE_NONE)
    {
        ShowError("ROEUtils: Unknown Record trigger index %d.", event);
        return 0;
    }

    RoeHandlers[event] = RoeCheckHandler();

    // Build caching bitset from records
    lua_getglobal(L, "tpz");
    lua_getfield(L, -1, "roe");
    lua_getfield(L, -1, "records");
    lua_pushnil(L);
    while (lua_next(L, -2) != 0)
    {
        lua_getfield(L, -1, "trigger");
        uint32 recordID = static_cast<uint32>(lua_tointeger(L, -3));
        uint32 trigger = static_cast<uint32>(lua_tointeger(L, -1));
        lua_pop(L, 2);
        if (trigger == event)
            RoeHandlers[event].bitmap.set(recordID);
    }

    //        ShowDebug("\nRegistered RoE Handler %d... ", evtype);

    return 0;
}

int32 ParseRecords(lua_State* L)
{
    roeutils::RoeCache.ImplementedRecords.reset();
    roeutils::RoeCache.RepeatableRecords.reset();
    roeutils::RoeCache.NotifyThresholds.fill(1);

    if (lua_isnil(L, -1) || !lua_istable(L, -1))
        return 0;

    // Build caching bitsets from records
    lua_pushnil(L);
    while (lua_next(L, -2) != 0)
    {
        // Set Implemented bit.
        uint32 recordID = static_cast<uint32>(lua_tointeger(L, -2));
        roeutils::RoeCache.ImplementedRecords.set(recordID);

        // Set notification threshold
        lua_getfield(L, -1, "notify");
        if (!lua_isnil(L, -1))
            roeutils::RoeCache.NotifyThresholds[recordID] = static_cast<uint32>((lua_tointeger(L, -1)));
        lua_pop(L, 1);

        // Set repeatability bit
        lua_getfield(L, -1, "reward");
        if (!lua_isnil(L, -1))
        {
            lua_getfield(L, -1, "repeatable");
            if (lua_toboolean(L, -1))
            {
                roeutils::RoeCache.RepeatableRecords.set(recordID);
            }
            lua_pop(L, 1);
        }
        lua_pop(L, 1);

        lua_pop(L, 1);
    }
    // ShowInfo("\nRoEUtils: %d record entries parsed & available.", RoeBitmaps.ImplementedRecords.count());
    return 0;
}

bool event(ROE_EVENT eventID, CCharEntity* PChar, RoeDatagramList payload)
{
    if (!PChar || PChar->objtype != TYPE_PC)
        return false;

    RoeCheckHandler& handler = RoeHandlers[eventID];

    // Bail if player has no records of this type.
    if ((PChar->m_eminenceCache.activemap & handler.bitmap).none())
        return 0;

    lua_State* L = luautils::LuaHandle;
    uint32 stackTop = lua_gettop(L);
    lua_getglobal(L, "tpz");
    lua_getfield(L, -1, "roe");

    // Call onRecordTrigger for each record of this type
    for (int i = 0; PChar->m_eminenceLog.active[i] != 0; i++)
    {
        // Check record is of this type
        if (handler.bitmap.test(PChar->m_eminenceLog.active[i]))
        {
            lua_getfield(L, -1, "onRecordTrigger");
            uint8 args { 0 };

            CLuaBaseEntity LuaAllyEntity(PChar);
            Lunar<CLuaBaseEntity>::push(L, &LuaAllyEntity);
            args++;

            // Record #
            lua_pushinteger(L, PChar->m_eminenceLog.active[i]);
            args++;

            // param table
            lua_newtable(L);
            args++;

            lua_pushinteger(L, PChar->m_eminenceLog.progress[i]);
            lua_setfield(L, -2, "progress");

            for (auto& datagram : payload)
            {
                lua_pushstring(L, datagram.param.c_str());
                switch (datagram.type)
                {
                case RoeDatagramPayload::mob:
                {
                    CLuaBaseEntity LuaMobEntity(datagram.data.mobEntity);
                    Lunar<CLuaBaseEntity>::push(L, &LuaMobEntity);
                    break;
                }
                case RoeDatagramPayload::uinteger:
                {
                    lua_pushinteger(L, datagram.data.uinteger);
                    break;
                }
                }
                lua_settable(L, -3);
            }

            if (lua_pcall(L, args, 0, 0))
            {
                ShowError("roeutils::onRecordTrigger: %s\n", lua_tostring(L, -1));
                lua_pop(L, 1);
            }
        }
    }
    lua_settop(L, stackTop);
    return true;
}

bool event(ROE_EVENT eventID, CCharEntity* PChar, RoeDatagram data) // shorthand for single-datagram calls.
{
    return event(eventID, PChar, RoeDatagramList { data });
}

bool event(ROE_EVENT eventID, CCharEntity* PChar) // shorthand for no-datagram calls.
{
    return event(eventID, PChar, RoeDatagramList {});
}

void SetEminenceRecordCompletion(CCharEntity* PChar, uint16 recordID, bool newStatus)
{
    uint16 page = recordID / 8;
    uint8 bit = recordID % 8;
    if (newStatus)
        PChar->m_eminenceLog.complete[page] |= (1 << bit);
    else
        PChar->m_eminenceLog.complete[page] &= ~(1 << bit);

    for (int i = 0; i < 4; i++)
    {
        PChar->pushPacket(new CRoeQuestLogPacket(PChar, i));
    }
    charutils::SaveEminenceData(PChar);
}

bool GetEminenceRecordCompletion(CCharEntity* PChar, uint16 recordID)
{
    uint16 page = recordID / 8;
    uint8 bit = recordID % 8;
    return PChar->m_eminenceLog.complete[page] & (1 << bit);
}

bool AddEminenceRecord(CCharEntity* PChar, uint16 recordID)
{

    // We deny taking records which aren't implemented in the Lua
    if (!roeutils::RoeCache.ImplementedRecords.test(recordID))
    {
        std::string message = "The record #" + std::to_string(recordID) + " is not implemented at this time.";
        PChar->pushPacket(new CChatMessagePacket(PChar, MESSAGE_NS_SAY, message, "RoE System"));
        return false;
    }

    // Prevent packet-injection for re-taking completed records which aren't marked repeatable.
    if (roeutils::GetEminenceRecordCompletion(PChar, recordID) && !roeutils::RoeCache.RepeatableRecords.test(recordID))
        return false;

    // Per above, this i < 30 is correct.
    for (int i = 0; i < 30; i++)
    {
        if (PChar->m_eminenceLog.active[i] == 0)
        {
            PChar->m_eminenceLog.active[i] = recordID;
            PChar->m_eminenceCache.activemap.set(recordID);

            PChar->pushPacket(new CRoeUpdatePacket(PChar));
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, recordID, 0, MSGBASIC_ROE_START));
            charutils::SaveEminenceData(PChar);
            return true;
        }
        else if (PChar->m_eminenceLog.active[i] == recordID)
        {
            return false;
        }
    }
    return false;
}

bool DelEminenceRecord(CCharEntity* PChar, uint16 recordID)
{
    for (int i = 0; i < 31; i++)
    {
        if (PChar->m_eminenceLog.active[i] == recordID)
        {
            PChar->m_eminenceLog.active[i] = 0;
            PChar->m_eminenceLog.progress[i] = 0;
            PChar->m_eminenceCache.activemap.reset(recordID);
            // Shift entries up so records are shown in retail-accurate order.
            for (int j = i; j < 29 && PChar->m_eminenceLog.active[j + 1] != 0; j++)
            {
                std::swap(PChar->m_eminenceLog.active[j], PChar->m_eminenceLog.active[j + 1]);
                std::swap(PChar->m_eminenceLog.progress[j], PChar->m_eminenceLog.progress[j + 1]);
            }
            PChar->pushPacket(new CRoeUpdatePacket(PChar));
            charutils::SaveEminenceData(PChar);
            return true;
        }
    }
    return false;
}

bool HasEminenceRecord(CCharEntity* PChar, uint16 recordID)
{
    return PChar->m_eminenceCache.activemap.test(recordID);
}

uint32 GetEminenceRecordProgress(CCharEntity* PChar, uint16 recordID)
{
    for (int i = 0; i < 31; i++)
    {
        if (PChar->m_eminenceLog.active[i] == recordID)
        {
            return PChar->m_eminenceLog.progress[i];
        }
    }
    return 0;
}

bool SetEminenceRecordProgress(CCharEntity* PChar, uint16 recordID, uint32 progress)
{
    for (int i = 0; i < 31; i++)
    {
        if (PChar->m_eminenceLog.active[i] == recordID)
        {
            if (PChar->m_eminenceLog.progress[i] == progress)
                return true;

            PChar->m_eminenceLog.progress[i] = progress;
            PChar->pushPacket(new CRoeUpdatePacket(PChar));
            charutils::SaveEminenceData(PChar);
            return true;
        }
    }
    return false;
}

} /* namespace roe */
