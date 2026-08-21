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
#include "data/shared_types/mob_attributes/yaml.h"
#include "data/yaml/schema_annotations.h"

#include <glaze/glaze.hpp>

#include <map>
#include <optional>
#include <string>

namespace xi::data::datasets::ecosystems::wire
{

struct Species
{
    uint16                               id{};
    std::optional<shared::MobAttributes> attributes;
};

struct Family
{
    uint16                                        id{};
    std::optional<shared::MobAttributes>          attributes;
    std::optional<std::map<std::string, Species>> species;
};

struct Ecosystem
{
    uint8                                        id{};
    std::optional<shared::MobAttributes>         attributes;
    std::optional<std::map<std::string, Family>> families;
};

struct Document
{
    std::map<std::string, Ecosystem> ecosystems;

    using YamlRoot = yaml::DatasetRoot<&Document::ecosystems>;
};

} // namespace xi::data::datasets::ecosystems::wire

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
