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

#ifndef _CGUILDMENUPACKET_H
#define _CGUILDMENUPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

enum GUILDSTATUS
{
    GUILD_OPEN    = 0,
    GUILD_CLOSE   = 1,
    GUILD_HOLYDAY = 2
};

/************************************************************************
 *																		*
 *  																		*
 *																		*
 ************************************************************************/

class CGuildMenuPacket : public CBasicPacket
{
public:
    CGuildMenuPacket(GUILDSTATUS status, uint8 open, uint8 close, uint8 holiday);
};

#endif
