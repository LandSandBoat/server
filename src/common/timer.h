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

#ifndef _TIMER_H
#define _TIMER_H

#include "common/cbasetypes.h"

#define DIFF_TICK(a, b) ((uint32)((a) - (b)))

uint32 gettick(void);
uint32 gettick_nocache(void);

time_point get_server_start_time(void);

void timer_init(void);
void timer_final(void);

uint32 getCurrentTimeMs();

#endif
