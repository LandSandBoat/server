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

#include <optional>
#include <sol/sol.hpp>
#include <string>

class TestCase
{
public:
    TestCase(std::string name, std::optional<sol::protected_function> func, std::string parentPath);

    auto fullName() const -> std::string;
    auto name() const -> const std::string&;
    auto testFunc() const -> const std::optional<sol::protected_function>&;
    auto isSkipped() const -> bool;
    void markAsSkipped();

private:
    std::string                            name_;
    std::optional<sol::protected_function> testFunc_;
    std::string                            parentPath_;
    bool                                   skipped_ = false;
};
