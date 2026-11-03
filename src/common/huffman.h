/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include <span>

// The client's static Huffman coding for game packet payloads. An encoded payload is a flag byte
// (1 = Huffman codes follow, 0 = raw bytes follow) and its size is counted in bits, flag included.

[[nodiscard]] constexpr auto huffman_byte_size(const size_t bits) noexcept -> size_t
{
    return (bits + 7) / 8;
}

// Returns -1 when the tables are missing or truncated.
[[nodiscard]] auto huffman_init() -> int32;

// Encoded size in bytes of `in`, without the flag byte. The client's send queue estimates each packet the same way.
[[nodiscard]] auto huffman_encoded_size(std::span<const uint8> in) -> uint32;

// Equivalent to the client's logic. Returns the bit count including the flag byte, or nothing when even a raw copy doesn't fit.
[[nodiscard]] auto huffman_encode(std::span<const uint8> in, std::span<uint8> out) -> Maybe<uint32>;

// Equivalent to the client's logic. `in` starts at the flag byte. Returns the decoded byte count, or nothing on bad input
// or a full `out`.
[[nodiscard]] auto huffman_decode(std::span<const uint8> in, uint32 bits, std::span<uint8> out) -> Maybe<uint32>;
