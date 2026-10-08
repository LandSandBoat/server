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
class CBattleEntity;
class CCharEntity;
class CItemWeapon;
class CSpell;

namespace xi::data
{

struct Monstrosity;

}

// ===
// See scripts/globals/monstrosity.lua for a general overview of how Monstrosity works and is designed.
// ===
namespace monstrosity
{

// Purchased instincts sit in a gap of the family instinct bitfield.
constexpr auto kPurchasedInstinctsOffset = 20;
constexpr auto kPurchasedInstinctsBytes  = 4;

// Infamy stops rising here, higher while Belligerency is flagged.
constexpr auto kInfamyCap             = 10000;
constexpr auto kInfamyCapBelligerency = 50000;

struct MonstrosityData_t
{
public:
    MonstrosityData_t();

    uint8  MonstrosityId;
    uint16 Species;
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

    bool Belligerency;

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
void HandleZoneIn(CCharEntity* PChar);
void SendFullMonstrosityUpdate(CCharEntity* PChar);

[[nodiscard]] auto GetPackedMonstrosityName(const CCharEntity* PChar) -> uint32;

void HandleMonsterSkillActionPacket(CCharEntity* PChar, const GP_CLI_COMMAND_ACTION& data);
void HandleEquipChangePacket(CCharEntity* PChar, const mon_data_t& data);

void CalculateStats(CCharEntity* PChar);
void SetLevel(CCharEntity* PChar, uint8 id, uint8 level);
void HandleLevelUp(CCharEntity* PChar);

// The player in MON, or null. m_PMonstrosity is only ever set while the job is MON.
[[nodiscard]] auto AsMonipulator(const CBattleEntity* PEntity) -> const CCharEntity*;

struct SpeciesJobs
{
    xi::Job mainJob;
    xi::Job subJob;
    uint8   level;
};

// The jobs and level a Monipulator fights with. Its sub job is at the main level.
[[nodiscard]] auto GetSpeciesJobs(const CCharEntity* PChar) -> SpeciesJobs;
[[nodiscard]] auto GetWeaponDelay(const CCharEntity* PChar, const CItemWeapon* PWeapon) -> uint16;
void               AddInfamy(CCharEntity* PChar, uint32 exp);
[[nodiscard]] auto GetBaseDelay(const CCharEntity* PChar) -> uint16;
[[nodiscard]] auto GetBaseDamage(const CCharEntity* PChar) -> uint16;
[[nodiscard]] auto GetExpNEXTLevel(uint8 level) -> uint32;
[[nodiscard]] auto GetFeretoryExits(xi::ZoneId zoneId) -> std::vector<std::array<float, 4>>;
[[nodiscard]] auto CanCastSpell(CSpell* PSpell) -> bool;
[[nodiscard]] auto ListsSpell(const CCharEntity* PChar, CSpell* PSpell) -> bool;

void HandleDeathMenu(CCharEntity* PChar, GP_CLI_COMMAND_ACTION_HOMEPOINTMENU type);

[[nodiscard]] auto IsInstinctUnlocked(const CCharEntity* PChar, uint16 instinct) -> bool;
[[nodiscard]] auto IsVariantUnlocked(const CCharEntity* PChar, uint8 variant) -> bool;

void SetBelligerencyFlag(CCharEntity* PChar, bool flag);

} // namespace monstrosity
