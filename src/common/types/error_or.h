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
//   An alias for std::expected: either a T (the success value) or an E
//   describing why it couldn't be produced. Prefer this over out-params,
//   sentinel values, or Maybe<T> when the caller needs to know why something
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
//
//           return position_t{ ... };
//       }
//

template <typename T, typename E = std::string>
using ErrorOr = std::expected<T, E>;

//
// Error<E>
//
//   The error side of an ErrorOr. Return one to fail:
//
//       return Error("could not open the file");
//
//   E comes from the argument, then converts to the function's error type. A
//   std::unique_ptr<Derived> can therefore satisfy an error type of std::unique_ptr<Base>.
//
template <typename E = std::string>
using Error = std::unexpected<E>;

//
// Success()
//
//   The success side of an ErrorOr<void, E>, for functions that report a failure reason
//   but have nothing to return when they work:
//
//       auto init() -> ErrorOr<void>
//       {
//           if (somethingWrong)
//           {
//               return Error("...");
//           }
//
//           return Success();
//       }
//
//   It reads better than `return {};`, which says nothing about which side you mean.
//
struct SuccessType
{
    template <typename E>
    constexpr operator ErrorOr<void, E>() const // NOLINT(google-explicit-constructor)
    {
        return ErrorOr<void, E>{};
    }
};

constexpr auto Success() -> SuccessType
{
    return {};
}

// } // namespace xi
