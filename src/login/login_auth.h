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

#ifndef _LOGIN_AUTH_H
#define _LOGIN_AUTH_H

#include "../common/cbasetypes.h"

#include "login_session.h"

/*==========================================
 * Login-Server data parse
 *-------------------------------------------*/
/*main events*/
#define LOGIN_ATTEMPT         0x10
#define LOGIN_CREATE          0x20
#define LOGIN_CHANGE_PASSWORD 0x30

/*return result*/
#define LOGIN_SUCCESS                 0x01
#define LOGIN_SUCCESS_CREATE          0x03
#define LOGIN_SUCCESS_CHANGE_PASSWORD 0x06

#define LOGIN_REQUEST_NEW_PASSWORD 0x05

#define LOGIN_ERROR                 0x02
#define LOGIN_ERROR_CREATE          0x09
#define LOGIN_ERROR_CREATE_TAKEN    0x04
#define LOGIN_ERROR_CREATE_DISABLED 0x08
#define LOGIN_ERROR_CHANGE_PASSWORD 0x07

extern int32 login_fd;
/*
 *
 *   Parse connections for authentification
 */
int32 connect_client_login(int32 listenfd);

int32 login_parse(int32 fd);

bool check_string(std::string const& str, std::size_t max_length);

/*=============================================
 * login data close socket
 *-------------------------------------------*/
int32 do_close_login(login_session_data_t* loginsd, int32 fd);
#endif
