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

#include "0x069_chocobo_racing.h"

#include <string>
#include <vector>

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0074
// This packet is sent by the server for the chocobo racing entrant list in response to GP_CLI_COMMAND_CHOCOBO_RACE_REQ (Kind = ChocoboList).
// It carries the race weather, the entrant stats and the entrant names for a given race.
namespace GP_SERV_COMMAND_CHOCOBO_LIST
{

constexpr size_t kNumRacers  = 8;  // entrants per race
constexpr size_t kNameLength = 16; // chocobo name buffer

struct ChocoboName
{
    uint32_t padding00; // always 0 in captures
    char     Name[kNameLength];
};

// Mode 1: race parameters.
class RACE final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_LIST, RACE>
{
public:
    struct PacketData
    {
        uint32_t SlotIndex; // TODO: Research this more. Mirrors incoming Param.
        uint8_t  padding04[8];
        uint16_t Mode;
        uint16_t ParamSize;
        uint32_t RaceParams[2];
        uint8_t  junk00[152];
    };

    RACE(uint32_t weather);
};

// Mode 2: racers' stats.
class CHOCOBOS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_LIST, CHOCOBOS>
{
public:
    struct PacketData
    {
        uint32_t                                     SlotIndex; // TODO: Research this more. Mirrors incoming Param.
        uint8_t                                      padding04[8];
        uint16_t                                     Mode;
        uint16_t                                     ParamSize;
        GP_SERV_COMMAND_CHOCOBO_RACING::ChocoboParam Chocobos[kNumRacers];
        uint8_t                                      junk00[64];
    };

    CHOCOBOS(const std::vector<GP_SERV_COMMAND_CHOCOBO_RACING::ChocoboParam>& chocobos);
};

// Mode 3: entrant names.
class NAMES final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_LIST, NAMES>
{
public:
    struct PacketData
    {
        uint32_t    SlotIndex; // TODO: Research this more. Mirrors incoming Param.
        uint8_t     padding04[8];
        uint16_t    Mode;
        uint16_t    ParamSize;
        ChocoboName Chocobos[kNumRacers];
    };

    NAMES(const std::vector<std::string>& names);
};

// Mode 4: notify the client the toteboard exchange is done.
class END final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_LIST, END>
{
public:
    struct PacketData
    {
        uint32_t SlotIndex;    // TODO: Research this more. Mirrors incoming Param.
        uint8_t  unknown04[8]; // Used by client but captured as 0
        uint16_t Mode;
        uint16_t ParamSize;
        uint8_t  junk00[160];
    };

    END();
};

} // namespace GP_SERV_COMMAND_CHOCOBO_LIST
