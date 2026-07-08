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

#include <map/los_cache.h>

auto LineOfSightCache::get(const Vector3& src, const Vector3& dst, uint16 zoneId, timer::time_point now) -> Maybe<bool>
{
    const Key key = makeKey(src, dst, zoneId);

    for (std::size_t i = 0; i < size_; ++i)
    {
        if (entries_[i].key == key)
        {
            if (now >= entries_[i].expiry)
            {
                return std::nullopt;
            }

            const bool result = entries_[i].result;
            moveToFront(i);
            return result;
        }
    }

    return std::nullopt;
}

void LineOfSightCache::put(const Vector3& src, const Vector3& dst, uint16 zoneId, bool result, timer::time_point now)
{
    const Key  key    = makeKey(src, dst, zoneId);
    const auto expiry = now + kTTL;

    for (std::size_t i = 0; i < size_; ++i)
    {
        if (entries_[i].key == key)
        {
            entries_[i].result = result;
            entries_[i].expiry = expiry;
            moveToFront(i);
            return;
        }
    }

    if (size_ < kCapacity)
    {
        ++size_;
    }

    for (std::size_t i = size_ - 1; i > 0; --i) // shift down, dropping the LRU entry if full
    {
        entries_[i] = entries_[i - 1];
    }

    entries_[0] = Entry{ key, result, expiry };
}

auto LineOfSightCache::makeKey(const Vector3& src, const Vector3& dst, uint16 zoneId) -> Key
{
    return Key{
        zoneId,
        static_cast<int16>(src.x / kYalmsPerCell),
        static_cast<int16>(src.y / kYalmsPerCell),
        static_cast<int16>(src.z / kYalmsPerCell),
        static_cast<int16>(dst.x / kYalmsPerCell),
        static_cast<int16>(dst.y / kYalmsPerCell),
        static_cast<int16>(dst.z / kYalmsPerCell),
    };
}

void LineOfSightCache::moveToFront(std::size_t i)
{
    if (i == 0)
    {
        return;
    }

    const Entry tmp = entries_[i];

    for (std::size_t j = i; j > 0; --j)
    {
        entries_[j] = entries_[j - 1];
    }

    entries_[0] = tmp;
}
