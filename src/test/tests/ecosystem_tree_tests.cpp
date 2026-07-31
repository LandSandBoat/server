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

// Inheritance rules for data/ecosystem.yaml.

#include "map/data/backends/yaml.h"
#include "map/data/loader.h"
#include "map/utils/mobutils.h"

#include <catch2/catch_test_macros.hpp>

#include <string>

namespace
{

using Backend = xi::data::backends::YAMLBackend;
using Node    = xi::data::Node<Backend>;

// Every species in the file, resolved through LoadSpeciesData.
auto species()
{
    static const auto loaded = []
    {
        mobutils::LoadSpeciesData();

        HashMap<xi::Species, mobutils::SpeciesInfo> flat;
        for (const auto& [ecosystemId, ecosystem] : LoadEcosystem())
        {
            for (const auto& [familyId, family] : ecosystem.Families)
            {
                for (const auto& [speciesId, _] : family.Species)
                {
                    flat.try_emplace(speciesId, mobutils::GetSpeciesData(static_cast<uint16>(speciesId)));
                }
            }
        }

        return flat;
    }();

    return &loaded;
}

} // namespace

TEST_CASE("ecosystem tree: the file loads", "[data][ecosystem]")
{
    REQUIRE(!species()->empty());
}

TEST_CASE("ecosystem tree: a species inherits what it does not write", "[data][ecosystem]")
{
    // gold_flan (6) writes nothing but its id; every value below is the flan family's.
    const auto it = species()->find(xi::Species::GoldFlan);
    REQUIRE(it != species()->end());

    const auto& goldFlan = it->second;
    CHECK(goldFlan.Ecosystem == xi::Ecosystem::Amorph);
    CHECK(goldFlan.Family == xi::Family::Flan);
    CHECK(goldFlan.MobAttributes.Element == xi::Element::Water);
    CHECK(goldFlan.MobAttributes.Speed == 32);

    // The family sets str/dex/vit/agi/mnd; the rest stay default `c`.
    CHECK(goldFlan.MobAttributes.Stats.Str == xi::StatRank::E);
    CHECK(goldFlan.MobAttributes.Stats.Vit == xi::StatRank::D);
    CHECK(goldFlan.MobAttributes.Stats.Int == xi::StatRank::C);
    CHECK(goldFlan.MobAttributes.Stats.Eva == xi::StatRank::C);
}

TEST_CASE("ecosystem tree: unwritten fields fall back to the schema default", "[data][ecosystem]")
{
    // Nothing in the acuex chain writes speed or charmable.
    const auto it = species()->find(xi::Species::Acuex);
    REQUIRE(it != species()->end());

    CHECK(it->second.MobAttributes.Speed == 40);
    CHECK(it->second.MobAttributes.Charmable == false);
}

TEST_CASE("ecosystem tree: every species knows the family it sits under", "[data][ecosystem]")
{
    for (const auto& [id, data] : *species())
    {
        INFO("speciesID " << static_cast<uint16>(id));

        // Family ids start at 1, so a zero means the tree was not walked.
        CHECK(static_cast<uint16>(data.Family) != 0);
    }
}

TEST_CASE("ecosystem tree: a partial stats block inherits its siblings", "[data][ecosystem]")
{
    Backend::Tree family{ std::string{ R"(
stats:
  str: e
  vit: d
)" } };
    Backend::Tree lone{ std::string{ R"(
stats:
  vit: a
)" } };

    xi::data::MobAttributesData resolved{};
    xi::data::applyOverrides(resolved, populate(Node{ family.root() }, std::type_identity<xi::data::MobAttributesOverrides>{}));
    xi::data::applyOverrides(resolved, populate(Node{ lone.root() }, std::type_identity<xi::data::MobAttributesOverrides>{}));

    CHECK(resolved.Stats.Vit == xi::StatRank::A); // set by the species
    CHECK(resolved.Stats.Str == xi::StatRank::E); // inherited, not reset by the partial map
    CHECK(resolved.Stats.Agi == xi::StatRank::C); // neither level writes it
}

TEST_CASE("ecosystem tree: a level records only what it wrote", "[data][ecosystem]")
{
    Backend::Tree level{ std::string{ R"(
speed: 32
stats:
  vit: a
)" } };

    const auto wrote = populate(Node{ level.root() }, std::type_identity<xi::data::MobAttributesOverrides>{});

    CHECK(wrote.Speed == 32);
    CHECK(!wrote.Charmable.has_value()); // absent, not `false`
    REQUIRE(wrote.Stats.has_value());
    CHECK(!wrote.Stats->Str.has_value());
}
