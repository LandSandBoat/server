/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

template <class T>
class Singleton
{
public:
    Singleton(const Singleton&)            = delete;
    Singleton& operator=(const Singleton&) = delete;

    static T* getInstance()
    {
        if (!_instance)
        {
            _instance = std::make_unique<T_Instance>();
        }

        return _instance.get();
    }

    static void delInstance()
    {
        _instance = nullptr;
    }

protected:
    Singleton()
    {
    }

    virtual ~Singleton()
    {
    }

private:
    // https://stackoverflow.com/a/55932298
    struct T_Instance : public T
    {
        T_Instance()
        : T()
        {
        }
    };

    static inline std::unique_ptr<T> _instance = nullptr;
};
