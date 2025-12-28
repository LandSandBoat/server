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

#include "0x0f4_tracking_list.h"

#include "entities/charentity.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_TRACKING_LIST::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(SendFlg, 1, "SendFlg not equal to 1");
}

void GP_CLI_COMMAND_TRACKING_LIST::process(MapSession* PSession, CCharEntity* PChar) const
{
    PChar->loc.zone->WideScan(PChar, charutils::getWideScanRange(PChar));
}
