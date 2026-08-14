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

#include "0x033_trade_res.h"

#include "entities/char_entity.h"
#include "items/transactions/player_trade.h"
#include "packets/s2c/0x022_item_trade_res.h"

auto GP_CLI_COMMAND_TRADE_RES::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent, BlockedState::Monstrosity })
        .oneOf<GP_CLI_COMMAND_TRADE_RES_KIND>(this->Kind)
        .mustNotEqual(PChar->TradePending.ActIndex, 0, "No pending trade target");
}

void GP_CLI_COMMAND_TRADE_RES::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* PTarget = PChar->tradePartner();
    if (!PTarget)
    {
        ShowWarningFmt("GP_CLI_COMMAND_TRADE_RES: Could not find trade targets.");
        return;
    }

    switch (static_cast<GP_CLI_COMMAND_TRADE_RES_KIND>(this->Kind))
    {
        case GP_CLI_COMMAND_TRADE_RES_KIND::Start:
        {
            if (PChar->activePlayerTradeTransaction())
            {
                // Trade is already active
                return;
            }

            if (!PlayerTradeTransaction::start(PChar, PTarget))
            {
                ShowInfoFmt("GP_CLI_COMMAND_TRADE_RES: Start refused ({} -> {})", PChar->getName(), PTarget->getName());
                PChar->TradePending.clean();
                PTarget->TradePending.clean();
                return;
            }

            PChar->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PTarget, GP_ITEM_TRADE_RES_KIND::Start);
            PTarget->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PChar, GP_ITEM_TRADE_RES_KIND::Start);
        }
        break;
        case GP_CLI_COMMAND_TRADE_RES_KIND::Cancell:
        {
            PlayerTradeTransaction::cancel(PChar);
        }
        break;
        case GP_CLI_COMMAND_TRADE_RES_KIND::Make:
        {
            // Notify the other side we're done trading
            PTarget->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PChar, GP_ITEM_TRADE_RES_KIND::Make);
            if (auto* transaction = PChar->activePlayerTradeTransaction(); transaction && transaction->accept(PChar))
            {
                // If both sides accepted, perform swaps and close the transaction.
                transaction->commitAndClose();
            }
        }
        break;
        case GP_CLI_COMMAND_TRADE_RES_KIND::MakeCancell:
        {
            // XiPackets claim this can be sent by the client, but unknown in what conditions.
            ShowDebugFmt("GP_CLI_COMMAND_TRADE_RES: MakeCancell received from {}", PChar->getName());
        }
        break;
    }
}
