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

#include <any>
#include <iostream>
#include <memory>
#include <string>
#include <thread>

#include "logging.h"

#ifdef WIN32
#include <io.h>
#define isatty _isatty
#else
#include <unistd.h>
#endif

struct ConsoleCommand
{
    std::string name;
    std::string description;

    // TODO: Use variant or any to carry a payload to the function
    std::function<void()> func;
};

class ConsoleService
{
public:
    ConsoleService()
    {
        RegisterCommand("help", "Print a list of available console commands.",
        [=]() // By value
        {
            fmt::print("> Available commands:\n");
            for (auto& [name, command] : m_commands)
            {
                fmt::print("> {} : {}\n", command.name, command.description);
            }
        });

        RegisterCommand("exit", "Terminate the program.",
        []()
        {
            fmt::print("Goodbye!");
            std::terminate();
        });

        bool attached = isatty(0);
        if (attached)
        {
            ShowStatus("Console input thread is ready...");
            ShowStatus("Type 'help' for a list of available commands.");
            m_consoleInputThread = std::thread([&]()
            {
                // ctrl c apparently causes log spam
                auto lastInputTime = server_clock::now();

                // TODO: condition_variable
                while (m_consoleThreadRun)
                {
                    if ((server_clock::now() - lastInputTime) > 1s)
                    {
                        std::lock_guard lock(m_consoleInputBottleneck);

                        std::string line;
                        std::getline(std::cin, line);

                        std::istringstream stream(line);
                        std::string        input;

                        std::vector<std::string> inputs;
                        while (stream >> input)
                        {
                            inputs.emplace_back(input);
                        }

                        if (!inputs.empty())
                        {
                            if (m_commands.find(input) != m_commands.end())
                            {
                                m_commands[input].func();
                            }
                        }
                    }
                };
                ShowStatus("Console input thread exiting...");
            });
        }
    }
    ~ConsoleService()
    {
        m_consoleThreadRun = false;
        m_consoleInputThread.join();
    }

    // NOTE: If you capture things in this function, make sure they're protected (locked or atomic)!
    void RegisterCommand(std::string const& name, std::string const& description, std::function<void()> func)
    {
        std::lock_guard lock(m_consoleInputBottleneck);
        m_commands[name] = ConsoleCommand{ name, description, func };
    }

private:
    std::thread       m_consoleInputThread;
    std::mutex        m_consoleInputBottleneck;
    std::atomic<bool> m_consoleThreadRun = true;

    std::unordered_map<std::string, ConsoleCommand> m_commands;
};
