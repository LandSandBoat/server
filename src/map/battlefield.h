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

#ifndef _CBATTLEFIELD_H
#define _CBATTLEFIELD_H

#include <functional>
#include <memory>
#include <set>
#include <vector>

#include "common/cbasetypes.h"
#include "common/mmo.h"
#include "sol/sol.hpp"
#include <unordered_map>

enum BCRULES : uint8
{
    RULES_ALLOW_SUBJOBS         = 0x01,
    RULES_LOSE_EXP              = 0x02,
    RULES_REMOVE_3MIN           = 0x04,
    RULES_SPAWN_TREASURE_ON_WIN = 0x08,
    RULES_MAAT                  = 0x10
};

enum BATTLEFIELDMOBCONDITION : uint8
{
    CONDITION_NONE               = 0x00,
    CONDITION_SPAWNED_AT_START   = 0x01,
    CONDITION_WIN_REQUIREMENT    = 0x02,
    CONDITION_DISAPPEAR_AT_START = 0x04,
};

enum BATTLEFIELD_LEAVE_CODE : uint8
{
    BATTLEFIELD_LEAVE_CODE_EXIT   = 1,
    BATTLEFIELD_LEAVE_CODE_WIN    = 2,
    BATTLEFIELD_LEAVE_CODE_WARPDC = 3,
    BATTLEFIELD_LEAVE_CODE_LOSE   = 4
};

enum BATTLEFIELD_STATUS : uint8
{
    BATTLEFIELD_STATUS_OPEN   = 0,
    BATTLEFIELD_STATUS_LOCKED = 1,
    BATTLEFIELD_STATUS_WON    = 2,
    BATTLEFIELD_STATUS_LOST   = 3
};

enum BATTLEFIELD_RETURN_CODE : uint8
{
    BATTLEFIELD_RETURN_CODE_WAIT              = 1,
    BATTLEFIELD_RETURN_CODE_CUTSCENE          = 2,
    BATTLEFIELD_RETURN_CODE_INCREMENT_REQUEST = 3,
    BATTLEFIELD_RETURN_CODE_LOCKED            = 4,
    BATTLEFIELD_RETURN_CODE_REQS_NOT_MET      = 5,
    BATTLEFIELD_RETURN_CODE_BATTLEFIELD_FULL  = 6
};

class CNpcEntity;
class CMobEntity;
class CCharEntity;
class CBaseEntity;
class CBattleEntity;
class CBattlefieldHandler;
class CZone;

struct BattlefieldMob_t
{
    CMobEntity*             PMob;
    BATTLEFIELDMOBCONDITION condition; // whether it has died or not

    BattlefieldMob_t()
    : condition(CONDITION_NONE)
    {
        PMob = nullptr;
    }
};

struct BattlefieldRecord_t
{
    std::string name;
    size_t      partySize;
    duration    time;

    BattlefieldRecord_t()
    : partySize(0)
    , time(std::chrono::minutes(30))
    {
    }
};

struct BattlefieldInitiator_t
{
    std::string name;
    uint32      id;

    BattlefieldInitiator_t()
    : id(0)
    {
    }
};

struct BattlefieldGroup
{
    std::vector<uint32> mobIds;
    sol::function       deathCallback;
    sol::function       randomDeathCallback;
    sol::function       allDeathCallback;
    sol::function       setupCallback;
    uint8               deathCount  = 0;
    uint32              randomMobId = 0;
};

class CBattlefield : public std::enable_shared_from_this<CBattlefield>
{
public:
    CBattlefield(uint16 id, CZone* PZone, uint8 area, CCharEntity* PInitiator, bool isInteraction);
    ~CBattlefield();

    uint16                        GetID() const;
    CZone*                        GetZone() const;
    uint16                        GetZoneID() const;
    std::string const&            GetName() const;
    const BattlefieldInitiator_t& GetInitiator() const;
    uint8                         GetArea() const;
    const BattlefieldRecord_t&    GetRecord() const;
    uint8                         GetStatus() const;
    uint16                        GetRuleMask() const;
    time_point                    GetStartTime() const;
    duration                      GetTimeInside() const;
    time_point                    GetFightTime() const;
    duration                      GetTimeLimit() const;
    time_point                    GetWipeTime() const;
    size_t                        GetMaxParticipants() const;
    size_t                        GetPlayerCount() const;
    uint8                         GetLevelCap() const;
    duration                      GetFinishTime() const;
    duration                      GetRemainingTime() const;
    duration                      GetLastTimeUpdate() const;
    uint64_t                      GetLocalVar(std::string const& name) const;
    uint32                        GetArmouryCrate() const;

    bool CheckInProgress();
    bool IsOccupied() const;
    bool isInteraction() const;
    bool isEntered(CCharEntity* PChar) const;

    void ForEachPlayer(const std::function<void(CCharEntity*)>& func);
    void ForEachEnemy(const std::function<void(CMobEntity*)>& func);
    void ForEachRequiredEnemy(const std::function<void(CMobEntity*)>& func);
    void ForEachAdditionalEnemy(const std::function<void(CMobEntity*)>& func);
    void ForEachNpc(const std::function<void(CNpcEntity*)>& func);
    void ForEachAlly(const std::function<void(CMobEntity*)>& func);

    void SetID(uint16 id);
    void SetName(std::string const& name);
    void SetInitiator(std::string const& name);
    void SetArea(uint8 area);
    void SetRecord(std::string const& name, duration time, size_t partySize);
    void SetStatus(uint8 status);
    void SetRuleMask(uint16 rulemask);
    void SetStartTime(time_point time);
    void SetFightTime(time_point time);
    void SetTimeLimit(duration time);
    void SetWipeTime(time_point time);
    void SetMaxParticipants(uint8 max);
    void SetLevelCap(uint8 cap);
    void SetLocalVar(std::string const& name, uint64_t value);
    void SetLastTimeUpdate(duration time);
    void setArmouryCrate(uint32 entityId);

    void         ApplyLevelRestrictions(CCharEntity* PChar) const;
    bool         InsertEntity(CBaseEntity* PEntity, bool inBattlefield = false, BATTLEFIELDMOBCONDITION conditions = CONDITION_NONE, bool ally = false);
    CBaseEntity* GetEntity(CBaseEntity* PEntity);
    bool         IsRegistered(CCharEntity* PChar);
    bool         RemoveEntity(CBaseEntity* PEntity, uint8 leavecode = 0);
    void         onTick(time_point time);
    bool         CanCleanup(bool cleanup = false);
    bool         Cleanup(time_point time, bool force);
    bool         LoadMobs();
    bool         SpawnLoot(CBaseEntity* PEntity = nullptr);

    // Groups
    void addGroup(BattlefieldGroup group);
    void handleDeath(CBaseEntity* PEntity);

    static void setPlayerEntered(CCharEntity* PChar, bool entered);
    static bool hasPlayerEntered(CCharEntity* PChar);

    static uint16 getBattlefieldArea(CCharEntity* PChar);

    uint8 m_isMission;
    bool  m_showTimer = true;

    std::set<uint32>              m_RegisteredPlayers;
    std::set<uint32>              m_EnteredPlayers;
    std::vector<CNpcEntity*>      m_NpcList;
    std::vector<BattlefieldMob_t> m_RequiredEnemyList;
    std::vector<BattlefieldMob_t> m_AdditionalEnemyList;
    std::vector<CMobEntity*>      m_AllyList;

private:
    uint16                 m_ID;
    CZone*                 m_Zone;
    std::string            m_Name;
    BattlefieldInitiator_t m_Initiator;
    uint8                  m_Area;
    BattlefieldRecord_t    m_Record;
    uint8                  m_Status{ BATTLEFIELD_STATUS_OPEN };
    uint16                 m_Rules;
    time_point             m_StartTime;
    time_point             m_Tick;
    time_point             m_FightTick;
    duration               m_TimeLimit{};
    time_point             m_WipeTime;
    duration               m_FinishTime{};
    duration               m_LastPromptTime{};
    size_t                 m_MaxParticipants;
    uint8                  m_LevelCap;
    // Entity id of the Armoury Crate that appears upon victory
    uint32     m_armouryCrate = 0;
    const bool m_isInteraction;

    time_point m_cleanupTime{};
    bool       m_cleanedPlayers = false;
    bool       m_Cleanup        = false;
    bool       m_Attacked       = false;

    std::unordered_map<std::string, uint64_t> m_LocalVars;
    std::vector<BattlefieldGroup>             m_groups;
};

#endif
