/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "0x0b5_faq_gmparam.h"

GP_SERV_COMMAND_FAQ_GMPARAM::GP_SERV_COMMAND_FAQ_GMPARAM(const uint16_t id)
{
    auto& packet = this->data();

    packet.RescueCount = 0;    // This value has been observed to be 0 and non-zero values.
    packet.params[0]   = 1;    // The first value of this array used to be the number of GM calls in the queue.
    packet.Id          = id;   // This value is reflected from what the client sent in its own 0x0D4
    packet.Option      = 0;    // This value has been observed to be 0. This value may reflect the option(s) selected within the Help Desk menu.
    packet.RescueTime  = 1800; // This value has been observed to be 1800.
}
