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

#include "data/datasets/status_effects/dataset.h"

#include "data/datasets/status_effects/yaml.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <stdexcept>
#include <utility>

namespace xi::data::datasets::status_effects
{

auto Dataset::decode(const std::string_view text) -> Records
{
    const auto document = yaml::read<YamlDocument>(text);
    Records    records;

    for (const auto& [name, source] : document.status_effects)
    {
        yaml::verifyNamedMapEntry<xi::StatusEffect>(name, source.id);
        StatusEffectData record{
            .Id               = source.id,
            .Name             = source.name.value_or(name),
            .Flags            = yaml::resolveFlags(source.flags),
            .ExclusionGroup   = yaml::resolveEnum(source.exclusion_group),
            .Negative         = yaml::resolveEnum(source.negative),
            .Overwrite        = yaml::resolveEnum(source.overwrite),
            .Block            = yaml::resolveEnum(source.block),
            .Remove           = yaml::resolveEnum(source.remove),
            .Element          = yaml::resolveEnum(source.element),
            .MinDuration      = source.min_duration.value_or(0),
            .SortKey          = source.sort_key.value_or(0),
            .WearOffMessageId = source.wear_off_message_id.value_or(0),
        };

        if (!records.try_emplace(record.Id, std::move(record)).second)
        {
            throw std::runtime_error(fmt::format("duplicate status effect id {}", source.id));
        }
    }
    return records;
}

} // namespace xi::data::datasets::status_effects
