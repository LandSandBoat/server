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

#include "item_shop.h"

CItemShop::CItemShop(uint16 id)
: CItem(id)
{
    m_MinPrice = 0;
    m_MaxPrice = 0;

    m_DailyIncrease   = 0;
    m_InitialQuantity = 0;
}

CItemShop::~CItemShop() = default;

uint32 CItemShop::getMinPrice() const
{
    return m_MinPrice;
}

uint32 CItemShop::getMaxPrice() const
{
    return m_MaxPrice;
}

bool CItemShop::IsInMenu()
{
    return getQuantity() != 0;
}

bool CItemShop::IsDailyIncrease() const
{
    return m_DailyIncrease != 0;
}

void CItemShop::setMinPrice(uint32 price)
{
    m_MinPrice = price;
}

void CItemShop::setMaxPrice(uint32 price)
{
    m_MaxPrice = price;
}

void CItemShop::setDailyIncrease(uint16 increase)
{
    m_DailyIncrease = increase;
}

uint16 CItemShop::getDailyIncrease() const
{
    return m_DailyIncrease;
}

void CItemShop::setInitialQuantity(uint16 increase)
{
    m_InitialQuantity = increase;
}

uint16 CItemShop::getInitialQuantity() const
{
    return m_InitialQuantity;
}

uint16 CItemShop::getSellPrice()
{
    if (getID() >= 0x2800 && getID() <= 0x6FFF)
    {
        return (uint16)((getMinPrice() + (getQuantity() / getStackSize()) * (getMinPrice() * 0.10f)) / 12);
    }
    else
    {
        return getBasePrice() / 3;
    }
}
