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

class CBaseEntity;

enum class GP_SERV_COMMAND_MAGICSCHEDULOR_TYPE : uint8_t
{
    CastSpell    = 0x0,
    UseItem      = 0x1,
    Ability      = 0x2,
    Event1       = 0x3, // Event Related (Misc event animations, banner announcements, etc.)
    Event2       = 0x4, // Event Related (Misc event animations, NPC weaponskills, etc.)
    Unknown1     = 0x5, // Unknown (Has misc ability animations, banner announcements, etc.)
    WeaponSkill  = 0x6,
    Unknown2     = 0x7,
    Unknown3     = 0x8, // Unknown (Has misc ability animations, banner announcements, etc.)
    MonsterSkill = 0x9,
    Unknown4     = 0xA, // Unknown (Has misc warping animations.)
    Unknown5     = 0xB, // Unknown (Has misc banner announcements.)
    Unknown6     = 0xC, // Unknown (Has misc casting animations.)
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x003A
// This packet is sent by the server to inform the client of a magic scheduler animation/event that should play.
class GP_SERV_COMMAND_MAGICSCHEDULOR final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_MAGICSCHEDULOR, GP_SERV_COMMAND_MAGICSCHEDULOR>
{
public:
    struct PacketData
    {
        uint32_t                            UniqueNoCas;  // PS2: UniqueNoCas
        uint32_t                            UniqueNoTar;  // PS2: UniqueNoTar
        uint16_t                            ActIndexCast; // PS2: ActIndexCast
        uint16_t                            ActIndexTar;  // PS2: ActIndexTar
        uint16_t                            fileNum;      // PS2: fileNum
        GP_SERV_COMMAND_MAGICSCHEDULOR_TYPE type;         // PS2: type
        uint8_t                             padding00;    // PS2: padding00
    };

    GP_SERV_COMMAND_MAGICSCHEDULOR(const CBaseEntity* PEntity, const CBaseEntity* PTarget, uint16 animId, GP_SERV_COMMAND_MAGICSCHEDULOR_TYPE type);
};
