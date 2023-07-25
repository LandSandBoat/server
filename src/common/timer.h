// Copyright (c) 2010-2015 Darkstar Dev Teams

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
