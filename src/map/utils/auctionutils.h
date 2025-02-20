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

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include "packets/basic.h"

class CCharEntity;

namespace auctionutils
{
    void HandlePacket(CCharEntity* PChar, CBasicPacket& data);

    void SellingItems(CCharEntity* PChar, uint8 action, uint32 price, uint8 slot, uint16 itemid, uint8 quantity);
    void OpenListOfSales(CCharEntity* PChar, uint8 action, uint16 itemid);
    void RetrieveListOfItemsSoldByPlayer(CCharEntity* PChar);
    void ProofOfPurchase(CCharEntity* PChar, uint8 action, uint32 price, uint8 slot, uint8 quantity);
    void PurchasingItems(CCharEntity* PChar, uint8 action, uint32 price, uint16 itemid, uint8 quantity);
    void CancelSale(CCharEntity* PChar, uint8 action, uint8 slotid);
    void UpdateSaleListByPlayer(CCharEntity* PChar, uint8 action, uint8 slotid);
}; // namespace auctionutils
