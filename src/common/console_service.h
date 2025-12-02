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
#include <condition_variable>
#include <functional>
#include <iostream>
#include <memory>
#include <string>
#include <thread>
#include <unordered_map>

class Application;

class ConsoleService final
{
private:
    struct ConsoleCommand
    {
        std::string name;
        std::string description;

        // TODO: Use variant or any to carry a payload to the function
        std::function<void(std::vector<std::string>& inputs)> func;
    };

public:
    ConsoleService(Application& application);
    ~ConsoleService();

    // NOTE: If you capture things in this function, make sure they're protected (locked or atomic)!
    // NOTE: If you're going to print, use fmt::print, rather than ShowInfo etc.
    void registerCommand(const std::string& name, const std::string& description, std::function<void(std::vector<std::string>&)> func);

private:
    void registerDefaultCommands();
    void run();

    Application& application_;

    std::mutex              m_consoleInputBottleneck;
    std::atomic<bool>       m_consoleThreadRun;
    std::jthread            m_consoleInputThread;
    std::condition_variable m_consoleStopCondition;

    std::unordered_map<std::string, ConsoleCommand> m_commands;
};
