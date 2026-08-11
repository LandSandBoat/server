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

#include "map/data/datasets/ecosystems/dataset.h"
#include "map/data/datasets/status_effects/dataset.h"
#include "map/data/yaml/merge.h"

#include <catch2/catch_test_macros.hpp>

#include <string>
#include <vector>

using EcosystemsDataset   = xi::data::datasets::ecosystems::Dataset;
using StatusEffectDataset = xi::data::datasets::status_effects::Dataset;

TEST_CASE("data binding: modules keep sparse-map and list-replacement semantics", "[data][binding]")
{
    const std::string              core = R"(
status_effects:
  sample:
    id: 42
    flags:
      - damage
      - death
    min_duration: 5
)";
    const std::vector<std::string> modules{ R"(
status_effects:
  sample:
    flags:
      - no_cancel
)" };

    const auto  decoded = StatusEffectDataset::decode(xi::data::mergeYaml(core, modules));
    const auto& sample  = decoded.at(42);
    CHECK(sample.MinDuration == 5);
    CHECK(sample.Flags == xi::StatusEffectFlag::NoCancel);

    const std::string              ecosystemsCore = R"(
ecosystems:
  module_ecosystem:
    id: 250
    attributes:
      element: fire
      detects:
        - sight
        - hearing
      speed: 40
)";
    const std::vector<std::string> ecosystemsModules{ R"(
ecosystems:
  module_ecosystem:
    attributes:
      detects:
        - hearing
      speed: 32
)" };

    const auto  ecosystems = EcosystemsDataset::decode(xi::data::mergeYaml(ecosystemsCore, ecosystemsModules));
    const auto& attributes = ecosystems.at(static_cast<xi::Ecosystem>(250)).MobAttributes;
    CHECK(attributes.Element == xi::Element::Fire);
    CHECK(attributes.Detects == xi::Detects::Hearing);
    CHECK(attributes.Speed == 32);
}

TEST_CASE("data binding: runtime decoding is strict", "[data][binding]")
{
    CHECK_THROWS(StatusEffectDataset::decode(R"(
status_effects:
  sample:
    id: 42
    surprise: true
)"));

    CHECK_THROWS(StatusEffectDataset::decode(R"(
status_effects:
  sample:
    name: missing_id
)"));

    CHECK_THROWS(StatusEffectDataset::decode(R"(
status_effects:
  sample:
    id: 42
    element: definitely_not_an_element
)"));

    CHECK_THROWS(StatusEffectDataset::decode(R"(
status_effects:
  ko:
    id: 1
)"));

    CHECK_THROWS(StatusEffectDataset::decode(R"(
status_effects:
  invalid-name:
    id: 42
)"));

    CHECK_THROWS(StatusEffectDataset::decode(R"(
status_effects:
  sample:
    id: 42
    flags:
      - damage
      - damage
)"));

    CHECK_THROWS(EcosystemsDataset::decode(R"(
ecosystems:
  module_ecosystem:
    id: 250
    families:
      module_family:
        id: 0
)"));

    CHECK_THROWS(EcosystemsDataset::decode(R"(
ecosystems:
  module_ecosystem:
    id: 250
    speed: 32
)"));

    CHECK_THROWS(EcosystemsDataset::decode(R"(
ecosystems:
  module_ecosystem:
    id: 250
    attributes:
      stats:
        intelligence: a
)"));
}

TEST_CASE("data binding: explicit null clears optional values", "[data][binding]")
{
    const auto base = StatusEffectDataset::decode(xi::data::mergeYaml(R"(
status_effects:
  sample:
    id: 42
    name: null
    min_duration: null
)",
                                                                      {}));
    CHECK(base.at(42).Name == "sample");
    CHECK(base.at(42).MinDuration == 0);

    const std::vector<std::string> modules{ R"(
status_effects:
  sample:
    min_duration: null
)" };
    const auto                     overlaid = StatusEffectDataset::decode(xi::data::mergeYaml(R"(
status_effects:
  sample:
    id: 42
    min_duration: 5
)",
                                                                                              modules));
    CHECK(overlaid.at(42).MinDuration == 0);

    const std::vector<std::string> ecosystemsModules{ R"(
ecosystems:
  module_ecosystem:
    attributes: null
)" };
    const auto                     ecosystems = EcosystemsDataset::decode(xi::data::mergeYaml(R"(
ecosystems:
  module_ecosystem:
    id: 250
    attributes:
      speed: 32
)",
                                                                                              ecosystemsModules));
    CHECK_FALSE(ecosystems.at(static_cast<xi::Ecosystem>(250)).MobAttributes.Speed.has_value());
}

TEST_CASE("data binding: numeric IDs are authoritative and unique", "[data][binding]")
{
    CHECK_THROWS(StatusEffectDataset::decode(R"(
status_effects:
  first:
    id: 42
  second:
    id: 42
)"));

    const auto ecosystems = EcosystemsDataset::decode(R"(
ecosystems:
  module_defined_name:
    id: 250
    attributes:
      speed: 0
      charmable: false
      element: none
    families:
      another_module_name:
        id: 65000
        species:
          final_module_name:
            id: 64999
            attributes:
              detects:
                - hearing
      second_module_name:
        id: 64998
)");

    const auto  ecosystemId = static_cast<xi::Ecosystem>(250);
    const auto  familyId    = static_cast<xi::Family>(65000);
    const auto  speciesId   = static_cast<xi::Species>(64999);
    const auto& ecosystem   = ecosystems.at(ecosystemId);
    REQUIRE(ecosystem.MobAttributes.Speed.has_value());
    CHECK(*ecosystem.MobAttributes.Speed == 0);
    REQUIRE(ecosystem.MobAttributes.Charmable.has_value());
    CHECK_FALSE(*ecosystem.MobAttributes.Charmable);
    REQUIRE(ecosystem.MobAttributes.Element.has_value());
    CHECK(*ecosystem.MobAttributes.Element == xi::Element::None);
    CHECK(ecosystem.Families.size() == 2);
    CHECK(ecosystem.Families.at(familyId).Species.at(speciesId).MobAttributes.Detects == xi::Detects::Hearing);

    CHECK_THROWS(EcosystemsDataset::decode(R"(
ecosystems:
  first:
    id: 1
  second:
    id: 1
)"));
}

TEST_CASE("data binding: every stat-rank field resolves by name", "[data][binding]")
{
    const auto ecosystems = EcosystemsDataset::decode(R"(
ecosystems:
  module_ecosystem:
    id: 250
    attributes:
      stats:
        str: a
        dex: b
        vit: c
        agi: d
        int: e
        mnd: f
        chr: g
        def: a
        eva: b
        att: c
        acc: d
)");

    const auto& overrides = ecosystems.at(static_cast<xi::Ecosystem>(250)).MobAttributes;
    REQUIRE(overrides.Stats.has_value());
    const auto& ranks = *overrides.Stats;
    CHECK(ranks.Str == xi::StatRank::A);
    CHECK(ranks.Dex == xi::StatRank::B);
    CHECK(ranks.Vit == xi::StatRank::C);
    CHECK(ranks.Agi == xi::StatRank::D);
    CHECK(ranks.Int == xi::StatRank::E);
    CHECK(ranks.Mnd == xi::StatRank::F);
    CHECK(ranks.Chr == xi::StatRank::G);
    CHECK(ranks.Def == xi::StatRank::A);
    CHECK(ranks.Eva == xi::StatRank::B);
    CHECK(ranks.Att == xi::StatRank::C);
    CHECK(ranks.Acc == xi::StatRank::D);
}
