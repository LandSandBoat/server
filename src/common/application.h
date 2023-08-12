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

#include <memory>
#include <string>

#include <argparse/argparse.hpp>

#include "console_service.h"

class Application
{
public:
    Application(std::string const& serverName, int argc, char** argv);
    virtual ~Application() = default;

    Application(const Application&)            = delete;
    Application(Application&&)                 = delete;
    Application& operator=(const Application&) = delete;
    Application& operator=(Application&&)      = delete;

    virtual bool IsRunning();
    virtual void Tick();

protected:
    std::string       m_ServerName;
    std::atomic<bool> m_RequestExit;

    std::unique_ptr<argparse::ArgumentParser> gArgParser;
    std::unique_ptr<ConsoleService>           gConsoleService;
};
