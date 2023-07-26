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

#ifndef _CONSOLE_SERVICE_H_
#define _CONSOLE_SERVICE_H_

#pragma once

#include <any>
#include <condition_variable>
#include <iostream>
#include <memory>
#include <string>
#include <thread>

#include <nonstd/jthread.hpp>

#include "logging.h"
#include "taskmgr.h"
#include "tracy.h"
#include "utils.h"

class ConsoleService
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
    ConsoleService();
    ~ConsoleService();

    // NOTE: If you capture things in this function, make sure they're protected (locked or atomic)!
    // NOTE: If you're going to print, use fmt::print, rather than ShowInfo etc.
    void RegisterCommand(std::string const& name, std::string const& description, std::function<void(std::vector<std::string>&)> func);

    // Call this to stop processing commands
    void stop();

private:
    std::mutex              m_consoleInputBottleneck;
    std::atomic<bool>       m_consoleThreadRun = true;
    nonstd::jthread         m_consoleInputThread;
    std::condition_variable m_consoleStopCondition;

    std::unordered_map<std::string, ConsoleCommand> m_commands;
};

#endif // _CONSOLE_SERVICE_H_
