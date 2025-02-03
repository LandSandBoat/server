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

#include "common/timer.h"
#include "common/logging.h"
#include "common/utils.h"

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>

#ifdef WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h> // GetTickCount()
#else
#include <sys/time.h> // struct timeval, gettimeofday()
#include <unistd.h>
#endif

// server startup time
time_point start_time;

/*----------------------------
 *  Get tick time
 *----------------------------*/

#if defined(ENABLE_RDTSC)
static uint64 RDTSC_BEGINTICK = 0, RDTSC_CLOCK = 0;

static __inline uint64 _rdtsc()
{
    // clang-format off
    register union
    {
        uint64 qw;
        uint32 dw[2];
    } t;

    asm volatile("rdtsc" : "=a"(t.dw[0]), "=d"(t.dw[1]));
    // clang-format on

    return t.qw;
}

static void rdtsc_calibrate()
{
    uint64 t1, t2;
    int32  i;

    ShowInfo("Calibrating Timer Source, please wait... ");

    RDTSC_CLOCK = 0;

    for (i = 0; i < 5; i++)
    {
        t1 = _rdtsc();
        usleep(1000000); // 1000 MS
        t2 = _rdtsc();
        RDTSC_CLOCK += (t2 - t1) / 1000;
    }
    RDTSC_CLOCK /= 5;

    RDTSC_BEGINTICK = _rdtsc();

    ShowInfo(" done. (Frequency: %u Mhz)", (uint32)(RDTSC_CLOCK / 1000));
}
#endif

/// platform-abstracted tick retrieval
static uint32 tick()
{
#if defined(WIN32)
    return GetTickCount();
#elif defined(ENABLE_RDTSC)
    //
    return (uint32)((_rdtsc() - RDTSC_BEGINTICK) / RDTSC_CLOCK);
    //
#elif (defined(_POSIX_TIMERS) && _POSIX_TIMERS > 0 && defined(_POSIX_MONOTONIC_CLOCK) /* posix compliant */) || \
    (defined(__FreeBSD_cc_version) && __FreeBSD_cc_version >= 500005 /* FreeBSD >= 5.1.0 */)
    timespec tval{};
    clock_gettime(CLOCK_MONOTONIC, &tval);
    return tval.tv_sec * 1000 + tval.tv_nsec / 1000000;
#else
    timeval tval{};
    gettimeofday(&tval, nullptr);
    return tval.tv_sec * 1000 + tval.tv_usec / 1000;
#endif
}

//////////////////////////////////////////////////////////////////////////
#if defined(TICK_CACHE) && TICK_CACHE > 1
//////////////////////////////////////////////////////////////////////////
// tick is cached for TICK_CACHE calls
static uint32 gettick_cache;
static int32  gettick_count = 1;

unsigned int gettick_nocache(void)
{
    gettick_count = TICK_CACHE;
    gettick_cache = tick();
    return gettick_cache;
}

unsigned int gettick(void)
{
    return (--gettick_count == 0) ? gettick_nocache() : gettick_cache;
}
//////////////////////////////
#else
//////////////////////////////
// tick doesn't get cached
uint32 gettick_nocache()
{
    return tick() + 100000000; // +27 hours for respawn
}

uint32 gettick()
{
    return tick() + 100000000; // +27 hours for respawn
}
//////////////////////////////////////////////////////////////////////////
#endif
/////////////////////////////////////////////////////////////////////////

duration get_uptime()
{
    return server_clock::now() - start_time;
}

void timer_init()
{
#if defined(ENABLE_RDTSC)
    rdtsc_calibrate();
#endif
    start_time = server_clock::now();
}

void timer_final()
{
}

time_point get_server_start_time()
{
    return start_time;
}

uint32 getCurrentTimeMs()
{
    return std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count() % 1000;
}
