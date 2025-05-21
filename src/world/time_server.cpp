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

#include "time_server.h"

#include "common/cbasetypes.h"
#include "common/task_manager.h"
#include "common/tracy.h"
#include "common/vana_time.h"

#include "conquest_system.h"
#include "daily_tally.h"
#include "world_server.h"

int32 time_server(timer::time_point tick, CTaskManager::CTask* PTask)
{
    TracyZoneScoped;
    // Track elapsed ticks.
    static auto tickNum = 0;
    ++tickNum;

    WorldServer* worldServer = std::any_cast<WorldServer*>(PTask->m_data);

    // Earth-based ticks.
    // Uses the JST equivalent of the current timer tick. (steady_clock -> system_clock)

    // Earth time points
    const auto jstTime    = earth_time::time_point(timer::to_utc(tick));
    const auto jstHour    = earth_time::jst::get_hour(jstTime);
    const auto jstWeekday = earth_time::jst::get_weekday(jstTime);

    // Static variable for the next tick
    static auto nextHourlyTick = std::chrono::ceil<std::chrono::hours>(jstTime);

    // Hourly ticks
    if (jstTime >= nextHourlyTick)
    {
        ShowDebugFmt("1-hour tick... (current tick: {})", tickNum);
        if (jstHour == 0)
        {
            // Daily tick (midnight JST)
            ShowDebugFmt("Daily tick... (current tick: {})", tickNum);
            if (jstWeekday == 1)
            {
                // Weekly tick (Monday JST)
                ShowDebugFmt("Weekly tick... (current tick: {})", tickNum);
                worldServer->conquestSystem_->updateWeekConquest();
            }
            else
            {
                // This should happen every midnight except Monday.
                worldServer->conquestSystem_->updateHourlyConquest();
            }
            dailytally::UpdateDailyTallyPoints();
        }
        else
        {
            // This should happen hourly, except midnight.
            worldServer->conquestSystem_->updateHourlyConquest();
        }
        // 1-hour tick (including every midnight)

        if (jstHour % 2 == 0)
        {
            // 2-hour tick
            ShowDebugFmt("2-hour tick... (current tick: {})", tickNum);
            if (jstHour % 4 == 0)
            {
                // 4-hour tick
                ShowDebugFmt("4-hour tick... (current tick: {})", tickNum);
            }
        }

        nextHourlyTick = std::chrono::ceil<std::chrono::hours>(jstTime);
    }

    // Vana'diel-based ticks.
    // Uses the Vana'diel time equivalent of the current JST time. (steady_clock -> system_clock -> vanadiel_clock)
    // Note: Vana'diel minute is equal to the tick interval (2400ms). It is possible to miss a minute if there is
    //       variance in the tick time.

    // Vana'diel time points
    const auto vanaTime = vanadiel_time::from_earth_time(jstTime);
    const auto vanaTotd = vanadiel_time::get_totd(vanaTime);
    const auto vanaHour = vanadiel_time::get_hour(vanaTime);

    // Static variables for the next tick
    static auto nextVHourlyUpdate = std::chrono::ceil<xi::vanadiel_clock::hours>(vanaTime);
    static auto prevTotd          = vanaTotd;

    if (vanaTime >= nextVHourlyUpdate)
    {
        // Vana'diel Hour
        worldServer->conquestSystem_->updateVanaHourlyConquest();

        if (vanaHour == 0)
        {
            // Vana'diel Day
            ShowDebugFmt("Vana'diel day tick... (current tick: {})", tickNum);
        }

        if (vanaTotd != prevTotd)
        {
            // MIDNIGHT -> NEWDAY -> DAWN -> DAY -> DUSK -> EVENING -> NIGHT

            prevTotd = vanaTotd;
        }

        nextVHourlyUpdate = std::chrono::ceil<xi::vanadiel_clock::hours>(vanaTime);
    }

    return 0;
}
