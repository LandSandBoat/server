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

#include "../common/showmsg.h"
#include "../common/socket.h"

#include "account.h"
#include "login.h"
#include "login_auth.h"
#include "message_server.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include <algorithm>

int32 login_fd;                 //main fd(socket) of server

/*
*
*       LOGIN SECTION
*
*/
int32 connect_client_login(int32 listenfd)
{
    int32 fd = 0;
    struct sockaddr_in client_address;
    if ((fd = connect_client(listenfd, client_address)) != -1)
    {
        create_session(fd, recv_to_fifo, send_from_fifo, login_parse);
        session[fd]->client_addr = ntohl(client_address.sin_addr.s_addr);
        return fd;
    }
    return -1;
}

int32 login_parse(int32 fd)
{
    login_session_data_t* sd = (login_session_data_t*)session[fd]->session_data;

    //check if sd will not defined
    if (sd == nullptr)
    {
        session[fd]->session_data = new login_session_data_t{};
        sd = (login_session_data_t*)session[fd]->session_data;
        sd->serviced = 0;
        login_sd_list.push_back(sd);
        sd->client_addr = session[fd]->client_addr;
        sd->login_fd = fd;
    }

    if (session[fd]->flag.eof)
    {
        do_close_login(sd, fd);
        return 0;
    }

    //all auth packets have one structure:
    // [login][passwords][code] => summary assign 33 bytes
    if (session[fd]->rdata.size() == 33)
    {
        char* buff = &session[fd]->rdata[0];
        int8 code = ref<uint8>(buff, 32);

        std::string name(buff, buff + 16);
        std::string password(buff + 16, buff + 32);
        char escaped_name[16*2 +1];
        char escaped_pass[32*2 +1];

        std::fill_n(sd->login, sizeof sd->login, '\0');
        std::copy(name.cbegin(), name.cend(), sd->login);

        //data check
        if (check_string(name, 16) && check_string(password, 16))
        {
            ShowWarning(CL_WHITE"login_parse" CL_RESET":" CL_WHITE"%s" CL_RESET" send unreadable data\n", ip2str(sd->client_addr, nullptr));
            session[fd]->wdata.resize(1);
            ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_ERROR;
            do_close_login(sd, fd);
            return -1;
        }

        Sql_EscapeString(SqlHandle, escaped_name, name.c_str());
        Sql_EscapeString(SqlHandle, escaped_pass, password.c_str());

        switch (code)
        {
        case LOGIN_ATTEMPT:
        {
            const char* fmtQuery = "SELECT accounts.id,accounts.status \
                                    FROM accounts \
                                    WHERE accounts.login = '%s' AND accounts.password = PASSWORD('%s')";
            int32 ret = Sql_Query(SqlHandle, fmtQuery, escaped_name, escaped_pass);
            if (ret != SQL_ERROR  && Sql_NumRows(SqlHandle) != 0)
            {
                ret = Sql_NextRow(SqlHandle);

                sd->accid = (uint32)Sql_GetUIntData(SqlHandle, 0);
                uint8 status = (uint8)Sql_GetUIntData(SqlHandle, 1);

                if (status & ACCST_NORMAL)
                {
                    //fmtQuery = "SELECT * FROM accounts_sessions WHERE accid = %d AND client_port <> 0";

                    //int32 ret = Sql_Query(SqlHandle,fmtQuery,sd->accid);

                    //if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 )
                    //{
                    //  ref<uint8>(session[fd]->wdata,0) = 0x05; // SESSION has already activated
                    //  WFIFOSET(fd,33);
                    //  do_close_login(sd,fd);
                    //  return 0;
                    //}
                    fmtQuery = "UPDATE accounts SET accounts.timelastmodify = NULL WHERE accounts.id = %d";
                    Sql_Query(SqlHandle, fmtQuery, sd->accid);
                    fmtQuery = "SELECT charid, server_addr, server_port \
                                FROM accounts_sessions JOIN accounts \
                                ON accounts_sessions.accid = accounts.id \
                                WHERE accounts.id = %d;";
                    ret = Sql_Query(SqlHandle, fmtQuery, sd->accid);
                    if (ret != SQL_ERROR  && Sql_NumRows(SqlHandle) == 1)
                    {
                        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                        {
                            uint32 charid = Sql_GetUIntData(SqlHandle, 0);
                            uint64 ip = Sql_GetUIntData(SqlHandle, 1);
                            uint64 port = Sql_GetUIntData(SqlHandle, 2);

                            ip |= (port << 32);

                            zmq::message_t chardata(sizeof(charid));
                            ref<uint32>((uint8*)chardata.data(), 0) = charid;
                            zmq::message_t empty(0);

                            queue_message(ip, MSG_LOGIN, &chardata, &empty);
                        }
                    }
                    memset(&session[fd]->wdata[0], 0, 33);
                    session[fd]->wdata.resize(33);
                    ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_SUCCESS;
                    ref<uint32>(session[fd]->wdata.data(), 1) = sd->accid;
                    flush_fifo(fd);
                    do_close_tcp(fd);
                }
                else if (status & ACCST_BANNED)
                {
                    memset(&session[fd]->wdata[0], 0, 33);
                    session[fd]->wdata.resize(33);
                    //  ref<uint8>(session[fd]->wdata,0) = LOGIN_SUCCESS;
                    do_close_login(sd, fd);
                }

                //////22/03/2012 Fix for when a client crashes before fully logging in:
                //              Before: When retry to login, would freeze client since login data corrupt.
                //              After: Removes older login info if a client logs in twice (based on acc id!)

                //check for multiple logins from this account id
                int numCons = 0;
                for (login_sd_list_t::iterator i = login_sd_list.begin(); i != login_sd_list.end(); ++i) {
                    if ((*i)->accid == sd->accid) {
                        numCons++;
                    }
                }

                if (numCons > 1) {
                    ShowInfo("login_parse:" CL_WHITE"<%s>" CL_RESET" has logged in %i times! Removing older logins.\n", escaped_name, numCons);
                    for (int j = 0; j < (numCons - 1); j++) {
                        for (login_sd_list_t::iterator i = login_sd_list.begin(); i != login_sd_list.end(); ++i) {
                            if ((*i)->accid == sd->accid) {
                                //ShowInfo("Current login fd=%i Removing fd=%i \n",sd->login_fd,(*i)->login_fd);
                                login_sd_list.erase(i);
                                break;
                            }
                        }
                    }
                }
                //////

                ShowInfo("login_parse:" CL_WHITE"<%s>" CL_RESET" was connected\n", escaped_name, status);
                return 0;
            }
            else {
                session[fd]->wdata.resize(1);
                ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_ERROR;
                ShowWarning("login_parse: unexisting user" CL_WHITE"<%s>" CL_RESET" tried to connect\n", escaped_name);
                do_close_login(sd, fd);
            }
        }
        break;
        case LOGIN_CREATE:

           //check if account creation is disabled
            if (!login_config.account_creation)
            {
                ShowWarning(CL_WHITE"login_parse" CL_RESET": New account attempt <" CL_WHITE"%s" CL_RESET"> but is disabled in config.\n", escaped_name);
                session[fd]->wdata.resize(1);
                ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_ERROR_CREATE;
                do_close_login(sd, fd);
                return 0;
            }

           //looking for same login
            if (Sql_Query(SqlHandle, "SELECT accounts.id FROM accounts WHERE accounts.login = '%s'", escaped_name) == SQL_ERROR)
            {
                session[fd]->wdata.resize(1);
                ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_ERROR_CREATE;
                do_close_login(sd, fd);
                return -1;
            }

            if (Sql_NumRows(SqlHandle) == 0)
            {
                //creating new account_id
                const char *fmtQuery = "SELECT max(accounts.id) FROM accounts;";

                uint32 accid = 0;

                if (Sql_Query(SqlHandle, fmtQuery) != SQL_ERROR  && Sql_NumRows(SqlHandle) != 0)
                {
                    Sql_NextRow(SqlHandle);

                    accid = Sql_GetUIntData(SqlHandle, 0) + 1;
                }
                else {
                    session[fd]->wdata.resize(1);
                    ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_ERROR_CREATE;
                    do_close_login(sd, fd);
                    return -1;
                }

                accid = (accid < 1000 ? 1000 : accid);

                //creating new account
                time_t timecreate;
                tm*    timecreateinfo;

                time(&timecreate);
                timecreateinfo = localtime(&timecreate);

                char strtimecreate[128];
                strftime(strtimecreate, sizeof(strtimecreate), "%Y:%m:%d %H:%M:%S", timecreateinfo);
                fmtQuery = "INSERT INTO accounts(id,login,password,timecreate,timelastmodify,status,priv)\
                                       VALUES(%d,'%s',PASSWORD('%s'),'%s',NULL,%d,%d);";

                if (Sql_Query(SqlHandle, fmtQuery, accid, escaped_name, escaped_pass,
                    strtimecreate, ACCST_NORMAL, ACCPRIV_USER) == SQL_ERROR)
                {
                    session[fd]->wdata.resize(1);
                    ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_ERROR_CREATE;
                    do_close_login(sd, fd);
                    return -1;
                }

                ShowStatus(CL_WHITE"login_parse" CL_RESET": account<" CL_WHITE"%s" CL_RESET"> was created\n", escaped_name);
                session[fd]->wdata.resize(1);
                ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_SUCCESS_CREATE;
                do_close_login(sd, fd);
            }
            else {
                ShowWarning(CL_WHITE"login_parse" CL_RESET": account<" CL_WHITE"%s" CL_RESET"> already exists\n", escaped_name);
                session[fd]->wdata.resize(1);
                ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_ERROR_CREATE;
                do_close_login(sd, fd);
            }
            break;
        case LOGIN_CHANGE_PASSWORD:
        {
            const char* fmtQuery = "SELECT accounts.id,accounts.status \
                                    FROM accounts \
                                    WHERE accounts.login = '%s' AND accounts.password = PASSWORD('%s')";
            int32 ret = Sql_Query(SqlHandle, fmtQuery, escaped_name, escaped_pass);
            if (ret == SQL_ERROR || Sql_NumRows(SqlHandle) == 0)
            {
                session[fd]->wdata.resize(1);
                ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_ERROR;
                ShowWarning("login_parse: user" CL_WHITE"<%s>" CL_RESET" could not be found using the provided information. Aborting.\n", escaped_name);
                do_close_login(sd, fd);
                return 0;
            }

            ret = Sql_NextRow(SqlHandle);

            sd->accid = (uint32)Sql_GetUIntData(SqlHandle, 0);
            uint8 status = (uint8)Sql_GetUIntData(SqlHandle, 1);

            if (status & ACCST_BANNED)
            {
                session[fd]->wdata.resize(1);
                ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                ShowInfo("login_parse: banned user" CL_WHITE"<%s>" CL_RESET" detected. Aborting.\n", escaped_name);
                do_close_login(sd, fd);
                return 0;
            }

            if (status & ACCST_NORMAL)
            {
                // Account info verified. Now request the new password.
                session[fd]->wdata.resize(1);
                ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_REQUEST_NEW_PASSWORD;
                flush_fifo(fd);
                session[fd]->rdata.resize(0);  // Clear read buffer
                session[fd]->func_recv(fd);

                // Packet expects a single password parameter no longer than
                // 16 bytes.
                size_t size = session[fd]->rdata.size();
                if (size == 0 || size > 16)
                {
                    session[fd]->wdata.resize(1);
                    ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                    ShowWarning("login_parse: Invalid packet size (%d). Could not update password for user" CL_WHITE"<%s>" CL_RESET".\n", size, escaped_name);
                    do_close_login(sd, fd);
                    return 0;
                }

                char* buff2 = &session[fd]->rdata[0];
                std::string updated_password(buff2, buff2 + 16);
                char escaped_updated_password[16 * 2 + 1];
                Sql_EscapeString(SqlHandle, escaped_updated_password, updated_password.c_str());

                fmtQuery = "UPDATE accounts SET accounts.timelastmodify = NULL WHERE accounts.id = %d";
                Sql_Query(SqlHandle, fmtQuery, sd->accid);

                fmtQuery = "UPDATE accounts SET accounts.password = PASSWORD('%s') WHERE accounts.id = %d";
                ret = Sql_Query(SqlHandle, fmtQuery, escaped_updated_password, sd->accid);
                if (ret == SQL_ERROR)
                {
                    session[fd]->wdata.resize(1);
                    ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                    ShowWarning("login_parse: Error trying to update password in database for user" CL_WHITE"<%s>" CL_RESET".\n", escaped_name);
                    do_close_login(sd, fd);
                    return 0;
                }

                memset(&session[fd]->wdata[0], 0, 33);
                session[fd]->wdata.resize(33);
                ref<uint8>(session[fd]->wdata.data(), 0) = LOGIN_SUCCESS_CHANGE_PASSWORD;
                ref<uint32>(session[fd]->wdata.data(), 1) = sd->accid;
                flush_fifo(fd);
                do_close_tcp(fd);

                ShowInfo("login_parse: password updated successfully.\n");
                return 0;
            }
        }
        break;
        default:
            ShowWarning("login_parse: undefined code:[%d], ip sender:<%s>\n", code, ip2str(session[fd]->client_addr, nullptr));
            do_close_login(sd, fd);
            break;
        };
        //RFIFOSKIP(fd,33);
    }
    else {
        do_close_login(sd, fd);
    }
    return 0;
};


int32 do_close_login(login_session_data_t* loginsd, int32 fd)
{
    ShowInfo(CL_WHITE"login_parse" CL_RESET":" CL_WHITE"%s" CL_RESET"shutdown socket...\n", ip2str(loginsd->client_addr, nullptr));
    erase_loginsd(fd);
    do_close_tcp(fd);
    return 0;
}

bool check_string(std::string const& str, std::size_t max_length)
{
    return !str.empty() && str.size() <= max_length && std::all_of(str.cbegin(), str.cend(), [](char const& c) { return c >= 0x20; });
}
