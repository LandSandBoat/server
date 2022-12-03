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

#ifndef _KERNEL_H_
#define _KERNEL_H_

#include "cbasetypes.h"
#include "console_service.h"
#include "settings.h"

extern std::atomic<bool> gRunFlag;

extern void  log_init(int, char**);
extern int32 do_init(int32, char**);
extern void  set_socket_type(void);
extern void  do_abort(void);
extern void  do_final(int);

extern std::unique_ptr<ConsoleService> gConsoleService;

#endif // _KERNEL_H_
