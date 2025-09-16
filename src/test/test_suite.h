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

#include "test_case.h"
#include <sol/sol.hpp>
#include <string>
#include <vector>

class TestSuite
{
public:
    explicit TestSuite(const std::string& name, const std::string& fullPath = "", TestSuite* parent = nullptr);

    auto addChildSuite(const std::string& name) -> TestSuite&;
    auto addTestCase(const std::string& name, std::optional<sol::protected_function> func) -> TestCase&;

    void setSetupFunc(sol::protected_function func);
    void setTeardownFunc(sol::protected_function func);
    void setBeforeEachFunc(sol::protected_function func);
    void setAfterEachFunc(sol::protected_function func);

    auto fullName() const -> std::string;
    auto name() const -> std::string;
    auto childSuites() const -> const std::vector<TestSuite>&;
    auto testCases() const -> const std::vector<TestCase>&;

    auto setupFunc() const -> sol::protected_function;
    auto teardownFunc() const -> sol::protected_function;
    auto beforeEachFunc() const -> sol::protected_function;
    auto afterEachFunc() const -> sol::protected_function;

    void setEnvironment(sol::environment env);
    auto parent() const -> TestSuite*;

    void setSourceFile(const std::string& filePath);
    auto sourceFile() const -> const std::string&;

private:
    void setHookFunction(sol::protected_function& target, sol::protected_function func, const std::string& hookName);

    std::string            name_;
    std::string            fullPath_;
    std::string            sourceFile_;
    std::vector<TestCase>  testCases_;
    std::vector<TestSuite> childSuites_;

    sol::protected_function setupFunc_;
    sol::protected_function teardownFunc_;
    sol::protected_function beforeEachFunc_;
    sol::protected_function afterEachFunc_;

    TestSuite*       parent_;
    sol::environment environment_;
};
