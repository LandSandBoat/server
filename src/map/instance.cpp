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

#include "ai/ai_container.h"
#include "entities/charentity.h"
#include "lua/luautils.h"
#include "zone.h"

#include "common/timer.h"

CInstance::CInstance(CZone* zone, uint32 instanceid)
: CZoneEntities(zone)
, m_instanceid(instanceid)
, m_zone(zone)
, m_startTime(timer::now())
{
    TracyZoneScoped;

    m_wipeTimer     = m_startTime;
    m_lastTimeCheck = m_startTime;

    LoadInstance();
}

CInstance::~CInstance()
{
    TracyZoneScoped;
}

uint16 CInstance::GetID() const
{
    return m_instanceid;
}

uint32 CInstance::GetProgress() const
{
    return m_progress;
}

uint32 CInstance::GetStage() const
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
    TracyZoneScoped;

    const auto rset = db::preparedStmt("SELECT "
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
                                       "WHERE instanceid = ? "
                                       "LIMIT 1",
                                       m_instanceid);

    if (rset && rset->rowsCount() && rset->next())
    {
        m_instanceName = rset->get<std::string>("instance_name");

        m_timeLimit                       = std::chrono::minutes(rset->get<uint32>("time_limit"));
        m_entrance                        = rset->get<uint16>("entrance_zone");
        m_entryloc.x                      = rset->get<float>("start_x");
        m_entryloc.y                      = rset->get<float>("start_y");
        m_entryloc.z                      = rset->get<float>("start_z");
        m_entryloc.rotation               = rset->get<uint8>("start_rot");
        m_zone_music_override.m_songDay   = !rset->isNull("music_day") ? xi::optional(rset->get<uint16>("music_day")) : std::nullopt;
        m_zone_music_override.m_songNight = !rset->isNull("music_night") ? xi::optional(rset->get<uint16>("music_night")) : std::nullopt;
        m_zone_music_override.m_bSongS    = !rset->isNull("battlesolo") ? xi::optional(rset->get<uint16>("battlesolo")) : std::nullopt;
        m_zone_music_override.m_bSongM    = !rset->isNull("battlemulti") ? xi::optional(rset->get<uint16>("battlemulti")) : std::nullopt;

        // Add to Lua cache
        // TODO: This will happen more often than needed, but not so often that it's a performance concern
        const auto zone     = m_zone->getName();
        const auto name     = m_instanceName;
        const auto filename = fmt::format("./scripts/zones/{}/instances/{}.lua", zone, name);
        luautils::CacheLuaObjectFromFile(filename);
    }
    else
    {
        ShowCritical("CZone::LoadInstance: Cannot load instance %u", m_instanceid);
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
    m_registeredChars.emplace_back(PChar->id);
}

uint8 CInstance::GetLevelCap() const
{
    return m_levelcap;
}

const std::string& CInstance::GetName()
{
    return m_instanceName;
}

position_t CInstance::GetEntryLoc()
{
    return m_entryloc;
}

timer::duration CInstance::GetTimeLimit()
{
    return m_timeLimit;
}

void CInstance::SetTimeLimit(timer::duration time)
{
    m_timeLimit = time;
}

timer::duration CInstance::GetLastTimeUpdate()
{
    return m_lastTimeUpdate;
}

timer::duration CInstance::GetWipeTime()
{
    return m_wipeTimer - m_startTime;
}

timer::duration CInstance::GetElapsedTime(timer::time_point tick)
{
    // no reason to allow returning a negative elapsed time, can happen if map server is delayed and processing a previous tick
    return std::max(timer::duration(0s), tick - m_startTime);
}

uint64_t CInstance::GetLocalVar(const std::string& name) const
{
    auto var = m_LocalVars.find(name);
    return var != m_LocalVars.end() ? var->second : 0;
}

void CInstance::SetLevelCap(uint8 cap)
{
    m_levelcap = cap;
}

void CInstance::SetEntryLoc(float x, float y, float z, float rot)
{
    m_entryloc.x        = x;
    m_entryloc.y        = y;
    m_entryloc.z        = z;
    m_entryloc.rotation = (uint8)rot;
}

void CInstance::SetLastTimeUpdate(timer::duration lastTime)
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

void CInstance::SetWipeTime(timer::duration time)
{
    m_wipeTimer = time + m_startTime;
}

void CInstance::SetLocalVar(const std::string& name, uint64_t value)
{
    m_LocalVars[name] = value;
}

/************************************************************************
 *                                                                       *
 *  Checks if the instance has expired.  If not, runs instance timer     *
 *                                                                       *
 ************************************************************************/

void CInstance::CheckTime(timer::time_point tick)
{
    auto checkFrequency = 1s;
    // Once someone zones in, m_lastTimeCheck will change and checkFrequency will be pinned at 1s for the remainder of the instance
    if (CharListEmpty() && m_startTime == m_lastTimeCheck)
    {
        // give grace period before first instance check to allow time to register instance and zone in
        // instance.lua lets the client run through the event for a maximum of 35s before forcing zone change with `setPos`
        checkFrequency = 40s;
    }
    if (m_lastTimeCheck + checkFrequency <= tick && !Failed())
    {
        luautils::OnInstanceTimeUpdate(GetZone(), this, static_cast<uint32>(timer::count_milliseconds(GetElapsedTime(tick))));
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
    auto clearStates = [](CBattleEntity* entity)
    {
        if (static_cast<CBattleEntity*>(entity)->isAlive())
        {
            entity->PAI->ClearStateStack();
        }
    };

    ForEachChar(
        [&](CCharEntity* PChar)
        {
            clearStates(PChar);
        });

    ForEachMob(
        [&](CMobEntity* PMob)
        {
            clearStates(PMob);
        });

    ForEachPet(
        [&](CPetEntity* PPet)
        {
            clearStates(PPet);
        });

    ForEachTrust(
        [&](CTrustEntity* PTrust)
        {
            clearStates(PTrust);
        });
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
    // insert returns a pair (iterator,inserted)
    return m_enteredChars.insert(id).second;
}

uint16 CInstance::GetSoloBattleMusic()
{
    return m_zone_music_override.m_bSongS ? *m_zone_music_override.m_bSongS : GetZone()->GetSoloBattleMusic();
}

uint16 CInstance::GetPartyBattleMusic()
{
    return m_zone_music_override.m_bSongM ? *m_zone_music_override.m_bSongM : GetZone()->GetPartyBattleMusic();
}

uint16 CInstance::GetBackgroundMusicDay()
{
    return m_zone_music_override.m_songDay ? *m_zone_music_override.m_songDay : GetZone()->GetBackgroundMusicDay();
}

uint16 CInstance::GetBackgroundMusicNight()
{
    return m_zone_music_override.m_songNight ? *m_zone_music_override.m_songNight : GetZone()->GetBackgroundMusicNight();
}
