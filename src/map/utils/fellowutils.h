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
#pragma once

#include "common/cbasetypes.h"

#include <optional>

namespace fellowutils
{

struct FellowAppearance
{
    uint8 name{};
    uint8 race{};
    uint8 size{};
    uint8 personality{};
    uint8 face{};
};

struct FellowProgress
{
    uint8  level{};
    uint8  levelCap{};
    uint32 exp{};
    uint8  bond{};
    uint8  bondCap{};
    uint8  job{};
    uint8  signals{};
    uint8  unlockedJobs{};
    uint8  weaponModel{};
    uint8  weaponTier{};
    uint8  headwearTier{};
    uint8  armorPath{};
    uint8  armorTier{};
    uint8  bodyLevel{};
    uint8  handsLevel{};
    uint8  legsLevel{};
    uint8  feetLevel{};
    uint8  gearLocks{};
    uint8  activeTimeUpgrades{};
    uint8  fashionAdvice{};
    uint8  kills{};
    uint32 callTime{};
};

struct FellowData
{
    FellowAppearance appearance;
    FellowProgress   progress;
};

template <typename F>
void ForEachField(FellowAppearance& data, F&& fn)
{
    fn("name", data.name);
    fn("race", data.race);
    fn("size", data.size);
    fn("personality", data.personality);
    fn("face", data.face);
}

template <typename F>
void ForEachField(FellowProgress& data, F&& fn)
{
    fn("level", data.level);
    fn("levelCap", data.levelCap);
    fn("exp", data.exp);
    fn("bond", data.bond);
    fn("bondCap", data.bondCap);
    fn("job", data.job);
    fn("signals", data.signals);
    fn("unlockedJobs", data.unlockedJobs);
    fn("weaponModel", data.weaponModel);
    fn("weaponTier", data.weaponTier);
    fn("headwearTier", data.headwearTier);
    fn("armorPath", data.armorPath);
    fn("armorTier", data.armorTier);
    fn("bodyLevel", data.bodyLevel);
    fn("handsLevel", data.handsLevel);
    fn("legsLevel", data.legsLevel);
    fn("feetLevel", data.feetLevel);
    fn("gearLocks", data.gearLocks);
    fn("activeTimeUpgrades", data.activeTimeUpgrades);
    fn("fashionAdvice", data.fashionAdvice);
    fn("kills", data.kills);
    fn("callTime", data.callTime);
}

auto HasFellow(uint32 charId) -> bool;
auto CreateFellow(uint32 charId, uint32 packed) -> bool;
auto LoadFellow(uint32 charId) -> std::optional<FellowData>;
auto SaveFellow(uint32 charId, const FellowProgress& progress) -> bool;

} // namespace fellowutils
