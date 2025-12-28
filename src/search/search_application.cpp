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

#include "search_application.h"

#include "common/console_service.h"
#include "search_engine.h"

namespace
{

auto appConfig() -> ApplicationConfig
{
    return ApplicationConfig{
        .serverName = "search",
        .arguments  = {},
    };
}

} // namespace

SearchApplication::SearchApplication(const int argc, char** argv)
: Application(appConfig(), argc, argv)
{
}

SearchApplication::~SearchApplication() = default;

auto SearchApplication::createEngine() -> std::unique_ptr<Engine>
{
    return std::make_unique<SearchEngine>(ioContext());
}

void SearchApplication::registerCommands(ConsoleService& console)
{
    const auto expiryDays   = settings::get<uint16>("search.EXPIRE_DAYS");
    auto*      searchEngine = static_cast<SearchEngine*>(engine_.get());

    console.registerCommand("ah_cleanup",
                            fmt::format("AH task to return items older than {} days", expiryDays),
                            std::bind(&SearchEngine::onAHCleanup, searchEngine, std::placeholders::_1));

    console.registerCommand("expire_all",
                            "Force-expire all items on the AH, returning to sender",
                            std::bind(&SearchEngine::onExpireAll, searchEngine, std::placeholders::_1));
}

void SearchApplication::requestExit()
{
    Application::requestExit();
    io_context_.stop();
}
