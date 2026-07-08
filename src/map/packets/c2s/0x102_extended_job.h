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

struct blu_data_t
{
    uint8_t SpellId;
    uint8_t unknown00;
    uint8_t padding00[2];
    uint8_t JobIndex;
    uint8_t SupportJobFlg;
    uint8_t padding01[2];
    uint8_t Spells[20];
    uint8_t unused00[132];
};

enum class AutomatonSlot : uint8_t
{
    Head         = 0,
    Frame        = 1,
    Attachment1  = 2,
    Attachment2  = 3,
    Attachment3  = 4,
    Attachment4  = 5,
    Attachment5  = 6,
    Attachment6  = 7,
    Attachment7  = 8,
    Attachment8  = 9,
    Attachment9  = 10,
    Attachment10 = 11,
    Attachment11 = 12,
    Attachment12 = 13,
};

struct pup_data_t
{
    uint8_t ItemId;
    uint8_t unknown00;
    uint8_t padding00[2];
    uint8_t JobIndex;
    uint8_t SupportJobFlg;
    uint8_t padding01[2];
    uint8_t Slots[14];
    uint8_t unused00[138];
};

struct mon_flags0_t
{
    uint8_t SpeciesFlag : 1;     // 0x01
    uint8_t unknown_0_1 : 1;     // 0x02 (unused)
    uint8_t InstinctFlag : 1;    // 0x04
    uint8_t Descriptor1Flag : 1; // 0x08
    uint8_t Descriptor2Flag : 1; // 0x10
    uint8_t unknown_1_1 : 1;     // 0x20 (unused)
    uint8_t unknown_1_2 : 1;     // 0x40 (unused)
    uint8_t unknown_1_3 : 1;     // 0x80 (unused)
};

struct mon_data_t
{
    uint8_t      unknown00[6];     // 0x04-0x09
    mon_flags0_t Flags0;           // 0x0A
    uint8_t      unknown01;        // 0x0B
    uint16_t     SpeciesIndex;     // 0x0C-0x0D
    uint16_t     unknown02;        // 0x0E-0x0F
    uint16_t     Slots[12];        // 0x10-0x27
    uint8_t      Descriptor1Index; // 0x28
    uint8_t      Descriptor2Index; // 0x29
    uint8_t      unused00[122];    // 0x2A onwards
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0102
// This packet is sent by the client when interacting with an extended job-specific system.
// This is used for things such as:
// - Editing equipped Blue Mage spells.
// - Editing equipped Automaton attachments.
// - Editing equipped Monstrosity instincts.
// clang-format off
GP_CLI_PACKET(GP_CLI_COMMAND_EXTENDED_JOB,
    union {
        blu_data_t bluData; // BLU spells
        pup_data_t pupData; // PUP attachment
        mon_data_t monData; // Monstrosity data, used for the Monstrosity system
    } Data;
);
// clang-format on
