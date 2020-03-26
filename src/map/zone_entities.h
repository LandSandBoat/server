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

#ifndef _CZONEENTITIES_H
#define _CZONEENTITIES_H

#include "zone.h"

class CZoneEntities
{
public:

    void			HealAllMobs();

    CCharEntity*    GetCharByName(int8* name);                                      // finds the player if exists in zone
    CCharEntity*	GetCharByID(uint32 id);
    CBaseEntity*	GetEntity(uint16 targid, uint8 filter = -1); 					// получаем указатель на любую сущность в зоне

    void			SpawnPCs(CCharEntity* PChar);									// отображаем персонажей в зоне
    void			SpawnMOBs(CCharEntity* PChar);									// отображаем MOBs в зоне
    void			SpawnPETs(CCharEntity* PChar);									// отображаем PETs в зоне
    void			SpawnNPCs(CCharEntity* PChar);									// отображаем NPCs в зоне
    void			SpawnTRUSTs(CCharEntity* PChar);
    void			SpawnMoogle(CCharEntity* PChar);								// отображаем Moogle в MogHouse
    void			SpawnTransport(CCharEntity* PChar);                             // отображаем транспорт
    void			DespawnPC(CCharEntity* PChar);
    void			SavePlayTime();

    void			WideScan(CCharEntity* PChar, uint16 radius);					// сканирование местности с заданным радиусом

    void			DecreaseZoneCounter(CCharEntity* PChar);						// добавляем персонажа в зону

    void			InsertAlly(CBaseEntity* PMob);
    void			InsertPC(CCharEntity* PChar);
    void			InsertNPC(CBaseEntity* PNpc);									// добавляем в зону npc
    void			InsertMOB(CBaseEntity* PMob);									// добавляем в зону mob
    void			InsertPET(CBaseEntity* PPet);									// добавляем в зону pet
    void			InsertTRUST(CBaseEntity* PTrust);
    void			DeletePET(CBaseEntity* PPet);       	                        // derefs the pet's ID from this zone
    void			DeleteTRUST(CBaseEntity* PTrust);

    void			FindPartyForMob(CBaseEntity* PEntity);                          // ищем группу для монстра
    void			TransportDepart(uint16 boundary, uint16 zone);                  // транспотр отправляется, необходимо собрать пассажиров

    void			TOTDChange(TIMETYPE TOTD);										// обработка реакции мира на смену времени суток
    void			WeatherChange(WEATHER weather);
    void			PushPacket(CBaseEntity*, GLOBAL_MESSAGE_TYPE, CBasicPacket*);	// отправляем глобальный пакет в пределах зоны

    void			ZoneServer(time_point tick, bool check_region);

    CZone*          GetZone();

    EntityList_t	GetCharList();
    bool			CharListEmpty();
    uint16			GetNewTargID();

    EntityList_t	m_allyList;
    EntityList_t	m_mobList;				// список всех MOBs в зоне
    EntityList_t	m_petList;				// список всех PETs в зоне
    EntityList_t	m_trustList;
    EntityList_t	m_npcList;				// список всех NPCs в зоне
    EntityList_t	m_charList;				// список всех PCs  в зоне

    CZoneEntities(CZone*);
    ~CZoneEntities();
private:

    CZone* m_zone;
    CBaseEntity*    m_Transport;            // указатель на транспорт в зоне
    time_point m_EffectCheckTime {server_clock::now()};

};

#endif
