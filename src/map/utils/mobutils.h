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

#include "common/cbasetypes.h"

#include <common/types/hash_map.h>

#include "data/enums/ecosystem.h"
#include "data/enums/family.h"
#include "data/mob_attributes.h"
#include "entities/mob_entity.h"
#include "modifier.h"

struct ModsList_t
{
    uint32                  id;
    std::vector<CModifier*> mods;
    std::vector<CModifier*> mobMods;

    ModsList_t()
    : id(0)
    {
    }
};

enum class WeaknessType
{
    BLUE   = 0,
    YELLOW = 1,
    RED    = 2,
    WHITE  = 3
};

typedef HashMap<uint32, ModsList_t*> ModsMap_t;

namespace mobutils
{

// A species with the attributes of its family and ecosystem already folded in.
struct SpeciesInfo
{
    xi::Ecosystem               Ecosystem{};
    xi::Family                  Family{};
    xi::data::MobAttributesData MobAttributes{};
};

template <class T>
void ApplyStatRanks(T& out, const xi::data::StatRanksData& stats)
{
    out.strRank = static_cast<uint8>(stats.Str);
    out.dexRank = static_cast<uint8>(stats.Dex);
    out.vitRank = static_cast<uint8>(stats.Vit);
    out.agiRank = static_cast<uint8>(stats.Agi);
    out.intRank = static_cast<uint8>(stats.Int);
    out.mndRank = static_cast<uint8>(stats.Mnd);
    out.chrRank = static_cast<uint8>(stats.Chr);
    out.defRank = static_cast<uint8>(stats.Def);
    out.evaRank = static_cast<uint8>(stats.Eva);
    out.attRank = static_cast<uint8>(stats.Att);
    out.accRank = static_cast<uint8>(stats.Acc);
}

void LoadSpeciesData();
auto GetSpeciesData(uint16 speciesId) -> const SpeciesInfo&;
void ApplySpecies(CMobEntity* PMob);
void CalculateMobStats(CMobEntity* PMob, bool recover = true);
void SetupJob(CMobEntity* PMob);
void SetupRoaming(CMobEntity* PMob);
void SetupDynamisMob(CMobEntity* PMob);
void SetupBattlefieldMob(CMobEntity* PMob);
void SetupEventMob(CMobEntity* PMob);
void SetupDungeonInstanceMob(CMobEntity* PMob);
void SetupPetSkills(CMobEntity* PMob);

auto JobSkillRankToBaseEvaRank(xi::Job mjob, xi::Job sjob) -> uint8;

uint16 GetBaseWeaponDamage(CMobEntity* PMob, uint16 slot);
uint16 GetMagicEvasion(CMobEntity* PMob);
uint16 GetBaseDefEva(CMobEntity* PMob, uint8 rank);
uint16 GetBaseSkill(CMobEntity* PMob, uint8 rank);
uint16 GetBaseToRank(uint8 rank, uint16 level);
uint16 GetSubJobStats(uint8 rank, uint16 level, uint16 stat);
void   GetAvailableSpells(CMobEntity* PMob);
void   InitializeMob(CMobEntity* PMob);
void   LoadSqlModifiers();
void   Cleanup();

// get modifiers for species / pool / spawn
ModsList_t* GetMobSpeciesMods(uint16 speciesId, bool create = false);
ModsList_t* GetMobPoolMods(uint32 poolId, bool create = false);
ModsList_t* GetMobSpawnMods(uint32 mobId, bool create = false);

void AddSqlModifiers(CMobEntity* PMob);

void SetSpellList(CMobEntity*, uint16);
auto InstantiateAlly(uint32 groupid, xi::ZoneId zoneID, CInstance* = nullptr) -> CMobEntity*;
auto InstantiateDynamicMob(uint32 groupid, xi::ZoneId groupZoneId, xi::ZoneId targetZoneId) -> CMobEntity*;
void WeaknessTrigger(CBaseEntity* PTarget, WeaknessType level);

}; // namespace mobutils
