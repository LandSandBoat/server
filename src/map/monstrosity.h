/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "packets/basic.h"

#include "entities/battle_entity.h"
#include "packets/c2s/0x01a_action.h"

#include "data/enums/zone.h"

#include <array>
#include <memory>
#include <vector>

struct mon_data_t;
class CCharEntity;
class CSpell;

namespace xi::data
{

struct Monstrosity;

}

// A character becomes a Monipulator by setting its job to MON and zoning. On zone-in a MON character
// gets PChar->m_PMonstrosity, loaded from char_monstrosity or created with the three starter families
// and the race I instincts. Some state can only be set at zone time, so entering and leaving rely on it.
//
// Stats, exp, traits, spells and abilities check for m_PMonstrosity, then use the main and sub job of
// the current species. Main and sub job levels move together: a MNK15/NIN has NIN at 15 too, with all
// of its abilities and traits, but only the main job's SP ability.
//
// The client validates a lot for MON, but the server still checks every zone-in and MON equip packet.
// An invalid state leaves the client unable to change job, species, instincts or name without a GM.
namespace monstrosity
{

// Purchased instincts sit in a gap of the family instinct bitfield.
constexpr auto kPurchasedInstinctsOffset = 20;
constexpr auto kPurchasedInstinctsBytes  = 4;

struct MonstrosityData_t
{
public:
    MonstrosityData_t();

    uint8  MonstrosityId;
    uint16 Species;
    uint16 StanceSpecies{ 0 }; // The form Fighting Stance shows, 0 outside the stance.
    uint16 Flags;
    uint16 Look;
    uint8  Size;

    uint8 NamePrefix1;
    uint8 NamePrefix2;

    xi::Job MainJob;
    xi::Job SubJob;
    uint32  CurrentExp;

    std::array<uint16, 12> EquippedInstincts{ 0 };
    std::array<uint8, 128> levels{ 0 };
    std::array<uint8, 64>  instincts{ 0 };
    std::array<uint8, 32>  variants{ 0 };

    bool  Belligerency;
    uint8 Rank{ 0 }; // Cached for the status packet. charutils::SetPoints keeps it in step with infamy.

    timer::time_point LastEquipChange{};

    position_t EntryPos{};
    uint16     EntryZoneId;
    uint8      EntryMainJob;
    uint8      EntrySubJob;
};

void LoadStaticData();

[[nodiscard]] auto GetStaticData() -> const xi::data::Monstrosity&;

// char_monstrosity holds a character's Monstrosity progress even while it is not in MON.
[[nodiscard]] auto LoadMonstrosityData(uint32 charId) -> std::unique_ptr<MonstrosityData_t>;
void               SaveMonstrosityData(uint32 charId, const MonstrosityData_t& data);
void               WriteMonstrosityData(CCharEntity* PChar);

void TryPopulateMonstrosityData(CCharEntity* PChar);
void HandleJobChange(CCharEntity* PChar, xi::Job newJob);
void HandleZoneIn(CCharEntity* PChar);
void SendFullMonstrosityUpdate(CCharEntity* PChar);

[[nodiscard]] auto GetPackedMonstrosityName(const CCharEntity* PChar) -> uint32;

void HandleMonsterSkillActionPacket(CCharEntity* PChar, const GP_CLI_COMMAND_ACTION& data);
void HandleEquipChangePacket(CCharEntity* PChar, const mon_data_t& data);
void ChangeSpecies(CCharEntity* PChar, uint16 speciesCode);

void CalculateStats(CCharEntity* PChar);
void HandleLevelUp(CCharEntity* PChar);

// The player in MON, or null. m_PMonstrosity is only ever set while the job is MON.
[[nodiscard]] auto AsMonipulator(const CBattleEntity* PEntity) -> const CCharEntity*;

// Monipulators only help Monipulators, and adventurers only help adventurers.
[[nodiscard]] auto CanAssist(const CBattleEntity* PInitiator, const CCharEntity* PTarget) -> bool;

struct SpeciesJobs
{
    xi::Job mainJob;
    xi::Job subJob;
    uint8   level;
};

// The jobs and level a Monipulator fights with. Its sub job is at the main level.
[[nodiscard]] auto GetSpeciesJobs(const CCharEntity* PChar) -> SpeciesJobs;
[[nodiscard]] auto GetWeaponDelay(const CCharEntity* PChar) -> uint16;
[[nodiscard]] auto GetCombatSkill(const CCharEntity* PChar) -> uint16;
[[nodiscard]] auto GetEvasionSkill(const CCharEntity* PChar) -> uint16;
void               AddInfamy(CCharEntity* PChar, uint32 exp);
void               AddPrestige(CCharEntity* PChar, uint32 exp);
[[nodiscard]] auto IsGladiatorInBelligerency(const CCharEntity* PChar) -> bool;
[[nodiscard]] auto IsMonipulatorInBelligerency(const CCharEntity* PChar) -> bool;

// A flagged Monipulator and a gladiator in a Belligerency zone are enemies.
[[nodiscard]] auto AreBelligerents(const CBattleEntity* PFirst, const CBattleEntity* PSecond) -> bool;
void               HandleBelligerentDefeat(CCharEntity* PLoser, CCharEntity* PWinner);
void               HandleGladiatorGearChange(CCharEntity* PChar);
[[nodiscard]] auto GetBaseDelay(const CCharEntity* PChar) -> uint16;
void               ApplyIdleRegen(CCharEntity* PChar);
void               HandleMobSkillFired(CCharEntity* PChar, uint16 mobSkillId);
[[nodiscard]] auto GetDisplaySpecies(const CCharEntity* PChar) -> uint16;
[[nodiscard]] auto GetBaseDamage(const CCharEntity* PChar, xi::Mod rating) -> uint16;
[[nodiscard]] auto GetExpNEXTLevel(uint8 level) -> uint32;
[[nodiscard]] auto GetFeretoryExits(xi::ZoneId zoneId) -> std::vector<std::array<float, 4>>;
[[nodiscard]] auto IsPassageZone(xi::ZoneId zoneId) -> bool;
[[nodiscard]] auto CanParty(const CCharEntity* PChar) -> bool;
[[nodiscard]] auto CanCastSpell(CSpell* PSpell) -> bool;
[[nodiscard]] auto ListsSpell(const CCharEntity* PChar, CSpell* PSpell) -> bool;

void HandleDeathMenu(CCharEntity* PChar, GP_CLI_COMMAND_ACTION_HOMEPOINTMENU type);

void SetBelligerencyFlag(CCharEntity* PChar, bool flag);

void UpdateRank(CCharEntity* PChar, int32 infamy);

} // namespace monstrosity
