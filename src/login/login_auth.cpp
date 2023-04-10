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

#include "common/logging.h"
#include "common/socket.h"

#include "map/message.h"

#include "login.h"
#include "login_auth.h"

#include <cctype>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include <algorithm>

int32 login_fd; // main fd(socket) of server

enum ACCOUNT_STATUS_CODE : uint8
{
    NORMAL = 0x01,
    BANNED = 0x02,
};

enum ACCOUNT_PRIVILIGE_CODE : uint8
{
    USER  = 0x01,
    ADMIN = 0x02,
    ROOT  = 0x04,
};

/*
 *       LOGIN SECTION
 */
int32 connect_client_login(int32 listenfd)
{
    int32              fd = 0;
    struct sockaddr_in client_address;
    if ((fd = connect_client(listenfd, client_address)) != -1)
    {
        create_session(fd, recv_to_fifo, send_from_fifo, login_parse);
        sessions[fd]->client_addr = ntohl(client_address.sin_addr.s_addr);
        return fd;
    }
    return -1;
}

int32 login_parse(int32 fd)
{
    login_session_data_t* sd = (login_session_data_t*)sessions[fd]->session_data;

    // check if sd will not defined
    if (sd == nullptr)
    {
        sessions[fd]->session_data = new login_session_data_t{};
        sd                         = (login_session_data_t*)sessions[fd]->session_data;
        sd->serviced               = 0;
        login_sd_list.push_back(sd);
        sd->client_addr = sessions[fd]->client_addr;
        sd->login_fd    = fd;
    }

    if (sessions[fd]->flag.eof)
    {
        do_close_login(sd, fd);
        return 0;
    }

    // all auth packets have one structure:
    // [login][passwords][code] => summary assign 33 bytes
    if (sessions[fd]->rdata.size() == 33)
    {
        char* buff = &sessions[fd]->rdata[0];
        int8  code = ref<uint8>(buff, 32);

        std::string name(buff, buff + 16);
        std::string password(buff + 16, buff + 32);
        char        escaped_name[16 * 2 + 1];
        char        escaped_pass[32 * 2 + 1];

        std::fill_n(sd->login, sizeof sd->login, '\0');
        std::copy(name.cbegin(), name.cend(), sd->login);

        // data check
        if (check_string(name, 16) && check_string(password, 16))
        {
            ShowWarning(fmt::format("login_parse: {} send unreadable data", ip2str(sd->client_addr)));
            sessions[fd]->wdata.resize(1);
            ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_ERROR;
            do_close_login(sd, fd);
            return -1;
        }

        sql->EscapeString(escaped_name, name.c_str());
        sql->EscapeString(escaped_pass, password.c_str());

        switch (code)
        {
            case LOGIN_ATTEMPT:
            {
                const char* fmtQuery = "SELECT accounts.id,accounts.status \
                                    FROM accounts \
                                    WHERE accounts.login = '%s' AND accounts.password = PASSWORD('%s')";
                int32       ret      = sql->Query(fmtQuery, escaped_name, escaped_pass);
                if (ret != SQL_ERROR && sql->NumRows() != 0)
                {
                    ret = sql->NextRow();

                    sd->accid    = sql->GetUIntData(0);
                    uint8 status = (uint8)sql->GetUIntData(1);

                    if (status & ACCOUNT_STATUS_CODE::NORMAL)
                    {
                        fmtQuery = "UPDATE accounts SET accounts.timelastmodify = NULL WHERE accounts.id = %d";
                        sql->Query(fmtQuery, sd->accid);

                        fmtQuery = "SELECT charid, server_addr, server_port \
                                FROM accounts_sessions JOIN accounts \
                                ON accounts_sessions.accid = accounts.id \
                                WHERE accounts.id = %d;";
                        ret      = sql->Query(fmtQuery, sd->accid);
                        if (ret != SQL_ERROR && sql->NumRows() == 1)
                        {
                            while (sql->NextRow() == SQL_SUCCESS)
                            {
                                uint32 charid = sql->GetUIntData(0);
                                uint64 ip     = sql->GetUIntData(1);
                                uint64 port   = sql->GetUIntData(2);

                                ip |= (port << 32);

                                std::ignore = ip;

                                zmq::message_t chardata(sizeof(charid));
                                ref<uint32>((uint8*)chardata.data(), 0) = charid;
                                zmq::message_t empty(0);

                                // TODO: MSG_LOGIN is a no-op in message_server.cpp,
                                //     : so sending this does nothing?
                                //     : But in the client (message.cpp), it _could_
                                //     : be used to clear out lingering PChar data.
                                // queue_message(ipp, MSG_LOGIN, &chardata, &empty);
                            }
                        }

                        memset(&sessions[fd]->wdata[0], 0, 33);
                        sessions[fd]->wdata.resize(33);
                        ref<uint8>(sessions[fd]->wdata.data(), 0)  = LOGIN_SUCCESS;
                        ref<uint32>(sessions[fd]->wdata.data(), 1) = sd->accid;
                        flush_fifo(fd);
                        do_close_tcp(fd);
                    }
                    else if (status & ACCOUNT_STATUS_CODE::BANNED)
                    {
                        memset(&sessions[fd]->wdata[0], 0, 33);
                        sessions[fd]->wdata.resize(33);
                        do_close_login(sd, fd);
                    }

                    //////22/03/2012 Fix for when a client crashes before fully logging in:
                    //              Before: When retry to login, would freeze client since login data corrupt.
                    //              After: Removes older login info if a client logs in twice (based on acc id!)

                    // check for multiple logins from this account id
                    int numCons = 0;
                    for (auto& i : login_sd_list)
                    {
                        if (i->accid == sd->accid)
                        {
                            numCons++;
                        }
                    }

                    if (numCons > 1)
                    {
                        ShowInfo(fmt::format("login_parse: <{}> has logged in {} times! Removing older logins.", escaped_name, numCons));
                        for (int j = 0; j < (numCons - 1); j++)
                        {
                            for (login_sd_list_t::iterator i = login_sd_list.begin(); i != login_sd_list.end(); ++i)
                            {
                                if ((*i)->accid == sd->accid)
                                {
                                    ShowTrace(fmt::format("Current login fd={} Removing fd={}", sd->login_fd, (*i)->login_fd));
                                    login_sd_list.erase(i);
                                    break;
                                }
                            }
                        }
                    }
                    //////

                    ShowInfo(fmt::format("login_parse: <{}> was connected", escaped_name, status));
                    return 0;
                }

                sessions[fd]->wdata.resize(1);
                ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_ERROR;
                ShowWarning(fmt::format("login_parse: unexisting user <{}> tried to connect", escaped_name));
                do_close_login(sd, fd);
            }
            break;
            case LOGIN_CREATE:

                // check if account creation is disabled
                if (!settings::get<bool>("login.ACCOUNT_CREATION"))
                {
                    ShowWarning(fmt::format("login_parse: New account attempt <{}> but is disabled in settings.",
                                            escaped_name));
                    sessions[fd]->wdata.resize(1);
                    ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_ERROR_CREATE_DISABLED;
                    do_close_login(sd, fd);
                    return -1;
                }

                // looking for same login
                if (sql->Query("SELECT accounts.id FROM accounts WHERE accounts.login = '%s'", escaped_name) == SQL_ERROR)
                {
                    sessions[fd]->wdata.resize(1);
                    ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_ERROR_CREATE;
                    do_close_login(sd, fd);
                    return -1;
                }

                if (sql->NumRows() == 0)
                {
                    // creating new account_id
                    const char* fmtQuery = "SELECT max(accounts.id) FROM accounts;";

                    uint32 accid = 0;

                    if (sql->Query(fmtQuery) != SQL_ERROR && sql->NumRows() != 0)
                    {
                        sql->NextRow();

                        accid = sql->GetUIntData(0) + 1;
                    }
                    else
                    {
                        sessions[fd]->wdata.resize(1);
                        ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_ERROR_CREATE;
                        do_close_login(sd, fd);
                        return -1;
                    }

                    accid = (accid < 1000 ? 1000 : accid);

                    // creating new account
                    time_t timecreate;
                    tm     timecreateinfo;

                    time(&timecreate);
                    _localtime_s(&timecreateinfo, &timecreate);

                    char strtimecreate[128];
                    strftime(strtimecreate, sizeof(strtimecreate), "%Y:%m:%d %H:%M:%S", &timecreateinfo);
                    fmtQuery = "INSERT INTO accounts(id,login,password,timecreate,timelastmodify,status,priv)\
                                       VALUES(%d,'%s',PASSWORD('%s'),'%s',NULL,%d,%d);";

                    if (sql->Query(fmtQuery, accid, escaped_name, escaped_pass, strtimecreate, ACCOUNT_STATUS_CODE::NORMAL, ACCOUNT_PRIVILIGE_CODE::USER) == SQL_ERROR)
                    {
                        sessions[fd]->wdata.resize(1);
                        ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_ERROR_CREATE;
                        do_close_login(sd, fd);
                        return -1;
                    }

                    ShowInfo(fmt::format("login_parse: account<{}> was created", escaped_name));
                    sessions[fd]->wdata.resize(1);
                    ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_SUCCESS_CREATE;
                    do_close_login(sd, fd);
                }
                else
                {
                    ShowWarning(fmt::format("login_parse: account<{}> already exists", escaped_name));
                    sessions[fd]->wdata.resize(1);
                    ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_ERROR_CREATE_TAKEN;
                    do_close_login(sd, fd);
                }
                break;
            case LOGIN_CHANGE_PASSWORD:
            {
                const char* fmtQuery = "SELECT accounts.id,accounts.status \
                                    FROM accounts \
                                    WHERE accounts.login = '%s' AND accounts.password = PASSWORD('%s')";
                int32       ret      = sql->Query(fmtQuery, escaped_name, escaped_pass);
                if (ret == SQL_ERROR || sql->NumRows() == 0)
                {
                    sessions[fd]->wdata.resize(1);
                    ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_ERROR;
                    ShowWarning(fmt::format("login_parse: user <{}> could not be found using the provided information. Aborting.", escaped_name));
                    do_close_login(sd, fd);
                    return 0;
                }

                ret = sql->NextRow();

                sd->accid    = sql->GetUIntData(0);
                uint8 status = (uint8)sql->GetUIntData(1);

                if (status & ACCOUNT_STATUS_CODE::BANNED)
                {
                    sessions[fd]->wdata.resize(1);
                    ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                    ShowInfo(fmt::format("login_parse: banned user <{}> detected. Aborting.", escaped_name));
                    do_close_login(sd, fd);
                    return 0;
                }

                if (status & ACCOUNT_STATUS_CODE::NORMAL)
                {
                    // Account info verified. Now request the new password.
                    sessions[fd]->wdata.resize(1);
                    ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_REQUEST_NEW_PASSWORD;
                    flush_fifo(fd);
                    sessions[fd]->rdata.resize(0); // Clear read buffer
                    sessions[fd]->func_recv(fd);

                    // Packet expects a single password parameter no longer than
                    // 16 bytes.
                    size_t size = sessions[fd]->rdata.size();
                    if (size == 0 || size > 16)
                    {
                        sessions[fd]->wdata.resize(1);
                        ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                        ShowWarning(fmt::format("login_parse: Invalid packet size ({}). Could not update password for user <{}>.",
                                                size, escaped_name));
                        do_close_login(sd, fd);
                        return 0;
                    }

                    char*       buff2 = &sessions[fd]->rdata[0];
                    std::string updated_password(buff2, buff2 + 16);
                    char        escaped_updated_password[16 * 2 + 1];
                    sql->EscapeString(escaped_updated_password, updated_password.c_str());

                    fmtQuery = "UPDATE accounts SET accounts.timelastmodify = NULL WHERE accounts.id = %d";
                    sql->Query(fmtQuery, sd->accid);

                    fmtQuery = "UPDATE accounts SET accounts.password = PASSWORD('%s') WHERE accounts.id = %d";
                    ret      = sql->Query(fmtQuery, escaped_updated_password, sd->accid);
                    if (ret == SQL_ERROR)
                    {
                        sessions[fd]->wdata.resize(1);
                        ref<uint8>(sessions[fd]->wdata.data(), 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                        ShowWarning(fmt::format("login_parse: Error trying to update password in database for user <{}>.", escaped_name));
                        do_close_login(sd, fd);
                        return 0;
                    }

                    memset(&sessions[fd]->wdata[0], 0, 33);
                    sessions[fd]->wdata.resize(33);
                    ref<uint8>(sessions[fd]->wdata.data(), 0)  = LOGIN_SUCCESS_CHANGE_PASSWORD;
                    ref<uint32>(sessions[fd]->wdata.data(), 1) = sd->accid;
                    flush_fifo(fd);
                    do_close_tcp(fd);

                    ShowInfo("login_parse: password updated successfully.");
                    return 0;
                }
            }
            break;
            default:
                ShowWarning(fmt::format("login_parse: undefined code:[{}], ip sender:<{}>", code, ip2str(sessions[fd]->client_addr)));
                do_close_login(sd, fd);
                break;
        };
    }
    else
    {
        do_close_login(sd, fd);
    }
    return 0;
};

int32 do_close_login(login_session_data_t* loginsd, int32 fd)
{
    ShowInfo(fmt::format("login_parse: {} shutdown socket", ip2str(loginsd->client_addr)));
    erase_loginsd(fd);
    do_close_tcp(fd);
    return 0;
}

bool check_string(std::string const& str, std::size_t max_length)
{
    return !str.empty() && str.size() <= max_length && std::all_of(str.cbegin(), str.cend(), [](char const& c)
                                                                   { return c >= 0x20; });
}
