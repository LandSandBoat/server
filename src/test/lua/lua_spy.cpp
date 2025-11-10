/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "lua_spy.h"

#include "common/logging.h"
#include "common/lua.h"
#include "map/lua/sol_bindings.h"
#include "test_common.h"

#include <sstream>

// Spies observe calls to Lua functions, recording arguments and return values for later inspection.
CLuaSpy::CLuaSpy(const std::string& path, const sol::object& originalFunc)
: path_(path)
, original_(originalFunc)
{
    if (!originalFunc.valid() || originalFunc == sol::lua_nil)
    {
        TestError("Spy target '{}' does not exist", path);
        return;
    }

    originalFunc_ = originalFunc.as<sol::protected_function>();
    calls_        = lua.create_table();
}

CLuaSpy::~CLuaSpy() = default;

auto CLuaSpy::original() const -> sol::object
{
    return original_;
}

auto CLuaSpy::path() const -> std::string
{
    return path_;
}

/************************************************************************
 *  Function: spy() (__call)
 *  Purpose : Intercepts calls to a Lua function, recording args and return value
 *  Example : local s = spy('xi.my.global.function')
 *  Notes   :
 ************************************************************************/

auto CLuaSpy::operator()(sol::variadic_args args) -> sol::object
{
    DebugTestFmt("Spy function called for path: {}", path_);

    const auto result      = originalFunc_(args);
    auto       returnValue = sol::object(sol::lua_nil);
    if (result.valid())
    {
        returnValue = result;
    }

    recordCall(args, returnValue);

    DebugTestFmt("Spy returning value for path: {}", path_);
    return returnValue;
}

// Records a call with its arguments and return value.
void CLuaSpy::recordCall(sol::variadic_args args, sol::optional<sol::object> returnValue)
{
    // Record the call
    sol::table callInfo = lua.create_table();
    sol::table argTable = lua.create_table();

    int i = 1;
    for (auto arg : args)
    {
        argTable.raw_set(i, sol::object(arg));
        i++;
    }

    callInfo["args"] = argTable;

    if (returnValue.has_value() && returnValue.value().valid())
    {
        callInfo["returned"] = returnValue.value();
    }

    calls_[calls_.size() + 1] = callInfo;
}

/************************************************************************
 *  Function: clear()
 *  Purpose : Clears all recorded calls
 *  Example : s:clear()
 *  Notes   : Does not unset the spy
 ************************************************************************/

void CLuaSpy::clear()
{
    calls_ = lua.create_table();
}

/************************************************************************
 *  Function: called()
 *  Purpose : Asserts that the spy was called (optionally a specific number of times)
 *  Example : s:called(3)
 *  Notes   :
 ************************************************************************/

void CLuaSpy::called(sol::optional<size_t> times)
{
    size_t count = calls_.size();

    if (times.has_value())
    {
        // Check for exact number of calls
        if (count != times.value())
        {
            TestError("Spy '{}' was called {} time(s), expected {}",
                      path_,
                      count,
                      times.value());
        }
    }
    else
    {
        if (count == 0)
        {
            TestError("Spy '{}' was never called", path_);
        }
    }
}

/************************************************************************
 *  Function: calledWith()
 *  Purpose : Asserts that the spy was called with specific parameters
 *  Example : s:calledWith(arg1, arg2, ...)
 *  Notes   : Will match any call with the exact arguments provided
 *          : Userdata is matched by tostring() representation
 ************************************************************************/

void CLuaSpy::calledWith(sol::variadic_args expected) const
{
    auto formatValue = [](const sol::object& obj) -> std::string
    {
        switch (obj.get_type())
        {
            case sol::type::userdata:
                return lua["tostring"](obj).get<std::string>();
            case sol::type::number:
                return std::to_string(obj.as<double>());
            case sol::type::string:
                return "\"" + obj.as<std::string>() + "\"";
            case sol::type::boolean:
                return obj.as<bool>() ? "true" : "false";
            case sol::type::lua_nil:
                return "nil";
            default:
                return "<" + std::string(sol::type_name(lua.lua_state(), obj.get_type())) + ">";
        }
    };

    auto formatArgs = [&formatValue](auto args_range) -> std::string
    {
        std::stringstream ss;
        ss << "(";
        bool first = true;
        for (const auto& arg : args_range)
        {
            if (!first)
            {
                ss << ", ";
            }
            ss << formatValue(sol::object(arg));
            first = false;
        }

        ss << ")";

        return ss.str();
    };

    // Check if any call matches the expected arguments
    for (auto& [_, call] : calls_)
    {
        sol::table callInfo = call;
        sol::table args     = callInfo["args"];

        if (args.size() != expected.size())
        {
            continue;
        }

        bool matches = true;
        int  i       = 1;
        for (const auto& exp : expected)
        {
            auto        argVal = args.raw_get<sol::object>(i++);
            sol::object expVal = exp;

            if (!argVal.valid() || !expVal.valid())
            {
                matches = false;
                break;
            }

            // Special handling for userdata comparison
            if (argVal.get_type() == sol::type::userdata && expVal.get_type() == sol::type::userdata)
            {
                if (lua["tostring"](argVal).get<std::string>() != lua["tostring"](expVal).get<std::string>())
                {
                    matches = false;
                    break;
                }
            }
            else if (argVal != expVal)
            {
                matches = false;
                break;
            }
        }

        if (matches)
        {
            return; // Found a matching call
        }
    }

    // Build error message
    std::stringstream error;
    error << "Spy '" << path_ << "' was not called with expected arguments\n";
    error << "Expected: " << formatArgs(expected) << "\n";

    if (calls_.size() == 0)
    {
        error << "Function was never called";
    }
    else
    {
        error << "Function was called " << calls_.size() << " time(s) with:\n";
        int callNum = 1;
        for (auto& [_, call] : calls_)
        {
            sol::table callInfo = call;
            sol::table args     = callInfo["args"];
            error << "  Call " << callNum++ << ": (";

            bool first = true;
            for (size_t i = 1; i <= args.size(); i++)
            {
                if (!first)
                {
                    error << ", ";
                }
                error << formatValue(args.raw_get<sol::object>(i));
                first = false;
            }
            error << ")\n";
        }
    }

    TestError("{}", error.str());
}

void CLuaSpy::Register()
{
    SOL_USERTYPE("CSpy", CLuaSpy);
    SOL_REGISTER("called", CLuaSpy::called);
    SOL_REGISTER("calledWith", CLuaSpy::calledWith);
    SOL_REGISTER("clear", CLuaSpy::clear);
    SOL_REGISTER(sol::meta_function::call, CLuaSpy::operator());
    SOL_READONLY("calls", CLuaSpy::calls);
}
