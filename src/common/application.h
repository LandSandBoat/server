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
    auto initialize() -> bool;
    void trySetConsoleTitle();
    void registerSignalHandlers() const;
    void usercheck() const;
    void tryIncreaseRLimits() const;
    void tryDisableQuickEditMode() const;
    void tryRestoreQuickEditMode() const;
    void registerFileSinks();

    void markLoaded();

    //
    // Runtime
    //

    auto run() -> int;
    auto isRunning() const -> bool;
    void requestExit();

    // Override these to add specific behavior
    virtual auto onFileSinkRegister() -> std::optional<std::string>; // Return a custom log file name
    virtual void onArgumentsRegister(Arguments* args) {};               // Register any child specific argument
    virtual void onConsoleCommandsRegister(ConsoleService* console) {}; // Register any child specific console commands
    virtual auto onInitialize() -> bool = 0;                            // Called after parent initialize, safe to use logger
    virtual auto onRun() -> int         = 0;                            // Return exit code

    auto isRunningInCI() const -> bool;

    //
    // Member accessors
    //
    auto ioContext() -> asio::io_context&;

protected:
    asio::io_context io_context_;

    std::string serverName_;

private:
    std::unique_ptr<Arguments>      args_;
    std::unique_ptr<ConsoleService> consoleService_;
    bool                            initialized_{ false };
};
