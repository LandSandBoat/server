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

#include "0x04b_pbx_result.h"

#include "entities/charentity.h"
#include "packets/c2s/0x04d_pbx.h"

GP_SERV_COMMAND_PBX_RESULT::GP_SERV_COMMAND_PBX_RESULT(GP_CLI_COMMAND_PBX_COMMAND action, GP_CLI_COMMAND_PBX_BOXNO boxid, const uint8 count, const uint8 param)
{
    // Only uses Represent
    auto& packet = this->data();
    this->setSize(0x14);

    packet.Command = static_cast<uint8_t>(action);
    packet.BoxNo   = static_cast<int8_t>(boxid);

    // Client relies on these being explicitly set to -1 if not used
    packet.PostWorkNo = -1;
    packet.ItemWorkNo = -1;
    packet.ItemStacks = -1;
    packet.ResParam1  = -1;
    packet.ResParam2  = -1;
    packet.ResParam3  = -1;

    if (action == GP_CLI_COMMAND_PBX_COMMAND::Check)
    {
        if (boxid == GP_CLI_COMMAND_PBX_BOXNO::Incoming)
        {
            packet.ResParam2 = count;
        }
        else
        {
            packet.ResParam3 = count;
        }
    }
    else if (action == GP_CLI_COMMAND_PBX_COMMAND::Query)
    {
        packet.ResParam1 = count;
    }

    packet.Result = param;
}

GP_SERV_COMMAND_PBX_RESULT::GP_SERV_COMMAND_PBX_RESULT(GP_CLI_COMMAND_PBX_COMMAND action, GP_CLI_COMMAND_PBX_BOXNO boxid, CItem* PItem, uint8 slotid, uint8 count, uint8 message)
{
    // Uses the full structure
    auto& packet = this->data();
    this->setSize(0x58);

    packet.Command    = static_cast<uint8_t>(action);
    packet.BoxNo      = static_cast<int8_t>(boxid);
    packet.PostWorkNo = slotid;
    packet.Result     = message; // success: 0x01, else error message
    packet.ResParam1  = count;

    // Client relies on these being explicitly set to -1 if not used
    packet.ItemWorkNo = -1;
    packet.ItemStacks = -1;
    packet.ResParam2  = -1;
    packet.ResParam3  = -1;

    if (PItem)
    {
        if ((action != GP_CLI_COMMAND_PBX_COMMAND::Get &&
             action != GP_CLI_COMMAND_PBX_COMMAND::Clear &&
             action != GP_CLI_COMMAND_PBX_COMMAND::Reject) ||
            message > 1)
        {
            if (boxid == GP_CLI_COMMAND_PBX_BOXNO::Incoming)
            {
                packet.State.Stat = 0x07;
                std::memcpy(packet.State.box_state.pbox.Recv.From, PItem->getSender().c_str(), std::min(PItem->getSender().size(), sizeof(packet.State.box_state.pbox.Recv.From))); // Sender's name.  Client disables "Return" if it starts with "AH"
            }
            else
            {
                packet.State.Stat = PItem->isSent() ? 0x03 : 0x05;                                                                                                                  // 0x05 in send: canceled. other values are unknown
                std::memcpy(packet.State.box_state.pbox.Send.To, PItem->getReceiver().c_str(), std::min(PItem->getReceiver().size(), sizeof(packet.State.box_state.pbox.Send.To))); // Receiver's name.  Client disables "Return" if it starts with "AH"
            }
        }
        if (action == GP_CLI_COMMAND_PBX_COMMAND::Set)
        {
            packet.State.Stat = 0x01;
            packet.ItemWorkNo = PItem->getSlotID();
        }
        else if (action == GP_CLI_COMMAND_PBX_COMMAND::Send)
        {
            packet.ItemWorkNo = PItem->getSlotID();
        }
        else if (action == GP_CLI_COMMAND_PBX_COMMAND::Cancel)
        {
            if (message == 0x01)
            {
                packet.State.Stat = 0x05;
            }
            else if (message == 0x02)
            {
                packet.State.Stat = 0x04;
            }
        }

        packet.State.box_state.pbox.Send.ItemWorkNo = PItem->getSubID();
        packet.State.ItemNo                         = PItem->getID();
        packet.State.Stack                          = PItem->getQuantity();
        std::memcpy(packet.State.Data, PItem->m_extra, std::min(sizeof(PItem->m_extra), sizeof(packet.State.Data)));
    }
}
