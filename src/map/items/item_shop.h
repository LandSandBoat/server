/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "item.h"

class CItemShop : public CItem
{
public:
    CItemShop(uint16);

    CItemShop(const CItemShop& other);
    virtual ~CItemShop();

    auto getMinPrice() const -> uint32;
    auto getMaxPrice() const -> uint32;

    auto IsInMenu() -> bool;
    auto IsDailyIncrease() const -> bool;

    void setMinPrice(uint32 price);
    void setMaxPrice(uint32 price);
    void setDailyIncrease(uint16 quantity);
    auto getDailyIncrease() const -> uint16;
    void setInitialQuantity(uint16 quantity);
    auto getInitialQuantity() const -> uint16;
    auto getSellPrice() -> uint16;

private:
    uint32 m_MinPrice;
    uint32 m_MaxPrice;

    uint16 m_DailyIncrease;
    uint16 m_InitialQuantity;
};
