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

#include "common/application.h"
#include "in_memory_sink.h"
#include "map/map_engine.h"
#include "mock_manager.h"
#include "reporters/reporter_container.h"
#include "test_collector.h"
#include "test_lua_environment.h"
#include "world/world_engine.h"
#include <deque>
#include <memory>
#include <vector>

#ifndef _WIN32
#include <sys/resource.h>
#endif

class CLuaSimulation;

struct TestConfig
{
    std::shared_ptr<InMemorySink> loggerSink;
    bool                          verbose{ false };
    std::string                   output;
    bool                          keepGoing{ false };
    bool                          watch{ false };
    FilterConfig                  filters;
};

struct TestResults
{
    size_t total{ 0 };
    size_t passed{ 0 };
    size_t failed{ 0 };
    size_t skipped{ 0 };
};

struct HookInfo
{
    sol::protected_function func;
    std::string             suiteName;
    size_t                  depth;
};

struct HookContext
{
    std::vector<HookInfo> beforeEachHooks;
    std::deque<HookInfo>  afterEachHooks;
};

class TestEngine final : public Engine
{
public:
    TestEngine(asio::io_context& io_context, TestConfig testConfig);
    ~TestEngine() override;

    DISALLOW_COPY_AND_MOVE(TestEngine);

    auto executeTests() -> bool;

private:
    auto executeSuite(const TestSuite& suite, HookContext context) -> TestResults;
    void reportSetupTeardownFailure(const TestSuite& suite, const std::string& functionName, const std::string& errorMessage) const;
    auto executeTestCase(const TestCase& testCase, const HookContext& context, const TestSuite& suite) const -> bool;
    auto runBeforeHooks(const HookContext& context, const std::string& testName) const -> std::optional<std::string>;
    void runAfterHooks(const HookContext& context, const std::string& testName) const;

    std::unique_ptr<MapEngine>          mapEngine_;
    std::unique_ptr<WorldEngine>        worldEngine_;
    std::unique_ptr<MockManager>        mockManager_;
    TestConfig                          testConfig_;
    ReporterContainer                   reporters_;
    std::unique_ptr<TestLuaEnvironment> luaEnvironment_;
    std::unique_ptr<TestCollector>      testCollector_;
    std::unique_ptr<CLuaSimulation>     simulation_;
};
