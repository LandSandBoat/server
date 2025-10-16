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

#include "0x061_clistatus.h"

#include "entities/charentity.h"
#include "packets/char_job_extra.h"
#include "packets/char_status.h"
#include "packets/menu_jobpoints.h"
#include "packets/menu_merit.h"
#include "packets/monipulator1.h"
#include "packets/monipulator2.h"
#include "packets/s2c/0x061_clistatus.h"
#include "packets/s2c/0x062_clistatus2.h"
#include "packets/s2c/0x08d_job_points.h"
#include "packets/s2c/0x0df_group_attr.h"
#include "packets/s2c/0x119_abil_recast.h"
#include "packets/status_effects.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_CLISTATUS::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .range("unknown00", unknown00, 0, 1);
}

void GP_CLI_COMMAND_CLISTATUS::process(MapSession* PSession, CCharEntity* PChar) const
{
    PChar->pushPacket<CCharStatusPacket>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_GROUP_ATTR>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS2>(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_ABIL_RECAST>(PChar);
    PChar->pushPacket<CMenuMeritPacket>(PChar);
    PChar->pushPacket<CMonipulatorPacket1>(PChar);
    PChar->pushPacket<CMonipulatorPacket2>(PChar);

    if (charutils::hasKeyItem(PChar, KeyItem::JOB_BREAKER))
    {
        // Only send Job Points Packet if the player has unlocked them
        PChar->pushPacket<CMenuJobPointsPacket>(PChar);
        PChar->pushPacket<GP_SERV_COMMAND_JOB_POINTS>(PChar);
    }

    PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
    PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
    PChar->pushPacket<CStatusEffectPacket>(PChar);
}
