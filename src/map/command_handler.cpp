/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "command_handler.h"

#include "autotranslate.h"
#include "common/async.h"
#include "common/database.h"
#include "common/utils.h"
#include "entities/charentity.h"
#include "lua/lua_baseentity.h"
#include "lua/luautils.h"

#include <cmath>
#include <iostream>
#include <sstream>
#include <string>
#include <unordered_map>
#include <variant>
#include <vector>

// NOTE: Auto-translate blocks are dealt with as a string of bytes
using CommandArg = std::variant<bool, int, double, std::string>;

// The below section is a proposed rewrite of commandhandler.
// It can automatically deduce the types of strings that are passed to it.
//
// Test strings:
// bools: true True false False TRUE FALSE
// ints: 0 1 0x01 0xFF
// floats: 1.2 .1 1.4f
// strings: naked_string \"a string\" \'a string\' \"embedded \'string 1\'\" \'embedded \"string 2\"\'
//
// The issue with this, is that there is no easy way to interpret the entire string as one long string
// without surrounding it with quotes. If this can be nicely handled then the below code is ready
// to go!

/*
CommandArg deduceArgType(std::string& str)
{
    // Look for auto-translate byte blocks
    if (str.length() == 6 &&
        str.front() == -3 &&
        str.back() == -3)
    {
        // Return as-is, no need to further checks or transformations
        return str;
    }

    try
    {
        float d = std::stof(str);
        float intpart;
        if (std::modf(d, &intpart) == 0.0)
        {
            return static_cast<int>(intpart);
        }
        else
        {
            // float
            return d;
        }
    }
    catch (std::exception&)
    {
        // Must be a string of some kind
    }

    // bools
    std::string lower = "";
    for (auto& ch : str)
    {
        lower += std::tolower(ch);
    }

    if (lower == "true") { return true; }
    if (lower == "false") { return false; }

    // string
    return str;
}

std::vector<CommandArg> splitToArgs(std::string const& input)
{
    std::string str = trim(input);

    std::vector<CommandArg> args;
    char currentClosure = '\0';
    std::string buffer = "";
    for (auto ch : str)
    {
        // Open "" string
        if (currentClosure == '\0' && ch == '\"')
        {
            currentClosure = '\"';
        }
        // Open '' string
        else if (currentClosure == '\0' && ch == '\'')
        {
            currentClosure = '\'';
        }
        // Close "" string
        else if (currentClosure == '\"' && ch == '\"')
        {
            currentClosure = '\0';
        }
        // Close '' string
        else if (currentClosure == '\'' && ch == '\'')
        {
            currentClosure = '\0';
        }
        // Encountered unescaped space, submit buffer
        else if (ch == ' ' && currentClosure == '\0')
        {
            args.emplace_back(deduceArgType(buffer));
            buffer = "";
        }
        // Add to buffer
        else
        {
            buffer += ch;
        }
    }

    // Reached the end, try to submit the end of the buffer
    args.emplace_back(deduceArgType(buffer));

    return args;
}
*/

int32 CCommandHandler::call(sol::state& lua, CCharEntity* PChar, const std::string& commandline)
{
    TracyZoneScoped;

    // TODO: stringstreams are slow. Replace with something else.
    std::istringstream clstream(commandline);
    std::string        cmdname;

    clstream >> cmdname;

    if (!PChar)
    {
        ShowError("cmdhandler::call: nullptr character attempted to use command");
        return -1;
    }

    if (cmdname.empty())
    {
        ShowError("cmdhandler::call: function name was empty");
        return -1;
    }

    TracyZoneString(PChar->name);
    TracyZoneString(commandline);

    auto commandObj = lua["xi"]["commands"][cmdname];
    if (!commandObj.valid())
    {
        ShowError("cmdhandler::call: Function does not exist (%s)", cmdname);
        return -1;
    }

    sol::table commandTable = commandObj;

    if (!commandTable["cmdprops"].valid())
    {
        ShowError("cmdhandler::call: (%s): Undefined 'cmdprops' table", cmdname);
        return -1;
    }

    if (!commandTable["cmdprops"]["permission"].valid())
    {
        ShowError("cmdhandler::call: (%s): Invalid or no permission field set in cmdprops", cmdname);
        return -1;
    }

    if (!commandTable["cmdprops"]["parameters"].valid())
    {
        ShowError("cmdhandler::call: (%s): Invalid or no parameters field set in cmdprops", cmdname);
        return -1;
    }

    int8        permission = commandTable["cmdprops"]["permission"];
    std::string parameters = commandTable["cmdprops"]["parameters"];

    // Ensure this user can use this command
    if (permission > PChar->m_GMlevel)
    {
        ShowWarning("cmdhandler::call: Character %s attempting to use higher permission command %s", PChar->name, cmdname);
        return -1;
    }
    else
    {
        if (settings::get<uint8>("map.AUDIT_GM_CMD") <= permission && settings::get<uint8>("map.AUDIT_GM_CMD") > 0)
        {
            std::string name       = PChar->name;
            std::string cmdlinestr = autotranslate::replaceBytes(commandline);

            // clang-format off
            Async::getInstance()->submit([name, cmdname, cmdlinestr]()
            {
                const auto query = "INSERT into audit_gm (date_time, gm_name, command, full_string) VALUES(current_timestamp(), ?, ?, ?)";
                if (!db::preparedStmt(query, db::escapeString(name), db::escapeString(cmdname), db::escapeString(cmdlinestr)))
                {
                    ShowError("cmdhandler::call: Failed to log GM command.");
                }
            });
            // clang-format on
        }
    }

    // Ensure the onTrigger function exists for this command
    sol::function onTrigger = commandTable["onTrigger"];
    if (!onTrigger.valid())
    {
        ShowError("cmdhandler::call: (%s) missing onTrigger function", cmdname);
        return -1;
    }

    std::vector<CommandArg> args;

    // Prepare parameters
    std::string param;
    auto        parameter = parameters.cbegin();

    // Parse and push parameters based on symbol string
    while (parameter != parameters.cend() && !clstream.eof())
    {
        clstream >> param;

        switch (*parameter)
        {
            case 'b':
                args.emplace_back(std::string(commandline));
                break;

            case 's':
                if (parameters.size() == 1)
                {
                    std::string str = param;
                    while (!clstream.eof())
                    {
                        clstream >> param;
                        str += " " + param;
                    }
                    args.emplace_back(str);
                    break;
                }
                args.emplace_back(param);
                break;

            case 'i':
                args.emplace_back(atoi(param.c_str()));
                break;

            case 'd':
                args.emplace_back(atof(param.c_str()));
                break;

            default:
                ShowError("cmdhandler::call: (%s) undefined type for param: symbol: %s", cmdname.c_str(), *parameter);
                break;
        }

        ++parameter;
    }

    // Call the function
    auto result = onTrigger(PChar, sol::as_args(args));
    if (!result.valid())
    {
        sol::error err = result;
        ShowError("cmdhandler::call: (%s) error: %s", cmdname.c_str(), err.what());
        return -1;
    }

    return 0;
}
