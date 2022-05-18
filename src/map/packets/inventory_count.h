/*
===========================================================================

  Copyright (c) 2021 LandSandBoat Dev Team

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

#ifndef _CINVENTORYCOUNTPACKET_H
#define _CINVENTORYCOUNTPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"

class CCharEntity;

class CInventoryCountPacket : public CBasicPacket
{
public:
    CInventoryCountPacket(uint8 locationId, uint8 slotId);

    // For Mannequin updates
    CInventoryCountPacket(uint8 locationId, uint8 slotId, uint16 headId, uint16 bodyId, uint16 handsId, uint16 legId, uint16 feetId, uint16 mainId, uint16 subId, uint16 rangeId);
};

#endif // _CINVENTORYCOUNTPACKET_H
