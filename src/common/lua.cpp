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

#include "lua.h"

#include "logging.h"
#include "tracy.h"

#include <numeric>
#include <string>

sol::state lua;

/**
 * @brief Load the bare minimum required to use Lua.
 */
void lua_init()
{
    TracyZoneScoped;

    lua.open_libraries();

    // Globally require bit library
    lua.do_string("if not bit then bit = require('bit') end");

    lua.do_string(
        "function __FILE__() return debug.getinfo(2, 'S').source end\n"
        "function __LINE__() return debug.getinfo(2, 'l').currentline end\n"
        "function __FUNC__() return debug.getinfo(2, 'n').name end\n");

    // Bind print(...) globally
    lua.set_function("print", &lua_print);

    // Attempt to startup lldebugger
    auto result = lua["require"]("lldebugger");
    if (result.valid())
    {
        result.get<sol::table>()["start"];
        ShowInfo("Started script debugger");
    }
}

/**
 * @brief
 */
std::string lua_to_string(sol::object const& obj, std::size_t depth)
{
    switch (obj.get_type())
    {
        case sol::type::none:
            [[fallthrough]];
        case sol::type::lua_nil:
        {
            return "nil";
        }
        case sol::type::string:
        {
            if (depth > 0)
            {
                return "\"" + obj.as<std::string>() + "\"";
            }
            else
            {
                return obj.as<std::string>();
            }
        }
        case sol::type::number:
        {
            return fmt::format("{0:g}", obj.as<double>());
        }
        case sol::type::thread:
        {
            return "thread";
        }
        case sol::type::boolean:
        {
            return obj.as<bool>() ? "true" : "false";
        }
        case sol::type::function:
        {
            return "function";
        }
        case sol::type::userdata:
        {
            return lua["tostring"](obj);
        }
        case sol::type::lightuserdata:
        {
            return "lightuserdata";
        }
        case sol::type::table:
        {
            auto table = obj.as<sol::table>();

            std::string indent = "";
            for (std::size_t i = 0U; i < depth + 1U; ++i)
            {
                indent += "    ";
            }

            std::string unindent = "";
            if (!indent.empty())
            {
                unindent = std::string(indent.begin(), indent.end() - 4);
            }

            // Stringify everything first
            std::vector<std::string> stringVec;
            for (auto const& [keyObj, valObj] : table)
            {
                if (keyObj.get_type() == sol::type::string)
                {
                    stringVec.emplace_back(fmt::format("{}{}: {}", indent, lua_to_string(keyObj), lua_to_string(valObj, depth + 1)));
                }
                else
                {
                    stringVec.emplace_back(fmt::format("{}{}", indent, lua_to_string(valObj, depth + 1)));
                }
            }

            // Accumulate into a pretty string
            // clang-format off
            std::string outStr = "\n" + unindent + "{" + (stringVec.empty() ? "" : "\n");
            outStr += std::accumulate(std::begin(stringVec), std::end(stringVec), std::string(),
            [](std::string& ss, std::string& s)
            {
                return ss.empty() ? s : (ss + ",\n" + s);
            });
            // clang-format on

            return outStr + (stringVec.empty() ? "" : "\n") + unindent + "}";
        }
        default:
        {
            return "UNKNOWN";
        }
    }
}

/**
 * @brief
 */
void lua_print(sol::variadic_args va)
{
    TracyZoneScoped;

    std::vector<std::string> vec;
    for (std::size_t i = 0; i < va.size(); ++i)
    {
        vec.emplace_back(lua_to_string(va[i]));
    }

    ShowLua(fmt::format("{}", fmt::join(vec.begin(), vec.end(), " ")).c_str());
}
