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

#ifndef _LOBBY_H
#define _LOBBY_H

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include "login_session.h"

extern int32 login_lobbydata_fd;
extern int32 login_lobbyview_fd;

int32 connect_client_lobbydata(int32 listenfd);
int32 connect_client_lobbyview(int32 listenfd);

int32 lobbydata_parse(int32 fd);
int32 lobbyview_parse(int32 fd);

int32 do_close_lobbydata(login_session_data_t* loginsd, int32 fd);
int32 do_close_lobbyview(login_session_data_t*, int32 fd);

int32 lobby_createchar(login_session_data_t* loginsd, int8* buf);
int32 lobby_createchar_save(uint32 accid, uint32 charid, char_mini* createchar);

#endif
