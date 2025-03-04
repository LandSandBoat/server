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
#include "utils/instanceutils.h"
#include "zone.h"

#include "common/timer.h"

CInstance::CInstance(CZone* zone)
: CZoneEntities(zone)
, m_zone(zone)
{
    TracyZoneScoped;
}

CInstance::CInstance(CZone* zone, uint32 instanceId)
: CZoneEntities(zone)
, m_instanceId(instanceId)
, m_zone(zone)
{
    TracyZoneScoped;

    const auto data = instanceutils::GetInstanceData(instanceId);

    m_instanceName = data.instanceName;

    m_timeLimit = std::chrono::minutes(data.timeLimit);
    m_entrance  = data.entranceZoneId;

    m_entryloc.x        = data.startX;
    m_entryloc.y        = data.startY;
    m_entryloc.z        = data.startZ;
    m_entryloc.rotation = data.startRot;

    m_zone_music_override.m_songDay   = data.musicDay;
    m_zone_music_override.m_songNight = data.musicNight;
    m_zone_music_override.m_bSongS    = data.battleSolo;
    m_zone_music_override.m_bSongM    = data.battleMulti;

    m_startTime = server_clock::now();
    m_wipeTimer = m_startTime;
}

CInstance::~CInstance()
{
    TracyZoneScoped;
}

uint32 CInstance::GetID() const
{
    return m_instanceId;
}

uint32 CInstance::GetProgress() const
{
    return m_progress;
}

uint32 CInstance::GetStage() const
{
    return m_stage;
}

void CInstance::RegisterCommander(uint32 charId)
{
    m_commander = charId;

    RegisterChar(charId);
}

void CInstance::RegisterChar(uint32 charId)
{
    m_registeredChars.insert(charId);
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

duration CInstance::GetTimeLimit()
{
    return m_timeLimit;
}

void CInstance::SetTimeLimit(duration time)
{
    m_timeLimit = time;
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

uint64_t CInstance::GetLocalVar(std::string const& name) const
{
    auto var = m_LocalVars.find(name);
    return var != m_LocalVars.end() ? var->second : 0;
}

void CInstance::SetLevelCap(uint8 cap)
{
    m_levelcap = cap;
}

void CInstance::SetEntryLoc(float x, float y, float z, uint8 rot)
{
    m_entryloc.x        = x;
    m_entryloc.y        = y;
    m_entryloc.z        = z;
    m_entryloc.rotation = rot;
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

void CInstance::SetLocalVar(std::string const& name, uint64_t value)
{
    m_LocalVars[name] = value;
}

void CInstance::CheckTime(time_point tick)
{
    if (m_lastTimeCheck + 1s <= tick && !Failed())
    {
        luautils::OnInstanceTimeUpdate(GetZone(), this, (uint32)std::chrono::duration_cast<std::chrono::milliseconds>(GetElapsedTime(tick)).count());
        m_lastTimeCheck = tick;
    }
}

bool CInstance::CharRegistered(uint32 charId)
{
    for (auto id : m_registeredChars)
    {
        if (charId == id)
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

    // clang-format off
    ForEachChar([&](CCharEntity* PChar)
    {
        clearStates(PChar);
    });

    ForEachMob([&](CMobEntity* PMob)
    {
        clearStates(PMob);
    });

    ForEachPet([&](CPetEntity* PPet)
    {
        clearStates(PPet);
    });

    ForEachTrust([&](CTrustEntity* PTrust)
    {
        clearStates(PTrust);
    });
    // clang-format on
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
    return m_zone_music_override.m_bSongS != (uint16)-1 ? m_zone_music_override.m_bSongS : GetZone()->GetSoloBattleMusic();
}

uint16 CInstance::GetPartyBattleMusic()
{
    return m_zone_music_override.m_bSongM != (uint16)-1 ? m_zone_music_override.m_bSongM : GetZone()->GetPartyBattleMusic();
}

uint16 CInstance::GetBackgroundMusicDay()
{
    return m_zone_music_override.m_songDay != (uint16)-1 ? m_zone_music_override.m_songDay : GetZone()->GetBackgroundMusicDay();
}

uint16 CInstance::GetBackgroundMusicNight()
{
    return m_zone_music_override.m_songNight != (uint16)-1 ? m_zone_music_override.m_songNight : GetZone()->GetBackgroundMusicNight();
}
