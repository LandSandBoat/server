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

#include "application.h"

#include "debug.h"
#include "logging.h"
#include "lua.h"
#include "settings.h"
#include "taskmgr.h"
#include "xirand.h"

#ifdef _WIN32
#include <windows.h>
#endif

Application::Application(std::string const& serverName, int argc, char** argv)
: serverName_(serverName)
, requestExit_(false)
, ioContext_()
, argParser_(std::make_unique<argparse::ArgumentParser>(argv[0]))
, lua_(lua_init())
{
#ifdef _WIN32
    SetConsoleTitleA(fmt::format("{}-server", serverName_).c_str());
#endif

    argParser_->add_argument("--log")
        .default_value(fmt::format("log/{}-server.log", serverName_));

    try
    {
        argParser_->parse_args(argc, argv);
    }
    catch (const std::runtime_error& err)
    {
        std::cerr << err.what() << "\n";
        std::cerr << *argParser_ << "\n";
        std::exit(1);
    }

    auto logName = argParser_->get<std::string>("--log");
    logging::InitializeLog(serverName_, logName, false);

    settings::init(lua_);

    xirand::seed();

    ShowInfo("Begin %s-server Init...", serverName);

#ifdef ENV64BIT
    ShowInfo("64-bit environment detected");
#else
    ShowInfo("32-bit environment detected");
#endif

    debug::init();

    ShowInfo("The %s-server is ready to work...", serverName);
    ShowInfo("=======================================================================");
}

void Application::run()
{
    ShowInfo("starting io_context");

    // This busy loop looks nasty, however --
    // https://think-async.com/Asio/asio-1.24.0/doc/asio/reference/io_service.html
    //
    //   If an exception is thrown from a handler, the exception is allowed to propagate through the throwing thread's invocation of
    //   run(), run_one(), run_for(), run_until(), poll() or poll_one(). No other threads that are calling any of these functions are affected.
    //   It is then the responsibility of the application to catch the exception.
    while (Application::isRunning())
    {
        try
        {
            // NOTE: io_context.run() takes over and blocks this thread. Anything after this point will only fire
            // if io_context finishes!
            ioContext_.run();
            break;
        }
        catch (std::exception& e)
        {
            // TODO: make a list of "allowed exceptions", the rest can/should cause shutdown.
            ShowError(fmt::format("Inner fatal: {}", e.what()));
        }
    }
}

bool Application::isRunning()
{
    return !requestExit_;
}

auto Application::lua() -> sol::state_view
{
    return lua_;
}

auto Application::ioContext() -> asio::io_context&
{
    return ioContext_;
}
