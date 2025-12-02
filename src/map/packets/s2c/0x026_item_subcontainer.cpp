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

#include "0x026_item_subcontainer.h"

#include "item_container.h"

GP_SERV_COMMAND_ITEM_SUBCONTAINER::GP_SERV_COMMAND_ITEM_SUBCONTAINER(const CONTAINER_ID locationId, const uint8_t slotId)
{
    auto& packet = this->data();

    packet.container = locationId;
    packet.index     = slotId;
}

GP_SERV_COMMAND_ITEM_SUBCONTAINER::GP_SERV_COMMAND_ITEM_SUBCONTAINER(const CONTAINER_ID locationId, const uint8_t slotId, const uint16_t headId, const uint16_t bodyId, const uint16_t handsId, const uint16_t legId, const uint16_t feetId, const uint16_t mainId, const uint16_t subId, const uint16_t rangeId)
{
    auto& packet = this->data();

    packet.is_used   = 0x01;
    packet.container = locationId;
    packet.index     = slotId;

    packet.model_id_race_hair = 0x01; // TODO: This is wrong. Mannequins use the same race values as player entities. However, they use a custom face/hair model id of 31.
    packet.model_id_head      = headId + 0x1000;
    packet.model_id_body      = bodyId + 0x2000;
    packet.model_id_hands     = handsId + 0x3000;
    packet.model_id_legs      = legId + 0x4000;
    packet.model_id_feet      = feetId + 0x5000;
    packet.model_id_main      = mainId + 0x6000;
    packet.model_id_sub       = subId + 0x7000;
    packet.model_id_range     = rangeId + 0x8000;
}
