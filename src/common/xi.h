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

#include <optional>
#include <type_traits>
#include <utility>

#include "earth_time.h"

// The purpose of this namespace IS NOT to replace the C++ standard library.
//
// It is to provide convenience wrappers around common standard library types
// so that they are easier and more intuitive to use in the context of this project.
//
// You should be:
// - Forwarding all of the expected and useful functions from the underlying standard library type
// - Not forwarding/hiding the ones that are not useful
// - Adding new functions that are useful and convenient

namespace xi
{
    class vanadiel_clock
    {
    private:
        using millisecond_ratio = std::ratio<1, 25000>; // (1Vms/25000ms) * 1000Vms * 60Vs = 1 Vmin
        using second_ratio      = std::ratio_multiply<millisecond_ratio, std::ratio<1000>>;
        using minute_ratio      = std::ratio_multiply<second_ratio, std::ratio<60>>; // 2.4 Earth seconds
        using hour_ratio        = std::ratio_multiply<minute_ratio, std::ratio<60>>; //  60 Vana'diel minutes
        using day_ratio         = std::ratio_multiply<hour_ratio, std::ratio<24>>;   //  24 Vana'diel hours
        using week_ratio        = std::ratio_multiply<day_ratio, std::ratio<8>>;     //   8 Vana'diel days
        using month_ratio       = std::ratio_multiply<day_ratio, std::ratio<30>>;    //  30 Vana'diel days
        using year_ratio        = std::ratio_multiply<day_ratio, std::ratio<360>>;   // 360 Vana'diel days

    public:
        using milliseconds = std::chrono::duration<long long, millisecond_ratio>;
        using seconds      = std::chrono::duration<long long, second_ratio>;
        using minutes      = std::chrono::duration<long long, minute_ratio>;
        using hours        = std::chrono::duration<long long, hour_ratio>;
        using days         = std::chrono::duration<long long, day_ratio>;
        using weeks        = std::chrono::duration<long long, week_ratio>;
        using months       = std::chrono::duration<long long, month_ratio>;
        using years        = std::chrono::duration<long long, year_ratio>;

        using duration              = milliseconds;
        using rep                   = duration::rep;
        using period                = duration::period;
        using time_point            = std::chrono::time_point<vanadiel_clock>;
        static const bool is_steady = false;

        static time_point now() noexcept
        {
            return time_point{ std::chrono::duration_cast<duration>(earth_time::now() - earth_time::vanadiel_epoch) };
        }
    };

    // A wrapper around std::optional to allow usage of object.apply([](auto& obj) { ... });
    // https://en.cppreference.com/w/cpp/utility/optional
    template <typename T>
    class optional
    {
    public:
        constexpr optional() = default;

        constexpr optional(std::nullopt_t) noexcept
        : m_value(std::nullopt)
        {
        }

        constexpr optional(T&& value)
        : m_value(std::forward<T>(value))
        {
        }

        constexpr optional(const T& value)
        : m_value(value)
        {
        }

        constexpr optional(const optional& other)                = default;
        constexpr optional(optional&& other) noexcept            = default;
        constexpr optional& operator=(const optional& other)     = default;
        constexpr optional& operator=(optional&& other) noexcept = default;
        ~optional()                                              = default;

        constexpr optional& operator=(std::nullopt_t) noexcept
        {
            m_value = std::nullopt;
            return *this;
        }

        constexpr optional& operator=(T&& value)
        {
            m_value = std::move(value);
            return *this;
        }

        template <typename F>
        constexpr bool apply(F&& f) &
        {
            if (m_value)
            {
                f(*m_value);
            }
            return m_value.has_value();
        }

        template <typename F>
        constexpr bool apply(F&& f) const&
        {
            if (m_value)
            {
                f(*m_value);
            }
            return m_value.has_value();
        }

        constexpr explicit operator bool() const noexcept
        {
            return m_value.has_value();
        }

        constexpr T& operator*() &
        {
            return *m_value;
        }

        constexpr const T& operator*() const&
        {
            return *m_value;
        }

        constexpr T* operator->() noexcept
        {
            return m_value.operator->();
        }

        constexpr const T* operator->() const noexcept
        {
            return m_value.operator->();
        }

        constexpr void reset() noexcept
        {
            m_value.reset();
        }

        template <typename... Args>
        constexpr T& emplace(Args&&... args)
        {
            return m_value.emplace(std::forward<Args>(args)...);
        }

        constexpr bool operator==(const optional& other) const
        {
            return m_value == other.m_value;
        }

        constexpr bool operator!=(const optional& other) const
        {
            return m_value != other.m_value;
        }

    private:
        std::optional<T> m_value = std::nullopt;
    };

    // TODO: A wrapper around std::variant to allow usage of:
    //     :   object.visit(overloaded{...});
    //     :   object.get<T>() -> xi::optional<T>;

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
