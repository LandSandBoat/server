/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Teams

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

#ifndef _LOGIN_CONF_H
#define _LOGIN_CONF_H

#include "common/cbasetypes.h"

#include "login_session.h"

/*
    These are the functions to deal with traffic from port 51220

    This port appears to be for various POL functions like online status,
    friends list etc.
    Most importantly for us it handles interactions with loading/saving client
    settings to/from the server.

    Flags to observe this communication with Wireshark:
    tcp.port == 51220 && tcp.flags.push == 1

    NOTE: Not properly responding results in a failed login and a POL error code.
        : You will get different error codes the further you make it in the process,
        : such as: POL-5334, POL-0008, POL-2059, POL-5303, POL-5299, etc.

    Captures from retail (POL -> Character select screen), this pattern
    is repeated twice:

    C->S (length: 40)
    00 00 00 00 01 00 39 81 2e c0 f4 c4 6b 20 54 ff   ......9.....k T.
    3b f2 39 bb 4a 98 9c 7f 00 00 00 00 00 00 00 00   ;.9.J...........
    00 00 00 00 00 00 00 00                           ........

    S->C (length: 24)
    81 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
    00 00 00 00 0e 17 69 63                           ......ic

    C->S (length: 40)
    07 67 0c 2f 35 6b 07 1a 37 b8 98 5b 6b 20 54 ff   .g./5k..7..[k T.
    3b f2 39 bb 4a 98 9c 7f bc a4 70 47 79 11 13 70   ;.9.J.....pGy..p
    0c 3b e2 08 a5 63 b7 c5                           .;...c..

    C->S (length: 40)
    dd 7e 30 dc d9 77 e3 37 01 4c cb 9c a1 6e fe bd   .~0..w.7.L...n..
    17 57 ce 4e 82 ed 87 71 46 a0 06 fe 37 32 b2 a2   .W.N...qF...72..
    00 00 75 73 a2 f4 4e f3                           ..us..N.

    S->C (length: 24)
    86 63 09 2f 3d 6b 07 1a 93 8e db 91 6b 20 54 ff   .c./=k......k T.
    3b f2 39 bb 4a 98 9c 7f                           ;.9.J...

    S->C (length: 32)
    b7 95 27 98 36 8f dc b4 3a 4b 28 0d 11 ad 10 3f   ..'.6...:K(....?
    dd 7e 30 dc d9 77 e3 37 01 4c cb 9c 0e c1 84 03   .~0..w.7.L......
*/

extern int32 login_lobbyconf_fd;

int32 connect_client_lobbyconf(int32 listenfd);
int32 lobbyconf_parse(int32 fd);
int32 do_close_lobbyconf(login_session_data_t*, int32 fd);

#endif // _LOGIN_CONF_H
