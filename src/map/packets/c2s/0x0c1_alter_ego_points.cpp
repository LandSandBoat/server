/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "0x0c1_alter_ego_points.h"

#include "entities/charentity.h"
#include "enums/alter_ego_points.h"
#include "packets/s2c/0x08e_alter_ego_points.h"

auto GP_CLI_COMMAND_ALTER_EGO_POINTS::validate(MapSession* PSession, const CCharEntity* PChar) const
    -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent, BlockedState::AbnormalStatus })
        .oneOf<AlterEgoCategory>(this->CategoryIndex)
        .isInMogHouse()
        .hasKeyItem(KeyItem::CIPHER_BRACELET)
        .custom([&](PacketValidator& v)
                {
                    if (PChar->GetMLevel() < 99)
                    {
                        v.mustEqual(true, false, "Main job must be Level 99");
                    }
                });
}

void GP_CLI_COMMAND_ALTER_EGO_POINTS::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Entrypoint for player requesting Alter Ego upgrade
    // 1) Verify PC has enough points to spend (0->10=1pt, 10->20=2 pts, 20->30=3pts, 30->40=4pts, 40->50=5pts
    // 2) Verify PC is not attempting to upgrade past the cap (50)
    // 3) Save upgrade to DB
    // 4) Substract spent alter_ego_points
    // 5) Emit BATTLE_MESSAGE message 828 with Data set to CategoryIndex and Data2 set to upgrade level
    // PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, this->CategoryIndex, 1, MsgBasic::AlterEgoUpgrade);
    // 6) Send updated array to PC
    PChar->pushPacket<GP_SERV_PACKET_ALTER_EGO_POINTS>(PChar);
}
