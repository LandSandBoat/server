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

#include "../../common/socket.h"

#include "currency2.h"

#include "../entities/charentity.h"

CCurrencyPacket2::CCurrencyPacket2(CCharEntity* PChar)
{
	this->type = 0x18;
	this->size = 0x25;

    const char* query = "SELECT bayld, kinetic_unit, imprimaturs, obsidian_fragment, lebondopt_wing, \
                         pulchridopt_wing, mweya_plasm FROM char_points WHERE charid = %d";

    int ret = Sql_Query(SqlHandle, query, PChar->id);
    if (ret != SQL_ERROR && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        ref<uint32>(0x04) = Sql_GetIntData(SqlHandle, 0);
        ref<uint16>(0x08) = Sql_GetUIntData(SqlHandle, 1);
        ref<uint8>(0x0A) = Sql_GetUIntData(SqlHandle, 2);
        ref<uint32>(0x0C) = Sql_GetIntData(SqlHandle, 3);
        ref<uint16>(0x10) = Sql_GetUIntData(SqlHandle, 4);
        ref<uint16>(0x12) = Sql_GetUIntData(SqlHandle, 5);
        ref<uint32>(0x14) = Sql_GetIntData(SqlHandle, 6);
    }
}
