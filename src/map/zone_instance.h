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
    CZoneInstance(Scheduler& scheduler, MapConfig config, xi::ZoneId ZoneID, REGION_TYPE RegionID, CONTINENT_TYPE ContinentID, uint8 levelRestriction);
    ~CZoneInstance() override;

    DISALLOW_COPY_AND_MOVE(CZoneInstance);

    CInstance* CreateInstance(uint32 instanceid);

    virtual CCharEntity* GetCharByName(const std::string& name) override; // finds the player if exists in zone
    virtual CCharEntity* GetCharByID(uint32 id) override;
    virtual CBaseEntity* GetEntity(uint16 targid, uint8 filter = -1) override; // get a pointer to any entity in the zone

    auto getInstanceByRunId(uint32 runId) const -> CInstance*;

    virtual void SpawnPCs(CCharEntity* PChar) override;
    virtual void SpawnMOBs(CCharEntity* PChar) override;
    virtual void SpawnPETs(CCharEntity* PChar) override;
    virtual void SpawnTRUSTs(CCharEntity* PChar) override;
    virtual void SpawnNPCs(CCharEntity* PChar) override;
    virtual void SpawnConditionalNPCs(CCharEntity* PChar) override; // display Moogle in MogHouse in zone
    virtual void SpawnTransport(CCharEntity* PChar) override;       // display ship/boat in zone

    virtual void WideScan(CCharEntity* PChar, uint16 radius) override;

    virtual void DecreaseZoneCounter(CCharEntity* PChar) override; // Remove a character to the zone
    virtual void IncreaseZoneCounter(CCharEntity* PChar) override; // Add a character from the zone

    virtual void InsertNPC(CBaseEntity* PNpc) override;
    virtual void InsertMOB(CBaseEntity* PMob) override;
    virtual void InsertPET(CBaseEntity* PPet) override;
    virtual void InsertTRUST(CBaseEntity* PTrust) override;

    virtual void FindPartyForMob(CBaseEntity* PEntity) override; // looking for a party for the monster

    virtual void TransportDepart(uint16 boundary, xi::ZoneId prevZoneId, uint16 transportId) override; // ship/boat is leaving, passengers need to be collected

    virtual void PushPacket(CBaseEntity*, GLOBAL_MESSAGE_TYPE, const std::unique_ptr<CBasicPacket>&) override; // send a global package within the zone

    virtual void UpdateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask, bool alwaysInclude = false) override;

    virtual auto ZoneServer(timer::time_point tick) -> Task<void> override;
    virtual auto CheckTriggerAreas() -> Task<void> override;

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
    typedef std::vector<std::unique_ptr<CInstance>> instanceList_t;

    instanceList_t                  m_InstanceList;
    FlatHashMap<uint32, CInstance*> instancesByRun_;
};
