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
#include "data/yaml/merge.h"
#include "utils/moduleutils.h"

#include <chrono>
#include <exception>
#include <fmt/format.h>
#include <string>

namespace xi::data
{

template <class Dataset>
auto loadDataset() -> typename Dataset::Records
{
    const auto dataPath = Dataset::kDataPath;
    const auto start    = std::chrono::steady_clock::now();
    const auto corePath = fmt::format("data/{}.yaml", dataPath);
    const auto modules  = moduleutils::GetDataModules(dataPath, ".yaml");

    try
    {
        auto       result       = Dataset::decode(loadMergedYaml(corePath, modules));
        const auto ms           = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - start).count();
        const auto moduleSuffix = modules.empty()
                                      ? std::string{}
                                      : fmt::format("  +{} module{}", modules.size(), modules.size() == 1 ? "" : "s");
        ShowInfoFmt("[data] {} {} entries loaded in {}ms{}", dataPath, result.size(), ms, moduleSuffix);
        return result;
    }
    catch (const std::exception& error)
    {
        ShowErrorFmt("loadDataset({}) failed: {}", corePath, error.what());
        throw;
    }
}

} // namespace xi::data
