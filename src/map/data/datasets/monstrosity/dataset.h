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
#include "common/types/maybe.h"
#include "data/enums/ecosystem.h"
#include "data/enums/job.h"
#include "data/enums/mod.h"
#include "data/enums/monstrosity_species.h"
#include "data/enums/monstrosity_variant.h"

#include <cstddef>
#include <map>
#include <string_view>
#include <utility>
#include <vector>

namespace xi::data
{

// dat_skill_id is what the client sends, mob_skill_id is what runs.
struct MonstrosityTpSkill
{
    uint16 datSkillId{};
    uint16 mobSkillId{};
    uint8  unlockLevel{};
    uint16 tpCost{};
};

struct MonstrosityInstinct
{
    uint8                   cost{};
    HashMap<xi::Mod, int16> mods{};
};

struct MonstrositySpecies
{
    uint8                           monstrosityId{};
    xi::Job                         mjob{};
    xi::Job                         sjob{};
    uint8                           size{};
    uint16                          look{};
    xi::Ecosystem                   ecosystem{};
    Maybe<uint16>                   mobSpecies{};
    uint16                          hpScale{};
    std::vector<MonstrosityTpSkill> tpSkills{};
};

// One slot in Teyrnon's shop. Exactly one of species and variant is set.
struct MonstrosityShopSlot
{
    Maybe<xi::MonstrositySpecies>                         species{};
    Maybe<xi::MonstrosityVariant>                         variant{};
    uint16                                                infamy{};
    std::vector<std::pair<xi::MonstrositySpecies, uint8>> requirements{};
};

// Granted once every required family reaches its level. Exactly one of species and variant is set.
struct MonstrosityLevelUnlock
{
    Maybe<xi::MonstrositySpecies>                         species{};
    Maybe<xi::MonstrosityVariant>                         variant{};
    std::vector<std::pair<xi::MonstrositySpecies, uint8>> requirements{};
};

struct Monstrosity
{
    // Keyed by species code, which is what the client and char_monstrosity both use.
    HashMap<uint16, MonstrositySpecies> species{};

    HashMap<uint16, MonstrosityInstinct> instincts{};

    // Level to the exp needed to clear it.
    HashMap<uint8, uint32> expTable{};

    // Keyed by menu page. The index within a page is the menu slot.
    std::map<uint8, std::vector<MonstrosityShopSlot>> teyrnonShop{};

    std::vector<MonstrosityLevelUnlock> levelUnlocks{};

    [[nodiscard]] auto size() const -> std::size_t
    {
        return species.size() + instincts.size() + expTable.size();
    }
};

} // namespace xi::data

namespace xi::data::datasets::monstrosity::wire
{

struct Document;

}

namespace xi::data::datasets::monstrosity
{

struct Dataset
{
    using Records      = Monstrosity;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "monstrosity" };
    static constexpr std::string_view kTitle{ "Monstrosity" };
    static constexpr std::string_view kDescription{ "Monstrosity species, instincts, TP moves, the exp curve and Feretory rules." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::monstrosity
