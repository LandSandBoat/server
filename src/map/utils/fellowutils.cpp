/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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

#include "fellowutils.h"

#include "common/database.h"
#include "common/logging.h"

namespace fellowutils
{

auto HasFellow(const uint32 charId) -> bool
{
    const auto rset = db::preparedStmt("SELECT charid FROM char_fellows WHERE charid = ? LIMIT 1", charId);
    return rset && rset->rowsCount() > 0;
}

auto CreateFellow(const uint32 charId, const uint32 packed) -> bool
{
    const uint8 name        = packed & 0x0F;
    const uint8 race        = (packed >> 4) & 0x07;
    const uint8 personality = (packed >> 10) & 0x0F;
    const uint8 size        = (packed >> 18) & 0x03;
    const uint8 face        = (packed >> 20) & 0x0F;

    if (name > 7 || personality < 1 || personality > 12 || size < 1)
    {
        ShowErrorFmt("Invalid fellow data {:#x} for char {}", packed, charId);
        return false;
    }

    if (HasFellow(charId))
    {
        return false;
    }

    const auto rset = db::preparedStmt("INSERT INTO char_fellows (charid, name, race, size, personality, face) VALUES (?, ?, ?, ?, ?, ?)",
                                       charId,
                                       name,
                                       race,
                                       size,
                                       personality,
                                       face);
    return rset && rset->rowsAffected() > 0;
}

auto LoadFellow(const uint32 charId) -> std::optional<FellowData>
{
    const auto rset = db::preparedStmt("SELECT name, race, size, personality, face, level, level_cap, exp, bond, bond_cap, "
                                       "job, signals, unlocked_jobs, weapon_model, weapon_tier, headwear_tier, armor_path, armor_tier, "
                                       "body_level, hands_level, legs_level, feet_level, gear_locks, active_time_upgrades, fashion_advice, kills, call_time "
                                       "FROM char_fellows WHERE charid = ? LIMIT 1",
                                       charId);

    if (!rset || !rset->next())
    {
        return std::nullopt;
    }

    return FellowData{
        .appearance = {
            .name        = rset->get<uint8>("name"),
            .race        = rset->get<uint8>("race"),
            .size        = rset->get<uint8>("size"),
            .personality = rset->get<uint8>("personality"),
            .face        = rset->get<uint8>("face"),
        },
        .progress = {
            .level              = rset->get<uint8>("level"),
            .levelCap           = rset->get<uint8>("level_cap"),
            .exp                = rset->get<uint32>("exp"),
            .bond               = rset->get<uint8>("bond"),
            .bondCap            = rset->get<uint8>("bond_cap"),
            .job                = rset->get<uint8>("job"),
            .signals            = rset->get<uint8>("signals"),
            .unlockedJobs       = rset->get<uint8>("unlocked_jobs"),
            .weaponModel        = rset->get<uint8>("weapon_model"),
            .weaponTier         = rset->get<uint8>("weapon_tier"),
            .headwearTier       = rset->get<uint8>("headwear_tier"),
            .armorPath          = rset->get<uint8>("armor_path"),
            .armorTier          = rset->get<uint8>("armor_tier"),
            .bodyLevel          = rset->get<uint8>("body_level"),
            .handsLevel         = rset->get<uint8>("hands_level"),
            .legsLevel          = rset->get<uint8>("legs_level"),
            .feetLevel          = rset->get<uint8>("feet_level"),
            .gearLocks          = rset->get<uint8>("gear_locks"),
            .activeTimeUpgrades = rset->get<uint8>("active_time_upgrades"),
            .fashionAdvice      = rset->get<uint8>("fashion_advice"),
            .kills              = rset->get<uint8>("kills"),
            .callTime           = rset->get<uint32>("call_time"),
        },
    };
}

auto SaveFellow(const uint32 charId, const FellowProgress& progress) -> bool
{
    const auto rset = db::preparedStmt("UPDATE char_fellows SET level = ?, level_cap = ?, exp = ?, bond = ?, bond_cap = ?, "
                                       "job = ?, signals = ?, unlocked_jobs = ?, weapon_model = ?, weapon_tier = ?, headwear_tier = ?, armor_path = ?, armor_tier = ?, "
                                       "body_level = ?, hands_level = ?, legs_level = ?, feet_level = ?, gear_locks = ?, active_time_upgrades = ?, fashion_advice = ?, kills = ?, call_time = ? "
                                       "WHERE charid = ? LIMIT 1",
                                       progress.level,
                                       progress.levelCap,
                                       progress.exp,
                                       progress.bond,
                                       progress.bondCap,
                                       progress.job,
                                       progress.signals,
                                       progress.unlockedJobs,
                                       progress.weaponModel,
                                       progress.weaponTier,
                                       progress.headwearTier,
                                       progress.armorPath,
                                       progress.armorTier,
                                       progress.bodyLevel,
                                       progress.handsLevel,
                                       progress.legsLevel,
                                       progress.feetLevel,
                                       progress.gearLocks,
                                       progress.activeTimeUpgrades,
                                       progress.fashionAdvice,
                                       progress.kills,
                                       progress.callTime,
                                       charId);
    return rset != nullptr;
}

} // namespace fellowutils
