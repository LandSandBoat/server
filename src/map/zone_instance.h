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

#ifndef _CZONEINSTANCE_H
#define _CZONEINSTANCE_H

#include "instance.h"
#include "zone.h"

class CZoneInstance : public CZone
{
public:
    DISALLOW_COPY_AND_MOVE(CZoneInstance);

    virtual CCharEntity* GetCharByName(const std::string& name) override; // finds the player if exists in zone
    virtual CCharEntity* GetCharByID(uint32 id) override;
    virtual CBaseEntity* GetEntity(uint16 targid, uint8 filter = -1) override; // get a pointer to any entity in the zone

    virtual void SpawnPCs(CCharEntity* PChar) override;
    virtual void SpawnMOBs(CCharEntity* PChar) override;
    virtual void SpawnPETs(CCharEntity* PChar) override;
    virtual void SpawnTRUSTs(CCharEntity* PChar) override;
    virtual void SpawnNPCs(CCharEntity* PChar) override;
    virtual void SpawnConditionalNPCs(CCharEntity* PChar) override; // display Moogle in MogHouse in zone
    virtual void SpawnTransport(CCharEntity* PChar) override;       // display ship/boat in zone

    virtual void WideScan(CCharEntity* PChar, uint16 radius) override;

    virtual void DecreaseZoneCounter(CCharEntity* PChar) override; // add a character to the zone
    virtual void IncreaseZoneCounter(CCharEntity* PChar) override; // remove a character from the zone

    virtual void InsertNPC(CBaseEntity* PNpc) override;
    virtual void InsertMOB(CBaseEntity* PMob) override;
    virtual void InsertPET(CBaseEntity* PPet) override;
    virtual void InsertTRUST(CBaseEntity* PTrust) override;

    virtual void FindPartyForMob(CBaseEntity* PEntity) override; // looking for a party for the monster

    virtual void TransportDepart(uint16 boundary, uint16 prevZoneId, uint16 transportId) override; // ship/boat is leaving, passengers need to be collected

    virtual void TOTDChange(vanadiel_time::TOTD TOTD) override; // process the world's reactions to changing time of day

    virtual void PushPacket(CBaseEntity*, GLOBAL_MESSAGE_TYPE, const std::unique_ptr<CBasicPacket>&) override; // send a global package within the zone

    virtual void UpdateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask, bool alwaysInclude = false) override;

    virtual void ZoneServer(timer::time_point tick) override;
    virtual void CheckTriggerAreas() override;

    void ForEachChar(const std::function<void(CCharEntity*)>& func) override;
    void ForEachCharInstance(CBaseEntity* PEntity, const std::function<void(CCharEntity*)>& func) override;
    void ForEachMob(const std::function<void(CMobEntity*)>& func) override;
    void ForEachMobInstance(CBaseEntity* PEntity, const std::function<void(CMobEntity*)>& func) override;
    void ForEachNpc(const std::function<void(CNpcEntity*)>& func) override;
    void ForEachNpcInstance(CBaseEntity* PEntity, const std::function<void(CNpcEntity*)>& func) override;
    void ForEachTrust(const std::function<void(CTrustEntity*)>& func) override;
    void ForEachTrustInstance(CBaseEntity* PEntity, const std::function<void(CTrustEntity*)>& func) override;
    void ForEachPet(const std::function<void(CPetEntity*)>& func) override;
    void ForEachPetInstance(CBaseEntity* PEntity, const std::function<void(CPetEntity*)>& func) override;
    void ForEachAlly(const std::function<void(CMobEntity*)>& func) override;
    void ForEachAllyInstance(CBaseEntity* PEntity, const std::function<void(CMobEntity*)>& func) override;

    CInstance* CreateInstance(uint32 instanceid);

    CZoneInstance(ZONEID ZoneID, REGION_TYPE RegionID, CONTINENT_TYPE ContinentID, uint8 levelRestriction);
    ~CZoneInstance() override;

private:
    typedef std::vector<std::unique_ptr<CInstance>> instanceList_t;

    instanceList_t m_InstanceList;
};

#endif // _CZONEINSTANCE_H
