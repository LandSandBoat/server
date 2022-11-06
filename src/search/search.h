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

#include "common/cbasetypes.h"

struct search_req
{
    uint16      zoneid[15];
    uint8       jobid;
    uint8       minlvl;
    uint8       maxlvl;
    uint8       race;
    uint8       nation;
    uint8       minRank;
    uint8       maxRank;
    uint32      flags;
    std::string name;
    uint8       nameLen;
    uint8       commentType;
};
