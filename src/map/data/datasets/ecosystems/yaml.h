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
#include "data/enums/detects.h"
#include "data/enums/element.h"
#include "data/enums/stat_rank.h"
#include "data/yaml/enum_token.h"
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

#include <map>
#include <optional>
#include <string>
#include <string_view>
#include <vector>

namespace xi::data::datasets::ecosystems::wire
{

struct StatRanks
{
    std::optional<yaml::EnumToken<xi::StatRank>> str;
    std::optional<yaml::EnumToken<xi::StatRank>> dex;
    std::optional<yaml::EnumToken<xi::StatRank>> vit;
    std::optional<yaml::EnumToken<xi::StatRank>> agi;
    std::optional<yaml::EnumToken<xi::StatRank>> intelligence;
    std::optional<yaml::EnumToken<xi::StatRank>> mnd;
    std::optional<yaml::EnumToken<xi::StatRank>> chr;
    std::optional<yaml::EnumToken<xi::StatRank>> def;
    std::optional<yaml::EnumToken<xi::StatRank>> eva;
    std::optional<yaml::EnumToken<xi::StatRank>> att;
    std::optional<yaml::EnumToken<xi::StatRank>> acc;
};

struct MobAttributes
{
    std::optional<yaml::EnumToken<xi::Element>>              element;
    std::optional<StatRanks>                                 stats;
    std::optional<std::vector<yaml::EnumToken<xi::Detects>>> detects;
    std::optional<uint8>                                     speed;
    std::optional<bool>                                      charmable;
};

struct Species
{
    uint16                       id{};
    std::optional<MobAttributes> attributes;
};

struct Family
{
    uint16                                        id{};
    std::optional<MobAttributes>                  attributes;
    std::optional<std::map<std::string, Species>> species;
};

struct Ecosystem
{
    uint8                                        id{};
    std::optional<MobAttributes>                 attributes;
    std::optional<std::map<std::string, Family>> families;
};

struct Document
{
    std::map<std::string, Ecosystem> ecosystems;

    using YamlRoot = yaml::DatasetRoot<&Document::ecosystems>;
};

} // namespace xi::data::datasets::ecosystems::wire

template <>
struct glz::meta<xi::data::datasets::ecosystems::wire::StatRanks>
{
    using T                                  = xi::data::datasets::ecosystems::wire::StatRanks;
    static constexpr std::string_view name   = "stat_ranks";
    static constexpr auto             modify = glz::object("int", &T::intelligence);
};

template <>
struct glz::meta<xi::data::datasets::ecosystems::wire::MobAttributes>
{
    static constexpr std::string_view name = "mob_attributes";
};

template <>
struct glz::json_schema<xi::data::datasets::ecosystems::wire::StatRanks>
{
    glz::schema str{ .description = "Inherits when omitted; defaults to c." };
    glz::schema dex{ .description = "Inherits when omitted; defaults to c." };
    glz::schema vit{ .description = "Inherits when omitted; defaults to c." };
    glz::schema agi{ .description = "Inherits when omitted; defaults to c." };
    glz::schema intelligence{ .description = "Inherits when omitted; defaults to c." };
    glz::schema mnd{ .description = "Inherits when omitted; defaults to c." };
    glz::schema chr{ .description = "Inherits when omitted; defaults to c." };
    glz::schema def{ .description = "Inherits when omitted; defaults to c." };
    glz::schema eva{ .description = "Inherits when omitted; defaults to c." };
    glz::schema att{ .description = "Inherits when omitted; defaults to a." };
    glz::schema acc{ .description = "Inherits when omitted; defaults to a." };
};

template <>
struct glz::json_schema<xi::data::datasets::ecosystems::wire::MobAttributes>
{
    glz::schema element{ .description = "Elemental affinity override. Omitted values inherit; defaults to none." };
    glz::schema stats{ .description = "Stat rank overrides from a-g. Lower is better; attack and accuracy only handle a-e. Omitted ranks inherit." };
    glz::schema detects{
        .description = "Detection mechanisms. Omitted values inherit; defaults to an empty list. Redefine the entire list when overriding.",
        .uniqueItems = true,
    };
    glz::schema speed{
        .description = "Movement and animation speed override. Omitted values inherit; defaults to 40. 0 is immobile.",
        .minimum     = 0L,
        .maximum     = 255L,
    };
    glz::schema charmable{ .description = "Whether the entity can be charmed. Omitted values inherit; defaults to false." };
};

template <>
struct glz::json_schema<xi::data::datasets::ecosystems::wire::Species>
{
    glz::schema id{ .description = "Unique species ID. To be deprecated.", .minimum = 1L, .maximum = 65535L };
    glz::schema attributes{ .description = "Attribute overrides for this species." };
};

template <>
struct glz::json_schema<xi::data::datasets::ecosystems::wire::Family>
{
    glz::schema id{ .description = "Unique family ID. To be deprecated.", .minimum = 1L, .maximum = 65535L };
    glz::schema attributes{ .description = "Attribute overrides inherited by species in this family." };
    glz::schema species{ .description = "Species in this family, keyed by name. Names must be unique across all ecosystems." };
};

template <>
struct glz::json_schema<xi::data::datasets::ecosystems::wire::Ecosystem>
{
    glz::schema id{ .description = "Unique ecosystem ID. To be deprecated.", .minimum = 0L, .maximum = 255L };
    glz::schema attributes{ .description = "Attribute overrides inherited by families in this ecosystem." };
    glz::schema families{ .description = "Families in this ecosystem, keyed by name. Names must be unique across all ecosystems." };
};

template <>
struct glz::json_schema<xi::data::datasets::ecosystems::wire::Document>
{
    glz::schema ecosystems{ .description = "Ecosystems keyed by name." };
};
