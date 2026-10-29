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

#include "common/macros.h"
#include <new>
#include <utility>

// A T that is constructed in place and deliberately never destroyed. The same pattern as
// Abseil's absl::NoDestructor and Chromium's base::NoDestructor.
//
// We should eventually sort out our lifetimes and remove the need for this!
template <class T>
class NoDestructor final
{
public:
    template <class... Args>
    explicit NoDestructor(Args&&... args);

    ~NoDestructor() = default;

    DISALLOW_COPY_AND_MOVE(NoDestructor);

    auto operator*() -> T&;
    auto operator->() -> T*;
    auto get() -> T*;

private:
    alignas(T) unsigned char storage_[sizeof(T)]{};
};

template <class T>
template <class... Args>
NoDestructor<T>::NoDestructor(Args&&... args)
{
    ::new (static_cast<void*>(storage_)) T(std::forward<Args>(args)...);
}

template <class T>
auto NoDestructor<T>::operator*() -> T&
{
    return *get();
}

template <class T>
auto NoDestructor<T>::operator->() -> T*
{
    return get();
}

template <class T>
auto NoDestructor<T>::get() -> T*
{
    // The placement new above started T's lifetime in storage_; launder so the pointer refers
    // to that object rather than to the bytes it was created in.
    return std::launder(reinterpret_cast<T*>(storage_));
}
