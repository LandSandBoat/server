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

#include "common/enum_traits.h"
#include "common/logging.h"
#include "data/enums/zone.h"

#include <cstdlib>
#include <exception>
#include <filesystem>
#include <fmt/format.h>
#include <fstream>
#include <iterator>
#include <optional>
#include <string>

namespace xi::data
{

inline auto zoneFilePath(const xi::ZoneId zoneId, const std::string_view name) -> std::string
{
    return fmt::format("data/zones/{}/{}.yaml", EnumTraits<xi::ZoneId>::toName(zoneId), name);
}

// Per-zone data file. No file means the zone declares none of this kind.
template <class Dataset>
auto loadZoneFile(const xi::ZoneId zoneId) -> std::optional<typename Dataset::Records>
{
    const auto path = zoneFilePath(zoneId, Dataset::kDataPath);
    if (!std::filesystem::exists(path))
    {
        return std::nullopt;
    }

    try
    {
        std::ifstream     input(path, std::ios::binary);
        const std::string text{ std::istreambuf_iterator<char>(input), std::istreambuf_iterator<char>() };

        auto records = Dataset::decode(text);
        if constexpr (requires { Dataset::verifyZone(records, zoneId); })
        {
            Dataset::verifyZone(records, zoneId);
        }

        return records;
    }
    catch (const std::exception& error)
    {
        // Catch exceptions from workers, report the file and stop deliberately.
        ShowCriticalFmt("{} is not valid: {}", path, error.what());
        std::exit(-1);
    }
}

} // namespace xi::data
