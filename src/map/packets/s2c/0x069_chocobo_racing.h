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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0069
// This packet is sent by the server in relation to the chocobo racing event.
// It has multiple purposes related to this event.
// TODO: Actual VLAs sizes and underlying structs unknown.
namespace GP_SERV_COMMAND_CHOCOBO_RACING
{

// Mode=1 This mode is used to update the ChocoboRacingSys.RacingParams data.
class RACINGPARAMS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_RACING, RACINGPARAMS>
{
public:
    struct PacketData
    {
        uint8_t  Mode;          // PS2: (New; did not exist.)
        uint8_t  padding00[3];  // PS2: (New; did not exist.)
        uint32_t RaceParams[2]; // PS2: (New; did not exist.)
        uint8_t  junk00[184];   // PS2: (New; did not exist.)
    };

    // TODO: Unimplemented
    RACINGPARAMS() = default;
};

// Mode=2 This mode is used to update the ChocoboRacingSys.ChocoboParams data.
class CHOCOBOPARAMS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_RACING, CHOCOBOPARAMS>
{
public:
    struct PacketData
    {
        uint8_t Mode;           // PS2: (New; did not exist.)
        uint8_t ParamIndex;     // PS2: (New; did not exist.)
        uint8_t ParamSize;      // PS2: (New; did not exist.)
        uint8_t padding00;      // PS2: (New; did not exist.)
        uint8_t ParamData[192]; // PS2: (New; did not exist.)
    };

    // TODO: Unimplemented
    CHOCOBOPARAMS() = default;
};

// Mode=3 This mode is used to update the ChocoboRacingSys.SectionParams data.
class SECTIONPARAMS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_RACING, SECTIONPARAMS>
{
public:
    struct PacketData
    {
        uint8_t Mode;           // PS2: (New; did not exist.)
        uint8_t ParamIndex;     // PS2: (New; did not exist.)
        uint8_t ParamSize;      // PS2: (New; did not exist.)
        uint8_t padding00;      // PS2: (New; did not exist.)
        uint8_t ParamData[192]; // PS2: (New; did not exist.)
    };

    // TODO: Unimplemented
    SECTIONPARAMS() = default;
};

// Mode=4 This mode is used to update the ChocoboRacingSys.ResultParams and ChocoboRacingSys.SectionParams data.
class RESULTPARAMS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_RACING, RESULTPARAMS>
{
public:
    struct PacketData
    {
        uint8_t Mode;           // PS2: (New; did not exist.)
        uint8_t padding00;      // PS2: (New; did not exist.)
        uint8_t ParamSize;      // PS2: (New; did not exist.)
        uint8_t padding01;      // PS2: (New; did not exist.)
        uint8_t ParamData[192]; // PS2: (New; did not exist.) Note: Documented as 2 VLAs on XiPackets
    };

    // TODO: Unimplemented
    RESULTPARAMS() = default;
};

// Mode=5 The client ignores all data in the packet and will only set the ChocoboRacingSys.DownloadFlg to 1
class END final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_RACING, END>
{
public:
    struct PacketData
    {
        uint8_t Mode;           // PS2: (New; did not exist.)
        uint8_t padding00[195]; // PS2: (New; did not exist.)
    };

    // TODO: Unimplemented
    END() = default;
};

} // namespace GP_SERV_COMMAND_CHOCOBO_RACING
