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

#include "protocol/profile/s2c/0x0303_get_file_list.h"

#include "common/cbasetypes.h"
#include "common/types/error_or.h"
#include "common/types/maybe.h"

#include <span>
#include <string>
#include <string_view>
#include <vector>

namespace profile::files
{

constexpr uint32 fileSizeLimit = 0x400000;

auto read(uint32 accountId, const std::string& path) -> ErrorOr<Maybe<std::string>>;
auto write(uint32 accountId, const std::string& path, uint32 offset, std::span<const uint8> data) -> bool; // offset 0 starts over, anything else appends
auto erase(uint32 accountId, const std::string& path) -> bool;
auto list(uint32 accountId, std::string_view directory, uint16 limit) -> Maybe<std::vector<ProfFileInfo>>; // oldest first, names relative to the directory

} // namespace profile::files
