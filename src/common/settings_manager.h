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

    TODO

    Usage (Lua)

    TODO
*/

#pragma once

#include "cbasetypes.h"
#include "settings_impl.h"
#include "singleton.h"

#include <filesystem>
#include <fstream>
#include <functional>
#include <iostream>
#include <memory>
#include <string>
#include <unordered_map>
#include <variant>

using variant_value_t = std::variant<bool, float, unsigned int, std::string>;

class SettingsManager : public Singleton<SettingsManager>
{
private:
    struct SettingsDetails
    {
        std::string     name;
        variant_value_t value;
    };

    std::unordered_map<variant_settings_t, SettingsDetails> map;

    void ParseSettingsLine(std::string const& section, std::string const& line);

    void ReadServerMessage();

public:
    SettingsManager();

    // TODO: Automatic conversion from uint8, uint16 etc.
    // TODO: OR: Funcs for GetInt, GetUInt, GetString etc.
    template <typename T>
    [[nodiscard]] static T Get(variant_settings_t key)
    {
        try
        {
            auto& instance = SettingsManager::GetInstance();
            auto detail = instance.map.at(key);
            return std::get<T>(detail.value);
        }
        catch (const std::exception& e)
        {
            // TODO: Error logging that prints the setting you're trying to get
            std::cerr << "Error: SettingsManager::Get: " << e.what() << '\n';
        }
        return T();
    }
};
