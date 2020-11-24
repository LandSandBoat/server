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

#include "../common/blowfish.h"
#include "../common/md52.h"
#include "../common/showmsg.h"
#include "../common/timer.h"
#include "../common/utils.h"
#include "../common/version.h"
#include "../common/zlib.h"

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <thread>

#include "alliance.h"
#include "ability.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "utils/fishingutils.h"
#include "utils/gardenutils.h"
#include "utils/guildutils.h"
#include "utils/instanceutils.h"
#include "utils/itemutils.h"
#include "linkshell.h"
#include "map.h"
#include "mob_spell_list.h"
#include "packet_guard.h"
#include "packet_system.h"
#include "party.h"
#include "utils/petutils.h"
#include "utils/trustutils.h"
#include "roe.h"
#include "spell.h"
#include "time_server.h"
#include "transport.h"
#include "vana_time.h"
#include "status_effect_container.h"
#include "utils/zoneutils.h"
#include "conquest_system.h"
#include "daily_system.h"
#include "utils/mobutils.h"
#include "ai/controllers/automaton_controller.h"

#include "lua/luautils.h"

#include "packets/basic.h"
#include "packets/char_update.h"
#include "message.h"

#ifdef TRACY_ENABLE
void* operator new(std::size_t count)
{
    auto ptr = malloc(count);
    TracyAlloc(ptr, count);
    return ptr;
}

void operator delete(void* ptr) noexcept
{
    TracyFree(ptr);
    free(ptr);
}
#endif // TRACY_ENABLE

const char* MAP_CONF_FILENAME = nullptr;

int8*  g_PBuff = nullptr;                // глобальный буфер обмена пакетами
int8*  PTempBuff = nullptr;                // временный  буфер обмена пакетами

thread_local Sql_t* SqlHandle = nullptr;

int32  map_fd = 0;                      // main socket
uint32 map_amntplayers = 0;             // map amnt unique players

in_addr map_ip;
uint16 map_port = 0;

map_config_t map_config;                // map server settings
map_session_list_t map_session_list;
CCommandHandler CmdHandler;

std::thread messageThread;

/************************************************************************
*                                                                       *
*  mapsession_getbyipp                                                  *
*                                                                       *
************************************************************************/

map_session_data_t* mapsession_getbyipp(uint64 ipp)
{
    map_session_list_t::iterator i = map_session_list.begin();
    while (i != map_session_list.end())
    {
        if ((*i).first == ipp)
            return (*i).second;
        i++;
    }
    return nullptr;
}

/************************************************************************
*                                                                       *
*  mapsession_createsession                                             *
*                                                                       *
************************************************************************/

map_session_data_t* mapsession_createsession(uint32 ip, uint16 port)
{
    TracyZoneScoped;
    map_session_data_t* map_session_data = new map_session_data_t;
    memset(map_session_data, 0, sizeof(map_session_data_t));

    map_session_data->server_packet_data = new int8[map_config.buffer_size + 20];

    map_session_data->last_update = time(nullptr);
    map_session_data->client_addr = ip;
    map_session_data->client_port = port;

    uint64 port64 = port;
    uint64 ipp = ip;
    ipp |= port64 << 32;
    map_session_list[ipp] = map_session_data;

    const char* fmtQuery = "SELECT charid FROM accounts_sessions WHERE inet_ntoa(client_addr) = '%s' LIMIT 1;";

    int32 ret = Sql_Query(SqlHandle, fmtQuery, ip2str(map_session_data->client_addr));

    if (ret == SQL_ERROR ||
        Sql_NumRows(SqlHandle) == 0)
    {
        ShowError(CL_RED"recv_parse: Invalid login attempt from %s\n" CL_RESET, ip2str(map_session_data->client_addr));
        return nullptr;
    }
    return map_session_data;
}

/************************************************************************
*                                                                       *
*  do_init                                                              *
*                                                                       *
************************************************************************/

int32 do_init(int32 argc, char** argv)
{
    TracyZoneScoped;
    ShowStatus("do_init: begin server initialization...");
    map_ip.s_addr = 0;

    for (int i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "--ip") == 0)
        {
            uint32 ip;
            inet_pton(AF_INET, argv[i + 1], &ip);
            map_ip.s_addr = ip;
        }
        else if (strcmp(argv[i], "--port") == 0)
            map_port = std::stoi(argv[i + 1]);
    }

    MAP_CONF_FILENAME = "./conf/map.conf";

    srand((uint32)time(nullptr));
    tpzrand::seed();

    map_config_default();
    map_config_read((const int8*)MAP_CONF_FILENAME);
    map_config_from_env();
    ShowMessage("\t\t - " CL_GREEN"[OK]" CL_RESET"\n");
    ShowStatus("do_init: map_config is reading");
    ShowMessage("\t\t - " CL_GREEN"[OK]" CL_RESET"\n");

    luautils::init();
    CmdHandler.init(luautils::LuaHandle);
    PacketParserInitialize();
    SqlHandle = Sql_Malloc();

    ShowStatus("do_init: sqlhandle is allocating");
    if (Sql_Connect(SqlHandle, map_config.mysql_login.c_str(),
        map_config.mysql_password.c_str(),
        map_config.mysql_host.c_str(),
        map_config.mysql_port,
        map_config.mysql_database.c_str()) == SQL_ERROR)
    {
        do_final(EXIT_FAILURE);
    }
    Sql_Keepalive(SqlHandle);

    // отчищаем таблицу сессий при старте сервера (временное решение, т.к. в кластере это не будет работать)
    Sql_Query(SqlHandle, "DELETE FROM accounts_sessions WHERE IF(%u = 0 AND %u = 0, true, server_addr = %u AND server_port = %u);",
        map_ip.s_addr, map_port, map_ip.s_addr, map_port);

    ShowMessage("\t\t - " CL_GREEN"[OK]" CL_RESET"\n");
    ShowStatus("do_init: zlib is reading");
    zlib_init();
    ShowMessage("\t\t\t - " CL_GREEN"[OK]" CL_RESET"\n");

    messageThread = std::thread(message::init, map_config.msg_server_ip.c_str(), map_config.msg_server_port);

    ShowStatus("do_init: loading items");
    itemutils::Initialize();
    ShowMessage("\t\t\t - " CL_GREEN"[OK]" CL_RESET"\n");

    ShowStatus("do_init: loading plants");
    gardenutils::Initialize();
    ShowMessage("\t\t\t - " CL_GREEN "[OK]" CL_RESET "\n");

    // нужно будет написать один метод для инициализации всех данных в battleutils
    // и один метод для освобождения этих данных

    ShowStatus("do_init: loading spells");
    spell::LoadSpellList();
    mobSpellList::LoadMobSpellList();
    autoSpell::LoadAutomatonSpellList();
    ShowMessage("\t\t\t - " CL_GREEN"[OK]" CL_RESET"\n");

    guildutils::Initialize();
    charutils::LoadExpTable();
    traits::LoadTraitsList();
    effects::LoadEffectsParameters();
    battleutils::LoadSkillTable();
    meritNameSpace::LoadMeritsList();
    ability::LoadAbilitiesList();
    battleutils::LoadWeaponSkillsList();
    battleutils::LoadMobSkillsList();
    battleutils::LoadSkillChainDamageModifiers();
    petutils::LoadPetList();
    trustutils::LoadTrustList();
    mobutils::LoadCustomMods();
    daily::LoadDailyItems();
    roeutils::init();

    ShowStatus("do_init: loading zones");
    zoneutils::LoadZoneList();
    ShowMessage("\t\t\t - " CL_GREEN"[OK]" CL_RESET"\n");

    fishingutils::LoadFishingMessages();

    ShowStatus("do_init: server is binding with port %u", map_port == 0 ? map_config.usMapPort : map_port);
    map_fd = makeBind_udp(map_config.uiMapIp, map_port == 0 ? map_config.usMapPort : map_port);
    ShowMessage("\t - " CL_GREEN"[OK]" CL_RESET"\n");

    CVanaTime::getInstance()->setCustomEpoch(map_config.vanadiel_time_epoch);

    zoneutils::InitializeWeather(); // Need VanaTime initialized

    CTransportHandler::getInstance()->InitializeTransport();

    CTaskMgr::getInstance()->AddTask("time_server", server_clock::now(), nullptr, CTaskMgr::TASK_INTERVAL, time_server, 2400ms);
    CTaskMgr::getInstance()->AddTask("map_cleanup", server_clock::now(), nullptr, CTaskMgr::TASK_INTERVAL, map_cleanup, 5s);
    CTaskMgr::getInstance()->AddTask("garbage_collect", server_clock::now(), nullptr, CTaskMgr::TASK_INTERVAL, map_garbage_collect, 15min);

    g_PBuff = new int8[map_config.buffer_size + 20];
    PTempBuff = new int8[map_config.buffer_size + 20];

    PacketGuard::Init();

    ShowStatus("The map-server is " CL_GREEN"ready" CL_RESET" to work...\n");
    ShowMessage("=======================================================================\n");
    return 0;
}

/************************************************************************
*                                                                       *
*  do_final                                                             *
*                                                                       *
************************************************************************/

void do_final(int code)
{
    delete[] g_PBuff;
    g_PBuff = nullptr;
    delete[] PTempBuff;
    PTempBuff = nullptr;

    itemutils::FreeItemList();
    battleutils::FreeWeaponSkillsList();
    battleutils::FreeMobSkillList();

    petutils::FreePetList();
    trustutils::FreeTrustList();
    zoneutils::FreeZoneList();
    luautils::free();
    message::close();
    if (messageThread.joinable())
    {
        messageThread.join();
    }

    CTaskMgr::delInstance();
    CVanaTime::delInstance();

    Sql_Free(SqlHandle);
    SqlHandle = nullptr;

    timer_final();
    socket_final();

    exit(code);
}

/************************************************************************
*                                                                       *
*  do_abort                                                             *
*                                                                       *
************************************************************************/

void do_abort(void)
{
    do_final(EXIT_FAILURE);
}

/************************************************************************
*                                                                       *
*  set_server_type                                                      *
*                                                                       *
************************************************************************/

void set_server_type()
{
    SERVER_TYPE = TOPAZ_SERVER_MAP;
    SOCKET_TYPE = socket_type::UDP;
}

/************************************************************************
*                                                                       *
*  do_sockets                                                           *
*                                                                       *
************************************************************************/

int32 do_sockets(fd_set* rfd, duration next)
{
    struct timeval timeout;
    int32 ret;
    memcpy(rfd, &readfds, sizeof(*rfd));

    timeout.tv_sec = (long)std::chrono::duration_cast<std::chrono::seconds>(next).count();
    timeout.tv_usec = (long)std::chrono::duration_cast<std::chrono::microseconds>(next - std::chrono::duration_cast<std::chrono::seconds>(next)).count();

    ret = sSelect(fd_max, rfd, nullptr, nullptr, &timeout);

    if (ret == SOCKET_ERROR)
    {
        if (sErrno != S_EINTR)
        {
            ShowFatalError("do_sockets: select() failed, error code %d!\n", sErrno);
            do_final(EXIT_FAILURE);
        }
        return 0; // interrupted by a signal, just loop and try again
    }

    last_tick = time(nullptr);

    if (sFD_ISSET(map_fd, rfd))
    {
        struct sockaddr_in from;
        socklen_t fromlen = sizeof(from);

        int32 ret = recvudp(map_fd, g_PBuff, map_config.buffer_size, 0, (struct sockaddr*)&from, &fromlen);
        if (ret != -1)
        {
            // find player char
#   ifdef WIN32
            uint32 ip = ntohl(from.sin_addr.S_un.S_addr);
#   else
            uint32 ip = ntohl(from.sin_addr.s_addr);
#   endif

            uint64 port = ntohs(from.sin_port);
            uint64 ipp = ip;
            ipp |= port << 32;
            map_session_data_t* map_session_data = mapsession_getbyipp(ipp);

            if (map_session_data == nullptr)
            {
                map_session_data = mapsession_createsession(ip, ntohs(from.sin_port));
                if (map_session_data == nullptr)
                {
                    map_session_list.erase(ipp);
                    return -1;
                }
            }

            map_session_data->last_update = time(nullptr);
            size_t size = ret;

            if (recv_parse(g_PBuff, &size, &from, map_session_data) != -1)
            {
                // если предыдущий пакет был потерян, то мы не собираем новый,
                // а отправляем предыдущий пакет повторно
                if (!parse(g_PBuff, &size, &from, map_session_data))
                {
                    send_parse(g_PBuff, &size, &from, map_session_data);
                }

                ret = sendudp(map_fd, g_PBuff, size, 0, (const struct sockaddr*)&from, fromlen);

                int8* data = g_PBuff;
                g_PBuff = map_session_data->server_packet_data;

                map_session_data->server_packet_data = data;
                map_session_data->server_packet_size = size;
            }
            if (map_session_data->shuttingDown > 0)
            {
                map_close_session(server_clock::now(), map_session_data);
            }
        }
    }

    TracyReportLuaMemory(luautils::LuaHandle);

    return 0;
}

/************************************************************************
*                                                                       *
*  parse_console                                                        *
*                                                                       *
************************************************************************/

int32 parse_console(int8* buf)
{
    return 0;
}

/************************************************************************
*                                                                       *
*  map_decipher_packet                                                  *
*                                                                       *
************************************************************************/

int32 map_decipher_packet(int8* buff, size_t size, sockaddr_in* from, map_session_data_t* map_session_data)
{
    uint16 tmp, i;

    // counting blocks whose size = 4 byte
    tmp = (uint16)((size - FFXI_HEADER_SIZE) / 4);
    tmp -= tmp % 2;

#   ifdef WIN32
    uint32 ip = ntohl(from->sin_addr.S_un.S_addr);
#   else
    uint32 ip = ntohl(from->sin_addr.s_addr);
#   endif

    blowfish_t *pbfkey = &map_session_data->blowfish;

    for (i = 0; i < tmp; i += 2)
    {
        blowfish_decipher((uint32*)buff + i + 7, (uint32*)buff + i + 8, pbfkey->P, pbfkey->S[0]);
    }

    if (checksum((uint8*)(buff + FFXI_HEADER_SIZE), (uint32)(size - (FFXI_HEADER_SIZE + 16)), (char*)(buff + size - 16)) == 0)
    {
        return 0;
    }

    ShowError("map_encipher_packet: bad packet from <%s>\n", ip2str(ip));
    return -1;
}

/************************************************************************
*                                                                       *
*  main function to parse recv packets                                  *
*                                                                       *
************************************************************************/

int32 recv_parse(int8* buff, size_t* buffsize, sockaddr_in* from, map_session_data_t* map_session_data)
{
    size_t size = *buffsize;
    int32 checksumResult = -1;

#ifdef WIN32
    try
    {
        checksumResult = checksum((uint8*)(buff + FFXI_HEADER_SIZE), (uint32)(size - (FFXI_HEADER_SIZE + 16)), (char*)(buff + size - 16));
    }
    catch (...)
    {
        ShowError(CL_RED"Possible crash attempt from: %s\n" CL_RESET, ip2str(map_session_data->client_addr));
        return -1;
    }
#else
    checksumResult = checksum((uint8*)(buff + FFXI_HEADER_SIZE), size - (FFXI_HEADER_SIZE + 16), (char*)(buff + size - 16));
#endif

    if (checksumResult == 0)
    {
        if (map_session_data->PChar == nullptr)
        {
            uint32 CharID = ref<uint32>(buff, FFXI_HEADER_SIZE + 0x0C);

            const char* fmtQuery = "SELECT charid FROM chars WHERE charid = %u LIMIT 1;";

            int32 ret = Sql_Query(SqlHandle, fmtQuery, CharID);

            if (ret == SQL_ERROR ||
                Sql_NumRows(SqlHandle) == 0 ||
                Sql_NextRow(SqlHandle) != SQL_SUCCESS)
            {
                ShowError(CL_RED"recv_parse: Cannot load charid %u" CL_RESET, CharID);
                return -1;
            }

            fmtQuery = "SELECT session_key FROM accounts_sessions WHERE charid = %u LIMIT 1;";

            ret = Sql_Query(SqlHandle, fmtQuery, CharID);

            if (ret == SQL_ERROR ||
                Sql_NumRows(SqlHandle) == 0 ||
                Sql_NextRow(SqlHandle) != SQL_SUCCESS)
            {
                ShowError(CL_RED"recv_parse: Cannot load session_key for charid %u" CL_RESET, CharID);
            }
            else
            {
                char* strSessionKey = nullptr;
                Sql_GetData(SqlHandle, 0, &strSessionKey, nullptr);

                memcpy(map_session_data->blowfish.key, strSessionKey, 20);
            }

            // наверное создание персонажа лучше вынести в метод charutils::LoadChar() и загрузку инвентаря туда же сунуть
            CCharEntity* PChar = new CCharEntity();
            PChar->id = CharID;

            charutils::LoadChar(PChar);

            PChar->status = STATUS_DISAPPEAR;

            map_session_data->PChar = PChar;
        }
        map_session_data->client_packet_id = 0;
        map_session_data->server_packet_id = 0;
        return 0;
    }
    else
    {
        //char packets

        if (map_decipher_packet(buff, *buffsize, from, map_session_data) == -1)
        {
            *buffsize = 0;
            return -1;
        }
        // reading data size
        uint32 PacketDataSize = ref<uint32>(buff, *buffsize - sizeof(int32) - 16);
        // creating buffer for decompress data
        auto PacketDataBuff = std::make_unique<int8[]>(map_config.buffer_size);
        // it's decompressing data and getting new size
        PacketDataSize = zlib_decompress(buff + FFXI_HEADER_SIZE,
            PacketDataSize,
            PacketDataBuff.get(),
            map_config.buffer_size);

        // it's making result buff
        // don't need memcpy header
        memcpy(buff + FFXI_HEADER_SIZE, PacketDataBuff.get(), PacketDataSize);
        *buffsize = FFXI_HEADER_SIZE + PacketDataSize;

        return 0;
    }
    return -1;
}

/************************************************************************
*                                                                       *
*  main function parsing the packets                                    *
*                                                                       *
************************************************************************/

int32 parse(int8* buff, size_t* buffsize, sockaddr_in* from, map_session_data_t* map_session_data)
{
    TracyZoneScoped;
    // начало обработки входящего пакета

    int8* PacketData_Begin = &buff[FFXI_HEADER_SIZE];
    int8* PacketData_End = &buff[*buffsize];

    CCharEntity* PChar = map_session_data->PChar;

    TracyZoneIString(PChar->GetName());

    uint16 SmallPD_Size = 0;
    uint16 SmallPD_Type = 0;
    uint16 SmallPD_Code = ref<uint16>(buff, 0);

    for (int8* SmallPD_ptr = PacketData_Begin;
        SmallPD_ptr + (ref<uint8>(SmallPD_ptr, 1) & 0xFE) * 2 <= PacketData_End && (ref<uint8>(SmallPD_ptr, 1) & 0xFE);
        SmallPD_ptr = SmallPD_ptr + SmallPD_Size * 2)
    {
        SmallPD_Size = (ref<uint8>(SmallPD_ptr, 1) & 0x0FE);
        SmallPD_Type = (ref<uint16>(SmallPD_ptr, 0) & 0x1FF);

        if (PacketSize[SmallPD_Type] == SmallPD_Size || PacketSize[SmallPD_Type] == 0) // Tests incoming packets for the correct size prior to processing
        {
            // Google Translate:
            // if the code of the current package is less than or equal to the last received
            // or more global then ignore the package

            if ((ref<uint16>(SmallPD_ptr, 2) <= map_session_data->client_packet_id) ||
                (ref<uint16>(SmallPD_ptr, 2) > SmallPD_Code))
            {
                continue;
            }

            if (SmallPD_Type != 0x15)
            {
                ShowInfo("parse: %03hX | %04hX %04hX %02hX from user: %s\n", SmallPD_Type, ref<uint16>(SmallPD_ptr, 2), ref<uint16>(buff, 2), SmallPD_Size, PChar->GetName());
            }

            if (map_config.packetguard_enabled && PacketGuard::IsRateLimitedPacket(PChar, SmallPD_Type))
            {
                ShowExploit(CL_RED "[PacketGuard] Rate-limiting packet: Player: %s - Packet: %03hX\n" CL_RESET, PChar->GetName(), SmallPD_Type);
                continue; // skip this packet
            }

            if (map_config.packetguard_enabled && !PacketGuard::PacketIsValidForPlayerState(PChar, SmallPD_Type))
            {
                ShowExploit(CL_RED "[PacketGuard] Caught mismatch between player substate and recieved packet: Player: %s - Packet: %03hX\n" CL_RESET, PChar->GetName(), SmallPD_Type);
                // TODO: Plug in optional jailutils usage
                continue; // skip this packet
            }

            if (PChar->loc.zone == nullptr && SmallPD_Type != 0x0A)
            {
                ShowWarning("This packet is unexpected from %s - Received %03hX earlier without matching 0x0A\n", PChar->GetName(), SmallPD_Type);
            }
            else
            {
                PacketParser[SmallPD_Type](map_session_data, PChar, CBasicPacket(reinterpret_cast<uint8*>(SmallPD_ptr)));
            }
        }
        else
        {
            ShowWarning("Bad packet size %03hX | %04hX %04hX %02hX from user: %s\n", SmallPD_Type, ref<uint16>(SmallPD_ptr, 2), ref<uint16>(buff, 2), SmallPD_Size, PChar->GetName());
        }
    }
    map_session_data->client_packet_id = SmallPD_Code;

    // Google Translate:
    // here we check if the client received the previous package
    // if not received, then we do not create a new one, but send the previous one

    if (ref<uint16>(buff, 2) != map_session_data->server_packet_id)
    {
        ref<uint16>(map_session_data->server_packet_data, 2) = SmallPD_Code;
        ref<uint16>(map_session_data->server_packet_data, 8) = (uint32)time(nullptr);

        g_PBuff = map_session_data->server_packet_data;
        *buffsize = map_session_data->server_packet_size;

        map_session_data->server_packet_data = buff;
        return -1;
    }

    // GT: increase the number of the sent packet only if new data is sent

    map_session_data->server_packet_id += 1;

    return 0;
}

/************************************************************************
*                                                                       *
*  main function is building big packet                                 *
*                                                                       *
************************************************************************/

int32 send_parse(int8 *buff, size_t* buffsize, sockaddr_in* from, map_session_data_t* map_session_data)
{
    // Модификация заголовка исходящего пакета
    // Суть преобразований:
    //  - отправить клиенту номер последнего полученного от него пакета
    //  - присвоить исходящему пакету номер последнего отправленного клиенту пакета +1
    //  - записать текущее время отправки пакета

    ref<uint16>(buff, 0) = map_session_data->server_packet_id;
    ref<uint16>(buff, 2) = map_session_data->client_packet_id;

    // сохранение текущего времени (32 BIT!)
    ref<uint32>(buff, 8) = (uint32)time(nullptr);

    // собираем большой пакет, состоящий из нескольких маленьких
    CCharEntity *PChar = map_session_data->PChar;
    CBasicPacket* PSmallPacket;
    uint32 PacketSize = UINT32_MAX;
    auto PacketCount = PChar->getPacketCount();
    uint8 packets = 0;

    do {
        do {
            *buffsize = FFXI_HEADER_SIZE;
            PacketList_t packetList = PChar->getPacketList();
            packets = 0;

            while (!packetList.empty() && *buffsize + packetList.front()->length() < map_config.buffer_size &&
                packets < PacketCount)
            {
                PSmallPacket = packetList.front();

                PSmallPacket->sequence(map_session_data->server_packet_id);
                memcpy(buff + *buffsize, *PSmallPacket, PSmallPacket->length());

                *buffsize += PSmallPacket->length();
                packetList.pop_front();
                packets++;
            }

            PacketCount /= 2;

            //Сжимаем данные без учета заголовка
            //Возвращаемый размер в 8 раз больше реальных данных
            PacketSize = zlib_compress(buff + FFXI_HEADER_SIZE, (uint32)(*buffsize - FFXI_HEADER_SIZE), PTempBuff, map_config.buffer_size);

            // handle compression error
            if (PacketSize == static_cast<uint32>(-1))
            {
                continue;
            }

            ref<uint32>(PTempBuff, zlib_compressed_size(PacketSize)) = PacketSize;

            PacketSize = (uint32)zlib_compressed_size(PacketSize) + 4;

        } while (PacketCount > 0 && PacketSize > 1300 - FFXI_HEADER_SIZE - 16); //max size for client to accept

        if (PacketSize == static_cast<uint32>(-1))
        {
            if (PChar->getPacketCount() > 0)
            {
                PChar->erasePackets(1);
                PacketCount = PChar->getPacketCount();
            }
            else
            {
                *buffsize = 0;
                return -1;
            }
        }
    } while (PacketSize == static_cast<uint32>(-1));
    PChar->erasePackets(packets);

    //Запись размера данных без учета заголовка
    uint8 hash[16];
    md5((uint8*)PTempBuff, hash, PacketSize);
    memcpy(PTempBuff + PacketSize, hash, 16);
    PacketSize += 16;

    if (PacketSize > map_config.buffer_size + 20)
    {
        ShowFatalError(CL_RED"%Memory manager: PTempBuff is overflowed (%u)\n" CL_RESET, PacketSize);
    }

    //making total packet
    memcpy(buff + FFXI_HEADER_SIZE, PTempBuff, PacketSize);

    uint32 CypherSize = (PacketSize / 4)&-2;

    blowfish_t* pbfkey = &map_session_data->blowfish;

    for (uint32 j = 0; j < CypherSize; j += 2)
    {
        blowfish_encipher((uint32*)(buff)+j + 7, (uint32*)(buff)+j + 8, pbfkey->P, pbfkey->S[0]);
    }

    // контролируем размер отправляемого пакета. в случае,
    // если его размер превышает 1400 байт (размер данных + 42 байта IP заголовок),
    // то клиент игнорирует пакет и возвращает сообщение о его потере

    // в случае возникновения подобной ситуации выводим предупреждующее сообщение и
    // уменьшаем размер BuffMaxSize с шагом в 4 байта до ее устранения (вручную)

    *buffsize = PacketSize + FFXI_HEADER_SIZE;

    return 0;
}

/************************************************************************
*                                                                       *
*  Таймер для завершения сессии (без таймера мы этого сделать не можем, *
*  т.к. сессия продолжает использоваться в do_sockets)                  *
*                                                                       *
************************************************************************/

int32 map_close_session(time_point tick, map_session_data_t* map_session_data)
{
    if (map_session_data != nullptr &&
        map_session_data->server_packet_data != nullptr &&
        map_session_data->PChar != nullptr)
    {
        charutils::SavePlayTime(map_session_data->PChar);

        //clear accounts_sessions if character is logging out (not when zoning)
        if (map_session_data->shuttingDown == 1)
        {
            Sql_Query(SqlHandle, "DELETE FROM accounts_sessions WHERE charid = %u", map_session_data->PChar->id);
        }

        uint64 port64 = map_session_data->client_port;
        uint64 ipp = map_session_data->client_addr;
        ipp |= port64 << 32;

        map_session_data->PChar->StatusEffectContainer->SaveStatusEffects(map_session_data->shuttingDown == 1);

        delete[] map_session_data->server_packet_data;
        delete map_session_data->PChar;
        delete map_session_data;
        map_session_data = nullptr;

        map_session_list.erase(ipp);
        return 0;
    }

    ShowError(CL_RED"map_close_session: cannot close session, session not found\n" CL_RESET);
    return 1;
}

/************************************************************************
*                                                                       *
*  Timer function that clenup all timed out players                     *
*                                                                       *
************************************************************************/

int32 map_cleanup(time_point tick, CTaskMgr::CTask* PTask)
{
    TracyZoneScoped;
    map_session_list_t::iterator it = map_session_list.begin();

    while (it != map_session_list.end())
    {
        map_session_data_t* map_session_data = it->second;

        CCharEntity* PChar = map_session_data->PChar;

        if ((time(nullptr) - map_session_data->last_update) > 5)
        {
            if (PChar != nullptr && !(PChar->nameflags.flags & FLAG_DC))
            {

                PChar->nameflags.flags |= FLAG_DC;
                PChar->updatemask |= UPDATE_HP;
                if (PChar->status == STATUS_NORMAL)
                {
                    PChar->loc.zone->SpawnPCs(PChar);
                }
            }
            if ((time(nullptr) - map_session_data->last_update) > map_config.max_time_lastupdate)
            {
                if (PChar != nullptr)
                {
                    if (map_session_data->shuttingDown == 0)
                    {
                        //[Alliance] fix to stop server crashing:
                        //if a party within an alliance only has 1 char (that char will be party leader)
                        //if char then disconnects we need to tell the server about the alliance change
                        if (PChar->PParty != nullptr && PChar->PParty->m_PAlliance != nullptr && PChar->PParty->GetLeader() == PChar)
                        {
                            if (PChar->PParty->members.size() == 1)
                            {
                                if (PChar->PParty->m_PAlliance->partyList.size() == 1)
                                {
                                    PChar->PParty->m_PAlliance->dissolveAlliance();
                                }
                                else
                                {
                                    PChar->PParty->m_PAlliance->removeParty(PChar->PParty);
                                }
                            }
                        }


                        // uncharm pet if player d/c
                        if (PChar->PPet != nullptr && PChar->PPet->objtype == TYPE_MOB)
                        {
                            petutils::DespawnPet(PChar);
                        }

                        PChar->StatusEffectContainer->SaveStatusEffects(true);
                        charutils::SaveCharPosition(PChar);

                        ShowDebug(CL_CYAN"map_cleanup: %s timed out, closing session\n" CL_RESET, PChar->GetName());

                        PChar->status = STATUS_SHUTDOWN;
                        PacketParser[0x00D](map_session_data, PChar, 0);
                    }
                    else
                    {
                        map_session_data->PChar->StatusEffectContainer->SaveStatusEffects(true);
                        Sql_Query(SqlHandle, "DELETE FROM accounts_sessions WHERE charid = %u;", map_session_data->PChar->id);

                        delete[] map_session_data->server_packet_data;
                        delete map_session_data->PChar;
                        delete map_session_data;
                        map_session_data = nullptr;

                        map_session_list.erase(it++);
                        continue;
                    }
                }
                else if (map_session_data->shuttingDown == 0)
                {

                    ShowWarning(CL_YELLOW"map_cleanup: WHITHOUT CHAR timed out, session closed\n" CL_RESET);

                    const char* Query = "DELETE FROM accounts_sessions WHERE client_addr = %u AND client_port = %u";
                    Sql_Query(SqlHandle, Query, map_session_data->client_addr, map_session_data->client_port);

                    delete[] map_session_data->server_packet_data;
                    map_session_list.erase(it++);
                    delete map_session_data;
                    continue;
                }
            }
        }
        else if (PChar != nullptr && (PChar->nameflags.flags & FLAG_DC))
        {
            PChar->nameflags.flags &= ~FLAG_DC;
            PChar->updatemask |= UPDATE_HP;

            if (PChar->status == STATUS_NORMAL)
            {
                PChar->loc.zone->SpawnPCs(PChar);
            }
            charutils::SaveCharStats(PChar);
        }
        ++it;
    }
    return 0;
}

/************************************************************************
*                                                                       *
*  Map-Server Version Screen [venom]                                    *
*                                                                       *
************************************************************************/

void map_helpscreen(int32 flag)
{
    ShowMessage("Usage: map-server [options]\n");
    ShowMessage("Options:\n");
    ShowMessage(CL_WHITE"  Commands\t\t\tDescription\n" CL_RESET);
    ShowMessage("-----------------------------------------------------------------------------\n");
    ShowMessage("  --help, --h, --?, /?     Displays this help screen\n");
    ShowMessage("  --map-config <file>      Load map-server configuration from <file>\n");
    ShowMessage("  --version, --v, -v, /v   Displays the server's version\n");
    ShowMessage("\n");
    if (flag)
    {
        exit(EXIT_FAILURE);
    }
}

/************************************************************************
*                                                                       *
*  Map-Server Version Screen [venom]                                    *
*                                                                       *
************************************************************************/

void map_versionscreen(int32 flag)
{
    ShowInfo(CL_WHITE "Topaz version %d.%02d.%02d" CL_RESET"\n",
        TOPAZ_MAJOR_VERSION, TOPAZ_MINOR_VERSION, TOPAZ_REVISION);
    if (flag)
    {
        exit(EXIT_FAILURE);
    }
}

/************************************************************************
*                                                                       *
*  map_config_default                                                   *
*                                                                       *
************************************************************************/

int32 map_config_default()
{
    map_config.uiMapIp = INADDR_ANY;
    map_config.usMapPort = 54230;
    map_config.mysql_host = "127.0.0.1";
    map_config.mysql_login = "root";
    map_config.mysql_password = "root";
    map_config.mysql_database = "tpzdb";
    map_config.mysql_port = 3306;
    map_config.server_message = "";
    map_config.buffer_size = 1800;
    map_config.ah_base_fee_single = 1;
    map_config.ah_base_fee_stacks = 4;
    map_config.ah_tax_rate_single = 1.0;
    map_config.ah_tax_rate_stacks = 0.5;
    map_config.ah_max_fee = 10000;
    map_config.ah_list_limit = 7;
    map_config.exp_rate = 1.0f;
    map_config.exp_loss_rate = 1.0f;
    map_config.exp_retain = 0.0f;
    map_config.exp_loss_level = 4;
    map_config.level_sync_enable = 0;
    map_config.disable_gear_scaling = 0;
    map_config.all_jobs_widescan = 1;
    map_config.speed_mod = 0;
    map_config.mount_speed_mod = 0;
    map_config.mob_speed_mod = 0;
    map_config.skillup_chance_multiplier = 1.0f;
    map_config.craft_chance_multiplier = 1.0f;
    map_config.skillup_amount_multiplier = 1;
    map_config.craft_amount_multiplier = 1;
    map_config.garden_day_matters = false;
    map_config.garden_moonphase_matters = false;
    map_config.garden_pot_matters = false;
    map_config.garden_mh_aura_matters = false;
    map_config.craft_common_cap = 700;
    map_config.craft_specialization_points = 400;
    map_config.mob_tp_multiplier = 1.0f;
    map_config.player_tp_multiplier = 1.0f;
    map_config.nm_hp_multiplier = 1.0f;
    map_config.mob_hp_multiplier = 1.0f;
    map_config.player_hp_multiplier = 1.0f;
    map_config.alter_ego_hp_multiplier = 1.0f;
    map_config.nm_mp_multiplier = 1.0f;
    map_config.mob_mp_multiplier = 1.0f;
    map_config.player_mp_multiplier = 1.0f;
    map_config.alter_ego_mp_multiplier = 1.0f;
    map_config.sj_mp_divisor = 2.0f;
    map_config.subjob_ratio = 1;
    map_config.include_mob_sj = false;
    map_config.nm_stat_multiplier = 1.0f;
    map_config.mob_stat_multiplier = 1.0f;
    map_config.player_stat_multiplier = 1.0f;
    map_config.alter_ego_stat_multiplier = 1.0f;
    map_config.alter_ego_skill_multiplier = 1.0f;
    map_config.ability_recast_multiplier = 1.0f;
    map_config.blood_pact_shared_timer = 0;
    map_config.vanadiel_time_epoch = 0;
    map_config.lightluggage_block = 4;
    map_config.packetguard_enabled = false;
    map_config.max_time_lastupdate = 60000;
    map_config.newstyle_skillups = 7;
    map_config.drop_rate_multiplier = 1.0f;
    map_config.mob_gil_multiplier = 1.0f;
    map_config.all_mobs_gil_bonus = 0;
    map_config.max_gil_bonus = 9999;
    map_config.Battle_cap_tweak = 0;
    map_config.lv_cap_mission_bcnm = 0;
    map_config.max_merit_points = 30;
    map_config.yell_cooldown = 30;
    map_config.audit_gm_cmd = 0;
    map_config.audit_chat = 0;
    map_config.audit_say = 0;
    map_config.audit_shout = 0;
    map_config.audit_tell = 0;
    map_config.audit_yell = 0;
    map_config.audit_party = 0;
    map_config.audit_linkshell = 0;
    map_config.msg_server_port = 54003;
    map_config.msg_server_ip = "127.0.0.1";
    map_config.healing_tick_delay = 10;
    map_config.skillup_bloodpact = true;
    map_config.anticheat_enabled = false;
    map_config.anticheat_jail_disable = false;
    map_config.daily_tally_amount = 10;
    map_config.daily_tally_limit = 50000;
    return 0;
}

int32 map_config_from_env()
{
    map_config.mysql_login     = std::getenv("TPZ_DB_USER") ? std::getenv("TPZ_DB_USER") : map_config.mysql_login;
    map_config.mysql_password  = std::getenv("TPZ_DB_USER_PASSWD") ? std::getenv("TPZ_DB_USER_PASSWD") : map_config.mysql_password;
    map_config.mysql_host      = std::getenv("TPZ_DB_HOST") ? std::getenv("TPZ_DB_HOST") : map_config.mysql_host;
    map_config.mysql_port      = std::getenv("TPZ_DB_PORT") ? std::stoi(std::getenv("TPZ_DB_PORT")) : map_config.mysql_port;
    map_config.mysql_database  = std::getenv("TPZ_DB_NAME") ? std::getenv("TPZ_DB_NAME") : map_config.mysql_database;
    map_config.msg_server_ip   = std::getenv("TPZ_MSG_IP") ? std::getenv("TPZ_MSG_IP") : map_config.msg_server_ip;
    map_config.msg_server_port = std::getenv("TPZ_MSG_PORT") ? std::stoi(std::getenv("TPZ_MSG_PORT")) : map_config.msg_server_port;
    return 0;
}

/************************************************************************
*                                                                       *
*  Map-Server Config [venom]                                            *
*                                                                       *
************************************************************************/

int32 map_config_read(const int8* cfgName)
{
    char line[1024], w1[1024], w2[1024];
    FILE* fp;

    fp = fopen((const char*)cfgName, "r");
    if (fp == nullptr)
    {
        ShowError("Map configuration file not found at: %s\n", cfgName);
        return 1;
    }

    while (fgets(line, sizeof(line), fp))
    {
        char* ptr;

        if (line[0] == '#')
        {
            continue;
        }
        if (sscanf(line, "%[^:]: %[^\t\r\n]", w1, w2) < 2)
        {
            continue;
        }

        //Strip trailing spaces
        ptr = w2 + strlen(w2);
        while (--ptr >= w2 && *ptr == ' ');
        ptr++;
        *ptr = '\0';

        if (strcmpi(w1, "timestamp_format") == 0)
        {
            strncpy(timestamp_format, w2, 20);
        }
        else if (strcmpi(w1, "stdout_with_ansisequence") == 0)
        {
            stdout_with_ansisequence = config_switch(w2);
        }
        else if (strcmpi(w1, "console_silent") == 0)
        {
            //ShowInfo("Console Silent Setting: %d", atoi(w2));
            msg_silent = atoi(w2);
        }
        else if (strcmpi(w1, "map_port") == 0)
        {
            map_config.usMapPort = (atoi(w2));
        }
        else if (strcmp(w1, "buff_maxsize") == 0)
        {
            map_config.buffer_size = atoi(w2);
        }
        else if (strcmp(w1, "max_time_lastupdate") == 0)
        {
            map_config.max_time_lastupdate = atoi(w2);
        }
        else if (strcmp(w1, "vanadiel_time_epoch") == 0)
        {
            map_config.vanadiel_time_epoch = atoi(w2);
        }
        else if (strcmp(w1, "fame_multiplier") == 0)
        {
            map_config.fame_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "lightluggage_block") == 0)
        {
            map_config.lightluggage_block = atoi(w2);
        }
        else if (strcmp(w1, "packetguard_enabled") == 0)
        {
            map_config.packetguard_enabled = atoi(w2);
        }
        else if (strcmp(w1, "ah_base_fee_single") == 0)
        {
            map_config.ah_base_fee_single = atoi(w2);
        }
        else if (strcmp(w1, "ah_base_fee_stacks") == 0)
        {
            map_config.ah_base_fee_stacks = atoi(w2);
        }
        else if (strcmp(w1, "ah_tax_rate_single") == 0)
        {
            map_config.ah_tax_rate_single = (float)atof(w2);
        }
        else if (strcmp(w1, "ah_tax_rate_stacks") == 0)
        {
            map_config.ah_tax_rate_stacks = (float)atof(w2);
        }
        else if (strcmp(w1, "ah_max_fee") == 0)
        {
            map_config.ah_max_fee = atoi(w2);
        }
        else if (strcmp(w1, "ah_list_limit") == 0)
        {
            map_config.ah_list_limit = atoi(w2);
        }
        else if (strcmp(w1, "exp_rate") == 0)
        {
            map_config.exp_rate = (float)atof(w2);
        }
        else if (strcmp(w1, "exp_loss_rate") == 0)
        {
            map_config.exp_loss_rate = (float)atof(w2);
        }
        else if (strcmp(w1, "exp_party_gap_penalties") == 0)
        {
            map_config.exp_party_gap_penalties = (uint8)atof(w2);
        }
        else if (strcmp(w1, "mob_tp_multiplier") == 0)
        {
            map_config.mob_tp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "player_tp_multiplier") == 0)
        {
            map_config.player_tp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "nm_hp_multiplier") == 0)
        {
            map_config.nm_hp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "mob_hp_multiplier") == 0)
        {
            map_config.mob_hp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "player_hp_multiplier") == 0)
        {
            map_config.player_hp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "alter_ego_hp_multiplier") == 0)
        {
            map_config.alter_ego_hp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "nm_mp_multiplier") == 0)
        {
            map_config.nm_mp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "mob_mp_multiplier") == 0)
        {
            map_config.mob_mp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "player_mp_multiplier") == 0)
        {
            map_config.player_mp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "alter_ego_mp_multiplier") == 0)
        {
            map_config.alter_ego_mp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "sj_mp_divisor") == 0)
        {
            map_config.sj_mp_divisor = (float)atof(w2);
        }
        else if (strcmp(w1, "subjob_ratio") == 0)
        {
            map_config.subjob_ratio = atoi(w2);
        }
        else if (strcmp(w1, "include_mob_sj") == 0)
        {
            map_config.include_mob_sj = atoi(w2);
        }
        else if (strcmp(w1, "nm_stat_multiplier") == 0)
        {
            map_config.nm_stat_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "mob_stat_multiplier") == 0)
        {
            map_config.mob_stat_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "player_stat_multiplier") == 0)
        {
            map_config.player_stat_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "alter_ego_stat_multiplier") == 0)
        {
            map_config.alter_ego_stat_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "alter_ego_skill_multiplier") == 0)
        {
            map_config.alter_ego_skill_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "ability_recast_multiplier") == 0)
        {
            map_config.ability_recast_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "blood_pact_shared_timer") == 0)
        {
            map_config.blood_pact_shared_timer = atoi(w2);
        }
        else if (strcmp(w1, "drop_rate_multiplier") == 0)
        {
            map_config.drop_rate_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "mob_gil_multiplier") == 0)
        {
            map_config.mob_gil_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "all_mobs_gil_bonus") == 0)
        {
            map_config.all_mobs_gil_bonus = atoi(w2);
        }
        else if (strcmp(w1, "max_gil_bonus") == 0)
        {
            map_config.max_gil_bonus = atoi(w2);
        }
        else if (strcmp(w1, "exp_retain") == 0)
        {
            map_config.exp_retain = std::clamp<float>((float)atof(w2), 0.0f, 1.0f);
        }
        else if (strcmp(w1, "exp_loss_level") == 0)
        {
            map_config.exp_loss_level = atoi(w2);
        }
        else if (strcmp(w1, "level_sync_enable") == 0)
        {
            map_config.level_sync_enable = atoi(w2);
        }
        else if (strcmp(w1, "disable_gear_scaling") == 0)
        {
            map_config.disable_gear_scaling = atoi(w2);
        }
        else if (strcmp(w1, "all_jobs_widescan") == 0)
        {
            map_config.all_jobs_widescan = atoi(w2);
        }
        else if (strcmp(w1, "speed_mod") == 0)
        {
            map_config.speed_mod = atoi(w2);
        }
        else if (strcmp(w1, "mount_speed_mod") == 0)
        {
            map_config.mount_speed_mod = atoi(w2);
        }
        else if (strcmp(w1, "mob_speed_mod") == 0)
        {
            map_config.mob_speed_mod = atoi(w2);
        }
        else if (strcmp(w1, "skillup_chance_multiplier") == 0)
        {
            map_config.skillup_chance_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "craft_chance_multiplier") == 0)
        {
            map_config.craft_chance_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "skillup_amount_multiplier") == 0)
        {
            map_config.skillup_amount_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "craft_amount_multiplier") == 0)
        {
            map_config.craft_amount_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "craft_common_cap") == 0)
        {
            map_config.craft_common_cap = atoi(w2);
        }
        else if (strcmp(w1, "craft_specialization_points") == 0)
        {
            map_config.craft_specialization_points = atoi(w2);
        }
        else if (strcmp(w1, "garden_day_matters") == 0)
        {
            map_config.garden_day_matters = atof(w2);
        }
        else if (strcmp(w1, "garden_moonphase_matters") == 0)
        {
            map_config.garden_moonphase_matters = atof(w2);
        }
        else if (strcmp(w1, "garden_pot_matters") == 0)
        {
            map_config.garden_pot_matters = atof(w2);
        }
        else if (strcmp(w1, "garden_mh_aura_matters") == 0)
        {
            map_config.garden_mh_aura_matters = atof(w2);
        }
        else if (strcmp(w1, "mysql_host") == 0)
        {
            map_config.mysql_host = std::string(w2);
        }
        else if (strcmp(w1, "mysql_login") == 0)
        {
            map_config.mysql_login = std::string(w2);
        }
        else if (strcmp(w1, "mysql_password") == 0)
        {
            map_config.mysql_password = std::string(w2);
        }
        else if (strcmp(w1, "mysql_port") == 0)
        {
            map_config.mysql_port = atoi(w2);
        }
        else if (strcmp(w1, "mysql_database") == 0)
        {
            map_config.mysql_database = std::string(w2);
        }
        else if (strcmpi(w1, "import") == 0)
        {
            map_config_read((const int8*)w2);
        }
        else if (strcmpi(w1, "newstyle_skillups") == 0)
        {
            map_config.newstyle_skillups = atoi(w2);
        }
        else if (strcmp(w1, "Battle_cap_tweak") == 0)
        {
            map_config.Battle_cap_tweak = atoi(w2);
        }
        else if (strcmp(w1, "lv_cap_mission_bcnm") == 0)
        {
            map_config.lv_cap_mission_bcnm = atoi(w2);
        }
        else if (strcmp(w1, "max_merit_points") == 0)
        {
            map_config.max_merit_points = atoi(w2);
        }
        else if (strcmp(w1, "yell_cooldown") == 0)
        {
            map_config.yell_cooldown = atoi(w2);
        }
        else if (strcmp(w1, "audit_gm_cmd") == 0)
        {
            map_config.audit_gm_cmd = atoi(w2);
        }
        else if (strcmp(w1, "audit_chat") == 0)
        {
            map_config.audit_chat = atoi(w2);
        }
        else if (strcmp(w1, "audit_say") == 0)
        {
            map_config.audit_say = atoi(w2);
        }
        else if (strcmp(w1, "audit_shout") == 0)
        {
            map_config.audit_shout = atoi(w2);
        }
        else if (strcmp(w1, "audit_tell") == 0)
        {
            map_config.audit_tell = atoi(w2);
        }
        else if (strcmp(w1, "audit_yell") == 0)
        {
            map_config.audit_yell = atoi(w2);
        }
        else if (strcmp(w1, "audit_linkshell") == 0)
        {
            map_config.audit_linkshell = atoi(w2);
        }
        else if (strcmp(w1, "audit_party") == 0)
        {
            map_config.audit_party = atoi(w2);
        }
        else if (strcmp(w1, "msg_server_port") == 0)
        {
            map_config.msg_server_port = atoi(w2);
        }
        else if (strcmp(w1, "msg_server_ip") == 0)
        {
            map_config.msg_server_ip = std::string(w2);
        }
        else if (strcmp(w1, "mob_no_despawn") == 0)
        {
            map_config.mob_no_despawn = atoi(w2);
        }
        else if (strcmp(w1, "healing_tick_delay") == 0)
        {
            map_config.healing_tick_delay = atoi(w2);
        }
        else if (strcmp(w1, "skillup_bloodpact") == 0)
        {
            map_config.skillup_bloodpact = atoi(w2);
        }
        else if (strcmp(w1, "anticheat_enabled") == 0)
        {
            map_config.anticheat_enabled = atoi(w2);
        }
        else if (strcmp(w1, "anticheat_jail_disable") == 0)
        {
            map_config.anticheat_jail_disable = atoi(w2);
        }
        else if (strcmp(w1, "daily_tally_amount") == 0)
        {
            map_config.daily_tally_amount = atoi(w2);
        }
        else if (strcmp(w1, "daily_tally_limit") == 0)
        {
            map_config.daily_tally_limit = atoi(w2);
        }
        else
        {
            ShowWarning(CL_YELLOW"Unknown setting '%s' in file %s\n" CL_RESET, w1, cfgName);
        }
    }

    fclose(fp);

    // Load the English server message..
    fp = fopen("./conf/server_message.conf", "rb");
    if (fp == nullptr)
    {
        ShowError("Could not read English server message from: ./conf/server_message.conf\n");
        return 1;
    }

    while (fgets(line, sizeof(line), fp))
    {
        string_t sline(line);
        map_config.server_message += sline;
    }

    fclose(fp);

    // Ensure both messages have nullptr terminates..
    if (map_config.server_message.at(map_config.server_message.length() - 1) != 0x00)
    {
        map_config.server_message += (char)0x00;
    }

    return 0;
}

int32 map_garbage_collect(time_point tick, CTaskMgr::CTask* PTask)
{
    TracyZoneScoped;
    luautils::garbageCollect();
    return 0;
}

void log_init(int argc, char** argv)
{
    std::string logFile;
#ifdef DEBUGLOGMAP
#ifdef WIN32
    logFile = "log\\map-server.log";
#else
    logFile = "log/map-server.log";
#endif
#endif
    bool defaultname = true;
    for (int i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "--ip") == 0 && defaultname)
        {
            logFile = argv[i + 1];
        }
        else if (strcmp(argv[i], "--port") == 0 && defaultname)
        {
            logFile.append(argv[i + 1]);
        }
        else if (strcmp(argv[i], "--log") == 0)
        {
            defaultname = false;
            logFile = argv[i + 1];
        }
    }
    InitializeLog(logFile);
}
