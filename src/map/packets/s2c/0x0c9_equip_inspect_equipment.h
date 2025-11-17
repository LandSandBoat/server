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
// PS2: SAVE_EQUIP_KIND
enum class SAVE_EQUIP_KIND : uint8_t
{
    SAVE_EQUIP_KIND_RIGHTHAND   = 0,
    SAVE_EQUIP_KIND_LEFTHAND    = 1,
    SAVE_EQUIP_KIND_BOW         = 2,
    SAVE_EQUIP_KIND_ARROW       = 3,
    SAVE_EQUIP_KIND_HEAD        = 4,
    SAVE_EQUIP_KIND_BODY        = 5,
    SAVE_EQUIP_KIND_ARM         = 6,
    SAVE_EQUIP_KIND_LEG         = 7,
    SAVE_EQUIP_KIND_FOOT        = 8,
    SAVE_EQUIP_KIND_NECK        = 9,
    SAVE_EQUIP_KIND_BELT        = 10,
    SAVE_EQUIP_KIND_RIGHTEAR    = 11,
    SAVE_EQUIP_KIND_LEFTEAR     = 12,
    SAVE_EQUIP_KIND_RIGHTFINGER = 13,
    SAVE_EQUIP_KIND_LEFTFINGER  = 14,
    SAVE_EQUIP_KIND_BACKPACK    = 15,
    SAVE_EQUIP_KIND_END         = 16,
};

// PS2: (New; did not exist.)
struct checkitem_t
{
    uint16_t        ItemNo;    // PS2: (New; did not exist.)
    SAVE_EQUIP_KIND EquipKind; // PS2: (New; did not exist.)
    uint8_t         padding03; // PS2: (New; did not exist.)
    uint8_t         Data[24];  // PS2: (New; did not exist.)
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x00C9
// This packet is sent by the server in response to the client checking another player.
// This packet is used to populate the other players information. (Jobs, level, equipment, etc.)
namespace GP_SERV_COMMAND_EQUIP_INSPECT
{

// Mode 3: Equipment information (sent in batches of up to 8 items)
class EQUIPMENT final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_EQUIP_INSPECT, EQUIPMENT>
{
public:
    struct PacketData
    {
        uint32_t    UniqNo;     // PS2: UniqNo
        uint16_t    ActIndex;   // PS2: ActIndex
        uint8_t     OptionFlag; // PS2: OptionFlag
        uint8_t     EquipCount; // PS2: (New; did not exist.)
        checkitem_t Equip[8];   // PS2: (New; did not exist.)
    };

    EQUIPMENT(CCharEntity* PChar, CCharEntity* PTarget);
};

} // namespace GP_SERV_COMMAND_EQUIP_INSPECT
