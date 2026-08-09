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

#include "data/datasets/merits/dataset.h"

#include "data/datasets/merits/yaml.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <algorithm>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

namespace xi::data::datasets::merits
{

namespace
{

constexpr uint16 kCategoryStride = 64; // ids are a category base plus an even offset

constexpr auto meritableJob(const xi::Job job) -> bool
{
    return job != xi::Job::NONE && job != xi::Job::MON;
}

// every job that can hold merits
auto allJobs() -> const std::vector<xi::Job>&
{
    static const auto jobs = []
    {
        std::vector<xi::Job> all;
        for (const auto& [name, job] : EnumTraits<xi::Job>::kEntries)
        {
            if (meritableJob(job))
            {
                all.emplace_back(job);
            }
        }

        return all;
    }();

    return jobs;
}

auto resolveSkills(const std::optional<wire::SkillList>& skills, const std::string_view name) -> std::vector<xi::SkillType>
{
    std::vector<xi::SkillType> resolved;
    if (!skills)
    {
        return resolved;
    }

    for (const auto& token : *skills)
    {
        const auto skill = yaml::resolveEnum(token);
        if (std::ranges::contains(resolved, skill))
        {
            throw std::runtime_error(fmt::format("merit '{}' lists skill '{}' twice", name, token.Value));
        }

        resolved.emplace_back(skill);
    }

    return resolved;
}

// a merit's own job list wins, then its category's, then every job
auto resolveJobs(const std::optional<wire::JobList>& merit,
                 const std::optional<wire::JobList>& category,
                 const std::string_view              name) -> std::vector<xi::Job>
{
    const auto& tokens = [&]() -> const std::optional<wire::JobList>&
    {
        if (merit)
        {
            return merit;
        }

        return category;
    }();

    if (!tokens)
    {
        return allJobs();
    }

    std::vector<xi::Job> resolved;
    for (const auto& token : *tokens)
    {
        const auto job = yaml::resolveEnum(token);
        if (!meritableJob(job))
        {
            throw std::runtime_error(fmt::format("merit '{}' lists job '{}', which cannot hold merits", name, token.Value));
        }

        if (std::ranges::contains(resolved, job))
        {
            throw std::runtime_error(fmt::format("merit '{}' lists job '{}' twice", name, token.Value));
        }

        resolved.emplace_back(job);
    }

    return resolved;
}

} // namespace

auto Dataset::decode(const std::string_view text) -> Records
{
    const auto& document = yaml::read<YamlDocument>(text);
    const auto& source   = document.merits;

    Records records;

    // expanded across every level so callers cannot index out of range
    if (source.level_caps.empty() || source.level_caps.front().level != 0)
    {
        throw std::runtime_error("level_caps must open with a level 0 entry");
    }

    for (std::size_t i = 0; i < source.level_caps.size(); ++i)
    {
        const auto& entry = source.level_caps[i];
        if (i > 0 && entry.level <= source.level_caps[i - 1].level)
        {
            throw std::runtime_error(fmt::format("level_caps entry for level {} is out of order", entry.level));
        }

        std::size_t next = records.LevelCaps.size();
        if (i + 1 < source.level_caps.size())
        {
            next = source.level_caps[i + 1].level;
        }

        for (std::size_t level = entry.level; level < next; ++level)
        {
            records.LevelCaps[level] = entry.cap;
        }
    }

    for (const auto& [categoryName, category] : source.categories)
    {
        yaml::verifyNamedMapEntry<xi::MeritCategory>(categoryName, category.id);

        if (category.id % kCategoryStride != 0)
        {
            throw std::runtime_error(fmt::format("category '{}' id {:#06x} is not a multiple of {}",
                                                 categoryName,
                                                 category.id,
                                                 kCategoryStride));
        }

        for (const auto& [meritName, merit] : category.merits)
        {
            yaml::verifyNamedMapEntry<xi::Merit>(meritName, merit.id);

            if (merit.id - merit.id % kCategoryStride != category.id || merit.id % 2 != 0)
            {
                throw std::runtime_error(fmt::format("merit '{}' id {:#06x} is not an even offset inside category '{}' ({:#06x})",
                                                     meritName,
                                                     merit.id,
                                                     categoryName,
                                                     category.id));
            }

            const auto costs = source.upgrade_costs.find(merit.upgrade_cost);
            if (costs == source.upgrade_costs.end())
            {
                throw std::runtime_error(fmt::format("merit '{}' references unknown upgrade cost table '{}'",
                                                     meritName,
                                                     merit.upgrade_cost));
            }

            if (costs->second.empty())
            {
                throw std::runtime_error(fmt::format("upgrade cost table '{}' is empty", merit.upgrade_cost));
            }

            // the cost table sizes the merit unless it caps itself lower
            const auto maxUpgrades = merit.max_upgrades.value_or(static_cast<uint8>(costs->second.size()));
            if (maxUpgrades > costs->second.size())
            {
                throw std::runtime_error(fmt::format("merit '{}' allows {} upgrades, but '{}' only prices {}",
                                                     meritName,
                                                     maxUpgrades,
                                                     merit.upgrade_cost,
                                                     costs->second.size()));
            }

            records.Entries.emplace_back(MeritData{
                .Id           = static_cast<xi::Merit>(merit.id),
                .Category     = static_cast<xi::MeritCategory>(category.id),
                .Value        = merit.value,
                .MaxUpgrades  = maxUpgrades,
                .Jobs         = resolveJobs(merit.jobs, category.jobs, meritName),
                .Skills       = resolveSkills(merit.skills, meritName),
                .UpgradeCosts = costs->second,
                .Spell        = merit.spell.value_or(std::string{}),
                .WeaponSkill  = merit.weapon_skill.value_or(std::string{}),
            });
        }

        records.Categories.emplace_back(MeritCategoryData{
            .Id          = static_cast<xi::MeritCategory>(category.id),
            .MaxUpgrades = category.max_upgrades,
        });
    }

    std::ranges::sort(records.Entries, {}, &MeritData::Id);
    std::ranges::sort(records.Categories, {}, &MeritCategoryData::Id);

    // sorting put equal ids side by side, so a duplicate is an adjacent pair
    if (std::ranges::adjacent_find(records.Categories, {}, &MeritCategoryData::Id) != records.Categories.end())
    {
        throw std::runtime_error("two categories share one id");
    }

    if (std::ranges::adjacent_find(records.Entries, {}, &MeritData::Id) != records.Entries.end())
    {
        throw std::runtime_error("two merits share one id");
    }

    // a category's merits sit together in Entries, but their ids may have gaps
    uint16 index = 0;
    for (auto& category : records.Categories)
    {
        category.Offset = index;
        while (index < records.Entries.size() && records.Entries[index].Category == category.Id)
        {
            ++index;
        }

        category.Count = static_cast<uint8>(index - category.Offset);
    }

    if (index != records.Entries.size())
    {
        throw std::runtime_error("merits left uncovered by their category");
    }

    // a skill can only take its bonus from a single merit
    for (const auto& entry : records.Entries)
    {
        for (const auto skill : entry.Skills)
        {
            const auto [it, inserted] = records.MeritBySkill.try_emplace(skill, entry.Id);
            if (!inserted)
            {
                throw std::runtime_error(fmt::format("skill '{}' is claimed by merits {:#06x} and {:#06x}",
                                                     EnumTraits<xi::SkillType>::toName(skill),
                                                     std::to_underlying(it->second),
                                                     std::to_underlying(entry.Id)));
            }
        }
    }

    return records;
}

} // namespace xi::data::datasets::merits
