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

#include "lua_stub.h"

#include "common/logging.h"
#include "common/lua.h"
#include "map/lua/sol_bindings.h"

// Stubs can replace a Lua function entirely, provide a fixed return value, or run side effects alongside the original.
// Priority order is: implementation > returnValue > original
// Possess all the features of a spy as well.
CLuaStub::CLuaStub(const std::string& path, const sol::object& originalFunc, sol::optional<sol::object> impl)
: CLuaSpy(path, originalFunc)
{
    if (impl.has_value() && impl.value().valid() && impl.value() != sol::lua_nil)
    {
        if (impl.value().get_type() == sol::type::function)
        {
            // Function passed to constructor is a replacement implementation
            implementation_ = impl.value().as<sol::protected_function>();
        }
        else
        {
            // Non-function value is a fixed return value
            returnValue_ = impl.value();
        }
    }
}

CLuaStub::~CLuaStub() = default;

/************************************************************************
 *  Function: stub() (__call)
 *  Purpose : Intercepts calls to a Lua function, allowing replacement, side effects, or fixed return value
 *  Example : local s = stub('xi.my.global.function', 42)
 *  Notes   :
 ************************************************************************/

auto CLuaStub::operator()(sol::variadic_args args) -> sol::as_returns_t<std::vector<sol::object>>
{
    DebugTestFmt("Stub function called for path: {}", path_);

    // Priority order:
    // 1. Replacement implementation (completely replaces function)
    // 2. Fixed return value (returns constant without calling anything)
    // 3. Side effect (executes alongside original)
    // 4. Original function (if nothing else is set)

    if (implementation_.has_value())
    {
        // Execute the replacement implementation
        const auto result = implementation_.value()(args);
        if (result.valid())
        {
            recordCall(args, result.get<sol::object>(0));
            // Extract all return values into a vector and return them
            std::vector<sol::object> returnValues;
            for (int i = 0; i < result.return_count(); ++i)
            {
                returnValues.push_back(result.get<sol::object>(i));
            }
            return sol::as_returns(std::move(returnValues));
        }
    }
    else if (returnValue_.has_value())
    {
        // Return the stubbed value without calling anything
        recordCall(args, returnValue_.value());
        // Return single value
        std::vector<sol::object> returnValues{ returnValue_.value() };
        return sol::as_returns(std::move(returnValues));
    }
    else if (sideEffect_.has_value())
    {
        // Execute the side effect (for its side effects)
        sideEffect_.value()(args);

        // But return the original function's result
        const auto result = originalFunc_(args);
        if (result.valid())
        {
            recordCall(args, result.get<sol::object>(0));
            std::vector<sol::object> returnValues;
            for (int i = 0; i < result.return_count(); ++i)
            {
                returnValues.push_back(result.get<sol::object>(i));
            }
            return sol::as_returns(std::move(returnValues));
        }
    }
    else
    {
        // No stub behavior defined, call original
        const auto result = originalFunc_(args);
        if (result.valid())
        {
            recordCall(args, result.get<sol::object>(0));
            std::vector<sol::object> returnValues;
            for (int i = 0; i < result.return_count(); ++i)
            {
                returnValues.push_back(result.get<sol::object>(i));
            }
            return sol::as_returns(std::move(returnValues));
        }
    }

    recordCall(args, sol::nullopt);
    // Return empty (no values)
    std::vector<sol::object> empty;
    return sol::as_returns(std::move(empty));
}

/************************************************************************
 *  Function: returnValue()
 *  Purpose : Assigns a fixed return value for the stub
 *  Example : s:returnValue(42)
 *  Notes   :
 ************************************************************************/

void CLuaStub::returnValue(const sol::object& value)
{
    returnValue_    = value;
    implementation_ = sol::nullopt;
}

/************************************************************************
 *  Function: sideEffect()
 *  Purpose : Sets side effect function to run alongside the original
 *  Example : s:sideEffect(function() end)
 *  Notes   :
 ************************************************************************/

void CLuaStub::sideEffect(const sol::protected_function& func)
{
    sideEffect_     = func;
    returnValue_    = sol::nullopt;
    implementation_ = sol::nullopt;
}

void CLuaStub::Register()
{
    SOL_USERTYPE_INHERIT("CStub", CLuaStub, CLuaSpy);
    SOL_REGISTER("returnValue", CLuaStub::returnValue);
    SOL_REGISTER("sideEffect", CLuaStub::sideEffect);
    SOL_REGISTER(sol::meta_function::call, CLuaStub::operator());
}
