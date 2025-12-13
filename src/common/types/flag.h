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

namespace xi
{

//
// Flag<Tag>
//
// A strongly typed boolean flag.
//

template <typename Tag>
class Flag
{
public:
    constexpr explicit Flag(bool value) noexcept;

    constexpr operator bool() const noexcept;

    constexpr bool operator==(const Flag& other) const noexcept = default;
    constexpr bool operator!=(const Flag& other) const noexcept = default;

    static const Flag Yes;
    static const Flag No;

private:
    bool value_ = false;
};

//
// Implementation
//

template <typename Tag>
constexpr Flag<Tag>::Flag(bool value) noexcept
: value_(value)
{
}

template <typename Tag>
constexpr Flag<Tag>::operator bool() const noexcept
{
    return value_;
}

template <typename Tag>
constexpr Flag<Tag> Flag<Tag>::Yes{ true };

template <typename Tag>
constexpr Flag<Tag> Flag<Tag>::No{ false };

} // namespace xi

//
// Common flags
//
// TODO: When lots of callsites are moved to be inside xi::, then these flags can also be moved
//     : inside xi::
//

using SendPacket = xi::Flag<struct SendPacketTag>;
