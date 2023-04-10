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
#include "login_session.h"
#include "../common/logging.h"
#include "../common/socket.h"

login_sd_list_t login_sd_list;

login_session_data_t* find_loginsd_byaccid(uint32 accid)
{
    for (auto& i : login_sd_list)
    {
        if (i->accid == accid)
        {
            return i;
        }
    }
    return nullptr;
}

login_session_data_t* find_loginsd_byip(uint32 ip)
{
    //////// 19/03/2012 Fix for 1 IP -> Many Accounts
    // Simply increases "serviced" by 1 every time a login is returned via an IP address.
    // The result is the illusion of independancy (though really it's not!)
    unsigned int minserv           = 1000;
    int          multiple_ip_count = 0;
    for (auto& i : login_sd_list)
    {
        if (i->client_addr == ip)
        {
            multiple_ip_count++;
            if (i->serviced < minserv)
            {
                minserv = i->serviced;
            }
        }
    }

    if (multiple_ip_count > 1)
    {
        ShowInfo(fmt::format("Detected {} instances from {}. Returning best account match.", multiple_ip_count, ip2str(ip)));
    }

    for (auto& i : login_sd_list)
    {
        if (i->client_addr == ip && i->serviced == minserv)
        {
            i->serviced++;
            return i;
        }
    }
    return nullptr;
}

void erase_loginsd_byaccid(uint32 accid)
{
    for (login_sd_list_t::iterator i = login_sd_list.begin(); i != login_sd_list.end(); ++i)
    {
        if ((*i)->accid == accid)
        {
            login_sd_list.erase(i);
            return;
        }
    }
}

void erase_loginsd(int32 loginfd)
{
    for (login_sd_list_t::iterator i = login_sd_list.begin(); i != login_sd_list.end(); ++i)
    {
        if ((*i)->login_fd == loginfd)
        {
            login_sd_list.erase(i);
            return;
        }
    }
}
