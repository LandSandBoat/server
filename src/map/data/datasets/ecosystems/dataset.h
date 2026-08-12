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
#include "data/enums/detects.h"
#include "data/enums/ecosystem.h"
#include "data/enums/element.h"
#include "data/enums/family.h"
#include "data/enums/mob_mod.h"
#include "data/enums/mod.h"
#include "data/enums/species.h"
#include "data/enums/stat_rank.h"

#include <optional>
#include <string_view>

namespace xi::data
{

struct StatRanksData
{
    xi::StatRank Str{ xi::StatRank::C };
    xi::StatRank Dex{ xi::StatRank::C };
    xi::StatRank Vit{ xi::StatRank::C };
    xi::StatRank Agi{ xi::StatRank::C };
    xi::StatRank Int{ xi::StatRank::C };
    xi::StatRank Mnd{ xi::StatRank::C };
    xi::StatRank Chr{ xi::StatRank::C };
    xi::StatRank Def{ xi::StatRank::C };
    xi::StatRank Eva{ xi::StatRank::C };
    xi::StatRank Att{ xi::StatRank::A };
    xi::StatRank Acc{ xi::StatRank::A };
};

struct MobAttributesData
{
    xi::Element                Element{ xi::Element::None };
    StatRanksData              Stats{};
    xi::Detects                Detects{};
    uint8                      Speed{ 40 };
    bool                       Charmable{ false };
    HashMap<xi::Mod, int16>    Mods{};
    HashMap<xi::MobMod, int16> MobMods{};
};

struct StatRanksOverrides
{
    std::optional<xi::StatRank> Str;
    std::optional<xi::StatRank> Dex;
    std::optional<xi::StatRank> Vit;
    std::optional<xi::StatRank> Agi;
    std::optional<xi::StatRank> Int;
    std::optional<xi::StatRank> Mnd;
    std::optional<xi::StatRank> Chr;
    std::optional<xi::StatRank> Def;
    std::optional<xi::StatRank> Eva;
    std::optional<xi::StatRank> Att;
    std::optional<xi::StatRank> Acc;
};

struct MobAttributesOverrides
{
    std::optional<xi::Element>        Element;
    std::optional<StatRanksOverrides> Stats;
    std::optional<xi::Detects>        Detects;
    std::optional<uint8>              Speed;
    std::optional<bool>               Charmable;

    // Merged key by key, so a child only has to write the mods it changes.
    HashMap<xi::Mod, int16>    Mods{};
    HashMap<xi::MobMod, int16> MobMods{};
};

template <class T>
void applyOverride(T& target, const std::optional<T>& overrideValue)
{
    if (overrideValue)
    {
        target = *overrideValue;
    }
}

inline void applyOverrides(StatRanksData& target, const StatRanksOverrides& overrides)
{
    applyOverride(target.Str, overrides.Str);
    applyOverride(target.Dex, overrides.Dex);
    applyOverride(target.Vit, overrides.Vit);
    applyOverride(target.Agi, overrides.Agi);
    applyOverride(target.Int, overrides.Int);
    applyOverride(target.Mnd, overrides.Mnd);
    applyOverride(target.Chr, overrides.Chr);
    applyOverride(target.Def, overrides.Def);
    applyOverride(target.Eva, overrides.Eva);
    applyOverride(target.Att, overrides.Att);
    applyOverride(target.Acc, overrides.Acc);
}

// Key-by-key merge: what the child writes wins, the rest of the parent's keys stay.
template <class Map>
void mergeKeyedValues(Map& target, const Map& overrides)
{
    for (const auto& [id, value] : overrides)
    {
        target.insert_or_assign(id, value);
    }
}

inline void applyOverrides(MobAttributesData& target, const MobAttributesOverrides& overrides)
{
    applyOverride(target.Element, overrides.Element);
    applyOverride(target.Detects, overrides.Detects);
    applyOverride(target.Speed, overrides.Speed);
    applyOverride(target.Charmable, overrides.Charmable);
    if (overrides.Stats)
    {
        applyOverrides(target.Stats, *overrides.Stats);
    }

    mergeKeyedValues(target.Mods, overrides.Mods);
    mergeKeyedValues(target.MobMods, overrides.MobMods);
}

struct SpeciesData
{
    xi::Species            Id{};
    MobAttributesOverrides MobAttributes{};
};

struct FamilyData
{
    xi::Family                                      Id{};
    MobAttributesOverrides                          MobAttributes{};
    HashMap<decltype(SpeciesData::Id), SpeciesData> Species{};
};

struct EcosystemData
{
    xi::Ecosystem                                 Id{};
    MobAttributesOverrides                        MobAttributes{};
    HashMap<decltype(FamilyData::Id), FamilyData> Families{};
};

using Ecosystems = HashMap<xi::Ecosystem, EcosystemData>;

} // namespace xi::data

namespace xi::data::datasets::ecosystems::wire
{

struct Document;

}

namespace xi::data::datasets::ecosystems
{

struct Dataset
{
    using Records      = Ecosystems;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "ecosystems" };
    static constexpr std::string_view kTitle{ "Ecosystems" };
    static constexpr std::string_view kDescription{ "The ecosystem, family, and species tree with inherited mob attributes at every level." };

    static auto decode(std::string_view text) -> Records;
};

} // namespace xi::data::datasets::ecosystems
