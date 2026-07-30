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

class CAHItemsListPacket
{
public:
    CAHItemsListPacket(uint16 offset);

    void AddItem(const AuctionHouseItem& item);
    void SetItemCount(uint16 count);

    auto GetData() -> uint8*;
    auto GetSize() const -> uint16;

private:
    uint8  m_count{};
    uint16 m_offset{};

    uint8 m_PData[256]{};
};
