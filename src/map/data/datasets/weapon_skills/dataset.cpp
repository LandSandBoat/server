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

#include "data/datasets/weapon_skills/dataset.h"

#include "data/datasets/weapon_skills/yaml.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <algorithm>
#include <stdexcept>
#include <unordered_set>
#include <utility>
#include <variant>

namespace xi::data::datasets::weapon_skills
{

auto Dataset::decode(const std::string_view text) -> Records
{
    const auto document = yaml::read<YamlDocument>(text);

    Records                   records;
    std::unordered_set<uint8> ids;

    for (const auto& [name, source] : document.weapon_skills)
    {
        yaml::verifyNamedMapEntry<xi::WeaponSkill>(name, source.id);
        if (!ids.insert(source.id).second)
        {
            throw std::runtime_error(fmt::format("duplicate weapon skill id {}", source.id));
        }

        WeaponSkillData record{
            .Id          = static_cast<xi::WeaponSkill>(source.id),
            .Name        = name,
            .Skill       = yaml::resolveEnum(source.skill),
            .Level       = source.level.value_or(0),
            .MainJobOnly = source.main_job_only.value_or(false),
            .Unlock      = yaml::resolveEnum(source.unlock),
            .Element     = yaml::resolveEnum(source.element),
            .Animation   = source.animation,
            .Range       = source.range,
            .Target      = shared::toTargets(source.target, fmt::format("{} target", name)),
        };

        for (const auto& job : source.jobs.value_or(std::vector<yaml::EnumToken<xi::Job>>{}))
        {
            record.Jobs.emplace_back(yaml::resolveEnum(job));
        }

        for (const auto& skillchain : source.skillchain.value_or(std::vector<yaml::EnumToken<xi::SkillchainType>>{}))
        {
            record.Skillchain.emplace_back(yaml::resolveEnum(skillchain));
        }

        if (record.Skillchain.size() > 3)
        {
            throw std::runtime_error(fmt::format("{} has more than three skillchain properties", name));
        }

        if (source.aoe)
        {
            record.Aoe = shared::toAoe(*source.aoe);
        }

        records.emplace_back(std::move(record));
    }

    std::ranges::sort(records, {}, &WeaponSkillData::Id);
    return records;
}

} // namespace xi::data::datasets::weapon_skills
