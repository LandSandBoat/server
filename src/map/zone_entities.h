﻿/*
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

#ifndef _CZONEENTITIES_H
#define _CZONEENTITIES_H

#include "zone.h"

#include <set>
#include <vector>

class CZoneEntities
{
public:
    void HealAllMobs();

    CCharEntity* GetCharByName(const std::string& name); // finds the player if exists in zone
    CCharEntity* GetCharByID(uint32 id);
    CBaseEntity* GetEntity(uint16 targid, uint8 filter = -1); // get a pointer to any entity in the zone

    void UpdateCharPacket(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask);
    void UpdateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask, bool alwaysInclude = false);

    void SpawnPCs(CCharEntity* PChar);
    void SpawnMOBs(CCharEntity* PChar);
    void SpawnPETs(CCharEntity* PChar);
    void SpawnNPCs(CCharEntity* PChar);
    void SpawnTRUSTs(CCharEntity* PChar);
    void SpawnMoogle(CCharEntity* PChar);    // display Moogle in MogHouse in zone
    void SpawnTransport(CCharEntity* PChar); // display ship/boat in zone
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
    void DeletePET(CBaseEntity* PPet);
    void DeleteTRUST(CBaseEntity* PTrust);

    void FindPartyForMob(CBaseEntity* PEntity);         // looking for a party for the monster
    void TransportDepart(uint16 boundary, uint16 zone); // ship/boat is leaving, passengers need to be collected

    void TOTDChange(TIMETYPE TOTD); // process the world's reactions to changing time of day
    void WeatherChange(WEATHER weather);
    void MusicChange(uint16 BlockID, uint16 MusicTrackID);

    void PushPacket(CBaseEntity*, GLOBAL_MESSAGE_TYPE, std::unique_ptr<CBasicPacket>&&); // send a global package within the zone

    void ZoneServer(time_point tick);

    CZone* GetZone();

    EntityList_t GetCharList() const;
    EntityList_t GetMobList() const;
    bool         CharListEmpty() const;

    uint16 GetNewCharTargID();
    void   AssignDynamicTargIDandLongID(CBaseEntity* PEntity);

    EntityList_t m_allyList;
    EntityList_t m_mobList;
    EntityList_t m_petList;
    EntityList_t m_trustList;
    EntityList_t m_npcList;
    EntityList_t m_TransportList;
    EntityList_t m_charList;

    uint16           nextDynamicTargID; // The next dynamic targ ID to chosen -- SE rotates them forwards and skips entries that already exist.
    std::set<uint16> charTargIds;       // sorted set of targids for characters
    std::set<uint16> dynamicTargIds;    // sorted set of targids for dynamic entities

    std::vector<std::pair<uint16, time_point>> dynamicTargIdsToDelete; // list of targids pending deletion at a later date

    CZoneEntities(CZone*);
    ~CZoneEntities();

private:
    CZone*     m_zone;
    time_point m_EffectCheckTime{ server_clock::now() };

    time_point computeTime{ server_clock::now() };
    uint16     lastCharComputeTargId;

    time_point charPersistTime{ server_clock::now() };
    uint16     lastCharPersistTargId;
};

#endif
