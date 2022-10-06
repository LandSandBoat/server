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

#include "modifier.h"

CModifier::CModifier(Mod type, int16 amount)
: m_id(type)
, m_amount(amount)
{
}

Mod CModifier::getModID() const
{
    return m_id;
}

int16 CModifier::getModAmount() const
{
    return m_amount;
}

void CModifier::setModAmount(int16 amount)
{
    m_amount = amount;
}

CPetModifier::CPetModifier(Mod type, PetModType pettype, int16 amount)
: CModifier(type, amount)
, m_pettype(pettype)
{
}

PetModType CPetModifier::getPetModType() const
{
    return m_pettype;
}
