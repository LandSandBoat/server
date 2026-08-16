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

#include <cstddef>
#include <memory>
#include <mutex>
#include <stdexcept>
#include <utility>
#include <vector>

// https://gist.github.com/edwintcloud/d547a4f9ccaf7245b06f0e8782acefaa
//
// Fixed-capacity, thread-safe ring buffer. Capacity must be a power of two so the
// hot enqueue path can wrap indices with a cheap mask instead of a modulo.
template <class T>
class CircularBuffer final
{
public:
    explicit CircularBuffer(std::size_t capacity);

    auto enqueue(const T& item) -> void;
    auto enqueue(T&& item) -> void;

    // Writes in place, so each slot keeps its capacity; assigning over it would free that.
    template <class WriteFn>
    auto emplace(WriteFn&& write) -> void;

    // Oldest first. Non-destructive, so the slots keep their capacity.
    auto snapshot() -> std::vector<T>;

    auto isEmpty() -> bool;
    auto isFull() -> bool;
    auto size() -> std::size_t;

private:
    // Unlocked; callers must already hold `mutex_`.
    auto isEmptyUnlocked() const -> bool;
    auto sizeUnlocked() const -> std::size_t;

    // Capacity is a power of two, so wrapping is a single AND rather than a modulo.
    auto advance(std::size_t index) const -> std::size_t;

    // Unlocked; callers must already hold `mutex_`. Marks the slot at tail_ as written.
    auto commitUnlocked() -> void;

    std::unique_ptr<T[]> buffer_;

    std::size_t head_{ 0 };
    std::size_t tail_{ 0 };
    std::size_t capacity_{ 0 };
    std::size_t mask_{ 0 };
    bool        full_{ false };

    std::mutex mutex_;
};

template <class T>
CircularBuffer<T>::CircularBuffer(std::size_t capacity)
: buffer_(std::make_unique<T[]>(capacity))
, capacity_(capacity)
, mask_(capacity - 1)
{
    if (capacity == 0 || (capacity & (capacity - 1)) != 0)
    {
        throw std::invalid_argument("CircularBuffer capacity must be a power of two");
    }
}

template <class T>
auto CircularBuffer<T>::isEmptyUnlocked() const -> bool
{
    return !full_ && head_ == tail_;
}

template <class T>
auto CircularBuffer<T>::sizeUnlocked() const -> std::size_t
{
    if (full_)
    {
        return capacity_;
    }

    if (tail_ >= head_)
    {
        return tail_ - head_;
    }

    return capacity_ - head_ + tail_;
}

template <class T>
auto CircularBuffer<T>::advance(std::size_t index) const -> std::size_t
{
    return (index + 1) & mask_;
}

template <class T>
auto CircularBuffer<T>::commitUnlocked() -> void
{
    if (full_)
    {
        head_ = advance(head_);
    }

    tail_ = advance(tail_);
    full_ = tail_ == head_;
}

template <class T>
auto CircularBuffer<T>::enqueue(const T& item) -> void
{
    const std::lock_guard lock(mutex_);

    buffer_[tail_] = item;
    commitUnlocked();
}

template <class T>
auto CircularBuffer<T>::enqueue(T&& item) -> void
{
    const std::lock_guard lock(mutex_);

    buffer_[tail_] = std::move(item);
    commitUnlocked();
}

template <class T>
template <class WriteFn>
auto CircularBuffer<T>::emplace(WriteFn&& write) -> void
{
    const std::lock_guard lock(mutex_);

    write(buffer_[tail_]);
    commitUnlocked();
}

template <class T>
auto CircularBuffer<T>::snapshot() -> std::vector<T>
{
    const std::lock_guard lock(mutex_);

    std::vector<T> items;
    if (isEmptyUnlocked())
    {
        return items;
    }

    items.reserve(sizeUnlocked());

    std::size_t index = head_;
    do
    {
        items.push_back(buffer_[index]);
        index = advance(index);
    } while (index != tail_);

    return items;
}

template <class T>
auto CircularBuffer<T>::isEmpty() -> bool
{
    const std::lock_guard lock(mutex_);

    return isEmptyUnlocked();
}

template <class T>
auto CircularBuffer<T>::isFull() -> bool
{
    const std::lock_guard lock(mutex_);

    return full_;
}

template <class T>
auto CircularBuffer<T>::size() -> std::size_t
{
    const std::lock_guard lock(mutex_);

    return sizeUnlocked();
}
