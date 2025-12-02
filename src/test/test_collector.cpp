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

#include "test_collector.h"
#include "common/logging.h"
#include "common/lua.h"
#include "common/tracy.h"
#include "reporters/reporter_container.h"
#include <algorithm>
#include <chrono>
#include <format>

using namespace std::chrono_literals;

namespace
{

constexpr auto SUITES_PATH = "scripts/tests";

} // namespace

TestCollector::TestCollector(const FilterConfig& filters, ReporterContainer& reporters)
: rootSuite_("root", "")
, currentSuite_(&rootSuite_)
, matcher_(filters)
, reporters_(reporters)
{
    TracyZoneScoped;

    registerTestFramework();

    auto testFiles = collectTestFiles();
    for (const auto& filePath : testFiles)
    {
        loadTestFile(filePath);
    }

    countTestsAndSuites();
    ShowInfoFmt("Collected {} tests in {} suites", totalTests_, totalSuites_);
}

auto TestCollector::totalTests() const -> size_t
{
    return totalTests_;
}

auto TestCollector::totalSuites() const -> size_t
{
    return totalSuites_;
}

auto TestCollector::rootSuite() const -> const TestSuite&
{
    return rootSuite_;
}

auto TestCollector::collectTestFiles() const -> std::vector<std::filesystem::path>
{
    std::vector<std::filesystem::path> luaFiles;

    if (!std::filesystem::exists(SUITES_PATH))
    {
        ShowWarningFmt("Test suites path does not exist: {}", SUITES_PATH);
        return luaFiles;
    }

    // Collect all .lua files and apply pattern filters
    for (const auto& entry : std::filesystem::recursive_directory_iterator(SUITES_PATH))
    {
        if (entry.is_regular_file())
        {
            if (const auto& path = entry.path(); path.extension() == ".lua" && !matcher_.shouldSkipFile(path))
            {
                luaFiles.push_back(path);
            }
        }
    }

    std::ranges::sort(luaFiles);

    return luaFiles;
}

void TestCollector::loadTestFile(const std::filesystem::path& filePath)
{
    TracyZoneScoped;
    TracyZoneString(filePath.generic_string());

    // Normalize path to forward slashes and build hierarchical suite name from path
    currentFile_                             = filePath.generic_string();
    const std::filesystem::path relativePath = std::filesystem::relative(filePath, SUITES_PATH);
    std::string                 pathSuiteName;

    // Build suite name from folder path (excluding filename)
    std::vector<std::string> pathComponents;
    for (const auto& component : relativePath)
    {
        pathComponents.push_back(component.string());
    }

    // Build suite name from all components except the last (filename)
    for (size_t i = 0; i < pathComponents.size() - 1; ++i)
    {
        if (!pathSuiteName.empty())
        {
            pathSuiteName += "::";
        }

        pathSuiteName += pathComponents[i];
    }

    // Create a root suite for this file path if we have folders
    if (!pathSuiteName.empty())
    {
        auto& pathSuite = rootSuite_.addChildSuite(pathSuiteName);
        currentSuite_   = &pathSuite;
    }
    else
    {
        // File is directly in suites folder
        currentSuite_ = &rootSuite_;
    }

    if (const auto result = lua.safe_script_file(filePath.string(), &sol::script_pass_on_error); !result.valid())
    {
        const sol::error err = result;
        ShowErrorFmt("Failed to load test file '{}': {}", filePath.string(), err.what());

        // Create a suite for this file with a single failing test to track the loading error
        auto& failedSuite = currentSuite_->addChildSuite(filePath.stem().string());
        failedSuite.addTestCase("File Loading", std::nullopt);

        // Report it immediately as a failure
        reporters_.onSuiteStart(failedSuite);
        reporters_.onSuiteEnd(failedSuite, 0ms);
    }

    // Reset to root for next file
    currentSuite_ = &rootSuite_;
}

void TestCollector::registerTestFramework()
{
    // describe: Defines a new test suite. Multiple levels of nesting are supported.
    lua.set_function(
        "describe",
        [this](const std::string& name, const sol::protected_function& callback)
        {
            // Add child suite with parent reference
            TestSuite& newSuite = currentSuite_->addChildSuite(name);
            newSuite.setSourceFile(currentFile_);

            // Set as current suite for nested calls
            const auto previousSuite = currentSuite_;
            currentSuite_            = &newSuite;

            // Create environment for this describe block
            sol::environment describeEnv;

            if (currentEnvironment_.has_value())
            {
                // Create environment that inherits from parent
                describeEnv = sol::environment(lua, sol::create, currentEnvironment_.value());
            }
            else
            {
                // Top-level describe inherits from global
                describeEnv = sol::environment(lua, sol::create, lua.globals());
            }

            // Store the environment in the suite
            newSuite.setEnvironment(describeEnv);
            sol::set_environment(describeEnv, callback);

            // Track current environment for nested describes
            const auto previousEnvironment = currentEnvironment_;
            currentEnvironment_            = describeEnv;

            // Execute the callback to collect nested describes/its
            if (const auto result = callback(); !result.valid())
            {
                const sol::error err = result;
                ShowErrorFmt("Failed to execute describe block '{}': {}", name, err.what());

                // Create a failing test for the describe block error
                newSuite.addTestCase("Describe Setup", std::nullopt);
            }

            // Restore previous environment and suite
            currentEnvironment_ = previousEnvironment;
            currentSuite_       = previousSuite;
        });

    // it: Defines a new test case within the current suite
    lua.set_function(
        "it",
        [this](const std::string& name, const sol::protected_function& testFunc)
        {
            auto& testCase = currentSuite_->addTestCase(name, testFunc);

            // Check if this test should be skipped based on filters
            if (matcher_.shouldSkipTest(std::format("{}::{}", currentSuite_->fullName(), name)))
            {
                testCase.markAsSkipped();
            }
        });

    // before_each: Function to run before each test in the current suite
    lua.set_function(
        "before_each",
        [this](const sol::protected_function& setupFunc)
        {
            currentSuite_->setBeforeEachFunc(setupFunc);
        });

    // after_each: Function to run after each test in the current suite
    lua.set_function(
        "after_each",
        [this](const sol::protected_function& teardownFunc)
        {
            currentSuite_->setAfterEachFunc(teardownFunc);
        });

    // setup: Function to run once before all tests in the current suite
    lua.set_function(
        "setup",
        [this](const sol::protected_function& setupFunc)
        {
            currentSuite_->setSetupFunc(setupFunc);
        });

    // teardown: Function to run once after all tests in the current suite
    lua.set_function(
        "teardown",
        [this](const sol::protected_function& teardownFunc)
        {
            currentSuite_->setTeardownFunc(teardownFunc);
        });
}

void TestCollector::countTestsAndSuites()
{
    countSuite(rootSuite_, 0);
}

void TestCollector::countSuite(const TestSuite& suite, const int depth)
{
    if (depth > 0)
    { // Don't count root suite
        totalSuites_++;
    }

    totalTests_ += suite.testCases().size();
    for (const auto& child : suite.childSuites())
    {
        countSuite(child, depth + 1);
    }
}
