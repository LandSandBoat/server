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

    void ParseSettingsLine(std::string const& section, std::string const& line)
    {
        std::string sectionTitle = section + "Settings::";
        sectionTitle[0] = std::toupper(sectionTitle[0]);
        std::cout << sectionTitle << "\n";

        // TODO: Parse data from line
        //     HOST = "127.0.0.1", -- (string) The IP Address of the host machine
        //     PORT = 3306, -- (uint) The Port

        std::string lookupString = sectionTitle + ""; // TODO
        //variant_settings_lookup[lookupString] = 0U;
    }

public:
    SettingsManager()
    {
        populate_settings_lookup();

        // Parse from files
        if (std::filesystem::is_empty("./settings"))
        {
            // Show angry message about copying your settings files across!
            // std::cout << "Settings is empty!";
        }

        // auto fp = RIAA_FILE("test.txt");

        for (auto& entry : std::filesystem::directory_iterator("./settings"))
        {
            auto& path = entry.path();
            if (path.extension() == ".lua")
            {
                std::ifstream file(path.generic_string());
                std::string   line;
                if (file.is_open())
                {
                    while (!file.eof())
                    {
                        std::getline(file, line);
                        ParseSettingsLine(path.filename().replace_extension("").string(), line);
                    }
                    file.close();
                }
            }
        }
    }

    template <typename T>
    [[nodiscard]] static T Get(variant_settings_t key)
    {
        auto& instance = SettingsManager::GetInstance();
        // TODO: Helpful error logging here for bad lookups
        auto detail = instance.map.at(key);
        return std::get<T>(detail.value);
    }
};
