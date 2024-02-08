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

#include "common/blowfish.h"
#include "common/cbasetypes.h"
#include "common/console_service.h"
#include "common/logging.h"
#include "common/lua.h"
#include "common/md52.h"
#include "common/mmo.h"
#include "common/settings.h"
#include "common/socket.h"
#include "common/sql.h"
#include "common/taskmgr.h"
#include "common/timer.h"
#include "common/utils.h"

#ifdef WIN32
#include <wepoll.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#else
#include <cerrno>
#include <netdb.h>
#include <netinet/in.h>

// MacOS has no epoll
#ifdef __APPLE__
#include <sys/ioctl.h>
#else
#include <sys/epoll.h>
#endif

#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
typedef int   HANDLE;
typedef u_int SOCKET;
#define INVALID_SOCKET (SOCKET)(~0)
#define SOCKET_ERROR   (-1)
#endif

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <sstream>
#include <unordered_set>
#include <vector>

#include "data_loader.h"
#include "search.h"
#include "tcp_request.h"

#include "packets/auction_history.h"
#include "packets/auction_list.h"
#include "packets/linkshell_list.h"
#include "packets/party_list.h"
#include "packets/search_comment.h"
#include "packets/search_list.h"

#include <task_system.hpp>

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

void TaskManagerThread(bool const& requestExit);

int32 ah_cleanup(time_point tick, CTaskMgr::CTask* PTask);

void TCPComm(SOCKET socket);

extern void       HandleSearchRequest(CTCPRequestPacket& PTCPRequest);
extern void       HandleSearchComment(CTCPRequestPacket& PTCPRequest);
extern void       HandleGroupListRequest(CTCPRequestPacket& PTCPRequest);
extern void       HandleAuctionHouseHistory(CTCPRequestPacket& PTCPRequest);
extern void       HandleAuctionHouseRequest(CTCPRequestPacket& PTCPRequest);
extern search_req _HandleSearchRequest(CTCPRequestPacket& PTCPRequest);

extern std::unique_ptr<ConsoleService> gConsoleService;

// A single IP should only have one request in flight at a time, so we are going to
// be tracking the IP addresses of incoming requests and if we haven't cleared the
// record for it - we drop the request.
std::mutex                      gIPAddressesInUseMutex;
std::unordered_set<std::string> gIPAddressesInUse;

// Implement using getsockname and inet_ntop
std::string socketToString(SOCKET socket)
{
    sockaddr_storage addr;
    socklen_t        len = sizeof(addr);
    getsockname(socket, (sockaddr*)&addr, &len);

    char         ipstr[INET6_ADDRSTRLEN];
    sockaddr_in* s = (sockaddr_in*)&addr;
    inet_ntop(AF_INET, &s->sin_addr, ipstr, sizeof(ipstr));

    return std::string(ipstr);
}

bool isSocketInUse(std::string const& ipAddressStr)
{
    std::lock_guard<std::mutex> lock(gIPAddressesInUseMutex);

    // ShowInfo(fmt::format("Checking if IP is in use: {}", ipAddressStr).c_str());
    return gIPAddressesInUse.find(ipAddressStr) != gIPAddressesInUse.end();
}

void removeSocketFromSet(std::string const& ipAddressStr)
{
    std::lock_guard<std::mutex> lock(gIPAddressesInUseMutex);

    // ShowInfo(fmt::format("Removing IP from set: {}", ipAddressStr).c_str());
    gIPAddressesInUse.erase(ipAddressStr);
}

void addSocketToSet(std::string const& ipAddressStr)
{
    std::lock_guard<std::mutex> lock(gIPAddressesInUseMutex);

    // ShowInfo(fmt::format("Adding IP to set: {}", ipAddressStr).c_str());
    gIPAddressesInUse.insert(ipAddressStr);
}

/************************************************************************
 *                                                                       *
 *  Prints the contents of the packet in `data` to the console.          *
 *                                                                       *
 ************************************************************************/

void PrintPacket(char* data, int size)
{
    fmt::printf("\n");
    for (int32 y = 0; y < size; y++)
    {
        fmt::printf("%02x ", (uint8)data[y]);
        if (((y + 1) % 16) == 0)
        {
            fmt::printf("\n");
        }
    }
    fmt::printf("\n");
}

int32 main(int32 argc, char** argv)
{
    bool appendDate{};
    bool requestExit = false;
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

        if (strcmp(argv[i], "--append-date") == 0)
        {
            appendDate = true;
        }
    }

    logging::InitializeLog("search", logFile, appendDate);

    lua_init();
    settings::init();

    auto expireDays = settings::get<uint16>("search.EXPIRE_DAYS");

    int iResult{};

    SOCKET ListenSocket = INVALID_SOCKET;
    SOCKET ClientSocket = INVALID_SOCKET;

    struct addrinfo* result = nullptr;
    struct addrinfo  hints
    {
    };

#ifdef WIN32
    // Initialize Winsock
    iResult = WSAStartup(MAKEWORD(2, 2), &wsaData);
    if (iResult != 0)
    {
        ShowError("WSAStartup failed with error: %d", iResult);
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
    iResult = getaddrinfo(nullptr, settings::get<std::string>("network.SEARCH_PORT").c_str(), &hints, &result);
    if (iResult != 0)
    {
        ShowError("getaddrinfo failed with error: %d", iResult);
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
        ShowError("socket failed with error: %ld", WSAGetLastError());
        freeaddrinfo(result);
        WSACleanup();
#else
        ShowError("socket failed with error: %ld", errno);
        freeaddrinfo(result);
#endif
        return 1;
    }

    // https://stackoverflow.com/questions/3229860/what-is-the-meaning-of-so-reuseaddr-setsockopt-option-linux
    // Avoid hangs in TIME_WAIT state of TCP
#ifdef WIN32
    // Windows doesn't seem to have this problem, but apparently this would be the right way to explicitly mimic SO_REUSEADDR unix's behavior.
    setsockopt(ListenSocket, SOL_SOCKET, SO_DONTLINGER, "\x00\x00\x00\x00", 4);
#else
    int enable = 1;
    if (setsockopt(ListenSocket, SOL_SOCKET, SO_REUSEADDR, &enable, sizeof(int)) < 0)
    {
        ShowError("setsockopt SO_REUSEADDR failed!");
    }
#endif
    // Setup the TCP listening socket
    iResult = bind(ListenSocket, result->ai_addr, (int)result->ai_addrlen);
    if (iResult == SOCKET_ERROR)
    {
#ifdef WIN32
        ShowError("bind failed with error: %d", WSAGetLastError());
        freeaddrinfo(result);
        closesocket(ListenSocket);
        WSACleanup();
#else
        ShowError("bind failed with error: %d", errno);
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
        ShowError("listen failed with error: %d", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
#else
        ShowError("listen failed with error: %d", errno);
        close(ListenSocket);
#endif
        return 1;
    }

#ifdef _WIN32
    // Disable Quick Edit Mode (Mark) in Windows Console to prevent users from accidentially
    // causing the server to freeze.
    HANDLE hInput;
    DWORD  prev_mode;
    hInput = GetStdHandle(STD_INPUT_HANDLE);
    GetConsoleMode(hInput, &prev_mode);
    SetConsoleMode(hInput, ENABLE_EXTENDED_FLAGS | (prev_mode & ~ENABLE_QUICK_EDIT_MODE));
#endif // _WIN32

    ShowInfo("========================================================");
    ShowInfo("search and auction server");
    ShowInfo("========================================================");

    if (settings::get<bool>("search.EXPIRE_AUCTIONS"))
    {
        ShowInfo("AH task to return items older than %u days is running", expireDays);
        CTaskMgr::getInstance()->AddTask("ah_cleanup", server_clock::now(), nullptr, CTaskMgr::TASK_INTERVAL, ah_cleanup,
                                         std::chrono::seconds(settings::get<uint32>("search.EXPIRE_INTERVAL")));
    }

    std::thread taskManagerThread(TaskManagerThread, std::ref(requestExit));

    auto taskSystem = ts::task_system(4);

    // clang-format off
    gConsoleService = std::make_unique<ConsoleService>();
    gConsoleService->RegisterCommand(
    "ah_cleanup", fmt::format("AH task to return items older than {} days.", expireDays),
    [](std::vector<std::string>& inputs)
    {
        ah_cleanup(server_clock::now(), nullptr);
    });
    gConsoleService->RegisterCommand(
    "expire_all", "Force-expire all items on the AH, returning to sender.",
    [](std::vector<std::string>& inputs)
    {
        CDataLoader data;
        data.ExpireAHItems(0);
    });

    gConsoleService->RegisterCommand("exit", "Terminate the program.",
    [&](std::vector<std::string>& inputs)
    {
        fmt::print("> Goodbye!\n");
        gConsoleService->stop();
        requestExit = true;
    });
    // clang-format on

    ShowInfo("========================================================");
#ifndef __APPLE__
    epoll_event epollEvent  = { EPOLLIN };
    HANDLE      epollHandle = epoll_create1(0);
    epoll_ctl(epollHandle, EPOLL_CTL_ADD, ListenSocket, &epollEvent);
    int ret = 0;

    while (!requestExit)
    {
        ret = epoll_wait(epollHandle, &epollEvent, 1, 100);
        if (ret == SOCKET_ERROR)
        {
            if (sErrno != S_EINTR)
            {
                ShowCritical("do_sockets: select() failed, error code %d!", sErrno);
                std::exit(EXIT_FAILURE);
            }
            continue; // interrupted by a signal, just loop and try again
        }
        else if (ret == 0 || requestExit)
        {
            continue;
        }

        // Accept a client socket
        ClientSocket = accept(ListenSocket, nullptr, nullptr);
        if (ClientSocket == INVALID_SOCKET)
        {
            ShowError("accept failed with error: %d", sErrno);
            continue;
        }

        auto ipAddressStr = socketToString(ClientSocket);
        if (isSocketInUse(ipAddressStr))
        {
            ShowError(fmt::format("IP already being served, dropping connection from: {}", ipAddressStr).c_str());
            continue;
        }

        // clang-format off
        taskSystem.schedule([ClientSocket, ipAddressStr]() // Take by value, not by reference
        {
            addSocketToSet(ipAddressStr);
            TCPComm(ClientSocket);
            removeSocketFromSet(ipAddressStr);
        });
        // clang-format on
    }

    gConsoleService = nullptr;

    // close the connection since we're done
    epoll_ctl(epollHandle, EPOLL_CTL_DEL, ListenSocket, &epollEvent);

    // __APPLE__ has no epoll, use Select
#else
    fd_set fdSet        = {};
    fd_set workingFdSet = {};

    struct timeval timeout = {};

    FD_ZERO(&fdSet);
    FD_SET(ListenSocket, &fdSet);

    int usecTimeout = std::chrono::duration_cast<std::chrono::microseconds>(100ms).count();

    int ret = 0;
    while (!requestExit)
    {
        // timeout can be updated by select, set it back every iteration.
        timeout.tv_sec  = 0;
        timeout.tv_usec = usecTimeout;

        memcpy(&workingFdSet, &fdSet, sizeof(fdSet));
        ret = sSelect(ListenSocket + 1, &workingFdSet, nullptr, nullptr, &timeout);

        if (ret == SOCKET_ERROR)
        {
            if (sErrno != S_EINTR)
            {
                ShowCritical("select() failed, error code %d!", sErrno);
                std::exit(EXIT_FAILURE);
            }
            continue;
        }

        if (ret > 0)
        {
            // Accept a client socket
            ClientSocket = accept(ListenSocket, nullptr, nullptr);
            if (ClientSocket == INVALID_SOCKET)
            {
                ShowError("accept failed with error: %d", sErrno);
                continue;
            }

            auto ipAddressStr = socketToString(ClientSocket);
            if (isSocketInUse(ipAddressStr))
            {
                ShowError(fmt::format("IP already being served, dropping connection from: {}", ipAddressStr).c_str());
                continue;
            }

            // clang-format off
            taskSystem.schedule([ClientSocket, ipAddressStr]() // Take by value, not by reference
            {
                addSocketToSet(ipAddressStr);
                TCPComm(ClientSocket);
                removeSocketFromSet(ipAddressStr);
            });
            // clang-format on
        }
    }
#endif

#ifdef WIN32
    epoll_close(epollHandle);
    iResult = shutdown(ListenSocket, SD_SEND);
#else
    iResult = shutdown(ListenSocket, SHUT_WR);
#endif
    if (iResult == SOCKET_ERROR)
    {
#ifdef WIN32
        if (sErrno != WSAENOTCONN) // If the socket isn't connected we throw an error if we try to close it if it's not connected.
        {
            ShowError("shutdown failed with error: %d", WSAGetLastError());
            closesocket(ListenSocket);
            WSACleanup();
            return 1;
        }
#else
        ShowError("shutdown failed with error: %d", errno);
        close(ListenSocket);
        return 1;
#endif
    }

    logging::ShutDown();
    taskManagerThread.join();

    // cleanup
#ifdef WIN32
    closesocket(ClientSocket);
    WSACleanup();
#else
    close(ClientSocket);
#endif
    return 0;
}

void TCPComm(SOCKET socket)
{
    CTCPRequestPacket PTCPRequest(&socket);

    if (PTCPRequest.ReceiveFromSocket() == 0)
    {
        return;
    }

    ShowInfo("= = = = = = = Type: %u Size: %u ", PTCPRequest.GetPacketType(), PTCPRequest.GetSize());

    switch (PTCPRequest.GetPacketType())
    {
        case TCP_SEARCH:
        case TCP_SEARCH_ALL:
        {
            ShowInfo("Search ");
            HandleSearchRequest(PTCPRequest);
        }
        break;
        case TCP_SEARCH_COMMENT:
        {
            ShowInfo("Search comment ");
            HandleSearchComment(PTCPRequest);
        }
        break;
        case TCP_GROUP_LIST:
        {
            ShowInfo("Search group");
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
    uint8* data = PTCPRequest.GetData();

    uint32 partyid      = ref<uint32>(data, 0x10);
    uint32 allianceid   = ref<uint32>(data, 0x14);
    uint32 linkshellid1 = ref<uint32>(data, 0x18);
    uint32 linkshellid2 = ref<uint32>(data, 0x1C);

    ShowInfo("SEARCH::PartyID = %u", partyid);
    ShowInfo("SEARCH::LinkshellIDs = %u, %u", linkshellid1, linkshellid2);

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

        uint32 totalResults  = (uint32)LinkshellList.size();
        uint32 currentResult = 0;

        // Iterate through the linkshell list, splitting up the results into
        // smaller chunks.
        std::list<SearchEntity*>::iterator it = LinkshellList.begin();

        do
        {
            CLinkshellListPacket PLinkshellPacket(linkshellid, totalResults);

            while (currentResult < totalResults)
            {
                bool success = PLinkshellPacket.AddPlayer(*it);
                if (!success)
                    break;

                currentResult++;
                ++it;
            }

            if (currentResult == totalResults)
                PLinkshellPacket.SetFinal();

            auto ret = PTCPRequest.SendToSocket(PLinkshellPacket.GetData(), PLinkshellPacket.GetSize());
            if (ret <= 0)
                break;
        } while (currentResult < totalResults);
    }
}

void HandleSearchComment(CTCPRequestPacket& PTCPRequest)
{
    uint8* data     = PTCPRequest.GetData();
    uint32 playerId = ref<uint32>(data, 0x10);

    CDataLoader PDataLoader;
    std::string comment = PDataLoader.GetSearchComment(playerId);
    if (comment.empty())
    {
        return;
    }

    SearchCommentPacket commentPacket(playerId, comment);
    PTCPRequest.SendToSocket(commentPacket.GetData(), commentPacket.GetSize());
}

void HandleSearchRequest(CTCPRequestPacket& PTCPRequest)
{
    search_req sr         = _HandleSearchRequest(PTCPRequest);
    int        totalCount = 0;

    CDataLoader              PDataLoader;
    std::list<SearchEntity*> SearchList = PDataLoader.GetPlayersList(sr, &totalCount);

    uint32 totalResults  = (uint32)SearchList.size();
    uint32 currentResult = 0;

    // Iterate through the search list, splitting up the results into
    // smaller chunks.
    std::list<SearchEntity*>::iterator it = SearchList.begin();

    do
    {
        CSearchListPacket PSearchPacket(totalCount);

        while (currentResult < totalResults)
        {
            bool success = PSearchPacket.AddPlayer(*it);
            if (!success)
                break;

            currentResult++;
            ++it;
        }

        if (currentResult == totalResults)
            PSearchPacket.SetFinal();

        auto ret = PTCPRequest.SendToSocket(PSearchPacket.GetData(), PSearchPacket.GetSize());
        if (ret <= 0)
            break;
    } while (currentResult < totalResults);
}

void HandleAuctionHouseRequest(CTCPRequestPacket& PTCPRequest)
{
    uint8* data    = PTCPRequest.GetData();
    uint8  AHCatID = ref<uint8>(data, 0x16);

    // 2 - level
    // 3 - race
    // 4 - job
    // 5 - damage
    // 6 - delay
    // 7 - defense
    // 8 - resistance
    // 9 - name
    std::string OrderByString = "ORDER BY";
    uint8       paramCount    = ref<uint8>(data, 0x12);
    for (uint8 i = 0; i < paramCount; ++i) // Item sort options
    {
        uint8 param = ref<uint32>(data, 0x18 + 8 * i);
        ShowInfo(" Param%u: %u", i, param);
        switch (param)
        {
            case 2:
                OrderByString.append(" item_equipment.level DESC,");
                break;
            case 5:
                OrderByString.append(" item_weapon.dmg DESC,");
                break;
            case 6:
                OrderByString.append(" item_weapon.delay DESC,");
                break;
            case 9:
                OrderByString.append(" item_basic.sortname,");
                break;
        }
    }

    OrderByString.append(" item_basic.itemid");
    const char* OrderByArray = OrderByString.data();

    CDataLoader          PDataLoader;
    std::vector<ahItem*> ItemList = PDataLoader.GetAHItemsToCategory(AHCatID, OrderByArray);

    uint8 PacketsCount = (uint8)((ItemList.size() / 20) + (ItemList.size() % 20 != 0) + (ItemList.empty()));

    for (uint8 i = 0; i < PacketsCount; ++i)
    {
        CAHItemsListPacket PAHPacket(20 * i);
        uint16             itemListSize = static_cast<uint16>(ItemList.size());

        PAHPacket.SetItemCount(itemListSize);

        for (uint16 y = 20 * i; (y != 20 * (i + 1)) && (y < itemListSize); ++y)
        {
            PAHPacket.AddItem(ItemList.at(y));
        }

        PTCPRequest.SendToSocket(PAHPacket.GetData(), PAHPacket.GetSize());
    }
}

void HandleAuctionHouseHistory(CTCPRequestPacket& PTCPRequest)
{
    uint8* data   = PTCPRequest.GetData();
    uint16 ItemID = ref<uint16>(data, 0x12);
    uint8  stack  = ref<uint8>(data, 0x15);

    CDataLoader             PDataLoader;
    std::vector<ahHistory*> HistoryList = PDataLoader.GetAHItemHistory(ItemID, stack != 0);
    ahItem                  item        = PDataLoader.GetAHItemFromItemID(ItemID);

    CAHHistoryPacket PAHPacket = CAHHistoryPacket(item, stack);

    for (auto& i : HistoryList)
    {
        PAHPacket.AddItem(i);
    }

    PTCPRequest.SendToSocket(PAHPacket.GetData(), PAHPacket.GetSize());
}

search_req _HandleSearchRequest(CTCPRequestPacket& PTCPRequest)
{
    // This function constructs a `search_req` based on which query should be sent to the database.
    // The results from the database will eventually be sent to the client.

    uint32 bitOffset = 0;

    unsigned char sortDescending = 0;
    unsigned char isPresent      = 0;
    unsigned char areaCount      = 0;

    char  name[16] = {};
    uint8 nameLen  = 0;

    uint8 minLvl = 0;
    uint8 maxLvl = 0;

    uint8 jobid    = 0;
    uint8 raceid   = 255; // 255 cause race 0 is an actual filter (hume)
    uint8 nationid = 255; // 255 cause nation 0 is an actual filter (sandoria)

    uint8 minRank = 0;
    uint8 maxRank = 0;

    uint16 areas[15] = {};

    uint32 flags = 0;

    uint8* data = PTCPRequest.GetData();
    uint8  size = ref<uint8>(data, 0x10);

    uint16 workloadBits = size * 8;

    uint8 commentType = 0;

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
            if ((bitOffset + 3) >= workloadBits) // so 0000000 at the end does not get interpreted as name entry
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
                }
                break;
            }
            case SEARCH_AREA: // Area Code Entry - 10 bit
            {
                if (isPresent == 0) // no more Area entries
                {
                    ShowTrace("Area List End found.");
                }
                else // 8 Bit = 1 Byte per Area Code
                {
                    areas[areaCount] = (uint16)unpackBitsLE(&data[0x11], bitOffset, 10);
                    areaCount++;
                    bitOffset += 10;
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

                    ShowInfo("Nationality Entry found. (%2X) Sorting: (%s).\n", country, (sortDescending == 0x00) ? "ascending" : "descending");
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
                }
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
                }
                break;
            }
            case SEARCH_RACE: // Race - 4 bit
            {
                if (isPresent == 0x1)
                {
                    unsigned char race = (unsigned char)unpackBitsLE(&data[0x11], bitOffset, 4);
                    bitOffset += 4;
                    raceid = race;

                    ShowInfo("Race Entry found. (%2X) Sorting: (%s).\n", race, (sortDescending == 0x00) ? "ascending" : "descending");
                }
                ShowInfo("SortByRace: %s.\n", (sortDescending == 0x00) ? "ascending" : "descending");
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

                    ShowInfo("Rank Entry found. (%d - %d) Sorting: (%s).\n", fromRank, toRank, (sortDescending == 0x00) ? "ascending" : "descending");
                }
                ShowInfo("SortByRank: %s.\n", (sortDescending == 0x00) ? "ascending" : "descending");
                break;
            }
            case SEARCH_COMMENT: // 4 Byte
            {
                commentType = (uint8)unpackBitsLE(&data[0x11], bitOffset, 32);
                bitOffset += 32;

                ShowInfo("Comment Entry found. (%2X).\n", commentType);
                break;
            }
            // the following 4 Entries were generated with /sea (ballista|friend|linkshell|away|inv)
            // so they may be off
            case SEARCH_LINKSHELL: // 4 Byte
            {
                unsigned int lsId = (unsigned int)unpackBitsLE(&data[0x11], bitOffset, 32);
                bitOffset += 32;

                ShowInfo("Linkshell Entry found. Value: %.8X\n", lsId);
                break;
            }
            case SEARCH_FRIEND: // Friend Packet, 0 byte
            {
                ShowInfo("Friend Entry found.\n");
                break;
            }
            case SEARCH_FLAGS1: // Flag Entry #1, 2 byte,
            {
                if (isPresent == 0x1)
                {
                    unsigned short flags1 = (unsigned short)unpackBitsLE(&data[0x11], bitOffset, 16);
                    bitOffset += 16;

                    ShowInfo("Flag Entry #1 (%.4X) found. Sorting: (%s).\n", flags1, (sortDescending == 0x00) ? "ascending" : "descending");

                    flags = flags1;
                }
                ShowInfo("SortByFlags: %s\n", (sortDescending == 0 ? "ascending" : "descending"));
                break;
            }
            case SEARCH_FLAGS2: // Flag Entry #2 - 4 byte
            {
                unsigned int flags2 = (unsigned int)unpackBitsLE(&data[0x11], bitOffset, 32);

                bitOffset += 32;
                flags = flags2;
                break;
            }
            default:
            {
                ShowInfo("Unknown Search Param %.2X!\n", EntryType);
                break;
            }
        }
    }
    fmt::printf("\n");

    ShowInfo("Name: %s Job: %u Lvls: %u ~ %u ", (nameLen > 0 ? name : nullptr), jobid, minLvl, maxLvl);

    search_req sr;
    sr.jobid  = jobid;
    sr.maxlvl = maxLvl;
    sr.minlvl = minLvl;

    sr.race        = raceid;
    sr.nation      = nationid;
    sr.minRank     = minRank;
    sr.maxRank     = maxRank;
    sr.flags       = flags;
    sr.commentType = commentType;

    sr.nameLen = nameLen;
    memcpy(&sr.zoneid, areas, sizeof(sr.zoneid));
    if (nameLen > 0)
    {
        sr.name.insert(0, name);
    }

    return sr;
    // Do not process the last bits, which can interfere with other operations
    // For example: "/blacklist delete Name" and "/sea all Name"
}

/************************************************************************
 *                                                                       *
 *  Task Manager Thread                                                  *
 *                                                                       *
 ************************************************************************/

void TaskManagerThread(bool const& requestExit)
{
    duration next;
    while (!requestExit)
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
    CDataLoader data;
    data.ExpireAHItems(settings::get<uint16>("search.EXPIRE_DAYS"));

    return 0;
}

void do_final(int code)
{
    timer_final();
    socket_final();

    logging::ShutDown();

    std::exit(code);
}

void do_abort()
{
    do_final(EXIT_FAILURE);
}
