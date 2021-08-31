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

#ifndef _CSTOPDOWNLOADINGPACKET_H
#define _CSTOPDOWNLOADINGPACKET_H

#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"
#include "basic.h"
#include <vector>

/************************************************************************
 *																		*
 *  																		*
 *																		*
 ************************************************************************/

class CCharEntity;

class CStopDownloadingPacket : public CBasicPacket
{
public:
    CStopDownloadingPacket(CCharEntity* PChar, std::vector<std::pair<uint32, string_t>> blacklist);
};

#endif
