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

#include "test_runner.h"
#include "common/arguments.h"
#include "common/console_service.h"
#include "common/filewatcher.h"
#include "common/logging.h"
#include "common/lua.h"
#include "common/settings.h"
#include "in_memory_sink.h"
#include "ipc_client.h"
#include "lua/lua_sim_client.h"
#include "lua/lua_simulation.h"
#include "map/lua/luautils.h"
#include "map/map_server.h"
#include "map/utils/zoneutils.h"
#include "test_char.h"
#include "world/world_server.h"

#include <argparse/argparse.hpp>
#include <sol/sol.hpp>

namespace
{
    std::string testFrameworkPath = "scripts/tests";
} // namespace

TestRunner::TestRunner(const int argc, char** argv)
: Application("test", argc, argv)
, m_sink(std::make_shared<InMemorySink>())
{
    TestChar::clean();

    args_->add_argument("--keep-going")
        .default_value(false)
        .implicit_value(true)
        .store_into(m_options.keepGoing)
        .help("Continue as much as possible after an error or failure.");

    args_->add_argument("-r", "--runs")
        .default_value(1)
        .store_into(m_options.runs)
        .help("Number of times to run the tests.")
        .scan<'i', int>();

    args_->add_argument("--verbose")
        .default_value(false)
        .implicit_value(true)
        .store_into(m_options.verbose)
        .help("Verbose output of errors.");

    args_->add_argument("-t", "--tags")
        .default_value(std::vector<std::string>{})
        .append()
        .store_into(m_options.tags)
        .help("Only run tests with these #tags.");

    args_->add_argument("--exclude-tags")
        .default_value(std::vector<std::string>{})
        .append()
        .store_into(m_options.excludeTags)
        .help("Do not run tests with these #tags, takes precedence over tags.");

    args_->add_argument("--filter")
        .default_value(std::vector<std::string>{})
        .append()
        .store_into(m_options.filter)
        .help("Only run test names matching the pattern.");

    args_->add_argument("--filter-out")
        .default_value(std::vector<std::string>{})
        .append()
        .store_into(m_options.filterOut)
        .help("Do not run test names matching the pattern, takes precedence over filter.");

    args_->add_argument("--pattern")
        .default_value(std::vector<std::string>{ "" })
        .append()
        .store_into(m_options.pattern)
        .help("Only run test files matching the pattern.");

    args_->add_argument("--exclude-pattern")
        .default_value(std::vector<std::string>{ "" })
        .append()
        .store_into(m_options.excludePattern)
        .help("Do not run test files matching the pattern, takes precedence over pattern.");

    args_->add_argument("--root")
        .default_value(std::vector<std::string>{ "scripts/tests/suites" })
        .append()
        .store_into(m_options.ROOT)
        .help("Test script file/folder. Folders will be traversed for any file that matches the pattern option.");

    args_->add_argument("-n", "--name")
        .default_value(std::vector<std::string>{})
        .append()
        .store_into(m_options.name)
        .help("Run test with the given full name.");

    args_->add_argument("-o", "--output")
        .default_value("term")
        .store_into(m_options.output)
        .help("Output format to use. One of 'term', 'junit'.");

    args_->parse();

    // Without a world server actively pumping the queues,
    // the embedded map server deadlocks on exit
    //
    // We will need this to work to support multiprocess tests and validating systems that rely on world server.
    // However, that requires deeper rework to the IPP logic so we can smartly route messages during tests.
    m_worldServer = std::make_unique<WorldServer>(argc, argv);

    m_mapServer = std::make_unique<MapServer>(MapConfig{
        .isTestServer      = true,
        .dynamicZones      = true,
        .controlledWeather = true,
        .lazyMeshLoad      = true, // Not currently used
        .disableLosLoad    = true, // Not currently used
    });
}

TestRunner::~TestRunner() = default;

// Replace all loggers sinks with the in-memory sink
void TestRunner::captureLogger() const
{
    // Override existing log settings for tests.
    settings::set("logging.LOG_DEBUG", settings::get<std::string>("test.LOG_DEBUG"));
    settings::set("logging.LOG_INFO", settings::get<std::string>("test.LOG_INFO"));
    settings::set("logging.LOG_WARNING", settings::get<std::string>("test.LOG_WARNING"));
    settings::set("logging.LOG_LUA", settings::get<std::string>("test.LOG_LUA"));

    // clang-format off
    spdlog::apply_all([&](const std::shared_ptr<spdlog::logger>& logger)
    {
        logger->sinks().clear();
        logger->sinks().push_back(m_sink);
    });
    // clang-format on

    logging::SetPattern(settings::get<std::string>("test.LOG_PATTERN"));
}

void TestRunner::prepareLuaEnvironment() const
{
    ShowInfo("Preparing Lua environment for tests");

    CLuaSimulation::Register();
    CLuaSimClient::Register();

    // Inject paths to luarocks tree
    // LUAROCKS_TREE is set by CMake and is required to build xi_test
    const auto sharePath = std::format(LUAROCKS_TREE, "share");
    const auto libPath   = std::format(LUAROCKS_TREE, "lib");

    lua["package"]["path"]  = std::format("{};{}/?.lua;{}/?/init.lua",
                                          lua["package"]["path"].get<std::string>(),
                                          sharePath,
                                          sharePath);
    lua["package"]["cpath"] = std::format("{};{}/?.dll",
                                          lua["package"]["cpath"].get<std::string>(),
                                          libPath);

    // Revert the global tostring function to the original implementation
    lua.set_function("tostring", lua.get<sol::function>("_tostring"));
}

bool TestRunner::executeTests()
{
    const auto entryObj = lua.safe_script_file(testFrameworkPath + "/framework/entrypoint.lua", &sol::script_pass_on_error);
    if (!entryObj.valid())
    {
        const sol::error err = entryObj;
        std::cerr << "Failed to load test wrapper: " << err.what();
        return false;
    }

    CLuaSimulation simulation(m_mapServer.get(), m_sink);

    auto toStringTable = [&](const std::vector<std::string>& vec) -> sol::table
    {
        sol::table arr = lua.create_table();
        for (size_t i = 0; i < vec.size(); ++i)
        {
            arr[i + 1] = vec[i];
        }

        return arr;
    };

    // Pass CLI arguments directly to wrapper
    sol::table optionsTbl = lua.create_table_with(
        "keepGoing", m_options.keepGoing,
        "runs", m_options.runs,
        "verbose", m_options.verbose,
        "recursive", m_options.recursive,
        "output", m_options.output,
        "tags", toStringTable(m_options.tags),
        "excludeTags", toStringTable(m_options.excludeTags),
        "filter", toStringTable(m_options.filter),
        "filterOut", toStringTable(m_options.filterOut),
        "pattern", toStringTable(m_options.pattern),
        "excludePattern", toStringTable(m_options.excludePattern),
        "ROOT", toStringTable(m_options.ROOT),
        "name", toStringTable(m_options.name));

    // TODO: Improve sandboxing by making a deep copy of the lua state and reset it after each test?
    const sol::protected_function        entryFunc = entryObj;
    const sol::protected_function_result result    = entryFunc(simulation, optionsTbl);
    if (!result.valid())
    {
        const sol::error  err  = result;
        const std::string what = err.what();
        std::cerr << "Test execution failed: " << what << '\n';
        return false;
    }

    const sol::table resultTable   = result.get<sol::table>();
    const auto       failuresCount = resultTable.get<uint32>("failures");
    const auto       errorsCount   = resultTable.get<uint32>("errors");
    const bool       success       = failuresCount == 0 && errorsCount == 0;

    if (!success)
    {
        std::cerr << "Test execution failed with "
                  << failuresCount << " failures and "
                  << errorsCount << " errors." << '\n';
    }
    else
    {
        std::cerr << "Test execution successful." << '\n';
    }

    return success;
}

void TestRunner::run()
{
    captureLogger();
    // From this point, every logging statements end up in the in-memory sink
    // Print to stderr directly if needed

    prepareLuaEnvironment();

    const auto result = executeTests();

    requestExit();

    std::exit(result);
}

void TestRunner::loadConsoleCommands()
{
}
