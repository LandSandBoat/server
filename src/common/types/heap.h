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

#include <algorithm>
#include <cstddef>
#include <functional>
#include <utility>
#include <vector>

// namespace xi
// {

//
// Heap<T, Compare>
//
// A std::vector managed with the std::ranges heap algorithms, standing in for
// std::priority_queue. Same ordering semantics: the "largest" element per
// Compare is at the top, so use a greater-than comparator for a min-heap
// (or the MinHeap/MaxHeap aliases below).
//
// Unlike std::priority_queue:
//   - pop() returns the element by value, moved out of the heap.
//     (priority_queue only exposes top() as const&, forcing a const_cast or a
//     copy to extract move-only or expensive-to-copy elements.)
//   - clear() drops all elements at once instead of popping one at a time
//     with a reheapify per element.
//
template <typename T, typename Compare = std::less<T>>
class Heap
{
public:
    [[nodiscard]] bool        empty() const noexcept;
    [[nodiscard]] std::size_t size() const noexcept;

    // The element that pop() would return next. Precondition: !empty().
    [[nodiscard]] const T& top() const;

    void push(T value);

    template <typename... Args>
    void emplace(Args&&... args);

    // Removes and returns the top element. Precondition: !empty().
    [[nodiscard]] T pop();

    void clear() noexcept;

private:
    std::vector<T> storage;
    Compare        comp{};
};

// Largest element on top (same as Heap's default).
template <typename T>
using MaxHeap = Heap<T, std::less<T>>;

// Smallest element on top.
template <typename T>
using MinHeap = Heap<T, std::greater<T>>;

//
// Implementation
//

template <typename T, typename Compare>
bool Heap<T, Compare>::empty() const noexcept
{
    return storage.empty();
}

template <typename T, typename Compare>
std::size_t Heap<T, Compare>::size() const noexcept
{
    return storage.size();
}

template <typename T, typename Compare>
const T& Heap<T, Compare>::top() const
{
    return storage.front();
}

template <typename T, typename Compare>
void Heap<T, Compare>::push(T value)
{
    storage.push_back(std::move(value));
    std::ranges::push_heap(storage, comp);
}

template <typename T, typename Compare>
template <typename... Args>
void Heap<T, Compare>::emplace(Args&&... args)
{
    storage.emplace_back(std::forward<Args>(args)...);
    std::ranges::push_heap(storage, comp);
}

template <typename T, typename Compare>
T Heap<T, Compare>::pop()
{
    std::ranges::pop_heap(storage, comp);
    T value = std::move(storage.back());
    storage.pop_back();
    return value;
}

template <typename T, typename Compare>
void Heap<T, Compare>::clear() noexcept
{
    storage.clear();
}

// } // namespace xi
