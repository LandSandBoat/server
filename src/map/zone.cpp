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

#include "packets/s2c/0x057_weather.h"
namespace
{

constexpr std::uint16_t WeatherCycle = 2160;

}

// TODO:
// It is necessary to divide the CZone class into basic and heirs. Already painted: Standard, Resident, Instance and Dynamis
// Each of these zones has special behavior

#include "zone.h"

#include "common/logging.h"
#include "common/settings.h"
#include "common/timer.h"
#include "common/utils.h"
#include "common/vana_time.h"

#include <cstring>

#include "battlefield.h"
#include "enums/loot_recast.h"
#include "ipc_client.h"
#include "latent_effect_container.h"
#include "los/zone_los.h"
#include "map_engine.h"
#include "monstrosity.h"
#include "navmesh.h"
#include "party.h"
#include "recast_container.h"
#include "status_effect_container.h"
#include "treasure_pool.h"
#include "zone_entities.h"

#include "entities/npcentity.h"
#include "entities/petentity.h"

#include "lua/luautils.h"

#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "utils/moduleutils.h"

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
    m_Weather            = Weather::None;
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
    TracyZoneScoped;

    destroy(m_TreasurePool);
    destroy(m_zoneEntities);
    destroy(m_BattlefieldHandler);

    if (m_CampaignHandler)
    {
        destroy(m_CampaignHandler);
    }

    m_triggerAreaList.clear();

    for (auto zoneLine : m_zoneLineList)
    {
        destroy(zoneLine);
    }
    m_zoneLineList.clear();
}

auto CZone::GetID() const -> ZONEID
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

auto CZone::GetWeather() const -> Weather
{
    return m_Weather;
}

auto CZone::GetWeatherChangeTime() const -> uint32
{
    return m_WeatherChangeTime;
}

const std::string& CZone::getName()
{
    return m_zoneName;
}

uint16 CZone::GetSoloBattleMusic() const
{
    return m_zoneMusic.m_bSongS;
}

uint16 CZone::GetPartyBattleMusic() const
{
    return m_zoneMusic.m_bSongM;
}

uint16 CZone::GetBackgroundMusicDay() const
{
    return m_zoneMusic.m_songDay;
}

uint16 CZone::GetBackgroundMusicNight() const
{
    return m_zoneMusic.m_songNight;
}

void CZone::SetSoloBattleMusic(uint16 music)
{
    m_zoneMusic.m_bSongS = music;
}

void CZone::SetPartyBattleMusic(uint16 music)
{
    m_zoneMusic.m_bSongM = music;
}

void CZone::SetBackgroundMusicDay(uint16 music)
{
    m_zoneMusic.m_songDay = music;
}

void CZone::SetBackgroundMusicNight(uint16 music)
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
const QueryByNameResult_t& CZone::queryEntitiesByName(const std::string& pattern)
{
    TracyZoneScoped;

    // Always ignore cache for queries explicitly looking for dynamic entities
    // TODO: make this memoization work for dynamic entities somehow?
    if (pattern.rfind("DE_", 0) != 0)
    {
        // Use memoization since lookups are typically for the same mob names
        auto result = m_queryByNameResults.find(pattern);
        if (result != m_queryByNameResults.end())
        {
            return result->second;
        }
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
    for (const auto& zoneLine : m_zoneLineList)
    {
        if (zoneLine->m_zoneLineID == zoneLineID)
        {
            return zoneLine;
        }
    }
    return nullptr;
}

void CZone::LoadZoneLines()
{
    TracyZoneScoped;

    const auto rset = db::preparedStmt("SELECT zoneline, tozone, tox, toy, toz, rotation "
                                       "FROM zonelines "
                                       "WHERE fromzone = ?",
                                       m_zoneID);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        auto* zl = new zoneLine_t;

        zl->m_zoneLineID     = rset->get<uint32>("zoneline");
        zl->m_toZone         = rset->get<uint16>("tozone");
        zl->m_toPos.x        = rset->get<float>("tox");
        zl->m_toPos.y        = rset->get<float>("toy");
        zl->m_toPos.z        = rset->get<float>("toz");
        zl->m_toPos.rotation = rset->get<uint8>("rotation");

        m_zoneLineList.emplace_back(zl);
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

    const auto rset = db::preparedStmt("SELECT weather "
                                       "FROM zone_weather "
                                       "WHERE zone = ? LIMIT 1",
                                       m_zoneID);
    FOR_DB_SINGLE_RESULT(rset)
    {
        uint16_t weatherBlob[WeatherCycle]{};

        db::extractFromBlob(rset, "weather", weatherBlob);
        for (uint16 i = 0; i < WeatherCycle; i++)
        {
            if (weatherBlob[i])
            {
                const auto w_normal = static_cast<uint8>(weatherBlob[i] >> 10);
                const auto w_common = static_cast<uint8>((weatherBlob[i] >> 5) & 0x1F);
                const auto w_rare   = static_cast<uint8>(weatherBlob[i] & 0x1F);
                m_WeatherVector.insert(std::make_pair(i, zoneWeather_t(w_normal, w_common, w_rare)));
            }
        }
    }
}

void CZone::LoadZoneSettings()
{
    TracyZoneScoped;

    const auto rset = db::preparedStmt("SELECT "
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
                                       "bcnm.name AS bcnmname "
                                       "FROM zone_settings AS zone "
                                       "LEFT JOIN bcnm_records AS bcnm "
                                       "USING (zoneid) "
                                       "WHERE zoneid = ? "
                                       "LIMIT 1",
                                       m_zoneID);
    FOR_DB_SINGLE_RESULT(rset)
    {
        m_zoneName.insert(0, rset->get<std::string>("name"));
        m_zoneIP   = str2ip(rset->get<std::string>("zoneip"));
        m_zonePort = rset->get<uint16>("zoneport");

        m_zoneMusic.m_songDay   = rset->get<uint8>("music_day");
        m_zoneMusic.m_songNight = rset->get<uint8>("music_night");
        m_zoneMusic.m_bSongS    = rset->get<uint8>("battlesolo");
        m_zoneMusic.m_bSongM    = rset->get<uint8>("battlemulti");
        m_tax                   = static_cast<uint16>(rset->get<float>("tax") * 100); // tax for bazaar
        m_miscMask              = rset->get<uint16>("misc");
        m_zoneType              = rset->get<ZONE_TYPE>("zonetype");

        if (rset->getOrDefault<std::string>("bcnmname", "") != "") // bcnmid cannot be used now, because they start from scratch
        {
            m_BattlefieldHandler = new CBattlefieldHandler(this);
        }

        if (m_miscMask & MISC_TREASURE)
        {
            m_TreasurePool = new CTreasurePool(TreasurePoolType::Zone);
        }

        if (m_CampaignHandler && m_CampaignHandler->m_PZone == nullptr)
        {
            destroy(m_CampaignHandler);
        }
    }
}

void CZone::LoadNavMesh()
{
    TracyZoneScoped;

    if (m_navMesh == nullptr)
    {
        m_navMesh = std::make_unique<CNavMesh>(static_cast<uint16>(GetID()));
    }

    char file[255];
    std::memset(file, 0, sizeof(file));
    snprintf(file, sizeof(file), "navmeshes/%s.nav", getName().c_str());

    if (!m_navMesh->load(file))
    {
        DebugNavmesh("CZone::LoadNavMesh: Cannot load navmesh file (%s)", file);
        m_navMesh = nullptr;
    }
}

void CZone::LoadZoneLos()
{
    TracyZoneScoped;

    if (GetTypeMask() & ZONE_TYPE::CITY || (m_miscMask & MISC_LOS_OFF))
    {
        // Skip cities and zones with line of sight turned off
        return;
    }

    if (lineOfSight)
    {
        // Clean up previous object if one exists.
        lineOfSight = nullptr;
    }

    lineOfSight = ZoneLos::Load((uint16)GetID(), fmt::sprintf("losmeshes/%s.obj", getName()));
}

void CZone::InsertMOB(CBaseEntity* PMob)
{
    m_zoneEntities->InsertMOB(PMob);
}

void CZone::InsertNPC(CBaseEntity* PNpc)
{
    m_zoneEntities->InsertNPC(PNpc);
}

void CZone::InsertPET(CBaseEntity* PPet)
{
    m_zoneEntities->InsertPET(PPet);
}

void CZone::InsertTRUST(CBaseEntity* PTrust)
{
    m_zoneEntities->InsertTRUST(PTrust);
}

void CZone::InsertTriggerArea(std::unique_ptr<ITriggerArea>&& triggerArea)
{
    if (triggerArea != nullptr)
    {
        m_triggerAreaList.emplace_back(std::move(triggerArea));
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

void CZone::TransportDepart(uint16 boundary, uint16 prevZoneId, uint16 transportId)
{
    m_zoneEntities->TransportDepart(boundary, prevZoneId, transportId);
}

void CZone::updateCharLevelRestriction(CCharEntity* PChar)
{
    TracyZoneScoped;

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
        // remove buffs in level cap zones as well (such as riverne sites)
        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE, EffectNotice::Silent);
        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ERASABLE, EffectNotice::Silent);
        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ATTACK, EffectNotice::Silent);
        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ON_ZONE, EffectNotice::Silent);
        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_SONG, EffectNotice::Silent);
        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ROLL, EffectNotice::Silent);
        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_SYNTH_SUPPORT, EffectNotice::Silent);
        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_BLOODPACT, EffectNotice::Silent);
        PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_LEVEL_RESTRICTION, EFFECT_LEVEL_RESTRICTION, m_levelRestriction, 0s, 0s));
    }
}

void CZone::SetWeather(const Weather weather)
{
    TracyZoneScoped;

    if (!magic_enum::enum_contains<Weather>(weather))
    {
        ShowWarningFmt("Weather value ({}) invalid.", static_cast<uint16_t>(weather));
        return;
    }

    if (m_Weather == weather)
    {
        return;
    }

    m_zoneEntities->WeatherChange(weather);

    m_Weather           = weather;
    m_WeatherChangeTime = earth_time::vanadiel_timestamp();

    m_zoneEntities->PushPacket(nullptr, CHAR_INZONE, std::make_unique<GP_SERV_COMMAND_WEATHER>(m_WeatherChangeTime, m_Weather, xirand::GetRandomNumber(4, 28)));
}

void CZone::UpdateWeather()
{
    TracyZoneScoped;

    vanadiel_time::time_point CurrentVanaDate   = vanadiel_time::now(); // Current Vanadiel time
    vanadiel_time::time_point nextVanaMidnight  = vanadiel_time::get_next_midnight(CurrentVanaDate);
    vanadiel_time::time_point StartFogVanaDate  = nextVanaMidnight - xi::vanadiel_clock::days(1) + xi::vanadiel_clock::hours(2); // Vanadiel timestamp of 2 AM in minutes
    vanadiel_time::time_point EndFogVanaDate    = StartFogVanaDate + xi::vanadiel_clock::hours(5);                               // Vanadiel timestamp of 7 AM in minutes
    vanadiel_time::duration   WeatherNextUpdate = 0s;
    uint32                    WeatherDay        = 0;
    uint8                     WeatherChance     = 0;

    // Random time between 3 minutes and 30 minutes for the next weather change
    WeatherNextUpdate = std::chrono::seconds(xirand::GetRandomNumber(180, 1801));

    // Calculate what day we are on since the start of vanadiel time
    WeatherDay = vanadiel_time::count_days(CurrentVanaDate.time_since_epoch());

    // The weather starts over again every 2160 days
    WeatherDay = WeatherDay % WeatherCycle;

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

    auto selectedWeather = Weather::None;

    // 15% chance for rare weather, 35% chance for common weather, 50% chance for normal weather
    // * Percentages were generated from a 6 hour sample and rounded down to closest multiple of 5*
    if (WeatherChance < 15) // 15% chance to have the weather_rare
    {
        selectedWeather = static_cast<Weather>(weatherType.rare);
    }
    else if (WeatherChance < 50) // 35% chance to have weather_common
    {
        selectedWeather = static_cast<Weather>(weatherType.common);
    }
    else
    {
        selectedWeather = static_cast<Weather>(weatherType.normal);
    }

    // This check is incorrect, fog is not simply a time of day, though it may consistently happen in SOME zones
    // (Al'Taieu likely has it every morning, while Atohwa Chasm can have it at random any time of day)
    if ((CurrentVanaDate >= StartFogVanaDate) &&
        (CurrentVanaDate < EndFogVanaDate) &&
        (selectedWeather < Weather::HotSpell) &&
        !(GetTypeMask() & ZONE_TYPE::CITY))
    {
        selectedWeather = Weather::Fog;
        // Force the weather to change by 7 am
        WeatherNextUpdate = EndFogVanaDate - CurrentVanaDate;
    }

    SetWeather(selectedWeather);
    luautils::OnZoneWeatherChange(GetID(), selectedWeather);

    // clang-format off
    timer::time_point nextWeatherTick = timer::now() + std::chrono::duration_cast<earth_time::duration>(WeatherNextUpdate);
    CTaskManager::getInstance()->AddTask("zone_update_weather", nextWeatherTick, this, CTaskManager::TASK_ONCE, 1s,
    [](timer::time_point tick, CTaskManager::CTask* PTask)
    {
        CZone* PZone = std::any_cast<CZone*>(PTask->m_data);
        if (!PZone->IsWeatherStatic())
        {
            PZone->UpdateWeather();
        }
        return 0;
    });
    // clang-format on
}

bool CZone::CheckMobsPathedBack()
{
    bool allMobsHomeAndHealed = true;
    if (m_zoneEntities && m_zoneEntities->GetMobList().size() > 0)
    {
        EntityList_t mobListMap = m_zoneEntities->GetMobList();
        for (const auto& pair : mobListMap)
        {
            CMobEntity* mob = dynamic_cast<CMobEntity*>(pair.second);
            // if the mob is (not dead/despawned AND it is not fully healed) OR it is pathing home
            if (mob && ((!mob->isDead() && !mob->isFullyHealed()) || mob->m_IsPathingHome))
            {
                // at least one mob is away from home or not fully healed
                allMobsHomeAndHealed = false;
                break;
            }
        }
    }

    return allMobsHomeAndHealed;
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
        m_timeZoneEmpty = timer::now();
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

    PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ON_ZONE_PATHOS, EffectNotice::Silent);

    CharZoneIn(PChar);
}

void CZone::SpawnMOBs(CCharEntity* PChar)
{
    m_zoneEntities->SpawnMOBs(PChar);
}

void CZone::SpawnPETs(CCharEntity* PChar)
{
    m_zoneEntities->SpawnPETs(PChar);
}

void CZone::SpawnTRUSTs(CCharEntity* PChar)
{
    m_zoneEntities->SpawnTRUSTs(PChar);
}

void CZone::SpawnNPCs(CCharEntity* PChar)
{
    m_zoneEntities->SpawnNPCs(PChar);
}

void CZone::SpawnPCs(CCharEntity* PChar)
{
    m_zoneEntities->SpawnPCs(PChar);
}

void CZone::SpawnConditionalNPCs(CCharEntity* PChar)
{
    m_zoneEntities->SpawnConditionalNPCs(PChar);
}

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

void CZone::TOTDChange(vanadiel_time::TOTD TOTD)
{
    TracyZoneScoped;

    m_zoneEntities->TOTDChange(TOTD);

    luautils::OnTOTDChange(m_zoneID, TOTD);
}

void CZone::SavePlayTime()
{
    TracyZoneScoped;

    m_zoneEntities->SavePlayTime();
}

CCharEntity* CZone::GetCharByName(const std::string& name)
{
    return m_zoneEntities->GetCharByName(name);
}

CCharEntity* CZone::GetCharByID(uint32 id)
{
    return m_zoneEntities->GetCharByID(id);
}

void CZone::PushPacket(CBaseEntity* PEntity, GLOBAL_MESSAGE_TYPE message_type, const std::unique_ptr<CBasicPacket>& packet)
{
    TracyZoneScoped;

    m_zoneEntities->PushPacket(PEntity, message_type, packet);
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

void CZone::ZoneServer(timer::time_point tick)
{
    TracyZoneScoped;

    m_zoneEntities->ZoneServer(tick);

    if (m_BattlefieldHandler != nullptr)
    {
        m_BattlefieldHandler->HandleBattlefields(tick);
    }

    if (ZoneTimer && m_zoneEntities->CharListEmpty() && m_timeZoneEmpty + 5s < timer::now() && CheckMobsPathedBack())
    {
        ZoneTimer->m_type = CTaskManager::TASK_REMOVE;
        ZoneTimer         = nullptr;

        ZoneTimerTriggerAreas->m_type = CTaskManager::TASK_REMOVE;
        ZoneTimerTriggerAreas         = nullptr;
    }
}

void CZone::ForEachChar(const std::function<void(CCharEntity*)>& func)
{
    TracyZoneScoped;

    m_zoneEntities->ForEachChar(func);
}

void CZone::ForEachCharInstance(CBaseEntity* PEntity, const std::function<void(CCharEntity*)>& func)
{
    TracyZoneScoped;

    ForEachChar(func);
}

void CZone::ForEachMob(const std::function<void(CMobEntity*)>& func)
{
    TracyZoneScoped;

    m_zoneEntities->ForEachMob(func);
}

void CZone::ForEachMobInstance(CBaseEntity* PEntity, const std::function<void(CMobEntity*)>& func)
{
    TracyZoneScoped;

    ForEachMob(func);
}

void CZone::ForEachNpc(const std::function<void(CNpcEntity*)>& func)
{
    TracyZoneScoped;

    m_zoneEntities->ForEachNpc(func);
}

void CZone::ForEachNpcInstance(CBaseEntity* PEntity, const std::function<void(CNpcEntity*)>& func)
{
    TracyZoneScoped;

    ForEachNpc(func);
}

void CZone::ForEachTrust(const std::function<void(CTrustEntity*)>& func)
{
    TracyZoneScoped;

    m_zoneEntities->ForEachTrust(func);
}

void CZone::ForEachTrustInstance(CBaseEntity* PEntity, const std::function<void(CTrustEntity*)>& func)
{
    TracyZoneScoped;

    ForEachTrust(func);
}

void CZone::ForEachPet(const std::function<void(CPetEntity*)>& func)
{
    TracyZoneScoped;

    m_zoneEntities->ForEachPet(func);
}

void CZone::ForEachPetInstance(CBaseEntity* PEntity, const std::function<void(CPetEntity*)>& func)
{
    TracyZoneScoped;

    ForEachPet(func);
}

void CZone::ForEachAlly(const std::function<void(CMobEntity*)>& func)
{
    TracyZoneScoped;

    m_zoneEntities->ForEachAlly(func);
}

void CZone::ForEachAllyInstance(CBaseEntity* PEntity, const std::function<void(CMobEntity*)>& func)
{
    TracyZoneScoped;

    ForEachAlly(func);
}

void CZone::createZoneTimers()
{
    TracyZoneScoped;

    // clang-format off
    ZoneTimer = CTaskManager::getInstance()->AddTask(m_zoneName, timer::now(), this, CTaskManager::TASK_INTERVAL, kLogicUpdateInterval,
    [](timer::time_point tick, CTaskManager::CTask* PTask)
    {
        CZone* PZone = std::any_cast<CZone*>(PTask->m_data);
        PZone->ZoneServer(tick);
        return 0;
    });

    ZoneTimerTriggerAreas = CTaskManager::getInstance()->AddTask(m_zoneName + "TriggerAreas", timer::now(), this, CTaskManager::TASK_INTERVAL, kTriggerAreaInterval,
    [](timer::time_point tick, CTaskManager::CTask* PTask)
    {
        CZone* PZone = std::any_cast<CZone*>(PTask->m_data);
        PZone->CheckTriggerAreas();
        return 0;
    });
    // clang-format on
}

void CZone::CharZoneIn(CCharEntity* PChar)
{
    TracyZoneScoped;

    PChar->loc.zone        = this;
    PChar->loc.zoning      = false;
    PChar->loc.destination = 0;
    PChar->clearTriggerAreas();

    if (PChar->isMounted() && !CanUseMisc(MISC_MOUNT))
    {
        PChar->animation = ANIMATION_NONE;
        PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_MOUNTED);
    }

    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_COSTUME))
    {
        PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_COSTUME);
    }

    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_ILLUSION))
    {
        PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_ILLUSION);
    }

    PChar->ReloadPartyInc();

    // Zone-wide treasure pool takes precendence over all others
    if (m_TreasurePool && m_TreasurePool->getPoolType() == TreasurePoolType::Zone)
    {
        PChar->PTreasurePool = m_TreasurePool;
        PChar->PTreasurePool->addMember(PChar);
    }
    else
    {
        if (PChar->PParty)
        {
            PChar->PParty->ReloadTreasurePool(PChar);
        }
        else
        {
            PChar->PTreasurePool = new CTreasurePool(TreasurePoolType::Solo);
            PChar->PTreasurePool->addMember(PChar);
        }
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
                PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, EffectNotice::Silent);
                updateCharLevelRestriction(PChar);
                if (PChar->PPet)
                {
                    PChar->PPet->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, EffectNotice::Silent);
                }
            }
        }
    }
    else if (PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_CONFRONTATION))
    {
        // Player is zoning into a zone that does not have a battlefield but the player has a confrontation effect - remove it
        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, EffectNotice::Silent);
        if (PChar->PPet)
        {
            PChar->PPet->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, EffectNotice::Silent);
        }
    }
    else if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
    {
        // Logging in with no party and a level sync status = bad.
        if (!PChar->PParty)
        {
            PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEVEL_SYNC);
            PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEVEL_RESTRICTION);
        }
    }

    // Mark current zone as visited
    PChar->m_ZonesVisitedList[PChar->getZone() >> 3] |= (1 << (PChar->getZone() % 8));

    monstrosity::HandleZoneIn(PChar);

    PChar->PLatentEffectContainer->CheckLatentsZone();

    charutils::ReadHistory(PChar);

    // Restore seal recast timer if enabled
    if (settings::get<bool>("main.PERSIST_SEAL_TIMERS"))
    {
        auto expirationTimestamp = static_cast<uint32>(PChar->getCharVar("SealTimerExpiry"));
        if (expirationTimestamp > 0)
        {
            auto currentTimestamp = earth_time::timestamp();
            if (expirationTimestamp > currentTimestamp)
            {
                auto remainingSeconds = expirationTimestamp - currentTimestamp;
                // Sanity check: seal timer should never exceed 5 minutes (300 seconds)
                if (remainingSeconds <= 300)
                {
                    PChar->PRecastContainer->AddLootRecast(LootRecastID::Seal, std::chrono::seconds(remainingSeconds));
                }
            }

            // Ensure var is wiped after zone in
            PChar->setCharVar("SealTimerExpiry", 0);
        }
    }

    moduleutils::OnCharZoneIn(PChar);
}

void CZone::CharZoneOut(CCharEntity* PChar)
{
    TracyZoneScoped;

    for (const auto& triggerArea : m_triggerAreaList)
    {
        if (PChar->isInTriggerArea(triggerArea->getTriggerAreaID()))
        {
            luautils::OnTriggerAreaLeave(PChar, triggerArea);
            break;
        }
    }

    // Save seal recast timer if enabled
    if (settings::get<bool>("main.PERSIST_SEAL_TIMERS"))
    {
        auto* recast = PChar->PRecastContainer->GetLootRecast(LootRecastID::Seal);
        if (recast && recast->RecastTime > 0s)
        {
            auto remaining = (recast->TimeStamp + recast->RecastTime) - timer::now();
            // Don't save if it will expire during zoning process
            if (remaining > 10s)
            {
                auto remainingSeconds    = std::chrono::duration_cast<std::chrono::seconds>(remaining).count();
                auto expirationTimestamp = earth_time::timestamp() + static_cast<uint32>(remainingSeconds);
                PChar->setCharVar("SealTimerExpiry", static_cast<int32>(expirationTimestamp));
            }
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
                PChar->PParty->SetSyncTarget("", MsgStd::LevelSyncDeactivateLeftArea);
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
                    PChar->PParty->SetSyncTarget("", MsgStd::LevelSyncRemoveTooFewMembers);
                }
            }
        }
        PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEVEL_SYNC);
        PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEVEL_RESTRICTION);
    }

    if (PChar->PTreasurePool != nullptr) // TODO: Condition for eliminating problems with MobHouse, we need to solve it once and for all!
    {
        PChar->PTreasurePool->delMember(PChar);
    }

    // If zone-wide treasure pool but no players in zone then destroy current pool and create new pool
    // this prevents loot from staying in zone pool after the last player leaves the zone
    if (m_TreasurePool && m_TreasurePool->getPoolType() == TreasurePoolType::Zone && m_zoneEntities->CharListEmpty())
    {
        destroy(m_TreasurePool);
        m_TreasurePool = new CTreasurePool(TreasurePoolType::Zone);
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

    charutils::WriteHistory(PChar);
}

bool CZone::IsZoneActive() const
{
    return ZoneTimer != nullptr;
}

CZoneEntities* CZone::GetZoneEntities()
{
    return m_zoneEntities;
}

void CZone::CheckTriggerAreas()
{
    TracyZoneScoped;

    // clang-format off
    ForEachChar([&](CCharEntity* PChar)
    {
        // TODO: When we start to use octrees or spatial hashing to split up zones,
        //     : use them here to make the search domain smaller.

        // Do not enter trigger areas while loading in. Set in xi.player.onGameIn
        if (PChar->GetLocalVar("ZoningIn") > 0)
        {
            return;
        }

        for (const auto& triggerArea : m_triggerAreaList)
        {
            const auto triggerAreaID = triggerArea->getTriggerAreaID();
            if (triggerArea->isPointInside(PChar->loc.p))
            {
                if (!PChar->isInTriggerArea(triggerAreaID))
                {
                    // Add the TriggerArea to the players cache of current TriggerAreas
                    PChar->onTriggerAreaEnter(triggerAreaID);
                    luautils::OnTriggerAreaEnter(PChar, triggerArea);
                }
            }
            else if (PChar->isInTriggerArea(triggerAreaID))
            {
                // Remove the TriggerArea from the players cache of current TriggerAreas
                PChar->onTriggerAreaLeave(triggerAreaID);
                luautils::OnTriggerAreaLeave(PChar, triggerArea);
            }
        }
    });
    // clang-format on
}
