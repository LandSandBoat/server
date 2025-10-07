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

#include "0x051_grap_list.h"

#include "entities/charentity.h"

GP_SERV_COMMAND_GRAP_LIST::GP_SERV_COMMAND_GRAP_LIST(const CCharEntity* PChar)
{
    auto& packet = this->data();

    const look_t* look  = (PChar->getStyleLocked() ? &PChar->mainlook : &PChar->look);
    packet.GrapIDTbl[0] = look->face;
    packet.GrapIDTbl[0] |= look->race << 8;
    packet.GrapIDTbl[1] = PChar->playerConfig.DisplayHeadOffFlg ? 0x0 : look->head + 0x1000;
    packet.GrapIDTbl[2] = look->body + 0x2000;
    packet.GrapIDTbl[3] = look->hands + 0x3000;
    packet.GrapIDTbl[4] = look->legs + 0x4000;
    packet.GrapIDTbl[5] = look->feet + 0x5000;
    packet.GrapIDTbl[6] = look->main + 0x6000;
    packet.GrapIDTbl[7] = look->sub + 0x7000;
    packet.GrapIDTbl[8] = look->ranged + 0x8000;

    if (PChar->m_Costume2 != 0)
    {
        packet.GrapIDTbl[0] = PChar->m_Costume2;
        packet.GrapIDTbl[8] = 0xFFFF;
    }

    if (PChar->m_PMonstrosity != nullptr)
    {
        packet.GrapIDTbl[0] = PChar->m_PMonstrosity->Look;
        packet.GrapIDTbl[8] = 0xFFFF;
    }
}
