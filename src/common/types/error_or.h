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

#include <expected>
#include <string>
#include <utility>

// namespace xi
// {

//
// ErrorOr<T, E = std::string>
//
//   An alias for std::expected (C++23): either a T (the success value) or an E
//   describing why it couldn't be produced. Prefer this over out-params,
//   sentinel values, or Maybe<T> when the caller needs to know *why* something
//   failed, not just that it did.
//
//   Return a success value directly, and an error via Error():
//
//       auto parsePos(const std::string& s) -> ErrorOr<position_t>
//       {
//           if (s.empty())
//           {
//               return Error("empty position string");
//           }
//           return position_t{ ... };
//       }
//
//   Callers can branch (`if (result) { result->x; }` / `result.error()`), or use
//   the monadic ops (and_then/transform/or_else) to chain without branching.
//

template <typename T, typename E = std::string>
using ErrorOr = std::expected<T, E>;

// Construct the error side of an ErrorOr: `return Error("reason");`
template <typename E = std::string>
auto Error(E error) -> std::unexpected<E>
{
    return std::unexpected<E>{ std::move(error) };
}

inline auto Error(const char* message) -> std::unexpected<std::string>
{
    return std::unexpected<std::string>{ message };
}

// } // namespace xi
