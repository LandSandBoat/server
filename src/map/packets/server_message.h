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

#ifndef _CSERVERMESSAGEPACKET_H
#define _CSERVERMESSAGEPACKET_H

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include "basic.h"

class CServerMessagePacket : public CBasicPacket
{
public:
    CServerMessagePacket(const std::string& message, int8 language, int32 timestamp, int32 message_offset);
};

#endif
