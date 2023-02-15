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
#include "world_server.h"

#include "common/application.h"
#include "common/console_service.h"
#include "common/logging.h"

namespace
{
    std::unique_ptr<SqlConnection> sql;
} // namespace

void UpdateDailyTallyPoints()
{
    uint16 dailyTallyLimit  = settings::get<uint16>("main.DAILY_TALLY_LIMIT");
    uint16 dailyTallyAmount = settings::get<uint16>("main.DAILY_TALLY_AMOUNT");

    const char* fmtQuery = "UPDATE char_points \
            SET char_points.daily_tally = LEAST(%u, char_points.daily_tally + %u) \
            WHERE char_points.daily_tally > -1;";

    int32 ret = sql->Query(fmtQuery, dailyTallyLimit, dailyTallyAmount);

    if (ret == SQL_ERROR)
    {
        ShowError("Failed to update daily tally points");
    }
    else
    {
        ShowDebug("Distributed daily tally points");
    }

    fmtQuery = "DELETE FROM char_vars WHERE varname = 'gobbieBoxUsed';";

    if (sql->Query(fmtQuery, dailyTallyAmount) == SQL_ERROR)
    {
        ShowError("Failed to delete daily tally char_vars entries");
    }
}

int32 time_server(time_point tick, CTaskMgr::CTask* PTask)
{
    TracyZoneScoped;
    TIMETYPE VanadielTOTD = CVanaTime::getInstance()->SyncTime();

    // Weekly update for conquest (sunday at midnight)
    static time_point lastConquestTally  = tick - 1h;
    static time_point lastConquestUpdate = tick - 1h;
    if (CVanaTime::getInstance()->getJstWeekDay() == 1 && CVanaTime::getInstance()->getJstHour() == 0 && CVanaTime::getInstance()->getJstMinute() == 0)
    {
        if (tick > (lastConquestTally + 1h))
        {
            lastConquestTally = tick;
        }
    }
    // Hourly conquest update
    else if (CVanaTime::getInstance()->getJstMinute() == 0)
    {
        if (tick > (lastConquestUpdate + 1h))
        {
            lastConquestUpdate = tick;
        }
    }

    // Vanadiel Hour
    static time_point lastVHourlyUpdate = tick - 4800ms;
    if (CVanaTime::getInstance()->getMinute() == 0)
    {
        if (tick > (lastVHourlyUpdate + 4800ms))
        {
            lastVHourlyUpdate = tick;
        }
    }

    // JST Midnight
    static time_point lastTickedJstMidnight = tick - 1h;
    if (CVanaTime::getInstance()->getJstHour() == 0 && CVanaTime::getInstance()->getJstMinute() == 0)
    {
        if (tick > (lastTickedJstMidnight + 1h))
        {
            if (settings::get<bool>("main.ENABLE_DAILY_TALLY"))
            {
                UpdateDailyTallyPoints();
            }

            lastTickedJstMidnight = tick;
        }
    }

    // 4-hour RoE Timed blocks
    static time_point lastTickedRoeBlock = tick - 1h;
    if (CVanaTime::getInstance()->getJstHour() % 4 == 0 && CVanaTime::getInstance()->getJstMinute() == 0)
    {
        if (tick > (lastTickedRoeBlock + 1h))
        {
            lastTickedRoeBlock = tick;
        }
    }

    // Vanadiel Day
    static time_point lastVDailyUpdate = tick - 4800ms;
    if (CVanaTime::getInstance()->getHour() == 0 && CVanaTime::getInstance()->getMinute() == 0)
    {
        if (tick > (lastVDailyUpdate + 4800ms))
        {
            lastVDailyUpdate = tick;
        }
    }

    if (VanadielTOTD != TIME_NONE)
    {
    }

    return 0;
}

WorldServer::WorldServer(int argc, char** argv)
: Application("world", argc, argv)
, messageServer(std::make_unique<message_server_wrapper_t>(std::ref(m_RequestExit)))
, httpServer(std::make_unique<HTTPServer>())
{
    // Anonymous namespace preparation
    sql = std::make_unique<SqlConnection>();

    // Tasks
    CTaskMgr::getInstance()->AddTask("time_server", server_clock::now(), nullptr, CTaskMgr::TASK_INTERVAL, time_server, 2400ms);
}

WorldServer::~WorldServer()
{
}

void WorldServer::Tick()
{
    Application::Tick();
}
