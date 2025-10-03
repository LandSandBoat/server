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

#include "test_case.h"
#include <utility>

#include <format>

TestCase::TestCase(std::string name, std::optional<sol::protected_function> func, std::string parentPath)
: name_(std::move(name))
, testFunc_(std::move(func))
, parentPath_(std::move(parentPath))
{
}

auto TestCase::fullName() const -> std::string
{
    return parentPath_.empty() ? name_ : std::format("{} > {}", parentPath_, name_);
}

auto TestCase::name() const -> const std::string&
{
    return name_;
}

auto TestCase::testFunc() const -> const std::optional<sol::protected_function>&
{
    return testFunc_;
}

auto TestCase::isSkipped() const -> bool
{
    return skipped_;
}

void TestCase::markAsSkipped()
{
    skipped_ = true;
}
