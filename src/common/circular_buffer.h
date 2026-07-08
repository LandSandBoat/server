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

#include <memory>
#include <mutex>
#include <stdexcept>
#include <utility>

// https://gist.github.com/edwintcloud/d547a4f9ccaf7245b06f0e8782acefaa
//
// Fixed-capacity, thread-safe ring buffer. Capacity must be a power of two so the
// hot enqueue path can wrap indices with a cheap mask instead of a modulo.
template <class T>
class CircularBuffer final
{
private:
    std::unique_ptr<T[]> buffer;

    std::size_t head{};
    std::size_t tail{};
    std::size_t max_size{};
    std::size_t mask{};
    bool        full{};

    T empty_item{};

    std::mutex mutex;

    // Unlocked; callers must already hold `mutex`.
    bool is_empty_unlocked() const
    {
        return (!full && (head == tail));
    }

    // Advance an index by one with wraparound. Capacity is a power of two, so this
    // is a single AND rather than a (much more expensive) modulo on the hot path.
    std::size_t advance(std::size_t index) const
    {
        return (index + 1) & mask;
    }

    // Shared, unlocked enqueue body. The forwarding reference lets callers pass an
    // lvalue (copied into the slot) or an rvalue (moved, no allocation).
    template <class U>
    void push_unlocked(U&& item)
    {
        buffer[tail] = std::forward<U>(item);

        if (full)
        {
            head = advance(head);
        }

        tail = advance(tail);

        full = tail == head;
    }

public:
    CircularBuffer(std::size_t max_size)
    : buffer(std::make_unique<T[]>(max_size))
    , max_size(max_size)
    , mask(max_size - 1)
    {
        if (max_size == 0 || (max_size & (max_size - 1)) != 0)
        {
            throw std::invalid_argument("CircularBuffer capacity must be a power of two");
        }
    }

    void enqueue(const T& item)
    {
        std::lock_guard lock(mutex);
        push_unlocked(item);
    }

    void enqueue(T&& item)
    {
        std::lock_guard lock(mutex);
        push_unlocked(std::move(item));
    }

    T dequeue()
    {
        std::lock_guard lock(mutex);

        if (is_empty_unlocked())
        {
            throw std::runtime_error("buffer is empty");
        }

        T item = std::move(buffer[head]);

        buffer[head] = empty_item;

        head = advance(head);

        full = false;

        return item;
    }

    T front()
    {
        std::lock_guard lock(mutex);

        if (is_empty_unlocked())
        {
            throw std::runtime_error("buffer is empty");
        }

        return buffer[head];
    }

    bool is_empty()
    {
        std::lock_guard lock(mutex);

        return is_empty_unlocked();
    }

    bool is_full()
    {
        std::lock_guard lock(mutex);

        return full;
    }

    std::size_t size()
    {
        std::lock_guard lock(mutex);

        if (full)
        {
            return max_size;
        }

        if (tail >= head)
        {
            return tail - head;
        }

        return max_size - head + tail;
    }
};
