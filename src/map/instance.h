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

#pragma once

#include "zone_entities.h"

#include <common/types/hash_map.h>

#include <set>

enum INSTANCE_STATUS
{
    INSTANCE_NORMAL,
    INSTANCE_FAILED,
    INSTANCE_COMPLETE
};

struct zoneMusicOverride_t
{
    Maybe<uint16> m_songDay;   // music (daytime)
    Maybe<uint16> m_songNight; // music (nighttime)
    Maybe<uint16> m_bSongS;    // battle music (solo)
    Maybe<uint16> m_bSongM;    // battle music (party)
};

class CInstance : public CZoneEntities
{
public:
    CInstance(Scheduler& scheduler, MapConfig config, CZone* zone, uint32 instanceid);
    ~CInstance();

    void RegisterChar(CCharEntity*);

    auto GetID() const -> uint16;
    auto runId() const -> uint32;

    auto GetLevelCap() const -> uint8;
    auto GetName() -> const std::string&;
    auto GetEntryLoc() -> position_t;                               // Get entry location
    auto GetTimeLimit() -> timer::duration;                         // Get instance time limit
    auto GetLastTimeUpdate() -> timer::duration;                    // Get last time a "Time Remaining:" message was displayed
    auto GetProgress() const -> uint32;                             // Tracks the progress through the current stage
    auto GetStage() const -> uint32;                                // Tracks the progress through the instance (eg. floor #)
    auto GetWipeTime() -> timer::duration;                          // Get time wipe happened (elapsed since start)
    auto GetElapsedTime(timer::time_point tick) -> timer::duration; // Get elapsed time so far
    auto GetLocalVar(const std::string& name) const -> uint64_t;

    void SetLevelCap(uint8 cap);
    void SetEntryLoc(float x, float y, float z, float rot); // Set entry location
    void SetLastTimeUpdate(timer::duration time);           // Set last time a "Time Remaining:" message was displayed
    void SetTimeLimit(timer::duration time);                // Set instance time limit
    void SetProgress(uint32 progress);                      // Set progress through current stage
    void SetStage(uint32 stage);                            // Set current stage (eg. floor #)
    void SetWipeTime(timer::duration time);                 // Set elapsed time when a wipe is detected
    void SetLocalVar(const std::string& name, uint64_t value);

    void CheckTime(timer::time_point tick);          // Check time limit (run instance time script)
    auto CharRegistered(CCharEntity* PChar) -> bool; // Check if PChar is registered to this instance
    void ClearEntities();
    void Fail();                             // Fails the instance (onInstanceFailure)
    auto Failed() -> bool;                   // Checks if instance is failed
    void Complete();                         // Completes the instance (onInstanceComplete)
    auto Completed() -> bool;                // Checks if instance is completed
    void Cancel();                           // Sets instance to fail without calling onInstanceFailure
    auto CheckFirstEntry(uint32 id) -> bool; // Checks if this is the first time a char is entering

    auto GetSoloBattleMusic() -> uint16;
    auto GetPartyBattleMusic() -> uint16;
    auto GetBackgroundMusicDay() -> uint16;
    auto GetBackgroundMusicNight() -> uint16;

    auto overlayId() const -> uint32;

private:
    void LoadInstance();

    uint32              runId_{ 0 };
    uint32              m_instanceid{ 0 };
    uint16              m_entrance{ 0 };
    std::string         m_instanceName;
    CZone*              m_zone;
    uint32              m_commander{ 0 };
    uint8               m_levelcap{ 0 };
    timer::duration     m_timeLimit{ timer::duration::zero() };
    timer::time_point   m_startTime;
    timer::duration     m_lastTimeUpdate{ timer::duration::zero() };
    timer::time_point   m_lastTimeCheck;
    timer::time_point   m_wipeTimer;
    uint32              m_progress{ 0 };
    uint32              m_stage{ 0 };
    position_t          m_entryloc{};
    zoneMusicOverride_t m_zone_music_override{};
    INSTANCE_STATUS     m_status{ INSTANCE_NORMAL };
    std::vector<uint32> m_registeredChars;
    std::set<uint32>    m_enteredChars;
    uint32              overlayId_{ 0 };

    HashMap<std::string, uint64_t> localVars_;
};
