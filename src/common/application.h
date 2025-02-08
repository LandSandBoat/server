/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

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

#include "console_service.h"
#include "lua.h"

#include <argparse/argparse.hpp>

#include <asio/io_context.hpp>

#include <memory>
#include <string>

class Application
{
public:
    Application(std::string const& serverName, int argc, char** argv);
    virtual ~Application() = default;

    Application(const Application&)            = delete;
    Application(Application&&)                 = delete;
    Application& operator=(const Application&) = delete;
    Application& operator=(Application&&)      = delete;

    void run();

protected:
    std::string       serverName_;
    std::atomic<bool> requestExit_;

    sol::lua_state lua_;

    asio::io_context ioContext_;

    std::unique_ptr<argparse::ArgumentParser> argParser_;
    std::unique_ptr<ConsoleService>           consoleService_;

};
