/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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

#include <array>
#include <functional>
#include <memory>
#include <mutex>
#include <string>
#include <tuple>
#include <type_traits>
#include <utility>
#include <vector>

#include "earth_time.h"
#include "tracy.h"
#include "vanadiel_clock.h"

#include "types/flag.h"
#include "types/fn.h"
#include "types/maybe.h"
#include "types/variant.h"

namespace xi
{

// https://github.com/microsoft/GSL/blob/main/include/gsl/util
// final_action allows you to ensure something gets run at the end of a scope
template <class F>
class final_action
{
public:
    explicit final_action(const F& ff) noexcept
    : f{ ff }
    {
    }

    explicit final_action(F&& ff) noexcept
    : f{ std::move(ff) }
    {
    }

    ~final_action() noexcept
    {
        if (invoke)
        {
            f();
        }
    }

    final_action(final_action&& other) noexcept
    : f(std::move(other.f))
    , invoke(std::exchange(other.invoke, false))
    {
    }

    final_action(const final_action&)   = delete;
    void operator=(const final_action&) = delete;
    void operator=(final_action&&)      = delete;

private:
    F    f;
    bool invoke = true;
};

// finally() - convenience function to generate a final_action
template <class F>
[[nodiscard]] auto finally(F&& f) noexcept
{
    return final_action<std::decay_t<F>>{ std::forward<F>(f) };
}

class bit_reference
{
public:
    bit_reference(uint8& byte, size_t bit)
    : byte_(byte)
    , bit_(bit)
    {
    }

    operator bool() const
    {
        return (byte_ & (1 << bit_)) != 0;
    }

    bit_reference& operator=(bool value)
    {
        if (value)
        {
            byte_ |= (1 << bit_);
        }
        else
        {
            byte_ &= ~(1 << bit_);
        }
        return *this;
    }

    bit_reference& operator=(const bit_reference& other)
    {
        return *this = static_cast<bool>(other);
    }

private:
    uint8& byte_;
    size_t bit_;
};

// std::bitset is not trivial, so we need to create our own bitset
// for use with the database
template <std::size_t N>
struct bitset
{
    static constexpr std::size_t    storage_size = (N + 7) / 8;
    std::array<uint8, storage_size> data;

    void set(std::size_t pos, bool value)
    {
        if (value)
        {
            data[pos / 8] |= (1 << (pos % 8));
        }
        else
        {
            data[pos / 8] &= ~(1 << (pos % 8));
        }
    }

    void set(std::size_t pos)
    {
        set(pos, true);
    }

    bool get(std::size_t pos) const
    {
        return (data[pos / 8] >> (pos % 8)) & 0x01;
    }

    bool test(std::size_t pos) const
    {
        return get(pos);
    }

    bool none() const
    {
        for (std::size_t i = 0; i < storage_size; ++i)
        {
            if (data[i] != 0)
            {
                return false;
            }
        }
        return true;
    }

    void reset()
    {
        std::fill(data.begin(), data.end(), 0);
    }

    void reset(std::size_t pos)
    {
        set(pos, false);
    }

    void flip()
    {
        for (std::size_t i = 0; i < storage_size; ++i)
        {
            data[i] = ~data[i];
        }
    }

    void flip(std::size_t pos)
    {
        data[pos / 8] ^= (1 << (pos % 8));
    }

    std::size_t size() const
    {
        return N;
    }

    xi::bitset<storage_size>& operator=(xi::bitset<storage_size>&& other)
    {
        data = std::move(other.data);
        return *this;
    }

    bit_reference operator[](std::size_t pos)
    {
        return bit_reference(data[pos / 8], pos % 8);
    }

    bool operator[](std::size_t pos) const
    {
        return get(pos);
    }

    xi::bitset<N> operator&(const xi::bitset<N>& other) const
    {
        xi::bitset<N> result;
        for (std::size_t i = 0; i < storage_size; ++i)
        {
            result.data[i] = data[i] & other.data[i];
        }
        return result;
    }

    xi::bitset<N> operator~() const
    {
        xi::bitset<N> result;
        for (std::size_t i = 0; i < storage_size; ++i)
        {
            result.data[i] = ~data[i];
        }
        return result;
    }

    xi::bitset<N>& operator&=(const xi::bitset<N>& other)
    {
        for (std::size_t i = 0; i < storage_size; ++i)
        {
            data[i] &= other.data[i];
        }
        return *this;
    }
};

} // namespace xi
