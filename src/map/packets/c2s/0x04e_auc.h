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

#pragma once

#include "base.h"

struct GP_AUC_BOX
{
    uint8_t  Stat;         // PS2: Stat
    uint8_t  padding00;    // PS2: padding00
    uint8_t  ItemIndex;    // PS2: ItemIndex
    uint8_t  padding01;    // PS2: padding01
    uint8_t  Name[16];     // PS2: Name
    uint16_t ItemNo;       // PS2: ItemNo
    uint8_t  ItemQuantity; // PS2: ItemQuantity
    uint8_t  ItemCategory; // PS2: ItemCategory
    uint32_t Price;        // PS2: Price
    uint32_t MarketNo;     // PS2: MarketNo
    uint32_t LotNo;        // PS2: LotNo
    uint32_t TimeStamp;    // PS2: TimeStamp
};

struct GP_AUC_PARAM_LOT
{
    uint32_t LimitPrice;    // PS2: LimitPrice
    uint16_t ItemWorkIndex; // PS2: ItemWorkIndex
    uint16_t padding00;     // PS2: padding00
    uint32_t ItemStacks;    // PS2: ItemStacks
};

struct GP_AUC_PARAM_BID
{
    uint32_t BidPrice;   // PS2: BidPrice
    uint16_t ItemNo;     // PS2: ItemNo
    uint16_t padding00;  // PS2: dummy
    uint32_t ItemStacks; // PS2: ItemStacks
};

struct GP_AUC_PARAM_SUMMARY
{
    uint32_t Kind;   // PS2: Kind
    uint16_t ItemNo; // PS2: ItemNo
};

struct GP_AUC_PARAM_HISTORY
{
    uint32_t Range;  // PS2: Range
    uint16_t ItemNo; // PS2: ItemNo
};

struct GP_AUC_PARAM_ASKCOMMIT
{
    uint32_t Commission;    // PS2: Commission
    uint16_t ItemWorkIndex; // PS2: ItemWorkIndex
    uint16_t ItemNo;        // PS2: ItemNo
    uint32_t ItemStacks;    // PS2: ItemStacks
};

struct GP_AUC_PARAM_TRANS
{
    uint16_t Signature;      // PS2: Signature
    uint16_t TotalSize;      // PS2: TotalSize
    uint16_t Offset;         // PS2: Offset
    uint16_t Size;           // PS2: Size
    uint16_t FragmentNo;     // PS2: FragmentNo
    uint16_t TotalFragments; // PS2: TotalFragments
};

struct GP_AUC_PARAM
{
    union
    {
        GP_AUC_PARAM_LOT       LotIn;     // LotIn
        GP_AUC_PARAM_BID       Bid;       // Bid
        GP_AUC_PARAM_SUMMARY   Summary;   // Summary
        GP_AUC_PARAM_HISTORY   History;   // History
        GP_AUC_PARAM_ASKCOMMIT AskCommit; // AskCommit
        GP_AUC_PARAM_TRANS     Trans;     // Trans
    };
};

enum class GP_CLI_COMMAND_AUC_COMMAND : uint8_t
{
    Open      = 0x02, // Only in S2C responses
    AskCommit = 0x04, // Used when placing an item up for sale; before confirmation.
    Info      = 0x05, // Used when opening the 'Sales Status' window.
    WorkCheck = 0x0A, // Used when opening the auction house.
    LotIn     = 0x0B, // Used when placing an item up for sale; after confirmation.
    LotCancel = 0x0C, // Used when cancelling the sale of an item.
    LotCheck  = 0x0D, // Used when querying the status of items up for sale in the 'Sales Status' window.
    Bid       = 0x0E, // Used when bidding on an item.
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x004E
// This packet is sent by the client when interacting with the auction house system.
GP_CLI_PACKET(GP_CLI_COMMAND_AUC,
              GP_CLI_COMMAND_AUC_COMMAND Command;      // PS2: Command
              int8_t                     AucWorkIndex; // PS2: AucWorkIndex
              int8_t                     Result;       // PS2: Result
              int8_t                     ResultStatus; // PS2: ResultStatus
              GP_AUC_PARAM               Param;        // PS2: Param
              GP_AUC_BOX                 Parcel;       // PS2: Parcel
);
