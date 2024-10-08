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

#ifndef _ZLIB_H
#define _ZLIB_H

#include "common/cbasetypes.h"

static inline size_t zlib_compressed_size(const size_t sz)
{
    return (sz + 7) / 8;
}

int32 zlib_init();
int32 zlib_compress(const int8* in, const uint32 in_sz, int8* out, const uint32 out_sz);
int32 zlib_decompress(const int8* in, const uint32 in_sz, int8* out, const uint32 out_sz);

#endif // _ZLIB_H
