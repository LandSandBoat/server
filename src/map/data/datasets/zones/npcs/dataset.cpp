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

#include "data/datasets/zones/npcs/dataset.h"

#include "data/datasets/zones/npcs/yaml.h"
#include "data/shared_types/look.h"
#include "data/shared_types/position.h"
#include "data/yaml/read.h"

#include <fmt/format.h>

#include <array>
#include <string>
#include <string_view>

namespace xi::data::datasets::zones::npcs
{

namespace
{

constexpr uint8  kDefaultSpeed          = 50;
constexpr uint8  kDefaultAnimationSpeed = 50;
constexpr auto   kDefaultStatus         = xi::Status::Disappear;
constexpr uint32 kDefaultEntityFlags    = 0x003;

} // namespace

auto Dataset::decode(const std::string_view text) -> Records
{
    const auto document = yaml::read<YamlDocument>(text);

    Records records;
    records.reserve(document.npcs.size());

    for (const auto& [id, source] : document.npcs)
    {
        const auto look = [&]() -> std::array<uint16, 10>
        {
            if (!source.render.look)
            {
                return {};
            }

            return shared::toLookFields(*source.render.look, std::to_string(id));
        }();

        records.emplace_back(NpcData{
            .Id              = id,
            .ActIndex        = static_cast<uint16>(id & 0xFFF),
            .Script          = source.script.value_or(std::string{}),
            .DisplayName     = source.display_name.value_or(std::string{}),
            .Position        = shared::toPosition(source.at, fmt::format("npc {}", id), source.render.moving.value_or(0)),
            .Look            = look,
            .LookAt          = source.look_at.value_or(0),
            .Animation       = yaml::resolveEnum(source.render.animation, xi::Animation::None),
            .AnimationSub    = source.render.animation_sub.value_or(0),
            .Status          = yaml::resolveEnum(source.status, kDefaultStatus),
            .NameVis         = static_cast<xi::NameVis>(source.render.name_vis.value_or(0)),
            .EntityFlags     = static_cast<xi::EntityFlags>(source.render.entity_flags.value_or(kDefaultEntityFlags)),
            .NamePrefix      = source.render.name_prefix.value_or(0),
            .DoorId          = source.render.door_id,
            .ModelSize       = source.render.model_size.value_or(0),
            .ModelHitboxSize = source.render.hitbox.value_or(0),
            .Speed           = source.speed.value_or(kDefaultSpeed),
            .AnimationSpeed  = source.animation_speed.value_or(kDefaultAnimationSpeed),
            .Widescan        = source.widescan.value_or(false),
            .Content         = yaml::resolveEnum(source.content),
        });
    }

    return records;
}

void Dataset::verifyZone(const Records& records, const xi::ZoneId zoneId)
{
    for (const auto& npc : records)
    {
        const auto owner = (npc.Id >> 12) & 0xFFF;
        if (owner != static_cast<uint32>(zoneId))
        {
            throw std::runtime_error(fmt::format("npc 0x{:08X} belongs to zone {}, not {}", npc.Id, owner, static_cast<uint32>(zoneId)));
        }
    }
}

} // namespace xi::data::datasets::zones::npcs
