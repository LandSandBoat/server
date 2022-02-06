/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

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

/*
    SettingsManager

    The SettingsManager object is created by Application on construction. It's purpose is
    to read _all_ settings for _all_ systems, validate them, and make them accessible to
    both C++ and Lua in a typesafe manner.

    Usage (C++)

    bool isTOAUEnabled = SettingsManager::Get<bool>(Settings::ENABLE_TOAU);

    Usage (Lua)

    local isTOAUEnabled = xi.settings.ENABLE_TOAU
*/

#pragma once

#include "singleton.h"

#include <iostream>
#include <string>
#include <unordered_map>
#include <variant>

enum class Settings
{
    ENABLE_TOAU,
    DAMAGE_MULT,
};

using variant_t = std::variant<bool, float, unsigned int, std::string>;

struct SettingsDetails
{
    std::string name;
    variant_t value;
};

class SettingsManager : public Singleton<SettingsManager>
{
public:
    SettingsManager()
    {
        std::cout << "Init SettingsManager\n";

        // Parse from files

        map[Settings::ENABLE_TOAU] = SettingsDetails{"ENABLE_TOAU", true};
        map[Settings::DAMAGE_MULT] = SettingsDetails{"DAMAGE_MULT", 1.0f};
    }

    template<typename T>
    [[nodiscard]] static T Get(Settings key)
    {
        auto& instance = SettingsManager::GetInstance();
        auto detail = instance.map[key];
        return std::get<T>(detail.value);
    }

    std::unordered_map<Settings, SettingsDetails> map;
};
