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

#include "0x04d_pbx.h"

#include "entities/charentity.h"
#include "trade_container.h"
#include "utils/dboxutils.h"
#include "utils/jailutils.h"
#include "utils/zoneutils.h"

auto GP_CLI_COMMAND_PBX::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    auto pv = PacketValidator()
                  .oneOf<GP_CLI_COMMAND_PBX_COMMAND>(Command)
                  .isNotCrafting(PChar)
                  .isNotFishing(PChar)
                  .mustEqual(jailutils::InPrison(PChar), false, "Cannot use delivery box while jailed")
                  .mustEqual(Result, 0, "Result not 0")
                  .mustEqual(ResParam1, 0, "ResParam1 not 0")
                  .mustEqual(ResParam2, 0, "ResParam2 not 0")
                  .mustEqual(ResParam3, 0, "ResParam3 not 0");

    switch (static_cast<GP_CLI_COMMAND_PBX_COMMAND>(Command))
    {
        case GP_CLI_COMMAND_PBX_COMMAND::Work:
        {
            pv
                .range("BoxNo", BoxNo, GP_CLI_COMMAND_PBX_BOXNO::Incoming, GP_CLI_COMMAND_PBX_BOXNO::Outgoing)
                .range("PostWorkNo", PostWorkNo, -1, 8)
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Set:
        {
            pv
                .mustEqual(BoxNo, GP_CLI_COMMAND_PBX_BOXNO::Outgoing, "BoxNo not Outgoing")
                .range("PostWorkNo", PostWorkNo, 0, 8)
                .range("ItemStacks", ItemStacks, 0, 999999999);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Send:
        {
            pv
                .mustEqual(BoxNo, GP_CLI_COMMAND_PBX_BOXNO::Outgoing, "BoxNo not Outgoing")
                .range("PostWorkNo", PostWorkNo, 0, 8)
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Cancel:
        {
            pv
                .mustEqual(BoxNo, GP_CLI_COMMAND_PBX_BOXNO::Outgoing, "BoxNo not Outgoing")
                .range("PostWorkNo", PostWorkNo, 0, 8)
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Check:
        {
            pv
                .range("BoxNo", BoxNo, GP_CLI_COMMAND_PBX_BOXNO::Incoming, GP_CLI_COMMAND_PBX_BOXNO::Outgoing)
                .mustEqual(PostWorkNo, -1, "PostWorkNo not -1")
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Recv:
        {
            pv
                .mustEqual(BoxNo, GP_CLI_COMMAND_PBX_BOXNO::Incoming, "BoxNo not Incoming")
                .range("PostWorkNo", PostWorkNo, 0, 8)
                .mustEqual(ItemWorkNo, 1, "ItemWorkNo not 1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Confirm:
        {
            pv
                .mustEqual(BoxNo, GP_CLI_COMMAND_PBX_BOXNO::None, "BoxNo not None")
                .mustEqual(PostWorkNo, -1, "PostWorkNo not -1")
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Accept:
        {
            pv
                .mustEqual(BoxNo, GP_CLI_COMMAND_PBX_BOXNO::Incoming, "BoxNo not Incoming")
                .range("PostWorkNo", PostWorkNo, 0, 8)
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Reject:
        {
            pv
                .mustEqual(BoxNo, GP_CLI_COMMAND_PBX_BOXNO::Incoming, "BoxNo not Incoming")
                .range("PostWorkNo", PostWorkNo, 0, 8)
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Get:
        {
            pv
                .range("BoxNo", BoxNo, GP_CLI_COMMAND_PBX_BOXNO::Incoming, GP_CLI_COMMAND_PBX_BOXNO::Outgoing)
                .range("PostWorkNo", PostWorkNo, 0, 8)
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Clear:
        {
            pv
                .range("BoxNo", BoxNo, GP_CLI_COMMAND_PBX_BOXNO::Incoming, GP_CLI_COMMAND_PBX_BOXNO::Outgoing)
                .range("PostWorkNo", PostWorkNo, 0, 8)
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Query:
        {
            pv
                .mustEqual(BoxNo, GP_CLI_COMMAND_PBX_BOXNO::None, "BoxNo not None")
                .mustEqual(PostWorkNo, -1, "PostWorkNo not -1")
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::DeliOpen:
        {
            pv
                .mustEqual(BoxNo, GP_CLI_COMMAND_PBX_BOXNO::None, "BoxNo not None")
                .mustEqual(PostWorkNo, -1, "PostWorkNo not -1")
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::PostOpen:
        {
            pv
                .mustEqual(BoxNo, GP_CLI_COMMAND_PBX_BOXNO::None, "BoxNo not None")
                .mustEqual(PostWorkNo, -1, "PostWorkNo not -1")
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::PostClose:
        {
            pv
                .mustEqual(BoxNo, GP_CLI_COMMAND_PBX_BOXNO::None, "BoxNo not None")
                .mustEqual(PostWorkNo, -1, "PostWorkNo not -1")
                .mustEqual(ItemWorkNo, -1, "ItemWorkNo not -1")
                .mustEqual(ItemStacks, -1, "ItemStacks not -1");
        }
        break;
    }

    return pv;
}

void GP_CLI_COMMAND_PBX::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto charName = PChar->getName();

    if (!zoneutils::IsResidentialArea(PChar) && PChar->m_GMlevel == 0 && !PChar->loc.zone->CanUseMisc(MISC_AH) && !PChar->loc.zone->CanUseMisc(MISC_MOGMENU))
    {
        ShowWarningFmt("DBOX: {} ({}) is trying to use the delivery box in a disallowed zone [{}]", charName, PChar->id, PChar->loc.zone->getName());
        return;
    }

    switch (static_cast<GP_CLI_COMMAND_PBX_COMMAND>(Command))
    {
        case GP_CLI_COMMAND_PBX_COMMAND::Work:
        {
            dboxutils::SendOldItems(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo));
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Set:
        {
            const auto receiverName = db::escapeString(asStringFromUntrustedSource(TargetName, 15));

            dboxutils::AddItemsToBeSent(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo), PostWorkNo, ItemWorkNo, ItemStacks, receiverName);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Send:
        {
            dboxutils::SendConfirmation(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo), PostWorkNo);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Cancel:
        {
            dboxutils::CancelSendingItem(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo), PostWorkNo);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Check:
        {
            dboxutils::SendClientNewItemCount(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo), PostWorkNo);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Recv:
        {
            dboxutils::SendNewItems(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo), PostWorkNo);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Confirm:
        {
            dboxutils::RemoveDeliveredItemFromSendingBox(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo), PostWorkNo);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Accept:
        {
            dboxutils::UpdateDeliveryCellBeforeRemoving(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo), PostWorkNo);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Reject:
        {
            dboxutils::ReturnToSender(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo), PostWorkNo);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Get:
        {
            dboxutils::TakeItemFromCell(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo), PostWorkNo);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Clear:
        {
            dboxutils::RemoveItemFromCell(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo), PostWorkNo);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::Query:
        {
            const auto receiverName = db::escapeString(asStringFromUntrustedSource(TargetName, 15));

            dboxutils::ConfirmNameBeforeSending(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo), receiverName);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::DeliOpen:
        {
            dboxutils::OpenSendBox(PChar);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::PostOpen:
        {
            dboxutils::OpenRecvBox(PChar);
        }
        break;
        case GP_CLI_COMMAND_PBX_COMMAND::PostClose:
        {
            dboxutils::CloseMailWindow(PChar, static_cast<GP_CLI_COMMAND_PBX_BOXNO>(BoxNo));
        }
        break;
    }
}
