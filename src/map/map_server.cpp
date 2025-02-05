/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#pragma once

struct map_session_data_t
{
    uint32       client_addr        = 0;
    uint16       client_port        = 0;
    uint16       client_packet_id   = 0;       // id of the last packet that came from the client
    uint16       server_packet_id   = 0;       // id of the last packet sent by the server
    int8*        server_packet_data = nullptr; // a pointer to the packet, which was previously sent to the client
    size_t       server_packet_size = 0;       // the size of the packet that was previously sent to the client
    time_t       last_update        = 0;       // time of last packet recv
    blowfish_t   blowfish           = {};      // unique decypher keys, these are the currently expected keys
    CCharEntity* PChar              = nullptr; // game char
    uint8        shuttingDown       = 0;       // prevents double session closing
    uint32       charID             = 0;

    // Store old blowfish data, when a player recieves 0x00B their key should increment
    // If it doesn't, and we can still successfully decrypt here, that means we need to resend 0x00B.
    blowfish_t prev_blowfish = {};

    // Used to resend 0x00B zoneout packet in case the client needs it
    uint8  zone_type = 0;
    uint32 zone_ipp  = 0;

    void incrementBlowfish()
    {
        prev_blowfish = blowfish;

        blowfish.key[4] += 2;

        initBlowfish();
    }

    void initBlowfish()
    {
        md5((uint8*)(blowfish.key), blowfish.hash, 20);

        for (uint32 i = 0; i < 16; ++i)
        {
            if (blowfish.hash[i] == 0)
            {
                std::memset(blowfish.hash + i, 0, 16 - i);
                break;
            }
        }
        blowfish_init((int8*)blowfish.hash, 16, blowfish.P, blowfish.S[0]);
    }
};

typedef std::map<uint64, map_session_data_t*> map_session_list_t;
extern map_session_list_t                     map_session_list;

extern inline map_session_data_t* mapsession_getbyipp(uint64 ipp);
extern inline map_session_data_t* mapsession_createsession(uint32 ip, uint16 port);

int32 map_close_session(time_point tick, map_session_data_t* map_session_data);
