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

#include "0x086_guild_open.h"

#include "common/utils.h"

GP_SERV_COMMAND_GUILD_OPEN::GP_SERV_COMMAND_GUILD_OPEN(const GP_SERV_COMMAND_GUILD_OPEN_STAT status, const uint8 open, const uint8 close, const uint8 holiday)
{
    auto& packet = this->data();

    packet.Stat = status;

    switch (status)
    {
        case GP_SERV_COMMAND_GUILD_OPEN_STAT::Open:
        case GP_SERV_COMMAND_GUILD_OPEN_STAT::Close:
        {
            // Pack guild hours into Time field (bits representing open to close hours)
            packBitsBE(reinterpret_cast<uint8*>(&packet.Time), 0xFFFFFF, open, close - open);
        }
        break;
        case GP_SERV_COMMAND_GUILD_OPEN_STAT::Holiday:
        {
            packet.Time = holiday;
        }
        break;
    }
}
