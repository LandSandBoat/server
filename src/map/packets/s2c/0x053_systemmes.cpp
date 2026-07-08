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

#include "0x053_systemmes.h"

GP_SERV_COMMAND_SYSTEMMES::GP_SERV_COMMAND_SYSTEMMES(const uint32 param0, const uint32 param1, const MsgStd messageId)
{
    auto& packet = this->data();

    packet.para   = param0;
    packet.para2  = param1;
    packet.Number = messageId;
}
