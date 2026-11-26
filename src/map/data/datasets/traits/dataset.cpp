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

#include "data/datasets/traits/dataset.h"

#include "data/datasets/traits/yaml.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <algorithm>
#include <ranges>
#include <set>
#include <stdexcept>
#include <string>
#include <tuple>
#include <utility>
#include <variant>
#include <vector>

namespace xi::data::datasets::traits
{

namespace
{

constexpr std::size_t kTraitMaskBits = 18 * 8; // CCharEntity::m_TraitList, sent in 0x0AC

auto resolveMods(const wire::Mods& mods) -> std::vector<std::pair<xi::Mod, int16>>
{
    std::vector<std::pair<xi::Mod, int16>> resolved;
    for (const auto& [mod, value] : yaml::resolveKeys(std::optional{ mods }))
    {
        resolved.emplace_back(mod, value);
    }

    std::ranges::sort(resolved);
    return resolved;
}

auto resolveJobRank(const wire::JobRankEntry& entry) -> wire::JobRank
{
    if (const auto* level = std::get_if<uint8>(&entry))
    {
        return wire::JobRank{ .level = *level };
    }

    return std::get<wire::JobRank>(entry);
}

} // namespace

auto Dataset::decode(const std::string_view text) -> Records
{
    const auto document = yaml::read<YamlDocument>(text);

    Records records;

    for (const auto& [name, trait] : document.traits)
    {
        yaml::verifyNamedMapEntry<xi::Trait>(name, trait.id);

        if (trait.id >= kTraitMaskBits)
        {
            throw std::runtime_error(fmt::format("trait '{}' id {} does not fit the {}-bit trait mask", name, trait.id, kTraitMaskBits));
        }

        std::set<uint8> usedRanks;
        for (const auto& [job, ranks] : yaml::resolveKeys(trait.jobs))
        {
            const auto jobName = EnumTraits<xi::Job>::toName(job);
            if (job == xi::Job::NONE)
            {
                throw std::runtime_error(fmt::format("trait '{}' lists job '{}'", name, jobName));
            }

            for (const auto& [rank, source] : ranks)
            {
                const auto entry = resolveJobRank(source);
                usedRanks.insert(rank);

                // blueutils marks blue magic traits with level 0
                if (entry.level == 0)
                {
                    throw std::runtime_error(fmt::format("trait '{}' job '{}' has a rank at level 0", name, jobName));
                }

                // a trait with no ranks has its effect in code or scripts
                std::vector<std::pair<xi::Mod, int16>> mods{ { xi::Mod::NONE, 0 } };
                if (trait.ranks)
                {
                    const auto rankMods = trait.ranks->find(rank);
                    if (rankMods == trait.ranks->end())
                    {
                        throw std::runtime_error(fmt::format("trait '{}' job '{}' rank {} has no entry under ranks", name, jobName, rank));
                    }

                    mods = resolveMods(rankMods->second);
                    if (mods.empty())
                    {
                        mods.emplace_back(xi::Mod::NONE, 0);
                    }
                }

                for (const auto& [mod, value] : mods)
                {
                    records.emplace_back(TraitData{
                        .Id      = static_cast<xi::Trait>(trait.id),
                        .Job     = job,
                        .Level   = entry.level,
                        .Rank    = rank,
                        .Mod     = mod,
                        .Value   = value,
                        .Merit   = yaml::resolveEnum(trait.merit),
                        .Content = yaml::resolveEnum(entry.content),
                    });
                }
            }
        }

        if (trait.ranks)
        {
            for (const auto& rank : *trait.ranks | std::views::keys)
            {
                if (!usedRanks.contains(rank))
                {
                    throw std::runtime_error(fmt::format("trait '{}' rank {} is not given to any job", name, rank));
                }
            }
        }
    }

    // battleutils::AddTraits keeps the first rank it meets, so higher ranks come first
    std::ranges::sort(records,
                      {},
                      [](const TraitData& entry)
                      {
                          return std::tuple{ entry.Job, entry.Id, -static_cast<int>(entry.Rank), entry.Mod };
                      });

    return records;
}

} // namespace xi::data::datasets::traits
