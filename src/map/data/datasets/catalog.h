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

#include "data/datasets/animation_locks/dataset.h"
#include "data/datasets/animation_locks/yaml.h"
#include "data/datasets/ecosystems/dataset.h"
#include "data/datasets/ecosystems/yaml.h"
#include "data/datasets/merits/dataset.h"
#include "data/datasets/merits/yaml.h"
#include "data/datasets/status_effects/dataset.h"
#include "data/datasets/status_effects/yaml.h"

#include <concepts>
#include <string_view>
#include <type_traits>

namespace xi::data::datasets
{

template <class T>
concept DatasetDefinition = requires(std::string_view input) {
    typename T::Records;
    typename T::YamlDocument;
    { T::kDataPath } -> std::convertible_to<std::string_view>;
    { T::kTitle } -> std::convertible_to<std::string_view>;
    { T::kDescription } -> std::convertible_to<std::string_view>;
    { T::decode(input) } -> std::same_as<typename T::Records>;
};

template <DatasetDefinition... Entries>
struct DatasetCatalog
{
    template <class Function>
    static void forEach(Function&& function)
    {
        (function(std::type_identity<Entries>{}), ...);
    }
};

using Catalog = DatasetCatalog<animation_locks::Dataset, status_effects::Dataset, ecosystems::Dataset, merits::Dataset>;

} // namespace xi::data::datasets
