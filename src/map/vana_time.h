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

#ifndef _CVANATIME_H
#define _CVANATIME_H

#define VTIME_BASEDATE		1009810800		// unix epoch - 1009810800 = se epoch (in earth seconds)
#define VTIME_YEAR			518400			// 360 * GameDay
#define VTIME_MONTH			43200			// 30 * GameDay
#define VTIME_WEEK			11520			// 8 * GameDay
#define VTIME_DAY			1440			// 24 hours * GameHour
#define VTIME_HOUR			60				// 60 minutes

#include "../common/cbasetypes.h"

enum DAYTYPE
{
	FIRESDAY		= 0,
	EARTHSDAY		= 1,
	WATERSDAY		= 2,
	WINDSDAY		= 3,
	ICEDAY			= 4,
	LIGHTNINGDAY	= 5,
	LIGHTSDAY		= 6,
	DARKSDAY		= 7
};

enum TIMETYPE
{
    TIME_NONE       = 0,
    TIME_MIDNIGHT   = 1,
    TIME_NEWDAY     = 2,
    TIME_DAWN       = 3,
    TIME_DAY        = 4,
    TIME_DUSK       = 5,
    TIME_EVENING    = 6,
    TIME_NIGHT      = 7
};

class CVanaTime
{
public:

	static	CVanaTime * getInstance();
	static  void delInstance();

	TIMETYPE SyncTime();
	TIMETYPE GetCurrentTOTD();

	uint32	 getDate();
	uint32	 getYear();
	uint32	 getMonth();
	uint32	 getDayOfTheMonth();
	uint32	 getHour();
	uint32	 getMinute();
	uint32	 getWeekday();
	uint32	 getMoonPhase();
	uint8	 getMoonDirection();
	uint8	 getRSERace();
	uint8	 getRSELocation();
	uint32	 getSysHour();
	uint32	 getSysMinute();
	uint32	 getSysSecond();
	uint32	 getSysWeekDay();						// Number of day since sunday
	uint32	 getSysYearDay();						// Number of day since 1st january

    uint32   getVanaTime();
	int32	 getCustomEpoch();

	void	 setCustomEpoch(int32 epoch);

	time_point   lastConquestUpdate;
    time_point   lastVHourlyUpdate;
    time_point   lastVDailyUpdate;
    time_point   lastConquestTally;
    time_point   lastMidnight;

private:

	static CVanaTime * _instance;

	CVanaTime();

	uint32	 m_vYear;								// Vanadiel Year
	uint32	 m_vMon;								// Vanadiel Month
	uint32	 m_vDate;								// Vanadiel Date (day of the month)
	uint32	 m_vHour;								// Vanadiel Hour
	uint32	 m_vMin;								// Vanadiel Minute
	uint32	 m_vDay;								// Vanadiel Day (Day of the week, fire,earth,wind)
	uint32	 m_vanaDate;							// Vanadiel time in integer format

	TIMETYPE m_TimeType;							// текущий тип времени

	int32	 m_customEpoch;						// Custom epoch to use instead of VTIME_BASEDATE
};

#endif
