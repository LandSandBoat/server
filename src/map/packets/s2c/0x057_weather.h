/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "base.h"

enum class Weather : uint16_t;
// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0057
// This packet is sent by the server to inform the client of weather changes.
class GP_SERV_COMMAND_WEATHER final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_WEATHER, GP_SERV_COMMAND_WEATHER>
{
public:
    struct PacketData
    {
        uint32_t StartTime;
        Weather  WeatherNumber;
        uint16_t WeatherOffsetTime;
    };

    GP_SERV_COMMAND_WEATHER(uint32_t startTime, Weather weatherId, uint16_t offsetTime);
};
