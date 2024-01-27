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

#include "logging.h"

#include <ctime>

#include "vana_time.h"

CVanaTime::CVanaTime()
{
    setCustomEpoch(0);
}

uint32 CVanaTime::getDate() const
{
    return m_vanaDate;
}

uint32 CVanaTime::getYear() const
{
    return m_vYear;
}

uint32 CVanaTime::getMonth() const
{
    return m_vMon;
}

uint32 CVanaTime::getDayOfTheMonth() const
{
    return m_vDate;
}

uint32 CVanaTime::getHour() const
{
    return m_vHour;
}

uint32 CVanaTime::getMinute() const
{
    return m_vMin;
}

uint32 CVanaTime::getWeekday() const
{
    return m_vDay;
}

uint32 CVanaTime::getSysTime()
{
    return static_cast<uint32>(time(nullptr));
}

uint32 CVanaTime::getSysHour()
{
    time_t now = time(nullptr);
    tm     ltm{};

    _localtime_s(&ltm, &now);

    return ltm.tm_hour;
}

uint32 CVanaTime::getSysMinute()
{
    time_t now = time(nullptr);
    tm     ltm{};

    _localtime_s(&ltm, &now);

    return ltm.tm_min;
}

uint32 CVanaTime::getSysSecond()
{
    time_t now = time(nullptr);
    tm     ltm{};

    _localtime_s(&ltm, &now);

    return ltm.tm_sec;
}

uint32 CVanaTime::getSysWeekDay()
{
    time_t now = time(nullptr);
    tm     ltm{};

    _localtime_s(&ltm, &now);

    return ltm.tm_wday;
}

uint32 CVanaTime::getSysYearDay()
{
    time_t now = time(nullptr);
    tm     ltm{};

    _localtime_s(&ltm, &now);

    return ltm.tm_yday;
}

uint32 CVanaTime::getJstHour()
{
    auto now = time(nullptr) + JST_OFFSET;
    tm   jtm{};

    _gmtime_s(&jtm, &now);

    return jtm.tm_hour;
}

uint32 CVanaTime::getJstMinute()
{
    auto now = time(nullptr) + JST_OFFSET;
    tm   jtm{};

    _gmtime_s(&jtm, &now);

    return jtm.tm_min;
}

uint32 CVanaTime::getJstSecond()
{
    auto now = time(nullptr) + JST_OFFSET;
    tm   jtm{};

    _gmtime_s(&jtm, &now);

    return jtm.tm_sec;
}

uint32 CVanaTime::getJstWeekDay()
{
    auto now = time(nullptr) + JST_OFFSET;
    tm   jtm{};

    _gmtime_s(&jtm, &now);

    return jtm.tm_wday;
}

uint32 CVanaTime::getJstDayOfMonth()
{
    auto now = time(nullptr) + JST_OFFSET;
    tm   jtm{};

    _gmtime_s(&jtm, &now);

    return jtm.tm_mday;
}

uint32 CVanaTime::getJstYearDay()
{
    auto now = time(nullptr) + JST_OFFSET;
    tm   jtm{};

    _gmtime_s(&jtm, &now);

    return jtm.tm_yday;
}

uint32 CVanaTime::getJstMidnight()
{
    auto now = time(nullptr) + JST_OFFSET;
    tm   jst{};

    _gmtime_s(&jst, &now);

    jst.tm_hour = 0;
    jst.tm_min  = 0;
    jst.tm_sec  = 0;

    return static_cast<uint32>(timegm(&jst) - JST_OFFSET + (60 * 60 * 24)); // Unix timestamp of the upcoming JST midnight
}

uint32 CVanaTime::getVanaTime() const
{
    // all functions/variables for in game time should be derived from this
    return (uint32)time(nullptr) - (m_customEpoch ? m_customEpoch : VTIME_BASEDATE);
}

uint32 CVanaTime::getEpoch() const
{
    return m_customEpoch ? m_customEpoch : VTIME_BASEDATE;
}

uint32 CVanaTime::getCustomEpoch() const
{
    return m_customEpoch;
}

void CVanaTime::setCustomEpoch(int32 epoch)
{
    m_customEpoch = epoch;
    m_TimeType    = SyncTime();
}

TIMETYPE CVanaTime::GetCurrentTOTD()
{
    return m_TimeType;
}

uint32 CVanaTime::getMoonPhase() const
{
    int32  phase   = 0;
    double daysmod = (int32)(((m_vanaDate / VTIME_DAY) + 26) % 84);

    if (daysmod >= 42)
    {
        phase = (int32)(100 * ((daysmod - 42) / 42) + 0.5);
    }
    else
    {
        phase = (int32)(100 * (1 - (daysmod / 42)) + 0.5);
    }

    return phase;
}

uint8 CVanaTime::getMoonDirection() const
{
    double daysmod = (int32)(((m_vanaDate / VTIME_DAY) + 26) % 84);

    if (daysmod == 42 || daysmod == 0)
    {
        return 0; // neither waxing nor waning
    }
    else if (daysmod < 42)
    {
        return 1; // waning
    }
    else
    {
        return 2; // waxing
    }
}

uint8 CVanaTime::getRSERace() const
{
    return (uint8)(((m_vanaDate / VTIME_WEEK) - 22) % 8) + 1;
}

uint8 CVanaTime::getRSELocation() const
{
    return (uint8)(((m_vanaDate / VTIME_WEEK) - 21) % 3);
}

TIMETYPE CVanaTime::SyncTime()
{
    m_vanaDate = (uint32)(this->getVanaTime() / 60.0 * 25) +
                 886 * VTIME_YEAR; // convert vana time (from SE epoch in earth seconds) to vanadiel minutes and add 886 vana years

    m_vYear = m_vanaDate / VTIME_YEAR;
    m_vMon  = (m_vanaDate / VTIME_MONTH) % 12 + 1;
    m_vDate = (m_vanaDate / VTIME_DAY) % 30 + 1;
    m_vDay  = (m_vanaDate % VTIME_WEEK) / VTIME_DAY;
    m_vHour = (m_vanaDate % VTIME_DAY) / VTIME_HOUR;
    m_vMin  = m_vanaDate % VTIME_HOUR;

    static uint8 lastTickedHour = m_vHour;
    if (m_vHour == (lastTickedHour + 1) % 24u)
    {
        lastTickedHour = m_vHour;
        switch (m_vHour)
        {
            case 0:
                m_TimeType = TIME_MIDNIGHT;
                return TIME_MIDNIGHT;
            case 4:
                m_TimeType = TIME_NEWDAY;
                return TIME_NEWDAY;
            case 6:
                m_TimeType = TIME_DAWN;
                return TIME_DAWN;
            case 7:
                m_TimeType = TIME_DAY;
                return TIME_DAY;
            case 17:
                m_TimeType = TIME_DUSK;
                return TIME_DUSK;
            case 18:
                m_TimeType = TIME_EVENING;
                return TIME_EVENING;
            case 20:
                m_TimeType = TIME_NIGHT;
                return TIME_NIGHT;
        }
    }
    return TIME_NONE;
}
