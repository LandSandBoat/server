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

#include "zone.h"

#include "common/timer.h"
#include "common/types/fn.h"

#include "entities/base_entity.h"
#include "entities/char_entity.h"
#include "entities/mob_entity.h"
#include "entities/npc_entity.h"
#include "entities/pet_entity.h"
#include "entities/trust_entity.h"
#include "enums/music_slot.h"

#include "spatial_grid.h"

#include <functional>
#include <set>
#include <vector>

// Per-entity callbacks used by the spawn-sync helpers.
using EntityFn       = FnRef<bool(CBaseEntity*)>; // visibility predicate
using EntityCallback = FnRef<void(CBaseEntity*)>; // action run on a newly-spawned entity

class CZoneEntities
{
public:
    CZoneEntities(Scheduler& scheduler, MapConfig config, CZone* zone);
    ~CZoneEntities();

    void HealAllMobs();
    void TryAddToNearbySpawnLists(CBaseEntity* PEntity);

    void onEntityMoved(CBaseEntity* PEntity);
    void onEntityDespawned(CBaseEntity* PEntity);

    CCharEntity* GetCharByName(const std::string& name); // finds the player if exists in zone
    CCharEntity* GetCharByID(uint32 id);
    CBaseEntity* GetEntity(uint16 targid, uint8 filter = -1); // get a pointer to any entity in the zone

    void UpdateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask, bool alwaysInclude = false);

    void SpawnPCs(CCharEntity* PChar);
    void SpawnMOBs(CCharEntity* PChar);
    void SpawnPETs(CCharEntity* PChar);
    void SpawnNPCs(CCharEntity* PChar);
    void SpawnTRUSTs(CCharEntity* PChar);
    void SpawnConditionalNPCs(CCharEntity* PChar); // display Moogle in MogHouse in zone
    void SpawnTransport(CCharEntity* PChar);       // display ship/boat in zone
    void DespawnPC(CCharEntity* PChar);
    void SavePlayTime();

    void WideScan(CCharEntity* PChar, uint16 radius);

    void DecreaseZoneCounter(CCharEntity* PChar); // add a character to the zone

    void InsertAlly(CBaseEntity* PMob);
    void InsertPC(CCharEntity* PChar);
    void InsertNPC(CBaseEntity* PNpc);
    void InsertMOB(CBaseEntity* PMob);
    void InsertPET(CBaseEntity* PPet);
    void InsertTRUST(CBaseEntity* PTrust);

    void FindPartyForMob(CBaseEntity* PEntity); // looking for a party for the monster

    void TransportDepart(uint16 boundary, uint16 prevZoneId, uint16 transportId); // ship/boat is leaving, passengers need to be collected

    void WeatherChange(xi::Weather weather);
    void MusicChange(MusicSlot slotId, uint16 trackId);

    void PushPacket(CBaseEntity*, GLOBAL_MESSAGE_TYPE, const std::unique_ptr<CBasicPacket>&); // send a global package within the zone

    auto ZoneServer(timer::time_point tick) -> Task<void>;

    CZone* GetZone();

    auto GetEffectCheckTime() const -> timer::time_point;
    auto GetCharList() const -> const EntityList_t&;
    auto GetMobList() const -> const EntityList_t&;
    bool CharListEmpty() const;

    void ForEachChar(FnRef<void(CCharEntity*)> func);
    void ForEachMob(FnRef<void(CMobEntity*)> func);
    void ForEachNpc(FnRef<void(CNpcEntity*)> func);
    void ForEachTrust(FnRef<void(CTrustEntity*)> func);
    void ForEachPet(FnRef<void(CPetEntity*)> func);
    void ForEachAlly(FnRef<void(CMobEntity*)> func);

    auto GetNewCharTargID() -> uint16;
    void AssignDynamicTargIDandLongID(CBaseEntity* PEntity);
    void EraseStaleDynamicTargIDs();
    auto GetUsedDynamicTargIDsCount() const -> std::size_t;

private:
    auto mobTick(CMobEntity* PMob, timer::time_point tick) -> Task<void>;
    auto mobAggroCheck(CMobEntity* PMob, timer::time_point tick) -> Task<void>;
    auto npcTick(CNpcEntity* PNpc, timer::time_point tick) -> Task<void>;
    auto petTick(CPetEntity* PPet, timer::time_point tick) -> Task<void>;
    auto trustTick(CTrustEntity* PTrust, timer::time_point tick) -> Task<void>;
    auto charTick(CCharEntity* PChar, timer::time_point tick) -> Task<void>;

    // aggro check when a mob becomes visible
    void tapMobAggro(CCharEntity* PChar, CMobEntity* PCurrentMob);

    // clear and re-file every entity into the grid
    void rebuildSpatialGrid();

    // Sync one of a player's spawn lists against the proximity grid: drop now-invisible entries, then
    // add in-range visible ones from a 3x3 cell query. `visible` carries the precise status/vertical/
    // distance checks; `onAdd` runs per newly-added entity (mob aggro). `alwaysInclude` is an optional
    // set of entities that must be considered regardless of range (NPCs flagged alwaysRelevant, which
    // a range query can't find) - each is run through `visible` like any other candidate.
    void syncSpawnListWithGrid(CCharEntity* PChar, SpawnIDList_t& spawnList, uint8 objtype, uint8 spawnFlag, EntityFn visible, EntityCallback onAdd = {}, EntityCallback onUpdate = {}, const std::vector<CBaseEntity*>* alwaysInclude = nullptr);

    Scheduler& scheduler_;
    MapConfig  config_;

    CZone* m_zone;

    // NOTE: These are all keyed by targid
    EntityList_t m_allyList;
    EntityList_t m_mobList;
    EntityList_t m_petList;
    EntityList_t m_trustList;
    EntityList_t m_npcList;
    EntityList_t m_TransportList;
    EntityList_t m_charList;

    SpatialGrid               spatialGrid_;        // proximity grid; rebuilt every tick (always on)
    std::vector<uint32>       idsToRemoveScratch_; // reused scratch for grid spawn-list removals
    std::vector<CBaseEntity*> alwaysRelevantNpcs_; // NPCs flagged alwaysRelevant; collected each rebuild, spawned regardless of range

    std::vector<CBaseEntity*> tickEntityScratch_; // reusable snapshot of an entity list for a per-entity tick phase

    uint16           m_nextDynamicTargID; // The next dynamic targ ID to chosen -- SE rotates them forwards and skips entries that already exist.
    std::set<uint16> m_charTargIds;       // sorted set of targids for characters
    std::set<uint16> m_dynamicTargIds;    // sorted set of targids for dynamic entities

    std::vector<std::pair<uint16, timer::time_point>> m_dynamicTargIdsToDelete; // list of targids pending deletion at a later date

    timer::time_point m_EffectCheckTime{ timer::now() };

    timer::time_point m_computeTime{ timer::now() };
    uint16            m_lastCharComputeTargId{ 0 };

    timer::time_point m_charPersistTime{ timer::now() };
    uint16            m_lastCharPersistTargId{ 0 };

    //
    // Intermediate collections for use inside ZoneServer
    //

    std::vector<CMobEntity*>         m_mobsToDelete;
    std::vector<CNpcEntity*>         m_npcsToDelete;
    std::vector<CPetEntity*>         m_petsToDelete;
    std::vector<CTrustEntity*>       m_trustsToDelete;
    std::vector<CMobEntity*>         m_aggroableMobs;
    std::unordered_set<CCharEntity*> m_charsToChangeZone;
};
