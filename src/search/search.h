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

#include "../common/cbasetypes.h"

struct search_config_t
{
    std::string mysql_host;      // mysql addr     -> localhost
    uint16      mysql_port;      // mysql port     -> 3306
    std::string mysql_login;     // mysql login    -> default root
    std::string mysql_password;  // mysql pass     -> default root
    std::string mysql_database;  // mysql database -> default tpzdb
    bool        expire_auctions; // If true, then start task to expire old auctions off the auction house
    uint8       expire_days;     // Number of days to keep stuff on the auction house
    int16       expire_interval; // How often the task should run (time * 1000) in seconds
};

struct login_config_t
{
    std::string search_server_port; // search_server_port   -> 54002
};

struct search_req
{
    uint16   zoneid[10];
    uint8    jobid;
    uint8    minlvl;
    uint8    maxlvl;
    uint8    race;
    uint8    nation;
    uint8    minRank;
    uint8    maxRank;
    uint32   flags;
    string_t name;
    uint8    nameLen;
};

extern search_config_t search_config;
