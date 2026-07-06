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

#include "common/logging.h"

#include <common/types/hash_map.h>

#include "data/all.h" // Automatically generated manifest with every struct/populators
#include "data/backends/yaml.h"
#include "utils/moduleutils.h"

#include <chrono>
#include <fmt/format.h>
#include <string_view>

namespace xi::data
{

// Load `data/<path><B::kExtension>` dataset.
// Enabled modules with matching filenames get loaded and deep merged into the dataset
template <class T, NodeBackend B>
auto loadDataSet(std::string_view dataPath) -> HashMap<decltype(T::Id), T>
{
    const auto start    = std::chrono::steady_clock::now();
    const auto corePath = fmt::format("data/{}{}", dataPath, B::kExtension);
    const auto modules  = moduleutils::GetDataModules(dataPath, B::kExtension); // Collect all module files matching EXACTLY the same dataPath
    auto       result   = loadAllOf<T, B>(corePath, modules);                   // Load main dataset with modules patches applied
    const auto ms       = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - start).count();

    const auto moduleSuffix = modules.empty()
                                  ? std::string{}
                                  : fmt::format("  +{} module{}", modules.size(), modules.size() == 1 ? "" : "s");

    ShowInfoFmt("[data] {} {} entries loaded in {}ms{}",
                dataPath,
                result.size(),
                ms,
                moduleSuffix);
    return result;
}

} // namespace xi::data

inline auto LoadStatusEffects()
{
    return xi::data::loadDataSet<xi::data::StatusEffectData, xi::data::backends::YAMLBackend>("status_effects");
}
