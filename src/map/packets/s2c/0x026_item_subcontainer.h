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

enum CONTAINER_ID : uint8;
// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0026
// This packet is sent by the server to inform the player of an items sub-container information.
class GP_SERV_COMMAND_ITEM_SUBCONTAINER final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_ITEM_SUBCONTAINER, GP_SERV_COMMAND_ITEM_SUBCONTAINER>
{
public:
    struct PacketData
    {
        uint8_t      is_used;
        CONTAINER_ID container;
        uint8_t      index;
        // Anything below is specific to Mannequins
        uint8_t  unknown00;
        uint8_t  unknown01[2];
        uint16_t model_id_race_hair;
        uint16_t model_id_head;
        uint16_t model_id_body;
        uint16_t model_id_hands;
        uint16_t model_id_legs;
        uint16_t model_id_feet;
        uint16_t model_id_main;
        uint16_t model_id_sub;
        uint16_t model_id_range;
    };

    GP_SERV_COMMAND_ITEM_SUBCONTAINER(CONTAINER_ID locationId, uint8_t slotId);
    GP_SERV_COMMAND_ITEM_SUBCONTAINER(CONTAINER_ID locationId, uint8_t slotId, uint16_t headId, uint16_t bodyId, uint16_t handsId, uint16_t legId, uint16_t feetId, uint16_t mainId, uint16_t subId, uint16_t rangeId);
};
