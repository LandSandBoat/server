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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0044
// This packet is sent by the server to populate the clients extended job information.
namespace GP_SERV_COMMAND_EXTENDED_JOB
{
    class PUP final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_EXTENDED_JOB, PUP>
    {
    public:
        struct PacketData
        {
            uint8_t  Job;      // PS2: Job
            uint8_t  IsSubJob; // PS2: IsSubJob
            uint8_t  padding00[2];
            uint8_t  Head;
            uint8_t  Frame;
            uint8_t  Attachments[12];
            uint8_t  unknown00[2];
            uint32_t UnlockedHeads;
            uint32_t UnlockedFrames;
            uint8_t  padding01[24];
            uint32_t UnlockedAttachments[8];
            char     Name[16]; // assumed to be 16, longest name is 14 chars.
            uint16_t HP;
            uint16_t MaxHP;
            uint16_t MP;
            uint16_t MaxMP;
            uint16_t MeleeSkill;
            uint16_t MeleeSkillCap;
            uint16_t RangedSkill;
            uint16_t RangedSkillCap;
            uint16_t MagicSkill;
            uint16_t MagicSkillCap;
            uint8_t  padding03[4];
            uint16_t STR;
            uint16_t BonusSTR;
            uint16_t DEX;
            uint16_t BonusDEX;
            uint16_t VIT;
            uint16_t BonusVIT;
            uint16_t AGI;
            uint16_t BonusAGI;
            uint16_t INT;
            uint16_t BonusINT;
            uint16_t MND;
            uint16_t BonusMND;
            uint16_t CHR;
            uint16_t BonusCHR;
            uint8_t  BonusElementalCapacity;
            uint8_t  padding04[3];
        };

        PUP(CCharEntity* PChar, bool mjob);
    };
} // namespace GP_SERV_COMMAND_EXTENDED_JOB
