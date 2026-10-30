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

#include "instance.h"
#include "zone.h"

#include <common/types/flat_hash_map.h>

class CZoneInstance : public CZone
{
public:
    CZoneInstance(Scheduler& scheduler, MapConfig config, xi::ZoneId ZoneID, xi::Region RegionID, xi::Continent ContinentID, uint8 levelRestriction, const std::optional<xi::data::ZoneSettings>& settings);
    ~CZoneInstance() override;

    DISALLOW_COPY_AND_MOVE(CZoneInstance);

    auto CreateInstance(uint32 instanceid) -> CInstance*;

    auto GetCharByName(const std::string& name) -> CCharEntity* override; // finds the player if exists in zone
    auto GetCharByID(uint32 id) -> CCharEntity* override;
    auto GetEntity(uint16 targid, uint8 filter = -1) -> CBaseEntity* override; // get a pointer to any entity in the zone

    auto getInstanceByRunId(uint32 runId) const -> CInstance*;

    void SpawnPCs(CCharEntity* PChar) override;
    void SpawnMOBs(CCharEntity* PChar) override;
    void SpawnPETs(CCharEntity* PChar) override;
    void SpawnTRUSTs(CCharEntity* PChar) override;
    void SpawnNPCs(CCharEntity* PChar) override;
    void SpawnConditionalNPCs(CCharEntity* PChar) override; // display Moogle in MogHouse in zone
    void SpawnTransport(CCharEntity* PChar) override;       // display ship/boat in zone

    void WideScan(CCharEntity* PChar, uint16 radius) override;

    void DecreaseZoneCounter(CCharEntity* PChar) override; // Remove a character to the zone
    void IncreaseZoneCounter(CCharEntity* PChar) override; // Add a character from the zone

    void InsertNPC(CBaseEntity* PNpc) override;
    void InsertMOB(CBaseEntity* PMob) override;
    void InsertPET(CBaseEntity* PPet) override;
    void InsertTRUST(CBaseEntity* PTrust) override;

    void FindPartyForMob(CBaseEntity* PEntity) override; // looking for a party for the monster

    void TransportDepart(uint16 boundary, xi::ZoneId prevZoneId, std::string_view transport) override; // ship/boat is leaving, passengers need to be collected
    void DisembarkAll() override;                                                                      // the voyage zone is between runs, put whoever is still aboard ashore

    void PushPacket(CBaseEntity*, GLOBAL_MESSAGE_TYPE, const std::unique_ptr<CBasicPacket>&) override; // send a global package within the zone

    void UpdateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask, bool alwaysInclude = false) override;

    auto ZoneServer(timer::time_point tick) -> Task<void> override;
    auto CheckTriggerAreas() -> Task<void> override;

    void ForEachChar(FnRef<void(CCharEntity*)> func) override;
    void ForEachCharInstance(CBaseEntity* PEntity, FnRef<void(CCharEntity*)> func) override;
    void ForEachMob(FnRef<void(CMobEntity*)> func) override;
    void ForEachMobInstance(CBaseEntity* PEntity, FnRef<void(CMobEntity*)> func) override;
    void ForEachNpc(FnRef<void(CNpcEntity*)> func) override;
    void ForEachNpcInstance(CBaseEntity* PEntity, FnRef<void(CNpcEntity*)> func) override;
    void ForEachTrust(FnRef<void(CTrustEntity*)> func) override;
    void ForEachTrustInstance(CBaseEntity* PEntity, FnRef<void(CTrustEntity*)> func) override;
    void ForEachPet(FnRef<void(CPetEntity*)> func) override;
    void ForEachPetInstance(CBaseEntity* PEntity, FnRef<void(CPetEntity*)> func) override;
    void ForEachAlly(FnRef<void(CMobEntity*)> func) override;
    void ForEachAllyInstance(CBaseEntity* PEntity, FnRef<void(CMobEntity*)> func) override;

private:
    using instanceList_t = std::vector<std::unique_ptr<CInstance>>;

    instanceList_t                  m_InstanceList;
    FlatHashMap<uint32, CInstance*> instancesByRun_;
};
