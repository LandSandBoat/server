/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include <function2/function2.hpp>

// namespace xi
// {

//
// Fn<Signature>
//
// A move-only callable wrapper (fu2::unique_function), standing in for
// std::move_only_function until libc++ (macOS) implements it.
//
// Unlike std::function:
//   - Not copyable, so it can hold move-only captures (e.g. a unique_ptr).
//   - The signature carries qualifiers: to invoke through a const Fn&, the
//     signature must be const-qualified (e.g. Fn<void(int) const>).
//   - Invoking an empty Fn throws/traps instead of throwing std::bad_function_call.
//

template <typename Signature>
using Fn = fu2::unique_function<Signature>;

//
// FnRef<Signature>
//
// A non-owning callable view (fu2::function_view), standing in for C++26's
// std::function_ref. Use it for callback parameters that are only invoked
// during the call (ForEach-style iterators): unlike Fn/std::function it never
// copies or allocates, it just points at the caller's callable.
//
// Pass it by value (like a string_view), and never store one beyond the call
// - it dangles as soon as the referenced callable goes out of scope.
//

template <typename Signature>
using FnRef = fu2::function_view<Signature>;

// } // namespace xi
