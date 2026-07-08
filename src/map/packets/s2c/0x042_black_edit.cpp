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

#include "0x042_black_edit.h"

GP_SERV_COMMAND_BLACK_EDIT::GP_SERV_COMMAND_BLACK_EDIT(uint32 accId, const std::string& targetName, const GP_SERV_COMMAND_BLACK_EDIT_MODE mode)
{
    auto& packet = this->data();

    switch (mode)
    {
        case GP_SERV_COMMAND_BLACK_EDIT_MODE::Add:
        case GP_SERV_COMMAND_BLACK_EDIT_MODE::Delete:
        {
            packet.Data.ID = accId;
            packet.Mode    = mode;
            std::memcpy(packet.Data.Name, targetName.c_str(), std::min<size_t>(targetName.size(), sizeof(packet.Data.Name)));
            break;
        }
        case GP_SERV_COMMAND_BLACK_EDIT_MODE::Error:
        {
            packet.Data.ID = 0;
            packet.Mode    = mode;
            break;
        }
    }
}
