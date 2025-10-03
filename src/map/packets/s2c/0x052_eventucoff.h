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

enum class GP_SERV_COMMAND_EVENTUCOFF_MODE : uint32_t
{
    Standard         = 0, // This mode adjusts the clients standard control.
    EventRecvPending = 1, // This mode adjusts the clients event receive pending flag.
    CancelEvent      = 2, // This mode is used to cancel the current event the client is within.
    CancelInput      = 3, // This mode is used to cancel the clients current numerical or string input during an event.
    Fishing          = 4, // This mode is used to release the client from an event lock related to fishing.
};

class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0052
// This packet is sent by the server to adjust the clients current event user control state.
class GP_SERV_COMMAND_EVENTUCOFF final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_EVENTUCOFF, GP_SERV_COMMAND_EVENTUCOFF>
{
public:
    struct PacketData
    {
        GP_SERV_COMMAND_EVENTUCOFF_MODE Mode; // PS2: Mode
    };

    GP_SERV_COMMAND_EVENTUCOFF(CCharEntity* PChar, GP_SERV_COMMAND_EVENTUCOFF_MODE mode);
};
