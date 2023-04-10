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

namespace
{
    std::unordered_map<std::string, std::string> registeredCommands;
}

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

    // On the way out of this function, clear the globals it leaves behind
    // clang-format off
    ScopeGuard guard([&]()
    {
        lua.set("onTrigger", sol::lua_nil);
        lua.set("cmdprops", sol::lua_nil);
    });
    // clang-format on

    // Before we begin, make sure these globals are cleared (just in case!)
    lua.set("onTrigger", sol::lua_nil);
    lua.set("cmdprops", sol::lua_nil);

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

    auto filename = fmt::format("./scripts/commands/{}.lua", cmdname.c_str());
    if (auto maybeRegisteredCommand = registeredCommands.find(cmdname);
        maybeRegisteredCommand != registeredCommands.end())
    {
        filename = (*maybeRegisteredCommand).second;
    }

    auto loadResult = lua.safe_script_file(filename);
    if (!loadResult.valid())
    {
        sol::error err = loadResult;
        ShowError("cmdhandler::call: (%s): %s", cmdname.c_str(), err.what());
        return -1;
    }

    if (!lua["cmdprops"].valid())
    {
        ShowError("cmdhandler::call: (%s): Undefined 'cmdprops' table", cmdname.c_str());
        return -1;
    }

    if (!lua["cmdprops"]["permission"].valid())
    {
        ShowError("cmdhandler::call: (%s): Invalid or no permission field set in cmdprops", cmdname.c_str());
        return -1;
    }

    if (!lua["cmdprops"]["parameters"].valid())
    {
        ShowError("cmdhandler::call: (%s): Invalid or no parameters field set in cmdprops", cmdname.c_str());
        return -1;
    }

    int8        permission = lua["cmdprops"]["permission"];
    std::string parameters = lua["cmdprops"]["parameters"];

    // Ensure this user can use this command
    if (permission > PChar->m_GMlevel)
    {
        ShowWarning("cmdhandler::call: Character %s attempting to use higher permission command %s", PChar->name.c_str(), cmdname.c_str());
        return -1;
    }
    else
    {
        if (settings::get<uint8>("map.AUDIT_GM_CMD") <= permission && settings::get<uint8>("map.AUDIT_GM_CMD") > 0)
        {
            std::string name       = PChar->name;
            std::string cmdlinestr = autotranslate::replaceBytes(commandline);

            // clang-format off
            Async::getInstance()->query([name, cmdname, cmdlinestr](SqlConnection* _sql)
            {
                auto escaped_name        = _sql->EscapeString(name);
                auto escaped_cmdname     = _sql->EscapeString(cmdname);
                auto escaped_commandline = _sql->EscapeString(cmdlinestr);

                const char* fmtQuery = "INSERT into audit_gm (date_time,gm_name,command,full_string) VALUES(current_timestamp(),'%s','%s','%s')";
                if (_sql->Query(fmtQuery, escaped_name.data(), escaped_cmdname.data(), escaped_commandline.data()) == SQL_ERROR)
                {
                    ShowError("cmdhandler::call: Failed to log GM command.");
                }
            });
            // clang-format on
        }
    }

    // Ensure the onTrigger function exists for this command
    auto onTrigger = lua.get<sol::function>("onTrigger");
    if (!onTrigger.valid())
    {
        ShowError("cmdhandler::call: (%s) missing onTrigger function", cmdname.c_str());
        return -1;
    }

    std::vector<CommandArg> args;

    // Prepare parameters
    std::string param;
    std::string cmdparameters(parameters);
    auto        parameter = cmdparameters.cbegin();

    // Parse and push parameters based on symbol string
    while (parameter != cmdparameters.cend() && !clstream.eof())
    {
        clstream >> param;

        switch (*parameter)
        {
            case 'b':
                args.emplace_back(std::string(commandline));
                break;

            case 's':
                if (cmdparameters.size() == 1)
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
                ShowError("cmdhandler::call: (%s) undefined type for param; symbol: %s", cmdname.c_str(), *parameter);
                break;
        }

        ++parameter;
    }

    // Call the function
    auto result = onTrigger(CLuaBaseEntity(PChar), sol::as_args(args));
    if (!result.valid())
    {
        sol::error err = result;
        ShowError("cmdhandler::call: (%s) error: %s", cmdname.c_str(), err.what());
        return -1;
    }

    return 0;
}

void CCommandHandler::registerCommand(std::string const& commandName, std::string const& path)
{
    registeredCommands[commandName] = path;
    lua["cmdprops"]                 = sol::lua_nil;
    lua["onTrigger"]                = sol::lua_nil;
}
