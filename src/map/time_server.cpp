/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "../common/showmsg.h"

#include "utils/guildutils.h"
#include "utils/instanceutils.h"
#include "roe.h"
#include "time_server.h"
#include "timetriggers.h"
#include "transport.h"
#include "vana_time.h"
#include "utils/zoneutils.h"
#include "conquest_system.h"
#include "lua/luautils.h"
#include "entities/charentity.h"
#include "latent_effect_container.h"
#include "daily_system.h"

int32 time_server(time_point tick, CTaskMgr::CTask* PTask)
{
    TracyZoneScoped;
    TIMETYPE VanadielTOTD = CVanaTime::getInstance()->SyncTime();
    // uint8 WeekDay = (uint8)CVanaTime::getInstance()->getWeekday();

    // Weekly update for conquest (sunday at midnight)
    static time_point lastConquestTally = tick - 1h;
    static time_point lastConquestUpdate = tick - 1h;
    if (CVanaTime::getInstance()->getJstWeekDay() == 1  && CVanaTime::getInstance()->getJstHour() == 0 && CVanaTime::getInstance()->getJstMinute() == 0)
    {
        if (tick > (lastConquestTally + 1h))
        {
            conquest::UpdateWeekConquest();
            lastConquestTally = tick;
        }
    }
    // Hourly conquest update
    else if (CVanaTime::getInstance()->getJstMinute() == 0)
    {
        if (tick > (lastConquestUpdate + 1h))
        {
            conquest::UpdateConquestSystem();
            lastConquestUpdate = tick;
        }
    }

    // Vanadiel Hour
    static time_point lastVHourlyUpdate = tick - 4800ms;
    if (CVanaTime::getInstance()->getMinute() == 0)
    {
        if (tick > (lastVHourlyUpdate + 4800ms))
        {
			zoneutils::ForEachZone([](CZone* PZone)
            {
                luautils::OnGameHour(PZone);
				PZone->ForEachChar([](CCharEntity* PChar)
				{
					PChar->PLatentEffectContainer->CheckLatentsHours();
					PChar->PLatentEffectContainer->CheckLatentsMoonPhase();
				});
			});

            lastVHourlyUpdate = tick;
        }

    }

    // JST Midnight
    static time_point lastTickedJstMidnight = tick - 1h;
    if (CVanaTime::getInstance()->getJstHour() == 0 && CVanaTime::getInstance()->getJstMinute() == 0)
    {
        if (tick > (lastTickedJstMidnight + 1h))
        {
            daily::UpdateDailyTallyPoints();
            roeutils::CycleDailyRecords();
            guildutils::UpdateGuildPointsPattern();
            lastTickedJstMidnight = tick;
        }
    }

    // 4-hour RoE Timed blocks
    static time_point lastTickedRoeBlock = tick - 1h;
    if (CVanaTime::getInstance()->getJstHour() % 4 == 0 && CVanaTime::getInstance()->getJstMinute() == 0)
    {
        if (tick > (lastTickedRoeBlock + 1h))
        {
            roeutils::CycleTimedRecords();
            lastTickedRoeBlock = tick;
        }
    }

    // Vanadiel Day
    static time_point lastVDailyUpdate = tick - 4800ms;
    if (CVanaTime::getInstance()->getHour() == 0 && CVanaTime::getInstance()->getMinute() == 0)
    {
        TracyZoneScoped;
        if (tick > (lastVDailyUpdate + 4800ms))
        {
			zoneutils::ForEachZone([](CZone* PZone)
			{
                luautils::OnGameDay(PZone);
				PZone->ForEachChar([](CCharEntity* PChar)
				{
					PChar->PLatentEffectContainer->CheckLatentsWeekDay();
				});
			});

            guildutils::UpdateGuildsStock();
            zoneutils::SavePlayTime();

            lastVDailyUpdate = tick;
        }
    }

    if (VanadielTOTD != TIME_NONE)
    {
        TracyZoneScoped;
        zoneutils::TOTDChange(VanadielTOTD);

        if ((VanadielTOTD == TIME_DAY) || (VanadielTOTD == TIME_DUSK) || (VanadielTOTD == TIME_NIGHT))
        {
			zoneutils::ForEachZone([](CZone* PZone)
			{
				PZone->ForEachChar([](CCharEntity* PChar)
				{
					PChar->PLatentEffectContainer->CheckLatentsDay();
					PChar->PLatentEffectContainer->CheckLatentsJobLevel();
				});
			});
        }
    }

    CTriggerHandler::getInstance()->triggerTimer();
    CTransportHandler::getInstance()->TransportTimer();

    instanceutils::CheckInstance();

    TracyFrameMark;
    return 0;
}
