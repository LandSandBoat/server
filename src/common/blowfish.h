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

#ifndef _BLOWFISH_H
#define _BLOWFISH_H

#include "common/cbasetypes.h"

enum BLOWFISH
{
    BLOWFISH_WAITING,
    BLOWFISH_SENT,
    BLOWFISH_ACCEPTED,
};

struct blowfish_t
{
    uint32   key[5]    = {};
    uint8    hash[16]  = {};
    uint32   P[18]     = {};
    uint32   S[4][256] = {};
    BLOWFISH status    = BLOWFISH_WAITING;
};

void blowfish_decipher(uint32* xl, uint32* xr, const uint32* P, uint32* S);
void blowfish_encipher(uint32* xl, uint32* xr, const uint32* P, uint32* S);

uint32* blowfish_init(const int8 key[], int16 keybytes, uint32* P, uint32* S);

#endif
