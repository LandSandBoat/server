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

#ifndef _CLINKSHELLMESSAGEPACKET_H
#define _CLINKSHELLMESSAGEPACKET_H

#include "common/cbasetypes.h"

#include "linkshell.h"

#include "basic.h"

class CLinkshellMessagePacket : public CBasicPacket
{
public:
    static const uint16 id{ 0xCC };
    CLinkshellMessagePacket(const std::string& poster, const std::string& message, const std::string& lsname, uint32 posttime, bool ls1);
};

#endif
