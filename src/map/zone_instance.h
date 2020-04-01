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

#include "zone.h"
#include "instance.h"

typedef std::vector<std::unique_ptr<CInstance>> instanceList_t;

class CZoneInstance : public CZone
{
public:

    virtual CCharEntity*    GetCharByName(int8* name) override;                             // finds the player if exists in zone
    virtual CCharEntity*	GetCharByID(uint32 id) override;
    virtual CBaseEntity*	GetEntity(uint16 targid, uint8 filter = -1) override; 			// получаем указатель на любую сущность в зоне

    virtual void	SpawnPCs(CCharEntity* PChar) override; 									// отображаем персонажей в зоне
    virtual void	SpawnMOBs(CCharEntity* PChar) override;									// отображаем MOBs в зоне
    virtual void	SpawnPETs(CCharEntity* PChar) override;									// отображаем PETs в зоне
    virtual void	SpawnTRUSTs(CCharEntity* PChar) override;
    virtual void	SpawnNPCs(CCharEntity* PChar) override;									// отображаем NPCs в зоне
    virtual void	SpawnMoogle(CCharEntity* PChar) override;								// отображаем Moogle в MogHouse
    virtual void    SpawnTransport(CCharEntity* PChar) override;                            // отображаем транспорт

    virtual void	WideScan(CCharEntity* PChar, uint16 radius) override;					// сканирование местности с заданным радиусом

    virtual void	DecreaseZoneCounter(CCharEntity* PChar) override;						// добавляем персонажа в зону
    virtual void	IncreaseZoneCounter(CCharEntity* PChar) override;						// удаляем персонажа из зоны

    virtual void	InsertNPC(CBaseEntity* PNpc) override;									// добавляем в зону npc
    virtual void	InsertMOB(CBaseEntity* PMob) override;									// добавляем в зону mob
    virtual void	InsertPET(CBaseEntity* PPet) override;									// добавляем в зону pet
    virtual void	InsertTRUST(CBaseEntity* PTrust) override;
    virtual void	DeleteTRUST(CBaseEntity* PTrust) override;
    virtual void	DeletePET(CBaseEntity* PPet) override;       	                        // derefs the pet's ID from this zone

    virtual void    FindPartyForMob(CBaseEntity* PEntity) override;                         // ищем группу для монстра
    virtual void    TransportDepart(uint16 boundary, uint16 zone) override;                 // транспотр отправляется, необходимо собрать пассажиров

    virtual void	TOTDChange(TIMETYPE TOTD) override;										// обработка реакции мира на смену времени суток
    virtual void	PushPacket(CBaseEntity*, GLOBAL_MESSAGE_TYPE, CBasicPacket*) override;	// отправляем глобальный пакет в пределах зоны

    virtual void	ZoneServer(time_point tick, bool check_regions) override;

    virtual void	ForEachChar(std::function<void(CCharEntity*)> func) override;
    virtual void	ForEachCharInstance(CBaseEntity* PEntity, std::function<void(CCharEntity*)> func) override;
    virtual void	ForEachMobInstance(CBaseEntity* PEntity, std::function<void(CMobEntity*)> func) override;

    CInstance* CreateInstance(uint8 instanceid);

    CZoneInstance(ZONEID ZoneID, REGIONTYPE RegionID, CONTINENTTYPE ContinentID);
    ~CZoneInstance();

private:

    instanceList_t instanceList;
};

#endif
