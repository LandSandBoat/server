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

#ifndef _CINSTANCE_H
#define _CINSTANCE_H

#include "zone_entities.h"

#include <set>
#include <unordered_map>

enum INSTANCE_STATUS
{
    INSTANCE_NORMAL,
    INSTANCE_FAILED,
    INSTANCE_COMPLETE
};

class CInstance : public CZoneEntities
{
public:
    CInstance(CZone*, uint16 instanceid);
    ~CInstance();

    void RegisterChar(CCharEntity*);

    uint16             GetID() const;
    uint8              GetLevelCap() const;
    const std::string& GetName();
    position_t         GetEntryLoc();                   // Get entry location
    duration           GetTimeLimit();                  // Get instance time limit
    duration           GetLastTimeUpdate();             // Get last time a "Time Remaining:" message was displayed
    uint32             GetProgress() const;             // Tracks the progress through the current stage
    uint32             GetStage() const;                // Tracks the progress through the instance (eg. floor #)
    duration           GetWipeTime();                   // Get time wipe happened (elapsed since start)
    duration           GetElapsedTime(time_point tick); // Get elapsed time so far
    uint64_t           GetLocalVar(std::string const& name) const;

    void SetLevelCap(uint8 cap);
    void SetEntryLoc(float x, float y, float z, float rot); // Set entry location
    void SetLastTimeUpdate(duration time);                  // Set last time a "Time Remaining:" message was displayed
    void SetTimeLimit(duration time);                       // Set instance time limit
    void SetProgress(uint32 progress);                      // Set progress through current stage
    void SetStage(uint32 stage);                            // Set current stage (eg. floor #)
    void SetWipeTime(duration time);                        // Set elapsed time when a wipe is detected
    void SetLocalVar(std::string const& name, uint64_t value);

    void CheckTime(time_point tick);         // Check time limit (run instance time script)
    bool CharRegistered(CCharEntity* PChar); // Check if PChar is registered to this instance
    void ClearEntities();
    void Fail();                     // Fails the instance (onInstanceFailure)
    bool Failed();                   // Checks if instance is failed
    void Complete();                 // Completes the instance (onInstanceComplete)
    bool Completed();                // Checks if instance is completed
    void Cancel();                   // Sets instance to fail without calling onInstanceFailure
    bool CheckFirstEntry(uint32 id); // Checks if this is the first time a char is entering

    uint8 GetSoloBattleMusic();
    uint8 GetPartyBattleMusic();
    uint8 GetBackgroundMusicDay();
    uint8 GetBackgroundMusicNight();

private:
    void LoadInstance();

    uint16              m_instanceid{ 0 };
    uint16              m_entrance{ 0 };
    std::string         m_instanceName;
    CZone*              m_zone;
    uint32              m_commander{ 0 };
    uint8               m_levelcap{ 0 };
    duration            m_timeLimit{ duration::zero() };
    time_point          m_startTime;
    duration            m_lastTimeUpdate{ duration::zero() };
    time_point          m_lastTimeCheck;
    time_point          m_wipeTimer;
    uint32              m_progress{ 0 };
    uint32              m_stage{ 0 };
    position_t          m_entryloc{};
    zoneMusic_t         m_zone_music_override{};
    INSTANCE_STATUS     m_status{ INSTANCE_NORMAL };
    std::vector<uint32> m_registeredChars;
    std::set<uint32>    m_enteredChars;

    std::unordered_map<std::string, uint64_t> m_LocalVars;
};

#endif
