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

#include <span>
#include <string>
#include <string_view>

namespace xi::data
{

// Apply module YAML as RFC 7386 merge patches over the core document.
auto mergeYaml(std::string_view core, std::span<const std::string> modules) -> std::string;

auto loadMergedYaml(std::string_view corePath, std::span<const std::string> modulePaths) -> std::string;

} // namespace xi::data
