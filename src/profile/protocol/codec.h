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
#include "common/types/maybe.h"

#include <array>
#include <span>
#include <string>
#include <string_view>
#include <vector>

namespace profile
{

using SessionHash = std::array<uint8, 16>;

// sum of little-endian u32 words, a 1-3 byte tail shifted in from the top (sqCalcChecksum)
auto checksum(std::span<const uint8> bytes) -> uint32;

// the 4 characters polcore appends to every IRC line before CRLF
auto lineChecksum(std::string_view line) -> std::string;

// polcore's alphabet, unpadded drops the padding
auto base64Encode(std::span<const uint8> bytes) -> std::string;
auto base64EncodeUnpadded(std::span<const uint8> bytes) -> std::string;
auto base64Decode(std::string_view text) -> Maybe<std::vector<uint8>>;

// polcore's alphabet, input must be whole 5-byte groups
auto base32Encode(std::span<const uint8> bytes) -> std::string;

// "U" + 8 scrambled characters
auto scrambleNick(uint64 polId) -> std::string;

// same as the lobby's: id bits 0-15, and 16-23 in the top byte
auto characterKey(uint32 characterId) -> uint32;
auto characterIdFromKey(uint32 key) -> uint32;

} // namespace profile
