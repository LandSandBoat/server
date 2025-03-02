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

#include "common/logging.h"
#include "common/timer.h"

#include "ai/ai_container.h"
#include "battlefield.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"
#include "entities/trustentity.h"
#include "lua_baseentity.h"
#include "lua_battlefield.h"
#include "mob_modifier.h"
#include "status_effect_container.h"
#include "utils/mobutils.h"
#include "utils/zoneutils.h"

CLuaBattlefield::CLuaBattlefield(CBattlefield* PBattlefield)
: m_PLuaBattlefield(PBattlefield)
{
    if (PBattlefield == nullptr)
    {
        ShowError("CLuaBattlefield created with nullptr instead of valid CBattlefield*!");
    }
}

uint16 CLuaBattlefield::getID()
{
    return m_PLuaBattlefield->GetID();
}

uint16 CLuaBattlefield::getZoneID()
{
    return m_PLuaBattlefield->GetZoneID();
}

uint8 CLuaBattlefield::getArea()
{
    return m_PLuaBattlefield->GetArea();
}

uint32 CLuaBattlefield::getTimeLimit()
{
    return std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetTimeLimit()).count();
}

uint32 CLuaBattlefield::getTimeInside()
{
    return std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetTimeInside()).count();
}

uint32 CLuaBattlefield::getRemainingTime()
{
    return std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetRemainingTime()).count();
}

uint32 CLuaBattlefield::getFightTick()
{
    return std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetFightTime() - m_PLuaBattlefield->GetStartTime()).count();
}

uint32 CLuaBattlefield::getWipeTime()
{
    return std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetWipeTime() - get_server_start_time()).count();
}

uint32 CLuaBattlefield::getFightTime()
{
    return std::chrono::duration_cast<std::chrono::seconds>(get_server_start_time() - m_PLuaBattlefield->GetFightTime()).count();
}

uint32 CLuaBattlefield::getMaxParticipants()
{
    return static_cast<uint32>(m_PLuaBattlefield->GetMaxParticipants());
}

uint32 CLuaBattlefield::getPlayerCount()
{
    return static_cast<uint32>(m_PLuaBattlefield->GetPlayerCount());
}

sol::table CLuaBattlefield::getPlayers()
{
    auto table = lua.create_table();
    // clang-format off
    m_PLuaBattlefield->ForEachPlayer([&](CCharEntity* PChar)
    {
        if (PChar)
        {
            table.add(PChar);
        }
    });
    // clang-format on
    return table;
}

sol::table CLuaBattlefield::getPlayersAndTrusts()
{
    auto table = lua.create_table();
    // clang-format off
    m_PLuaBattlefield->ForEachPlayer([&](CCharEntity* PChar)
    {
        if (PChar)
        {
            table.add(PChar);
            for (auto const& PTrust : PChar->PTrusts)
            {
                table.add(CLuaBaseEntity(PTrust));
            }
        }
    });
    // clang-format on
    return table;
}

sol::table CLuaBattlefield::getMobs(bool required, bool adds)
{
    auto table = lua.create_table();

    if (required && !m_PLuaBattlefield->m_RequiredEnemyList.empty())
    {
        // clang-format off
        m_PLuaBattlefield->ForEachRequiredEnemy(
        [&](CMobEntity* PMob)
        {
            table.add(CLuaBaseEntity(PMob));
        });
        // clang-format on
    }

    if (adds && !m_PLuaBattlefield->m_AdditionalEnemyList.empty())
    {
        // clang-format off
        m_PLuaBattlefield->ForEachAdditionalEnemy(
        [&](CMobEntity* PMob)
        {
            table.add(CLuaBaseEntity(PMob));
        });
        // clang-format on
    }

    return table;
}

sol::table CLuaBattlefield::getNPCs()
{
    auto table = lua.create_table();
    // clang-format off
    m_PLuaBattlefield->ForEachNpc(
    [&](CNpcEntity* PNpc)
    {
        table.add(CLuaBaseEntity(PNpc));
    });
    // clang-format on
    return table;
}

sol::table CLuaBattlefield::getAllies()
{
    auto table = lua.create_table();
    // clang-format off
    m_PLuaBattlefield->ForEachAlly(
    [&](CMobEntity* PAlly)
    {
        table.add(CLuaBaseEntity(PAlly));
    });
    // clang-format on
    return table;
}

std::tuple<std::string, uint32, uint32> CLuaBattlefield::getRecord()
{
    const auto& record = m_PLuaBattlefield->GetRecord();

    auto   name = record.name;
    uint32 time = std::chrono::duration_cast<std::chrono::seconds>(record.time).count();
    uint32 size = static_cast<uint32>(record.partySize);

    return std::make_tuple(name, time, size);
}

uint8 CLuaBattlefield::getStatus()
{
    return m_PLuaBattlefield->GetStatus();
}

uint64_t CLuaBattlefield::getLocalVar(std::string const& name)
{
    return m_PLuaBattlefield->GetLocalVar(name);
}

uint32 CLuaBattlefield::getLastTimeUpdate()
{
    auto count = std::chrono::duration_cast<std::chrono::seconds>(m_PLuaBattlefield->GetLastTimeUpdate()).count();
    return count;
}

std::pair<uint32, std::string> CLuaBattlefield::getInitiator()
{
    const auto& initiator = m_PLuaBattlefield->GetInitiator();
    return std::make_pair(initiator.id, initiator.name);
}

uint32 CLuaBattlefield::getArmouryCrate()
{
    return m_PLuaBattlefield->GetArmouryCrate();
}

void CLuaBattlefield::setLocalVar(std::string const& name, uint64_t value)
{
    m_PLuaBattlefield->SetLocalVar(name, value);
}

void CLuaBattlefield::setLastTimeUpdate(uint32 seconds)
{
    m_PLuaBattlefield->SetLastTimeUpdate(std::chrono::seconds(seconds));
}

void CLuaBattlefield::setTimeLimit(uint32 seconds)
{
    m_PLuaBattlefield->SetTimeLimit(std::chrono::seconds(seconds));
}

void CLuaBattlefield::setWipeTime(uint32 seconds)
{
    m_PLuaBattlefield->SetWipeTime(get_server_start_time() + std::chrono::seconds(seconds));
}

void CLuaBattlefield::setRecord(std::string const& name, uint32 seconds)
{
    m_PLuaBattlefield->SetRecord(name, std::chrono::seconds(seconds), m_PLuaBattlefield->GetPlayerCount());
}

void CLuaBattlefield::setStatus(uint8 status)
{
    m_PLuaBattlefield->SetStatus(status);
}

auto CLuaBattlefield::insertEntity(uint16 targid, bool ally, bool inBattlefield) -> CBaseEntity*
{
    BATTLEFIELDMOBCONDITION conditions = static_cast<BATTLEFIELDMOBCONDITION>(0);
    ENTITYTYPE              filter     = static_cast<ENTITYTYPE>(0x1F);

    auto* PEntity = ally ? mobutils::InstantiateAlly(targid, m_PLuaBattlefield->GetZoneID()) : m_PLuaBattlefield->GetZone()->GetEntity(targid, filter);

    if (PEntity)
    {
        m_PLuaBattlefield->InsertEntity(PEntity, inBattlefield, conditions, ally);
        return PEntity;
    }

    ShowError("CLuaBattlefield::insertEntity - targid ID %u not found!", targid);
    return nullptr;
}

bool CLuaBattlefield::cleanup(bool cleanup)
{
    return m_PLuaBattlefield->CanCleanup(cleanup);
}

void CLuaBattlefield::win()
{
    m_PLuaBattlefield->SetStatus(static_cast<uint8>(BATTLEFIELD_STATUS_WON));
    m_PLuaBattlefield->CanCleanup(true);
}

void CLuaBattlefield::lose()
{
    m_PLuaBattlefield->SetStatus(static_cast<uint8>(BATTLEFIELD_STATUS_LOST));
    m_PLuaBattlefield->CanCleanup(true);
}

void CLuaBattlefield::addGroups(sol::table const& groups, bool hasMultipleArenas)
{
    // get the global function "applyMixins"
    sol::function applyMixins = lua["applyMixins"];

    // Ensure that each area has its own super linking
    int16 superlinkId = 1000 * m_PLuaBattlefield->GetArea();
    // The lowest entity ID allowed within the battlefield. Used for battlefields with multiple areas.
    uint32 lowestId = UINT32_MAX;
    // The highest entity ID allowed within the battlefield
    uint32 highestId = 0;

    // Check if this Battlefield that can take place in multiple arenas (such as xNM fights)
    if (hasMultipleArenas)
    {
        std::set<uint32> entityIds;
        for (auto const& entry : groups)
        {
            QueryByNameResult_t groupEntities;
            sol::table          groupData = entry.second.as<sol::table>();

            auto groupMobs = groupData["mobs"];
            if (groupMobs.valid())
            {
                auto mobNames = groupMobs.get<std::vector<std::string>>();
                for (std::string const& name : mobNames)
                {
                    const QueryByNameResult_t& result = m_PLuaBattlefield->GetZone()->queryEntitiesByName(name);
                    for (CBaseEntity* entity : result)
                    {
                        entityIds.insert(entity->id);
                        lowestId  = std::min(lowestId, entity->id);
                        highestId = std::max(highestId, entity->id);
                    }
                }
            }
        }

        if (!entityIds.empty())
        {
            uint32 stride = uint32(entityIds.size()) / m_PLuaBattlefield->GetZone()->m_BattlefieldHandler->MaxBattlefieldAreas();

            // Look to see if there's an Armoury Crate within the group of monsters
            static const std::string ARMOURY_CRATE = "Armoury_Crate";

            uint32 armouryCrateOffset = 0;
            uint32 potentialCrateId   = lowestId + stride;
            while (potentialCrateId >= lowestId)
            {
                CBaseEntity* entity = zoneutils::GetEntity(potentialCrateId, TYPE_NPC);
                if (entity != nullptr && entity->name == ARMOURY_CRATE)
                {
                    armouryCrateOffset = potentialCrateId - lowestId;
                    // If an Armoury Crate is in the battlefield we need to account for it in the stride
                    ++stride;
                    break;
                }
                --potentialCrateId;
            }

            uint32 offset = stride * (m_PLuaBattlefield->GetArea() - 1);
            lowestId += offset;
            highestId = lowestId + stride - 1;
            if (armouryCrateOffset != 0)
            {
                m_PLuaBattlefield->setArmouryCrate(lowestId + armouryCrateOffset);
            }
        }
    }
    else
    {
        lowestId  = 0;
        highestId = UINT32_MAX;
    }

    // The entities to be added to the battlefield
    std::set<uint32> entities;
    std::set<uint32> spawnedEntities;

    std::vector<BattlefieldGroup> battlefieldGroups;
    for (auto const& entry : groups)
    {
        sol::table groupData = entry.second.as<sol::table>();

        QueryByNameResult_t groupEntities;

        // Lookup mob ids given the provided names
        auto groupMobs = groupData["mobs"];
        if (groupMobs.valid())
        {
            auto mobNames = groupMobs.get<std::vector<std::string>>();
            for (std::string const& name : mobNames)
            {
                const QueryByNameResult_t& result = m_PLuaBattlefield->GetZone()->queryEntitiesByName(name);
                for (CBaseEntity* entity : result)
                {
                    if (entity->id >= lowestId && entity->id <= highestId)
                    {
                        groupEntities.emplace_back(entity);
                        if (entities.find(entity->id) == entities.end())
                        {
                            m_PLuaBattlefield->InsertEntity(entity, true);
                            entities.insert(entity->id);
                        }
                    }
                }
            }
        }

        // Look to see if there have been any mob ids specifically set for this battlefield.
        auto groupMobIds = groupData["mobIds"];
        if (groupMobIds.valid())
        {
            auto addMobIdsForArea = [&](const std::vector<uint32>& mobIds)
            {
                for (uint32 mobid : mobIds)
                {
                    CBaseEntity* entity = zoneutils::GetEntity(mobid, TYPE_MOB);
                    if (entity != nullptr)
                    {
                        groupEntities.emplace_back(entity);
                        if (entities.find(entity->id) == entities.end())
                        {
                            m_PLuaBattlefield->InsertEntity(entity, true);
                            entities.insert(entity->id);
                        }
                    }
                }
            };

            if (hasMultipleArenas)
            {
                // Mob IDs need to be in the format of { { id, ... }, { ... } } with each subtable being an area
                auto  mobIds = groupMobIds.get<std::vector<std::vector<uint32>>>();
                uint8 area   = m_PLuaBattlefield->GetArea() - 1;

                if (area >= mobIds.size())
                {
                    ShowWarning("Battlefield Area is greated than groupMobIds size.");
                    return;
                }

                addMobIdsForArea(mobIds[area]);
            }
            else
            {
                auto mobIds = groupMobIds.get<std::vector<uint32>>();
                addMobIdsForArea(mobIds);
            }
        }

        BattlefieldGroup group;
        for (CBaseEntity* entity : groupEntities)
        {
            auto PMob = dynamic_cast<CMobEntity*>(entity);
            if (PMob == nullptr)
            {
                ShowError("PMob is null.");
                return;
            }

            // Restore modifiers here since we save the modifiers below but don't want any previous modifiers persisting
            PMob->restoreModifiers();
            PMob->restoreMobModifiers();

            group.mobIds.emplace_back(entity->id);
        }

        group.deathCallback       = groupData.get<sol::function>("death");
        group.allDeathCallback    = groupData.get<sol::function>("allDeath");
        group.randomDeathCallback = groupData.get<sol::function>("randomDeath");
        group.setupCallback       = groupData.get<sol::function>("setup");

        bool isParty = groupData.get_or("isParty", false);
        if (isParty)
        {
            CParty* party = nullptr;
            for (CBaseEntity* entity : groupEntities)
            {
                auto PMob = dynamic_cast<CMobEntity*>(entity);
                if (PMob == nullptr)
                {
                    ShowError("PMob is null.");
                    return;
                }

                // Leave existing party first before joining this new one
                if (PMob->PParty != nullptr)
                {
                    PMob->PParty->RemoveMember(PMob);
                }

                if (party == nullptr)
                {
                    party = new CParty(PMob);
                }
                else
                {
                    party->AddMember(PMob);
                }
            }
        }

        bool  superlink      = groupData.get_or("superlink", false);
        uint8 superlinkGroup = groupData.get_or("superlinkGroup", 0);

        if (superlink && superlinkGroup)
        {
            ShowWarning(fmt::format("Superlink bool and Group defined in the same mob group for Battlefield {}", m_PLuaBattlefield->GetID()));
        }

        if (superlink || superlinkGroup)
        {
            // Allow for all mobs existing in the battlefield to superlink and be
            // associated with other groups.

            // NOTE: Since this is battlefield specific, splitting the range for the
            // two options mid-way at 500.  If there becomes a need for more than 500,
            // these values will need to be adjusted.

            if (superlinkGroup)
            {
                superlinkId = 1000 * m_PLuaBattlefield->GetArea() + 500 + superlinkGroup;
            }
            else
            {
                ++superlinkId;
            }

            for (CBaseEntity* entity : groupEntities)
            {
                auto PMob = dynamic_cast<CMobEntity*>(entity);
                if (PMob == nullptr)
                {
                    ShowError("PMob is null.");
                    return;
                }

                PMob->setMobMod(MOBMOD_SUPERLINK, superlinkId);
                PMob->saveMobModifiers();
            }
        }

        bool stationary = groupData.get_or("stationary", true);
        if (stationary)
        {
            for (CBaseEntity* entity : groupEntities)
            {
                auto PMob = dynamic_cast<CMobEntity*>(entity);
                if (PMob == nullptr)
                {
                    ShowError("PMob is null.");
                    return;
                }

                PMob->setMobMod(MOBMOD_ROAM_RESET_FACING, 1);
                PMob->m_maxRoamDistance = 0.5f;
                PMob->m_roamFlags |= ROAMFLAG_SCRIPTED;
                PMob->saveMobModifiers();
            }
        }

        auto mods = groupData["mods"];
        if (mods.valid())
        {
            for (CBaseEntity* entity : groupEntities)
            {
                auto PMob = dynamic_cast<CMobEntity*>(entity);
                if (PMob == nullptr)
                {
                    ShowError("PMob is null.");
                    return;
                }

                for (auto const& modifier : mods.get<sol::table>())
                {
                    PMob->setModifier(modifier.first.as<Mod>(), modifier.second.as<uint16>());
                }
                PMob->saveModifiers();
            }
        }

        auto mobMods = groupData["mobMods"];
        if (mobMods.valid())
        {
            for (CBaseEntity* entity : groupEntities)
            {
                auto PMob = dynamic_cast<CMobEntity*>(entity);
                if (PMob == nullptr)
                {
                    ShowError("PMob is null.");
                    return;
                }

                for (auto const& modifier : mobMods.get<sol::table>())
                {
                    PMob->setMobMod(modifier.first.as<uint16>(), modifier.second.as<uint16>());
                }
                PMob->saveMobModifiers();
            }
        }

        auto mixins = groupData["mixins"];
        if (mixins.valid() && applyMixins.valid())
        {
            // get the parameter "mixinOptions" (optional)
            auto mixinOptions = groupData["mixinOptions"];

            for (CBaseEntity* entity : groupEntities)
            {
                auto result = applyMixins(CLuaBaseEntity(entity), mixins, mixinOptions);
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError("luautils::applyMixins: %s", err.what());
                }
            }
        }

        auto initialize = groupData.get<sol::function>("initialize");
        if (initialize.valid())
        {
            auto mobs = lua.create_table();
            for (CBaseEntity* entity : groupEntities)
            {
                mobs.add(CLuaBaseEntity(entity));
            }

            initialize(this, mobs);

            // Save modifiers after initialize all mobs
            for (CBaseEntity* entity : groupEntities)
            {
                auto PMob = dynamic_cast<CMobEntity*>(entity);
                if (PMob == nullptr)
                {
                    ShowError("PMob is null.");
                    return;
                }

                PMob->saveModifiers();
                PMob->saveMobModifiers();
            }
        }

        bool spawned = groupData.get_or("spawned", true);
        if (spawned)
        {
            for (CBaseEntity* entity : groupEntities)
            {
                spawnedEntities.insert(entity->id);
            }
        }

        battlefieldGroups.emplace_back(std::move(group));
    }

    // Spawn entities after all groups have been setup.
    // This prevents wiping modifiers set in spawn in subsequent groups that repeat the same mobs.
    for (uint32 entityID : spawnedEntities)
    {
        CBaseEntity* entity = zoneutils::GetEntity(entityID, TYPE_MOB);
        if (entity != nullptr)
        {
            entity->Spawn();
        }
    }

    // Finalize setting up groups now that they've been spawned
    for (auto& group : battlefieldGroups)
    {
        if (group.setupCallback.valid())
        {
            auto mobs = lua.create_table();
            for (uint32 entityID : group.mobIds)
            {
                CBaseEntity* entity = zoneutils::GetEntity(entityID, TYPE_MOB);
                mobs.add(CLuaBaseEntity(entity));
            }
            auto result = group.setupCallback(this, mobs);
            if (!result.valid())
            {
                sol::error err = result;
                ShowError("Error in battlefield %s group.setup: %s", m_PLuaBattlefield->GetName(), err.what());
            }
        }

        m_PLuaBattlefield->addGroup(group);
    }

    if (m_PLuaBattlefield->GetArmouryCrate() != 0)
    {
        if (auto* entity = dynamic_cast<CNpcEntity*>(zoneutils::GetEntity(m_PLuaBattlefield->GetArmouryCrate(), TYPE_NPC)))
        {
            m_PLuaBattlefield->InsertEntity(entity, true, CONDITION_DISAPPEAR_AT_START);
            entity->SetUntargetable(true);
            entity->ResetLocalVars();
            entity->PAI->EventHandler.removeListener("TRIGGER_CRATE");
        }
    }
}

//==========================================================//

void CLuaBattlefield::Register()
{
    SOL_USERTYPE("CBattlefield", CLuaBattlefield);
    SOL_REGISTER("getID", CLuaBattlefield::getID);
    SOL_REGISTER("getZoneID", CLuaBattlefield::getZoneID);
    SOL_REGISTER("getArea", CLuaBattlefield::getArea);
    SOL_REGISTER("getTimeLimit", CLuaBattlefield::getTimeLimit);
    SOL_REGISTER("getRemainingTime", CLuaBattlefield::getRemainingTime);
    SOL_REGISTER("getTimeInside", CLuaBattlefield::getTimeInside);
    SOL_REGISTER("getFightTick", CLuaBattlefield::getFightTick);
    SOL_REGISTER("getWipeTime", CLuaBattlefield::getWipeTime);
    SOL_REGISTER("getFightTime", CLuaBattlefield::getFightTime);
    SOL_REGISTER("getMaxParticipants", CLuaBattlefield::getMaxParticipants);
    SOL_REGISTER("getPlayerCount", CLuaBattlefield::getPlayerCount);
    SOL_REGISTER("getPlayers", CLuaBattlefield::getPlayers);
    SOL_REGISTER("getPlayersAndTrusts", CLuaBattlefield::getPlayersAndTrusts);
    SOL_REGISTER("getMobs", CLuaBattlefield::getMobs);
    SOL_REGISTER("getNPCs", CLuaBattlefield::getNPCs);
    SOL_REGISTER("getAllies", CLuaBattlefield::getAllies);
    SOL_REGISTER("getRecord", CLuaBattlefield::getRecord);
    SOL_REGISTER("getStatus", CLuaBattlefield::getStatus);
    SOL_REGISTER("getLastTimeUpdate", CLuaBattlefield::getLastTimeUpdate);
    SOL_REGISTER("getInitiator", CLuaBattlefield::getInitiator);
    SOL_REGISTER("getLocalVar", CLuaBattlefield::getLocalVar);
    SOL_REGISTER("getArmouryCrate", CLuaBattlefield::getArmouryCrate);
    SOL_REGISTER("setLocalVar", CLuaBattlefield::setLocalVar);
    SOL_REGISTER("setLastTimeUpdate", CLuaBattlefield::setLastTimeUpdate);
    SOL_REGISTER("setTimeLimit", CLuaBattlefield::setTimeLimit);
    SOL_REGISTER("setWipeTime", CLuaBattlefield::setWipeTime);
    SOL_REGISTER("setRecord", CLuaBattlefield::setRecord);
    SOL_REGISTER("setStatus", CLuaBattlefield::setStatus);
    SOL_REGISTER("insertEntity", CLuaBattlefield::insertEntity);
    SOL_REGISTER("cleanup", CLuaBattlefield::cleanup);
    SOL_REGISTER("win", CLuaBattlefield::win);
    SOL_REGISTER("lose", CLuaBattlefield::lose);
    SOL_REGISTER("addGroups", CLuaBattlefield::addGroups);
};

std::ostream& operator<<(std::ostream& os, const CLuaBattlefield& battlefield)
{
    std::string id = battlefield.m_PLuaBattlefield ? std::to_string(battlefield.m_PLuaBattlefield->GetID()) : "nullptr";
    return os << "CLuaBattlefield(" << id << ")";
}

//==========================================================//
