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

#include <asio.hpp>

#include <memory>
#include <string>

//
// Forward declarations
//

class Arguments;
class ConsoleService;

//
// Globally exposed variables
//

class Application
{
public:
    Application(std::string const& serverName, int argc, char** argv);
    virtual ~Application();

    Application(const Application&)            = delete;
    Application(Application&&)                 = delete;
    Application& operator=(const Application&) = delete;
    Application& operator=(Application&&)      = delete;

    //
    // Init
    //

    void trySetConsoleTitle();
    void registerSignalHandlers();
    void usercheck();
    void tryIncreaseRLimits();
    void tryDisableQuickEditMode();
    void tryRestoreQuickEditMode();
    void prepareLogging();

    virtual void loadConsoleCommands() = 0;

    void markLoaded();

    //
    // Runtime
    //

    bool isRunning();
    void requestExit();

    // Is expected to block until requestExit() is called and/or isRunning() returns false
    virtual void run() = 0;

    bool isRunningInCI();

    //
    // Member accessors
    //

    auto ioContext() -> asio::io_context&;
    auto args() -> Arguments&;
    auto console() -> ConsoleService&;

protected:
    asio::io_context io_context_;

    std::string serverName_;

    std::unique_ptr<Arguments>      args_;
    std::unique_ptr<ConsoleService> consoleService_;
};
