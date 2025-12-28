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

#include "0x0e1_get_lsmsg.h"

#include "common/utils.h"
#include "entities/charentity.h"
#include "linkshell.h"

auto GP_CLI_COMMAND_GET_LSMSG::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    auto pv = PacketValidator()
                  .oneOf<LinkshellSlot>(LinkshellId);

    switch (static_cast<LinkshellSlot>(LinkshellId))
    {
        case LinkshellSlot::LS1:
            pv.mustNotEqual(PChar->PLinkshell1, nullptr, "Character does not have Linkshell 1");
            break;
        case LinkshellSlot::LS2:
            pv.mustNotEqual(PChar->PLinkshell2, nullptr, "Character does not have Linkshell 2");
            break;
    }

    return pv;
}

void GP_CLI_COMMAND_GET_LSMSG::process(MapSession* PSession, CCharEntity* PChar) const
{
    switch (static_cast<LinkshellSlot>(LinkshellId))
    {
        case LinkshellSlot::LS1:
            PChar->PLinkshell1->PushLinkshellMessage(PChar, LinkshellSlot::LS1);
            break;
        case LinkshellSlot::LS2:
            PChar->PLinkshell2->PushLinkshellMessage(PChar, LinkshellSlot::LS2);
            break;
    }
}
