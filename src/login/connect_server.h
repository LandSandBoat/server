/*
===========================================================================

Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "common/application.h"
#include "common/console_service.h"
#include "common/logging.h"
#include "common/lua.h"
#include "common/md52.h"
#include "common/settings.h"
#include "common/sql.h"
#include "common/utils.h"
#include "common/xirand.h"
#include "map/packets/basic.h"

#include <asio/ssl.hpp>
#include <asio/ts/buffer.hpp>
#include <asio/ts/internet.hpp>
#include <chrono>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <memory>
#include <thread>
#include <type_traits>
#include <unordered_map>
#include <utility>
#include <vector>
#include <zmq.hpp>

#include <nonstd/jthread.hpp>

#ifndef _WIN32
#include <sys/resource.h>
#endif

// Login specific stuff
#include "auth_session.h"
#include "cert_helpers.h"
#include "data_session.h"
#include "handler.h"
#include "handler_session.h"
#include "login_helpers.h"
#include "login_packets.h"
#include "session.h"
#include "view_session.h"

class ConnectServer final : public Application
{
public:
    ConnectServer(int argc, char** argv);

    ~ConnectServer() override
    {
        // Everything should be handled with RAII
    }

    // TODO: Currently never called. Need io_context asio::steady_timer callback with taskmgr to control timing?
    void Tick() override
    {
        Application::Tick();

        // Connect Server specific things
    }

    // This cleanup function is to periodically poll for auth sessions that were successful but xiloader failed to actually launch FFXI
    // When this happens, the data/view socket are never opened and will never be cleaned up normally.
    // Auth is closed before any other sessions are open, so the data/view cleanups aren't sufficient
    void periodicCleanup(const asio::error_code& error, asio::steady_timer* timer);
};
