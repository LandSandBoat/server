#include "time_server.h"

#include "../common/cbasetypes.h"
#include "../common/taskmgr.h"
#include "../common/tracy.h"
#include "../common/vana_time.h"
#include "gobbie_box.h"
#include "world_server.h"

int32 time_server(time_point tick, CTaskMgr::CTask* PTask)
{
    TracyZoneScoped;
    TIMETYPE     VanadielTOTD = CVanaTime::getInstance()->SyncTime();
    WorldServer* worldServer  = std::any_cast<WorldServer*>(PTask->m_data);

    // Weekly update for conquest (sunday at midnight)
    static time_point lastConquestTally  = tick - 1h;
    static time_point lastConquestUpdate = tick - 1h;
    if (CVanaTime::getInstance()->getJstWeekDay() == 1 && CVanaTime::getInstance()->getJstHour() == 0 && CVanaTime::getInstance()->getJstMinute() == 0)
    {
        if (tick > (lastConquestTally + 1h))
        {
            worldServer->conquestSystem->updateWeekConquest();
            lastConquestTally = tick;
        }
    }
    // Hourly conquest update
    else if (CVanaTime::getInstance()->getJstMinute() == 0)
    {
        if (tick > (lastConquestUpdate + 1h))
        {
            worldServer->conquestSystem->updateHourlyConquest();
            lastConquestUpdate = tick;
        }
    }

    // Vanadiel Hour
    static time_point lastVHourlyUpdate = tick - 4800ms;
    if (CVanaTime::getInstance()->getMinute() == 0)
    {
        if (tick > (lastVHourlyUpdate + 4800ms))
        {
            worldServer->conquestSystem->updateVanaHourlyConquest();
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
                gobbiebox::UpdateDailyTallyPoints(worldServer);
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
