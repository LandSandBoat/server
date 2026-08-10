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
#include "common/types/hash_map.h"
#include "enums/action/category.h"

#include <chrono>
#include <cstddef>
#include <optional>
#include <string_view>

namespace xi::data
{

// animation id -> caster action lock in milliseconds, one table per action category.
struct AnimationLocks
{
    HashMap<uint16, uint16> WeaponSkill{};
    HashMap<uint16, uint16> Dancer{};
    HashMap<uint16, uint16> RuneFencer{};
    HashMap<uint16, uint16> Magic{};
    HashMap<uint16, uint16> Ability{};
    HashMap<uint16, uint16> Item{};
    HashMap<uint16, uint16> MobSkill{};
    HashMap<uint16, uint16> Pet{};

    auto tableFor(const ActionCategory category) const -> const HashMap<uint16, uint16>*
    {
        switch (category)
        {
            case ActionCategory::SkillFinish:
                return &WeaponSkill;
            case ActionCategory::Dancer:
                return &Dancer;
            case ActionCategory::RuneFencer:
                return &RuneFencer;
            case ActionCategory::MagicStart:
            case ActionCategory::MagicFinish:
                return &Magic;
            case ActionCategory::AbilityStart:
            case ActionCategory::AbilityFinish:
                return &Ability;
            case ActionCategory::ItemStart:
            case ActionCategory::ItemFinish:
                return &Item;
            case ActionCategory::SkillStart:
            case ActionCategory::MobSkillFinish:
                return &MobSkill;
            case ActionCategory::PetSkillFinish:
                return &Pet;
            default:
                return nullptr;
        }
    }

    auto find(const ActionCategory category, const uint16 animationId) const -> std::optional<std::chrono::milliseconds>
    {
        const auto* table = tableFor(category);
        if (table == nullptr)
        {
            return std::nullopt;
        }

        const auto lock = table->find(animationId);
        return lock == table->end() ? std::nullopt : std::optional{ std::chrono::milliseconds{ lock->second } };
    }

    auto size() const -> std::size_t
    {
        return WeaponSkill.size() + Dancer.size() + RuneFencer.size() + Magic.size() +
               Ability.size() + Item.size() + MobSkill.size() + Pet.size();
    }
};

} // namespace xi::data

namespace xi::data::datasets::animation_locks::wire
{

struct Document;

}

namespace xi::data::datasets::animation_locks
{

struct Dataset
{
    using Records      = AnimationLocks;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "animation_locks" };
    static constexpr std::string_view kTitle{ "Animation Locks" };
    static constexpr std::string_view kDescription{ "Caster action lock per animation id, by action category." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::animation_locks
