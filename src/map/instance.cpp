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

#include <thread>

#include "instance.h"

#include "zone.h"
#include "ai/ai_container.h"
#include "entities/charentity.h"
#include "lua/luautils.h"

#include "../common/timer.h"


CInstance::CInstance(CZone* zone, uint8 instanceid) : CZoneEntities(zone),
    m_instanceid(instanceid)
{
    LoadInstance();

    m_startTime = server_clock::now();
    m_wipeTimer = m_startTime;
}

CInstance::~CInstance()
{
    for (auto entity : m_mobList)
    {
        delete entity.second;
    }
    for (auto entity : m_npcList)
    {
        delete entity.second;
    }
    for (auto entity : m_petList)
    {
        delete entity.second;
    }
    for (auto entity : m_trustList)
    {
        delete entity.second;
    }
}

uint8 CInstance::GetID()
{
    return m_instanceid;
}

uint32 CInstance::GetProgress()
{
    return m_progress;
}

uint32 CInstance::GetStage()
{
    return m_stage;
}

/************************************************************************
*                                                                       *
*  Loads instances settings from instance_list                          *
*                                                                       *
************************************************************************/

void CInstance::LoadInstance()
{
    static const char* Query =
        "SELECT "
        "instance_name, "
        "time_limit, "
        "entrance_zone, "
        "start_x, "
        "start_y, "
        "start_z, "
        "start_rot, "
        "music_day, "
        "music_night, "
        "battlesolo, "
        "battlemulti "
        "FROM instance_list "
        "WHERE instanceid = %u "
        "LIMIT 1";

    if (Sql_Query(SqlHandle, Query, m_instanceid) != SQL_ERROR &&
        Sql_NumRows(SqlHandle) != 0 &&
        Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        m_instanceName.insert(0, (const char*)Sql_GetData(SqlHandle, 0));

        m_timeLimit = std::chrono::minutes(Sql_GetUIntData(SqlHandle, 1));
        m_entrance = Sql_GetUIntData(SqlHandle, 2);
        m_entryloc.x = Sql_GetFloatData(SqlHandle, 3);
        m_entryloc.y = Sql_GetFloatData(SqlHandle, 4);
        m_entryloc.z = Sql_GetFloatData(SqlHandle, 5);
        m_entryloc.rotation = Sql_GetUIntData(SqlHandle, 6);
        m_zone_music_override.m_songDay = Sql_GetUIntData(SqlHandle, 7);
        m_zone_music_override.m_songNight = Sql_GetUIntData(SqlHandle, 8);
        m_zone_music_override.m_bSongS = Sql_GetUIntData(SqlHandle, 9);
        m_zone_music_override.m_bSongM = Sql_GetUIntData(SqlHandle, 10);
    }
    else
    {
        ShowFatalError(CL_RED"CZone::LoadInstance: Cannot load instance %u\n" CL_RESET, m_instanceid);
        Fail();
    }
}

/************************************************************************
*                                                                       *
*  Registers a char to the char list (and sets first one as leader)     *
*                                                                       *
************************************************************************/

void CInstance::RegisterChar(CCharEntity* PChar)
{
    if (m_registeredChars.empty())
    {
        m_commander = PChar->id;
    }
    m_registeredChars.push_back(PChar->id);
}

uint8 CInstance::GetLevelCap()
{
    return m_levelcap;
}

const int8* CInstance::GetName()
{
    return (const int8*)m_instanceName.c_str();
}

position_t CInstance::GetEntryLoc()
{
    return m_entryloc;
}

duration CInstance::GetTimeLimit()
{
    return m_timeLimit;
}

duration CInstance::GetLastTimeUpdate()
{
    return m_lastTimeUpdate;
}

duration CInstance::GetWipeTime()
{
    return m_wipeTimer - m_startTime;
}

duration CInstance::GetElapsedTime(time_point tick)
{
    return tick - m_startTime;
}

void CInstance::SetLevelCap(uint8 cap)
{
    m_levelcap = cap;
}

void CInstance::SetEntryLoc(float x, float y, float z, float rot)
{
    m_entryloc.x = x;
    m_entryloc.y = y;
    m_entryloc.z = z;
    m_entryloc.rotation = (uint8)rot;
}

void CInstance::SetLastTimeUpdate(duration lastTime)
{
    m_lastTimeUpdate = lastTime;
}

void CInstance::SetProgress(uint32 progress)
{
    m_progress = progress;
    luautils::OnInstanceProgressUpdate(this);
}

void CInstance::SetStage(uint32 stage)
{
    m_stage = stage;
}

void CInstance::SetWipeTime(duration time)
{
    m_wipeTimer = time + m_startTime;
}

/************************************************************************
*                                                                       *
*  Checks if the instance has expired.  If not, runs instance timer     *
*                                                                       *
************************************************************************/

void CInstance::CheckTime(time_point tick)
{
    if (m_lastTimeCheck + 1s <= tick && !Failed())
    {
        luautils::OnInstanceTimeUpdate(GetZone(), this, (uint32)std::chrono::duration_cast<std::chrono::milliseconds>(GetElapsedTime(tick)).count());
        m_lastTimeCheck = tick;
    }
}

bool CInstance::CharRegistered(CCharEntity* PChar)
{
    for (auto id : m_registeredChars)
    {
        if (PChar->id == id)
        {
            return true;
        }
    }
    return false;
}

void CInstance::ClearEntities()
{
    auto clearStates = [](auto& entity)
    {
        if (static_cast<CBattleEntity*>(entity.second)->isAlive())
        {
            entity.second->PAI->ClearStateStack();
        }
    };
    std::for_each(m_charList.cbegin(), m_charList.cend(), clearStates);
    std::for_each(m_mobList.cbegin(), m_mobList.cend(), clearStates);
    std::for_each(m_petList.cbegin(), m_petList.cend(), clearStates);
    std::for_each(m_trustList.cbegin(), m_trustList.cend(), clearStates);
}

void CInstance::Fail()
{
    Cancel();

    ClearEntities();

    luautils::OnInstanceFailure(this);
}

bool CInstance::Failed()
{
    return m_status == INSTANCE_FAILED;
}

void CInstance::Complete()
{
    m_status = INSTANCE_COMPLETE;

    ClearEntities();

    luautils::OnInstanceComplete(this);
}

bool CInstance::Completed()
{
    return m_status == INSTANCE_COMPLETE;
}

void CInstance::Cancel()
{
    m_status = INSTANCE_FAILED;
}

bool CInstance::CheckFirstEntry(uint32 id)
{
    //insert returns a pair (iterator,inserted)
    return m_enteredChars.insert(id).second;
}

uint8 CInstance::GetSoloBattleMusic()
{
    return m_zone_music_override.m_bSongS != (uint8)-1 ? m_zone_music_override.m_bSongS : GetZone()->GetSoloBattleMusic();
}

uint8 CInstance::GetPartyBattleMusic()
{
    return m_zone_music_override.m_bSongM != (uint8)-1 ? m_zone_music_override.m_bSongM : GetZone()->GetPartyBattleMusic();
}

uint8 CInstance::GetBackgroundMusicDay()
{
    return m_zone_music_override.m_songDay != (uint8)-1 ? m_zone_music_override.m_songDay : GetZone()->GetBackgroundMusicDay();
}

uint8 CInstance::GetBackgroundMusicNight()
{
    return m_zone_music_override.m_songNight != (uint8)-1 ? m_zone_music_override.m_songNight : GetZone()->GetBackgroundMusicNight();
}
