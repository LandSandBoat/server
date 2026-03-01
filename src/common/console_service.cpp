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

#include "console_service.h"

#include "application.h"
#include "database.h"
#include "logging.h"
#include "lua.h"
#include "settings.h"
#include "task_manager.h"
#include "tracy.h"
#include "utils.h"
#include "version.h"

#include <sstream>

#ifdef _WIN32
#include <conio.h>
#include <io.h>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#define isatty  _isatty
#define getchar _getch
#else
#include <poll.h>
#include <sys/socket.h>
#include <unistd.h>
#endif

// https://stackoverflow.com/a/71992965
bool stdinHasData()
{
#if defined(_WIN32)
    // this works by harnessing Windows' black magic:
    return _kbhit();
#else
    pollfd pollFileDescriptor = { STDIN_FILENO, POLLIN, 0 };

    // poll the stdin file descriptor until it tells us it's ready
    // poll returns a 0 if STDIN isn't ready, or a 1 if it is.
    return poll(&pollFileDescriptor, 1, 0) == 1;
#endif
}

bool getLine(std::string& line)
{
    // If there is data on stdin we can call _getch() knowing that it won't block!
    // This makes this routine non-blocking.
    if (!stdinHasData())
    {
        return false;
    }

#if defined(_WIN32)
    const auto keyCharacter = static_cast<unsigned char>(getchar());
    if (keyCharacter == '\r')
    {
        fmt::print("\n"); // Windows needs \r\n for newlines in the console, but the enter key is only \r.
        return true;
    }

    if (keyCharacter == '\n')
    {
        return true;
    }

    if (keyCharacter == '\b')
    {
        fmt::print("\b \b"); // move cursor left, overwrite with space, move cursor left
        if (line.size() > 0)
        {
            line.pop_back(); // remove last char in buffer if any
        }
        return false;
    }

    if (std::isprint(keyCharacter))
    {
        fmt::print("{:c}", keyCharacter); // echo character back to console, apparently using ReadConsoleInput & GetStdHandle prevents echo?
        line += keyCharacter;
    }

    return false;
#else
    std::getline(std::cin, line);
    return true;
#endif
}

ConsoleService::ConsoleService(Application& application)
: application_(application)
{
    registerDefaultCommands();

    if (!application_.isRunningInCI())
    {
        run();
    }
}

ConsoleService::~ConsoleService() = default;

// NOTE: If you capture things in this function, make sure they're protected (locked or atomic)!
// NOTE: If you're going to print, use fmt::print, rather than ShowInfo etc.
void ConsoleService::registerCommand(const std::string& name, const std::string& description, std::function<void(std::vector<std::string>&)> func)
{
    std::lock_guard<std::mutex> lock(m_consoleInputBottleneck);

    m_commands[name] = ConsoleCommand{ name, description, std::move(func) };
}

void ConsoleService::registerDefaultCommands()
{
    registerCommand(
        "help", "Print a list of available console commands", [this](std::vector<std::string>& inputs)
        {
            fmt::print("> Available commands:\n");
            for (auto& [name, command] : m_commands)
            {
                fmt::print("> {} : {}\n", command.name, command.description);
            }
        });

    registerCommand(
        "version", "Print the application version", [](std::vector<std::string>& inputs)
        {
            fmt::print("> Application branch: {}\n", version::GetVersionString());
        });

    registerCommand(
        "tasks", "Show the current amount of tasks registered to the application task manager", [](std::vector<std::string>& inputs)
        {
            fmt::print("> tasks registered to the application task manager: {}\n", CTaskManager::getInstance()->getTaskList().size());
        });

    registerCommand(
        "reload_settings", "Reload settings files", [](std::vector<std::string>& inputs)
        {
            fmt::print("Reloading settings files\n");
            settings::init();
        });

    registerCommand(
        "log_level", "Set the maximum log level to be displayed (available: 0: trace, 1: debug, 2: info, 3: warn)", [](std::vector<std::string>& inputs)
        {
            if (inputs.size() >= 2)
            {
                std::vector<std::string> names = { "trace", "debug", "info", "warn" };
                auto                     level = std::clamp<uint8>(stoi(inputs[1]), 0, 3);
                spdlog::set_level(static_cast<spdlog::level::level_enum>(level));
                fmt::print("> Log level set to: {} ({})\n", level, names[level]);
            }
            else
            {
                fmt::print("> Invalid inputs.\n");
            }
        });

    registerCommand(
        "lua", "Provides a Lua REPL", [](std::vector<std::string>& inputs)
        {
            if (inputs.size() >= 2)
            {
                // Remove "lua" from the front of the inputs
                inputs = std::vector<std::string>(inputs.begin() + 1, inputs.end());

                auto input = fmt::format("local var = {}; if type(var) ~= \"nil\" then print(var) end", fmt::join(inputs, " "));

                lua.safe_script(input);
            }
        });

    registerCommand(
        "crash", "Crash the process (main thread)", [](std::vector<std::string>& inputs)
        {
            crash();
        });

    registerCommand(
        "crash_worker", "Crash the process (worker thread)", [&](std::vector<std::string>& inputs)
        {
            application_.scheduler().postToWorkerThread(
                []
                {
                    crash();
                });
        });

    registerCommand(
        "throw", "Throw an exception", [](std::vector<std::string>& inputs)
        {
            throw std::runtime_error("Exception thrown from console command (on main thread)");
        });

    registerCommand(
        "exit", "Request application exit", [&](std::vector<std::string>& inputs)
        {
            application_.requestExit();
            fmt::print("> Goodbye!");
        });
}

void ConsoleService::run()
{
    if (isatty(0))
    {
        application_.scheduler().postToWorkerThread(consoleLoop());
    }
}

auto ConsoleService::consoleLoop() -> Task<void>
{
    auto& scheduler = application_.scheduler();

    std::string line;

    while (!scheduler.closeRequested())
    {
        // If there is data, process as much as possible before yielding.
        // This removes the 50ms delay between every single keystroke.
        bool hasLine = false;
        while (stdinHasData())
        {
            if (getLine(line))
            {
                hasLine = true;
                break; // We have a full command to process
            }
        }

        if (hasLine)
        {
            std::istringstream       stream(line);
            std::string              part;
            std::vector<std::string> inputs;

            while (stream >> part)
            {
                for (auto& s : split(part))
                {
                    inputs.emplace_back(s);
                }
            }

            if (!inputs.empty())
            {
                TracyZoneScoped;

                auto it = m_commands.find(inputs[0]);
                if (it != m_commands.end())
                {
                    // Dispatch to main thread
                    scheduler.postToMainThread(
                        [cmd = it->second.func, args = std::move(inputs)]() mutable
                        {
                            try
                            {
                                cmd(args);
                            }
                            catch (const std::exception& e)
                            {
                                fmt::print(stderr, "> Command error: {}\n", e.what());
                            }
                        });
                }
                else
                {
                    fmt::print("> Unknown command: {}\n", inputs[0]);
                }
            }
            line.clear();

            // Immediately check for more input without yielding
            // if we just processed a line.
            continue;
        }

        // Yield only when there is no data to process.
        co_await scheduler.yieldFor(100ms);
    }
}
