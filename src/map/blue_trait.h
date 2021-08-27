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

#ifndef _CBLUETRAIT_H
#define _CBLUETRAIT_H

#include "trait.h"

class CBlueTrait : public CTrait
{
public:
    CBlueTrait(uint8 category, uint8 id);

    void setPoints(uint8 points);

    uint8 getCategory() const;
    uint8 getPoints() const;

private:
    uint8 m_points;
    uint8 m_category;
};

#endif
