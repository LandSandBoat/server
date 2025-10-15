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

#include "0x0e2_set_lsmsg.h"

#include "entities/charentity.h"
#include "enums/msg_std.h"
#include "items/item_linkshell.h"
#include "linkshell.h"

auto GP_CLI_COMMAND_SET_LSMSG::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // TODO: Short-circuit the null check so we can check the permission level here
    auto pv = PacketValidator()
                  .oneOf<GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL>(writeLevel)
                  .mustNotEqual(PChar->PLinkshell1, nullptr, "Character does not have Linkshell 1");

    return pv;
}

void GP_CLI_COMMAND_SET_LSMSG::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto canEditLsMes = [&](CItemLinkshell* PItemLinkshell) -> bool
    {
        switch (PChar->PLinkshell1->m_postRights)
        {
            case GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL::Linkshell:
                // Only the linkshell owner can edit the message
                return PItemLinkshell->GetLSType() == LSTYPE_LINKSHELL;
            case GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL::Pearlsack:
                // Linkshell owner or pearlsack owner can edit the message
                return PItemLinkshell->GetLSType() == LSTYPE_PEARLSACK || PItemLinkshell->GetLSType() == LSTYPE_LINKSHELL;
            case GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL::Linkpearl:
                // Anyone can edit
                return true;
        }

        return false;
    };

    auto* PItemLinkshell = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK1));
    if (PItemLinkshell != nullptr && PItemLinkshell->isType(ITEM_LINKSHELL))
    {
        if (unknown02)
        {
            // This flag is set when changing the linkshell message access level.
            if (PItemLinkshell->GetLSType() == LSTYPE_LINKSHELL) // Only Linkshell owner can change the access level
            {
                PChar->PLinkshell1->setPostRights(static_cast<GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL>(writeLevel));
                return;
            }

            PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::LinkshellNoAccess);
        }
        else if (unknown03)
        {
            // This flag is set when changing the linkshell message.
            if (canEditLsMes(PItemLinkshell))
            {
                const auto lsMessage = asStringFromUntrustedSource(sMessage, sizeof(sMessage));
                PChar->PLinkshell1->setMessage(lsMessage, PChar->getName());
                return;
            }

            PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::LinkshellNoAccess);
        }
    }
}
