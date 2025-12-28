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

#include "test_application.h"
#include "test_engine.h"

#include <spdlog/async.h>

namespace
{

auto appConfig() -> ApplicationConfig
{
    return ApplicationConfig{
        .serverName = "test",
        .arguments  = {
            ArgumentDefinition{
                 .name        = "--keep-going",
                 .description = "Continue as much as possible after an error or failure.",
                 .type        = ArgumentType::Flag,
            },
            ArgumentDefinition{
                 .name        = "--verbose",
                 .description = "Verbose output of errors.",
                 .type        = ArgumentType::Flag,
            },
            ArgumentDefinition{
                 .name        = "--watch",
                 .description = "Watch files for changes and re-run tests. (Not yet implemented)",
                 .type        = ArgumentType::Flag,
            },
            ArgumentDefinition{
                 .name        = "--tag",
                 .description = "Only run tests with these #tags.",
                 .type        = ArgumentType::Multiple,
            },
            ArgumentDefinition{
                 .name        = "--no-tag",
                 .description = "Do not run tests with these #tags, takes precedence over tags.",
                 .type        = ArgumentType::Multiple,
            },
            ArgumentDefinition{
                 .name        = "--file",
                 .description = "Only run test files matching the regex pattern.",
                 .type        = ArgumentType::Multiple,
            },
            ArgumentDefinition{
                 .name        = "--no-file",
                 .description = "Do not run test files matching the regex pattern, takes precedence over file.",
                 .type        = ArgumentType::Multiple,
            },
            ArgumentDefinition{
                 .name        = "--filter",
                 .description = "Only run test names matching the regex pattern.",
                 .type        = ArgumentType::Multiple,
            },
            ArgumentDefinition{
                 .name        = "--no-filter",
                 .description = "Do not run test names matching the regex pattern, takes precedence over filter.",
                 .type        = ArgumentType::Multiple,
            },
            ArgumentDefinition{
                 .name        = "--output",
                 .description = "Output file for test results. Use .json extension for CTRF format.",
            },
        },
    };
}

} // namespace

TestApplication::TestApplication(const int argc, char** argv)
: Application(appConfig(), argc, argv)
, sink_(std::make_shared<InMemorySink>())
{
}

TestApplication::~TestApplication() = default;

auto TestApplication::createEngine() -> std::unique_ptr<Engine>
{
    TestConfig config{
        .loggerSink = sink_,
        .verbose    = args().get<bool>("--verbose"),
        .output     = args().present<std::string>("--output").value_or(""),
        .keepGoing  = args().get<bool>("--keep-going"),
        .watch      = args().get<bool>("--watch"),
        .filters    = {
               .includePatterns = args().get<std::vector<std::string>>("--file"),
               .excludePatterns = args().get<std::vector<std::string>>("--no-file"),
               .includeFilters  = args().get<std::vector<std::string>>("--filter"),
               .excludeFilters  = args().get<std::vector<std::string>>("--no-filter"),
               .includeTags     = args().get<std::vector<std::string>>("--tag"),
               .excludeTags     = args().get<std::vector<std::string>>("--no-tag"),
        },
    };

    return std::make_unique<TestEngine>(ioContext(), config);
}

void TestApplication::run()
{
    TracyZoneScoped;

    engine_ = createEngine();
    markLoaded();
    //  From this point, every logging statements end up in the in-memory sink
    //  Print to stderr directly if needed
    captureLogger();

    if (const auto testEngine = static_cast<TestEngine*>(engine_.get()); !testEngine->executeTests())
    {
        std::exit(EXIT_FAILURE);
    }
}

// Replace all loggers sinks with the in-memory sink
void TestApplication::captureLogger() const
{
    const auto loggerNames = std::vector<std::string>{
        "critical", "error", "lua", "warn", "info", "debug", "trace"
    };

    // spdlog blows up if we don't!
    spdlog::shutdown();

    // Re-register all loggers as SYNCHRONOUS loggers with only our in-memory sink
    // This ensures all logs are immediately written to the sink
    for (const auto& name : loggerNames)
    {
        const auto logger = std::make_shared<spdlog::logger>(name, sink_);
        logger->set_level(spdlog::level::trace);
        spdlog::register_logger(logger);
    }

    logging::SetPattern(settings::get<std::string>("test.PATTERN"));
}
