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

#include <mutex>
#include <shared_mutex>
#include <type_traits>

#include "cbasetypes.h"
#include "tracy.h"

namespace detail
{

template <class M>
struct SynchronizedMutex
{
    mutable TracyLockable(M, mutex);
};

template <>
struct SynchronizedMutex<std::shared_mutex>
{
    mutable TracySharedLockable(std::shared_mutex, mutex);
};

} // namespace detail

// https://www.reddit.com/r/cpp/comments/p132c7/comment/h8b8nml/?share_id=-NRyj9iRw5TqSi4Mm381j
template <
    class T,
    class M                            = std::mutex,
    template <typename...> typename WL = std::unique_lock,
    template <typename...> typename RL = std::unique_lock>
struct Synchronized
{
    Synchronized()  = default;
    ~Synchronized() = default;

    explicit Synchronized(T in)
    : target(std::move(in))
    {
    }

    DISALLOW_COPY_AND_MOVE(Synchronized);

    auto read(auto f) const
    {
        auto l = lock();
        LockMark(holder_.mutex);
        return f(target);
    }

    auto write(auto f)
    {
        auto l = lock();
        LockMark(holder_.mutex);
        return f(target);
    }

private:
    using MutexType = std::remove_cvref_t<decltype(std::declval<const detail::SynchronizedMutex<M>&>().mutex)>;

    T target;

    detail::SynchronizedMutex<M> holder_;

    auto lock() const
    {
        return RL<MutexType>(holder_.mutex);
    }

    auto lock()
    {
        return WL<MutexType>(holder_.mutex);
    }
};

template <class T>
using SynchronizedShared = Synchronized<T, std::shared_mutex, std::unique_lock, std::shared_lock>;
