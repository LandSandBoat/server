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
#include "common/utils.h"

#include <common/types/maybe.h>

#include <cstddef>
#include <sol/sol.hpp>

namespace Exdata
{

template <size_t N>
auto decodeSignature(const uint8_t (&sig)[N]) -> std::string
{
    const std::string raw(reinterpret_cast<const char*>(sig), N);
    char              decoded[DecodeStringLength] = {};
    DecodeStringSignature(raw, decoded);
    return std::string(decoded);
}

template <size_t N>
void encodeSignature(const std::string& str, uint8_t (&sig)[N])
{
    char encoded[SignatureStringLength] = {};
    EncodeStringSignature(str, encoded);
    std::memcpy(sig, encoded, N);
}

// sol2's get_or is ambiguous when the fallback comes from a bitfield.
template <typename T, typename Table, typename Key>
auto get_or(Table&& tbl, Key&& key, T fallback) -> T
{
    return std::forward<Table>(tbl).template get<Maybe<T>>(std::forward<Key>(key)).value_or(std::move(fallback));
}

template <typename T, typename Proxy>
auto get_or(Proxy&& proxy, T fallback) -> T
{
    return std::forward<Proxy>(proxy).template get<Maybe<T>>().value_or(std::move(fallback));
}

} // namespace Exdata
