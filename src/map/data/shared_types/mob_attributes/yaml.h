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
#include "data/shared_types/render.h"
#include "data/yaml/enum_keyed_map.h"
#include "data/yaml/enum_token.h"

#include <glaze/glaze.hpp>

#include <array>
#include <optional>
#include <vector>

namespace xi::data::shared
{

using Rank          = std::optional<yaml::EnumToken<xi::StatRank>>;
using Jobs          = std::optional<std::array<yaml::EnumToken<xi::Job>, 2>>;
using Element       = std::optional<yaml::EnumToken<xi::Element>>;
using SkillType     = std::optional<yaml::EnumToken<xi::SkillType>>;
using Immunities    = std::optional<std::vector<yaml::EnumToken<xi::Immunity>>>;
using SpawnTypes    = std::optional<std::vector<yaml::EnumToken<xi::SpawnType>>>;
using BehaviorFlags = std::optional<std::vector<yaml::EnumToken<xi::Behavior>>>;
using DetectFlags   = std::optional<std::vector<yaml::EnumToken<xi::Detects>>>;
using Mods          = std::optional<yaml::EnumKeyedMap<xi::Mod, int16>>;
using MobMods       = std::optional<yaml::EnumKeyedMap<xi::MobMod, int16>>;

struct StatRanks
{
    std::optional<uint32> hp;
    std::optional<uint32> mp;
    Rank                  str;
    Rank                  dex;
    Rank                  vit;
    Rank                  agi;
    Rank                  intelligence;
    Rank                  mnd;
    Rank                  chr;
    Rank                  def;
    Rank                  eva;
    Rank                  att;
    Rank                  acc;
};

struct PhysicalDamageTaken
{
    std::optional<int16> slashing;
    std::optional<int16> piercing;
    std::optional<int16> blunt;
    std::optional<int16> h2h;
};

struct MagicDamageTaken
{
    std::optional<int16> all;
    std::optional<int16> fire;
    std::optional<int16> ice;
    std::optional<int16> wind;
    std::optional<int16> earth;
    std::optional<int16> thunder;
    std::optional<int16> water;
    std::optional<int16> light;
    std::optional<int16> dark;
};

struct ElementRanks
{
    std::optional<int16> fire;
    std::optional<int16> ice;
    std::optional<int16> wind;
    std::optional<int16> earth;
    std::optional<int16> thunder;
    std::optional<int16> water;
    std::optional<int16> light;
    std::optional<int16> dark;
};

struct StatusRanks
{
    std::optional<int16> paralyze;
    std::optional<int16> bind;
    std::optional<int16> silence;
    std::optional<int16> slow;
    std::optional<int16> poison;
    std::optional<int16> light_sleep;
    std::optional<int16> dark_sleep;
    std::optional<int16> blind;
    std::optional<int16> stun;
    std::optional<int16> gravity;
};

struct Resists
{
    Immunities                         immune_status;
    std::optional<PhysicalDamageTaken> dmg_physical;
    std::optional<MagicDamageTaken>    dmg_magic;
    std::optional<ElementRanks>        rank_element;
    std::optional<StatusRanks>         rank_status;
};

struct Combat
{
    SkillType             skill;
    std::optional<uint16> delay;
    std::optional<uint16> dmg_mult;
};

struct SpawnWindow
{
    std::optional<uint8> start;
    std::optional<uint8> end;
};

struct Spawn
{
    std::optional<uint32>      respawn;
    SpawnTypes                 type;
    std::optional<SpawnWindow> window;
};

struct Behaviors
{
    BehaviorFlags       flags;
    std::optional<bool> aggressive;
    std::optional<bool> links;
    std::optional<bool> true_detection;
};

struct MobAttributes
{
    std::optional<shared::Render> render;
    std::optional<Behaviors>      behaviors;
    std::optional<Spawn>          spawn;
    std::optional<Combat>         combat;
    Jobs                          jobs;
    Element                       element;
    std::optional<StatRanks>      stats;
    DetectFlags                   detects;
    std::optional<uint8>          speed;
    std::optional<uint8>          animation_speed;
    std::optional<bool>           charmable;
    std::optional<Resists>        resists;
    Mods                          mods;
    MobMods                       mob_mods;
};

} // namespace xi::data::shared

template <>
struct glz::meta<xi::data::shared::StatRanks>
{
    using T                                  = xi::data::shared::StatRanks;
    static constexpr std::string_view name   = "stat_ranks";
    static constexpr auto             modify = glz::object("int", &T::intelligence);
};

template <>
struct glz::json_schema<xi::data::shared::MagicDamageTaken>
{
    glz::schema all{ .description = "Applies on top of every element.", .minimum = -10000L, .maximum = 20000L };
};

template <>
struct glz::json_schema<xi::data::shared::Resists>
{
    glz::schema immune_status{
        .description = "Statuses that never land, whatever the resistance rank says.",
        .uniqueItems = true,
    };
    glz::schema dmg_physical{ .description = "Physical damage taken, by weapon type, in hundredths of a percent: 0 leaves it alone, -2500 takes a quarter less, 2500 takes a quarter more." };
    glz::schema dmg_magic{ .description = "Magic damage taken, by element, on the same hundredths-of-a-percent scale as dmg_physical." };
    glz::schema rank_element{ .description = "Resistance to each element. Higher resists more." };
    glz::schema rank_status{ .description = "Resistance to each status. Higher resists more." };
};

template <>
struct glz::json_schema<xi::data::shared::Combat>
{
    glz::schema skill{ .description = "Weapon skill type. Defaults to none." };
    glz::schema delay{ .description = "Attack delay. Defaults to 240." };
    glz::schema dmg_mult{ .description = "Base damage multiplier as a percentage. Defaults to 100." };
};

template <>
struct glz::json_schema<xi::data::shared::SpawnWindow>
{
    glz::schema start{ .description = "Vana'diel hour the mob starts spawning.", .minimum = 0L, .maximum = 23L };
    glz::schema end{ .description = "Vana'diel hour it stops.", .minimum = 0L, .maximum = 23L };
};

template <>
struct glz::json_schema<xi::data::shared::Spawn>
{
    glz::schema respawn{ .description = "Seconds before respawning. Defaults to 0." };
    glz::schema type{ .description = "Conditions under which it spawns. Defaults to normal.", .uniqueItems = true };
    glz::schema window{ .description = "Vana'diel hours it may spawn between. Omitted means any hour." };
};

template <>
struct glz::json_schema<xi::data::shared::Behaviors>
{
    glz::schema flags{
        .description = "Combat behaviour switches such as no_turn or raisable. An override replaces the whole list rather than adding to it.",
        .uniqueItems = true,
    };
    glz::schema aggressive{ .description = "Whether it aggroes players on sight. Defaults to false." };
    glz::schema links{ .description = "Whether it links with others of its kind. Defaults to false." };
    glz::schema true_detection{ .description = "Whether it sees through sneak and invisible. Defaults to false." };
};

template <>
struct glz::meta<xi::data::shared::MobAttributes>
{
    static constexpr std::string_view name = "mob_attributes";
};

template <>
struct glz::json_schema<xi::data::shared::StatRanks>
{
    glz::schema hp{ .description = "Flat HP, replacing what the level and job would derive. Defaults to 0, meaning derive it." };
    glz::schema mp{ .description = "Flat MP, replacing what the level and job would derive. Defaults to 0, meaning derive it." };
};

template <>
struct glz::json_schema<xi::data::shared::MobAttributes>
{
    glz::schema render{ .description = "How it is drawn and presented to the client." };
    glz::schema behaviors{ .description = "How it reacts to players." };
    glz::schema spawn{ .description = "When and how often it spawns." };
    glz::schema jobs{ .description = "Main and support job, in that order. Always written as a pair, so setting one restates the other." };
    glz::schema combat{ .description = "Weapon skill, delay and damage multiplier." };
    glz::schema element{ .description = "Elemental affinity. Defaults to none." };
    glz::schema stats{ .description = "Flat HP and MP plus a rank per stat, a to g, where a is best. Everything defaults to c except attack and accuracy, which default to a and only understand a to e." };
    glz::schema detects{
        .description = "How it notices players. Defaults to an empty list, and an override replaces the whole list rather than adding to it.",
        .uniqueItems = true,
    };
    glz::schema animation_speed{
        .description = "Animation speed. Falls back to speed when unset.",
        .minimum     = 0L,
        .maximum     = 255L,
    };
    glz::schema speed{
        .description = "Movement speed. Defaults to 40, and 0 is immobile.",
        .minimum     = 0L,
        .maximum     = 255L,
    };
    glz::schema charmable{ .description = "Whether it can be charmed. Defaults to false, and is forced off for notorious, event, fished and battlefield mobs whatever this says." };
    glz::schema resists{ .description = "Resistances, entry by entry. Each value replaces the inherited one rather than adding to it." };
    glz::schema mods{ .description = "Modifiers keyed by mod.yaml name, entry by entry, added on top of what the entity already has." };
    glz::schema mob_mods{ .description = "Mob modifiers keyed by mob_mod.yaml name, entry by entry." };
};
