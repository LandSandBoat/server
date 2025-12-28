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

#include "0x04e_auc.h"

#include "entities/charentity.h"
#include "utils/auctionutils.h"
#include "utils/jailutils.h"

auto GP_CLI_COMMAND_AUC::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    auto pv = PacketValidator()
                  .hasZoneMiscFlag(PChar, MISC_AH)
                  .mustEqual(jailutils::InPrison(PChar), false, "Character in jail")
                  .oneOf<GP_CLI_COMMAND_AUC_COMMAND>(Command)
                  .mustEqual(Result, 0, "Result not 0")
                  .mustEqual(ResultStatus, 0, "Result status");

    switch (Command)
    {
        case GP_CLI_COMMAND_AUC_COMMAND::AskCommit:
        {
            pv
                .range("Commission", Param.AskCommit.Commission, 1, 999999999)
                .range("ItemStacks", Param.AskCommit.ItemStacks, 0, 1);
        }
        break;
        case GP_CLI_COMMAND_AUC_COMMAND::Info:
        {
            // No specific parameter to validate for Info command
        }
        break;
        case GP_CLI_COMMAND_AUC_COMMAND::WorkCheck:
        {
            pv.mustEqual(AucWorkIndex, -1, "AucWorkIndex not -1");
        }
        break;
        case GP_CLI_COMMAND_AUC_COMMAND::LotIn:
        {
            pv
                .range("AucWorkIndex", AucWorkIndex, 0, 6)
                .range("LimitPrice", Param.LotIn.LimitPrice, 1, 999999999)
                .range("ItemStacks", Param.LotIn.ItemStacks, 0, 1);
        }
        break;
        case GP_CLI_COMMAND_AUC_COMMAND::Bid:
        {
            pv
                .range("AucWorkIndex", AucWorkIndex, 0, 6)
                .range("BidPrice", Param.Bid.BidPrice, 1, 999999999)
                .range("ItemStacks", Param.Bid.ItemStacks, 0, 1);
        }
        break;
        case GP_CLI_COMMAND_AUC_COMMAND::LotCancel:
        {
            pv.range("AucWorkIndex", AucWorkIndex, 0, 6);
        }
        break;
        case GP_CLI_COMMAND_AUC_COMMAND::LotCheck:
        {
            pv.range("AucWorkIndex", AucWorkIndex, 0, 6);
        }
        break;
        default:
            break;
    }

    return pv;
}

void GP_CLI_COMMAND_AUC::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto playerName = PChar->getName();

    switch (Command)
    {
        case GP_CLI_COMMAND_AUC_COMMAND::AskCommit:
        {
            auctionutils::SellingItems(PChar, Param.AskCommit);
        }
        break;
        case GP_CLI_COMMAND_AUC_COMMAND::Info:
        {
            auctionutils::OpenListOfSales(PChar);
            [[fallthrough]];
        }
        // FALLTHROUGH!
        case GP_CLI_COMMAND_AUC_COMMAND::WorkCheck:
        {
            auctionutils::RetrieveListOfItemsSoldByPlayer(PChar);
        }
        break;
        case GP_CLI_COMMAND_AUC_COMMAND::LotIn:
        {
            auctionutils::ProofOfPurchase(PChar, Param.LotIn);
        }
        break;
        case GP_CLI_COMMAND_AUC_COMMAND::Bid:
        {
            auctionutils::PurchasingItems(PChar, Param.Bid);
        }
        break;
        case GP_CLI_COMMAND_AUC_COMMAND::LotCancel:
        {
            auctionutils::CancelSale(PChar, AucWorkIndex);
        }
        break;
        case GP_CLI_COMMAND_AUC_COMMAND::LotCheck:
        {
            auctionutils::UpdateSaleListByPlayer(PChar, AucWorkIndex);
        }
        break;
        default:
            break;
    }
}
