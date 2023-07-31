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

#ifndef _CSEARCHLISTPACKET_H_
#define _CSEARCHLISTPACKET_H_

#include "common/cbasetypes.h"

enum SEARCHTYPE
{
    SEARCH_NAME          = 0x00, // 00000
    SEARCH_AREA          = 0x01, // 00001
    SEARCH_NATION        = 0x02, // 00010
    SEARCH_JOB           = 0x03, // 00011
    SEARCH_LEVEL         = 0x04, // 00100
    SEARCH_RACE          = 0x05, // 00101
    SEARCH_FLAGS1        = 0x06, // 00110
    SEARCH_ID            = 0x08, // 01000
    SEARCH_PARTY         = 0x0A, // 01010
    SEARCH_LINKSHELL     = 0x0B, // 01011
    SEARCH_FRIEND        = 0x0C, // 01100
    SEARCH_LINKSHELLRANK = 0x0D, // 01101
    SEARCH_UNK0x0E       = 0x0E, // 01110
    SEARCH_RANK          = 0x10, // 10000
    SEARCH_COMMENT       = 0x11, // 10001
    SEARCH_LINKSHELL2    = 0x13, // 10011
    SEARCH_FLAGS2        = 0x16, // 10110
    SEARCH_LANGUAGE      = 0x17, // 10111
};

class CSearchListPacket
{
public:
    CSearchListPacket(uint32 Total);

    bool AddPlayer(SearchEntity* PPlayer);
    void SetFinal();

    uint8* GetData();
    uint16 GetSize() const;

private:
    uint32 m_offset{};
    uint8  m_data[1024]{};
};

#endif
