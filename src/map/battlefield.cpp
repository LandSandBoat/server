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

#include "battlefield.h"

#include "../common/timer.h"

#include "ai/ai_container.h"
#include "ai/states/death_state.h"

#include "enmity_container.h"

#include "entities/baseentity.h"
#include "entities/battleentity.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"
#include "entities/trustentity.h"

#include "lua/luautils.h"

#include "packets/entity_animation.h"
#include "packets/entity_update.h"
#include "packets/message_basic.h"
#include "packets/position.h"

#include "status_effect_container.h"
#include "treasure_pool.h"

#include "utils/charutils.h"
#include "utils/itemutils.h"
#include "utils/zoneutils.h"
#include "zone.h"
#include <chrono>

CBattlefield::CBattlefield(uint16 id, CZone* PZone, uint8 area, CCharEntity* PInitiator)
{
    m_ID = id;
    m_Zone = PZone;
    m_Area = area;
    m_Initiator.id = PInitiator->id;
    m_Initiator.name = PInitiator->name;
    m_Record = BattlefieldRecord_t();
    m_Record.name = "Meme";
    m_Record.time = 24h;
    m_Record.partySize = 69;
    m_StartTime = server_clock::now();
    m_Tick = m_StartTime;
    m_LastPromptTime = 0s;
    m_RegisteredPlayers.emplace(PInitiator->id);
}

CBattlefield::~CBattlefield()
{
    luautils::OnBattlefieldDestroy(this);
}

uint16 CBattlefield::GetID() const
{
    return m_ID;
}

CZone* CBattlefield::GetZone() const
{
    return m_Zone;
}

uint16 CBattlefield::GetZoneID() const
{
    return m_Zone->GetID();
}

const std::string& CBattlefield::GetName() const
{
    return m_Name;
}

const BattlefieldInitiator_t& CBattlefield::GetInitiator() const
{
    return m_Initiator;
}

uint8 CBattlefield::GetArea() const
{
    return m_Area;
}

const BattlefieldRecord_t& CBattlefield::GetRecord() const
{
    return m_Record;
}

uint8 CBattlefield::GetStatus() const
{
    return m_Status;
}

uint16 CBattlefield::GetRuleMask() const
{
    return m_Rules;
}

time_point CBattlefield::GetStartTime() const
{
    return m_StartTime;
}

duration CBattlefield::GetTimeInside() const
{
    return m_Tick - m_StartTime;
}

time_point CBattlefield::GetFightTime() const
{
    return m_FightTick;
}

duration CBattlefield::GetTimeLimit() const
{
    return m_TimeLimit;
}

time_point CBattlefield::GetWipeTime() const
{
    return m_WipeTime;
}

duration CBattlefield::GetFinishTime() const
{
    return m_FinishTime;
}

duration CBattlefield::GetRemainingTime() const
{
    return GetTimeLimit() - GetTimeInside();
}

duration CBattlefield::GetLastTimeUpdate() const
{
    return m_LastPromptTime;
}

uint64_t CBattlefield::GetLocalVar(const std::string& name) const
{
    auto var = m_LocalVars.find(name);
    return var != m_LocalVars.end() ? var->second : 0;
}

size_t CBattlefield::GetMaxParticipants() const
{
    return m_MaxParticipants;
}

size_t CBattlefield::GetPlayerCount() const
{
    return m_EnteredPlayers.size();
}

uint8 CBattlefield::GetLevelCap() const
{
    return m_LevelCap;
}

void CBattlefield::SetName(const std::string& name)
{
    m_Name = name;
}

void CBattlefield::SetInitiator(const std::string& name)
{
    m_Initiator.name = name;
}

void CBattlefield::SetTimeLimit(duration time)
{
    m_TimeLimit = time;
}

void CBattlefield::SetWipeTime(time_point time)
{
    m_WipeTime = time;
}

void CBattlefield::SetArea(uint8 area)
{
    m_Area = area;
}

void CBattlefield::SetRecord(const std::string& name, duration time, size_t partySize)
{
    m_Record.name = !name.empty() ? name : m_Initiator.name;
    m_Record.time = time;
    m_Record.partySize = partySize;
}

void CBattlefield::SetStatus(uint8 status)
{
    m_Status = status;
    luautils::OnBattlefieldStatusChange(this);
}

void CBattlefield::SetRuleMask(uint16 rulemask)
{
    m_Rules = rulemask;
}

void CBattlefield::SetMaxParticipants(uint8 max)
{
    m_MaxParticipants = max;
}

void CBattlefield::SetLevelCap(uint8 cap)
{
    m_LevelCap = cap;
}

void CBattlefield::SetLocalVar(const std::string& name, uint64_t value)
{
    m_LocalVars[name] = value;
}

void CBattlefield::SetLastTimeUpdate(duration time)
{
    m_LastPromptTime = time;
}

void CBattlefield::ApplyLevelRestrictions(CCharEntity* PChar) const
{
    // Adjust player's level to the appropriate cap and remove buffs
    auto cap = GetLevelCap();

    if (cap && cap > 0)
    {
        cap += map_config.Battle_cap_tweak; // We wait till here to do this because we don't want to modify uncapped battles.

        // Check if it's a mission and if config setting applies.
        if (map_config.lv_cap_mission_bcnm == 0 && m_isMission == 1)
        {
            cap = PChar->GetMLevel(); // Cap to current level to strip buffs - this is the retail diff between uncapped and capped to max lv.
        }

        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DEATH, true);
        PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_LEVEL_RESTRICTION, EFFECT_LEVEL_RESTRICTION, cap, 0, 0));
    }

    // Check if we should remove SJ, whether or not there is a lv cap.
    if (!(m_Rules & BCRULES::RULES_ALLOW_SUBJOBS))
    {
        PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_SJ_RESTRICTION, EFFECT_SJ_RESTRICTION, 0, 0, 0));
    }
}

bool CBattlefield::IsOccupied() const
{
    return m_EnteredPlayers.size() > 0;
}

bool CBattlefield::InsertEntity(CBaseEntity* PEntity, bool enter, BATTLEFIELDMOBCONDITION conditions, bool ally)
{
    TPZ_DEBUG_BREAK_IF(PEntity == nullptr);

    if (PEntity->PBattlefield)
        return false;

    if (PEntity->objtype == TYPE_PC)
    {
        if (GetPlayerCount() < GetMaxParticipants())
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(PEntity);
            if (enter)
            {
                ApplyLevelRestrictions(PChar);
                m_EnteredPlayers.emplace(PEntity->id);
                PChar->ClearTrusts();
                luautils::OnBattlefieldEnter(PChar, this);
                charutils::SendTimerPacket(PChar, m_TimeLimit);
            }
            else if (!IsRegistered(PChar))
            {
                m_RegisteredPlayers.emplace(PEntity->id);
                luautils::OnBattlefieldRegister(PChar, this);
                return true;
            }
        }
        else
        {
            return false;
        }
    }
    else if (PEntity->objtype == TYPE_NPC)
    {
        PEntity->status = STATUS_NORMAL;
        PEntity->loc.zone->PushPacket(PEntity, CHAR_INRANGE, new CEntityUpdatePacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB));
        m_NpcList.push_back(static_cast<CNpcEntity*>(PEntity));
    }
    else if (PEntity->objtype == TYPE_MOB || PEntity->objtype == TYPE_PET)
    {
        // mobs
        if (!ally)
        {
            auto pet = dynamic_cast<CPetEntity*>(PEntity);

            // dont enter player pet
            if (pet && pet->PMaster && pet->PMaster->objtype == TYPE_PC)
            {
            }
            else
            {
                // only apply conditions to mobs spawning by default
                BattlefieldMob_t mob;
                mob.PMob = static_cast<CMobEntity*>(PEntity);
                mob.condition = conditions;
                mob.PMob->m_bcnmID = this->GetID();
                mob.PMob->m_battlefieldID = this->GetArea();

                if (mob.condition & CONDITION_WIN_REQUIREMENT)
                    m_RequiredEnemyList.push_back(mob);
                else
                    m_AdditionalEnemyList.push_back(mob);

                // todo: this can be greatly improved
                if (mob.PMob->isAlive())
                    mob.PMob->Die();
                if (mob.condition & CONDITION_SPAWNED_AT_START)
                    mob.PMob->Spawn();
            }
        }
        // ally
        else
        {
            m_AllyList.push_back(static_cast<CMobEntity*>(PEntity));
        }
    }

    auto entity = dynamic_cast<CBattleEntity*>(PEntity);

    // set their battlefield to this as they're now physically inside that battlefield
    if (enter)
        PEntity->PBattlefield = this;
    // mob, initiator or ally
    if (entity && !entity->StatusEffectContainer->GetStatusEffect(EFFECT_BATTLEFIELD))
        entity->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_BATTLEFIELD, EFFECT_BATTLEFIELD, this->GetID(),
            0, 0, m_Initiator.id, this->GetArea()), true);

    return true;
}

CBaseEntity* CBattlefield::GetEntity(CBaseEntity* PEntity)
{
    if (!PEntity)
        return nullptr;

    if (PEntity->objtype == TYPE_PC)
    {
        for (const auto id : m_EnteredPlayers)
            if (id == PEntity->id)
                return PEntity;
    }
    else if (PEntity->objtype == TYPE_MOB)
    {
        if (PEntity->allegiance == ALLEGIANCE_MOB)
        {
            for (const auto& mob : m_AdditionalEnemyList)
                if (mob.PMob->id == PEntity->id)
                    return mob.PMob;
            for (const auto& mob : m_RequiredEnemyList)
                if (mob.PMob->id == PEntity->id)
                    return mob.PMob;
        }
        else if (PEntity->allegiance == ALLEGIANCE_PLAYER)
        {
            for (auto PAlly : m_AllyList)
                if (PAlly->id == PEntity->id)
                    return PAlly;
        }
    }
    else if (PEntity->objtype == TYPE_PET || PEntity->objtype == TYPE_TRUST)
    {
        if (auto POwner = dynamic_cast<CCharEntity*>(static_cast<CBattleEntity*>(PEntity)->PMaster))
        {
            for (const auto id : m_EnteredPlayers)
                if (id == POwner->id)
                    return POwner;
        }
    }
    else if (PEntity->objtype == TYPE_NPC)
    {
        for (auto PNpc : m_NpcList)
        {
            if (PNpc->id == PEntity->id)
                return PNpc;
        }
    }
    return nullptr;
}

bool CBattlefield::IsRegistered(CCharEntity* PChar)
{
    return PChar && m_RegisteredPlayers.find(PChar->id) != m_RegisteredPlayers.end();
}

bool CBattlefield::RemoveEntity(CBaseEntity* PEntity, uint8 leavecode)
{
    // player's already zoned, we dont need to do anything
    if (!PEntity)
        return false;

    auto found = false;
    if (PEntity->objtype == TYPE_PC)
    {
        auto PChar = dynamic_cast<CCharEntity*>(PEntity);
        if (!(m_Rules & BCRULES::RULES_ALLOW_SUBJOBS))
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_SJ_RESTRICTION);
        if (m_LevelCap)
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_LEVEL_RESTRICTION);

        m_EnteredPlayers.erase(m_EnteredPlayers.find(PEntity->id));

        if (leavecode != BATTLEFIELD_LEAVE_CODE_WARPDC)
            m_RegisteredPlayers.erase(m_RegisteredPlayers.find(PEntity->id));

        if (leavecode != 255)
        {
            // todo: probably shouldnt hardcode this
            if (leavecode == BATTLEFIELD_LEAVE_CODE_WARPDC)
            {
                PEntity->loc.p.x = 0;
                PEntity->loc.p.y = 0;
                PEntity->loc.p.z = 0;
            }
            luautils::OnBattlefieldLeave(PChar, this, leavecode);
        }
        charutils::SendClearTimerPacket(PChar);
    }
    else
    {
        auto check = [PEntity, &found](auto entity) { if (PEntity == entity) { found = true; return found; } return false; };

        if (PEntity->objtype == TYPE_NPC)
        {
            PEntity->status = STATUS_DISAPPEAR;
            PEntity->loc.zone->PushPacket(PEntity, CHAR_INRANGE, new CEntityUpdatePacket(PEntity, ENTITY_DESPAWN, UPDATE_ALL_MOB));
            m_NpcList.erase(std::remove_if(m_NpcList.begin(), m_NpcList.end(), check), m_NpcList.end());
        }
        else if (PEntity->objtype == TYPE_MOB || PEntity->objtype == TYPE_PET)
        {
            // todo: probably need to check allegiance too cause besieged will prolly use > 0x700 too
            // allies targid >= 0x700
            if (PEntity->targid >= 0x700)
            {
                if (static_cast<CPetEntity*>(PEntity)->isAlive() && PEntity->PAI->IsSpawned())
                    static_cast<CPetEntity*>(PEntity)->Die();

                if (m_AllyList.size() > 0)
                {
                    m_AllyList.erase(std::remove_if(m_AllyList.begin(), m_AllyList.end(), check), m_AllyList.end());
                }
                PEntity->status = STATUS_DISAPPEAR;
                return found;
            }
            else
            {
                auto check = [PEntity, &found](auto entity) { if (entity.PMob == PEntity) { found = true; return found; } return false; };
                m_RequiredEnemyList.erase(std::remove_if(m_RequiredEnemyList.begin(), m_RequiredEnemyList.end(), check), m_RequiredEnemyList.end());
                m_AdditionalEnemyList.erase(std::remove_if(m_AdditionalEnemyList.begin(), m_AdditionalEnemyList.end(), check), m_AdditionalEnemyList.end());
            }
        }
        PEntity->loc.zone->PushPacket(PEntity, CHAR_INRANGE, new CEntityAnimationPacket(PEntity, CEntityAnimationPacket::Fade_Out));
    }

    // Remove enmity from valid battle entities
    if (auto PBattleEntity = dynamic_cast<CBattleEntity*>(PEntity))
    {
        PBattleEntity->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, true);
        PBattleEntity->StatusEffectContainer->DelStatusEffect(EFFECT_LEVEL_RESTRICTION);
        ClearEnmityForEntity(PBattleEntity);
    }

    PEntity->PBattlefield = nullptr;
    return found;
}

void CBattlefield::onTick(time_point time)
{
    if (!m_Attacked)
        CheckInProgress();

    if (time > m_Tick + 1s)
    {
        //todo : bcnm - update tick, fight tick, end if time is up
        m_Tick = time;
        m_FightTick = m_Status == BATTLEFIELD_STATUS_LOCKED ? m_FightTick : time;
        m_FinishTime = m_Status >= BATTLEFIELD_STATUS_WON ? m_FightTick - m_StartTime : m_FinishTime;

        luautils::OnBattlefieldTick(this);

        // todo: handle this in global
        // been here too long, gtfo
        if (GetTimeInside() >= GetTimeLimit())
            CanCleanup(true);
    }
}

bool CBattlefield::CanCleanup(bool cleanup)
{
    if (cleanup)
        m_Cleanup = cleanup;

    return m_Cleanup || m_EnteredPlayers.size() == 0;
}

void CBattlefield::Cleanup()
{
    // todo: delete all the things?
    for (const auto& mob : m_RequiredEnemyList)
    {
        if (mob.PMob->isAlive() && mob.PMob->PAI->IsSpawned())
            mob.PMob->PAI->Despawn();
    }

    for (const auto& mob : m_AdditionalEnemyList)
    {
        if (mob.PMob->isAlive() && mob.PMob->PAI->IsSpawned())
            mob.PMob->PAI->Despawn();
    }

    if (GetStatus() == BATTLEFIELD_STATUS_WON && GetRecord().time > m_FinishTime)
    {
        SetRecord(m_Initiator.name, m_FinishTime, m_EnteredPlayers.size());
    }
    auto tempEnemies = m_RequiredEnemyList;
    auto tempEnemies2 = m_AdditionalEnemyList;
    auto tempNpcs = m_NpcList;
    auto tempAllies = m_AllyList;
    auto tempPlayers = m_EnteredPlayers;

    for (auto mob : tempEnemies)
        RemoveEntity(mob.PMob);
    for (auto mob : tempEnemies2)
        RemoveEntity(mob.PMob);
    for (auto npc : tempNpcs)
        RemoveEntity(npc);
    for (auto ally : tempAllies)
        RemoveEntity(ally);

    uint8 leavecode = m_Status == BATTLEFIELD_STATUS_WON ? BATTLEFIELD_LEAVE_CODE_WIN : BATTLEFIELD_LEAVE_CODE_LOSE;

    for (auto id : tempPlayers)
    {
        auto PChar = GetZone()->GetCharByID(id);
        if (PChar)
            RemoveEntity(PChar, leavecode);
    }

    if (m_Attacked && m_Status == BATTLEFIELD_STATUS_WON)
    {
        const char* query = "SELECT fastestTime FROM bcnm_info WHERE bcnmId = %u AND zoneId = %u";
        auto ret = Sql_Query(SqlHandle, query, this->GetID(), this->GetZoneID());
        bool updateRecord = true;
        if (ret != SQL_ERROR && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            updateRecord = Sql_GetUIntData(SqlHandle, 0) > std::chrono::duration_cast<std::chrono::seconds>(m_Record.time).count();
        }

        if (updateRecord)
        {
            query = "UPDATE bcnm_info SET fastestName = '%s', fastestTime = %u, fastestPartySize = %u WHERE bcnmId = %u AND zoneid = %u";
            auto timeThing = std::chrono::duration_cast<std::chrono::seconds>(m_Record.time).count();

            Sql_Query(SqlHandle, query, m_Record.name.c_str(), timeThing, m_Record.partySize, this->GetID(), GetZoneID());
        }
    }
}

bool CBattlefield::LoadMobs()
{
    //get ids from DB
    auto fmtQuery = "SELECT monsterId, conditions \
                            FROM bcnm_battlefield \
                            WHERE bcnmId = %u AND battlefieldNumber = %u";

    auto ret = Sql_Query(SqlHandle, fmtQuery, this->GetID(), this->GetArea());

    if (ret == SQL_ERROR ||
        Sql_NumRows(SqlHandle) == 0)
    {
        ShowError("Battlefield::LoadMobs() : Cannot find any monster IDs for battlefield %i area %i \n",
            this->GetID(), this->GetArea());
    }
    else
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            auto mobid = Sql_GetUIntData(SqlHandle, 0);
            auto condition = Sql_GetUIntData(SqlHandle, 1);
            auto PMob = static_cast<CMobEntity*>(zoneutils::GetEntity(mobid, TYPE_MOB | TYPE_PET));

            if (PMob)
            {
                this->InsertEntity(PMob, true, static_cast<BATTLEFIELDMOBCONDITION>(condition));
            }
            else
            {
                ShowDebug("Battlefield::LoadMobs() mob %u not found\n", mobid);
                return false;
            }
        }
    }
    return true;
}

bool CBattlefield::SpawnLoot(CBaseEntity* PEntity)
{
    if (!PEntity)
    {
        auto fmtQuery = "SELECT npcId FROM bcnm_treasure_chests WHERE bcnmId = %u AND battlefieldNumber = %u;";
        auto ret = Sql_Query(SqlHandle, fmtQuery, this->GetID(), this->GetArea());

        if (ret == SQL_ERROR ||
            Sql_NumRows(SqlHandle) == 0)
        {
            ShowError("Battlefield::SpawnLoot() : Cannot find treasure chest for battlefield %i area %i \n",
                this->GetID(), this->GetArea());
            return false;
        }
        else
        {
            if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                auto npcId = Sql_GetUIntData(SqlHandle, 0);
                PEntity = zoneutils::GetEntity(npcId);
            }
        }
    }
    SetLocalVar("lootSpawned", 1);
    return InsertEntity(PEntity, true);
}

void CBattlefield::ClearEnmityForEntity(CBattleEntity* PEntity)
{
    if (!PEntity)
        return;

    auto func = [&](auto mob) { if (PEntity->PPet) mob->PEnmityContainer->Clear(PEntity->PPet->id);
    mob->PEnmityContainer->Clear(PEntity->id); };

    ForEachRequiredEnemy(func);
    ForEachAdditionalEnemy(func);
}

bool CBattlefield::CheckInProgress()
{
    ForEachEnemy([&](CMobEntity* PMob)
    {
        if (PMob->PEnmityContainer->GetEnmityList()->size())
        {
            if (m_Status == BATTLEFIELD_STATUS_OPEN)
                SetStatus(BATTLEFIELD_STATUS_LOCKED);
            m_Attacked = true;
        }
    });

    // mobs might have 0 enmity but we wont allow anymore players to enter
    return m_Status != BATTLEFIELD_STATUS_OPEN;
}

void CBattlefield::ForEachPlayer(std::function<void(CCharEntity*)> func)
{
    for (auto player : m_EnteredPlayers)
    {
        func(static_cast<CCharEntity*>(GetZone()->GetCharByID(player)));
    }
}

void CBattlefield::ForEachEnemy(std::function<void(CMobEntity*)> func)
{
    ForEachRequiredEnemy(func);
    ForEachAdditionalEnemy(func);
}

void CBattlefield::ForEachRequiredEnemy(std::function<void(CMobEntity*)> func)
{
    for (auto mob : m_RequiredEnemyList)
    {
        func(mob.PMob);
    }
}

void CBattlefield::ForEachAdditionalEnemy(std::function<void(CMobEntity*)> func)
{
    for (auto mob : m_AdditionalEnemyList)
    {
        func(mob.PMob);
    }
}

void CBattlefield::ForEachNpc(std::function<void(CNpcEntity*)> func)
{
    for (auto npc : m_NpcList)
    {
        func(npc);
    }
}

void CBattlefield::ForEachAlly(std::function<void(CMobEntity*)> func)
{
    for (auto ally : m_AllyList)
    {
        func(ally);
    }
}
