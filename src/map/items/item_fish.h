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

#ifndef _CITEMFISH_H
#define _CITEMFISH_H

#include "common/cbasetypes.h"

#include "item.h"

/************************************************************************
 *                                                                       *
 *  Fishing items.                                                       *
 *                                                                       *
 ************************************************************************/

class CItemFish : public CItem
{
public:
    CItemFish(const CItem& PItem);

    uint8  GetMin();
    uint8  GetMax();
    uint8  GetWatertype();
    uint8  GetSize();
    uint8  GetStamina();
    uint8  GetRodFlag();
    uint16 GetLength();
    uint16 GetWeight();
    bool   IsRanked();

    void SetMin(uint8);
    void SetMax(uint8);
    void SetWatertype(uint8);
    void SetSize(uint8);
    void SetStamina(uint8);
    void SetRodFlag(uint8);
    void SetLength(uint16);
    void SetWeight(uint16);
    void SetRank(bool);

    virtual ~CItemFish();

private:
    uint8 m_min;
    uint8 m_max;
    uint8 m_watertype;
    uint8 m_size;
    uint8 m_stamina;
    uint8 m_rodflag;
};

#endif
