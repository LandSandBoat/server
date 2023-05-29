/*
===========================================================================

Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "common/application.h"
#include "common/console_service.h"
#include "common/logging.h"
#include "common/lua.h"
#include "common/md52.h"
#include "common/settings.h"
#include "common/sql.h"
#include "common/utils.h"
#include "map/packets/basic.h"

#include <asio/ts/buffer.hpp>
#include <asio/ts/internet.hpp>
#include <chrono>
#include <cstdlib>
#include <iostream>
#include <memory>
#include <thread>
#include <type_traits>
#include <unordered_map>
#include <utility>
#include <vector>
#include <zmq.hpp>

#include <nonstd/jthread.hpp>

// TODO: Move to enum
#define LOGIN_ATTEMPT         0x10
#define LOGIN_CREATE          0x20
#define LOGIN_CHANGE_PASSWORD 0x30

/*return result*/
#define LOGIN_FAIL                    0x00
#define LOGIN_SUCCESS                 0x01
#define LOGIN_SUCCESS_CREATE          0x03
#define LOGIN_SUCCESS_CHANGE_PASSWORD 0x06

#define LOGIN_REQUEST_NEW_PASSWORD 0x05

#define LOGIN_ERROR                     0x02
#define LOGIN_ERROR_CREATE              0x09
#define LOGIN_ERROR_CREATE_TAKEN        0x04
#define LOGIN_ERROR_CREATE_DISABLED     0x08
#define LOGIN_ERROR_CHANGE_PASSWORD     0x07
#define LOGIN_ERROR_ALREADY_LOGGED_IN   0x0A
#define LOGIN_ERROR_VERSION_UNSUPPORTED 0x0B

#define SUPPORTED_XILOADER_VERSION "1.0.0"

bool check_string(std::string const& str, std::size_t max_length)
{
    // clang-format off
    return !str.empty() &&
        str.size() <= max_length &&
        std::all_of(str.cbegin(), str.cend(),
        [](char const& c)
        {
            return c >= 0x20;
        });
    // clang-format on
}

class handler_session
: public std::enable_shared_from_this<handler_session>
{
public:
    handler_session(asio::ip::tcp::socket socket)
    : socket_(std::move(socket))
    , data_()
    {
        socket_.set_option(asio::socket_base::reuse_address(true));
        ipAddress = socket_.remote_endpoint().address().to_string();
    }

    virtual ~handler_session() = default;

    void start()
    {
        do_read();
    }

    void do_read()
    {
        auto self(shared_from_this());

        // clang-format off
        socket_.async_read_some(asio::buffer(data_, max_length),
        [this, self](std::error_code ec, std::size_t length)
        {
            if (!ec)
            {
                read_func();
            }
            else
            {
                DebugSockets(ec.message());
                handle_error(ec, self);
            }
        });
        // clang-format on
    }

    virtual void handle_error(std::error_code ec, std::shared_ptr<handler_session> self)
    {
    }

    void do_write(std::size_t length)
    {
        auto self(shared_from_this());
        // clang-format off
        asio::async_write(socket_, asio::buffer(data_, length),
        [this, self](std::error_code ec, std::size_t /*length*/)
        {
            if (!ec)
            {
                write_func();
            }
            else
            {
                ShowError(ec.message());
            }
        });
        // clang-format on
    }

    virtual void read_func()  = 0;
    virtual void write_func() = 0;

    asio::ip::tcp::socket socket_;
    std::string           ipAddress;   // Sore IP address in class -- once the file handle is invalid this can no longer be obtained from socket_
    std::string           sessionHash; // Store session hash here additionally to clean up sockets easier

    // TODO: Use std::array
    enum
    {
        max_length = 4096
    };
    char data_[max_length] = {};
};

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

// Displays expansions on main menu. // May be a 32 bit integer on the client.
enum EXPANSION_DISPLAY : uint16
{
    BASE_GAME               = 0x0001, // not used by the client
    RISE_OF_ZILART          = 0x0002,
    CHAINS_OF_PROMATHIA     = 0x0004,
    TREASURES_OF_AHT_URGHAN = 0x0008,
    WINGS_OF_THE_GODDESS    = 0x0010,
    A_CRYSTALLINE_PROPHECY  = 0x0020,
    A_MOOGLE_KUPOD_ETAT     = 0x0040,
    A_SHANTOTTO_ASCENSION   = 0x0080,
    VISIONS_OF_ABYSSEA      = 0x0100,
    SCARS_OF_ABYSSEA        = 0x0200,
    HEROES_OF_ABYSSEA       = 0x0400,
    SEEKERS_OF_ADOULIN      = 0x0800,
    UNUSED_EXPANSION_1      = 0x1000,
    UNUSED_EXPANSION_2      = 0x2000,
    UNUSED_EXPANSION_3      = 0x4000,
    UNUSED_EXPANSION_4      = 0x8000,
};

// Displays features on main menu // May be a 32 bit integer on the client.
enum FEATURE_DISPLAY : uint16
{
    SECURE_TOKEN     = 0x0001,
    UNUSED_FEATURE_1 = 0x0002,
    MOG_WARDROBE_3   = 0x0004,
    MOG_WARDROBE_4   = 0x0008,
    MOG_WARDROBE_5   = 0x0010,
    MOG_WARDROBE_6   = 0x0020,
    MOG_WARDROBE_7   = 0x0040,
    MOG_WARDROBE_8   = 0x0080,
    UNUSED_FEATURE_2 = 0x0100,
    UNUSED_FEATURE_3 = 0x0200,
    UNUSED_FEATURE_4 = 0x0400,
    UNUSED_FEATURE_5 = 0x0800,
    UNUSED_FEATURE_6 = 0x1000,
    UNUSED_FEATURE_7 = 0x2000,
    UNUSED_FEATURE_8 = 0x4000,
    UNUSED_FEATURE_9 = 0x8000,
};

// Metadata about each session
struct session_t
{
    // Auth session is not yet needed to be stored
    // std::shared_ptr<handler_session> auth_session;
    std::shared_ptr<handler_session> data_session;
    std::shared_ptr<handler_session> view_session;
    std::shared_ptr<handler_session> pol_session;

    uint32      accountID                 = 0;
    uint32      serverIP                  = 0;
    uint32      requestedCharacterID      = 0;
    std::string requestedNewCharacterName = "";
    bool        justCreatedNewChar        = false;
    bool        versionMismatch           = false;

    std::chrono::time_point<std::chrono::system_clock> authorizedTime = server_clock::now();
};

// NOTE: This collection of flags is 64-bits wide!
enum AUTH_COMPONENTS
{
    // If this flag is set, then all communications will happen over a
    // secure TLS session.
    USE_TLS = 1 << 0,

    // Information to be sent during login sequence.
    // Each item is added to the data sequentially,
    // after username and password, which are mandatory:
    // [username][password][email][hostname][macaddr]
    // If you opted not to use email and hostname:
    // [username][password][macaddr]
    SEND_EMAIL       = 1 << 1,
    SEND_HOSTNAME    = 1 << 2,
    SEND_MAC_ADDRESS = 1 << 3,

    // These flags enable additional workflows between connect and xiloader
    ENABLE_ACCOUNT_CREATE  = 1 << 4, // Ability for a user to create an account
    ENABLE_ACCOUNT_DELETE  = 1 << 5, // Ability for a user to delete their account
    ENABLE_PASSWORD_CHANGE = 1 << 6, // Ability for a user to change their password through xiloader
    ENABLE_PASSWORD_RESET  = 1 << 7, // Ability for a user to flag their account for a password reset through connect server
};

// [ip_addr][session_hash] = session
std::unordered_map<std::string, std::map<std::string, session_t>> authenticatedSessions_;

session_t& get_authenticated_session(asio::ip::tcp::socket& socket, std::string sessionHash)
{
    std::string ip_str = socket.remote_endpoint().address().to_string();
    return authenticatedSessions_[ip_str][sessionHash]; // NOTE: Will construct if doesn't exist
}

session_t& get_authenticated_session(std::string ipAddr, std::string sessionHash)
{
    return authenticatedSessions_[ipAddr][sessionHash]; // NOTE: Will construct if doesn't exist
}

// hostname/ip conversion functions
std::string ip2str(uint32 ip)
{
    uint32 reversed_ip = htonl(ip);
    char   address[INET_ADDRSTRLEN];
    inet_ntop(AF_INET, &reversed_ip, address, INET_ADDRSTRLEN);
    return fmt::format("{}", address);
}

uint32 str2ip(const char* ip_str)
{
    uint32 ip;
    inet_pton(AF_INET, ip_str, &ip);

    return ntohl(ip);
}

void generateErrorMessage(char* packet, uint16 errorCode)
{
    std::memset(packet, 0, 0x24);

    packet[0] = 0x24; // size

    packet[4] = 0x49; // I
    packet[5] = 0x58; // X
    packet[6] = 0x46; // F
    packet[7] = 0x46; // F

    packet[8] = 0x04; // result

    packet[28] = 0x10; // Unknown

    ref<uint16>(packet, 32) = errorCode;

    unsigned char hash[16];
    md5(reinterpret_cast<uint8*>(packet), hash, 0x24);
    std::memcpy(packet + 12, hash, 16);
}

uint16 generateExpansionBitmask()
{
    uint16 mask = EXPANSION_DISPLAY::BASE_GAME;

    if (settings::get<bool>("login.RISE_OF_ZILART"))
    {
        mask |= EXPANSION_DISPLAY::RISE_OF_ZILART;
    }

    if (settings::get<bool>("login.CHAINS_OF_PROMATHIA"))
    {
        mask |= EXPANSION_DISPLAY::CHAINS_OF_PROMATHIA;
    }

    if (settings::get<bool>("login.TREASURES_OF_AHT_URGHAN"))
    {
        mask |= EXPANSION_DISPLAY::TREASURES_OF_AHT_URGHAN;
    }

    if (settings::get<bool>("login.WINGS_OF_THE_GODDESS"))
    {
        mask |= EXPANSION_DISPLAY::WINGS_OF_THE_GODDESS;
    }

    if (settings::get<bool>("login.A_CRYSTALLINE_PROPHECY"))
    {
        mask |= EXPANSION_DISPLAY::A_CRYSTALLINE_PROPHECY;
    }

    if (settings::get<bool>("login.A_MOOGLE_KUPOD_ETAT"))
    {
        mask |= EXPANSION_DISPLAY::A_MOOGLE_KUPOD_ETAT;
    }

    if (settings::get<bool>("login.A_SHANTOTTO_ASCENSION"))
    {
        mask |= EXPANSION_DISPLAY::A_SHANTOTTO_ASCENSION;
    }

    if (settings::get<bool>("login.VISIONS_OF_ABYSSEA"))
    {
        mask |= EXPANSION_DISPLAY::VISIONS_OF_ABYSSEA;
    }

    if (settings::get<bool>("login.SCARS_OF_ABYSSEA"))
    {
        mask |= EXPANSION_DISPLAY::SCARS_OF_ABYSSEA;
    }

    if (settings::get<bool>("login.HEROES_OF_ABYSSEA"))
    {
        mask |= EXPANSION_DISPLAY::HEROES_OF_ABYSSEA;
    }

    if (settings::get<bool>("login.SEEKERS_OF_ADOULIN"))
    {
        mask |= EXPANSION_DISPLAY::SEEKERS_OF_ADOULIN;
    }
    return mask;
}

uint16 generateFeatureBitmask()
{
    uint16 mask = 0;

    if (settings::get<bool>("login.SECURE_TOKEN"))
    {
        mask |= FEATURE_DISPLAY::SECURE_TOKEN;
    }

    if (settings::get<bool>("login.MOG_WARDROBE_3"))
    {
        mask |= FEATURE_DISPLAY::MOG_WARDROBE_3;
    }

    if (settings::get<bool>("login.MOG_WARDROBE_4"))
    {
        mask |= FEATURE_DISPLAY::MOG_WARDROBE_4;
    }

    if (settings::get<bool>("login.MOG_WARDROBE_5"))
    {
        mask |= FEATURE_DISPLAY::MOG_WARDROBE_5;
    }

    if (settings::get<bool>("login.MOG_WARDROBE_6"))
    {
        mask |= FEATURE_DISPLAY::MOG_WARDROBE_6;
    }

    if (settings::get<bool>("login.MOG_WARDROBE_7"))
    {
        mask |= FEATURE_DISPLAY::MOG_WARDROBE_7;
    }

    if (settings::get<bool>("login.MOG_WARDROBE_8"))
    {
        mask |= FEATURE_DISPLAY::MOG_WARDROBE_8;
    }

    return mask;
}

int32 saveCharacter(uint32 accid, uint32 charid, char_mini* createchar)
{
    auto sql = std::make_unique<SqlConnection>();

    const char* Query = "INSERT INTO chars(charid,accid,charname,pos_zone,nation) VALUES(%u,%u,'%s',%u,%u);";

    if (sql->Query(Query, charid, accid, createchar->m_name, createchar->m_zone, createchar->m_nation) == SQL_ERROR)
    {
        ShowDebug(fmt::format("lobby_ccsave: char<{}>, accid: {}, charid: {}", createchar->m_name, accid, charid));
        return -1;
    }

    Query = "INSERT INTO char_look(charid,face,race,size) VALUES(%u,%u,%u,%u);";

    if (sql->Query(Query, charid, createchar->m_look.face, createchar->m_look.race, createchar->m_look.size) == SQL_ERROR)
    {
        ShowDebug(fmt::format("lobby_cLook: char<{}>, charid: {}", createchar->m_name, charid));
        return -1;
    }

    Query = "INSERT INTO char_stats(charid,mjob) VALUES(%u,%u);";

    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        ShowDebug(fmt::format("lobby_cStats: charid: {}", charid));
        return -1;
    }

    Query = "INSERT INTO char_exp(charid) VALUES(%u) \
            ON DUPLICATE KEY UPDATE charid = charid;";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    Query = "INSERT INTO char_jobs(charid) VALUES(%u) \
            ON DUPLICATE KEY UPDATE charid = charid;";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    Query = "INSERT INTO char_points(charid) VALUES(%u) \
            ON DUPLICATE KEY UPDATE charid = charid;";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    Query = "INSERT INTO char_unlocks(charid) VALUES(%u) \
            ON DUPLICATE KEY UPDATE charid = charid;";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    Query = "INSERT INTO char_profile(charid) VALUES(%u) \
            ON DUPLICATE KEY UPDATE charid = charid;";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    Query = "INSERT INTO char_storage(charid) VALUES(%u) \
            ON DUPLICATE KEY UPDATE charid = charid;";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    Query = "DELETE FROM char_inventory WHERE charid = %u";
    if (sql->Query(Query, charid) == SQL_ERROR)
    {
        return -1;
    }

    Query = "INSERT INTO char_inventory(charid) VALUES(%u);";
    if (sql->Query(Query, charid, createchar->m_mjob) == SQL_ERROR)
    {
        return -1;
    }

    if (settings::get<bool>("main.NEW_CHARACTER_CUTSCENE"))
    {
        Query = "INSERT INTO char_vars(charid, varname, value) VALUES(%u, '%s', %u);";
        if (sql->Query(Query, charid, "HQuest[newCharacterCS]notSeen", 1) == SQL_ERROR)
        {
            return -1;
        }
    }
    return 0;
}

int32 createCharacter(session_t& session, char* buf)
{
    auto sql = std::make_unique<SqlConnection>();
    // Seed the random number generator.
    srand(clock());
    char_mini createchar;

    std::memcpy(createchar.m_name, session.requestedNewCharacterName.c_str(), 16);

    createchar.m_look.race = ref<uint8>(buf, 48);
    createchar.m_look.size = ref<uint8>(buf, 57);
    createchar.m_look.face = ref<uint8>(buf, 60);

    // Validate that the job is a starting job.
    uint8 mjob        = ref<uint8>(buf, 50);
    createchar.m_mjob = std::clamp<uint8>(mjob, 1, 6);

    // Log that the character attempting to create a non-starting job.
    if (mjob != createchar.m_mjob)
    {
        ShowInfo(fmt::format("{} attempted to create invalid starting job {} substituting {}",
                             session.requestedNewCharacterName, mjob, createchar.m_mjob));
    }

    createchar.m_nation = ref<uint8>(buf, 54);

    std::vector<uint32> bastokStartingZones   = { 0xEA, 0xEB, 0xEC };
    std::vector<uint32> sandoriaStartingZones = { 0xE6, 0xE7, 0xE8 };
    std::vector<uint32> windurstStartingZones = { 0xEE, 0xF0, 0xF1 };

    switch (createchar.m_nation)
    {
        case 0x02: // windy start
            createchar.m_zone = windurstStartingZones[rand() % 3];
            break;
        case 0x01: // bastok start
            createchar.m_zone = bastokStartingZones[rand() % 3];
            break;
        case 0x00: // sandy start
            createchar.m_zone = sandoriaStartingZones[rand() % 3];
            break;
    }

    const char* fmtQuery = "SELECT max(charid) FROM chars";

    if (sql->Query(fmtQuery) == SQL_ERROR)
    {
        return -1;
    }

    uint32 CharID = 0;

    if (sql->NumRows() != 0)
    {
        sql->NextRow();

        CharID = sql->GetUIntData(0) + 1;
    }

    if (saveCharacter(session.accountID, CharID, &createchar) == -1)
    {
        return -1;
    }

    ShowDebug(fmt::format("char<{}> successfully saved", createchar.m_name));
    return 0;
};

// Interaction with xiloader, port 54231
class auth_session : public handler_session
{
public:
    auth_session(asio::ip::tcp::socket socket)
    : handler_session(std::move(socket))
    {
        DebugSockets("auth_session");
    }

protected:
    void read_func() override
    {
        auto newModeFlag = ref<uint8>(data_, 0) == 0xFF;
        if (!newModeFlag)
        {
            ShowDebug("Old xiloader connected. Not supported.");
            ref<uint8>(data_, 0) = LOGIN_ERROR;
            do_write(1);
            return;
        }

        auto componentFlags = ref<uint64>(data_, 1);

        if (componentFlags & AUTH_COMPONENTS::USE_TLS)
        {
            // ...
        }
        char usernameBuffer[17] = {};
        char passwordBuffer[17] = {};

        std::memcpy(usernameBuffer, data_ + 0x09, 16);
        std::memcpy(passwordBuffer, data_ + 0x19, 16);

        // std::string reservedData(data_ + 0x40, 17);
        std::string version(data_ + 0x51, 5);

        std::string username(usernameBuffer, 16);
        std::string password(passwordBuffer, 16);

        if (strncmp(version.c_str(), SUPPORTED_XILOADER_VERSION, 5) != 0)
        {
            ref<uint8>(data_, 0) = LOGIN_ERROR_VERSION_UNSUPPORTED;

            do_write(1);
            return;
        }

        int8 code = ref<uint8>(data_, 0x29);

        DebugSockets(fmt::format("auth code: {}", code));

        // data check
        if (check_string(username, 16) && check_string(password, 16))
        {
            ShowWarning("login_parse: send unreadable data");
            return;
        }
        auto sql = std::make_unique<SqlConnection>();

        char escaped_name[16 * 2 + 1] = {};
        char escaped_pass[32 * 2 + 1] = {};

        sql->EscapeString(escaped_name, username.c_str());
        sql->EscapeString(escaped_pass, password.c_str());

        username = escaped_name;
        password = escaped_pass;

        switch (code)
        {
            case LOGIN_ATTEMPT:
            {
                DebugSockets("LOGIN_ATTEMPT");

                const char* fmtQuery = "SELECT accounts.id,accounts.status \
                                    FROM accounts \
                                    WHERE accounts.login = '%s' AND accounts.password = PASSWORD('%s')";
                int32       ret      = sql->Query(fmtQuery, escaped_name, escaped_pass);
                if (ret != SQL_ERROR && sql->NumRows() != 0)
                {
                    ret = sql->NextRow();

                    uint32 accountID = sql->GetUIntData(0);
                    uint32 status    = sql->GetUIntData(1);

                    if (status & ACCOUNT_STATUS_CODE::NORMAL)
                    {
                        fmtQuery = "UPDATE accounts SET accounts.timelastmodify = NULL WHERE accounts.id = %d";
                        sql->Query(fmtQuery, accountID);
                        fmtQuery = "SELECT charid, server_addr, server_port \
                                FROM accounts_sessions JOIN accounts \
                                ON accounts_sessions.accid = accounts.id \
                                WHERE accounts.id = %d;";
                        ret      = sql->Query(fmtQuery, accountID);
                        if (ret != SQL_ERROR && sql->NumRows() == 1)
                        {
                            while (sql->NextRow() == SQL_SUCCESS)
                            {
                                uint32 charid = sql->GetUIntData(0);
                                uint64 ip     = sql->GetUIntData(1);
                                uint64 port   = sql->GetUIntData(2);

                                ip |= (port << 32);

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

                        // TODO: Lock out same account logging in multiple times. Can check data/view session existence on same IP/account?
                        // Not a real problem because the account is locked out when a character is logged in.

                        /* fmtQuery = "SELECT charid \
                                FROM accounts_sessions \
                                WHERE accid = %u LIMIT 1;";

                        if (sql->Query(fmtQuery, accountID) != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
                        {
                            // TODO: kick player out of map server if already logged in
                            // uint32 charid = sql->GetUIntData(0);

                            // This error message doesn't work when sent this way. Unknown how to transmit "1039" error message to a client already logged in.
                            // session_t& authenticatedSession = get_authenticated_session(socket_, session.sentAccountID);
                            // if (auto data = authenticatedSession.data_session)
                            // {
                            //  generateErrorMessage(data->data_, 139);
                            //  data->do_write(0x24);
                            //  return;
                            //}
                            ref<uint8>(data_, 0) = LOGIN_ERROR_ALREADY_LOGGED_IN;
                            do_write(1);
                            return;
                        }*/

                        // Success
                        std::memset(data_, 0, 49);
                        ref<uint8>(data_, 0)  = LOGIN_SUCCESS;
                        ref<uint32>(data_, 1) = accountID;

                        unsigned char hash[16];
                        uint32        hashData = std::time(0) ^ getpid();
                        md5(reinterpret_cast<uint8*>(&hashData), hash, sizeof(hashData));
                        std::memcpy(data_ + 5, hash, 16);

                        do_write(21);

                        auto& session          = get_authenticated_session(socket_, std::string(reinterpret_cast<const char*>(hash), sizeof(hash)));
                        session.accountID      = accountID;
                        session.authorizedTime = server_clock::now();
                    }
                    else if (status & ACCOUNT_STATUS_CODE::BANNED)
                    {
                        ref<uint8>(data_, 0) = LOGIN_FAIL;
                        do_write(33);
                    }
                }
                else // No account match
                {
                    ref<uint8>(data_, 0) = LOGIN_ERROR;
                    do_write(1);
                }
            }
            break;
            case LOGIN_CREATE:
            {
                ShowInfo("LOGIN_CREATE");
                // check if account creation is disabled
                if (!settings::get<bool>("login.ACCOUNT_CREATION"))
                {
                    ShowWarning(fmt::format("login_parse: New account attempt <{}> but is disabled in settings.",
                                            escaped_name));
                    ref<uint8>(data_, 0) = LOGIN_ERROR_CREATE_DISABLED;
                    do_write(1);
                    return;
                }

                // looking for same login
                if (sql->Query("SELECT accounts.id FROM accounts WHERE accounts.login = '%s'", escaped_name) == SQL_ERROR)
                {
                    ref<uint8>(data_, 0) = LOGIN_ERROR_CREATE;
                    do_write(1);
                    return;
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
                        ref<uint8>(data_, 0) = LOGIN_ERROR_CREATE;
                        do_write(1);
                        return;
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
                        ref<uint8>(data_, 0) = LOGIN_ERROR_CREATE;
                        do_write(1);
                        return;
                    }

                    ref<uint8>(data_, 0) = LOGIN_SUCCESS_CREATE;
                    do_write(1);
                    return;
                }
                else
                {
                    ref<uint8>(data_, 0) = LOGIN_ERROR_CREATE_TAKEN;
                    do_write(1);
                    return;
                }
                break;
            }
            case LOGIN_CHANGE_PASSWORD:
            {
                const char* fmtQuery = "SELECT accounts.id,accounts.status \
                                    FROM accounts \
                                    WHERE accounts.login = '%s' AND accounts.password = PASSWORD('%s')";
                int32       ret      = sql->Query(fmtQuery, escaped_name, escaped_pass);
                if (ret == SQL_ERROR || sql->NumRows() == 0)
                {
                    ShowWarning(fmt::format("login_parse: user <{}> could not be found using the provided information. Aborting.", escaped_name));
                    ref<uint8>(data_, 0) = LOGIN_ERROR;
                    do_write(1);
                    return;
                }

                ret = sql->NextRow();

                uint32 accid  = sql->GetUIntData(0);
                uint8  status = (uint8)sql->GetUIntData(1);

                if (status & ACCOUNT_STATUS_CODE::BANNED)
                {
                    ShowInfo(fmt::format("login_parse: banned user <{}> detected. Aborting.", escaped_name));
                    ref<uint8>(data_, 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                    do_write(1);
                }

                if (status & ACCOUNT_STATUS_CODE::NORMAL)
                {
                    // Account info verified, grab password
                    std::string updated_password(data_ + 0x30, 16);

                    if (updated_password == "")
                    {
                        ShowWarning(fmt::format("login_parse: Empty password; Could not update password for user <{}>.", escaped_name));
                        ref<uint8>(data_, 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                        do_write(1);
                        return;
                    }

                    char escaped_updated_password[16 * 2 + 1];
                    sql->EscapeString(escaped_updated_password, updated_password.c_str());

                    fmtQuery = "UPDATE accounts SET accounts.timelastmodify = NULL WHERE accounts.id = %d";
                    sql->Query(fmtQuery, accid);

                    fmtQuery = "UPDATE accounts SET accounts.password = PASSWORD('%s') WHERE accounts.id = %d";
                    ret      = sql->Query(fmtQuery, escaped_updated_password, accid);
                    if (ret == SQL_ERROR)
                    {
                        ShowWarning(fmt::format("login_parse: Error trying to update password in database for user <{}>.", escaped_name));
                        ref<uint8>(data_, 0) = LOGIN_ERROR_CHANGE_PASSWORD;
                        do_write(1);
                        return;
                    }

                    memset(data_, 0, 33);
                    ref<uint8>(data_, 0) = LOGIN_SUCCESS_CHANGE_PASSWORD;
                    do_write(33);

                    ShowInfo("login_parse: password updated successfully.");
                    return;
                }
            }
            break;
            default:
            {
                ShowError(fmt::format("Unhandled auth code: {}", code));
            }
            break;
        }
    }

    void write_func() override
    {
        do_read();
    }

    void handle_error(std::error_code ec, std::shared_ptr<handler_session> self) override
    {
    }
};

void PrintPacket(const char* data, uint32 size)
{
    std::string message;
    char        buffer[5];

    for (size_t y = 0; y < size; y++)
    {
        std::memset(buffer, 0, sizeof(buffer));               // TODO: Replace these three lines with std::format when/if we move to C++ 20.
        snprintf(buffer, sizeof(buffer), "%02hhx ", data[y]); //
        message.append(buffer);                               //

        if (((y + 1) % 16) == 0)
        {
            message += "\n";
            ShowDebug(message.c_str());
            message.clear();
        }
    }

    if (message.length() > 0)
    {
        message += "\n";
        ShowDebug(message.c_str());
    }
}

std::string getHashFromPacket(asio::ip::tcp::socket& socket, char* data)
{
    std::string hash   = std::string(data + 12, 16);
    std::string ip_str = socket.remote_endpoint().address().to_string();

    if (authenticatedSessions_[ip_str].find(hash) == authenticatedSessions_[ip_str].end())
    {
        return "";
    }
    return hash;
}

// Main menu (Lobby), port 54001
// A comment on the packets below, defined as macros.
//   byte 0 - packet size
//   bytes 4-7 are the packet header "IXFF" (0x49, 0x58, 0x46, 0x46)
//   byte 8 - The expected message type:
//     0x03 - positive result
//     0x04 - error (in the case of an error, a uint16 error code is used at byte 32)
//     Other
class view_session : public handler_session
{
public:
    view_session(asio::ip::tcp::socket socket)
    : handler_session(std::move(socket))
    {
        DebugSockets("view_session");
    }

protected:
    void read_func() override
    {
        uint8 code = ref<uint8>(data_, 8);

        std::string sessionHash = getHashFromPacket(socket_, data_);

        if (sessionHash == "")
        {
            ShowWarning("Session requested without valid sessionHash!");
            return;
        }
        session_t& session = get_authenticated_session(socket_, sessionHash);
        if (!session.view_session)
        {
            session.view_session = std::make_shared<view_session>(std::forward<asio::ip::tcp::socket>(socket_));
        }
        session.view_session->sessionHash = sessionHash;

        DebugSockets(fmt::format("view code: {}", code));

        switch (code)
        {
            case 0x07: // 07: "Notifying lobby server of current selections."
            {
                auto requestedCharacterID                 = ref<uint32>(data_, 28);
                char requestedCharacter[PacketNameLength] = {};
                std::memcpy(&requestedCharacter, data_ + 36, PacketNameLength - 1);

                const char* pfmtQuery = "SELECT accid FROM chars WHERE charid = %u and charname = '%s' LIMIT 1;";
                auto        sql       = std::make_unique<SqlConnection>();

                uint32 accountID = 0;
                int32  ret       = sql->Query(pfmtQuery, requestedCharacterID, requestedCharacter);
                if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
                {
                    accountID                    = sql->GetUIntData(0);
                    session.requestedCharacterID = requestedCharacterID;
                }
                else
                {
                    // TODO: what's the error code to client here?
                    /* if (auto data = session.data_session)
                    {
                        std::memset(data->data_, 0, 0x05);
                        data->data_[0] = 0x0?;
                        data->do_write(0x05);
                    }*/
                }

                if (accountID != session.accountID)
                {
                    ShowError("Client tried to login as character not in their account");
                    socket_.close();
                    return;
                }

                if (auto data = session.data_session)
                {
                    std::memset(data->data_, 0, 0x05);
                    data->data_[0] = 0x02;
                    data->do_write(0x05);
                }
            }
            break;
            case 0x14: // 20: "Deleting from lobby server"
            {
                auto sql = std::make_unique<SqlConnection>();
                if (!settings::get<bool>("login.CHARACTER_DELETION"))
                {
                    generateErrorMessage(data_, 332);
                    do_write(0x24);
                    return;
                }

                memset(data_, 0, 0x20);
                data_[0] = 0x20; // size

                data_[4] = 0x49; // I
                data_[5] = 0x58; // X
                data_[6] = 0x46; // F
                data_[7] = 0x46; // F

                data_[8] = 0x03; // result

                unsigned char hash[16];

                md5(reinterpret_cast<uint8*>(data_), hash, 0x20);
                std::memcpy(data_ + 12, hash, 16);

                do_write(0x20);

                uint32 CharID = ref<uint32>(data_, 0x20);

                ShowInfo(fmt::format("attempt to delete char:<{}> from ip:<{}>",
                                     CharID, ipAddress));

                // Perform character deletion from the database. It is sufficient to remove the
                // value from the `chars` table. The mysql server will handle the rest.

                const char* pfmtQuery = "DELETE FROM chars WHERE charid = %i AND accid = %i";
                sql->Query(pfmtQuery, CharID, session.accountID);
            }
            break;
            case 0x21: // 33: Registering character name onto the lobby server
            {
                // creating new char
                if (createCharacter(session, data_) == -1)
                {
                    socket_.close();
                    return;
                }

                session.justCreatedNewChar = true;
                ShowInfo(fmt::format("char <{}> was successfully created", session.requestedNewCharacterName));

                memset(data_, 0, 0x20);

                data_[0] = 0x20; // size

                data_[4] = 0x49; // I
                data_[5] = 0x58; // X
                data_[6] = 0x46; // F
                data_[7] = 0x46; // F

                data_[8] = 0x03; // result

                unsigned char hash[16];

                md5(reinterpret_cast<uint8*>(data_), hash, 0x20);
                std::memcpy(data_ + 12, hash, 16);

                do_write(0x20);
            }
            break;
            case 0x22: // 34: Checking name and Gold World Pass
            {
                // block creation of character if in maintenance mode
                auto maintMode = settings::get<uint8>("login.MAINT_MODE");
                if (maintMode > 0)
                {
                    generateErrorMessage(data_, 314);
                    do_write(0x24);
                    return;
                }
                else
                {
                    auto sql = std::make_unique<SqlConnection>();

                    // creating new char
                    char CharName[PacketNameLength] = {};
                    std::memcpy(CharName, data_ + 32, PacketNameLength - 1);

                    // Sanitize name
                    char escapedCharName[16 * 2 + 1];
                    sql->EscapeString(escapedCharName, CharName);

                    std::optional<std::string> invalidNameReason = std::nullopt;

                    // Check for invalid characters
                    std::string nameStr(&escapedCharName[0]);
                    for (auto letters : nameStr)
                    {
                        if (!std::isalpha(letters))
                        {
                            invalidNameReason = "Invalid characters present in name.";
                            break;
                        }
                    }

                    // Check for invalid length name
                    // NOTE: The client checks for this. This is to guard
                    // against packet injection
                    if (nameStr.size() < 3 || nameStr.size() > 15)
                    {
                        invalidNameReason = "Invalid name length.";
                    }

                    // Check if the name is already in use by another character
                    if (sql->Query("SELECT charname FROM chars WHERE charname LIKE '%s'", escapedCharName) == SQL_ERROR)
                    {
                        invalidNameReason = "Internal entity name query failed.";
                    }
                    else if (sql->NumRows() != 0)
                    {
                        invalidNameReason = "Name already in use.";
                    }

                    // (optional) Check if the name is in use by NPC or Mob entities
                    if (settings::get<bool>("login.DISABLE_MOB_NPC_CHAR_NAMES"))
                    {
                        auto query =
                            "WITH results AS "
                            "( "
                            "    SELECT polutils_name AS `name` FROM npc_list "
                            "    UNION "
                            "    SELECT packet_name AS `name` FROM mob_pools "
                            ") "
                            "SELECT * FROM results WHERE REPLACE(REPLACE(UPPER(`name`), '-', ''), '_', '') LIKE REPLACE(REPLACE(UPPER('%s'), '-', ''), '_', '');";

                        if (sql->Query(query, nameStr) == SQL_ERROR)
                        {
                            invalidNameReason = "Internal entity name query failed";
                        }
                        else if (sql->NumRows() != 0)
                        {
                            invalidNameReason = "Name already in use.";
                        }
                    }

                    // (optional) Check if the name contains any words on the bad word list
                    auto loginSettingsTable = lua["xi"]["settings"]["login"].get<sol::table>();
                    if (auto badWordsList = loginSettingsTable.get_or<sol::table>("BANNED_WORDS_LIST", sol::lua_nil); badWordsList.valid())
                    {
                        auto potentialName = to_upper(nameStr);
                        for (auto entry : badWordsList)
                        {
                            auto badWord = to_upper(entry.second.as<std::string>());
                            if (potentialName.find(badWord) != std::string::npos)
                            {
                                invalidNameReason = fmt::format("Name matched with bad words list <{}>.", badWord);
                            }
                        }
                    }

                    if (invalidNameReason.has_value())
                    {
                        ShowWarning(fmt::format("new character name error <{}>: {}", CharName, (*invalidNameReason).c_str()));

                        // Send error code:
                        // The character name you entered is unavailable. Please choose another name.
                        // TODO: This message is displayed in Japanese, needs fixing.
                        generateErrorMessage(data_, 313);
                        do_write(0x24);
                        return;
                    }
                    else
                    {
                        // copy charname
                        session.requestedNewCharacterName = CharName;

                        memset(data_, 0, 0x20);
                        data_[0] = 0x20; // size

                        data_[4] = 0x49; // I
                        data_[5] = 0x58; // X
                        data_[6] = 0x46; // F
                        data_[7] = 0x46; // F

                        data_[8] = 0x03; // result

                        unsigned char hash[16];

                        md5(reinterpret_cast<uint8*>(data_), hash, 0x20);
                        std::memcpy(data_ + 12, hash, 16);

                        do_write(0x20);
                    }
                }
            }
            break;
            case 0x26: // 38: Version + Expansions
            {
                std::string client_ver_data((data_ + 0x74), 6); // Full length is 10 but we drop last 4. This contains "E" in the english client. Perhaps this can be used as a hint for language?
                client_ver_data = client_ver_data + "xx_x";     // And then we replace those last 4
                ShowInfo(fmt::format("Version: {}", client_ver_data));

                std::string expected_version(settings::get<std::string>("login.CLIENT_VER"), 0, 6); // Same deal here!
                expected_version     = expected_version + "xx_x";
                bool versionMismatch = expected_version != client_ver_data;
                bool fatalMismatch   = false;

                if (versionMismatch)
                {
                    ShowError(fmt::format("view_session: Incorrect client version: got {}, expected {}", client_ver_data.c_str(), expected_version.c_str()));

                    switch (settings::get<uint8>("login.VER_LOCK"))
                    {
                        // enabled
                        case 1:
                            if (expected_version < client_ver_data)
                            {
                                ShowError("view_session: The server must be updated to support this client version");
                            }
                            else
                            {
                                ShowError("view_session: The client must be updated to support this server version");
                            }
                            fatalMismatch = true;
                            break;
                        // enabled greater than or equal
                        case 2:
                            if (expected_version > client_ver_data)
                            {
                                ShowError("view_session: The client must be updated to support this server version");
                                fatalMismatch = true;
                            }
                            break;
                        default:
                            // no-op - not enabled or unknown verlock type
                            break;
                    }
                }

                if (fatalMismatch)
                {
                    generateErrorMessage(data_, 331); // "The games data has been updated"
                    do_write(0x24);
                    return;
                }

                std::array<uint8, 0x28> packet = {};

                packet[0] = 0x28; // size

                packet[4] = 0x49; // I
                packet[5] = 0x58; // X
                packet[6] = 0x46; // F
                packet[7] = 0x46; // F

                packet[8] = 0x05; // result

                // Magic
                packet[28] = 0x4F;
                packet[29] = 0xE0;
                packet[30] = 0x5D;
                packet[31] = 0xAD;

                ref<uint16>(packet.data(), 32) = generateExpansionBitmask();
                ref<uint16>(packet.data(), 36) = generateFeatureBitmask();

                std::memset(data_, 0, 0x28);
                std::memcpy(data_, packet.data(), 0x28);

                // Hash the packet data and then write the value of the hash into the packet.
                unsigned char hash[16];
                md5(reinterpret_cast<uint8*>(data_), hash, 0x28);
                std::memcpy(data_ + 12, hash, 16);

                ShowInfo("view_session: Sending version and expansions info");

                if (auto data = session.view_session.get())
                {
                    std::memcpy(data->data_, data_, 0x28);
                    data->do_write(0x28);
                }
            }
            break;
            case 0x1F: // 31: "Acquiring Player Data"
            {
                // ShowInfo("Data send triggered from view");

                if (auto data = session.data_session.get())
                {
                    std::memset(data->data_, 0, 5);
                    data->data_[0] = 0x01;
                    data->do_write(0x05);
                }
                else
                {
                    generateErrorMessage(data_, 332); // "Could not connect to lobby server.\nPlease check this title's news for announcements."
                    do_write(0x24);                   // This used to error, but this case is probably not valid after sessionHash. // TODO: is this this else block still needed?
                    return;
                }
            }
            break;
            case 0x24: // 36: "Acquiring FINAL FANTASY XI server data"
            {
                std::memset(data_, 0, 0x40);
                auto serverName = settings::get<std::string>("main.SERVER_NAME");

                data_[0] = 0x40; // size

                data_[4] = 0x49; // I
                data_[5] = 0x58; // X
                data_[6] = 0x46; // F
                data_[7] = 0x46; // F

                data_[8] = 0x23; // result

                data_[28] = 0x20; // unknown
                data_[32] = 0x64; // unknown

                std::memcpy(data_ + 36, serverName.c_str(), std::clamp<size_t>(serverName.length(), 0, 15));

                unsigned char Hash[16];
                md5(reinterpret_cast<uint8*>(data_), Hash, 0x40);
                std::memcpy(data_ + 12, Hash, 16);
                if (auto data = session.view_session.get())
                {
                    std::memcpy(data->data_, data_, 0x40);
                    data->do_write(0x40);
                }
            }
            break;
        }
    }

    void write_func() override
    {
        do_read();
    }

    void handle_error(std::error_code ec, std::shared_ptr<handler_session> self) override
    {
        if (self->sessionHash != "")
        {
            auto map = authenticatedSessions_[self->ipAddress];
            auto it  = map.find(self->sessionHash);

            if (it != map.end())
            {
                session_t& session = it->second;
                if (session.view_session.get())
                {
                    session.view_session = nullptr;
                }

                if (session.data_session == nullptr && session.view_session == nullptr)
                {
                    // Remove entry if needs to be
                    map.erase(it);

                    // Remove IP from map if it's the last entry
                    if (authenticatedSessions_[self->ipAddress].size() == 1)
                    {
                        authenticatedSessions_.erase(authenticatedSessions_.begin());
                    }
                }
            }
        }
    }
};

// port 54230
class data_session : public handler_session
{
public:
    data_session(asio::ip::tcp::socket socket)
    : handler_session(std::move(socket))
    {
        DebugSockets("data_session");
    }

protected:
    void read_func() override
    {
        std::string sessionHash = getHashFromPacket(socket_, data_);

        if (sessionHash == "")
        {
            // Attempt to use stored session hash.
            sessionHash = this->sessionHash;
            if (sessionHash == "")
            {
                ShowWarning("Session requested without valid sessionHash!");
                return;
            }
        }

        session_t& session = get_authenticated_session(socket_, sessionHash);
        if (!session.data_session)
        {
            session.data_session              = std::make_shared<data_session>(std::forward<asio::ip::tcp::socket>(socket_));
            session.data_session->sessionHash = sessionHash;
        }

        uint8 code = ref<uint8>(data_, 0);
        DebugSockets(fmt::format("data code: {}", code));

        switch (code)
        {
            case 0xA1: // 161
            {
                auto   maintMode          = settings::get<uint8>("login.MAINT_MODE");
                uint32 recievedAcccountID = ref<uint32>(data_, 1);

                if (session.accountID == recievedAcccountID)
                {
                    char uList[500];
                    std::memset(uList, 0, sizeof(uList));

                    session.serverIP = ref<uint32>(data_, 5);

                    unsigned char CharList[2500];
                    std::memset(CharList, 0, sizeof(CharList));

                    // Store the reserved numbers.
                    CharList[0] = 0xE0;
                    CharList[1] = 0x08;
                    CharList[4] = 0x49;
                    CharList[5] = 0x58;
                    CharList[6] = 0x46;
                    CharList[7] = 0x46;
                    CharList[8] = 0x20;

                    auto sql = std::make_unique<SqlConnection>();

                    const char* pfmtQuery = "SELECT content_ids FROM accounts WHERE id = %u;";
                    int32       ret       = sql->Query(pfmtQuery, session.accountID);
                    if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
                    {
                        CharList[28] = sql->GetUIntData(0);
                    }
                    else
                    {
                        // TODO: throw error to client here?
                        socket_.close();
                        return;
                    }

                    pfmtQuery = "SELECT charid, charname, pos_zone, pos_prevzone, mjob,\
                        race, face, head, body, hands, legs, feet, main, sub,\
                        war, mnk, whm, blm, rdm, thf, pld, drk, bst, brd, rng,\
                        sam, nin, drg, smn, blu, cor, pup, dnc, sch, geo, run, \
                        gmlevel \
                    FROM chars \
                        INNER JOIN char_stats USING(charid)\
                        INNER JOIN char_look  USING(charid) \
                        INNER JOIN char_jobs  USING(charid) \
                        WHERE accid = %i \
                    LIMIT %u;";

                    ret = sql->Query(pfmtQuery, session.accountID, CharList[28]);
                    if (ret == SQL_ERROR)
                    {
                        socket_.close();
                        return;
                    }

                    // Prerecorded 0xA1 packet with valid data for characters beyond those which are pulled from the database
                    LOBBY_A1_RESERVEPACKET(ReservePacket);

                    // server's name that shows in lobby menu
                    auto serverName = settings::get<std::string>("main.SERVER_NAME");
                    std::memcpy(ReservePacket + 60, serverName.c_str(), std::clamp<size_t>(serverName.length(), 0, 15));

                    // Prepare the character list data..
                    for (int j = 0; j < 16; ++j)
                    {
                        std::memcpy(CharList + 32 + 140 * j, ReservePacket + 32, 140);
                        std::memset(CharList + 32 + 140 * j, 0x00, 4);
                        std::memset(uList + 16 * (j + 1), 0x00, 4);
                    }

                    uList[0] = 0x03;

                    int i = 0;
                    // Read information about a specific character.
                    // Extract all the necessary information about the character from the database.
                    while (sql->NextRow() != SQL_NO_DATA)
                    {
                        char strCharName[16] = {}; // 15 characters + null terminator
                        std::memset(strCharName, 0, sizeof(strCharName));

                        std::string dbCharName = sql->GetStringData(1);
                        std::memcpy(strCharName, dbCharName.c_str(), dbCharName.length());

                        int32 gmlevel = sql->GetIntData(36);
                        if (maintMode == 0 || gmlevel > 0)
                        {
                            uint8 worldId = 0; // Use when multiple worlds are supported.

                            uint32 charId    = sql->GetUIntData(0);
                            uint32 contentId = charId; // Reusing the character ID as the content ID (which is also the name of character folder within the USER directory) at the moment

                            // The character ID is made up of two parts totalling 24 bits:
                            uint16 charIdMain  = charId & 0xFFFF;
                            uint8  charIdExtra = (charId >> 16) & 0xFF;

                            // uList is sent through data socket (to bootloader)
                            uint32 uListOffset = 16 * (i + 1);

                            ref<uint32>(uList, uListOffset)     = contentId;
                            ref<uint16>(uList, uListOffset + 4) = charIdMain;
                            ref<uint8>(uList, uListOffset + 6)  = worldId;
                            ref<uint8>(uList, uListOffset + 7)  = charIdExtra;

                            // CharList is sent through view socket (to the FFXI client)
                            uint32 charListOffset = 32 + i * 140;

                            ref<uint32>(CharList, charListOffset)     = contentId;
                            ref<uint16>(CharList, charListOffset + 4) = charIdMain;
                            ref<uint8>(CharList, charListOffset + 6)  = worldId;
                            ref<uint8>(CharList, charListOffset + 11) = charIdExtra;

                            std::memcpy(CharList + charListOffset + 12, &strCharName, 16);
                            // Change world name when multiple worlds are supported
                            std::memcpy(CharList + charListOffset + 12 + 16, serverName.c_str(), std::clamp<size_t>(serverName.length(), 0, 15));

                            uint16 zone = static_cast<uint16>(sql->GetUIntData(2));

                            uint8 MainJob    = static_cast<uint8>(sql->GetUIntData(4));
                            uint8 lvlMainJob = static_cast<uint8>(sql->GetUIntData(13 + MainJob));

                            ref<uint8>(CharList, charListOffset + 46) = MainJob;
                            ref<uint8>(CharList, charListOffset + 73) = lvlMainJob;

                            ref<uint8>(CharList, charListOffset + 44)  = static_cast<uint8>(sql->GetUIntData(5));   // race
                            ref<uint8>(CharList, charListOffset + 56)  = static_cast<uint8>(sql->GetUIntData(6));   // face
                            ref<uint16>(CharList, charListOffset + 58) = static_cast<uint16>(sql->GetUIntData(7));  // head
                            ref<uint16>(CharList, charListOffset + 60) = static_cast<uint16>(sql->GetUIntData(8));  // body
                            ref<uint16>(CharList, charListOffset + 62) = static_cast<uint16>(sql->GetUIntData(9));  // hands
                            ref<uint16>(CharList, charListOffset + 64) = static_cast<uint16>(sql->GetUIntData(10)); // legs
                            ref<uint16>(CharList, charListOffset + 66) = static_cast<uint16>(sql->GetUIntData(11)); // feet
                            ref<uint16>(CharList, charListOffset + 68) = static_cast<uint16>(sql->GetUIntData(12)); // main
                            ref<uint16>(CharList, charListOffset + 70) = static_cast<uint16>(sql->GetUIntData(13)); // sub

                            ref<uint8>(CharList, charListOffset + 72)  = static_cast<uint8>(zone);
                            ref<uint16>(CharList, charListOffset + 78) = zone;

                            ++i;
                        }
                    }

                    // the filtering above removes any non-GM characters so
                    // at this point we need to make sure stop players with empty lists
                    // from logging in or creating new characters
                    if (maintMode > 0 && i == 0)
                    {
                        if (auto data = session.view_session.get())
                        {
                            generateErrorMessage(data->data_, 321);
                            data->do_write(0x24);
                        }
                        ShowWarning(fmt::format("char:({}) attmpted login during maintenance mode (0xA2). Sending error to client.", session.accountID));
                        return;
                    }

                    if (auto data = session.data_session.get())
                    {
                        uList[1] = 0x10;
                        std::memset(data->data_, 0, sizeof(data_));
                        std::memcpy(data->data_, uList, 0x148);
                        data->do_write(0x148);
                    }

                    if (auto data = session.view_session.get())
                    {
                        unsigned char hash[16];
                        md5((unsigned char*)(CharList), hash, 2272);
                        std::memcpy(CharList + 12, hash, 16);

                        std::memset(data->data_, 0, sizeof(data_));
                        std::memcpy(data->data_, CharList, 2272);
                        data->do_write(2272);
                    }
                }
            }
            break;
            case 0xA2: // 162 : "Notifying lobby of current selections" pt 2
            {
                LOBBY_A2_RESERVEPACKET(ReservePacket);

                // Some kind of magic
                uint8 key3[20] = {};
                std::memcpy(key3, data_ + 1, sizeof(key3));
                key3[16] -= 2;

                uint8 MainReservePacket[0x48] = {};

                if (session.accountID == 0)
                {
                    ShowWarning(fmt::format("data_session: login data corrupt (0xA2). Disconnecting client."));

                    generateErrorMessage(data_, 321);
                    do_write(0x24);
                    socket_.close();
                    return;
                }

                uint32      charid    = session.requestedCharacterID;
                uint32      accountIP = str2ip(socket_.remote_endpoint().address().to_string().c_str());
                const char* fmtQuery  = "SELECT zoneip, zoneport, zoneid, pos_prevzone, gmlevel, accid, charname \
                                             FROM zone_settings, chars \
                                             WHERE IF(pos_zone = 0, zoneid = pos_prevzone, zoneid = pos_zone) AND charid = %u AND accid = %u;";

                uint32 ZoneIP   = 0;
                uint16 ZonePort = 0;
                uint16 ZoneID   = 0;
                uint16 PrevZone = 0;
                uint16 gmlevel  = 0;

                auto sql = std::make_unique<SqlConnection>();

                if (sql->Query(fmtQuery, charid, session.accountID) != SQL_ERROR && sql->NumRows() != 0)
                {
                    sql->NextRow();

                    ZoneID   = static_cast<uint16>(sql->GetUIntData(2));
                    PrevZone = static_cast<uint16>(sql->GetUIntData(3));
                    gmlevel  = static_cast<uint16>(sql->GetUIntData(4));

                    // new char only (first login from char create)
                    if (session.justCreatedNewChar)
                    {
                        key3[16] += 6;
                    }

                    inet_pton(AF_INET, (const char*)sql->GetData(0), &ZoneIP);
                    ZonePort                           = (uint16)sql->GetUIntData(1);
                    ref<uint32>(ReservePacket, (0x38)) = ZoneIP;
                    ref<uint16>(ReservePacket, (0x3C)) = ZonePort;

                    char strCharName[PacketNameLength] = {}; // 15 characters + null terminator
                    std::memset(strCharName, 0, sizeof(strCharName));

                    std::string dbCharName = sql->GetStringData(6);
                    std::memcpy(strCharName, dbCharName.c_str(), std::clamp<size_t>(dbCharName.length(), 3, PacketNameLength - 1));

                    ref<uint32>(ReservePacket, 28) = charid;
                    ref<uint32>(ReservePacket, 32) = charid & 0xFFFF;
                    std::memcpy(ReservePacket + 32, &strCharName, 16);
                    ref<uint32>(ReservePacket, 48) = (charid >> 16) & 0xFF;

                    ShowInfo(fmt::format("data_session: zoneid:({}), zoneip:({}), zoneport:({}) for char:({})",
                                         ZoneID, ip2str(ntohl(ZoneIP)), ZonePort, charid));

                    // Check the number of sessions
                    uint16 sessionCount = 0;

                    fmtQuery = "SELECT COUNT(client_addr) \
                                FROM accounts_sessions \
                                WHERE client_addr = %u;";

                    if (sql->Query(fmtQuery, accountIP) != SQL_ERROR && sql->NumRows() != 0)
                    {
                        sql->NextRow();
                        sessionCount = (uint16)sql->GetIntData(0);
                    }

                    bool hasActiveSession = false;

                    fmtQuery = "SELECT * \
                                FROM accounts_sessions \
                                WHERE accid = %u and client_port != '0';";

                    if (sql->Query(fmtQuery, session.accountID) != SQL_ERROR && sql->NumRows() != 0)
                    {
                        sql->NextRow();
                        hasActiveSession = true;
                    }

                    fmtQuery = "SELECT UNIX_TIMESTAMP(exception) \
                                FROM ip_exceptions \
                                WHERE accid = %u;";

                    uint64 exceptionTime = 0;

                    if (sql->Query(fmtQuery, session.accountID) != SQL_ERROR && sql->NumRows() != 0)
                    {
                        sql->NextRow();
                        exceptionTime = sql->GetUInt64Data(0);
                    }

                    uint64 timeStamp    = std::chrono::duration_cast<std::chrono::seconds>(server_clock::now().time_since_epoch()).count();
                    bool   isNotMaint   = !settings::get<bool>("login.MAINT_MODE");
                    auto   loginLimit   = settings::get<uint8>("login.LOGIN_LIMIT");
                    bool   excepted     = exceptionTime > timeStamp;
                    bool   loginLimitOK = loginLimit == 0 || sessionCount < loginLimit || excepted;
                    bool   isGM         = gmlevel > 0;

                    if (!loginLimitOK)
                    {
                        ShowWarning(fmt::format("data_session: account {} attempting to login when {} already has {} active session(s), limit is {}", session.accountID, ipAddress, sessionCount, loginLimit));
                    }

                    if (hasActiveSession)
                    {
                        ShowWarning(fmt::format("data_session: account {} is already logged in.", session.accountID));
                        if (auto data = session.view_session.get())
                        {
                            // Send error message to the client.
                            generateErrorMessage(data->data_, 305); // "Unable to connect to world server. Specified operation failed"
                            data->do_write(0x24);
                            return;
                        }
                    }

                    if ((isNotMaint && loginLimitOK) || isGM)
                    {
                        if (PrevZone == 0)
                        {
                            sql->Query("UPDATE chars SET pos_prevzone = %d WHERE charid = %u;", ZoneID, charid);
                        }
                        auto searchPort                    = settings::get<uint16>("network.SEARCH_PORT");
                        ref<uint32>(ReservePacket, (0x40)) = session.serverIP; // search-server ip
                        ref<uint16>(ReservePacket, (0x44)) = searchPort;       // search-server port

                        std::memcpy(MainReservePacket, ReservePacket, ref<uint8>(ReservePacket, 0));

                        // If the session was not processed by the game server, then it must be deleted.
                        sql->Query("DELETE FROM accounts_sessions WHERE accid = %u and client_port = 0", session.accountID);

                        char session_key[sizeof(key3) * 2 + 1];
                        bin2hex(session_key, key3, sizeof(key3));

                        fmtQuery = "INSERT INTO accounts_sessions(accid,charid,session_key,server_addr,server_port,client_addr, version_mismatch) "
                                   "VALUES(%u,%u,x'%s',%u,%u,%u,%u)";

                        if (sql->Query(fmtQuery, session.accountID, charid, session_key, ZoneIP, ZonePort, accountIP,
                                       session.versionMismatch ? 1 : 0) == SQL_ERROR)
                        {
                            if (auto data = session.view_session.get())
                            {
                                // Send error message to the client.
                                generateErrorMessage(data->data_, 305); // "Unable to connect to world server. Specified operation failed"
                                data->do_write(0x24);
                                return;
                            }
                        }

                        fmtQuery = "UPDATE char_stats SET zoning = 2 WHERE charid = %u";
                        sql->Query(fmtQuery, charid);
                    }
                    else
                    {
                        if (auto data = session.view_session.get())
                        {
                            // Send error message to the client.
                            generateErrorMessage(data->data_, 321);
                            data->do_write(0x24);
                            return;
                        }
                    }
                }
                else
                {
                    if (auto data = session.view_session.get())
                    {
                        // Send error message to the client.
                        generateErrorMessage(data->data_, 305); // "Unable to connect to world server. Specified operation failed"
                        data->do_write(0x24);
                        return;
                    }
                }

                unsigned char Hash[16]     = {};
                uint8         SendBuffSize = 0x48;

                std::memset(MainReservePacket + 12, 0, 16); // Zero the hash region
                md5(MainReservePacket, Hash, SendBuffSize);

                std::memcpy(MainReservePacket + 12, Hash, sizeof(Hash));

                if (auto data = session.view_session.get())
                {
                    std::memcpy(data->data_, MainReservePacket, sizeof(MainReservePacket));
                    data->do_write(SendBuffSize);

                    data->socket_.shutdown(asio::socket_base::shutdown_both); // Client waits for us to close the socket
                    data->socket_.close();
                    session.view_session = nullptr;
                }

                if (settings::get<bool>("login.LOG_USER_IP"))
                {
                    // Log clients IP info when player spawns into map server

                    time_t rawtime;
                    tm     convertedTime;
                    time(&rawtime);
                    _localtime_s(&convertedTime, &rawtime);

                    char timeAndDate[128];
                    strftime(timeAndDate, sizeof(timeAndDate), "%Y:%m:%d %H:%M:%S", &convertedTime);

                    fmtQuery = "INSERT INTO account_ip_record(login_time,accid,charid,client_ip)\
                            VALUES ('%s', %u, %u, '%s');";

                    if (sql->Query(fmtQuery, timeAndDate, session.accountID, charid, ip2str(accountIP)) == SQL_ERROR)
                    {
                        ShowError("data_session: Could not write info to account_ip_record.");
                    }
                }

                ShowInfo(fmt::format("data_session: client {} finished work with lobbyview", ip2str(accountIP)));
            }
            break;
            case 0xFE: // 254
            {
                // Reply with nothing to keep xiloader spinning, may not be needed.
                if (auto data = session.data_session.get())
                {
                    data->do_write(0);
                }
            }
            break;
        }
    }

    void write_func() override
    {
        do_read();
    }

    void handle_error(std::error_code ec, std::shared_ptr<handler_session> self) override
    {
        if (self->sessionHash != "")
        {
            auto map = authenticatedSessions_[self->ipAddress];
            auto it  = map.find(self->sessionHash);

            if (it != map.end())
            {
                session_t& session = it->second;
                if (session.data_session.get())
                {
                    session.data_session = nullptr;
                }

                if (session.data_session == nullptr && session.view_session == nullptr)
                {
                    // Remove entry if needs to be
                    map.erase(it);

                    // Remove IP from map if it's the last entry
                    if (authenticatedSessions_[self->ipAddress].size() == 1)
                    {
                        authenticatedSessions_.erase(authenticatedSessions_.begin());
                    }
                }
            }
        }
    }
};

template <typename T>
class handler
{
public:
    handler(asio::io_context& io_context, unsigned int port)
    : acceptor_(io_context, asio::ip::tcp::endpoint(asio::ip::tcp::v4(), port))
    , socket_(io_context)
    {
        acceptor_.set_option(asio::socket_base::reuse_address(true));
        do_accept();
    }

private:
    void do_accept()
    {
        // clang-format off
        acceptor_.async_accept(socket_,
        [this](std::error_code ec)
        {
            if (!ec)
            {
                if constexpr (std::is_same_v<T, auth_session>)
                {
                    auto auth_handler = std::make_shared<T>(std::move(socket_));
                    auth_handler->start();
                }
                else if constexpr (std::is_same_v<T, view_session>)
                {
                    auto view_handler = std::make_shared<T>(std::move(socket_));
                    view_handler->start();
                }
                else if constexpr (std::is_same_v<T, data_session>)
                {
                    auto data_handler = std::make_shared<T>(std::move(socket_));
                    data_handler->start();
                }
            }
            else
            {
                ShowError(ec.message());
            }

            do_accept();
        });
        // clang-format on
    }

    asio::ip::tcp::acceptor acceptor_;
    asio::ip::tcp::socket   socket_;
};

class ConnectServer final : public Application
{
public:
    ConnectServer(int argc, char** argv)
    : Application("connect", argc, argv)
    {
        asio::io_context io_context;

        // clang-format off
        gConsoleService->RegisterCommand("stats", "Print server runtime statistics",
        [](std::vector<std::string> inputs)
        {
            size_t uniqueIPs      = authenticatedSessions_.size();
            size_t uniqueAccounts = 0;

            for (auto ipAddrMap: authenticatedSessions_)
            {
                uniqueAccounts += authenticatedSessions_[ipAddrMap.first].size();
            }
            ShowInfo("Serving %u IP addresses with %u accounts\n", uniqueIPs, uniqueAccounts);
        });

        gConsoleService->RegisterCommand("exit", "Safely close the login server",
        [&](std::vector<std::string> inputs)
        {
            m_RequestExit = true;
            io_context.stop();
            gConsoleService->stop();
        });
        // clang-format on

#ifndef _WIN32
        struct rlimit limits;

        uint32 newRLimit = 10240;

        // Get old limits
        if (getrlimit(RLIMIT_NOFILE, &limits) == 0)
        {
            // Increase open file limit, which includes sockets, to newRLimit. This only effects the current process and child processes
            limits.rlim_cur = newRLimit;
            if (setrlimit(RLIMIT_NOFILE, &limits) == -1)
            {
                ShowError("Failed to increase rlim_cur to %d", newRLimit);
            }
        }
#endif

        try
        {
            // Handler creates session of type T for specific port on connection.
            ShowInfo("creating ports");
            handler<auth_session> auth(io_context, 54231);
            handler<view_session> view(io_context, 54001);
            handler<data_session> data(io_context, 54230);
            asio::steady_timer    cleanup_callback(io_context, std::chrono::minutes(15));

            cleanup_callback.async_wait(std::bind(&ConnectServer::periodicCleanup, this, std::placeholders::_1, &cleanup_callback));

            // NOTE: io_context.run() takes over and blocks this thread. Anything after this point will only fire
            // if io_context finishes!
            ShowInfo("starting io_context");

            io_context.run();
        }
        catch (std::exception& e)
        {
            ShowError(e.what());
        }
    }

    ~ConnectServer() override
    {
        // Everything should be handled with RAII
    }

    // TODO: Currently never called. Need io_context asio::steady_timer callback with taskmgr to control timing?
    void Tick() override
    {
        Application::Tick();

        // Connect Server specific things
    }

    // This cleanup function is to periodically poll for auth sessions that were successful but xiloader failed to actually launch FFXI
    // When this happens, the data/view socket are never opened and will never be cleaned up normally.
    // Auth is closed before any other sessions are open, so the data/view cleanups aren't sufficient
    void periodicCleanup(const asio::error_code& error, asio::steady_timer* timer)
    {
        if (!error)
        {
            auto ipAddrIterator = authenticatedSessions_.begin();
            while (ipAddrIterator != authenticatedSessions_.end())
            {
                auto sessionIterator = ipAddrIterator->second.begin();
                while (sessionIterator != ipAddrIterator->second.end())
                {
                    session_t& session = sessionIterator->second;

                    // If it's been 15 minutes, erase it from the session list
                    if (!session.data_session &&
                        !session.view_session &&
                        (server_clock::now() - session.authorizedTime) > std::chrono::minutes(15))
                    {
                        sessionIterator = ipAddrIterator->second.erase(sessionIterator);
                    }
                    else
                    {
                        sessionIterator++;
                    }
                }

                // If this map entry is empty, clean it up
                if (ipAddrIterator->second.size() == 0)
                {
                    ipAddrIterator = authenticatedSessions_.erase(ipAddrIterator);
                }
                else
                {
                    ipAddrIterator++;
                }
            }

            if (Application::IsRunning())
            {
                // reset timer
                timer->expires_at(timer->expiry() + std::chrono::minutes(15));
                timer->async_wait(std::bind(&ConnectServer::periodicCleanup, this, std::placeholders::_1, timer));
            }
        }
    }
};
