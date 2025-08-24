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
#include "common/zmq_dealer_wrapper.h"

#ifndef _WIN32
#include <sys/resource.h>
#endif

// Login specific stuff
#include "auth_session.h"
#include "common/engine.h"
#include "data_session.h"
#include "handler.h"
#include "view_session.h"

class ConnectEngine final : public Engine
{
public:
    ConnectEngine(asio::io_context& io_context);
    ~ConnectEngine() override;

    // This cleanup function is to periodically poll for auth sessions that were successful but xiloader failed to actually launch FFXI
    // When this happens, the data/view socket are never opened and will never be cleaned up normally.
    // Auth is closed before any other sessions are open, so the data/view cleanups aren't sufficient
    void periodicCleanup(const asio::error_code& error);

private:
    ZMQDealerWrapper      zmqDealerWrapper_;
    handler<auth_session> m_authHandler;
    handler<data_session> m_dataHandler;
    handler<view_session> m_viewHandler;
    asio::steady_timer    m_sessionCleanupTimer;
};
