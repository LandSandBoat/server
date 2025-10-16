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

#include "entities/baseentity.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"
#include "entities/petentity.h"
#include "entities/trustentity.h"
#include "enums/music_slot.h"

#include <set>
#include <vector>

class CZoneEntities
{
public:
    CZoneEntities(CZone*);
    ~CZoneEntities();

    void HealAllMobs();
    void TryAddToNearbySpawnLists(CBaseEntity* PEntity);

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

    void TOTDChange(vanadiel_time::TOTD TOTD); // process the world's reactions to changing time of day
    void WeatherChange(Weather weather);
    void MusicChange(MusicSlot slotId, uint16 trackId);

    void PushPacket(CBaseEntity*, GLOBAL_MESSAGE_TYPE, const std::unique_ptr<CBasicPacket>&); // send a global package within the zone

    void ZoneServer(timer::time_point tick);

    CZone* GetZone();

    auto         GetEffectCheckTime() const -> timer::time_point;
    EntityList_t GetCharList() const;
    EntityList_t GetMobList() const;
    bool         CharListEmpty() const;

    void ForEachChar(std::function<void(CCharEntity*)> const& func);
    void ForEachMob(std::function<void(CMobEntity*)> const& func);
    void ForEachNpc(std::function<void(CNpcEntity*)> const& func);
    void ForEachTrust(std::function<void(CTrustEntity*)> const& func);
    void ForEachPet(std::function<void(CPetEntity*)> const& func);
    void ForEachAlly(std::function<void(CMobEntity*)> const& func);

    auto GetNewCharTargID() -> uint16;
    void AssignDynamicTargIDandLongID(CBaseEntity* PEntity);
    void EraseStaleDynamicTargIDs();
    auto GetUsedDynamicTargIDsCount() const -> std::size_t;

private:
    CZone* m_zone;

    // NOTE: These are all keyed by targid
    EntityList_t m_allyList;
    EntityList_t m_mobList;
    EntityList_t m_petList;
    EntityList_t m_trustList;
    EntityList_t m_npcList;
    EntityList_t m_TransportList;
    EntityList_t m_charList;

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
