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

#include "test_engine.h"
#include "common/logging.h"
#include "common/lua.h"
#include "common/settings.h"
#include "common/tracy.h"
#include "enums/test_status.h"
#include "in_memory_sink.h"
#include "lua/lua_simulation.h"
#include "map/utils/zoneutils.h"
#include "reporters/reporter_container.h"
#include "test_char.h"
#include "test_suite.h"

#include <chrono>
#include <format>
#include <sol/sol.hpp>
#include <spdlog/spdlog.h>
#include <utility>
#include <vector>

TestEngine::TestEngine(asio::io_context& io_context, TestConfig testConfig)
: worldEngine_(std::make_unique<WorldEngine>(io_context))
, mockManager_(std::make_unique<MockManager>())
, testConfig_(std::move(testConfig))
, reporters_(testConfig_.verbose, testConfig_.output)
{
    TestChar::clean();

    // Unset specific settings that conflict with tests
    lua["xi"]["settings"]["main"]["NEW_CHARACTER_CUTSCENE"] = 0;
    lua["xi"]["settings"]["main"]["ALL_MAPS"]               = 0;

    // Without a world server actively pumping the queues,
    // the embedded map server deadlocks on exit
    //
    // We will need this to work to support multiprocess tests and validating systems that rely on world server.
    // However, that requires deeper rework to the IPP logic so we can smartly route messages during tests.
    auto mapConfig = MapConfig{
        .isTestServer      = true,
        .lazyZones         = true,
        .controlledWeather = true,
    };

    mapEngine_ = std::make_unique<MapEngine>(io_context, mapConfig);

    worldEngine_->onInitialize();
    mapEngine_->onInitialize();

    // Initialize Lua environment after engines are ready
    luaEnvironment_ = std::make_unique<TestLuaEnvironment>(mockManager_.get());

    // Create simulation instance
    simulation_ = std::make_unique<CLuaSimulation>(mapEngine_.get(), testConfig_.loggerSink);

    // Assign simulation to xi.test.world
    lua["xi"]["test"]          = lua.create_table();
    lua["xi"]["test"]["world"] = simulation_.get();

    // Collect all test suites
    testCollector_ = std::make_unique<TestCollector>(testConfig_.filters, reporters_);
}

TestEngine::~TestEngine() = default;

auto TestEngine::executeTests() -> bool
{
    TracyZoneScoped;

    TestResults results;
    const auto  runStartTime = std::chrono::steady_clock::now();

    // Execute all test suites
    const auto& rootSuite = testCollector_->rootSuite();
    for (const auto& suite : rootSuite.childSuites())
    {
        const HookContext baseContext{};
        const auto        suiteResults = executeSuite(suite, baseContext);

        results.total += suiteResults.total;
        results.passed += suiteResults.passed;
        results.failed += suiteResults.failed;

        simulation_->cleanClients();

        // Stop on first failure unless keep-going is set
        if (suiteResults.failed > 0 && !testConfig_.keepGoing)
        {
            ShowError("Stopping test execution due to failure (use --keep-going to continue)");
            break;
        }
    }

    // Calculate total run duration
    const auto runEndTime    = std::chrono::steady_clock::now();
    const auto totalDuration = std::chrono::duration_cast<std::chrono::milliseconds>(runEndTime - runStartTime);

    reporters_.onRunComplete(totalDuration);

    // Control the destruction order, else the program may hang.
    // TODO: Figure out why the ZMQ listeners hang on early exits.
    mapEngine_.reset();
    worldEngine_.reset();

    return results.failed == 0;
}

auto TestEngine::executeSuite(const TestSuite& suite, HookContext context) -> TestResults
{
    TracyZoneScoped;
    TracyZoneString(suite.fullName());

    TestResults results;
    auto        suiteStartTime = std::chrono::steady_clock::now();

    // Notify reporters of suite start
    reporters_.onSuiteStart(suite);

    // Add this suite's before_each to the context (accumulates as we go down)
    if (suite.beforeEachFunc().valid())
    {
        size_t depth = context.beforeEachHooks.size();
        context.beforeEachHooks.push_back({ suite.beforeEachFunc(), suite.name(), depth });
    }

    // Add this suite's after_each to the context (at the front, so it runs before parent hooks)
    if (suite.afterEachFunc().valid())
    {
        size_t depth = context.beforeEachHooks.empty() ? 0 : context.beforeEachHooks.size() - 1; // Use before_each depth since after runs in reverse
        context.afterEachHooks.emplace_front(suite.afterEachFunc(), suite.name(), depth);
    }

    // Run setup once for the suite
    if (suite.setupFunc().valid())
    {
        // Players created in setup() should persist across tests
        simulation_->setSetupContext(true);

        if (auto result = suite.setupFunc()(); !result.valid())
        {
            sol::error err = result;
            ShowErrorFmt("Setup failed for {}: {}", suite.name(), err.what());

            simulation_->setSetupContext(false);

            // Report the setup failure
            reportSetupTeardownFailure(suite, "setup()", fmt::format("Setup failed: {}", err.what()));

            results.total++;
            results.failed++;

            return results; // Skip this suite if setup fails
        }

        simulation_->setSetupContext(false);
    }

    // Execute all test cases in this suite with accumulated hooks
    for (const auto& testCase : suite.testCases())
    {
        if (testCase.isSkipped())
        {
            results.total++;
            results.skipped++;

            // Notify reporters
            reporters_.onTestSkipped(suite, testCase);

            continue;
        }

        results.total++;

        if (executeTestCase(testCase, context, suite))
        {
            results.passed++;
        }
        else
        {
            results.failed++;

            // Stop on first failure unless keep-going is set
            if (!testConfig_.keepGoing)
            {
                DebugTest("Stopping suite execution due to test failure");
                break;
            }
        }
    }

    // Execute nested suites, passing down the accumulated context
    for (const auto& childSuite : suite.childSuites())
    {
        auto [total, passed, failed, skipped] = executeSuite(childSuite, context);
        results.total += total;
        results.passed += passed;
        results.failed += failed;
        results.skipped += skipped;

        // Stop on first failure unless keep-going is set
        if (failed > 0 && !testConfig_.keepGoing)
        {
            break;
        }
    }

    // Run teardown once for the suite
    if (suite.teardownFunc().valid())
    {
        DebugTestFmt("  Running teardown for {}", suite.name());
        if (auto result = suite.teardownFunc()(); !result.valid())
        {
            sol::error err = result;
            ShowErrorFmt("Teardown failed for {}: {}", suite.name(), err.what());

            // Report the teardown failure
            reportSetupTeardownFailure(suite, "teardown()", fmt::format("Teardown failed: {}", err.what()));

            results.total++;
            results.failed++;
        }
    }

    // Calculate suite duration
    auto suiteEndTime  = std::chrono::steady_clock::now();
    auto suiteDuration = std::chrono::duration_cast<std::chrono::milliseconds>(suiteEndTime - suiteStartTime);

    // Notify reporters of suite end
    reporters_.onSuiteEnd(suite, suiteDuration);

    return results;
}

void TestEngine::reportSetupTeardownFailure(const TestSuite& suite, const std::string& functionName, const std::string& errorMessage) const
{
    const TestResult failure{
        .suiteName    = suite.fullName(),
        .testName     = functionName,
        .status       = TestStatus::Failed,
        .duration     = std::chrono::milliseconds(0),
        .errorMessage = errorMessage,
        .filePath     = suite.sourceFile()
    };

    // Since we don't have a TestCase for setup/teardown, we just report the result
    // without calling onTestStart
    reporters_.onTestEnd(failure);
}

auto TestEngine::executeTestCase(const TestCase& testCase, const HookContext& context, const TestSuite& suite) const -> bool
{
    TracyZoneScoped;
    TracyZoneString(fmt::format("{} :: {}", suite.fullName(), testCase.name()));

    // Notify reporters of test start
    reporters_.onTestStart(suite, testCase);

    // Track timing
    auto startTime = std::chrono::steady_clock::now();

    // Clean simulation state, reset PRNG seed and clear logs before each test
    DebugTestFmt("  Cleaning simulation state for test: {}", testCase.name());
    simulation_->seed();
    testConfig_.loggerSink->clear();

    auto                     status = TestStatus::Passed;
    std::string              errorMessage;
    std::vector<std::string> logs;

    // Run all before hooks
    if (auto hookError = runBeforeHooks(context, testCase.name()))
    {
        errorMessage = *hookError;
        status       = TestStatus::Failed;
    }

    // Execute the test if before hooks passed
    if (status == TestStatus::Passed)
    {
        if (const auto& testFunc = testCase.testFunc())
        {
            if (auto testResult = (*testFunc)(); !testResult.valid())
            {
                sol::error err = testResult;
                errorMessage   = err.what();
                status         = TestStatus::Failed;
            }
        }
        else
        {
            // No test function means this was a loading/setup failure
            errorMessage = "Test loading or setup failed";
            status       = TestStatus::Failed;
        }

        // Restore all mocks and spies after test execution
        mockManager_->restoreAll();
    }

    // Run all after hooks (even if test failed)
    runAfterHooks(context, testCase.name());

    // Always collect logs AFTER all execution (for verbose mode or failure)
    logs = testConfig_.loggerSink->logs();

    // Calculate duration
    auto endTime  = std::chrono::steady_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(endTime - startTime);

    // Create test result
    TestResult testResult{
        .suiteName    = suite.fullName(),
        .testName     = testCase.name(),
        .status       = status,
        .duration     = duration,
        .errorMessage = errorMessage,
        .logs         = logs,
        .filePath     = suite.sourceFile()
    };

    reporters_.onTestEnd(testResult);
    return status == TestStatus::Passed;
}

auto TestEngine::runBeforeHooks(const HookContext& context, const std::string& testName) const -> std::optional<std::string>
{
    TracyZoneScoped;

    if (context.beforeEachHooks.empty())
    {
        return std::nullopt;
    }

    DebugTest("========= SETUP =========");
    DebugTestFmt("  Executing {} before_each hooks for test: {}", context.beforeEachHooks.size(), testName);

    // Clean up any players from previous tests (but keep setup() players)
    simulation_->cleanClients(ClientScope::TestCase);

    for (size_t i = 0; i < context.beforeEachHooks.size(); ++i)
    {
        const auto& [func, suiteName, depth] = context.beforeEachHooks[i];
        DebugTestFmt("    Running before_each[{}] from suite '{}' (depth {})", i, suiteName, depth);

        if (auto result = func(); !result.valid())
        {
            sol::error err = result;
            ShowErrorFmt("    before_each[{}] from '{}' FAILED: {}", i, suiteName, err.what());
            DebugTest("======= END SETUP =======");
            return std::format("before_each from '{}' failed: {}", suiteName, err.what());
        }

        DebugTestFmt("    before_each[{}] from '{}' completed successfully", i, suiteName);
    }

    DebugTest("======= END SETUP =======");
    return std::nullopt;
}

void TestEngine::runAfterHooks(const HookContext& context, const std::string& testName) const
{
    TracyZoneScoped;

    if (context.afterEachHooks.empty())
    {
        return;
    }

    DebugTestFmt("======= TEARDOWN ========");
    DebugTestFmt("  Executing {} after_each hooks for test: {}", context.afterEachHooks.size(), testName);

    for (size_t i = 0; i < context.afterEachHooks.size(); ++i)
    {
        const auto& [func, suiteName, depth] = context.afterEachHooks[i];
        DebugTestFmt("    Running after_each[{}] from suite '{}' (depth {})", i, suiteName, depth);

        if (auto result = func(); !result.valid())
        {
            sol::error err = result;
            ShowErrorFmt("    after_each[{}] from '{}' failed: {}", i, suiteName, err.what());
        }
        else
        {
            DebugTestFmt("    after_each[{}] from '{}' completed successfully", i, suiteName);
        }
    }

    DebugTest("===== END TEARDOWN ======");
}
