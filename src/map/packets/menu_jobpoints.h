/*
===========================================================================
  Copyright (c) 2021 Ixion Dev Teams
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

#ifndef _CMENUJOBPOINTSPACKET_H
#define _CMENUJOBPOINTSPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"
#include "job_points.h"

class CCharEntity;

class CMenuJobPointsPacket : public CBasicPacket
{
public:
    CMenuJobPointsPacket(CCharEntity* PChar);
};

#endif
