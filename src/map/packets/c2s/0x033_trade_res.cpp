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

#include "entities/charentity.h"
#include "packets/s2c/0x022_item_trade_res.h"
#include "universal_container.h"
#include "utils/charutils.h"

namespace
{

const auto cleanTradeTargets = [](CCharEntity* PChar, CCharEntity* PTarget)
{
    PChar->TradePending.clean();
    PTarget->TradePending.clean();
};

} // namespace

auto GP_CLI_COMMAND_TRADE_RES::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_TRADE_RES_KIND>(Kind)
        .mustNotEqual(PChar->TradePending.targid, 0, "No pending trade target")
        .isNotMonstrosity(PChar);
}

void GP_CLI_COMMAND_TRADE_RES::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* PTarget = static_cast<CCharEntity*>(PChar->GetEntity(PChar->TradePending.targid, TYPE_PC));

    if (!PTarget ||
        PChar->TradePending.id != PTarget->id ||
        PTarget->TradePending.id != PChar->id)
    {
        ShowWarningFmt("GP_CLI_COMMAND_TRADE_RES: Could not find trade targets.");
        return;
    }

    switch (static_cast<GP_CLI_COMMAND_TRADE_RES_KIND>(Kind))
    {
        case GP_CLI_COMMAND_TRADE_RES_KIND::Start: // request accepted
        {
            ShowDebug("GP_CLI_COMMAND_TRADE_RES: %s accepted trade request from %s", PTarget->getName(), PChar->getName());

            // If either player universal container is NOT empty, back out of the trade.
            if (!PChar->UContainer->IsContainerEmpty() || !PTarget->UContainer->IsContainerEmpty())
            {
                ShowDebug("GP_CLI_COMMAND_TRADE_RES: UContainer is not empty");
                cleanTradeTargets(PChar, PTarget);

                return;
            }

            // Must be within 6 yalms of each other to trade.
            if (distance(PChar->loc.p, PTarget->loc.p) > 6 || PChar->m_moghouseID != PTarget->m_moghouseID)
            {
                ShowDebug("GP_CLI_COMMAND_TRADE_RES: Too far to trade");
                cleanTradeTargets(PChar, PTarget);

                return;
            }

            PChar->UContainer->SetType(UCONTAINER_TRADE);
            PChar->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PTarget, static_cast<GP_ITEM_TRADE_RES_KIND>(Kind));

            PTarget->UContainer->SetType(UCONTAINER_TRADE);
            PTarget->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PChar, static_cast<GP_ITEM_TRADE_RES_KIND>(Kind));
        }
        break;
        case GP_CLI_COMMAND_TRADE_RES_KIND::Cancell: // trade cancelled
        {
            ShowDebug("GP_CLI_COMMAND_TRADE_RES: %s cancelled trade with %s", PTarget->getName(), PChar->getName());

            if (PTarget->UContainer->GetType() == UCONTAINER_TRADE)
            {
                PTarget->UContainer->Clean();
            }

            if (PChar->UContainer->GetType() == UCONTAINER_TRADE)
            {
                PChar->UContainer->Clean();
            }

            cleanTradeTargets(PChar, PTarget);
            // TODO: Verify exact sequence of packets sent here.
            PTarget->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PChar, static_cast<GP_ITEM_TRADE_RES_KIND>(Kind));
        }
        break;
        case GP_CLI_COMMAND_TRADE_RES_KIND::Make: // trade accepted
        {
            ShowDebug("GP_CLI_COMMAND_TRADE_RES: %s accepted trade with %s", PTarget->getName(), PChar->getName());

            PChar->UContainer->SetLock();
            PTarget->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PChar, static_cast<GP_ITEM_TRADE_RES_KIND>(Kind));

            if (PTarget->UContainer->IsLocked())
            {
                if (charutils::CanTrade(PChar, PTarget) && charutils::CanTrade(PTarget, PChar))
                {
                    charutils::DoTrade(PChar, PTarget);
                    PTarget->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PTarget, GP_ITEM_TRADE_RES_KIND::End);

                    charutils::DoTrade(PTarget, PChar);
                    PChar->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PChar, GP_ITEM_TRADE_RES_KIND::End);
                }
                else
                {
                    // Failed to trade
                    // Either players containers are full or illegal item trade attempted
                    ShowDebug("GP_CLI_COMMAND_TRADE_RES: %s->%s trade failed (full inventory or illegal items)", PChar->getName(), PTarget->getName());
                    PChar->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PTarget, GP_ITEM_TRADE_RES_KIND::Cancell);
                    PTarget->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PChar, GP_ITEM_TRADE_RES_KIND::Cancell);
                }

                PChar->UContainer->Clean();
                PTarget->UContainer->Clean();

                cleanTradeTargets(PChar, PTarget);
            }
        }
        break;
        case GP_CLI_COMMAND_TRADE_RES_KIND::MakeCancell:
        {
            // XiPackets claim this can be sent by the client, but unknown in what conditions.
            ShowDebug("GP_CLI_COMMAND_TRADE_RES: MakeCancell received from %s", PChar->getName());
        }
        break;
    }
}
