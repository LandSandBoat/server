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

#ifndef _CITEMSHOP_H
#define _CITEMSHOP_H

#include "common/cbasetypes.h"

#include "item.h"

class CItemShop : public CItem
{
public:
    CItemShop(uint16 id);
    virtual ~CItemShop();

    uint32 getMinPrice() const;
    uint32 getMaxPrice() const;

    bool IsInMenu();
    bool IsDailyIncrease() const;

    void   setMinPrice(uint32 price);
    void   setMaxPrice(uint32 price);
    void   setDailyIncrease(uint16 quantity);
    uint16 getDailyIncrease() const;
    void   setInitialQuantity(uint16 quantity);
    uint16 getInitialQuantity() const;
    uint16 getSellPrice();

private:
    uint32 m_MinPrice;
    uint32 m_MaxPrice;

    uint16 m_DailyIncrease;
    uint16 m_InitialQuantity;
};

#endif
