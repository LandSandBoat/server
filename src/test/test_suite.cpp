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

#include "test_suite.h"
#include "common/logging.h"
#include <format>
#include <utility>

// Collection of test cases and child suites.
// Suites can be nested to any depth.
TestSuite::TestSuite(const std::string& name, const std::string& fullPath, TestSuite* parent)
: name_(name)
, fullPath_(fullPath.empty() ? name : fullPath)
, parent_(parent)
{
}

// Add a nested suite
auto TestSuite::addChildSuite(const std::string& name) -> TestSuite&
{
    // For root suite (no parent), don't add prefix
    auto fullPath = parent_ ? std::format("{}::{}", fullPath_, name) : name;
    childSuites_.emplace_back(name, fullPath, this);
    return childSuites_.back();
}

// Add a test case to this suite
auto TestSuite::addTestCase(const std::string& name, std::optional<sol::protected_function> func) -> TestCase&
{
    testCases_.emplace_back(name, std::move(func), fullPath_);
    return testCases_.back();
}

void TestSuite::setHookFunction(sol::protected_function& target, sol::protected_function func, const std::string& hookName)
{
    if (target.valid())
    {
        ShowErrorFmt("Test suite '{}' already has a {} function defined. Only one {} function is allowed per suite.",
                     fullPath_,
                     hookName,
                     hookName);
        return;
    }
    target = std::move(func);
}

void TestSuite::setSetupFunc(sol::protected_function func)
{
    setHookFunction(setupFunc_, std::move(func), "setup");
}

void TestSuite::setTeardownFunc(sol::protected_function func)
{
    setHookFunction(teardownFunc_, std::move(func), "teardown");
}

void TestSuite::setBeforeEachFunc(sol::protected_function func)
{
    setHookFunction(beforeEachFunc_, std::move(func), "beforeEach");
}

void TestSuite::setAfterEachFunc(sol::protected_function func)
{
    setHookFunction(afterEachFunc_, std::move(func), "afterEach");
}

// Sets the Lua environment for this suite and its children
void TestSuite::setEnvironment(sol::environment env)
{
    environment_ = std::move(env);
}

// Immediate parent suite, or nullptr if this is the root suite
auto TestSuite::parent() const -> TestSuite*
{
    return parent_;
}

void TestSuite::setSourceFile(const std::string& filePath)
{
    sourceFile_ = filePath;
}

auto TestSuite::sourceFile() const -> const std::string&
{
    return sourceFile_;
}

auto TestSuite::fullName() const -> std::string
{
    return fullPath_;
}

auto TestSuite::name() const -> std::string
{
    return name_;
}

auto TestSuite::childSuites() const -> const std::vector<TestSuite>&
{
    return childSuites_;
}

auto TestSuite::testCases() const -> const std::vector<TestCase>&
{
    return testCases_;
}

auto TestSuite::setupFunc() const -> sol::protected_function
{
    return setupFunc_;
}

auto TestSuite::teardownFunc() const -> sol::protected_function
{
    return teardownFunc_;
}

auto TestSuite::beforeEachFunc() const -> sol::protected_function
{
    return beforeEachFunc_;
}

auto TestSuite::afterEachFunc() const -> sol::protected_function
{
    return afterEachFunc_;
}
