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

#pragma once

#include <sol/sol.hpp>
#include <string>

class CLuaSpy
{
public:
    CLuaSpy(const std::string& path, const sol::object& originalFunc);
    virtual ~CLuaSpy();

    void called(sol::optional<size_t> times = sol::nullopt);
    void calledWith(sol::variadic_args expected) const;
    void clear();
    auto calls() const -> sol::table
    {
        return calls_;
    }

    auto original() const -> sol::object;
    auto path() const -> std::string;

    virtual auto operator()(sol::variadic_args args) -> sol::as_returns_t<std::vector<sol::object>>;
    static void  Register();

protected:
    void recordCall(sol::variadic_args args, sol::optional<sol::object> returnValue = sol::nullopt);

    std::string             path_;
    sol::object             original_;
    sol::protected_function originalFunc_;
    sol::table              calls_;
};
