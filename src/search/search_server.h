/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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
#include "common/utils.h"
#include "common/xirand.h"

#include <unordered_set>

#ifndef _WIN32
#include <sys/resource.h>
#endif

// search specific stuff
#include "handler.h"
#include "search_handler.h"

class SearchServer final : public Application
{
public:
    SearchServer(int argc, char** argv);
    ~SearchServer() override;

    void loadConsoleCommands() override;

    void run() override;

    void periodicCleanup(const asio::error_code& error, asio::steady_timer* timer);
    void ahCleanup();

private:
    // A single IP should only have one request in flight at a time, so we are going to
    // be tracking the IP addresses of incoming requests and if we haven't cleared the
    // record for it - we block until it's done
    SynchronizedShared<std::map<std::string, uint16_t>> IPAddressesInUse_;

    // NOTE: We're only using the read-lock for this
    SynchronizedShared<std::unordered_set<std::string>> IPAddressWhitelist_;
};
