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

#include "common/cbasetypes.h"

#include "base.h"

enum CONTAINER_ID : uint8;
class CItem;

enum class GP_SERV_COMMAND_MYROOM_OPERATION_RESULT : uint8_t
{
    Ok         = 0, // GP_MYROOM_RESULT_OK
    PlantAdd   = 1, // GP_MYROOM_RESULT_PLANT_ADD_PARAM
    PlantCheck = 2, // GP_MYROOM_RESULT_PLANT_CHECK_PARAM
    PlantCorp  = 3, // GP_MYROOM_RESULT_PLANT_CORP_PARAM
    PlantStop  = 4, // GP_MYROOM_RESULT_PLANT_STOP_PARAM
    Layout     = 5, // GP_MYROOM_RESULT_LAYOUT_PARAM
    Bankin     = 6, // GP_MYROOM_RESULT_BANKIN_PARAM
    End        = 7, // GP_MYROOM_RESULT_END
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00FA
// This packet is sent by the server when the client is interacting with furniture or plants in their mog house.
class GP_SERV_COMMAND_MYROOM_OPERATION final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MYROOM_OPERATION, GP_SERV_COMMAND_MYROOM_OPERATION>
{
public:
    struct PacketData
    {
        uint16_t                                MyroomItemNo;    // PS2: MyroomItemNo
        GP_SERV_COMMAND_MYROOM_OPERATION_RESULT Result;          // PS2: Result
        uint16_t                                unknown00;       // PS2: (New; did not exist.)
        uint8_t                                 MyroomItemIndex; // PS2: ItemIndex
        CONTAINER_ID                            MyroomCategory;  // PS2: (New; did not exist.)
        uint16_t                                unknown01;       // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_MYROOM_OPERATION(const CItem* PItem, CONTAINER_ID locationId, uint8 slotId);
};
