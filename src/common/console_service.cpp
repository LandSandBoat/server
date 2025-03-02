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

#include "database.h"
#include "lua.h"

#include <sstream>

#ifdef _WIN32
#include <conio.h>
#include <io.h>
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
    auto keyCharacter = static_cast<unsigned char>(getchar());
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

ConsoleService::ConsoleService()
{
    // clang-format off
    RegisterCommand("help", "Print a list of available console commands.",
    [this](std::vector<std::string>& inputs)
    {
        fmt::print("> Available commands:\n");
        for (auto& [name, command] : m_commands)
        {
            fmt::print("> {} : {}\n", command.name, command.description);
        }
    });

    RegisterCommand("tasks", "Show the current amount of tasks registered to the application task manager.",
    [](std::vector<std::string>& inputs)
    {
        fmt::print("> tasks registered to the application task manager: {}\n", CTaskMgr::getInstance()->getTaskList().size());
    });

    RegisterCommand("log_level", "Set the maximum log level to be displayed (available: 0: trace, 1: debug, 2: info, 3: warn)",
    [](std::vector<std::string>& inputs)
    {
        if (inputs.size() >= 2)
        {
            std::vector<std::string> names = { "trace", "debug", "info", "warn" };
            auto level = std::clamp<uint8>(stoi(inputs[1]), 0, 3);
            spdlog::set_level(static_cast<spdlog::level::level_enum>(level));
            fmt::print("> Log level set to: {} ({})\n", level, names[level]);
        }
        else
        {
            fmt::print("> Invalid inputs.\n");
        }
    });

    RegisterCommand("lua", "Provides a Lua REPL",
    [](std::vector<std::string>& inputs)
    {
        if (inputs.size() >= 2)
        {
            // Remove "lua" from the front of the inputs
            inputs = std::vector<std::string>(inputs.begin() + 1, inputs.end());

            auto input = fmt::format("local var = {}; if type(var) ~= \"nil\" then print(var) end", fmt::join(inputs, " "));
            lua.safe_script(input);
        }
    });

    RegisterCommand("crash", "Crash the process",
    [](std::vector<std::string>& inputs)
    {
        crash();
    });

    RegisterCommand("db", "Run both a query and a prepared statement to test the database connection",
    [](std::vector<std::string>& inputs)
    {
        auto query = "SELECT 1";
        auto rset = db::queryStr(query);
        if (rset && rset->rowsCount())
        {
            fmt::print("> Query successful: {}\n", query);
        }

        auto preparedQuery = "SELECT 1";
        auto preparedRset = db::preparedStmt(preparedQuery);
        if (preparedRset && preparedRset->rowsCount())
        {
            fmt::print("> Prepared statement successful: {}\n", preparedQuery);
        }
    });

    RegisterCommand("db_perf_test", "",
    [](std::vector<std::string>& inputs)
    {
        {
            const auto start = hires_clock::now();
            for (int i = 0; i < 100; i++) // number of queries
            {
                for (int j = 0; j < 10; j++) // charids
                {
                    auto rset = db::query("SELECT * FROM chars WHERE charid = %u", j);
                    if (rset && rset->rowsCount() && rset->next())
                    {
                        std::ignore = rset->get<uint32>(0);
                    }
                }
            }
            const auto end = hires_clock::now();
            const auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count();
            fmt::print("> db_perf_test queries took {}ms\n", duration);
        }

        {
            const auto start = hires_clock::now();
            for (int i = 0; i < 100; i++) // number of queries
            {
                for (int j = 0; j < 10; j++) // charids
                {
                    auto rset = db::preparedStmt("SELECT * FROM chars WHERE charid = ?", j);
                    if (rset && rset->rowsCount() && rset->next())
                    {
                        std::ignore = rset->get<uint32>(0);
                    }
                }
            }
            const auto end = hires_clock::now();
            const auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count();
            fmt::print("> db_perf_test prepared statements took {}ms\n", duration);
        }
    });

    bool attached = isatty(0);
    if (attached)
    {
        ShowInfo("Console input thread is ready...");
        ShowInfo("Type 'help' for a list of available commands.");
        m_consoleInputThread = nonstd::jthread([&]()
        {
            std::string line;

            while (m_consoleThreadRun)
            {
                std::unique_lock<std::mutex> lock(m_consoleInputBottleneck);

                // https://en.cppreference.com/w/cpp/thread/condition_variable/wait_for
                if (!m_consoleStopCondition.wait_for(lock, 50ms, [&]{ return !m_consoleThreadRun; }))
                {
                    if (!getLine(line))
                    {
                        continue;
                    }

                    std::istringstream stream(line);
                    std::string        input;

                    std::vector<std::string> inputs;
                    while (stream >> input)
                    {
                        for (auto& part : split(input))
                        {
                            inputs.emplace_back(part);
                        }
                    }

                    if (!inputs.empty())
                    {
                        TracyZoneScoped;

                        auto entry = m_commands.find(inputs[0]);
                        if (entry != m_commands.end())
                        {
                            entry->second.func(inputs);
                        }
                        else
                        {
                            fmt::print(fmt::runtime("> Unknown command: {}\n"), inputs[0]);
                        }
                    }

                    line = std::string();
                }
            }
            fmt::print("Console input thread exiting...\n");
        });
    }
    // clang-format on
}

ConsoleService::~ConsoleService()
{
    stop();
    m_consoleStopCondition.notify_all();
}

// NOTE: If you capture things in this function, make sure they're protected (locked or atomic)!
// NOTE: If you're going to print, use fmt::print, rather than ShowInfo etc.
void ConsoleService::RegisterCommand(std::string const& name, std::string const& description, std::function<void(std::vector<std::string>&)> func)
{
    std::lock_guard<std::mutex> lock(m_consoleInputBottleneck);

    m_commands[name] = ConsoleCommand{ name, description, std::move(func) };
}

void ConsoleService::stop()
{
    m_consoleThreadRun = false;
}
