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

#include "weather.h"

CWeatherPacket::CWeatherPacket(uint32 ChangeTime, WEATHER WeatherEffect, uint8 TransitionTime)
{
    this->id(0x057);
    this->length(12);

    ref<uint32>(0x04) = ChangeTime;
    ref<uint16>(0x08) = WeatherEffect;
    ref<uint8>(0x0A)  = TransitionTime;
}
