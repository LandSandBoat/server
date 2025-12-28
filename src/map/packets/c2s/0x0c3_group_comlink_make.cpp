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

#include "0x0c3_group_comlink_make.h"

#include "entities/charentity.h"
#include "items.h"
#include "items/item_linkshell.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

auto GP_CLI_COMMAND_GROUP_COMLINK_MAKE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(State, 0, "State not 0")
        .oneOf<GP_CLI_COMMAND_GROUP_COMLINK_MAKE_LINKSHELLID>(LinkshellId)
        .hasLinkshellRank(PChar, LinkshellId, LSTYPE_PEARLSACK);
}

void GP_CLI_COMMAND_GROUP_COMLINK_MAKE::process(MapSession* PSession, CCharEntity* PChar) const
{
    const CItemLinkshell* PItemLinkshell = nullptr;

    switch (static_cast<GP_CLI_COMMAND_GROUP_COMLINK_MAKE_LINKSHELLID>(LinkshellId))
    {
        case GP_CLI_COMMAND_GROUP_COMLINK_MAKE_LINKSHELLID::Linkshell1:
            PItemLinkshell = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK1));
            break;
        case GP_CLI_COMMAND_GROUP_COMLINK_MAKE_LINKSHELLID::Linkshell2:
            PItemLinkshell = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK2));
            break;
    }

    if (!PItemLinkshell)
    {
        return;
    }

    // Make a new Linkpearl
    auto* PItemLinkPearl = static_cast<CItemLinkshell*>(itemutils::GetItem(ITEMID::LINKPEARL));
    if (PItemLinkPearl)
    {
        PItemLinkPearl->setQuantity(1);
        std::memcpy(PItemLinkPearl->m_extra, PItemLinkshell->m_extra, 24);
        PItemLinkPearl->SetLSType(LSTYPE_LINKPEARL);
        charutils::AddItem(PChar, LOC_INVENTORY, PItemLinkPearl);
    }
}
