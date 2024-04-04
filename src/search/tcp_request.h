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

#ifndef _CTCPREQUESTPACKET_H_
#define _CTCPREQUESTPACKET_H_

#include "common/cbasetypes.h"
#include "common/mmo.h"

#ifdef WIN32
#include <winsock2.h>
#else
#include <errno.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/types.h>
typedef u_int SOCKET;
#endif

enum TCPREQUESTTYPE
{
    TCP_SEARCH_ALL       = 0x00,
    TCP_GROUP_LIST       = 0x02,
    TCP_SEARCH           = 0x03,
    TCP_AH_HISTORY_SINGL = 0x05,
    TCP_AH_HISTORY_STACK = 0x06,
    TCP_SEARCH_COMMENT   = 0x08,
    TCP_AH_REQUEST_MORE  = 0x10,
    TCP_AH_REQUEST       = 0x15,
};

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

class CTCPRequestPacket
{
public:
    CTCPRequestPacket(SOCKET* socket);
    ~CTCPRequestPacket();

    uint8* getData();
    int32  getSize() const;
    uint8  getPacketType();

    bool receiveFromSocket();

    int32 sendToSocket(uint8* data, uint32 length);
    int32 sendRawToSocket(uint8* data, uint32 length);

private:
    uint8*  m_data;
    int32   m_size;
    SOCKET* m_socket;

    blowfish_t blowfish;

    int8 key[24]{};

    bool decipher();
    bool packetHashIsValid();
};

#endif
