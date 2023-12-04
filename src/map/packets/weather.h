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

#ifndef _CWEATHERPACKET_H
#define _CWEATHERPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"

enum WEATHER
{
    WEATHER_NONE          = 0,
    WEATHER_SUNSHINE      = 1,
    WEATHER_CLOUDS        = 2,
    WEATHER_FOG           = 3,
    WEATHER_HOT_SPELL     = 4,
    WEATHER_HEAT_WAVE     = 5,
    WEATHER_RAIN          = 6,
    WEATHER_SQUALL        = 7,
    WEATHER_DUST_STORM    = 8,
    WEATHER_SAND_STORM    = 9,
    WEATHER_WIND          = 10,
    WEATHER_GALES         = 11,
    WEATHER_SNOW          = 12,
    WEATHER_BLIZZARDS     = 13,
    WEATHER_THUNDER       = 14,
    WEATHER_THUNDERSTORMS = 15,
    WEATHER_AURORAS       = 16,
    WEATHER_STELLAR_GLARE = 17,
    WEATHER_GLOOM         = 18,
    WEATHER_DARKNESS      = 19
};
#define MAX_WEATHER_ID 20
DECLARE_FORMAT_AS_UNDERLYING(WEATHER);

#define WEATHER_CYCLE 2160

class CWeatherPacket : public CBasicPacket
{
public:
    CWeatherPacket(uint32 ChangeTime, WEATHER WeatherEffect, uint8 TransitionTime);
};

#endif
