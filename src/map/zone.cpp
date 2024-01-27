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

// TODO:
// It is necessary to divide the Czone class into basic and heirs. Already painted: Standard, Rezident, Instance and Dinamis
// Each of these zones has special behavior

#include "zone.h"

#include "common/logging.h"
#include "common/socket.h"
#include "common/timer.h"
#include "common/utils.h"
#include "common/vana_time.h"

#include <cstring>

#include "battlefield.h"
#include "common/vana_time.h"
#include "enmity_container.h"
#include "latent_effect_container.h"
#include "linkshell.h"
#include "map.h"
#include "message.h"
#include "monstrosity.h"
#include "notoriety_container.h"
#include "party.h"
#include "spell.h"
#include "status_effect_container.h"
#include "treasure_pool.h"
#include "unitychat.h"
#include "zone_entities.h"

#include "entities/automatonentity.h"
#include "entities/npcentity.h"
#include "entities/petentity.h"

#include "lua/luautils.h"

#include "packets/action.h"
#include "packets/char.h"
#include "packets/char_sync.h"
#include "packets/char_update.h"
#include "packets/entity_update.h"
#include "packets/inventory_assign.h"
#include "packets/inventory_finish.h"
#include "packets/inventory_item.h"
#include "packets/lock_on.h"
#include "packets/message_basic.h"
#include "packets/server_ip.h"
#include "packets/wide_scan.h"

#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"
#include "utils/mobutils.h"
#include "utils/moduleutils.h"
#include "utils/petutils.h"
#include "utils/zoneutils.h"

int32 zone_server(time_point tick, CTaskMgr::CTask* PTask)
{
    CZone* PZone = std::any_cast<CZone*>(PTask->m_data);
    PZone->ZoneServer(tick);
    return 0;
}

int32 zone_trigger_area(time_point tick, CTaskMgr::CTask* PTask)
{
    CZone* PZone = std::any_cast<CZone*>(PTask->m_data);
    PZone->CheckTriggerAreas();
    return 0;
}

int32 zone_update_weather(time_point tick, CTaskMgr::CTask* PTask)
{
    CZone* PZone = std::any_cast<CZone*>(PTask->m_data);

    if (!PZone->IsWeatherStatic())
    {
        PZone->UpdateWeather();
    }

    return 0;
}

CZone::CZone(ZONEID ZoneID, REGION_TYPE RegionID, CONTINENT_TYPE ContinentID, uint8 levelRestriction)
: m_zoneID(ZoneID)
, m_zoneType(ZONE_TYPE::UNKNOWN)
, m_regionID(RegionID)
, m_continentID(ContinentID)
, m_levelRestriction(levelRestriction)
, m_WeatherChangeTime(0)
{
    TracyZoneScoped;

    m_useNavMesh = false;
    std::ignore  = m_useNavMesh;

    ZoneTimer             = nullptr;
    ZoneTimerTriggerAreas = nullptr;

    m_TreasurePool       = nullptr;
    m_BattlefieldHandler = nullptr;
    m_Weather            = WEATHER_NONE;
    m_navMesh            = nullptr;
    m_zoneEntities       = new CZoneEntities(this);
    m_CampaignHandler    = new CCampaignHandler(this);

    // settings should load first
    LoadZoneSettings();

    LoadZoneLines();
    LoadZoneWeather();

    // NOTE: Heavy resources like Navmesh are now loaded outside of the constructor in zoneutils::LoadZoneList
}

CZone::~CZone()
{
    destroy(m_TreasurePool);
    destroy(m_CampaignHandler);
    destroy(m_zoneEntities);
}

ZONEID CZone::GetID()
{
    return m_zoneID;
}

ZONE_TYPE CZone::GetTypeMask()
{
    return m_zoneType;
}

REGION_TYPE CZone::GetRegionID()
{
    return m_regionID;
}

CONTINENT_TYPE CZone::GetContinentID()
{
    return m_continentID;
}

uint8 CZone::getLevelRestriction()
{
    return m_levelRestriction;
}

uint32 CZone::GetIP() const
{
    return m_zoneIP;
}

uint16 CZone::GetPort() const
{
    return m_zonePort;
}

uint16 CZone::GetTax() const
{
    return m_tax;
}

WEATHER CZone::GetWeather()
{
    return m_Weather;
}

uint32 CZone::GetWeatherChangeTime() const
{
    return m_WeatherChangeTime;
}

const std::string& CZone::getName()
{
    return m_zoneName;
}

uint8 CZone::GetSoloBattleMusic() const
{
    return m_zoneMusic.m_bSongS;
}

uint8 CZone::GetPartyBattleMusic() const
{
    return m_zoneMusic.m_bSongM;
}

uint8 CZone::GetBackgroundMusicDay() const
{
    return m_zoneMusic.m_songDay;
}

uint8 CZone::GetBackgroundMusicNight() const
{
    return m_zoneMusic.m_songNight;
}

void CZone::SetSoloBattleMusic(uint8 music)
{
    m_zoneMusic.m_bSongS = music;
}

void CZone::SetPartyBattleMusic(uint8 music)
{
    m_zoneMusic.m_bSongM = music;
}

void CZone::SetBackgroundMusicDay(uint8 music)
{
    m_zoneMusic.m_songDay = music;
}

void CZone::SetBackgroundMusicNight(uint8 music)
{
    m_zoneMusic.m_songNight = music;
}

/**
 * Queries for entities (mobs or npcs) which name match the given pattern.
 *
 * @param pattern The pattern used to match the entity name. We use % as wildcard for consistency
 * with other methods that perform pattern matching.
 * E.g: %anto% matches Shantotto and Canto-anto
 */
QueryByNameResult_t const& CZone::queryEntitiesByName(std::string const& pattern)
{
    TracyZoneScoped;

    // Use memoization since lookups are typically for the same mob names
    auto result = m_queryByNameResults.find(pattern);
    if (result != m_queryByNameResults.end())
    {
        return result->second;
    }

    std::vector<CBaseEntity*> entities;

    // TODO: Make work for instances
    // clang-format off
    ForEachNpc([&](CNpcEntity* PNpc)
    {
        if (matches(PNpc->getName(), pattern))
        {
            entities.emplace_back(PNpc);
        }
    });

    ForEachMob([&](CMobEntity* PMob)
    {
        if (matches(PMob->getName(), pattern))
        {
            entities.emplace_back(PMob);
        }
     });
    // clang-format on

    m_queryByNameResults[pattern] = std::move(entities);
    return m_queryByNameResults[pattern];
}

uint32 CZone::GetLocalVar(const char* var)
{
    return m_LocalVars[var];
}

void CZone::SetLocalVar(const char* var, uint32 val)
{
    m_LocalVars[var] = val;
}

void CZone::ResetLocalVars()
{
    m_LocalVars.clear();
}

bool CZone::CanUseMisc(uint16 misc) const
{
    return (m_miscMask & misc) == misc;
}

bool CZone::IsWeatherStatic() const
{
    return m_WeatherVector.empty() || m_WeatherVector.size() == 1;
}

zoneLine_t* CZone::GetZoneLine(uint32 zoneLineID)
{
    for (zoneLineList_t::const_iterator i = m_zoneLineList.begin(); i != m_zoneLineList.end(); ++i)
    {
        if ((*i)->m_zoneLineID == zoneLineID)
        {
            return (*i);
        }
    }
    return nullptr;
}

void CZone::LoadZoneLines()
{
    TracyZoneScoped;
    static const char fmtQuery[] = "SELECT zoneline, tozone, tox, toy, toz, rotation FROM zonelines WHERE fromzone = %u";

    int32 ret = sql->Query(fmtQuery, m_zoneID);

    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            zoneLine_t* zl = new zoneLine_t;

            zl->m_zoneLineID     = (uint32)sql->GetIntData(0);
            zl->m_toZone         = (uint16)sql->GetIntData(1);
            zl->m_toPos.x        = sql->GetFloatData(2);
            zl->m_toPos.y        = sql->GetFloatData(3);
            zl->m_toPos.z        = sql->GetFloatData(4);
            zl->m_toPos.rotation = (uint8)sql->GetIntData(5);

            m_zoneLineList.emplace_back(zl);
        }
    }
}

/*************************************************************************
 *                                                                        *
 *  Loads weather for the zone from zone_bweather SQL Table               *
 *                                                                        *
 *  Weather is a rotating pattern of 2160 vanadiel days for each zone.    *
 *  It's stored as a blob of 2160 16-bit values, each representing 1 day  *
 *  starting from day 0 and storing 3 5-bit weather values each.          *
 *                                                                        *
 *              0        00000       00000        00000                   *
 *              ^        ^^^^^       ^^^^^        ^^^^^                   *
 *          padding      normal      common       rare                    *
 *                                                                        *
 *************************************************************************/

void CZone::LoadZoneWeather()
{
    TracyZoneScoped;
    static const char* Query = "SELECT weather FROM zone_weather WHERE zone = %u;";

    int32 ret = sql->Query(Query, m_zoneID);
    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        sql->NextRow();
        auto* weatherBlob = reinterpret_cast<uint16*>(sql->GetData(0));
        for (uint16 i = 0; i < WEATHER_CYCLE; i++)
        {
            if (weatherBlob[i])
            {
                uint8 w_normal = static_cast<uint8>(weatherBlob[i] >> 10);
                uint8 w_common = static_cast<uint8>((weatherBlob[i] >> 5) & 0x1F);
                uint8 w_rare   = static_cast<uint8>(weatherBlob[i] & 0x1F);
                m_WeatherVector.insert(std::make_pair(i, zoneWeather_t(w_normal, w_common, w_rare)));
            }
        }
    }
    else
    {
        ShowCritical("CZone::LoadZoneWeather: Cannot load zone weather (%u). Ensure zone_weather.sql has been imported!", m_zoneID);
    }
}

void CZone::LoadZoneSettings()
{
    TracyZoneScoped;
    static const char* Query = "SELECT "
                               "zone.name,"
                               "zone.zoneip,"
                               "zone.zoneport,"
                               "zone.music_day,"
                               "zone.music_night,"
                               "zone.battlesolo,"
                               "zone.battlemulti,"
                               "zone.tax,"
                               "zone.misc,"
                               "zone.zonetype,"
                               "bcnm.name "
                               "FROM zone_settings AS zone "
                               "LEFT JOIN bcnm_info AS bcnm "
                               "USING (zoneid) "
                               "WHERE zoneid = %u "
                               "LIMIT 1";

    if (sql->Query(Query, m_zoneID) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
    {
        m_zoneName.insert(0, (const char*)sql->GetData(0));

        inet_pton(AF_INET, (const char*)sql->GetData(1), &m_zoneIP);
        m_zonePort              = (uint16)sql->GetUIntData(2);
        m_zoneMusic.m_songDay   = (uint8)sql->GetUIntData(3);           // background music (day)
        m_zoneMusic.m_songNight = (uint8)sql->GetUIntData(4);           // background music (night)
        m_zoneMusic.m_bSongS    = (uint8)sql->GetUIntData(5);           // solo battle music
        m_zoneMusic.m_bSongM    = (uint8)sql->GetUIntData(6);           // party battle music
        m_tax                   = (uint16)(sql->GetFloatData(7) * 100); // tax for bazaar
        m_miscMask              = (uint16)sql->GetUIntData(8);

        m_zoneType = static_cast<ZONE_TYPE>(sql->GetUIntData(9));

        if (sql->GetData(10) != nullptr) // bcnmid cannot be used now, because they start from scratch
        {
            m_BattlefieldHandler = new CBattlefieldHandler(this);
        }
        if (m_miscMask & MISC_TREASURE)
        {
            m_TreasurePool = new CTreasurePool(TREASUREPOOL_ZONE);
        }
        if (m_CampaignHandler->m_PZone == nullptr)
        {
            m_CampaignHandler = nullptr;
        }
    }
    else
    {
        ShowCritical("CZone::LoadZoneSettings: Cannot load zone settings (%u)", m_zoneID);
    }
}

void CZone::LoadNavMesh()
{
    TracyZoneScoped;
    if (m_navMesh == nullptr)
    {
        m_navMesh = new CNavMesh((uint16)GetID());
    }

    char file[255];
    memset(file, 0, sizeof(file));
    snprintf(file, sizeof(file), "navmeshes/%s.nav", getName().c_str());

    if (!m_navMesh->load(file))
    {
        DebugNavmesh("CZone::LoadNavMesh: Cannot load navmesh file (%s)", file);
        destroy(m_navMesh);
    }
}

void CZone::LoadZoneLos()
{
    if (GetTypeMask() & ZONE_TYPE::CITY || (m_miscMask & MISC_LOS_OFF))
    {
        // Skip cities and zones with line of sight turned off
        return;
    }

    if (lineOfSight)
    {
        // Clean up previous object if one exists.
        destroy(lineOfSight);
    }

    lineOfSight = ZoneLos::Load((uint16)GetID(), fmt::sprintf("losmeshes/%s.obj", getName()));
}

/************************************************************************
 *                                                                       *
 *  Add a MOB to the zone                                                *
 *                                                                       *
 ************************************************************************/

void CZone::InsertMOB(CBaseEntity* PMob)
{
    m_zoneEntities->InsertMOB(PMob);
}

/************************************************************************
 *                                                                       *
 *  Add an NPC to the zone                                               *
 *                                                                       *
 ************************************************************************/

void CZone::InsertNPC(CBaseEntity* PNpc)
{
    m_zoneEntities->InsertNPC(PNpc);
}

void CZone::DeletePET(CBaseEntity* PPet)
{
    m_zoneEntities->DeletePET(PPet);
}

/************************************************************************
 *                                                                       *
 *  Add a PET to the zone (free targid 0x700-0x7FF)                      *
 *                                                                       *
 ************************************************************************/

void CZone::InsertPET(CBaseEntity* PPet)
{
    m_zoneEntities->InsertPET(PPet);
}

/************************************************************************
 *                                                                       *
 *  Add a trust to the zone                                              *
 *                                                                       *
 ************************************************************************/

void CZone::InsertTRUST(CBaseEntity* PTrust)
{
    m_zoneEntities->InsertTRUST(PTrust);
}

void CZone::DeleteTRUST(CBaseEntity* PTrust)
{
    m_zoneEntities->DeleteTRUST(PTrust);
}

/************************************************************************
 *                                                                       *
 *  Add a trigger area to the zone                                       *
 *                                                                       *
 ************************************************************************/

void CZone::InsertTriggerArea(CTriggerArea* triggerArea)
{
    if (triggerArea != nullptr)
    {
        m_triggerAreaList.emplace_back(triggerArea);
    }
}

/************************************************************************
 *                                                                       *
 *  We are looking for a monster for a party. For monsters grouped       *
 *  together, mutual aid (link) system is used                           *
 *                                                                       *
 ************************************************************************/

void CZone::FindPartyForMob(CBaseEntity* PEntity)
{
    TracyZoneScoped;
    m_zoneEntities->FindPartyForMob(PEntity);
}

/************************************************************************
 *                                                                       *
 *  The ship/boat is leaving, necessary to collect passengers            *
 *                                                                       *
 ************************************************************************/

void CZone::TransportDepart(uint16 boundary, uint16 zone)
{
    m_zoneEntities->TransportDepart(boundary, zone);
}

void CZone::updateCharLevelRestriction(CCharEntity* PChar)
{
    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_RESTRICTION))
    {
        // If the level restriction is already the same then no need to change it
        CStatusEffect* statusEffect = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_RESTRICTION);
        if (statusEffect == nullptr || statusEffect->GetPower() == m_levelRestriction)
        {
            return;
        }

        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_LEVEL_RESTRICTION);
    }

    if (m_levelRestriction != 0)
    {
        PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_LEVEL_RESTRICTION, EFFECT_LEVEL_RESTRICTION, m_levelRestriction, 0, 0));
    }
}

void CZone::SetWeather(WEATHER weather)
{
    TracyZoneScoped;
    if (weather >= MAX_WEATHER_ID)
    {
        ShowWarning("Weather value (%d) exceeds MAX_WEATHER_ID.", weather);
        return;
    }

    if (m_Weather == weather)
    {
        return;
    }

    m_zoneEntities->WeatherChange(weather);

    m_Weather           = weather;
    m_WeatherChangeTime = CVanaTime::getInstance()->getVanaTime();

    m_zoneEntities->PushPacket(nullptr, CHAR_INZONE, new CWeatherPacket(m_WeatherChangeTime, m_Weather, xirand::GetRandomNumber(4, 28)));
}

void CZone::UpdateWeather()
{
    TracyZoneScoped;

    uint32 CurrentVanaDate   = CVanaTime::getInstance()->getDate();                                  // Current Vanadiel timestamp in minutes
    uint32 StartFogVanaDate  = (CurrentVanaDate - (CurrentVanaDate % VTIME_DAY)) + (VTIME_HOUR * 2); // Vanadiel timestamp of 2 AM in minutes
    uint32 EndFogVanaDate    = StartFogVanaDate + (VTIME_HOUR * 5);                                  // Vanadiel timestamp of 7 AM in minutes
    uint32 WeatherNextUpdate = 0;
    uint32 WeatherDay        = 0;
    uint8  WeatherChance     = 0;

    // Random time between 3 minutes and 30 minutes for the next weather change
    WeatherNextUpdate = (xirand::GetRandomNumber(180, 1801));

    // Find the timestamp since the start of vanadiel
    WeatherDay = CVanaTime::getInstance()->getVanaTime();

    // Calculate what day we are on since the start of vanadiel time
    // 1 Vana'diel Day = 57 minutes 36 seconds or 3456 seconds
    WeatherDay = WeatherDay / 3456;

    // The weather starts over again every 2160 days
    WeatherDay = WeatherDay % WEATHER_CYCLE;

    // Get a random number to determine which weather effect we will use
    WeatherChance = xirand::GetRandomNumber(100);

    zoneWeather_t&& weatherType = zoneWeather_t(0, 0, 0);

    for (auto& weather : m_WeatherVector)
    {
        if (weather.first > WeatherDay)
        {
            break;
        }
        weatherType = weather.second;
    }

    uint8 Weather = 0;

    // 15% chance for rare weather, 35% chance for common weather, 50% chance for normal weather
    // * Percentages were generated from a 6 hour sample and rounded down to closest multiple of 5*
    if (WeatherChance < 15) // 15% chance to have the weather_rare
    {
        Weather = weatherType.rare;
    }
    else if (WeatherChance < 50) // 35% chance to have weather_common
    {
        Weather = weatherType.common;
    }
    else
    {
        Weather = weatherType.normal;
    }

    // This check is incorrect, fog is not simply a time of day, though it may consistently happen in SOME zones
    // (Al'Taieu likely has it every morning, while Atohwa Chasm can have it at random any time of day)
    if ((CurrentVanaDate >= StartFogVanaDate) &&
        (CurrentVanaDate < EndFogVanaDate) &&
        (Weather < WEATHER_HOT_SPELL) &&
        !(GetTypeMask() & ZONE_TYPE::CITY))
    {
        Weather = WEATHER_FOG;
        // Force the weather to change by 7 am
        //  2.4 vanadiel minutes = 1 earth second
        WeatherNextUpdate = (uint32)((EndFogVanaDate - CurrentVanaDate) * 2.4);
    }

    SetWeather((WEATHER)Weather);
    luautils::OnZoneWeatherChange(GetID(), Weather);

    CTaskMgr::getInstance()->AddTask(new CTaskMgr::CTask("zone_update_weather", server_clock::now() + std::chrono::seconds(WeatherNextUpdate), this,
                                                         CTaskMgr::TASK_ONCE, zone_update_weather));
}

/************************************************************************
 *                                                                       *
 *  Remove a character from the zone. If ZoneServer and character are    *
 *  online, and there is no more left in the zone, then stop zone        *
 *                                                                       *
 ************************************************************************/

void CZone::DecreaseZoneCounter(CCharEntity* PChar)
{
    TracyZoneScoped;
    m_zoneEntities->DecreaseZoneCounter(PChar);

    if (m_zoneEntities->CharListEmpty())
    {
        m_timeZoneEmpty = server_clock::now();
    }
    else
    {
        m_zoneEntities->DespawnPC(PChar);
    }

    CharZoneOut(PChar);
}

/************************************************************************
 *                                                                       *
 *  Add a character to the zone. If zone isn't running, then load zone.  *
 *  Be sure to check the number of characters in the zone.               *
 *  The maximum number of characters in one zone is 768                  *
 *                                                                       *
 ************************************************************************/

void CZone::IncreaseZoneCounter(CCharEntity* PChar)
{
    TracyZoneScoped;

    if (PChar == nullptr || PChar->loc.zone != nullptr || PChar->PTreasurePool != nullptr)
    {
        ShowWarning("CZone::IncreaseZoneCounter() - PChar is null, or Player zone or Treasure Pools is not null.");
        return;
    }

    PChar->targid = m_zoneEntities->GetNewCharTargID();

    if (PChar->targid >= 0x700)
    {
        ShowError("CZone::InsertChar : targid is high (03hX), update packets will be ignored", PChar->targid);
        return;
    }

    m_zoneEntities->InsertPC(PChar);

    if (!ZoneTimer && !m_zoneEntities->CharListEmpty())
    {
        createZoneTimers();
    }

    PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ON_ZONE_PATHOS, true);

    CharZoneIn(PChar);
}

/************************************************************************
 *                                                                       *
 *  Check the visibility of monsters by a character. It is better to     *
 *  keep the distance in global variable (server settings). It is in     *
 *  this function that the aggression of monsters is checked so that     *
 *  distance is not calculated several times (e.g. in ZoneServer)        *
 *                                                                       *
 ************************************************************************/

void CZone::SpawnMOBs(CCharEntity* PChar)
{
    m_zoneEntities->SpawnMOBs(PChar);
}

/************************************************************************
 *                                                                       *
 *  Check the visibility of pets by a character. For the adding of pets  *
 *  use UPDATE instead of SPAWN. SPAWN is only used when calling.        *
 *                                                                       *
 ************************************************************************/

void CZone::SpawnPETs(CCharEntity* PChar)
{
    m_zoneEntities->SpawnPETs(PChar);
}

void CZone::SpawnTRUSTs(CCharEntity* PChar)
{
    m_zoneEntities->SpawnTRUSTs(PChar);
}

/************************************************************************
 *                                                                       *
 *  Check the visibility of NPCs by a character.                         *
 *                                                                       *
 ************************************************************************/

void CZone::SpawnNPCs(CCharEntity* PChar)
{
    m_zoneEntities->SpawnNPCs(PChar);
}

/************************************************************************
 *                                                                       *
 *  Check the visibility of other characters by a character. The point   *
 *  of this action is that the characters update themselves and are      *
 *  added to the lists of other characters. Originally, the list size    *
 *  was limited to/changed to within 25-50 visible characters.           *
 *                                                                       *
 ************************************************************************/

void CZone::SpawnPCs(CCharEntity* PChar)
{
    m_zoneEntities->SpawnPCs(PChar);
}

/************************************************************************
 *                                                                       *
 *  Displaying Moogle in MogHouse                                        *
 *                                                                       *
 ************************************************************************/

void CZone::SpawnMoogle(CCharEntity* PChar)
{
    m_zoneEntities->SpawnMoogle(PChar);
}

/************************************************************************
 *                                                                       *
 *  Displaying ships/boats in the zone (not stored in the main list).    *
 *                                                                       *
 ************************************************************************/

void CZone::SpawnTransport(CCharEntity* PChar)
{
    m_zoneEntities->SpawnTransport(PChar);
}

CBaseEntity* CZone::GetEntity(uint16 targid, uint8 filter)
{
    return m_zoneEntities->GetEntity(targid, filter);
}

/************************************************************************
 *                                                                       *
 *  Process the world's adjustments to time of day changing              *
 *                                                                       *
 ************************************************************************/

void CZone::TOTDChange(TIMETYPE TOTD)
{
    TracyZoneScoped;
    m_zoneEntities->TOTDChange(TOTD);

    luautils::OnTOTDChange(m_zoneID, TOTD);
}

void CZone::SavePlayTime()
{
    m_zoneEntities->SavePlayTime();
}

CCharEntity* CZone::GetCharByName(std::string const& name)
{
    return m_zoneEntities->GetCharByName(name);
}

CCharEntity* CZone::GetCharByID(uint32 id)
{
    return m_zoneEntities->GetCharByID(id);
}

void CZone::PushPacket(CBaseEntity* PEntity, GLOBAL_MESSAGE_TYPE message_type, CBasicPacket* packet)
{
    TracyZoneScoped;
    m_zoneEntities->PushPacket(PEntity, message_type, packet);
}

void CZone::UpdateCharPacket(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask)
{
    TracyZoneScoped;
    m_zoneEntities->UpdateCharPacket(PChar, type, updatemask);
}

void CZone::UpdateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask, bool alwaysInclude)
{
    TracyZoneScoped;
    m_zoneEntities->UpdateEntityPacket(PEntity, type, updatemask, alwaysInclude);
}

void CZone::WideScan(CCharEntity* PChar, uint16 radius)
{
    TracyZoneScoped;
    m_zoneEntities->WideScan(PChar, radius);
}

/************************************************************************
 *                                                                       *
 *  Characters should be processed last when processing activity and     *
 *  status effects of entities in the zone.                              *
 *                                                                       *
 ************************************************************************/

void CZone::ZoneServer(time_point tick)
{
    TracyZoneScoped;
    m_zoneEntities->ZoneServer(tick);

    if (m_BattlefieldHandler != nullptr)
    {
        m_BattlefieldHandler->HandleBattlefields(tick);
    }

    if (ZoneTimer && m_zoneEntities->CharListEmpty() && m_timeZoneEmpty + 5s < server_clock::now())
    {
        ZoneTimer->m_type = CTaskMgr::TASK_REMOVE;
        ZoneTimer         = nullptr;

        ZoneTimerTriggerAreas->m_type = CTaskMgr::TASK_REMOVE;
        ZoneTimerTriggerAreas         = nullptr;

        m_zoneEntities->HealAllMobs();
    }
}

void CZone::ForEachChar(std::function<void(CCharEntity*)> const& func)
{
    TracyZoneScoped;
    for (auto PChar : m_zoneEntities->GetCharList())
    {
        func((CCharEntity*)PChar.second);
    }
}

void CZone::ForEachCharInstance(CBaseEntity* PEntity, std::function<void(CCharEntity*)> const& func)
{
    TracyZoneScoped;
    for (auto PChar : m_zoneEntities->GetCharList())
    {
        func((CCharEntity*)PChar.second);
    }
}

void CZone::ForEachMob(std::function<void(CMobEntity*)> const& func)
{
    TracyZoneScoped;
    for (auto PMob : m_zoneEntities->m_mobList)
    {
        func((CMobEntity*)PMob.second);
    }
}

void CZone::ForEachMobInstance(CBaseEntity* PEntity, std::function<void(CMobEntity*)> const& func)
{
    TracyZoneScoped;
    for (auto PMob : m_zoneEntities->m_mobList)
    {
        func((CMobEntity*)PMob.second);
    }
}

void CZone::ForEachTrust(std::function<void(CTrustEntity*)> const& func)
{
    TracyZoneScoped;
    for (auto PTrust : m_zoneEntities->m_trustList)
    {
        func((CTrustEntity*)PTrust.second);
    }
}

void CZone::ForEachTrustInstance(CBaseEntity* PEntity, std::function<void(CTrustEntity*)> const& func)
{
    TracyZoneScoped;
    for (auto PTrust : m_zoneEntities->m_trustList)
    {
        func((CTrustEntity*)PTrust.second);
    }
}

void CZone::ForEachNpc(std::function<void(CNpcEntity*)> const& func)
{
    TracyZoneScoped;
    for (auto PNpc : m_zoneEntities->m_npcList)
    {
        func((CNpcEntity*)PNpc.second);
    }
}

void CZone::createZoneTimers()
{
    TracyZoneScoped;
    ZoneTimer =
        CTaskMgr::getInstance()->AddTask(m_zoneName, server_clock::now(), this, CTaskMgr::TASK_INTERVAL, zone_server,
                                         std::chrono::milliseconds(static_cast<uint32>(server_tick_interval)));

    ZoneTimerTriggerAreas =
        CTaskMgr::getInstance()->AddTask(m_zoneName + "TriggerAreas", server_clock::now(), this, CTaskMgr::TASK_INTERVAL, zone_trigger_area,
                                         std::chrono::milliseconds(static_cast<uint32>(server_trigger_area_interval)));
}

void CZone::CharZoneIn(CCharEntity* PChar)
{
    TracyZoneScoped;

    PChar->loc.zone              = this;
    PChar->loc.zoning            = false;
    PChar->loc.destination       = 0;
    PChar->m_InsideTriggerAreaID = 0;

    if (PChar->isMounted() && !CanUseMisc(MISC_MOUNT))
    {
        PChar->animation = ANIMATION_NONE;
        PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_MOUNTED);
    }

    if (PChar->m_Costume != 0)
    {
        PChar->m_Costume = 0;
        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_COSTUME);
    }

    PChar->ReloadPartyInc();

    if (PChar->PParty != nullptr)
    {
        if (m_TreasurePool != nullptr)
        {
            PChar->PTreasurePool = m_TreasurePool;
            PChar->PTreasurePool->AddMember(PChar);
        }
        else
        {
            PChar->PParty->ReloadTreasurePool(PChar);
        }
    }
    else
    {
        PChar->PTreasurePool = new CTreasurePool(TREASUREPOOL_SOLO);
        PChar->PTreasurePool->AddMember(PChar);
    }

    if (!(m_zoneType & ZONE_TYPE::INSTANCED))
    {
        charutils::ClearTempItems(PChar);
        PChar->PInstance = nullptr;
    }

    if (m_BattlefieldHandler)
    {
        auto* PBattlefield = m_BattlefieldHandler->GetBattlefield(PChar, true);
        if (PBattlefield != nullptr && PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_CONFRONTATION))
        {
            PBattlefield->InsertEntity(PChar, CBattlefield::hasPlayerEntered(PChar));
        }
        else if (PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_CONFRONTATION))
        {
            // Player is in a zone with a battlefield but they are not part of one.
            if (CBattlefield::hasPlayerEntered(PChar))
            {
                // If inside of the battlefield arena then kick them out
                // Battlefield and level restriction effects will be removed once fully kicked.
                m_BattlefieldHandler->addOrphanedPlayer(PChar);
            }
            else
            {
                // Is not inside of a battlefield arena so remove the battlefield effect
                PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, true);
                updateCharLevelRestriction(PChar);
                if (PChar->PPet)
                {
                    PChar->PPet->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, true);
                }
            }
        }
    }
    else if (PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_CONFRONTATION))
    {
        // Player is zoning into a zone that does not have a battlefield but the player has a confrontation effect - remove it
        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, true);
        if (PChar->PPet)
        {
            PChar->PPet->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, true);
        }
    }

    monstrosity::HandleZoneIn(PChar);

    PChar->PLatentEffectContainer->CheckLatentsZone();

    charutils::ReadHistory(PChar);

    moduleutils::OnCharZoneIn(PChar);
}

void CZone::CharZoneOut(CCharEntity* PChar)
{
    TracyZoneScoped;
    for (triggerAreaList_t::const_iterator triggerAreaItr = m_triggerAreaList.begin(); triggerAreaItr != m_triggerAreaList.end(); ++triggerAreaItr)
    {
        if ((*triggerAreaItr)->GetTriggerAreaID() == PChar->m_InsideTriggerAreaID)
        {
            luautils::OnTriggerAreaLeave(PChar, *triggerAreaItr);
            break;
        }
    }

    moduleutils::OnCharZoneOut(PChar);
    luautils::OnZoneOut(PChar);

    if (PChar->m_LevelRestriction != 0)
    {
        if (PChar->PParty)
        {
            if (PChar->PParty->GetSyncTarget() == PChar || PChar->PParty->GetLeader() == PChar)
            {
                PChar->PParty->SetSyncTarget("", 551);
            }
            if (PChar->PParty->GetSyncTarget() != nullptr)
            {
                uint8 count = 0;
                for (uint32 i = 0; i < PChar->PParty->members.size(); ++i)
                {
                    if (PChar->PParty->members.at(i) != PChar && PChar->PParty->members.at(i)->getZone() == PChar->PParty->GetSyncTarget()->getZone())
                    {
                        count++;
                    }
                }
                if (count < 2) // 3, because one is zoning out - thus at least 2 will be left
                {
                    PChar->PParty->SetSyncTarget("", 552);
                }
            }
        }
        PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEVEL_SYNC);
        PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEVEL_RESTRICTION);
    }

    if (PChar->PLinkshell1 != nullptr)
    {
        PChar->PLinkshell1->DelMember(PChar);
    }

    if (PChar->PLinkshell2 != nullptr)
    {
        PChar->PLinkshell2->DelMember(PChar);
    }

    if (PChar->PUnityChat != nullptr)
    {
        PChar->PUnityChat->DelMember(PChar);
    }

    if (PChar->PTreasurePool != nullptr) // TODO: Condition for eliminating problems with MobHouse, we need to solve it once and for all!
    {
        PChar->PTreasurePool->DelMember(PChar);
    }

    PChar->ClearTrusts(); // trusts don't survive zone lines

    if (PChar->isDead())
    {
        charutils::SaveDeathTime(PChar);
    }

    PChar->loc.zone = nullptr;

    if (PChar->status == STATUS_TYPE::SHUTDOWN)
    {
        PChar->loc.destination = m_zoneID;
    }
    else
    {
        PChar->loc.prevzone = m_zoneID;
    }

    PChar->SpawnPCList.clear();
    PChar->SpawnNPCList.clear();
    PChar->SpawnMOBList.clear();
    PChar->SpawnPETList.clear();
    PChar->SpawnTRUSTList.clear();

    if (PChar->PParty && PChar->loc.destination != 0 && PChar->m_moghouseID == 0)
    {
        uint8 data[4]{};

        if (PChar->PParty->m_PAlliance)
        {
            ref<uint32>(data, 0) = PChar->PParty->m_PAlliance->m_AllianceID;
            message::send(MSG_ALLIANCE_RELOAD, data, sizeof data, nullptr);
        }
        else
        {
            ref<uint32>(data, 0) = PChar->PParty->GetPartyID();
            message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);
        }
    }

    if (PChar->PParty)
    {
        PChar->PParty->PopMember(PChar);
    }

    if (PChar->PAutomaton)
    {
        PChar->PAutomaton->PMaster = nullptr;
    }

    charutils::WriteHistory(PChar);
}

bool CZone::IsZoneActive() const
{
    return ZoneTimer != nullptr;
}

CZoneEntities* CZone::GetZoneEntities()
{
    TracyZoneScoped;
    return m_zoneEntities;
}

void CZone::CheckTriggerAreas()
{
    TracyZoneScoped;

    for (auto const& [targid, PEntity] : m_zoneEntities->m_charList)
    {
        auto* PChar = static_cast<CCharEntity*>(PEntity);

        // TODO: When we start to use octrees or spatial hashing to split up zones,
        //     : use them here to make the search domain smaller.

        uint32 triggerAreaID = 0;
        for (triggerAreaList_t::const_iterator triggerAreaItr = m_triggerAreaList.begin(); triggerAreaItr != m_triggerAreaList.end(); ++triggerAreaItr)
        {
            if ((*triggerAreaItr)->isPointInside(PChar->loc.p))
            {
                triggerAreaID = (*triggerAreaItr)->GetTriggerAreaID();

                if ((*triggerAreaItr)->GetTriggerAreaID() != PChar->m_InsideTriggerAreaID)
                {
                    luautils::OnTriggerAreaEnter(PChar, *triggerAreaItr);
                }

                if (PChar->m_InsideTriggerAreaID == 0)
                {
                    break;
                }
            }
            else if ((*triggerAreaItr)->GetTriggerAreaID() == PChar->m_InsideTriggerAreaID)
            {
                luautils::OnTriggerAreaLeave(PChar, *triggerAreaItr);
            }
        }
        PChar->m_InsideTriggerAreaID = triggerAreaID;
    }
}
