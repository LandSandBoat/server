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

#include <thread>

#include "../common/blowfish.h"
#include "../common/cbasetypes.h"
#include "../common/md52.h"
#include "../common/mmo.h"
#include "../common/showmsg.h"
#include "../common/socket.h"
#include "../common/sql.h"
#include "../common/taskmgr.h"
#include "../common/timer.h"
#include "../common/utils.h"

#ifdef WIN32
#include <winsock2.h>
#include <ws2tcpip.h>
#else
#include <cerrno>
#include <netdb.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
typedef u_int SOCKET;
#define INVALID_SOCKET (SOCKET)(~0)
#define SOCKET_ERROR   (-1)
#endif

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <sstream>

#include "data_loader.h"
#include "search.h"
#include "tcp_request.h"

#include "packets/auction_history.h"
#include "packets/auction_list.h"
#include "packets/linkshell_list.h"
#include "packets/party_list.h"
#include "packets/search_list.h"

#define DEFAULT_BUFLEN 1024
#define CODE_LVL       17
#define CODE_JOB       13
#define CODE_ZONE      20
#define CODE_ZONE_ALL  16

struct SearchCommInfo
{
    SOCKET socket;
    uint32 ip;
    uint16 port;
};

void TaskManagerThread();

int32 ah_cleanup(time_point tick, CTaskMgr::CTask* PTask);

const char* SEARCH_CONF_FILENAME = "./conf/search_server.conf";
const char* LOGIN_CONF_FILENAME  = "./conf/login.conf";

void TCPComm(SOCKET socket);

extern void        HandleSearchRequest(CTCPRequestPacket& PTCPRequest);
extern void        HandleSearchComment(CTCPRequestPacket& PTCPRequest);
extern void        HandleGroupListRequest(CTCPRequestPacket& PTCPRequest);
extern void        HandleAuctionHouseHistory(CTCPRequestPacket& PTCPRequest);
extern void        HandleAuctionHouseRequest(CTCPRequestPacket& PTCPRequest);
extern search_req  _HandleSearchRequest(CTCPRequestPacket& PTCPRequest);
extern std::string toStr(int number);

search_config_t search_config;
login_config_t  login_config;

void search_config_default();
void search_config_read(const int8* file);
void search_config_read_from_env();

void login_config_default();
void login_config_read(const int8* file); // We only need the search server port defined here
void login_config_read_from_env();

/************************************************************************
 *                                                                       *
 *  Prints the contents of the packet in `data` to the console.          *
 *                                                                       *
 ************************************************************************/

void PrintPacket(char* data, int size)
{
    char message[50];
    memset(&message, 0, 50);

    printf("\n");

    for (int32 y = 0; y < size; y++)
    {
        char msgtmp[50];
        memset(&msgtmp, 0, 50);
        std::snprintf(msgtmp, sizeof(msgtmp), "%s %02x", message, (uint8)data[y]);
        strncpy(message, msgtmp, 50);
        if (((y + 1) % 16) == 0)
        {
            message[48] = '\n';
            fputs(message, stdout);
            memset(&message, 0, 50);
        }
    }
    if (strlen(message) > 0)
    {
        message[strlen(message)] = '\n';
        fputs(message, stdout);
    }
    printf("\n");
}

int32 main(int32 argc, char** argv)
{
#ifdef WIN32
    WSADATA wsaData;
#endif

    std::string logFile;

#ifdef WIN32
    logFile = "log\\search-server.log";
#else
    logFile = "log/search-server.log";
#endif

    for (int i = 0; i < argc; i++)
    {
        if (strcmp(argv[i], "--log") == 0)
        {
            logFile = argv[i + 1];
        }
    }

    InitializeLog(logFile);

    int iResult;

    SOCKET ListenSocket = INVALID_SOCKET;
    SOCKET ClientSocket = INVALID_SOCKET;

    struct addrinfo* result = nullptr;
    struct addrinfo  hints;

    search_config_default();
    search_config_read((const int8*)SEARCH_CONF_FILENAME);
    search_config_read_from_env();
    login_config_read((const int8*)LOGIN_CONF_FILENAME);
    login_config_read_from_env();

#ifdef WIN32
    // Initialize Winsock
    iResult = WSAStartup(MAKEWORD(2, 2), &wsaData);
    if (iResult != 0)
    {
        ShowError("WSAStartup failed with error: %d\n", iResult);
        return 1;
    }

    ZeroMemory(&hints, sizeof(hints));
#else
    memset(&hints, 0, sizeof(hints));
#endif

    hints.ai_family   = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;
    hints.ai_flags    = AI_PASSIVE;

    // Resolve the server address and port
    iResult = getaddrinfo(nullptr, login_config.search_server_port.c_str(), &hints, &result);
    if (iResult != 0)
    {
        ShowError("getaddrinfo failed with error: %d\n", iResult);
#ifdef WIN32
        WSACleanup();
#endif
        return 1;
    }

    // Create a SOCKET for connecting to server
    ListenSocket = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
    if (ListenSocket == INVALID_SOCKET)
    {
#ifdef WIN32
        ShowError("socket failed with error: %ld\n", WSAGetLastError());
        freeaddrinfo(result);
        WSACleanup();
#else
        ShowError("socket failed with error: %ld\n", errno);
        freeaddrinfo(result);
#endif
        return 1;
    }

    // Setup the TCP listening socket
    iResult = bind(ListenSocket, result->ai_addr, (int)result->ai_addrlen);
    if (iResult == SOCKET_ERROR)
    {
#ifdef WIN32
        ShowError("bind failed with error: %d\n", WSAGetLastError());
        freeaddrinfo(result);
        closesocket(ListenSocket);
        WSACleanup();
#else
        ShowError("bind failed with error: %d\n", errno);
        freeaddrinfo(result);
        close(ListenSocket);
#endif
        return 1;
    }

    freeaddrinfo(result);

    iResult = listen(ListenSocket, SOMAXCONN);
    if (iResult == SOCKET_ERROR)
    {
#ifdef WIN32
        ShowError("listen failed with error: %d\n", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
#else
        ShowError("listen failed with error: %d\n", errno);
        close(ListenSocket);
#endif
        return 1;
    }

    ShowMessage(CL_WHITE "========================================================\n\n" CL_RESET);
    ShowMessage(CL_WHITE "topaz_search\n\n");
    ShowMessage(CL_WHITE "========================================================\n\n" CL_RESET);
    if (search_config.expire_auctions == 1)
    {
        ShowMessage(CL_GREEN "AH task to return items older than %u days is running\n" CL_RESET, search_config.expire_days);
        CTaskMgr::getInstance()->AddTask("ah_cleanup", server_clock::now(), nullptr, CTaskMgr::TASK_INTERVAL, ah_cleanup,
                                         std::chrono::seconds(search_config.expire_interval));
    }
    //  ShowMessage(CL_CYAN"[TASKMGR] Starting task manager thread..\n" CL_RESET);

    std::thread(TaskManagerThread).detach();

    while (true)
    {
        // Accept a client socket
        ClientSocket = accept(ListenSocket, nullptr, nullptr);
        if (ClientSocket == INVALID_SOCKET)
        {
#ifdef WIN32
            ShowError("accept failed with error: %d\n", WSAGetLastError());
#else
            ShowError("accept failed with error: %d\n", errno);
#endif
            continue;
        }

        std::thread(TCPComm, ClientSocket).detach();
    }
    // TODO: The code below this line will never be reached.

    // shutdown the connection since we're done
#ifdef WIN32
    iResult = shutdown(ClientSocket, SD_SEND);
#else
    iResult = shutdown(ClientSocket, SHUT_WR);
#endif
    if (iResult == SOCKET_ERROR)
    {
#ifdef WIN32
        ShowError("shutdown failed with error: %d\n", WSAGetLastError());
        closesocket(ClientSocket);
        WSACleanup();
#else
        ShowError("shutdown failed with error: %d\n", errno);
        close(ClientSocket);
#endif
        return 1;
    }

    // cleanup
#ifdef WIN32
    closesocket(ClientSocket);
    WSACleanup();
#else
    close(ClientSocket);
#endif
    return 0;
}

/************************************************************************
 *                                                                       *
 *  topaz_search default config                                       *
 *                                                                       *
 ************************************************************************/

void search_config_default()
{
    search_config.mysql_host      = "127.0.0.1";
    search_config.mysql_login     = "root";
    search_config.mysql_password  = "root";
    search_config.mysql_database  = "xidb";
    search_config.mysql_port      = 3306;
    search_config.expire_auctions = true;
    search_config.expire_days     = 3;
    search_config.expire_interval = 3600;
}

/************************************************************************
 *                                                                       *
 *  topaz_search config                                               *
 *                                                                       *
 ************************************************************************/

void search_config_read(const int8* file)
{
    char  line[1024];
    char  w1[1024];
    char  w2[1024];
    FILE* fp;

    fp = fopen((const char*)file, "r");
    if (fp == nullptr)
    {
        ShowError("configuration file not found at: %s\n", file);
        return;
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

        // Strip trailing spaces
        ptr = w2 + strlen(w2);
        while (--ptr >= w2 && *ptr == ' ')
        {
            ;
        }
        ptr++;
        *ptr = '\0';

        if (strcmp(w1, "mysql_host") == 0)
        {
            search_config.mysql_host = std::string(w2);
        }
        else if (strcmp(w1, "mysql_login") == 0)
        {
            search_config.mysql_login = std::string(w2);
        }
        else if (strcmp(w1, "mysql_password") == 0)
        {
            search_config.mysql_password = std::string(w2);
        }
        else if (strcmp(w1, "mysql_port") == 0)
        {
            search_config.mysql_port = atoi(w2);
        }
        else if (strcmp(w1, "mysql_database") == 0)
        {
            search_config.mysql_database = std::string(w2);
        }
        else if (strcmp(w1, "expire_auctions") == 0)
        {
            search_config.expire_auctions = atoi(w2);
        }
        else if (strcmp(w1, "expire_days") == 0)
        {
            search_config.expire_days = atoi(w2);
        }
        else if (strcmp(w1, "expire_interval") == 0)
        {
            search_config.expire_interval = atoi(w2);
        }
        else
        {
            ShowWarning(CL_YELLOW "Unknown setting '%s' in file %s\n" CL_RESET, w1, file);
        }
    }
    fclose(fp);
}

void search_config_read_from_env()
{
    search_config.mysql_login    = std::getenv("XI_DB_USER") ? std::getenv("XI_DB_USER") : search_config.mysql_login;
    search_config.mysql_password = std::getenv("XI_DB_USER_PASSWD") ? std::getenv("XI_DB_USER_PASSWD") : search_config.mysql_password;
    search_config.mysql_host     = std::getenv("XI_DB_HOST") ? std::getenv("XI_DB_HOST") : search_config.mysql_host;
    search_config.mysql_port     = std::getenv("XI_DB_PORT") ? std::stoi(std::getenv("XI_DB_PORT")) : search_config.mysql_port;
    search_config.mysql_database = std::getenv("XI_DB_NAME") ? std::getenv("XI_DB_NAME") : search_config.mysql_database;
}

/************************************************************************
 *                                                                       *
 *  login_topaz                                                          *
 *                                                                       *
 ************************************************************************/

void login_config_default()
{
    login_config.search_server_port = "54002";
}

/************************************************************************
 *                                                                       *
 *  login_topaz                                                          *
 *                                                                       *
 ************************************************************************/

void login_config_read(const int8* file)
{
    char  line[1024];
    char  w1[1024];
    char  w2[1024];
    FILE* fp;

    fp = fopen((const char*)file, "r");
    if (fp == nullptr)
    {
        ShowError("configuration file not found at: %s\n", file);
        return;
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

        // Strip trailing spaces
        ptr = w2 + strlen(w2);
        while (--ptr >= w2 && *ptr == ' ')
        {
            ;
        }
        ptr++;
        *ptr = '\0';

        if (strcmp(w1, "search_server_port") == 0)
        {
            login_config.search_server_port = std::string(w2);
        }
    }
    fclose(fp);
}

void login_config_read_from_env()
{
    login_config.search_server_port = std::getenv("XI_SEARCH_PORT") ? std::getenv("XI_SEARCH_PORT") : login_config.search_server_port;
}

void TCPComm(SOCKET socket)
{
    // ShowMessage("TCP connection from client with port: %u\n", htons(CommInfo.port));

    CTCPRequestPacket PTCPRequest(&socket);

    if (PTCPRequest.ReceiveFromSocket() == 0)
    {
        return;
    }
    // PrintPacket((int8*)PTCPRequest->GetData(), PTCPRequest->GetSize());
    ShowMessage("= = = = = = = \nType: %u Size: %u \n", PTCPRequest.GetPacketType(), PTCPRequest.GetSize());

    switch (PTCPRequest.GetPacketType())
    {
        case TCP_SEARCH:
        case TCP_SEARCH_ALL:
        {
            ShowMessage("Search \n");
            HandleSearchRequest(PTCPRequest);
        }
        break;
        case TCP_SEARCH_COMMENT:
        {
            ShowMessage("Search comment \n");
            HandleSearchComment(PTCPRequest);
        }
        break;
        case TCP_GROUP_LIST:
        {
            ShowMessage("Search group\n");
            HandleGroupListRequest(PTCPRequest);
        }
        break;
        case TCP_AH_REQUEST:
        case TCP_AH_REQUEST_MORE:
        {
            HandleAuctionHouseRequest(PTCPRequest);
        }
        break;
        case TCP_AH_HISTORY_SINGL:
        case TCP_AH_HISTORY_STACK:
        {
            HandleAuctionHouseHistory(PTCPRequest);
        }
        break;
    }
}

/************************************************************************
 *                                                                       *
 *  Character list request (party/linkshell)                             *
 *                                                                       *
 ************************************************************************/

void HandleGroupListRequest(CTCPRequestPacket& PTCPRequest)
{
    uint8* data = (uint8*)PTCPRequest.GetData();

    uint16 partyid      = ref<uint16>(data, 0x10);
    uint16 allianceid   = ref<uint16>(data, 0x14);
    uint32 linkshellid1 = ref<uint32>(data, 0x18);
    uint32 linkshellid2 = ref<uint32>(data, 0x1C);

    ShowMessage("SEARCH::PartyID = %u\n", partyid);
    ShowMessage("SEARCH::LinkshellIDs = %u, %u\n", linkshellid1, linkshellid2);

    CDataLoader PDataLoader;

    if (partyid != 0 || allianceid != 0)
    {
        std::list<SearchEntity*> PartyList = PDataLoader.GetPartyList(partyid, allianceid);

        CPartyListPacket PPartyPacket(partyid, (uint32)PartyList.size());

        for (auto& it : PartyList)
        {
            PPartyPacket.AddPlayer(it);
        }

        PrintPacket((char*)PPartyPacket.GetData(), PPartyPacket.GetSize());
        PTCPRequest.SendToSocket(PPartyPacket.GetData(), PPartyPacket.GetSize());
    }
    else if (linkshellid1 != 0 || linkshellid2 != 0)
    {
        uint32                   linkshellid   = linkshellid1 == 0 ? linkshellid2 : linkshellid1;
        std::list<SearchEntity*> LinkshellList = PDataLoader.GetLinkshellList(linkshellid);

        CLinkshellListPacket PLinkshellPacket(linkshellid, (uint32)LinkshellList.size());

        for (auto& it : LinkshellList)
        {
            PLinkshellPacket.AddPlayer(it);
        }

        PrintPacket((char*)PLinkshellPacket.GetData(), PLinkshellPacket.GetSize());
        PTCPRequest.SendToSocket(PLinkshellPacket.GetData(), PLinkshellPacket.GetSize());
    }
}

void HandleSearchComment(CTCPRequestPacket& PTCPRequest)
{
    uint8 packet[] = { 0xCC, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x20, 0x9B, 0x16, 0xC8, 0x4C, 0x76, 0x07, 0x02, 0x17, 0x71, 0xB9, 0xA8, 0xF5, 0xB6, 0xCF,
                       0xED, 0xF1, 0xFF, 0x70, 0x52, 0xA9, 0xAE, 0x81, 0xB6, 0x1B, 0x2B, 0x7B, 0xA0, 0xC1, 0xD2, 0xD1, 0xFD, 0x61, 0x43, 0x80, 0x37, 0x08, 0x74,
                       0xC5, 0x8D, 0x61, 0x43, 0x80, 0x37, 0x08, 0x74, 0xC5, 0x8D, 0x61, 0x43, 0x80, 0x37, 0x08, 0x74, 0xC5, 0x8D, 0x61, 0x43, 0x80, 0x37, 0x08,
                       0x74, 0xC5, 0x8D, 0x61, 0x43, 0x80, 0x37, 0x08, 0x74, 0xC5, 0x8D, 0x61, 0x43, 0x80, 0x37, 0x08, 0x74, 0xC5, 0x8D, 0x61, 0x43, 0x80, 0x37,
                       0x08, 0x74, 0xC5, 0x8D, 0x61, 0x43, 0x80, 0x37, 0x08, 0x74, 0xC5, 0x8D, 0x61, 0x43, 0x80, 0x37, 0x08, 0x74, 0xC5, 0x8D, 0x61, 0x43, 0x80,
                       0x37, 0x08, 0x74, 0xC5, 0x8D, 0x61, 0x43, 0x80, 0x37, 0x08, 0x74, 0xC5, 0x8D, 0x61, 0x43, 0x80, 0x37, 0x08, 0x74, 0xC5, 0x8D, 0x61, 0x43,
                       0x80, 0x37, 0x08, 0x74, 0xC5, 0x8D, 0x61, 0x43, 0x80, 0x37, 0x08, 0x74, 0xC5, 0x8D, 0x0C, 0x04, 0x13, 0xC0, 0x89, 0x17, 0x8F, 0x72, 0x93,
                       0xD6, 0x90, 0xF1, 0x21, 0x7A, 0xA5, 0xAC, 0x93, 0xD6, 0x90, 0xF1, 0x21, 0x7A, 0xA5, 0xAC, 0x93, 0xD6, 0x90, 0xF1, 0x21, 0x7A, 0xA5, 0xAC,
                       0x38, 0x25, 0x69, 0x79, 0x00, 0xC6, 0x7E, 0xDC, 0x80, 0x3D, 0x99, 0x85, 0xF4, 0xDF, 0xCF, 0xFC, 0x1A, 0x72, 0xE2, 0x0D };
    PTCPRequest.SendRawToSocket(packet, sizeof(packet));
}

void HandleSearchRequest(CTCPRequestPacket& PTCPRequest)
{
    search_req sr         = _HandleSearchRequest(PTCPRequest);
    int        totalCount = 0;

    CDataLoader              PDataLoader;
    std::list<SearchEntity*> SearchList = PDataLoader.GetPlayersList(sr, &totalCount);
    // PDataLoader->GetPlayersCount(sr)
    CSearchListPacket PSearchPacket(totalCount);

    for (auto& it : SearchList)
    {
        PSearchPacket.AddPlayer(it);
    }

    // PrintPacket((int8*)PSearchPacket->GetData(), PSearchPacket->GetSize());
    PTCPRequest.SendToSocket(PSearchPacket.GetData(), PSearchPacket.GetSize());
}

void HandleAuctionHouseRequest(CTCPRequestPacket& PTCPRequest)
{
    uint8* data    = (uint8*)PTCPRequest.GetData();
    uint8  AHCatID = ref<uint8>(data, 0x16);

    // 2 - level
    // 3 - race
    // 4 - job
    // 5 - damage
    // 6 - delay
    // 7 - defense
    // 8 - resistance
    // 9 - name
    string_t OrderByString = "ORDER BY";
    uint8    paramCount    = ref<uint8>(data, 0x12);
    for (uint8 i = 0; i < paramCount; ++i) // параметры сортировки предметов
    {
        uint8 param = ref<uint32>(data, 0x18 + 8 * i);
        ShowMessage(" Param%u: %u\n", i, param);
        switch (param)
        {
            case 2:
                OrderByString.append(" item_equipment.level DESC,");
            case 5:
                OrderByString.append(" item_weapon.dmg DESC,");
            case 6:
                OrderByString.append(" item_weapon.delay DESC,");
            case 9:
                OrderByString.append(" item_basic.sortname,");
        }
    }

    OrderByString.append(" item_basic.itemid");
    int8* OrderByArray = (int8*)OrderByString.data();

    CDataLoader          PDataLoader;
    std::vector<ahItem*> ItemList = PDataLoader.GetAHItemsToCategory(AHCatID, OrderByArray);

    uint8 PacketsCount = (uint8)((ItemList.size() / 20) + (ItemList.size() % 20 != 0) + (ItemList.empty()));

    for (uint8 i = 0; i < PacketsCount; ++i)
    {
        CAHItemsListPacket PAHPacket(20 * i);

        PAHPacket.SetItemCount((uint16)ItemList.size());

        for (uint16 y = 20 * i; (y != 20 * (i + 1)) && (y < ItemList.size()); ++y)
        {
            PAHPacket.AddItem(ItemList.at(y));
        }

        PTCPRequest.SendToSocket(PAHPacket.GetData(), PAHPacket.GetSize());
    }
}

void HandleAuctionHouseHistory(CTCPRequestPacket& PTCPRequest)
{
    uint8* data   = (uint8*)PTCPRequest.GetData();
    uint16 ItemID = ref<uint16>(data, 0x12);
    uint8  stack  = ref<uint8>(data, 0x15);

    CAHHistoryPacket PAHPacket(ItemID);

    CDataLoader             PDataLoader;
    std::vector<ahHistory*> HistoryList = PDataLoader.GetAHItemHystory(ItemID, stack != 0);

    for (auto& i : HistoryList)
    {
        PAHPacket.AddItem(i);
    }

    PTCPRequest.SendToSocket(PAHPacket.GetData(), PAHPacket.GetSize());
}

search_req _HandleSearchRequest(CTCPRequestPacket& PTCPRequest)
{
    // This function constructs a `search_req` based on which query should be send to the database.
    // The results from the database will eventually be sent to the client.

    uint32 bitOffset = 0;

    unsigned char sortDescending = 0;
    unsigned char isPresent      = 0;
    unsigned char areaCount      = 0;

    char  name[16];
    uint8 nameLen = 0;

    uint8 minLvl = 0;
    uint8 maxLvl = 0;

    uint8 jobid    = 0;
    uint8 raceid   = 255; // 255 cause race 0 is an actual filter (hume)
    uint8 nationid = 255; // 255 cause nation 0 is an actual filter (sandoria)

    uint8 minRank = 0;
    uint8 maxRank = 0;

    uint16 areas[10];

    uint32 flags = 0;

    uint8* data = (uint8*)PTCPRequest.GetData();
    uint8  size = ref<uint8>(data, 0x10);

    uint16 workloadBits = size * 8;

    memset(areas, 0, sizeof(areas));
    // ShowMessage("Received a search packet with size %u byte\n", size);

    while (bitOffset < workloadBits)
    {
        if ((bitOffset + 5) >= workloadBits)
        {
            bitOffset = workloadBits;
            break;
        }

        uint8 EntryType = (uint8)unpackBitsLE(&data[0x11], bitOffset, 5);
        bitOffset += 5;

        if ((EntryType != SEARCH_FRIEND) && (EntryType != SEARCH_LINKSHELL) && (EntryType != SEARCH_COMMENT) && (EntryType != SEARCH_FLAGS2))
        {
            if ((bitOffset + 3) >= workloadBits) // so 0000000 at the end does not get interpretet as name entry ...
            {
                bitOffset = workloadBits;
                break;
            }
            sortDescending = (unsigned char)unpackBitsLE(&data[0x11], bitOffset, 1);
            bitOffset += 1;

            isPresent = (unsigned char)unpackBitsLE(&data[0x11], bitOffset, 1);
            bitOffset += 1;
        }

        switch (EntryType)
        {
            case SEARCH_NAME:
            {
                if (isPresent == 0x1) // Name send
                {
                    if ((bitOffset + 5) >= workloadBits)
                    {
                        bitOffset = workloadBits;
                        break;
                    }
                    nameLen       = (unsigned char)unpackBitsLE(&data[0x11], bitOffset, 5);
                    name[nameLen] = '\0';

                    bitOffset += 5;

                    for (unsigned char i = 0; i < nameLen; i++)
                    {
                        name[i] = (char)unpackBitsLE(&data[0x11], bitOffset, 7);
                        bitOffset += 7;
                    }
                    // printf("SEARCH::Name Entry Found. (%s).\n",name);
                }
                // printf("SEARCH::SortByName: %s.\n",(sortDescending == 0 ? "ascending" : "descending"));
                // packetData.sortDescendingByName=sortDescending;
                break;
            }
            case SEARCH_AREA: // Area Code Entry - 10 bit
            {
                if (isPresent == 0) // no more Area entries
                {
                    // printf("SEARCH::Area List End found.\n");
                }
                else // 8 Bit = 1 Byte per Area Code
                {
                    areas[areaCount] = (uint16)unpackBitsLE(&data[0x11], bitOffset, 10);
                    areaCount++;
                    bitOffset += 10;
                    //  printf("SEARCH::Area List Entry found(%2X)!\n",areas[areaCount-1]);
                }
                break;
            }
            case SEARCH_NATION: // Country - 2 bit
            {
                if (isPresent == 0x1)
                {
                    unsigned char country = (unsigned char)unpackBitsLE(&data[0x11], bitOffset, 2);
                    bitOffset += 2;
                    nationid = country;

                    printf("SEARCH::Nationality Entry found. (%2X) Sorting: (%s).\n", country, (sortDescending == 0x00) ? "ascending" : "descending");
                }
                break;
            }
            case SEARCH_JOB: // Job - 5 bit
            {
                if (isPresent == 0x1)
                {
                    unsigned char job = (unsigned char)unpackBitsLE(&data[0x11], bitOffset, 5);
                    bitOffset += 5;
                    jobid = job;
                    // printf("SEARCH::Job Entry found. (%2X) Sorting: (%s).\n",job,(sortDescending==0x00)?"ascending":"descending");
                }
                // packetData.sortDescendingByJob=sortDescending;
                // printf("SEARCH::SortByJob: %s.\n",(sortDescending==0x00)?"ascending":"descending");
                break;
            }
            case SEARCH_LEVEL: // Level- 16 bit
            {
                if (isPresent == 0x1)
                {
                    unsigned char fromLvl = (unsigned char)unpackBitsLE(&data[0x11], bitOffset, 8);
                    bitOffset += 8;
                    unsigned char toLvl = (unsigned char)unpackBitsLE(&data[0x11], bitOffset, 8);
                    bitOffset += 8;
                    minLvl = fromLvl;
                    maxLvl = toLvl;
                    // printf("SEARCH::Level Entry found. (%d - %d) Sorting: (%s).\n",fromLvl,toLvl,(sortDescending==0x00)?"ascending":"descending");
                }
                // packetData.sortDescendingByLevel=sortDescending;
                // printf("SEARCH::SortByLevel: %s.\n",(sortDescending==0x00)?"ascending":"descending");
                break;
            }
            case SEARCH_RACE: // Race - 4 bit
            {
                if (isPresent == 0x1)
                {
                    unsigned char race = (unsigned char)unpackBitsLE(&data[0x11], bitOffset, 4);
                    bitOffset += 4;
                    raceid = race;

                    printf("SEARCH::Race Entry found. (%2X) Sorting: (%s).\n", race, (sortDescending == 0x00) ? "ascending" : "descending");
                }
                printf("SEARCH::SortByRace: %s.\n", (sortDescending == 0x00) ? "ascending" : "descending");
                // packetData.sortDescendingByRace=sortDescending;
                break;
            }
            case SEARCH_RANK: // Rank - 2 byte
            {
                if (isPresent == 0x1)
                {
                    unsigned char fromRank = (unsigned char)unpackBitsLE(&data[0x11], bitOffset, 8);
                    bitOffset += 8;
                    minRank              = fromRank;
                    unsigned char toRank = (unsigned char)unpackBitsLE(&data[0x11], bitOffset, 8);
                    bitOffset += 8;
                    maxRank = toRank;

                    printf("SEARCH::Rank Entry found. (%d - %d) Sorting: (%s).\n", fromRank, toRank, (sortDescending == 0x00) ? "ascending" : "descending");
                }
                printf("SEARCH::SortByRank: %s.\n", (sortDescending == 0x00) ? "ascending" : "descending");
                // packetData.sortDescendingByRank=sortDescending;
                break;
            }
            case SEARCH_COMMENT: // 4 Byte
            {
                unsigned int comment = (unsigned int)unpackBitsLE(&data[0x11], bitOffset, 32);
                bitOffset += 32;

                printf("SEARCH::Comment Entry found. (%8X).\n", comment);
                break;
            }
            // the following 4 Entries were generated with /sea (ballista|friend|linkshell|away|inv)
            // so they may be off
            case SEARCH_LINKSHELL: // 4 Byte
            {
                unsigned int lsId = (unsigned int)unpackBitsLE(&data[0x11], bitOffset, 32);
                bitOffset += 32;

                printf("SEARCH::Linkshell Entry found. Value: %.8X\n", lsId);
                break;
            }
            case SEARCH_FRIEND: // Friend Packet, 0 byte
            {
                printf("SEARCH::Friend Entry found.\n");
                break;
            }
            case SEARCH_FLAGS1: // Flag Entry #1, 2 byte,
            {
                if (isPresent == 0x1)
                {
                    unsigned short flags1 = (unsigned short)unpackBitsLE(&data[0x11], bitOffset, 16);
                    bitOffset += 16;

                    printf("SEARCH::Flag Entry #1 (%.4X) found. Sorting: (%s).\n", flags1, (sortDescending == 0x00) ? "ascending" : "descending");

                    flags = flags1;
                }
                printf("SEARCH::SortByFlags: %s\n", (sortDescending == 0 ? "ascending" : "descending"));
                // packetData.sortDescendingByFlags=sortDescending;
                break;
            }
            case SEARCH_FLAGS2: // Flag Entry #2 - 4 byte
            {
                unsigned int flags2 = (unsigned int)unpackBitsLE(&data[0x11], bitOffset, 32);

                bitOffset += 32;
                flags = flags2;
                /*
                if ((flags & 0xFFFF)!=(packetData.flags1))
                {
                printf("SEARCH::Flag mismatch: %.8X != %.8X\n",flags,packetData.flags1&0xFFFF);
                }
                packetData.flags2=flags;
                printf("SEARCH::Flag Entry #2 (%.8X) found.\n",packetData.flags2);
                */
                break;
            }
            default:
            {
                printf("SEARCH::Unknown Search Param %.2X!\n", EntryType);
                // outputPacket=true;
                break;
            }
        }
    }
    printf("\n");

    ShowMessage("Name: %s Job: %u Lvls: %u ~ %u \n", (nameLen > 0 ? name : nullptr), jobid, minLvl, maxLvl);

    search_req sr;
    sr.jobid  = jobid;
    sr.maxlvl = maxLvl;
    sr.minlvl = minLvl;

    sr.race    = raceid;
    sr.nation  = nationid;
    sr.minRank = minRank;
    sr.maxRank = maxRank;
    sr.flags   = flags;

    sr.nameLen = nameLen;
    memcpy(sr.zoneid, areas, sizeof(sr.zoneid));
    if (nameLen > 0)
    {
        sr.name.insert(0, name);
    }

    return sr;
    // не обрабатываем последние биты, что мешает в одну кучу
    // For example: "/blacklist delete Name" and "/sea all Name"
}

/************************************************************************
 *                                                                       *
 *  Task Manager Thread                                                  *
 *                                                                       *
 ************************************************************************/

void TaskManagerThread()
{
    duration next;
    while (true)
    {
        next = CTaskMgr::getInstance()->DoTimer(server_clock::now());
        std::this_thread::sleep_for(next);
    }
}

/************************************************************************
 *                                                                       *
 *  Task Manager Callbacks                                               *
 *                                                                       *
 ************************************************************************/

int32 ah_cleanup(time_point tick, CTaskMgr::CTask* PTask)
{
    // ShowMessage(CL_YELLOW"[TASK] ah_cleanup tick..\n" CL_RESET);

    CDataLoader data;
    data.ExpireAHItems();

    return 0;
}
