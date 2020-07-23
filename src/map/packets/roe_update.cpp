/*
===========================================================================

  Copyright (c) 2020 - Kreidos | github.com/kreidos

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

#include "../../common/socket.h"

#include "roe_update.h"

#include "../entities/charentity.h"

CRoeUpdatePacket::CRoeUpdatePacket(CCharEntity* PChar)
{
	this->id(0x111);
	this->length(0x104);

	/*  Each 4-bit nibble in the 4-byte chunk is labeled here. The second number is it's position.
	            (0 is the lowest order. IE the right-most bits)
	            A1A0 B0A2 B2B1 B4B3  ||  A = Record ID B = Progress                                 */

	for(uint32 i = 0; i < 31; i++)
	{
	    uint32 id = PChar->m_eminenceLog.active[i];
	    uint32 progress = PChar->m_eminenceLog.progress[i];
	    int c_offset = i < 30 ? i * 0x04 : 0xFC;  // The time-limited record is a special case, it goes at the end (0x100).
	    ref<uint32>(0x04 + c_offset) = ((progress & 0xFFFFF) << 12) + (id & 0xFFF);
	}

}
