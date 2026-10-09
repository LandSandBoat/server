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

#include "data/datasets/monstrosity/dataset.h"

#include "data/datasets/monstrosity/yaml.h"
#include "data/yaml/enum_keyed_map.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <stdexcept>
#include <utility>

namespace xi::data::datasets::monstrosity
{

namespace
{

constexpr auto kDefaultHPScale = uint16{ 240 };

// Shop slots and level unlocks name a species or variant behind family level requirements.
template <typename Record, typename Source>
void resolveUnlock(Record& record, const Source& source)
{
    if (source.species.has_value())
    {
        record.species = yaml::resolveEnum(source.species.value());
    }

    if (source.variant.has_value())
    {
        record.variant = yaml::resolveEnum(source.variant.value());
    }

    for (const auto& [family, level] : yaml::resolveKeys(source.requirements))
    {
        record.requirements.emplace_back(family, level);
    }
}

} // namespace

auto Dataset::decode(const std::string_view text) -> Records
{
    auto source = yaml::read<YamlDocument>(text).monstrosity;

    auto records = Monstrosity{};

    records.expTable = std::move(source.exp_table);
    for (uint8 level = 1; level < 100; ++level)
    {
        // A missing level would read as 0 exp needed and level up on every kill.
        if (const auto entry = records.expTable.find(level); entry == records.expTable.end() || entry->second == 0)
        {
            throw std::runtime_error(fmt::format("exp_table is missing level {}", level));
        }
    }

    for (auto& [page, slots] : source.teyrnon_shop)
    {
        auto& resolved = records.teyrnonShop[page];
        for (auto& slot : slots)
        {
            if (slot.species.has_value() == slot.variant.has_value())
            {
                throw std::runtime_error(fmt::format("teyrnon_shop page {} slot {} must set exactly one of species and variant", page, resolved.size()));
            }

            auto record = MonstrosityShopSlot{
                .infamy = slot.infamy,
            };

            resolveUnlock(record, slot);

            resolved.push_back(std::move(record));
        }
    }

    for (auto& unlock : source.level_unlocks)
    {
        if (unlock.species.has_value() == unlock.variant.has_value() || !unlock.requirements.has_value())
        {
            throw std::runtime_error(fmt::format("level_unlocks entry {} must set requirements and exactly one of species and variant", records.levelUnlocks.size()));
        }

        auto record = MonstrosityLevelUnlock{};

        resolveUnlock(record, unlock);

        records.levelUnlocks.push_back(std::move(record));
    }

    for (const auto& [key, instinct] : source.instincts)
    {
        if (records.instincts.contains(instinct.id))
        {
            throw std::runtime_error(fmt::format("instinct '{}' reuses id {}", key, instinct.id));
        }

        records.instincts.emplace(
            instinct.id,
            MonstrosityInstinct{
                .cost = instinct.cost,
                .mods = yaml::resolveKeys(instinct.mods),
            });
    }

    for (auto& [key, species] : source.species)
    {
        if (records.species.contains(species.species_code))
        {
            throw std::runtime_error(fmt::format("species '{}' reuses species code {}", key, species.species_code));
        }

        auto record = MonstrositySpecies{
            .monstrosityId = static_cast<uint8>(yaml::resolveEnum(species.family)),
            .mjob          = yaml::resolveEnum(species.mjob),
            .sjob          = yaml::resolveEnum(species.sjob),
            .size          = species.size,
            .look          = species.look,
            .ecosystem     = yaml::resolveEnum(species.ecosystem),
            .mobSpecies    = species.mob_species,
            .hpScale       = species.hp_scale.value_or(kDefaultHPScale),
        };

        if (species.tp_skills.has_value())
        {
            for (auto& skill : species.tp_skills.value())
            {
                // Disabled rows are unverified.
                if (!skill.enabled)
                {
                    continue;
                }

                record.tpSkills.push_back(MonstrosityTpSkill{
                    .datSkillId  = skill.dat_skill_id,
                    .mobSkillId  = skill.mob_skill_id,
                    .unlockLevel = skill.unlock_level,
                    .tpCost      = skill.tp_cost,
                });
            }
        }

        records.species.emplace(species.species_code, std::move(record));
    }

    return records;
}

} // namespace xi::data::datasets::monstrosity
