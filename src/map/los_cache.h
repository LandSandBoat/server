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

#include <common/cbasetypes.h>
#include <common/timer.h>

#include <common/types/maybe.h>

#include <map/ximesh/vector3.h>

#include <array>
#include <chrono>

class LineOfSightCache
{
public:
    auto get(const Vector3& src, const Vector3& dst, uint16 zoneId, timer::time_point now) -> Maybe<bool>;
    void put(const Vector3& src, const Vector3& dst, uint16 zoneId, bool result, timer::time_point now);

private:
    static constexpr std::size_t               kCapacity = 8;
    static constexpr std::chrono::milliseconds kTTL{ 2500 };
    static constexpr float                     kYalmsPerCell = 2.0f;

    struct Key
    {
        uint16 zone{};

        int16 sx{};
        int16 sy{};
        int16 sz{};

        int16 dx{};
        int16 dy{};
        int16 dz{};

        auto operator==(const Key&) const -> bool = default;
    };

    struct Entry
    {
        Key               key{};
        bool              result{};
        timer::time_point expiry{};
    };

    static auto makeKey(const Vector3& src, const Vector3& dst, uint16 zoneId) -> Key;

    void moveToFront(std::size_t i);

    std::array<Entry, kCapacity> entries_{};
    std::size_t                  size_{ 0 };
};
