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
#include <common/logging.h>
#include <common/mmo.h>
#include <common/scheduler.h>
#include <common/timer.h>
#include <common/types/maybe.h>
#include <common/vana_time.h>

#include <common/types/flat_hash_map.h>
#include <common/types/fn.h>

#include "battlefield_handler.h"
#include "campaign_handler.h"
#include "map/navmesh/inavmesh.h"
#include "map/navmesh/navmesh_config.h"
#include "map_config.h"
#include "packets/basic.h"
#include "spawn_slot.h"
#include "trigger_area.h"

#include <map/weather_container.h>

#include <map/ximesh/iximesh.h>

#include <common/types/hash_map.h>
#include <list>
#include <map>
#include <memory>

//
// Forward Declarations
//

#include "data/enums/weather.h"
#include "data/enums/zone.h"
#include "data/enums/zone_misc.h"
#include "data/enums/zone_type.h"
class XiMesh;
class CNavMesh;
class SpawnHandler;

#define MAX_ZONEID 300

inline constexpr auto ZONE_NO_DESTINATION = static_cast<xi::ZoneId>(0xFFFF);

enum NATION_TYPE : uint8
{
    NATION_SANDORIA = 0x00,
    NATION_BASTOK   = 0x01,
    NATION_WINDURST = 0x02,
    NATION_BEASTMEN = 0x03,
    NATION_NEUTRAL  = 0x05,
};

DECLARE_FORMAT_AS_UNDERLYING(NATION_TYPE);

enum class REGION_TYPE : uint8
{
    RONFAURE         = 0,
    ZULKHEIM         = 1,
    NORVALLEN        = 2,
    GUSTABERG        = 3,
    DERFLAND         = 4,
    SARUTABARUTA     = 5,
    KOLSHUSHU        = 6,
    ARAGONEU         = 7,
    FAUREGANDI       = 8,
    VALDEAUNIA       = 9,
    QUFIMISLAND      = 10,
    LITELOR          = 11,
    KUZOTZ           = 12,
    VOLLBOW          = 13,
    ELSHIMO_LOWLANDS = 14,
    ELSHIMO_UPLANDS  = 15,
    TULIA            = 16,
    MOVALPOLOS       = 17,
    TAVNAZIA         = 18,
    SANDORIA         = 19,
    BASTOK           = 20,
    WINDURST         = 21,
    JEUNO            = 22,
    DYNAMIS          = 23,
    TAVNAZIAN_MARQ   = 24,
    PROMYVION        = 25,
    LUMORIA          = 26,
    LIMBUS           = 27,
    WEST_AHT_URHGAN  = 28,
    MAMOOL_JA_SAVAGE = 29,
    HALVUNG          = 30,
    ARRAPAGO         = 31,
    ALZADAAL         = 32,
    RONFAURE_FRONT   = 33,
    NORVALLEN_FRONT  = 34,
    GUSTABERG_FRONT  = 35,
    DERFLAND_FRONT   = 36,
    SARUTA_FRONT     = 37,
    ARAGONEAU_FRONT  = 38,
    FAUREGANDI_FRONT = 39,
    VALDEAUNIA_FRONT = 40,
    ABYSSEA          = 41,
    THE_THRESHOLD    = 42,
    ABDHALJS         = 43,
    ADOULIN_ISLANDS  = 44,
    EAST_ULBUKA      = 45,

    UNKNOWN = 255
};
DECLARE_FORMAT_AS_UNDERLYING(REGION_TYPE);

enum class CONTINENT_TYPE : uint8
{
    THE_MIDDLE_LANDS       = 1,
    THE_ARADJIAH_CONTINENT = 2,
    THE_SHADOWREIGN_ERA    = 3,
    OTHER_AREAS            = 4
};
DECLARE_FORMAT_AS_UNDERLYING(CONTINENT_TYPE);

enum GLOBAL_MESSAGE_TYPE : uint8
{
    CHAR_INRANGE,
    CHAR_INRANGE_SELF,
    CHAR_INSHOUT,
    CHAR_INZONE
};

DECLARE_FORMAT_AS_UNDERLYING(GLOBAL_MESSAGE_TYPE);

enum class TELEPORT_TYPE : uint8
{
    OUTPOST_SANDY   = 0,
    OUTPOST_BASTOK  = 1,
    OUTPOST_WINDY   = 2,
    RUNIC_PORTAL    = 3,
    PAST_MAW        = 4,
    ABYSSEA_CONFLUX = 5,
    CAMPAIGN_SANDY  = 6,
    CAMPAIGN_BASTOK = 7,
    CAMPAIGN_WINDY  = 8,
    HOMEPOINT       = 9,
    SURVIVAL        = 10,
    WAYPOINT        = 11,
    ESCHAN_PORTAL   = 12,
};
DECLARE_FORMAT_AS_UNDERLYING(TELEPORT_TYPE);

struct zoneMusic_t
{
    uint16 m_songDay;   // music (daytime)
    uint16 m_songNight; // music (nighttime)
    uint16 m_bSongS;    // battle music (solo)
    uint16 m_bSongM;    // battle music (party)
};

/************************************************************************
 *                                                                       *
 *  zoneLine - unique identifier of a path from one point in a zone to   *
 *  another point in another zone. The departure area is the area,       *
 *  storing zoneLineID data. Arrival area and exact destination area     *
 *  defined in the structure.                                            *
 *                                                                       *
 ************************************************************************/

struct zoneLine_t
{
    uint32 zoneLineId; // 4 characters name such as 'z7b0'.

    // Where you zone from
    xi::ZoneId originZoneId;
    position_t originPos; // Center of the zoneline box.

    // Where you end up at
    xi::ZoneId destinationZoneId;
    position_t destinationPos;    // Center of the zoneline box
    float      destinationScaleX; // Box dimensions
    float      destinationScaleZ; // Box dimensions

    // Spawn slot cycling (0-7)
    uint8 m_spawnSlot = 0;
    auto  nextSpawnPosition() -> position_t;
};

class CBasicPacket;
class CBaseEntity;
class CCharEntity;
class CMobEntity;
class CNpcEntity;
class CPetEntity;
class CBattleEntity;
class CTrustEntity;
class CTreasurePool;
class CZoneEntities;
class NominateManager;

typedef std::list<std::unique_ptr<ITriggerArea>> triggerAreaList_t;

typedef std::list<zoneLine_t*> zoneLineList_t;

typedef FlatHashMap<uint16, CBaseEntity*> EntityList_t;

using QueryByNameResult_t = std::vector<CBaseEntity*>;

class CZone
{
public:
    CZone(Scheduler& scheduler, MapConfig config, xi::ZoneId ZoneID, REGION_TYPE RegionID, CONTINENT_TYPE ContinentID, uint8 levelRestriction);
    virtual ~CZone();

    DISALLOW_COPY_AND_MOVE(CZone);

    auto           GetID() const -> xi::ZoneId;
    xi::ZoneType   GetTypeMask();
    REGION_TYPE    GetRegionID();
    CONTINENT_TYPE GetContinentID();
    uint8          getLevelRestriction();
    uint32         GetIP() const;
    uint16         GetPort() const;
    uint16         GetTax() const;

    auto weather() -> WeatherContainer&;
    auto weather() const -> const WeatherContainer&;

    const std::string& getName();
    zoneLine_t*        GetZoneLine(uint32 zoneLineID);

    uint16 GetSoloBattleMusic() const;
    uint16 GetPartyBattleMusic() const;
    uint16 GetBackgroundMusicDay() const;
    uint16 GetBackgroundMusicNight() const;

    void SetSoloBattleMusic(uint16 music);
    void SetPartyBattleMusic(uint16 music);
    void SetBackgroundMusicDay(uint16 music);
    void SetBackgroundMusicNight(uint16 music);

    auto queryEntitiesByName(const std::string& pattern) -> const QueryByNameResult_t&;

    uint32                        GetLocalVar(const char* var);
    HashMap<std::string, uint32>& GetLocalVars();
    void                          SetLocalVar(const char* var, uint32 val);
    void                          ResetLocalVars();

    virtual CCharEntity* GetCharByName(const std::string& name);
    virtual CCharEntity* GetCharByID(uint32 id);

    // Gets an entity - ignores instances (use CBaseEntity->GetEntity if possible)
    virtual CBaseEntity* GetEntity(uint16 targid, uint8 filter = -1); // Get a pointer to any entity in the zone

    bool CanUseMisc(xi::ZoneMisc misc) const;
    void SetWeather(xi::Weather weather);
    void UpdateWeather();

    virtual void SpawnPCs(CCharEntity* PChar);
    virtual void SpawnMOBs(CCharEntity* PChar);
    virtual void SpawnPETs(CCharEntity* PChar);
    virtual void SpawnNPCs(CCharEntity* PChar);
    virtual void SpawnTRUSTs(CCharEntity* PChar);
    virtual void SpawnConditionalNPCs(CCharEntity* PChar); // Spawn Moogle in Moghouse in zone (if applicable)
    virtual void SpawnTransport(CCharEntity* PChar);       // Spawn ships/boats in the zone
    void         SavePlayTime();

    virtual void WideScan(CCharEntity* PChar, uint16 radius);

    virtual void DecreaseZoneCounter(CCharEntity* PChar); // Remove a character from the zone
    virtual void IncreaseZoneCounter(CCharEntity* PChar); // Add a character to the zone

    virtual void InsertNPC(CBaseEntity* PNpc);
    virtual void InsertMOB(CBaseEntity* PMob);
    virtual void InsertPET(CBaseEntity* PPet);
    virtual void InsertTRUST(CBaseEntity* PTrust);

    virtual void FindPartyForMob(CBaseEntity* PEntity);

    // Keep the underlying spatial grid current when an entity moves outside the per-tick resync
    // (teleport, setPos, a movement step, etc.).
    virtual void onEntityMoved(CBaseEntity* PEntity);

    virtual void TransportDepart(uint16 boundary, xi::ZoneId prevZoneId, uint16 transportId); // Collect passengers if ship/boat is departing

    virtual void updateCharLevelRestriction(CCharEntity* PChar); // Removes the character's level restriction. If the zone has a level restriction, it is applied after it is removed.

    void InsertTriggerArea(std::unique_ptr<ITriggerArea>&& triggerArea); // Add an active area to the zone

    virtual void TOTDChange(vanadiel_time::TOTD TOTD);
    virtual void PushPacket(CBaseEntity*, GLOBAL_MESSAGE_TYPE, const std::unique_ptr<CBasicPacket>&);

    virtual void UpdateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask, bool alwaysInclude = false);

    CZoneEntities* GetZoneEntities();

    void createZoneTimers();

    virtual auto ZoneServer(timer::time_point tick) -> Task<void>;
    virtual auto CheckTriggerAreas() -> Task<void>;

    virtual void ForEachChar(FnRef<void(CCharEntity*)> func);
    virtual void ForEachCharInstance(CBaseEntity* PEntity, FnRef<void(CCharEntity*)> func);
    virtual void ForEachMob(FnRef<void(CMobEntity*)> func);
    virtual void ForEachMobInstance(CBaseEntity* PEntity, FnRef<void(CMobEntity*)> func);
    virtual void ForEachNpc(FnRef<void(CNpcEntity*)> func);
    virtual void ForEachNpcInstance(CBaseEntity* PEntity, FnRef<void(CNpcEntity*)> func);
    virtual void ForEachTrust(FnRef<void(CTrustEntity*)> func);
    virtual void ForEachTrustInstance(CBaseEntity* PEntity, FnRef<void(CTrustEntity*)> func);
    virtual void ForEachPet(FnRef<void(CPetEntity*)> func);
    virtual void ForEachPetInstance(CBaseEntity* PEntity, FnRef<void(CPetEntity*)> func);
    virtual void ForEachAlly(FnRef<void(CMobEntity*)> func);
    virtual void ForEachAllyInstance(CBaseEntity* PEntity, FnRef<void(CMobEntity*)> func);

    auto spawnHandler() const -> SpawnHandler&;
    auto nominateManager() const -> NominateManager&;
    auto campaignHandler() const -> CCampaignHandler*;
    auto battlefieldHandler() const -> CBattlefieldHandler*;

    auto navMesh() const -> INavMesh*;
    auto xiMesh() const -> IXiMesh*;

    auto LoadNavMesh() -> Task<void>;
    void RebuildNavMesh(const NavMeshConfig& config = {});

    void LoadXiMesh();

protected:
    void CharZoneIn(CCharEntity* PChar);
    void CharZoneOut(CCharEntity* PChar);

    Scheduler& scheduler_;
    MapConfig  config_;

    Maybe<Scheduler::Token> zoneTimerToken_;
    Maybe<Scheduler::Token> zoneTimerTriggerAreasToken_;
    Maybe<Scheduler::Token> spawnHandlerTimerToken_;

    triggerAreaList_t m_triggerAreaList;

    HashMap<std::string, uint32> localVars_;

private:
    void LoadZoneSettings();
    void LoadZoneLines();
    void LoadZoneWeather();

    std::unique_ptr<INavMesh> navMesh_;
    std::unique_ptr<IXiMesh>  xiMesh_;

    xi::ZoneId     m_zoneID;
    xi::ZoneType   m_zoneType;
    REGION_TYPE    m_regionID;
    CONTINENT_TYPE m_continentID;
    uint8          m_levelRestriction;
    std::string    m_zoneName;
    uint16         m_zonePort{};
    uint32         m_zoneIP{};

    WeatherContainer weather_;

    CZoneEntities* m_zoneEntities;

    uint16       m_tax{};
    xi::ZoneMisc m_miscMask{};

    zoneMusic_t m_zoneMusic{};

    zoneLineList_t m_zoneLineList;

    CTreasurePool* m_TreasurePool;

    HashMap<std::string, QueryByNameResult_t> m_queryByNameResults;

    CBattlefieldHandler*             m_BattlefieldHandler; // BCNM Instances in this zone
    CCampaignHandler*                m_CampaignHandler;    // WOTG campaign information for this zone
    std::unique_ptr<SpawnHandler>    m_spawnHandler;       // Handles mob respawns
    std::unique_ptr<NominateManager> nominateManager_;     // Active /nominate proposals in this zone

    timer::time_point m_LoadedAt; // The time the zone was loaded
};
