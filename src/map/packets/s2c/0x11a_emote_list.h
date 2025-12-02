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

class CCharEntity;

// PS2: (New; did not exist.)
struct jobemotes_t
{
    uint32_t WAR : 1;
    uint32_t MNK : 1;
    uint32_t WHM : 1;
    uint32_t BLM : 1;
    uint32_t RDM : 1;
    uint32_t THF : 1;
    uint32_t PLD : 1;
    uint32_t DRK : 1;
    uint32_t BST : 1;
    uint32_t BRD : 1;
    uint32_t RNG : 1;
    uint32_t SAM : 1;
    uint32_t NIN : 1;
    uint32_t DRG : 1;
    uint32_t SMN : 1;
    uint32_t BLU : 1;
    uint32_t COR : 1;
    uint32_t PUP : 1;
    uint32_t DNC : 1;
    uint32_t SCH : 1;
    uint32_t GEO : 1;
    uint32_t RUN : 1;
    uint32_t unused : 10;
};

// PS2: (New; did not exist.)
struct chairemotes_t
{
    uint16_t Chair1 : 1;  // Chair: Imperial Chair
    uint16_t Chair2 : 1;  // Chair: Decorative Chair
    uint16_t Chair3 : 1;  // Chair: Ornate Stool
    uint16_t Chair4 : 1;  // Chair: Refined Chair
    uint16_t Chair5 : 1;  // Chair: Portable Container
    uint16_t Chair6 : 1;  // Chair: Chocobo Chair
    uint16_t Chair7 : 1;  // Chair: Ephramadian Throne
    uint16_t Chair8 : 1;  // Chair: Shadow Throne
    uint16_t Chair9 : 1;  // Chair: Leaf Bench
    uint16_t Chair10 : 1; // Chair: Astral Cube
    uint16_t Chair11 : 1; // Chair: Chocobo Chair II
    uint16_t unused : 5;
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x011A
// This packet is sent by the server to update the clients unlocked job emotes (/jobemote) and chairs (/sitchair).
class GP_SERV_COMMAND_EMOTE_LIST final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_EMOTE_LIST, GP_SERV_COMMAND_EMOTE_LIST>
{
public:
    struct PacketData
    {
        jobemotes_t   JobEmotes;
        chairemotes_t Chairs;
        uint16_t      padding00;
    };

    GP_SERV_COMMAND_EMOTE_LIST(const CCharEntity* PChar);
};
