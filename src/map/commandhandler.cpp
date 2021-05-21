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

#include "commandhandler.h"

#include "entities/charentity.h"
#include "fmt/format.h"
#include "lua/luautils.h"
#include "lua/lua_baseentity.h"

#include <sstream>

int32 CCommandHandler::call(sol::state& lua, CCharEntity* PChar, const int8* commandline)
{
    auto top = lua_gettop(lua.lua_state());

    std::istringstream clstream((char*)commandline);
    std::string        cmdname;

    clstream >> cmdname;

    if (!PChar)
    {
        ShowError("cmdhandler::call: nullptr character attempted to use command\n");

        lua_settop(lua.lua_state(), top);
        return -1;
    }

    if (cmdname.empty())
    {
        ShowError("cmdhandler::call: function name was empty\n");

        lua_settop(lua.lua_state(), top);
        return -1;
    }

    // Nil out any existing global instances of onTrigger before anything else!
    lua.set("onTrigger", sol::lua_nil);

    auto filename = fmt::format("./scripts/commands/{}.lua", cmdname.c_str());
    auto result   = lua.script_file(filename);
    if (!result.valid())
    {
        sol::error err = result;
        ShowError("cmdhandler::call: (%s): %s\n", cmdname.c_str(),err.what());

        lua_settop(lua.lua_state(), top);
        return -1;
    }

    if (!lua["cmdprops"].valid())
    {
        ShowError("cmdhandler::call: (%s): Undefined 'cmdprops' table\n", cmdname.c_str());

        lua_settop(lua.lua_state(), top);
        return -1;
    }

    if (!lua["cmdprops"]["permission"].valid())
    {
        ShowError("cmdhandler::call: (%s): Invalid or no permission field set in cmdprops\n", cmdname.c_str());

        // Delete the cmdprops table..
        lua_pushnil(lua.lua_state());
        lua_setglobal(lua.lua_state(), "cmdprops");

        lua_settop(lua.lua_state(), top);
        return -1;
    }

    if (!lua["cmdprops"]["parameters"].valid())
    {
        ShowError("cmdhandler::call: (%s): Invalid or no parameters field set in cmdprops\n", cmdname.c_str());

        // Delete the cmdprops table..
        lua_pushnil(lua.lua_state());
        lua_setglobal(lua.lua_state(), "cmdprops");

        lua_settop(lua.lua_state(), top);
        return -1;
    }

    int8 permission = lua["cmdprops"]["permission"];
    std::string parameters = lua["cmdprops"]["parameters"];

    // Ensure this user can use this command..
    if (permission > PChar->m_GMlevel)
    {
        ShowWarning("cmdhandler::call: Character %s attempting to use higher permission command %s\n", PChar->name.c_str(), cmdname.c_str());

        // Delete the cmdprops table..
        lua_pushnil(lua.lua_state());
        lua_setglobal(lua.lua_state(), "cmdprops");

        lua_settop(lua.lua_state(), top);
        return -1;
    }
    else
    {
        if (map_config.audit_gm_cmd <= permission && map_config.audit_gm_cmd > 0)
        {
            char escaped_name[16 * 2 + 1];
            Sql_EscapeString(SqlHandle, escaped_name, PChar->name.c_str());

            std::string escaped_gm_cmd;
            escaped_gm_cmd.reserve(cmdname.length() * 2 + 1);
            Sql_EscapeString(SqlHandle, escaped_gm_cmd.data(), (char*)cmdname.c_str());

            std::string escaped_full_string;
            escaped_full_string.reserve(strlen((char*)commandline) * 2 + 1);
            Sql_EscapeString(SqlHandle, escaped_full_string.data(), (char*)commandline);

            const char* fmtQuery = "INSERT into audit_gm (date_time,gm_name,command,full_string) VALUES(current_timestamp(),'%s','%s','%s')";
            if (Sql_Query(SqlHandle, fmtQuery, escaped_name, escaped_gm_cmd.data(), escaped_full_string.data()) == SQL_ERROR)
            {
                ShowError("cmdhandler::call: Failed to log GM command.\n");
            }
        }
    }

    // Ensure the onTrigger function exists for this command..
    auto onTrigger = lua.get<sol::function>("onTrigger");
    if (!onTrigger.valid())
    {
        ShowError("cmdhandler::call: (%s) missing onTrigger function\n", cmdname.c_str());

        // Delete the cmdprops table..
        lua_pushnil(lua.lua_state());
        lua_setglobal(lua.lua_state(), "cmdprops");

        lua_settop(lua.lua_state(), top);
        return -1;
    }

    sol::stack::push(lua.lua_state(), onTrigger);

    // Push the calling character
    sol::stack::push<CLuaBaseEntity>(lua.lua_state(), CLuaBaseEntity(PChar));
    int32 cntparam = 1;

    // Prepare parameters..
    std::string                 param;
    std::string                 cmdparameters(parameters);
    std::string::const_iterator parameter = cmdparameters.cbegin();

    // Parse and push parameters based on symbol string..
    while (parameter != cmdparameters.cend() && !clstream.eof())
    {
        clstream >> param;

        switch (*parameter)
        {
            case 'b':
                sol::stack::push<std::string>(lua.lua_state(), (const char*)commandline);
                ++cntparam;
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
                    sol::stack::push<std::string>(lua.lua_state(), str);
                    ++cntparam;
                    break;
                }
                sol::stack::push<std::string>(lua.lua_state(), param);
                ++cntparam;
                break;

            case 'i':
                sol::stack::push<int>(lua.lua_state(), atoi(param.c_str()));
                ++cntparam;
                break;

            case 'd':
                sol::stack::push<float>(lua.lua_state(), atof(param.c_str()));
                ++cntparam;
                break;

            default:
                ShowError("cmdhandler::call: (%s) undefined type for param; symbol: %s\n", cmdname.c_str(), *parameter);
                break;
        }

        ++parameter;
    }

    // Call the function..
    int32 status = lua_pcall(lua.lua_state(), cntparam, 0, 0);
    if (status)
    {
        ShowError("cmdhandler::call: (%s) error: %s\n", cmdname.c_str(), lua_tostring(lua.lua_state(), -1));
        lua_pop(lua.lua_state(), -1);

        // Delete the cmdprops table..
        lua_pushnil(lua.lua_state());
        lua_setglobal(lua.lua_state(), "cmdprops");

        lua_settop(lua.lua_state(), top);
        return -1;
    }

    // Delete the cmdprops table..
    lua_pushnil(lua.lua_state());
    lua_setglobal(lua.lua_state(), "cmdprops");

    lua_settop(lua.lua_state(), top);
    return 0;
}
