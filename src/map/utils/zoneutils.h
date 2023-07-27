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

#ifndef _ZONEUTILS_H
#define _ZONEUTILS_H

#include "common/cbasetypes.h"

#include "zone.h"

/************************************************************************
 *                                                                       *
 *  Задумывалось, как что-то вроде контролера зон                        *
 *                                                                       *
 ************************************************************************/

class CBaseEntity;
class CCharEntity;
class CNpcEntity;

namespace zoneutils
{
    void LoadZoneList();
    void FreeZoneList();
    void InitializeWeather();
    void TOTDChange(TIMETYPE TOTD);
    void SavePlayTime();

    REGION_TYPE    GetCurrentRegion(uint16 ZoneID);
    CONTINENT_TYPE GetCurrentContinent(uint16 ZoneID);

    int GetWeatherElement(WEATHER weather);

    CZone*       GetZone(uint16 ZoneID);
    CNpcEntity*  GetTrigger(uint16 TargID, uint16 ZoneID);
    CBaseEntity* GetEntity(uint32 ID, uint8 filter = -1);
    CCharEntity* GetCharByName(std::string const& name);
    CCharEntity* GetCharFromWorld(uint32 charid, uint16 targid);  // returns pointer to character by id and target id
    CCharEntity* GetChar(uint32 id);                              // returns pointer to character by id
    CCharEntity* GetCharToUpdate(uint32 primary, uint32 ternary); // returns pointer to preferred char to update for party changes
    void         ForEachZone(const std::function<void(CZone*)>& func);
    uint64       GetZoneIPP(uint16 zoneid);       // returns IPP for zone ID
    bool         IsResidentialArea(CCharEntity*); // returns whether or not the area is a residential zone

    void AfterZoneIn(CBaseEntity* PEntity); // triggers after a player has finished zoning in

}; // namespace zoneutils

#endif
