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
#include "common/cbasetypes.h"
#include "packets/c2s/0x03d_black_edit.h"

enum class GP_SERV_COMMAND_BLACK_EDIT_MODE : int8_t
{
    Add    = 0,
    Delete = 1,
    Error  = 2,
};

class GP_SERV_COMMAND_BLACK_EDIT final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_BLACK_EDIT, GP_SERV_COMMAND_BLACK_EDIT>
{
public:
    struct PacketData
    {
        SAVE_BLACK                      Data;         // PS2: Data
        GP_SERV_COMMAND_BLACK_EDIT_MODE Mode;         // PS2: Mode
        uint8_t                         padding00[3]; // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_BLACK_EDIT(uint32 accId, const std::string& targetName, GP_SERV_COMMAND_BLACK_EDIT_MODE mode);
};
