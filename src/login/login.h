/*
===========================================================================

  Copyright (c) 2010-2016 Darkstar Dev Teams

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

#ifndef _LOGIN_H
#define _LOGIN_H

#include "../common/cbasetypes.h"

#include <list>
#include <functional>

#include "../common/kernel.h"
#include "../common/socket.h"
#include "../common/sql.h"
#include "../common/mmo.h"

#include "login_session.h"

struct login_config_t
{
    uint16 login_auth_port;         // authentication port of login server ->  54231
    std::string login_auth_ip;           // authentication ip of login server   -> INADDR_ANY

    uint16 login_data_port;
    std::string login_data_ip;

    uint16 login_view_port;
    std::string login_view_ip;

    std::string servername;

    std::string mysql_host;         // mysql addr     -> localhost:3306
    uint16      mysql_port;         // mysql port     -> 3306
    std::string mysql_login;        // mysql login    -> default root
    std::string mysql_password;     // mysql pass     -> default NULL
    std::string mysql_database;     // mysql database -> default tpzdb

    uint32 search_server_port;      // search_server_port -> 54002

    uint16 msg_server_port;         // chat server port
    std::string msg_server_ip;      // chat server IP
    bool  log_user_ip;              // log user ip -> default false
    bool  account_creation;         // allow new accounts to be created -> default true
};

struct version_info_t
{
    std::string client_ver;         // Expected Client version
    uint8 ver_lock;                 // version lock type - (0 - disabled, 1 - enabled - strict, 2 - enabled - greater than or equal
};

struct maint_config_t
{
    uint8 maint_mode;               // maintenance mode - (0 - disabled, 1 - enabled)
};

extern login_config_t login_config;
extern version_info_t version_info;
extern maint_config_t maint_config;

extern Sql_t *SqlHandle;
//////////////////////////////////////////////////////////

/*======================================================
 * Login-Server Version Screen [venom]
 *------------------------------------------------------*/
void login_helpscreen(int32 flag);
/*======================================================
 * Login-Server Version Screen [venom]
 *------------------------------------------------------*/
void login_versionscreen(int32 flag);
/*==========================================
 * Login-Server Config [venom]
 *------------------------------------------*/

void login_config_read(const char *key, const char* value);
void login_config_default();

void version_info_read(const char *key, const char* value);
void version_info_default();

void maint_config_read(const char *key, const char* value);
void maint_config_default();
std::string maint_config_write(const char* key);

int32 config_read(const char* fileName, const char *config, std::function<void(const char*, const char*)> method);
int32 config_write(const char* fileName, const char *config, std::function<std::string(const char*)> method);

#endif
