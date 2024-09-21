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

#include "common/timer.h"

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
#include "utils/petutils.h"
#include "utils/zoneutils.h"
#include "zone.h"
#include <chrono>

CBattlefield::CBattlefield(uint16 id, CZone* PZone, uint8 area, CCharEntity* PInitiator)
: m_isMission(false)
, m_ID(id)
, m_Zone(PZone)
, m_Area(area)
, m_Record(BattlefieldRecord_t())
, m_Rules(0)
, m_StartTime(server_clock::now())
, m_LastPromptTime(0s)
, m_MaxParticipants(8)
, m_LevelCap(0)
{
    m_Initiator.id     = PInitiator->id;
    m_Initiator.name   = PInitiator->name;
    m_Record.name      = "Meme";
    m_Record.time      = 24h;
    m_Record.partySize = 69;
    m_Tick             = m_StartTime;
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

std::string const& CBattlefield::GetName() const
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
    return GetTimeLimit() > GetTimeInside() ? GetTimeLimit() - GetTimeInside() : duration(0);
}

duration CBattlefield::GetLastTimeUpdate() const
{
    return m_LastPromptTime;
}

uint64_t CBattlefield::GetLocalVar(std::string const& name) const
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

uint32 CBattlefield::GetArmouryCrate() const
{
    return m_armouryCrate;
}

void CBattlefield::SetName(std::string const& name)
{
    m_Name = name;
}

void CBattlefield::SetInitiator(std::string const& name)
{
    m_Initiator.name = name;
}

void CBattlefield::SetTimeLimit(duration time)
{
    m_TimeLimit      = time;
    m_LastPromptTime = time;
}

void CBattlefield::SetWipeTime(time_point time)
{
    m_WipeTime = time;
}

void CBattlefield::SetArea(uint8 area)
{
    m_Area = area;
}

void CBattlefield::SetRecord(std::string const& name, duration time, size_t partySize)
{
    m_Record.name      = !name.empty() ? name : m_Initiator.name;
    m_Record.time      = time;
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

void CBattlefield::SetLocalVar(std::string const& name, uint64_t value)
{
    m_LocalVars[name] = value;
}

void CBattlefield::SetLastTimeUpdate(duration time)
{
    m_LastPromptTime = time;
}

void CBattlefield::setArmouryCrate(uint32 entityId)
{
    m_armouryCrate = entityId;
}

void CBattlefield::ApplyLevelRestrictions(CCharEntity* PChar) const
{
    // Adjust player's level to the appropriate cap and remove buffs
    auto cap = GetLevelCap();

    if (cap > 0)
    {
        cap += settings::get<int8>("map.BATTLE_CAP_TWEAK"); // We wait till here to do this because we don't want to modify uncapped battles.

        // Check if it's a mission and if config setting applies.
        if (!settings::get<bool>("map.LV_CAP_MISSION_BCNM") && m_isMission == 1)
        {
            cap = settings::get<uint8>("main.MAX_LEVEL"); // Cap to server max level to strip buffs - this is the retail diff between uncapped and capped to max lv.
        }

        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE, true);
        PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_LEVEL_RESTRICTION, EFFECT_LEVEL_RESTRICTION, cap, 0, 0));
    }
    else
    {
        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_LEVEL_RESTRICTION);
    }

    // Check if we should remove SJ, whether or not there is a lv cap.
    if (!(m_Rules & BCRULES::RULES_ALLOW_SUBJOBS))
    {
        PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_SJ_RESTRICTION, EFFECT_SJ_RESTRICTION, 0, 0, 0));
    }
}

bool CBattlefield::IsOccupied() const
{
    return !m_EnteredPlayers.empty();
}

bool CBattlefield::isEntered(CCharEntity* PChar) const
{
    return m_EnteredPlayers.find(PChar->id) != m_EnteredPlayers.end();
}

bool CBattlefield::InsertEntity(CBaseEntity* PEntity, bool enter, BATTLEFIELDMOBCONDITION conditions, bool ally)
{
    if (PEntity == nullptr)
    {
        ShowWarning("CBattlefield::InsertEntity() - PEntity is null.");
        return false;
    }

    if (PEntity->PBattlefield)
    {
        return false;
    }

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

                if (m_showTimer)
                {
                    charutils::SendTimerPacket(PChar, GetRemainingTime());
                }

                // Try to add the player's pet in case they have one that can
                if (PChar->PPet != nullptr)
                {
                    InsertEntity(PChar->PPet, true);
                }
            }
            else if (!IsRegistered(PChar))
            {
                m_RegisteredPlayers.emplace(PEntity->id);
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
        PEntity->status = (conditions & CONDITION_DISAPPEAR_AT_START) == CONDITION_DISAPPEAR_AT_START ? STATUS_TYPE::DISAPPEAR : STATUS_TYPE::NORMAL;
        PEntity->loc.zone->UpdateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
        m_NpcList.emplace_back(static_cast<CNpcEntity*>(PEntity));
    }
    else if (PEntity->objtype == TYPE_MOB || PEntity->objtype == TYPE_PET)
    {
        // mobs
        if (!ally)
        {
            auto* pet = dynamic_cast<CPetEntity*>(PEntity);

            if (pet && pet->PMaster && pet->PMaster->objtype == TYPE_PC)
            {
                // Properly set the existing pet to exist within this battlefield
                pet->m_bcnmID        = GetID();
                pet->m_battlefieldID = GetArea();
            }
            else
            {
                // only apply conditions to mobs spawning by default
                BattlefieldMob_t mob;
                mob.PMob                  = static_cast<CMobEntity*>(PEntity);
                mob.condition             = conditions;
                mob.PMob->m_bcnmID        = this->GetID();
                mob.PMob->m_battlefieldID = this->GetArea();

                if (mob.condition & CONDITION_WIN_REQUIREMENT)
                {
                    m_RequiredEnemyList.emplace_back(mob);
                }
                else
                {
                    m_AdditionalEnemyList.emplace_back(mob);
                }

                // todo: this can be greatly improved
                if (mob.PMob->isAlive())
                {
                    mob.PMob->Die();
                }
                if (mob.condition & CONDITION_SPAWNED_AT_START)
                {
                    mob.PMob->Spawn();
                }
            }
        }
        // ally
        else
        {
            m_AllyList.emplace_back(static_cast<CMobEntity*>(PEntity));
        }
    }

    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);

    // set their battlefield to this as they're now physically inside that battlefield
    if (enter)
    {
        PEntity->PBattlefield = this;
    }

    // mob, initiator or ally
    if (entity)
    {
        CStatusEffect* PBattlefieldEffect = entity->StatusEffectContainer->GetStatusEffect(EFFECT_BATTLEFIELD);
        // Update battlefield ID if battlefield effect exists
        // Tango with a Tracker/Requiem of Sin corner case where NPC IDs are shared between BCs as per retail caps
        if (PBattlefieldEffect)
        {
            PBattlefieldEffect->SetPower(this->GetID());
        }
        else
        {
            entity->StatusEffectContainer->AddStatusEffect(
                new CStatusEffect(EFFECT_BATTLEFIELD, EFFECT_BATTLEFIELD, this->GetID(), 0, 0, m_Initiator.id, this->GetArea()), true);
        }
    }

    return true;
}

CBaseEntity* CBattlefield::GetEntity(CBaseEntity* PEntity)
{
    if (!PEntity)
    {
        return nullptr;
    }

    if (PEntity->objtype == TYPE_PC)
    {
        for (const auto id : m_EnteredPlayers)
        {
            if (id == PEntity->id)
            {
                return PEntity;
            }
        }
    }
    else if (PEntity->objtype == TYPE_MOB)
    {
        if (PEntity->allegiance == ALLEGIANCE_TYPE::MOB)
        {
            for (const auto& mob : m_AdditionalEnemyList)
            {
                if (mob.PMob->id == PEntity->id)
                {
                    return mob.PMob;
                }
            }
            for (const auto& mob : m_RequiredEnemyList)
            {
                if (mob.PMob->id == PEntity->id)
                {
                    return mob.PMob;
                }
            }
        }
        else if (PEntity->allegiance == ALLEGIANCE_TYPE::PLAYER)
        {
            for (auto* PAlly : m_AllyList)
            {
                if (PAlly->id == PEntity->id)
                {
                    return PAlly;
                }
            }
        }
    }
    else if (PEntity->objtype == TYPE_PET || PEntity->objtype == TYPE_TRUST)
    {
        if (auto* POwner = dynamic_cast<CCharEntity*>(static_cast<CBattleEntity*>(PEntity)->PMaster))
        {
            for (const auto id : m_EnteredPlayers)
            {
                if (id == POwner->id)
                {
                    return POwner;
                }
            }
        }
    }
    else if (PEntity->objtype == TYPE_NPC)
    {
        for (auto* PNpc : m_NpcList)
        {
            if (PNpc->id == PEntity->id)
            {
                return PNpc;
            }
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
    // player's already zoned, we don't need to do anything
    if (!PEntity)
    {
        return false;
    }

    auto found = false;
    if (PEntity->objtype == TYPE_PC)
    {
        auto* PChar = dynamic_cast<CCharEntity*>(PEntity);
        if (!(m_Rules & BCRULES::RULES_ALLOW_SUBJOBS))
        {
            PChar->StatusEffectContainer->DelStatusEffect(EFFECT_SJ_RESTRICTION);
        }

        // Release charmed pet when master leaves battlefield
        if (PChar->PPet && PChar->PPet->isCharmed)
        {
            petutils::DetachPet(PChar);
        }

        m_Zone->updateCharLevelRestriction(PChar);

        if (leavecode == BATTLEFIELD_LEAVE_CODE_EXIT && PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_CONFRONTATION))
        {
            if (GetStatus() == BATTLEFIELD_STATUS_LOCKED)
            {
                PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, true);
            }
            else
            {
                setPlayerEntered(PChar, false);
            }
        }

        if (PChar->isDead())
        {
            auto state = dynamic_cast<CDeathState*>(PChar->PAI->GetCurrentState());
            if (state)
            {
                state->allowSendRaise();
            }
        }

        m_EnteredPlayers.erase(m_EnteredPlayers.find(PEntity->id));

        if (leavecode != 255)
        {
            // todo: probably shouldnt hardcode this
            if (leavecode == BATTLEFIELD_LEAVE_CODE_WARPDC)
            {
                PEntity->loc.p.x = 0;
                PEntity->loc.p.y = 0;
                PEntity->loc.p.z = 0;
            }
        }
        charutils::SendClearTimerPacket(PChar);

        // Remove enmity from character and their pet with all mobs
        auto func = [&](auto mob)
        {
            // Only remove enmity from pet if it is not charmed
            if (PChar->PPet)
            {
                mob->PEnmityContainer->Clear(PChar->PPet->id);
            }
            mob->PEnmityContainer->Clear(PChar->id);
        };

        ForEachRequiredEnemy(func);
        ForEachAdditionalEnemy(func);
    }
    else
    {
        auto check = [PEntity, &found](auto entity)
        {
            if (PEntity == entity)
            {
                found = true;
                return found;
            }
            return false;
        };

        if (PEntity->objtype == TYPE_NPC)
        {
            PEntity->status = STATUS_TYPE::DISAPPEAR;
            PEntity->loc.zone->UpdateEntityPacket(PEntity, ENTITY_DESPAWN, UPDATE_ALL_MOB);

            if (auto* PNpcEntity = dynamic_cast<CNpcEntity*>(PEntity))
            {
                if (std::find(m_NpcList.begin(), m_NpcList.end(), PNpcEntity) != m_NpcList.end())
                {
                    m_NpcList.erase(std::remove_if(m_NpcList.begin(), m_NpcList.end(), check), m_NpcList.end());
                }
            }
        }
        else if (PEntity->objtype == TYPE_MOB || PEntity->objtype == TYPE_PET)
        {
            // todo: probably need to check allegiance too cause besieged will prolly use > 0x700 too
            // allies targid >= 0x700
            if (PEntity->targid >= 0x700)
            {
                // Disappear pets that do not belong to players
                auto* PPetEntity = dynamic_cast<CPetEntity*>(PEntity);
                if (PPetEntity && (!PPetEntity->PMaster || PPetEntity->PMaster->objtype != TYPE_PC))
                {
                    PEntity->status = STATUS_TYPE::DISAPPEAR;
                }

                if (auto* PMobEntity = dynamic_cast<CMobEntity*>(PEntity))
                {
                    if (std::find(m_AllyList.begin(), m_AllyList.end(), PMobEntity) != m_AllyList.end())
                    {
                        // We should not put an isAlive check here because some ally can be dead at cleanup
                        // but not despawned (for example Prishe in Dawn fight)
                        if (PMobEntity->PAI->IsSpawned())
                        {
                            PEntity->status = STATUS_TYPE::DISAPPEAR;
                            PEntity->loc.zone->UpdateEntityPacket(PEntity, ENTITY_DESPAWN, UPDATE_NONE);
                        }

                        m_AllyList.erase(std::remove_if(m_AllyList.begin(), m_AllyList.end(), check), m_AllyList.end());
                    }
                }
            }
            else
            {
                auto checkEnemy = [PEntity, &found](auto entity)
                {
                    if (entity.PMob == PEntity)
                    {
                        found = true;
                        return found;
                    }
                    return false;
                };
                m_RequiredEnemyList.erase(std::remove_if(m_RequiredEnemyList.begin(), m_RequiredEnemyList.end(), checkEnemy), m_RequiredEnemyList.end());
                m_AdditionalEnemyList.erase(std::remove_if(m_AdditionalEnemyList.begin(), m_AdditionalEnemyList.end(), checkEnemy), m_AdditionalEnemyList.end());
            }

            // Clear the mob's enmity
            auto* PMob = dynamic_cast<CMobEntity*>(PEntity);
            if (PMob)
            {
                PMob->PEnmityContainer->Clear();
            }
        }
        PEntity->loc.zone->PushPacket(PEntity, CHAR_INRANGE, std::make_unique<CEntityAnimationPacket>(PEntity, PEntity, CEntityAnimationPacket::Fade_Out));
    }

    PEntity->PBattlefield = nullptr;
    return found;
}

void CBattlefield::onTick(time_point time)
{
    TracyZoneScoped;
    if (!m_Attacked)
    {
        CheckInProgress();
    }

    if (time > m_Tick + 1s)
    {
        // todo : bcnm - update tick, fight tick, end if time is up
        m_Tick       = time;
        m_FightTick  = m_Status == BATTLEFIELD_STATUS_LOCKED ? m_FightTick : time;
        m_FinishTime = m_Status >= BATTLEFIELD_STATUS_WON ? m_FightTick - m_StartTime : m_FinishTime;

        luautils::OnBattlefieldTick(this);
    }
}

bool CBattlefield::CanCleanup(bool cleanup)
{
    if (cleanup)
    {
        m_Cleanup = cleanup;
    }

    return m_Cleanup || m_EnteredPlayers.empty();
}

bool CBattlefield::Cleanup(time_point time, bool force)
{
    // Wait until
    if (!force && !m_EnteredPlayers.empty() && m_cleanupTime > time)
    {
        return false;
    }

    // First cleanup the players if they haven't been cleaned up yet
    if (!m_cleanedPlayers)
    {
        uint8 leavecode = m_Status == BATTLEFIELD_STATUS_WON ? BATTLEFIELD_LEAVE_CODE_WIN : BATTLEFIELD_LEAVE_CODE_LOSE;
        for (auto id : m_EnteredPlayers)
        {
            auto* PChar = GetZone()->GetCharByID(id);
            luautils::OnBattlefieldLeave(PChar, this, leavecode);
        }

        m_cleanedPlayers = true;
        if (!force)
        {
            m_cleanupTime = time + 10s;
            return false;
        }
    }

    for (const auto& mob : m_RequiredEnemyList)
    {
        if (mob.PMob->isAlive() && mob.PMob->PAI->IsSpawned())
        {
            mob.PMob->PAI->Despawn();
        }
    }

    for (const auto& mob : m_AdditionalEnemyList)
    {
        if (mob.PMob->isAlive() && mob.PMob->PAI->IsSpawned())
        {
            mob.PMob->PAI->Despawn();
        }
    }

    if (GetStatus() == BATTLEFIELD_STATUS_WON && GetRecord().time > m_FinishTime)
    {
        SetRecord(m_Initiator.name, m_FinishTime, m_EnteredPlayers.size());
    }
    auto tempEnemies  = m_RequiredEnemyList;
    auto tempEnemies2 = m_AdditionalEnemyList;
    auto tempNpcs     = m_NpcList;
    auto tempAllies   = m_AllyList;
    auto tempPlayers  = m_EnteredPlayers;

    for (auto mob : tempEnemies)
    {
        RemoveEntity(mob.PMob);
    }
    for (auto mob : tempEnemies2)
    {
        RemoveEntity(mob.PMob);
    }
    for (auto* npc : tempNpcs)
    {
        RemoveEntity(npc);
    }
    for (auto* ally : tempAllies)
    {
        RemoveEntity(ally);
    }

    uint8 leavecode = m_Status == BATTLEFIELD_STATUS_WON ? BATTLEFIELD_LEAVE_CODE_WIN : BATTLEFIELD_LEAVE_CODE_LOSE;

    for (auto id : tempPlayers)
    {
        auto* PChar = GetZone()->GetCharByID(id);
        if (PChar)
        {
            RemoveEntity(PChar, leavecode);
        }
    }

    // Remove all registered players as long as they're in the zone
    for (auto id : m_RegisteredPlayers)
    {
        auto* PChar = GetZone()->GetCharByID(id);
        if (PChar)
        {
            PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, true);
            m_Zone->updateCharLevelRestriction(PChar);

            // Remove allies from player's spawn list
            for (auto* ally : tempAllies)
            {
                SpawnIDList_t::iterator MOB = PChar->SpawnMOBList.find(ally->id);
                if (MOB != PChar->SpawnMOBList.end())
                {
                    PChar->SpawnMOBList.erase(MOB);
                }
            }

            if (PChar->PPet)
            {
                PChar->PPet->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, true);
            }
        }
    }

    if (m_Attacked && m_Status == BATTLEFIELD_STATUS_WON)
    {
        const char* query        = "SELECT fastestTime FROM bcnm_records WHERE bcnmId = %u AND zoneId = %u";
        auto        ret          = _sql->Query(query, this->GetID(), this->GetZoneID());
        bool        updateRecord = true;
        if (ret != SQL_ERROR && _sql->NextRow() == SQL_SUCCESS)
        {
            updateRecord = _sql->GetUIntData(0) > std::chrono::duration_cast<std::chrono::seconds>(m_Record.time).count();
        }

        if (updateRecord)
        {
            query          = "UPDATE bcnm_records SET fastestName = '%s', fastestTime = %u, fastestPartySize = %u WHERE bcnmId = %u AND zoneid = %u";
            auto timeThing = std::chrono::duration_cast<std::chrono::seconds>(m_Record.time).count();

            _sql->Query(query, m_Record.name.c_str(), timeThing, m_Record.partySize, this->GetID(), GetZoneID());
        }
    }

    return true;
}

bool CBattlefield::CheckInProgress()
{
    // clang-format off
    ForEachEnemy([&](CMobEntity* PMob)
    {
        if (!PMob->PEnmityContainer->GetEnmityList()->empty())
        {
            if (m_Status == BATTLEFIELD_STATUS_OPEN)
            {
                SetStatus(BATTLEFIELD_STATUS_LOCKED);
            }
            m_Attacked = true;
        }
    });
    // clang-format on

    // mobs might have 0 enmity but we wont allow anymore players to enter
    return m_Status != BATTLEFIELD_STATUS_OPEN;
}

void CBattlefield::ForEachPlayer(const std::function<void(CCharEntity*)>& func)
{
    for (auto player : m_EnteredPlayers)
    {
        func(GetZone()->GetCharByID(player));
    }
}

void CBattlefield::ForEachEnemy(const std::function<void(CMobEntity*)>& func)
{
    ForEachRequiredEnemy(func);
    ForEachAdditionalEnemy(func);
}

void CBattlefield::ForEachRequiredEnemy(const std::function<void(CMobEntity*)>& func)
{
    for (auto mob : m_RequiredEnemyList)
    {
        func(mob.PMob);
    }
}

void CBattlefield::ForEachAdditionalEnemy(const std::function<void(CMobEntity*)>& func)
{
    for (auto mob : m_AdditionalEnemyList)
    {
        func(mob.PMob);
    }
}

void CBattlefield::ForEachNpc(const std::function<void(CNpcEntity*)>& func)
{
    for (auto* npc : m_NpcList)
    {
        func(npc);
    }
}

void CBattlefield::ForEachAlly(const std::function<void(CMobEntity*)>& func)
{
    for (auto* ally : m_AllyList)
    {
        func(ally);
    }
}

void CBattlefield::addGroup(BattlefieldGroup group)
{
    if (group.randomDeathCallback.valid())
    {
        group.randomMobId = xirand::GetRandomElement(group.mobIds);
    }
    m_groups.emplace_back(group);
}

void CBattlefield::handleDeath(CBaseEntity* PEntity)
{
    if (PEntity->objtype != TYPE_MOB || m_groups.empty())
    {
        return;
    }

    // Create a copy of groups since m_groups may change during the callbacks
    auto groups(m_groups);

    for (auto& group : groups)
    {
        // Calculate the total mobs that are dead for this group
        uint8 deathCount = 0;

        for (uint32 mobID : group.mobIds)
        {
            CMobEntity* PMob = dynamic_cast<CMobEntity*>(zoneutils::GetEntity(mobID, TYPE_MOB | TYPE_PET));
            if (PMob == nullptr || PMob->isDead())
            {
                ++deathCount;
            }
        }

        for (uint32 mobId : group.mobIds)
        {
            if (mobId != PEntity->id)
            {
                continue;
            }

            if (group.deathCallback.valid())
            {
                auto result = group.deathCallback(CLuaBattlefield(this), CLuaBaseEntity(PEntity), deathCount);
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError("Error in battlefield %s group.death: %s", this->GetName(), err.what());
                }
            }

            if (group.allDeathCallback.valid() && deathCount >= group.mobIds.size())
            {
                auto result = group.allDeathCallback(CLuaBattlefield(this), CLuaBaseEntity(PEntity));
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError("Error in battlefield %s group.allDeath: %s", this->GetName(), err.what());
                }
            }

            if (group.randomDeathCallback.valid() && mobId == group.randomMobId)
            {
                auto result = group.randomDeathCallback(CLuaBattlefield(this), CLuaBaseEntity(PEntity));
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError("Error in battlefield %s group.randomDeath: %s", this->GetName(), err.what());
                }
            }

            break;
        }
    }
}

void CBattlefield::setPlayerEntered(CCharEntity* PChar, bool entered)
{
    CStatusEffect* effect = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_BATTLEFIELD);

    if (effect == nullptr)
    {
        ShowError("Effect was null.");
        return;
    }

    effect->SetTier(entered ? 1 : 0);
}

bool CBattlefield::hasPlayerEntered(CCharEntity* PChar)
{
    if (!PChar->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD))
    {
        return false;
    }

    return PChar->StatusEffectContainer->GetStatusEffect(EFFECT_BATTLEFIELD)->GetTier() == 1;
}

uint16 CBattlefield::getBattlefieldArea(CCharEntity* PChar)
{
    return PChar->StatusEffectContainer->GetStatusEffect(EFFECT_BATTLEFIELD)->GetSubPower();
}
