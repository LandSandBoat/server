/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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
#include "common/types/hash_map.h"
#include "data/enums/animation.h"
#include "data/enums/behavior.h"
#include "data/enums/detects.h"
#include "data/enums/element.h"
#include "data/enums/immunity.h"
#include "data/enums/job.h"
#include "data/enums/mob_mod.h"
#include "data/enums/mod.h"
#include "data/enums/skill_type.h"
#include "data/enums/spawn_type.h"
#include "data/enums/stat_rank.h"

#include <array>
#include <optional>
#include <string_view>
#include <utility>

namespace xi::data::shared
{

struct MobAttributes;

} // namespace xi::data::shared

namespace xi::data
{

// Decoded form: what every layer of the chain merges into.

struct StatRanksData
{
    uint32       HP{};
    uint32       MP{};
    xi::StatRank Str{ xi::StatRank::C };
    xi::StatRank Dex{ xi::StatRank::C };
    xi::StatRank Vit{ xi::StatRank::C };
    xi::StatRank Agi{ xi::StatRank::C };
    xi::StatRank Int{ xi::StatRank::C };
    xi::StatRank Mnd{ xi::StatRank::C };
    xi::StatRank Chr{ xi::StatRank::C };
    xi::StatRank Def{ xi::StatRank::C };
    xi::StatRank Eva{ xi::StatRank::C };
    xi::StatRank Att{ xi::StatRank::A };
    xi::StatRank Acc{ xi::StatRank::A };
};

struct MobAttributesData
{
    // Absent means nothing in the chain set them, so the entity keeps its own default.
    std::optional<uint32>                  EntityFlags{};
    std::optional<uint8>                   AnimationSub{};
    std::optional<std::array<uint16, 10>>  Look{};
    std::optional<xi::Animation>           Animation{};
    std::optional<uint16>                  Moving{};
    std::optional<uint8>                   NameVis{};
    std::optional<uint8>                   NamePrefix{};
    std::optional<uint8>                   ModelSize{};
    std::optional<uint8>                   Hitbox{};
    std::optional<xi::Behavior>            Behavior{};
    std::optional<uint32>                  Respawn{};
    std::optional<xi::SpawnType>           SpawnType{};
    std::optional<std::pair<uint8, uint8>> SpawnWindow{};
    std::optional<xi::Immunity>            Immune{};
    std::optional<xi::SkillType>           CombatSkill{};
    std::optional<uint16>                  Delay{};
    std::optional<uint16>                  DamageMultiplier{};
    std::optional<xi::Job>                 MainJob{};
    std::optional<xi::Job>                 SubJob{};
    xi::Element                            Element{ xi::Element::None };
    StatRanksData                          Stats{};
    xi::Detects                            Detects{};
    uint8                                  Speed{ 40 };
    std::optional<uint8>                   AnimationSpeed{};
    bool                                   Charmable{ false };
    bool                                   Aggressive{ false };
    bool                                   Links{ false };
    bool                                   TrueDetection{ false };
    HashMap<xi::Mod, int16>                Resists{};
    HashMap<xi::Mod, int16>                Mods{};
    HashMap<xi::MobMod, int16>             MobMods{};
};

struct StatRanksOverrides
{
    std::optional<uint32>       HP;
    std::optional<uint32>       MP;
    std::optional<xi::StatRank> Str;
    std::optional<xi::StatRank> Dex;
    std::optional<xi::StatRank> Vit;
    std::optional<xi::StatRank> Agi;
    std::optional<xi::StatRank> Int;
    std::optional<xi::StatRank> Mnd;
    std::optional<xi::StatRank> Chr;
    std::optional<xi::StatRank> Def;
    std::optional<xi::StatRank> Eva;
    std::optional<xi::StatRank> Att;
    std::optional<xi::StatRank> Acc;
};

struct MobAttributesOverrides
{
    std::optional<uint32>                  EntityFlags;
    std::optional<uint8>                   AnimationSub;
    std::optional<std::array<uint16, 10>>  Look;
    std::optional<xi::Animation>           Animation;
    std::optional<uint16>                  Moving;
    std::optional<uint8>                   NameVis;
    std::optional<uint8>                   NamePrefix;
    std::optional<uint8>                   ModelSize;
    std::optional<uint8>                   Hitbox;
    std::optional<xi::Behavior>            Behavior;
    std::optional<uint32>                  Respawn;
    std::optional<xi::SpawnType>           SpawnType;
    std::optional<std::pair<uint8, uint8>> SpawnWindow;
    std::optional<xi::Immunity>            Immune;
    std::optional<xi::SkillType>           CombatSkill;
    std::optional<uint16>                  Delay;
    std::optional<uint16>                  DamageMultiplier;
    std::optional<xi::Job>                 MainJob;
    std::optional<xi::Job>                 SubJob;
    std::optional<xi::Element>             Element;
    std::optional<StatRanksOverrides>      Stats;
    std::optional<xi::Detects>             Detects;
    std::optional<uint8>                   Speed;
    std::optional<uint8>                   AnimationSpeed;
    std::optional<bool>                    Charmable;
    std::optional<bool>                    Aggressive;
    std::optional<bool>                    Links;
    std::optional<bool>                    TrueDetection;

    // Merged key by key, so a child only has to write what it changes.
    HashMap<xi::Mod, int16>    Resists{};
    HashMap<xi::Mod, int16>    Mods{};
    HashMap<xi::MobMod, int16> MobMods{};
};

// A child layer overrides its parent field by field; what it leaves unset it inherits.
void applyOverrides(StatRanksData& target, const StatRanksOverrides& overrides);
void applyOverrides(MobAttributesData& target, const MobAttributesOverrides& overrides);

auto convertAttributes(const shared::MobAttributes& source, std::string_view context) -> MobAttributesOverrides;
auto convertAttributes(const std::optional<shared::MobAttributes>& source, std::string_view context) -> MobAttributesOverrides;

} // namespace xi::data
