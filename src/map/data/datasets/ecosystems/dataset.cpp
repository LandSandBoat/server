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

#include "data/datasets/ecosystems/dataset.h"

#include "data/datasets/ecosystems/yaml.h"
#include "data/yaml/enum_keyed_map.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <map>
#include <optional>
#include <stdexcept>
#include <string>
#include <utility>

namespace xi::data::datasets::ecosystems
{

namespace
{

auto convertRanks(const wire::StatRanks& source) -> StatRanksOverrides
{
    const auto resolveOptionalEnum = []<class Enum>(const std::optional<yaml::EnumToken<Enum>>& token) -> std::optional<Enum>
    {
        return token ? std::optional{ yaml::resolveEnum(*token) } : std::nullopt;
    };

    return {
        .Str = resolveOptionalEnum(source.str),
        .Dex = resolveOptionalEnum(source.dex),
        .Vit = resolveOptionalEnum(source.vit),
        .Agi = resolveOptionalEnum(source.agi),
        .Int = resolveOptionalEnum(source.intelligence),
        .Mnd = resolveOptionalEnum(source.mnd),
        .Chr = resolveOptionalEnum(source.chr),
        .Def = resolveOptionalEnum(source.def),
        .Eva = resolveOptionalEnum(source.eva),
        .Att = resolveOptionalEnum(source.att),
        .Acc = resolveOptionalEnum(source.acc),
    };
}

auto convertAttributes(const wire::MobAttributes& source) -> MobAttributesOverrides
{
    MobAttributesOverrides attributes{};
    if (source.element)
    {
        attributes.Element = yaml::resolveEnum(*source.element);
    }

    if (source.stats)
    {
        attributes.Stats = convertRanks(*source.stats);
    }

    if (source.detects)
    {
        attributes.Detects = yaml::resolveFlags(source.detects);
    }

    attributes.Speed     = source.speed;
    attributes.Charmable = source.charmable;
    attributes.Mods      = yaml::resolveKeys(source.mods);
    attributes.MobMods   = yaml::resolveKeys(source.mob_mods);
    return attributes;
}

auto convertAttributes(const std::optional<wire::MobAttributes>& source) -> MobAttributesOverrides
{
    return source ? convertAttributes(*source) : MobAttributesOverrides{};
}

auto convertSpecies(const std::optional<std::map<std::string, wire::Species>>& entries)
    -> HashMap<xi::Species, SpeciesData>
{
    if (!entries)
    {
        return {};
    }

    HashMap<xi::Species, SpeciesData> species;
    for (const auto& [name, source] : *entries)
    {
        yaml::verifyNamedMapEntry<xi::Species>(name, source.id);
        if (source.id == 0)
        {
            throw std::runtime_error(fmt::format("species '{}' declares reserved id 0", name));
        }

        const auto id = static_cast<xi::Species>(source.id);
        if (!species.try_emplace(id, SpeciesData{ id, convertAttributes(source.attributes) }).second)
        {
            throw std::runtime_error(fmt::format("duplicate species id {}", source.id));
        }
    }
    return species;
}

auto convertFamilies(const std::optional<std::map<std::string, wire::Family>>& entries)
    -> HashMap<xi::Family, FamilyData>
{
    if (!entries)
    {
        return {};
    }

    HashMap<xi::Family, FamilyData> families;
    for (const auto& [name, source] : *entries)
    {
        yaml::verifyNamedMapEntry<xi::Family>(name, source.id);
        if (source.id == 0)
        {
            throw std::runtime_error(fmt::format("family '{}' declares reserved id 0", name));
        }

        const auto id = static_cast<xi::Family>(source.id);
        FamilyData family{ id, convertAttributes(source.attributes), convertSpecies(source.species) };
        if (!families.try_emplace(id, std::move(family)).second)
        {
            throw std::runtime_error(fmt::format("duplicate family id {}", source.id));
        }
    }
    return families;
}

} // namespace

auto Dataset::decode(const std::string_view text) -> Records
{
    const auto document = yaml::read<YamlDocument>(text);
    Records    records;

    for (const auto& [name, source] : document.ecosystems)
    {
        yaml::verifyNamedMapEntry<xi::Ecosystem>(name, source.id);
        const auto    id = static_cast<xi::Ecosystem>(source.id);
        EcosystemData ecosystem{ id, convertAttributes(source.attributes), convertFamilies(source.families) };
        if (!records.try_emplace(id, std::move(ecosystem)).second)
        {
            throw std::runtime_error(fmt::format("duplicate ecosystem id {}", source.id));
        }
    }
    return records;
}

} // namespace xi::data::datasets::ecosystems
