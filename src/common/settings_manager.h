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

// TODO: A string utils area

// https://stackoverflow.com/questions/18800796/c-get-string-between-two-delimiter-string/18800868
std::string get_str_between_two_str(const std::string &s,
        const std::string &start_delim,
        const std::string &stop_delim)
{
    std::size_t first_delim_pos = s.find(start_delim);
    std::size_t end_pos_of_first_delim = first_delim_pos + start_delim.length();
    std::size_t last_delim_pos = s.find_first_of(stop_delim, end_pos_of_first_delim);

    return s.substr(end_pos_of_first_delim,
            last_delim_pos - end_pos_of_first_delim);
}

bool string_starts_with(const std::string& s, const std::string& subString)
{
    return s.rfind(subString, 0) == 0;
}

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
        if (!string_starts_with(line, "    "))
        {
            return;
        }

        // TODO: Validate line

        auto nameString = get_str_between_two_str(line, "    ", " = ");
        auto typeString = get_str_between_two_str(line, "-- (", ") ");
        auto valueString = get_str_between_two_str(line, " = ", ", --");

        if (nameString == "--")
        {
            return;
        }

        std::string sectionTitle = section + "Settings::";
        sectionTitle[0]          = std::toupper(sectionTitle[0]);
        std::string lookupString = sectionTitle + nameString;
        auto        enumSetting  = variant_settings_lookup[lookupString];


        if (typeString == "string")
        {
            valueString = get_str_between_two_str(line, " = \"", "\", --");
            map[enumSetting] = SettingsDetails{ nameString, valueString };
        }
        else if (typeString == "bool")
        {
            map[enumSetting] = SettingsDetails{ nameString, valueString == "true" };
        }
        else if (typeString == "float")
        {
            map[enumSetting] = SettingsDetails{ nameString, std::stof(valueString) };
        }
        else if (typeString == "uint")
        {
            map[enumSetting] = SettingsDetails{ nameString, static_cast<uint32>(std::stoul(valueString)) };
        }
        else
        {
            std::cerr << sectionTitle << " : " << lookupString << ": invalid settings type! " << nameString << ", " << typeString << "\n";
        }
    }

    void ReadServerMessage()
    {
        // TODO
        if (std::filesystem::is_empty("./settings/server_message.txt"))
        {
            //
        }

        std::string serverMessage;
        std::ifstream file("./settings/server_message.txt");
        std::string   line;

        // TODO: This is a lame hack
        bool firstLine = true;
        if (file.is_open())
        {
            while (!file.eof())
            {
                std::getline(file, line);
                if (!firstLine)
                {
                    serverMessage += "\n";
                }
                serverMessage += line;
                firstLine = false;
            }
            file.close();
        }
        this->map[MainSettings::SERVER_MESSAGE] = SettingsDetails{ "MainSettings::SERVER_MESSAGE", serverMessage };
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

        // TODO: Go through "./settings/defaults" and build a list of all the default
        // settings that exist. Then compare them to whatever is in "./settings" and
        // report if there are settings missing.

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

        ReadServerMessage();
    }

    template <typename T>
    [[nodiscard]] static T Get(variant_settings_t key)
    {
        try
        {
            auto& instance = SettingsManager::GetInstance();
            auto detail = instance.map.at(key);
            return std::get<T>(detail.value);
        }
        catch(const std::exception& e)
        {
            std::cerr << "Error: SettingsManager::Get: " << e.what() << '\n';
        }
        return T();
    }
};
