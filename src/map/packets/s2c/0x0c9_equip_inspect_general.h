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

class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00C9
// This packet is sent by the server in response to the client checking another player.
// This packet is used to populate the other players information. (Jobs, level, equipment, etc.)
namespace GP_SERV_COMMAND_EQUIP_INSPECT
{

// Mode 1: General information (linkshell, jobs, chevron)
class GENERAL final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_EQUIP_INSPECT, GENERAL>
{
public:
    struct PacketData
    {
        uint32_t UniqNo;               // PS2: UniqNo
        uint16_t ActIndex;             // PS2: ActIndex
        uint8_t  OptionFlag;           // PS2: OptionFlag
        uint8_t  padding0B[3];         // PS2: (New; did not exist.))
        uint16_t ItemNo;               // PS2: ItemNo
        uint8_t  sComLinkName[16];     // PS2: sComLinkName
        uint16_t sComColor;            // PS2: (Unnamed struct of bits.)
        uint8_t  job[2];               // PS2: job
        uint8_t  lvl[2];               // PS2: lvl
        uint8_t  mjob;                 // PS2: mjob
        uint8_t  mlvl;                 // PS2: (New; did not exist.)
        uint8_t  mflags;               // PS2: (New; did not exist.)
        uint8_t  padding29[3];         // PS2: (New; did not exist.)
        uint32_t BallistaChevronCount; // PS2: (New; did not exist.)
        uint8_t  BallistaChevronFlags; // PS2: (New; did not exist.)
        uint8_t  padding31;            // PS2: (New; did not exist.)
        uint16_t BallistaFlags;        // PS2: (New; did not exist.)
        uint32_t MesNo;                // PS2: (New; did not exist.)
        int32_t  Params[5];            // PS2: (New; did not exist.)
        uint8_t  padding4C[8];         // PS2: (New; did not exist.)
    };

    GENERAL(const CCharEntity* PChar, const CCharEntity* PTarget);
};

} // namespace GP_SERV_COMMAND_EQUIP_INSPECT
