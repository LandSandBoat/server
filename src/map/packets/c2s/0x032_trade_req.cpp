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

#include "0x032_trade_req.h"

#include "entities/char_entity.h"
#include "enums/msg_std.h"
#include "items/transactions/player_trade.h"
#include "packets/s2c/0x021_item_trade_req.h"
#include "packets/s2c/0x022_item_trade_res.h"
#include "packets/s2c/0x053_systemmes.h"
#include "utils/charutils.h"
#include "utils/jailutils.h"

auto GP_CLI_COMMAND_TRADE_REQ::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent, BlockedState::Monstrosity })
        .mustNotEqual(PChar->id, this->UniqueNo, "Character trading with itself");
}

void GP_CLI_COMMAND_TRADE_REQ::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* PTarget = static_cast<CCharEntity*>(PChar->GetEntity(this->ActIndex, TYPE_PC));
    if (!PTarget || PTarget->id != this->UniqueNo)
    {
        return;
    }

    ShowDebugFmt("{} initiated trade request with {}", PChar->getName(), PTarget->getName());

    const auto refuse = [&](std::string_view reason)
    {
        ShowInfoFmt("{} -> {} trade refused: {}", PChar->getName(), PTarget->getName(), reason);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PTarget, GP_ITEM_TRADE_RES_KIND::ErrYouTrade);
    };

    if (jailutils::InPrison(PChar) || jailutils::InPrison(PTarget))
    {
        refuse("in prison");
        return;
    }

    if (charutils::IsAidBlocked(PChar, PTarget))
    {
        PChar->pushPacket<GP_SERV_COMMAND_SYSTEMMES>(0, 0, MsgStd::TargetIsCurrentlyBlocking);
        PTarget->pushPacket<GP_SERV_COMMAND_SYSTEMMES>(0, 0, MsgStd::BlockedByBlockaid);
        refuse("blockaid");
        return;
    }

    if (PChar->activePlayerTradeTransaction())
    {
        refuse("already in a trade");
        return;
    }

    if (PTarget->TradePending.entity.UniqueNo == PChar->id)
    {
        ShowDebugFmt("{} has already sent a trade request to {}", PChar->getName(), PTarget->getName());
        return;
    }

    if (PTarget->activePlayerTradeTransaction())
    {
        refuse("target already in a trade");
        return;
    }

    const timer::time_point currentTime           = timer::now();
    const auto              lastTargetTrade       = currentTime - PTarget->TradePending.invitedAt;
    const bool              targetHasRecentInvite = PTarget->TradePending.entity.ActIndex != 0 && lastTargetTrade < 60s;

    if (targetHasRecentInvite)
    {
        refuse("target has a recent unanswered invite");
        return;
    }

    // This block usually doesn't trigger,
    // The client is generally forced to send a trade cancel packet via a cancel yes/no menu,
    // resulting in an outgoing 0x033 with 0x04 set to 0x01 for their old trade target, but sometimes the menu does not happen and a cancel is sent instead.
    if (auto* POldTradeTarget = PChar->tradePartner())
    {
        POldTradeTarget->TradePending.clean();
        PChar->TradePending.clean();
        POldTradeTarget->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PChar, GP_ITEM_TRADE_RES_KIND::ErrYouTrade);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(POldTradeTarget, GP_ITEM_TRADE_RES_KIND::ErrYouTrade);
        return;
    }

    PChar->TradePending   = { .entity = EntityId(PTarget), .invitedAt = currentTime, .initiator = true };
    PTarget->TradePending = { .entity = EntityId(PChar), .invitedAt = currentTime, .initiator = false };
    PTarget->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_REQ>(PChar);
}
