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

#ifndef _MD52_H
#define _MD52_H

#include "common/cbasetypes.h"

typedef struct
{
    uint32 total[2];
    uint32 state[4];
    uint8  buffer[64];
} md5_context;

void md5(uint8* text, uint8* hash, int32 size);
void md5_starts(md5_context* ctx);
void md5_update(md5_context* ctx, uint8* input, uint32 length);
void md5_finish(md5_context* ctx, uint8 digest[16]);

#endif // _MD52_H
