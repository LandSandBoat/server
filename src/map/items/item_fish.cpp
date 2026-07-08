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

#include "item_fish.h"

#include "exdata/fish.h"

CItemFish::CItemFish(const CItem& PItem)
: CItem(PItem)
{
}

CItemFish::~CItemFish() = default;

auto CItemFish::GetLength() -> uint16
{
    return this->exdata<Exdata::Fish>().Size;
}

auto CItemFish::GetWeight() -> uint16
{
    return this->exdata<Exdata::Fish>().Weight;
}

auto CItemFish::IsRanked() -> bool
{
    return this->exdata<Exdata::Fish>().IsRanked;
}

void CItemFish::SetLength(const uint16 length)
{
    this->exdata<Exdata::Fish>().Size = length;
}

void CItemFish::SetWeight(const uint16 weight)
{
    this->exdata<Exdata::Fish>().Weight = weight;
}

void CItemFish::SetRank(const bool rank)
{
    this->exdata<Exdata::Fish>().IsRanked = rank ? 1 : 0;
}
