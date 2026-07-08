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

// TODO: Figure out appropriate names
// This value is used to determine the message type.
// The client uses a local lookup table for this value. Any value that is >= 8 will be ignored and defaults to 0, otherwise the following table is used:
enum class GP_SERV_COMMAND_TALKNUMNAME_TYPE : uint8_t
{
    Unknown0 = 0,
    Unknown1 = 1,
    Unknown2 = 2,
    Unknown3 = 3,
    Unknown4 = 4,
    Unknown5 = 5,
    Unknown6 = 6,
    Unknown7 = 7,
};

class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0043
// This packet is sent by the server to display a formatted message loaded from the DAT files.
class GP_SERV_COMMAND_TALKNUMNAME final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_TALKNUMNAME, GP_SERV_COMMAND_TALKNUMNAME>
{
public:
    struct PacketData
    {
        uint32_t                         UniqueNo;
        uint16_t                         ActIndex;
        uint16_t                         MesNum;
        GP_SERV_COMMAND_TALKNUMNAME_TYPE Type;
        uint8_t                          padding00;
        uint16_t                         padding01;
        uint8_t                          sName[16];
    };

    GP_SERV_COMMAND_TALKNUMNAME(const CCharEntity* PChar, uint16_t msgId);
};
