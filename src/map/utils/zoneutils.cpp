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

#include "zoneutils.h"

#include "ai/ai_container.h"
#include "aman.h"
#include "battlefield.h"
#include "campaign_system.h"
#include "common/logging.h"
#include "common/synchronized.h"
#include "conquest_system.h"
#include "data/datasets/zones/mobs/dataset.h"
#include "data/datasets/zones/npcs/dataset.h"
#include "data/datasets/zones/regions/dataset.h"
#include "data/datasets/zones/settings/dataset.h"
#include "data/enums/mob_mod.h"
#include "data/enums/weather.h"
#include "data/loader.h"
#include "entities/mob_entity.h"
#include "entities/npc_entity.h"
#include "items/item_weapon.h"
#include "itemutils.h"
#include "lua/luautils.h"
#include "map_networking.h"
#include "mob_spell_list.h"
#include "mobutils.h"
#include "roam_region.h"
#include "spawn_handler.h"
#include "spawn_slot.h"
#include "zone_instance.h"

#include <algorithm>
#include <execution>
#include <future>
#include <ranges>

#include <fmt/ranges.h>

std::map<xi::ZoneId, CZone*> g_PZoneList; // Global array of pointers for zones

namespace
{

constexpr uint16 kDefaultMobDelay            = 240;
constexpr uint16 kDefaultMobDamageMultiplier = 100;

using ZoneSettingsDataset = xi::data::datasets::zones::settings::Dataset;
using NpcsDataset         = xi::data::datasets::zones::npcs::Dataset;
using MobsDataset         = xi::data::datasets::zones::mobs::Dataset;
using RegionsDataset      = xi::data::datasets::zones::regions::Dataset;

// Each zone's entity files, parsed once: the id lookups and the entity inserts both read these.
struct ZoneEntityFiles
{
    std::optional<xi::data::Npcs> Npcs;
    std::optional<xi::data::Mobs> Mobs;
};

// Loot is named in the files, so it resolves here, where the item table exists.
auto buildDropList(const xi::ZoneId zoneId, const std::string& templateName, const xi::data::LootData& loot) -> const DropList_t*
{
    // Zones build these on worker threads, and every mob holds a pointer, so a deque keeps the earlier entries put.
    static Synchronized<std::deque<DropList_t>> ownedDropLists;

    const auto resolve = [&](const std::string& name) -> uint16
    {
        if (name == "nothing")
        {
            return 0;
        }

        const auto itemId = xi::items::lookupIdByName(name);
        if (!itemId)
        {
            ShowCriticalFmt("buildDropList: template '{}' in zone {} names unknown or ambiguous item '{}'", templateName, static_cast<uint32>(zoneId), name);
            std::exit(-1);
        }

        return *itemId;
    };

    DropList_t dropList;

    for (const auto& roll : loot.Drops)
    {
        if (roll.OneOf.empty())
        {
            dropList.Items.emplace_back(DROP_NORMAL, resolve(roll.Item), roll.Chance);
            continue;
        }

        auto& group = dropList.Groups.emplace_back(roll.Chance);
        for (const auto& [name, weight] : roll.OneOf)
        {
            group.Items.emplace_back(DROP_GROUPED, resolve(name), weight);
        }
    }

    for (const auto& name : loot.Steal)
    {
        dropList.Items.emplace_back(DROP_STEAL, resolve(name), 0);
    }

    // Despoil keeps its weights, though the engine picks uniformly.
    for (const auto& [name, weight] : loot.Despoil)
    {
        dropList.Items.emplace_back(DROP_DESPOIL, resolve(name), weight);
    }

    return ownedDropLists.write([&](auto& lists) -> const DropList_t*
                                {
                                    return &lists.emplace_back(std::move(dropList));
                                });
}

void InsertNPCs(CZone* PZone, const xi::ZoneId zoneId, const xi::data::Npcs& npcs)
{
    if ((PZone->GetTypeMask() & xi::ZoneType::Instanced) != xi::ZoneType::Unknown)
    {
        return;
    }

    for (const auto& entry : npcs)
    {
        auto* PNpc   = new CNpcEntity;
        PNpc->targid = entry.ActIndex;
        PNpc->id     = entry.Id;

        PNpc->name       = entry.Script;
        PNpc->packetName = entry.DisplayName;

        PNpc->loc.p = entry.Position;

        PNpc->m_TargID = entry.LookAt;

        PNpc->animationSpeed = entry.AnimationSpeed;
        PNpc->baseSpeed      = entry.Speed;
        PNpc->UpdateSpeed();

        PNpc->animation    = entry.Animation;
        PNpc->animationsub = entry.AnimationSub;

        PNpc->namevis = entry.NameVis;
        PNpc->status  = entry.Status;
        PNpc->m_flags = entry.EntityFlags;

        PNpc->look = look_t(entry.Look.data());

        PNpc->name_prefix     = entry.NamePrefix;
        PNpc->door_id         = entry.DoorId;
        PNpc->modelSize       = entry.ModelSize;
        PNpc->modelHitboxSize = std::max<float>(0.0f, entry.ModelHitboxSize / 10.f);
        PNpc->setWidescan(entry.Widescan);

        if (!luautils::IsContentEnabled(entry.Content))
        {
            PNpc->loc.p.x = 0.f;
            PNpc->loc.p.y = 0.f;
            PNpc->loc.p.z = 0.f;

            PNpc->status = xi::Status::Disappear;

            PNpc->setWidescan(false);
        }

        PZone->InsertNPC(PNpc);
    }
}

void InsertMobs(CZone* PZone, const xi::ZoneId zoneId, const xi::data::Mobs& mobs, const uint8 normalLevelRangeMin, const uint8 normalLevelRangeMax)
{
    const auto zoneType = PZone->GetTypeMask();
    if ((zoneType & xi::ZoneType::Instanced) != xi::ZoneType::Unknown)
    {
        return;
    }

    HashMap<std::string, const DropList_t*> dropListByTemplate;
    for (const auto& [name, mobTemplate] : mobs.Templates)
    {
        if (!mobTemplate.Loot.empty())
        {
            dropListByTemplate[name] = buildDropList(zoneId, name, mobTemplate.Loot);
        }
    }

    struct SlotPlacement
    {
        uint32 SlotId{};
        uint8  Chance{};
    };

    HashMap<uint16, SlotPlacement> slotByActIndex;
    for (const auto& slot : mobs.Slots)
    {
        for (const auto& member : slot.Members)
        {
            slotByActIndex[member.ActIndex] = { slot.Id, member.Chance };
        }
    }

    for (const auto& spawn : mobs.Spawns)
    {
        // A spawn with no template, or no position, only reserves its targid for script lookups.
        if (spawn.TemplateName.empty() || !spawn.Placed)
        {
            continue;
        }

        const auto& mobTemplate = mobs.Templates.at(spawn.TemplateName);

        if (!luautils::IsContentEnabled(mobTemplate.Content))
        {
            continue;
        }

        {
            auto* PMob = new CMobEntity;

            PMob->name       = spawn.Script;
            PMob->packetName = mobTemplate.DisplayName;
            PMob->id         = spawn.Id;
            PMob->targid     = spawn.ActIndex;

            PMob->m_SpawnPoint = spawn.Position;
            PMob->loc.p        = PMob->m_SpawnPoint;

            if (const auto dropList = dropListByTemplate.find(spawn.TemplateName); dropList != dropListByTemplate.end())
            {
                PMob->m_DropList = dropList->second;
            }

            PMob->m_minLevel = spawn.MinLevel;
            PMob->m_maxLevel = spawn.MaxLevel;

            PMob->m_Type = mobTemplate.Type;

            PMob->m_Species = static_cast<uint16>(mobTemplate.Species);

            // Merge the whole chain of attributes:
            // Ecosystem -> Family -> Species -> Templates -> Spawn
            auto attributes = mobutils::GetSpeciesData(PMob->m_Species).MobAttributes;
            xi::data::applyOverrides(attributes, mobTemplate.Attributes);
            xi::data::applyOverrides(attributes, spawn.Attributes);

            // And apply it!
            mobutils::ApplySpecies(PMob, attributes);

            // The weapon's own defaults are not a mob's, so these are always applied.
            auto* mainWeapon = static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN]);
            mainWeapon->setMaxHit(1);
            mainWeapon->setSkillType(attributes.CombatSkill.value_or(xi::SkillType::None));
            mainWeapon->setDelay(attributes.Delay.value_or(kDefaultMobDelay));
            mainWeapon->setBaseDelay(attributes.Delay.value_or(kDefaultMobDelay));

            PMob->m_dmgMult = attributes.DamageMultiplier.value_or(kDefaultMobDamageMultiplier);

            if (attributes.Look)
            {
                PMob->look = look_t(attributes.Look->data());
            }

            PMob->HPmodifier = attributes.Stats.HP;
            PMob->MPmodifier = attributes.Stats.MP;

            PMob->m_RespawnTime = std::chrono::seconds(attributes.Respawn.value_or(0));
            PMob->m_SpawnType   = attributes.SpawnType.value_or(xi::SpawnType::Normal);

            if (attributes.SpawnWindow)
            {
                PMob->setSpawnWindow(attributes.SpawnWindow->first, attributes.SpawnWindow->second);
            }

            PMob->m_name_prefix = attributes.NamePrefix.value_or(0);
            PMob->loc.p.moving  = attributes.Moving.value_or(0);

            // main.NORMAL_MOB_MAX_LEVEL_RANGE_MIN/MAX let a server flatten normal mob levels; notorious mobs keep theirs.
            const bool isNotorious = (PMob->m_Type & xi::MobType::Notorious) != xi::MobType::Normal;
            if (normalLevelRangeMin > 0 && !isNotorious && PMob->m_minLevel > normalLevelRangeMin)
            {
                PMob->m_minLevel = normalLevelRangeMin;
            }

            if (normalLevelRangeMax > 0 && !isNotorious && PMob->m_maxLevel > normalLevelRangeMax)
            {
                PMob->m_maxLevel = normalLevelRangeMax;
            }

            PMob->m_flags      = static_cast<xi::EntityFlags>(attributes.EntityFlags.value_or(0));
            PMob->animation    = attributes.Animation.value_or(xi::Animation::None);
            PMob->animationsub = attributes.AnimationSub.value_or(0);
            if (PMob->animationsub != 0)
            {
                PMob->setMobMod(xi::MobMod::SpawnAnimationsub, PMob->animationsub);
            }

            PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(mobTemplate.SpellList);

            PMob->m_Pool = mobTemplate.Id;

            PMob->allegiance      = mobTemplate.Allegiance;
            PMob->namevis         = static_cast<xi::NameVis>(attributes.NameVis.value_or(0));
            PMob->modelHitboxSize = std::max<float>(0.0f, attributes.Hitbox.value_or(0) / 10.f);
            PMob->modelSize       = attributes.ModelSize.value_or(0);

            PMob->m_roamFlags    = mobTemplate.RoamFlags;
            PMob->m_MobSkillList = mobTemplate.SkillList;

            if (!spawn.Region.empty())
            {
                if (const auto* region = PZone->roamRegion(spawn.Region))
                {
                    PMob->setRoamRegion(region);
                }
                else
                {
                    ShowCriticalFmt("InsertMobs: spawn {} names region '{}', which the zone does not declare", spawn.Id, spawn.Region);
                    std::exit(-1);
                }
            }

            if (!spawn.Route.empty())
            {
                PMob->setPatrolRoute(spawn.Route);
            }

            if (const auto placement = slotByActIndex.find(spawn.ActIndex); placement != slotByActIndex.end())
            {
                SpawnSlot* spawnSlot = PZone->spawnHandler().getOrCreateSpawnSlot(placement->second.SlotId);

                if (PMob->m_SpawnType == xi::SpawnType::Scripted)
                {
                    ShowError("Mob with ID %u in spawn slot %u in zone %u is a scripted spawn. Scripted spawns should not be assigned to spawn slots.", PMob->id, placement->second.SlotId, zoneId);
                }

                spawnSlot->AddMob(PMob, placement->second.Chance);
            }

            if ((zoneType & xi::ZoneType::Dynamis) != xi::ZoneType::Unknown)
            {
                PMob->setMobMod(xi::MobMod::Charmable, 0);
            }

            // must be here first to define mobmods
            mobutils::InitializeMob(PMob);

            // species chain first, then the template over it
            for (const auto& [id, value] : attributes.Mods)
            {
                PMob->addModifier(id, value);
            }

            for (const auto& [id, value] : attributes.MobMods)
            {
                PMob->setMobMod(id, value);
            }

            PZone->InsertMOB(PMob);
        }
    }
}

} // namespace

namespace zoneutils
{

detail::LazyLoadState lazyLoad;

/************************************************************************
 *                                                                       *
 *  Reaction zones to change the time of day                             *
 *                                                                       *
 ************************************************************************/

void TOTDChange(const vanadiel_time::TOTD TOTD)
{
    for (const auto PZone : g_PZoneList | std::views::values)
    {
        PZone->TOTDChange(TOTD);
    }
}

/************************************************************************
 *                                                                       *
 *  Initialize weather for each zone and launch task if not weather      *
 *  static                                                               *
 *                                                                       *
 ************************************************************************/

void InitializeWeather()
{
    TracyZoneScoped;

    for (const auto PZone : g_PZoneList | std::views::values)
    {
        if (!PZone->weather().isStatic())
        {
            PZone->UpdateWeather();
        }
        else
        {
            PZone->SetWeather(PZone->weather().entryForDay(0).common);
        }
    }
    ShowDebug("InitializeWeather Finished");
}

void SavePlayTime()
{
    for (const auto PZone : g_PZoneList | std::views::values)
    {
        PZone->SavePlayTime();
    }
    ShowDebug("Player playtime saving finished");
}

auto GetZone(const xi::ZoneId zoneId) -> CZone*
{
    if (g_PZoneList.contains(zoneId))
    {
        return g_PZoneList.at(zoneId);
    }

    return nullptr;
}

auto GetInstanceByRunId(const xi::ZoneId zoneId, const uint32 runId) -> CInstance*
{
    auto* PZoneInstance = dynamic_cast<CZoneInstance*>(GetZone(zoneId));
    return PZoneInstance ? PZoneInstance->getInstanceByRunId(runId) : nullptr;
}

auto GetEntity(const uint32 id, const uint8 filter) -> CBaseEntity*
{
    const uint16 DynamicEntityStart = 0x700;
    const auto   zoneID             = static_cast<xi::ZoneId>((id >> 12) & 0x0FFF);
    if (CZone* PZone = GetZone(zoneID))
    {
        return PZone->GetEntity(static_cast<uint16>(id & 0x00000800 ? (id & 0x7FF) + DynamicEntityStart : id & 0xFFF), filter);
    }

    return nullptr;
}

auto GetCharByName(const std::string& name) -> CCharEntity*
{
    for (const auto PZone : g_PZoneList | std::views::values)
    {
        if (CCharEntity* PChar = PZone->GetCharByName(name); PChar != nullptr)
        {
            return PChar;
        }
    }

    return nullptr;
}

auto GetCharFromWorld(const uint32 charId, const uint16 targId) -> CCharEntity*
{
    for (auto [zoneId, PZone] : g_PZoneList)
    {
        if (zoneId == xi::ZoneId::Unknown)
        {
            continue;
        }

        if (CBaseEntity* PEntity = PZone->GetEntity(targId, TYPE_PC); PEntity != nullptr && PEntity->id == charId)
        {
            return static_cast<CCharEntity*>(PEntity);
        }
    }

    return nullptr;
}

auto GetChar(const uint32 charId) -> CCharEntity*
{
    for (const auto PZone : g_PZoneList | std::views::values)
    {
        if (CCharEntity* PEntity = PZone->GetCharByID(charId))
        {
            return PEntity;
        }
    }

    return nullptr;
}

auto GetCharToUpdate(uint32 primary, uint32 tertiary) -> CCharEntity*
{
    CCharEntity* PPrimary   = nullptr;
    CCharEntity* PSecondary = nullptr;
    CCharEntity* PTertiary  = nullptr;

    for (const auto PZone : g_PZoneList | std::views::values)
    {
        PZone->ForEachChar(
            [primary, tertiary, &PPrimary, &PSecondary, &PTertiary](CCharEntity* PChar)
            {
                if (!PPrimary)
                {
                    if (PChar->id == primary)
                    {
                        PPrimary = PChar;
                    }
                    else if (PChar->PParty && PChar->PParty->GetPartyID() == primary)
                    {
                        PSecondary = PChar;
                    }
                    else if (PChar->id == tertiary)
                    {
                        PTertiary = PChar;
                    }
                }
            });

        if (PPrimary)
        {
            return PPrimary;
        }
    }

    if (PSecondary)
    {
        return PSecondary;
    }

    return PTertiary;
}

auto GetZonesAssignedToThisProcess(const IPP mapIPP) -> std::vector<xi::ZoneId>
{
    const auto ip    = mapIPP.getIP();
    const auto ipStr = mapIPP.getIPString();
    const auto port  = mapIPP.getPort();

    // NOTE: We normally don't want to build a prepared statement with fmt::format,
    //     : but this query is entirely internal, so it's OK.
    const auto zonesQuery = fmt::format("SELECT zoneid "
                                        "FROM zone_settings "
                                        "WHERE IF({} <> 0, '{}' = zoneip AND {} = zoneport, TRUE)",
                                        ip,
                                        ipStr,
                                        port);

    std::vector<xi::ZoneId> zonesOnThisProcess;

    const auto rset = db::preparedStmt(zonesQuery);
    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            zonesOnThisProcess.emplace_back(rset->get<xi::ZoneId>("zoneid"));
        }
    }

    return zonesOnThisProcess;
}

auto IsZoneAssignedToThisProcess(const IPP mapIPP, const xi::ZoneId zoneId) -> bool
{
    for (const auto zone : GetZonesAssignedToThisProcess(mapIPP))
    {
        if (zone == zoneId)
        {
            return true;
        }
    }

    return false;
}

/************************************************************************
 *                                                                       *
 *  Upload a list of NPCs to the specified zone                          *
 *                                                                       *
 ************************************************************************/

auto LoadNPCList(Scheduler& scheduler, const std::vector<xi::ZoneId>& zoneIds, const std::vector<ZoneEntityFiles>& parsed) -> Task<void>
{
    TracyZoneScoped;

    ShowInfo("Loading NPCs");

    co_await Scheduler::TaskGroup(
        zoneIds.size(),
        [&](auto& add)
        {
            for (const auto& [zoneId, records] : std::views::zip(zoneIds, parsed))
            {
                add(scheduler.spawnOnWorkerThread(
                    [zoneId, &records]()
                    {
                        TracyZoneScoped;

                        auto* PZone = g_PZoneList[zoneId];

                        if (const auto& npcs = records.Npcs)
                        {
                            InsertNPCs(PZone, zoneId, *npcs);
                        }
                    }));
            }
        });

    ShowInfo("Loading NPC scripts");
    // handle npc spawn functions after they're all done loading
    ForEachZone(
        zoneIds,
        [](CZone* PZone)
        {
            // NOTE: We have to do this in two passes because NPCs may rely on eachother.
            //     : So load them all, then spawn them all.
            PZone->ForEachNpc(
                [](CNpcEntity* PNpc)
                {
                    // Cache NPC Lua
                    luautils::OnEntityLoad(PNpc);
                });

            PZone->ForEachNpc(
                [](CNpcEntity* PNpc)
                {
                    luautils::OnNpcSpawn(PNpc);
                });
        });
}

/************************************************************************
 *                                                                       *
 *  Upload a list of MOBs to the specified zone                          *
 *                                                                       *
 ************************************************************************/

void LoadRoamRegions(CZone* PZone)
{
    const auto regions = xi::data::loadZoneFile<RegionsDataset>(PZone->GetID());
    if (!regions)
    {
        return;
    }

    for (const auto& region : *regions)
    {
        RoamRegion::Ring outer;
        outer.reserve(region.Outer.size());
        for (const auto& corner : region.Outer)
        {
            outer.push_back({ .x = corner[0], .y = corner[1], .z = corner[2] });
        }

        std::vector<RoamRegion::Ring> holes;
        holes.reserve(region.Holes.size());
        for (const auto& source : region.Holes)
        {
            RoamRegion::Ring hole;
            hole.reserve(source.size());
            for (const auto& corner : source)
            {
                hole.push_back({ .x = corner[0], .y = corner[1], .z = corner[2] });
            }

            holes.push_back(std::move(hole));
        }

        const auto* added = PZone->addRoamRegion(region.Name, RoamRegion(outer, holes));

        if (!added->hasWalkableSurface(*PZone->navMesh()))
        {
            ShowWarningFmt("LoadRoamRegions: {} does not sit on the navmesh of zone {}", region.Name, static_cast<uint16>(PZone->GetID()));
        }
    }
}

auto LoadMOBList(Scheduler& scheduler, const std::vector<xi::ZoneId>& zoneIds, const std::vector<ZoneEntityFiles>& parsed) -> Task<void>
{
    TracyZoneScoped;

    ShowInfo("Loading Mobs");

    const auto normalLevelRangeMin = settings::get<uint8>("main.NORMAL_MOB_MAX_LEVEL_RANGE_MIN");
    const auto normalLevelRangeMax = settings::get<uint8>("main.NORMAL_MOB_MAX_LEVEL_RANGE_MAX");

    co_await Scheduler::TaskGroup(
        zoneIds.size(),
        [&](auto& add)
        {
            for (const auto& [zoneId, records] : std::views::zip(zoneIds, parsed))
            {
                add(scheduler.spawnOnWorkerThread(
                    [normalLevelRangeMin, normalLevelRangeMax, zoneId, &records]()
                    {
                        TracyZoneScoped;

                        auto* PZone = g_PZoneList[zoneId];

                        if (const auto& mobs = records.Mobs)
                        {
                            InsertMobs(PZone, zoneId, *mobs, normalLevelRangeMin, normalLevelRangeMax);
                        }
                    }));
            }
        });

    ShowInfo("Loading Mob scripts");
    // handle mob Initialize functions after they're all loaded
    ForEachZone(
        zoneIds,
        [](CZone* PZone)
        {
            PZone->ForEachMob(
                [](CMobEntity* PMob)
                {
                    // Cache Mob Lua
                    luautils::OnEntityLoad(PMob);
                });

            PZone->ForEachMob(
                [&PZone](CMobEntity* PMob)
                {
                    luautils::OnMobInitialize(PMob);
                    PZone->FindPartyForMob(PMob);

                    luautils::ApplyMixins(PMob);
                    luautils::ApplyZoneMixins(PMob);

                    PMob->saveModifiers();
                    PMob->saveMobModifiers();

                    // Allow the mob to respawn if it is NOT a lottery, scripted, or windowed spawn
                    PMob->m_AllowRespawn = !(PMob->m_SpawnType == xi::SpawnType::Lottery ||
                                             PMob->m_SpawnType == xi::SpawnType::Scripted ||
                                             PMob->m_SpawnType == xi::SpawnType::Windowed);

                    // Intialize monsters that do not require specific conditions to spawn initially. Monsters conditioned to
                    // spawn by time or weather will be allowed upon corresponding time/weather events.
                    PMob->m_CanSpawn = !PMob->spawnWindow().has_value() &&
                                       (PMob->m_SpawnType == xi::SpawnType::Normal ||
                                        PMob->m_SpawnType == xi::SpawnType::Lottery ||
                                        PMob->m_SpawnType == xi::SpawnType::Scripted ||
                                        PMob->m_SpawnType == xi::SpawnType::Windowed);
                });

            // Spawn mobs after they've all been initialized. Spawning some mobs will spawn other mobs that may not yet be initialized.
            PZone->ForEachMob(
                [&PZone](CMobEntity* PMob)
                {
                    // Skip mobs already registered via setRespawnTime in onMobInitialize - let SpawnHandler handle them
                    if (PZone->spawnHandler().isRegistered(PMob))
                    {
                        if (PMob->m_SpawnType == xi::SpawnType::Scripted && PMob->m_RespawnTime > 0s)
                        {
                            PMob->m_AllowRespawn = true;
                        }
                        return;
                    }

                    if (PMob->m_CanSpawn && PMob->m_AllowRespawn)
                    {
                        PMob->m_AllowRespawn = true;
                        PMob->TrySpawn();
                    }
                    else
                    {
                        // If the mob is a scripted spawn and it has a respawn time defined when the mob initializes then allow it to respawn
                        if (PMob->m_SpawnType == xi::SpawnType::Scripted && PMob->m_RespawnTime > 0s)
                        {
                            PMob->m_AllowRespawn = true;
                        }

                        // Condition-based mobs (time/weather) register with 0s so they spawn when conditions are met
                        const bool isConditionBased = (PMob->m_SpawnType & (xi::SpawnType::AtNight | xi::SpawnType::AtEvening | xi::SpawnType::Weather | xi::SpawnType::Fog)) != xi::SpawnType::Normal ||
                                                      PMob->spawnWindow().has_value();
                        PZone->spawnHandler().registerForRespawn(PMob, isConditionBased ? std::make_optional(0s) : std::nullopt);
                    }
                });
        });
}

/************************************************************************
 *                                                                       *
 *  Create a new zone.                                                   *
 *                                                                       *
 ************************************************************************/

auto CreateZone(Scheduler& scheduler, MapConfig config, const xi::ZoneId ZoneID) -> CZone*
{
    const auto make = [&](const xi::ZoneType zoneType, const uint8 restriction, const std::optional<xi::data::ZoneSettings>& settings) -> CZone*
    {
        if ((zoneType & xi::ZoneType::Instanced) != xi::ZoneType::Unknown)
        {
            return new CZoneInstance(scheduler, config, ZoneID, GetCurrentRegion(ZoneID), GetCurrentContinent(ZoneID), restriction, settings);
        }

        return new CZone(scheduler, config, ZoneID, GetCurrentRegion(ZoneID), GetCurrentContinent(ZoneID), restriction, settings);
    };

    const auto settings = xi::data::loadZoneFile<ZoneSettingsDataset>(ZoneID);

    if (!settings)
    {
        return make(xi::ZoneType::Unknown, uint8{}, settings);
    }

    return make(settings->Type, settings->LevelRestriction, settings);
}

/************************************************************************
 *                                                                       *
 *  Initialization of zones. Revive all monsters at server start.        *
 *                                                                       *
 ************************************************************************/

auto LoadZones(Scheduler& scheduler, MapConfig config, const std::vector<xi::ZoneId>& zoneIds) -> Task<void>
{
    std::vector<xi::ZoneId> zonesIdsToLoad;

    for (const auto zoneId : zoneIds)
    {
        if (!g_PZoneList.contains(zoneId))
        {
            zonesIdsToLoad.emplace_back(zoneId);
        }
    }

    if (zonesIdsToLoad.empty())
    {
        // Requested zones are already loaded.
        co_return;
    }

    ShowInfo(fmt::format("Loading {} zones", zonesIdsToLoad.size()));

    for (auto zoneId : zonesIdsToLoad)
    {
        g_PZoneList[zoneId] = CreateZone(scheduler, config, zoneId);
    }

    if (!g_PZoneList.contains(xi::ZoneId::Unknown))
    {
        // False positive: "performance: Searching before insertion is not necessary."
        // cppcheck-suppress stlFindInsert
        g_PZoneList[xi::ZoneId::Unknown] = CreateZone(scheduler, config, xi::ZoneId::Unknown);
    }

    // Phase 1: Load ximeshes (navmesh build depends on ximesh)
    co_await Scheduler::TaskGroup(
        zonesIdsToLoad.size(),
        [&](auto& add)
        {
            for (const auto zoneId : zonesIdsToLoad)
            {
                add(scheduler.spawnOnWorkerThread(
                    [zoneId]()
                    {
                        g_PZoneList[zoneId]->LoadXiMesh();
                    }));
            }
        });

    // Phase 2: Load/build navmeshes (requires ximesh; processed serially because
    // each zone's build is a coroutine that dispatches tile work to workers)
    for (const auto zoneId : zonesIdsToLoad)
    {
        co_await g_PZoneList[zoneId]->LoadNavMesh();
    }

    // Parse each zone's entity files once, on workers.
    // Everything below reads these records.

    std::vector<ZoneEntityFiles> parsed(zonesIdsToLoad.size());

    co_await Scheduler::TaskGroup(
        zonesIdsToLoad.size(),
        [&](auto& add)
        {
            for (size_t index = 0; index < zonesIdsToLoad.size(); ++index)
            {
                add(scheduler.spawnOnWorkerThread(
                    [zoneId = zonesIdsToLoad[index], &records = parsed[index]]()
                    {
                        TracyZoneScoped;

                        records.Npcs = xi::data::loadZoneFile<NpcsDataset>(zoneId);
                        records.Mobs = xi::data::loadZoneFile<MobsDataset>(zoneId);
                    }));
            }
        });

    // IDs attached to xi.zone[name] need to be populated before NPCs and Mobs are loaded
    for (const auto& [zoneId, records] : std::views::zip(zonesIdsToLoad, parsed))
    {
        luautils::PopulateIDLookupsByZone(zoneId, { records.Npcs, records.Mobs });
    }

    // Regions come first: a spawn joins one by name, so they have to exist before mobs load.
    for (const auto zoneId : zonesIdsToLoad)
    {
        LoadRoamRegions(g_PZoneList[zoneId]);
    }

    co_await LoadNPCList(scheduler, zonesIdsToLoad, parsed);
    co_await LoadMOBList(scheduler, zonesIdsToLoad, parsed);

    campaign::LoadState();
    campaign::LoadNations();

    for (auto zoneId : zonesIdsToLoad)
    {
        if (g_PZoneList[zoneId]->GetIP() != 0)
        {
            luautils::OnZoneInitialize(g_PZoneList[zoneId]->GetID());
        }
    }

    // Start zone timers after all entities are loaded
    for (auto zoneId : zonesIdsToLoad)
    {
        g_PZoneList[zoneId]->createZoneTimers();
    }
}

auto LoadZoneList(Scheduler& scheduler, MapConfig config) -> Task<void>
{
    TracyZoneScoped;

    const auto zoneIds = GetZonesAssignedToThisProcess(config.ipp);
    if (zoneIds.empty())
    {
        ShowCritical("Unable to load any zones! Check IP and port params");
        std::exit(1);
    }

    co_await LoadZones(scheduler, config, zoneIds);
    luautils::InitInteractionGlobal();
}

// Initialize zone loading: immediate (load all now) or lazy (load on-demand)
auto Initialize(Scheduler& scheduler, MapConfig config) -> Task<void>
{
    if (!config.lazyZones)
    {
        co_await LoadZoneList(scheduler, config);
        co_return;
    }

    lazyLoad.enabled   = true;
    lazyLoad.asyncMode = false; // hardcoding to false since it wasn't in config

    auto zones            = GetZonesAssignedToThisProcess(config.ipp);
    lazyLoad.managedZones = std::set(zones.begin(), zones.end());

    luautils::InitInteractionGlobal();

    co_return;
}

auto ProcessLoadQueue(Scheduler& scheduler, MapConfig config) -> Task<void>
{
    TracyZoneScoped;

    if (!lazyLoad.loadQueue.empty())
    {
        auto zoneId = lazyLoad.loadQueue.front();
        lazyLoad.loadQueue.pop();
        co_await LoadZones(scheduler, config, { zoneId });
    }

    co_return;
}

auto IsLazyLoadingEnabled() -> bool
{
    return lazyLoad.enabled;
}

// Returns all zones managed by this process (ID and name)
// - Lazy mode: queries database for zone names
// - Immediate mode: uses already-loaded zone objects
auto GetManagedZones() -> std::vector<std::pair<xi::ZoneId, std::string>>
{
    std::vector<std::pair<xi::ZoneId, std::string>> result;

    // Lazy loading enabled: fetch from database
    if (!lazyLoad.managedZones.empty())
    {
        const auto query = fmt::format("SELECT zoneid, name FROM zone_settings WHERE zoneid IN ({})",
                                       fmt::join(lazyLoad.managedZones, ","));
        const auto rset  = db::preparedStmt(query);
        FOR_DB_MULTIPLE_RESULTS(rset)
        {
            result.emplace_back(rset->get<xi::ZoneId>("zoneid"), rset->get<std::string>("name"));
        }
    }
    // Lazy loading disabled: use loaded zone objects
    else
    {
        for (const auto& [zoneId, zone] : g_PZoneList)
        {
            result.emplace_back(zoneId, zone->getName());
        }
    }

    return result;
}

// TODO:
// This shouldn't have side effects, it should be const and the caller should be responsible
// for requesting the zone is loaded if it isn't ready.
auto IsZoneReady(Scheduler& scheduler, MapConfig config, xi::ZoneId zoneId) -> Task<bool>
{
    // Zone already loaded, or lazy loading disabled (all zones loaded at startup)
    if (GetZone(zoneId) || !lazyLoad.enabled)
    {
        co_return true;
    }

    // Zone not managed by this process - caller will handle cross-process
    if (!lazyLoad.managedZones.contains(zoneId))
    {
        co_return true;
    }

    // Sync mode: load now
    if (!lazyLoad.asyncMode)
    {
        co_await LoadZones(scheduler, config, { zoneId });
        co_return true;
    }

    // Async mode: queue and tell caller to wait
    lazyLoad.loadQueue.push(zoneId);
    co_return false;
}

/************************************************************************
 *                                                                       *
 *  Return current region from zone id                                   *
 *                                                                       *
 ************************************************************************/

auto GetCurrentRegion(const xi::ZoneId zoneId) -> REGION_TYPE
{
    switch (zoneId)
    {
        case xi::ZoneId::BostaunieuxOubliette:
        case xi::ZoneId::EastRonfaure:
        case xi::ZoneId::FortGhelsba:
        case xi::ZoneId::GhelsbaOutpost:
        case xi::ZoneId::HorlaisPeak:
        case xi::ZoneId::KingRanperresTomb:
        case xi::ZoneId::WestRonfaure:
        case xi::ZoneId::YughottGrotto:
            return REGION_TYPE::RONFAURE;
        case xi::ZoneId::GusgenMines:
        case xi::ZoneId::KonschtatHighlands:
        case xi::ZoneId::LaTheinePlateau:
        case xi::ZoneId::OrdellesCaves:
        case xi::ZoneId::Selbina:
        case xi::ZoneId::ValkurmDunes:
            return REGION_TYPE::ZULKHEIM;
        case xi::ZoneId::BatalliaDowns:
        case xi::ZoneId::CarpentersLanding:
        case xi::ZoneId::Davoi:
        case xi::ZoneId::TheEldiemeNecropolis:
        case xi::ZoneId::JugnerForest:
        case xi::ZoneId::MonasticCavern:
        case xi::ZoneId::PhanauetChannel:
            return REGION_TYPE::NORVALLEN;
        case xi::ZoneId::DangrufWadi:
        case xi::ZoneId::KorrolokaTunnel:
        case xi::ZoneId::NorthGustaberg:
        case xi::ZoneId::PalboroughMines:
        case xi::ZoneId::SouthGustaberg:
        case xi::ZoneId::WaughroonShrine:
        case xi::ZoneId::ZeruhnMines:
            return REGION_TYPE::GUSTABERG;
        case xi::ZoneId::Beadeaux:
        case xi::ZoneId::CrawlersNest:
        case xi::ZoneId::PashhowMarshlands:
        case xi::ZoneId::QulunDome:
        case xi::ZoneId::RolanberryFields:
            return REGION_TYPE::DERFLAND;
        case xi::ZoneId::BalgasDais:
        case xi::ZoneId::EastSarutabaruta:
        case xi::ZoneId::FullMoonFountain:
        case xi::ZoneId::Giddeus:
        case xi::ZoneId::InnerHorutotoRuins:
        case xi::ZoneId::OuterHorutotoRuins:
        case xi::ZoneId::ToraimaraiCanal:
        case xi::ZoneId::WestSarutabaruta:
            return REGION_TYPE::SARUTABARUTA;
        case xi::ZoneId::BibikiBay:
        case xi::ZoneId::BuburimuPeninsula:
        case xi::ZoneId::LabyrinthOfOnzozo:
        case xi::ZoneId::Manaclipper:
        case xi::ZoneId::MazeOfShakhrami:
        case xi::ZoneId::Mhaura:
        case xi::ZoneId::TahrongiCanyon:
            return REGION_TYPE::KOLSHUSHU;
        case xi::ZoneId::AltarRoom:
        case xi::ZoneId::AttohwaChasm:
        case xi::ZoneId::BoneyardGully:
        case xi::ZoneId::CastleOztroja:
        case xi::ZoneId::GarlaigeCitadel:
        case xi::ZoneId::MeriphataudMountains:
        case xi::ZoneId::SauromugueChampaign:
            return REGION_TYPE::ARAGONEU;
        case xi::ZoneId::BeaucedineGlacier:
        case xi::ZoneId::CloisterOfFrost:
        case xi::ZoneId::Feiyin:
        case xi::ZoneId::Psoxja:
        case xi::ZoneId::QubiaArena:
        case xi::ZoneId::RanguemontPass:
        case xi::ZoneId::TheShroudedMaw:
            return REGION_TYPE::FAUREGANDI;
        case xi::ZoneId::BearclawPinnacle:
        case xi::ZoneId::CastleZvahlBaileys:
        case xi::ZoneId::CastleZvahlKeep:
        case xi::ZoneId::ThroneRoom:
        case xi::ZoneId::UleguerandRange:
        case xi::ZoneId::Xarcabard:
            return REGION_TYPE::VALDEAUNIA;
        case xi::ZoneId::BehemothsDominion:
        case xi::ZoneId::LowerDelkfuttsTower:
        case xi::ZoneId::MiddleDelkfuttsTower:
        case xi::ZoneId::QufimIsland:
        case xi::ZoneId::StellarFulcrum:
        case xi::ZoneId::UpperDelkfuttsTower:
            return REGION_TYPE::QUFIMISLAND;
        case xi::ZoneId::TheBoyahdaTree:
        case xi::ZoneId::CloisterOfStorms:
        case xi::ZoneId::DragonsAery:
        case xi::ZoneId::HallOfTheGods:
        case xi::ZoneId::Romaeve:
        case xi::ZoneId::TheSanctuaryOfZitah:
            return REGION_TYPE::LITELOR;
        case xi::ZoneId::CloisterOfTremors:
        case xi::ZoneId::EasternAltepaDesert:
        case xi::ZoneId::ChamberOfOracles:
        case xi::ZoneId::QuicksandCaves:
        case xi::ZoneId::Rabao:
        case xi::ZoneId::WesternAltepaDesert:
            return REGION_TYPE::KUZOTZ;
        case xi::ZoneId::CapeTeriggan:
        case xi::ZoneId::CloisterOfGales:
        case xi::ZoneId::GustavTunnel:
        case xi::ZoneId::KuftalTunnel:
        case xi::ZoneId::ValleyOfSorrows:
            return REGION_TYPE::VOLLBOW;
        case xi::ZoneId::Kazham:
        case xi::ZoneId::Norg:
        case xi::ZoneId::SeaSerpentGrotto:
        case xi::ZoneId::YuhtungaJungle:
            return REGION_TYPE::ELSHIMO_LOWLANDS;
        case xi::ZoneId::CloisterOfFlames:
        case xi::ZoneId::CloisterOfTides:
        case xi::ZoneId::DenOfRancor:
        case xi::ZoneId::IfritsCauldron:
        case xi::ZoneId::SacrificialChamber:
        case xi::ZoneId::TempleOfUggalepih:
        case xi::ZoneId::YhoatorJungle:
            return REGION_TYPE::ELSHIMO_UPLANDS;
        case xi::ZoneId::TheCelestialNexus:
        case xi::ZoneId::LaloffAmphitheater:
        case xi::ZoneId::RuaunGardens:
        case xi::ZoneId::TheShrineOfRuavitau:
        case xi::ZoneId::VelugannonPalace:
            return REGION_TYPE::TULIA;
        case xi::ZoneId::MineShaft2716:
        case xi::ZoneId::NewtonMovalpolos:
        case xi::ZoneId::OldtonMovalpolos:
            return REGION_TYPE::MOVALPOLOS;
        case xi::ZoneId::LufaiseMeadows:
        case xi::ZoneId::MisareauxCoast:
        case xi::ZoneId::MonarchLinn:
        case xi::ZoneId::PhomiunaAqueducts:
        case xi::ZoneId::RiverneSiteA01:
        case xi::ZoneId::RiverneSiteB01:
        case xi::ZoneId::Sacrarium:
        case xi::ZoneId::SealionsDen:
            return REGION_TYPE::TAVNAZIA;
        case xi::ZoneId::TavnazianSafehold:
            return REGION_TYPE::TAVNAZIAN_MARQ;
        case xi::ZoneId::SouthernSanDoria:
        case xi::ZoneId::NorthernSanDoria:
        case xi::ZoneId::PortSanDoria:
        case xi::ZoneId::ChateauDoraguille:
            return REGION_TYPE::SANDORIA;
        case xi::ZoneId::BastokMines:
        case xi::ZoneId::BastokMarkets:
        case xi::ZoneId::PortBastok:
        case xi::ZoneId::Metalworks:
            return REGION_TYPE::BASTOK;
        case xi::ZoneId::WindurstWaters:
        case xi::ZoneId::WindurstWalls:
        case xi::ZoneId::PortWindurst:
        case xi::ZoneId::WindurstWoods:
        case xi::ZoneId::HeavensTower:
            return REGION_TYPE::WINDURST;
        case xi::ZoneId::RuludeGardens:
        case xi::ZoneId::UpperJeuno:
        case xi::ZoneId::LowerJeuno:
        case xi::ZoneId::PortJeuno:
            return REGION_TYPE::JEUNO;
        case xi::ZoneId::DynamisBastok:
        case xi::ZoneId::DynamisBeaucedine:
        case xi::ZoneId::DynamisBuburimu:
        case xi::ZoneId::DynamisJeuno:
        case xi::ZoneId::DynamisQufim:
        case xi::ZoneId::DynamisSanDoria:
        case xi::ZoneId::DynamisTavnazia:
        case xi::ZoneId::DynamisValkurm:
        case xi::ZoneId::DynamisWindurst:
        case xi::ZoneId::DynamisXarcabard:
            return REGION_TYPE::DYNAMIS;
        case xi::ZoneId::PromyvionDem:
        case xi::ZoneId::PromyvionHolla:
        case xi::ZoneId::PromyvionMea:
        case xi::ZoneId::PromyvionVahzl:
        case xi::ZoneId::SpireOfDem:
        case xi::ZoneId::SpireOfHolla:
        case xi::ZoneId::SpireOfMea:
        case xi::ZoneId::SpireOfVahzl:
        case xi::ZoneId::HallOfTransference:
            return REGION_TYPE::PROMYVION;
        case xi::ZoneId::Altaieu:
        case xi::ZoneId::EmpyrealParadox:
        case xi::ZoneId::TheGardenOfRuhmet:
        case xi::ZoneId::GrandPalaceOfHuxzoi:
            return REGION_TYPE::LUMORIA;
        case xi::ZoneId::Apollyon:
        case xi::ZoneId::Temenos:
            return REGION_TYPE::LIMBUS;
        case xi::ZoneId::AlZahbi:
        case xi::ZoneId::AhtUrhganWhitegate:
        case xi::ZoneId::BhaflauThickets:
        case xi::ZoneId::TheColosseum:
            return REGION_TYPE::WEST_AHT_URHGAN;
        case xi::ZoneId::MamoolJaTrainingGrounds:
        case xi::ZoneId::Mamook:
        case xi::ZoneId::WajaomWoodlands:
        case xi::ZoneId::AydeewaSubterrane:
        case xi::ZoneId::JadeSepulcher:
            return REGION_TYPE::MAMOOL_JA_SAVAGE;
        case xi::ZoneId::Halvung:
        case xi::ZoneId::MountZhayolm:
        case xi::ZoneId::LebrosCavern:
        case xi::ZoneId::NavukgoExecutionChamber:
            return REGION_TYPE::HALVUNG;
        case xi::ZoneId::ArrapagoReef:
        case xi::ZoneId::CaedarvaMire:
        case xi::ZoneId::LeujaoamSanctum:
        case xi::ZoneId::Nashmau:
        case xi::ZoneId::HazhalmTestingGrounds:
        case xi::ZoneId::TalaccaCove:
        case xi::ZoneId::Periqia:
            return REGION_TYPE::ARRAPAGO;
        case xi::ZoneId::NyzulIsle:
        case xi::ZoneId::ArrapagoRemnants:
        case xi::ZoneId::AlzadaalUnderseaRuins:
        case xi::ZoneId::BhaflauRemnants:
        case xi::ZoneId::SilverSeaRemnants:
        case xi::ZoneId::ZhayolmRemnants:
            return REGION_TYPE::ALZADAAL;
        case xi::ZoneId::SouthernSanDoriaS:
        case xi::ZoneId::EastRonfaureS:
            return REGION_TYPE::RONFAURE_FRONT;
        case xi::ZoneId::BastokMarketsS:
        case xi::ZoneId::NorthGustabergS:
        case xi::ZoneId::RuhotzSilvermines:
        case xi::ZoneId::GraubergS:
            return REGION_TYPE::GUSTABERG_FRONT;
        case xi::ZoneId::WindurstWatersS:
        case xi::ZoneId::WestSarutabarutaS:
        case xi::ZoneId::GhoyusReverie:
        case xi::ZoneId::FortKarugoNarugoS:
            return REGION_TYPE::SARUTA_FRONT;
        case xi::ZoneId::BatalliaDownsS:
        case xi::ZoneId::JugnerForestS:
        case xi::ZoneId::LaVauleS:
        case xi::ZoneId::EverbloomHollow:
        case xi::ZoneId::TheEldiemeNecropolisS:
            return REGION_TYPE::NORVALLEN_FRONT;
        case xi::ZoneId::RolanberryFieldsS:
        case xi::ZoneId::PashhowMarshlandsS:
        case xi::ZoneId::CrawlersNestS:
        case xi::ZoneId::BeadeauxS:
        case xi::ZoneId::VunkerlInletS:
            return REGION_TYPE::DERFLAND_FRONT;
        case xi::ZoneId::SauromugueChampaignS:
        case xi::ZoneId::MeriphataudMountainsS:
        case xi::ZoneId::CastleOztrojaS:
        case xi::ZoneId::GarlaigeCitadelS:
            return REGION_TYPE::ARAGONEAU_FRONT;
        case xi::ZoneId::BeaucedineGlacierS:
            return REGION_TYPE::FAUREGANDI_FRONT;
        case xi::ZoneId::XarcabardS:
        case xi::ZoneId::CastleZvahlBaileysS:
        case xi::ZoneId::CastleZvahlKeepS:
        case xi::ZoneId::ThroneRoomS:
            return REGION_TYPE::VALDEAUNIA_FRONT;
        case xi::ZoneId::AbysseaAltepa:
        case xi::ZoneId::AbysseaAttohwa:
        case xi::ZoneId::AbysseaEmpyrealParadox:
        case xi::ZoneId::AbysseaGrauberg:
        case xi::ZoneId::AbysseaKonschtat:
        case xi::ZoneId::AbysseaLaTheine:
        case xi::ZoneId::AbysseaMisareaux:
        case xi::ZoneId::AbysseaTahrongi:
        case xi::ZoneId::AbysseaUleguerand:
        case xi::ZoneId::AbysseaVunkerl:
            return REGION_TYPE::ABYSSEA;
        case xi::ZoneId::WalkOfEchoes:
            return REGION_TYPE::THE_THRESHOLD;
        case xi::ZoneId::DioramaAbdhaljsGhelsba:
        case xi::ZoneId::AbdhaljsIslePurgonorgo:
        case xi::ZoneId::MaquetteAbdhaljsLegionA:
        case xi::ZoneId::MaquetteAbdhaljsLegionB:
            return REGION_TYPE::ABDHALJS;
        case xi::ZoneId::WesternAdoulin:
        case xi::ZoneId::EasternAdoulin:
        case xi::ZoneId::RalaWaterways:
        case xi::ZoneId::RalaWaterwaysU:
            return REGION_TYPE::ADOULIN_ISLANDS;
        case xi::ZoneId::CeizakBattlegrounds:
        case xi::ZoneId::ForetDeHennetiel:
        case xi::ZoneId::SihGates:
        case xi::ZoneId::MohGates:
        case xi::ZoneId::CirdasCaverns:
        case xi::ZoneId::CirdasCavernsU:
        case xi::ZoneId::YahseHuntingGrounds:
        case xi::ZoneId::MorimarBasaltFields:
            return REGION_TYPE::EAST_ULBUKA;
        default:
            break;
    }
    return REGION_TYPE::UNKNOWN;
}

auto GetCurrentContinent(const xi::ZoneId zoneId) -> CONTINENT_TYPE
{
    return GetCurrentRegion(zoneId) != REGION_TYPE::UNKNOWN ? CONTINENT_TYPE::THE_MIDDLE_LANDS : CONTINENT_TYPE::OTHER_AREAS;
}

auto GetWeatherElement(const xi::Weather weather) -> int
{
    if (!magic_enum::enum_contains<xi::Weather>(weather))
    {
        ShowWarning("zoneutils::GetWeatherElement() - Invalid weather passed to function.");
        return 0;
    }

    // TODO: Fix weather ordering; at the moment, this current fire, water, earth, wind, snow, thunder
    // order MUST be preserved due to the weather enums going in this order. Those enums will
    // most likely have rippling effects, such as how weather data is stored in the db
    constexpr uint8 Element[] = {
        0, // WEATHER_NONE
        0, // WEATHER_SUNSHINE
        0, // WEATHER_CLOUDS
        0, // WEATHER_FOG
        1, // WEATHER_HOT_SPELL
        1, // WEATHER_HEAT_WAVE
        6, // WEATHER_RAIN
        6, // WEATHER_SQUALL
        4, // WEATHER_DUST_STORM
        4, // WEATHER_SAND_STORM
        3, // WEATHER_WIND
        3, // WEATHER_GALES
        2, // WEATHER_SNOW
        2, // WEATHER_BLIZZARDS
        5, // WEATHER_THUNDER
        5, // WEATHER_THUNDERSTORMS
        7, // WEATHER_AURORAS
        7, // WEATHER_STELLAR_GLARE
        8, // WEATHER_GLOOM
        8, // WEATHER_DARKNESS
    };
    return Element[static_cast<uint16_t>(weather)];
}

/************************************************************************
 *                                                                       *
 *  Clear (free up) the list of zones                                    *
 *                                                                       *
 ************************************************************************/

void FreeZoneList()
{
    for (auto PZone : g_PZoneList | std::views::values)
    {
        destroy(PZone);
    }
    g_PZoneList.clear();
}

void ForEachZone(FnRef<void(CZone*)> func)
{
    for (const auto PZone : g_PZoneList | std::views::values)
    {
        func(PZone);
    }
}

void ForEachZone(const std::vector<xi::ZoneId>& zoneIds, FnRef<void(CZone*)> func)
{
    for (auto zoneId : zoneIds)
    {
        if (g_PZoneList.contains(zoneId))
        {
            func(g_PZoneList[zoneId]);
        }
    }
}

auto GetZoneIPP(xi::ZoneId zoneId) -> uint64
{
    uint64 ipp = 0;

    const auto query = "SELECT zoneip, zoneport FROM zone_settings WHERE zoneid = ?";

    const auto rset = db::preparedStmt(query, zoneId);
    if (rset && rset->rowsCount() && rset->next())
    {
        const auto zoneip = str2ip(rset->get<std::string>("zoneip"));
        const auto port   = rset->get<uint16>("zoneport");

        ipp = IPP(zoneip, port).getRawIPP();
    }
    else
    {
        ShowCritical("zoneutils::GetZoneIPP: Cannot find zone %u", zoneId);
    }

    return ipp;
}

auto CanZoneUseMisc(xi::ZoneId zoneId, xi::ZoneMisc misc) -> bool
{
    const auto settings = xi::data::loadZoneFile<ZoneSettingsDataset>(zoneId);

    return settings && (settings->Misc & misc) == misc;
}

auto IsZoneAtPlayerCap(xi::ZoneId zoneId, bool isGM) -> bool
{
    const auto cap = settings::get<uint16>("map.ZONE_PLAYER_CAP");
    if (cap == 0)
    {
        return false;
    }

    const auto reserved  = settings::get<uint16>("map.ZONE_PLAYER_GM_RESERVED");
    const auto threshold = isGM ? cap : static_cast<uint16>(cap > reserved ? cap - reserved : 0);

    const auto settings = xi::data::loadZoneFile<ZoneSettingsDataset>(zoneId);
    if (settings && (settings->Type & xi::ZoneType::Instanced) != xi::ZoneType::Unknown)
    {
        return false;
    }

    const auto rset = db::preparedStmt(
        "SELECT COUNT(*) AS pop FROM accounts_sessions s "
        "JOIN chars c ON c.charid = s.charid "
        "WHERE c.pos_zone = ?",
        zoneId);

    FOR_DB_SINGLE_RESULT(rset)
    {
        return rset->get<uint32>("pop") >= threshold;
    }

    return false;
}

/************************************************************************
 *                                                                       *
 *  Check whether or not the zone is a residential area                  *
 *                                                                       *
 ************************************************************************/

auto IsResidentialArea(const CCharEntity* PChar) -> bool
{
    return PChar->inMogHouse();
}

void AfterZoneIn(CBaseEntity* PEntity)
{
    auto* PChar = dynamic_cast<CCharEntity*>(PEntity);
    if (!PChar)
    {
        return;
    }

    const bool inBattlefield    = PChar->PBattlefield && PChar->PBattlefield->isEntered(PChar);
    const bool inCappedInstance = PChar->PInstance && PChar->PInstance->GetLevelCap() > 0;
    if (!inBattlefield && !inCappedInstance)
    {
        GetZone(PChar->getZone())->updateCharLevelRestriction(PChar);
    }

    PChar->aman().onZoneIn();
    luautils::AfterZoneIn(PChar);
}

auto IsAlwaysOutOfNationControl(const REGION_TYPE region) -> bool
{
    return region >= REGION_TYPE::SANDORIA && region <= REGION_TYPE::LIMBUS;
}

}; // namespace zoneutils
