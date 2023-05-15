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
#include "common/blowfish.h"
#include "common/cbasetypes.h"
#include "common/console_service.h"
#include "common/logging.h"
#include "common/lua.h"
#include "common/md52.h"
#include "common/mmo.h"
#include "common/settings.h"
#include "common/socket.h"
#include "common/sql.h"
#include "common/taskmgr.h"
#include "common/timer.h"
#include "common/utils.h"
#include "message_server.h"
#include "world_server.h"

// TODO: Standardize our running arguments for shutdown and thread signals
std::atomic<bool> gRunFlag = true;
std::thread       messageThread;
bool              requestExit = false;

int main(int argc, char** argv)
{
    auto pWorldServer = std::make_unique<WorldServer>(argc, argv);

    while (pWorldServer->IsRunning())
    {
        pWorldServer->Tick();
    }

    message_server_close();
    if (messageThread.joinable())
    {
        messageThread.join();
    }
    return 0;
}
