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

#include <common/cbasetypes.h>
#include <common/ipp.h>
#include <common/types/flag.h>

#include <queue>

#include "zone.h"

class CBaseEntity;
class CCharEntity;
class CNpcEntity;

namespace zoneutils
{
namespace detail
{

struct LazyLoadState
{
    bool               enabled{ false };
    bool               asyncMode{ false };
    std::set<uint16>   managedZones{};
    std::queue<uint16> loadQueue{};
};

} // namespace detail

auto LoadZones(Scheduler& scheduler, MapConfig config, const std::vector<uint16>& zoneIds) -> Task<void>;
auto LoadZoneList(Scheduler& scheduler, MapConfig config) -> Task<void>;
auto Initialize(Scheduler& scheduler, MapConfig config) -> Task<void>;
auto ProcessLoadQueue(Scheduler& scheduler, MapConfig config) -> Task<void>;

auto IsLazyLoadingEnabled() -> bool;

// TODO:
// This shouldn't have side effects, it should be const and the caller should be responsible
// for requesting the zone is loaded if it isn't ready.
auto IsZoneReady(Scheduler& scheduler, MapConfig config, uint16 zoneId) -> Task<bool>;

auto GetManagedZones() -> std::vector<std::pair<uint16, std::string>>;
void FreeZoneList();
void InitializeWeather();
void TOTDChange(vanadiel_time::TOTD TOTD);
void SavePlayTime();

auto GetCurrentRegion(uint16 zoneId) -> REGION_TYPE;
auto GetCurrentContinent(uint16 zoneId) -> CONTINENT_TYPE;

auto GetWeatherElement(xi::Weather weather) -> int;

auto GetZone(uint16 zoneId) -> CZone*;
auto GetEntity(uint32 id, uint8 filter = -1) -> CBaseEntity*;
auto GetCharByName(const std::string& name) -> CCharEntity*;
auto GetCharFromWorld(uint32 charId, uint16 targId) -> CCharEntity*;  // returns pointer to character by id and target id
auto GetChar(uint32 charId) -> CCharEntity*;                          // returns pointer to character by id
auto GetCharToUpdate(uint32 primary, uint32 ternary) -> CCharEntity*; // returns pointer to preferred char to update for party changes
auto GetZonesAssignedToThisProcess(IPP mapIPP) -> std::vector<uint16>;
auto IsZoneAssignedToThisProcess(IPP mapIPP, ZONEID zoneId) -> bool;
void ForEachZone(FnRef<void(CZone*)> func);
void ForEachZone(const std::vector<uint16>& zoneIds, FnRef<void(CZone*)> func);
auto GetZoneIPP(uint16 zoneId) -> uint64;                    // returns IPP for zone ID
auto IsZoneAtPlayerCap(uint16 zoneId, bool isGM) -> bool;    // returns true if the zone is at capacity and the entry should be denied
auto IsResidentialArea(const CCharEntity* PChar) -> bool;    // returns whether or not the area is a residential zone
auto IsAlwaysOutOfNationControl(REGION_TYPE region) -> bool; // returns true if a region should never trigger "in areas outside own nation's control" latent effect; false otherwise.

void AfterZoneIn(CBaseEntity* PEntity); // triggers after a player has finished zoning in

}; // namespace zoneutils
