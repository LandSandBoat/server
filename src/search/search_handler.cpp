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

#include "search_handler.h"

#include "common/md52.h"
#include "common/timer.h"
#include "common/utils.h"

#include "data_loader.h"
#include "enums/search_type.h"

#include <algorithm>
#include <cstddef>
#include <cstring>
#include <iterator>
#include <map>
#include <unordered_set>

#include "packets/auction_history.h"
#include "packets/auction_list.h"
#include "packets/linkshell_list.h"
#include "packets/party_list.h"
#include "packets/search_comment.h"
#include "packets/search_list.h"

SearchHandler::SearchHandler(Scheduler& scheduler, asio::ip::tcp::socket socket, SynchronizedShared<std::map<std::string, uint16_t>>& IPAddressesInUseList, SynchronizedShared<std::unordered_set<std::string>>& IPAddressWhitelist)
: scheduler_(scheduler)
, socket_(std::move(socket))
, buffer_{}
, IPAddressesInUse_(IPAddressesInUseList)
, IPAddressWhitelist_(IPAddressWhitelist)
{
    DebugSocketsFmt("New connection from IP {}", socket_.lowest_layer().remote_endpoint().address().to_string());

    asio::error_code ec = {};
    socket_.lowest_layer().set_option(asio::socket_base::reuse_address(true));
    ipAddress_ = socket_.lowest_layer().remote_endpoint(ec).address().to_string();

    if (ec)
    {
        ipAddress_ = "error";
        socket_.lowest_layer().close();
    }
    else
    {
        addToUsedIPAddresses(ipAddress_);

        if (getNumSessionsInUse(ipAddress_) > 5)
        {
            ShowErrorFmt("More than 5 simultaneous connections from {}. Closing socket.", ipAddress_);
            socket_.lowest_layer().close();
            return;
        }
    }
}

SearchHandler::~SearchHandler()
{
    DebugSocketsFmt("Connection from IP {} closed", ipAddress_);
    removeFromUsedIPAddresses(ipAddress_);
}

auto SearchHandler::run() -> Task<void>
{
    auto self = shared_from_this();

    try
    {
        while (socket_.lowest_layer().is_open() && !scheduler_.closeRequested())
        {
            std::memset(buffer_.data(), 0, buffer_.size());

            auto result = co_await scheduler_.withTimeout(
                socket_.async_read_some(asio::buffer(buffer_.data(), buffer_.size()), asio::use_awaitable),
                10s);

            if (!result.has_value()) // timed out
            {
                DebugSocketsFmt("Socket timed out from {}", ipAddress_);
                break;
            }

            const auto length = result.value();
            if (length == 0) // EOF
            {
                break;
            }

            DebugSocketsFmt("Received packet from IP {} ({} bytes)", ipAddress_, length);

            read_func(static_cast<uint16_t>(length));

            while (!searchPackets_.empty())
            {
                auto packet    = searchPackets_.front();
                auto write_len = packet.getSize();

                std::memset(buffer_.data(), 0, buffer_.size());
                std::memcpy(buffer_.data(), packet.getData(), write_len);

                searchPackets_.pop_front();

                encrypt(write_len);

                DebugSocketsFmt("Sending packet to IP {} ({} bytes)", ipAddress_, write_len);

                co_await socket_.async_write_some(asio::buffer(buffer_.data(), write_len), asio::use_awaitable);
            }
        }
    }
    catch (const std::exception& e)
    {
        DebugSocketsFmt("Socket error from IP {}: {}", ipAddress_, e.what());
    }

    asio::error_code ec;
    socket_.lowest_layer().close(ec);
}

void SearchHandler::decrypt(const uint16_t length)
{
    DebugSocketsFmt("Decrypting packet from IP {} ({} bytes)", ipAddress_, length);

    // Get key from packet
    ref<uint32>(key, 16) = ref<uint32>(buffer_.data(), length - 4);

    // Decrypt packet
    md5(reinterpret_cast<uint8*>(key), blowfish_.hash, 20);

    blowfish_init(reinterpret_cast<int8*>(blowfish_.hash), 16, blowfish_.P, blowfish_.S[0]);

    uint16_t tmp = (length - 12) / 4;
    tmp -= tmp % 2;

    for (uint16_t i = 0; i < tmp; i += 2)
    {
        blowfish_decipher(reinterpret_cast<uint32*>(buffer_.data()) + i + 2, reinterpret_cast<uint32*>(buffer_.data()) + i + 3, blowfish_.P, blowfish_.S[0]);
    }

    ref<uint32>(key, 20) = ref<uint32>(buffer_.data(), length - 0x18);
}

void SearchHandler::encrypt(const uint16_t length)
{
    DebugSocketsFmt("Encrypting packet for IP {} ({} bytes)", ipAddress_, length);

    ref<uint16>(buffer_.data(), 0x00) = length;     // packet size
    ref<uint32>(buffer_.data(), 0x04) = 0x46465849; // "IXFF"

    md5(reinterpret_cast<uint8*>(key), blowfish_.hash, 24);

    blowfish_init(reinterpret_cast<int8*>(blowfish_.hash), 16, blowfish_.P, blowfish_.S[0]);

    md5(buffer_.data() + 8, buffer_.data() + length - 0x18 + 0x04, length - 0x18 - 0x04);

    uint8 tmp = (length - 12) / 4;
    tmp -= tmp % 2;

    for (uint8 i = 0; i < tmp; i += 2)
    {
        blowfish_encipher(reinterpret_cast<uint32*>(buffer_.data()) + i + 2, reinterpret_cast<uint32*>(buffer_.data()) + i + 3, blowfish_.P, blowfish_.S[0]);
    }

    memcpy(&buffer_[length] - 0x04, key + 16, 4);
}

auto SearchHandler::validatePacket(const uint16_t length) -> bool
{
    DebugSocketsFmt("Validating packet from IP {} ({} bytes)", ipAddress_, length);

    // Check if packet is valid
    uint8 PacketHash[16]{};

    int32 toHash = length; // whole packet

    toHash -= 0x08; // -headersize
    toHash -= 0x10; // -hashsize
    toHash -= 0x04; // -keysize

    md5(reinterpret_cast<uint8*>(&buffer_[8]), PacketHash, toHash);

    for (uint8 i = 0; i < 16; ++i)
    {
        if (buffer_[length - 0x14 + i] != PacketHash[i])
        {
            ShowErrorFmt("Search hash wrong byte {}: {} should be {}", i, hex8ToString(PacketHash[i]), hex8ToString(buffer_[length - 0x14 + i]));
            return false;
        }
    }

    return true;
}

inline auto searchTypeToString(const uint8 type) -> std::string
{
    switch (type)
    {
        case TCP_SEARCH:
            return "SEARCH";
        case TCP_SEARCH_ALL:
            return "SEARCH_ALL";
        case TCP_SEARCH_COMMENT:
            return "SEARCH_COMMENT";
        case TCP_GROUP_LIST:
            return "GROUP_LIST";
        case TCP_AH_REQUEST:
            return "AH_REQUEST";
        case TCP_AH_REQUEST_MORE:
            return "AH_REQUEST_MORE";
        case TCP_AH_HISTORY_SINGLE:
            return "AH_HISTORY_SINGLE";
        case TCP_AH_HISTORY_STACK:
            return "AH_HISTORY_STACK";
        default:
            return "UNKNOWN";
    }
}

void SearchHandler::read_func(const uint16_t length)
{
    if (length != ref<uint16>(buffer_.data(), 0x00) || length < 28)
    {
        ShowErrorFmt("Search packetsize wrong. Size {} should be {}.", length, ref<uint16>(buffer_.data(), 0x00));
        return;
    }

    decrypt(length);

    if (validatePacket(length))
    {
        uint8 packetType = buffer_[0x0B];

        ShowInfoFmt("Search Request: {} ({}), size: {}, ip: {}", searchTypeToString(packetType), packetType, length, ipAddress_);

        switch (packetType)
        {
            case TCP_SEARCH:
            case TCP_SEARCH_ALL:
            {
                HandleSearchRequest();
            }
            break;
            case TCP_SEARCH_COMMENT:
            {
                HandleSearchComment();
            }
            break;
            case TCP_GROUP_LIST:
            {
                HandleGroupListRequest();
            }
            break;
            case TCP_AH_REQUEST:
            case TCP_AH_REQUEST_MORE:
            {
                HandleAuctionHouseRequest();
            }
            break;
            case TCP_AH_HISTORY_SINGLE:
            case TCP_AH_HISTORY_STACK:
            {
                HandleAuctionHouseHistory();
            }
            break;
            default:
            {
                ShowErrorFmt("Unknown packet type: {}", packetType);
            }
        }
    }
}

// Mostly copy-pasted DSP era code. It works, so why change it?
/************************************************************************
 *                                                                       *
 *  Prints the contents of the packet in `data` to the console.          *
 *                                                                       *
 ************************************************************************/

void DebugPrintPacket(const uint8* data, const uint16_t size)
{
    if (!settings::get<bool>("logging.DEBUG_PACKETS"))
    {
        return;
    }

    std::string outStr = "\n";
    for (int32 y = 0; y < size; y++)
    {
        outStr += fmt::format("{:02X} ", data[y]);
        if (((y + 1) % 16) == 0)
        {
            outStr += "\n";
        }
    }

    ShowDebug(outStr);
}

/************************************************************************
 *                                                                       *
 *  Character list request (party/linkshell)                             *
 *                                                                       *
 ************************************************************************/

void SearchHandler::HandleGroupListRequest()
{
    uint32       partyid      = ref<uint32>(buffer_.data(), 0x10);
    const uint32 allianceid   = ref<uint32>(buffer_.data(), 0x14);
    uint32       linkshellid1 = ref<uint32>(buffer_.data(), 0x18);
    uint32       linkshellid2 = ref<uint32>(buffer_.data(), 0x1C);

    ShowInfoFmt("SEARCH::PartyID = {}", partyid);
    ShowInfoFmt("SEARCH::LinkshellIDs = {}, {}", linkshellid1, linkshellid2);

    const CDataLoader PDataLoader;

    if (partyid != 0 || allianceid != 0)
    {
        const auto PartyList = PDataLoader.GetPartyList(partyid, allianceid);

        CPartyListPacket PPartyPacket(partyid, static_cast<uint32>(PartyList.size()));

        std::size_t membersSent = 0;
        for (const auto& player : PartyList)
        {
            if (!PPartyPacket.AddPlayer(player))
            {
                ShowWarningFmt("Party list packet full, sent {} of {} members for party {}", membersSent, PartyList.size(), partyid);
                break;
            }

            membersSent++;
        }

        uint16_t length = PPartyPacket.GetSize();

        DebugPrintPacket(PPartyPacket.GetData(), length);
        searchPackets_.emplace_back(PPartyPacket.GetData(), length);
    }
    else if (linkshellid1 != 0 || linkshellid2 != 0)
    {
        const uint32 linkshellid   = linkshellid1 == 0 ? linkshellid2 : linkshellid1;
        const auto   LinkshellList = PDataLoader.GetLinkshellList(linkshellid);

        const uint32 totalResults  = static_cast<uint32>(LinkshellList.size());
        uint32       currentResult = 0;

        // Iterate through the linkshell list, splitting up the results into
        // smaller chunks.
        auto it = LinkshellList.begin();

        do
        {
            CLinkshellListPacket PLinkshellPacket(linkshellid, totalResults);

            while (currentResult < totalResults)
            {
                const bool success = PLinkshellPacket.AddPlayer(*it);
                if (!success)
                {
                    break;
                }

                currentResult++;
                ++it;
            }

            if (currentResult == totalResults)
            {
                PLinkshellPacket.SetFinal();
            }

            uint16_t length = PLinkshellPacket.GetSize();

            DebugPrintPacket(PLinkshellPacket.GetData(), length);
            searchPackets_.emplace_back(PLinkshellPacket.GetData(), length);

        } while (currentResult < totalResults);
    }
}

void SearchHandler::HandleSearchComment()
{
    const uint32 playerId = ref<uint32>(buffer_.data(), 0x10);

    const CDataLoader PDataLoader;
    const std::string comment = PDataLoader.GetSearchComment(playerId);
    if (comment.empty())
    {
        return;
    }

    SearchCommentPacket commentPacket(playerId, comment);

    uint16_t length = commentPacket.GetSize();

    DebugPrintPacket(commentPacket.GetData(), length);
    searchPackets_.emplace_back(commentPacket.GetData(), length);
}

void SearchHandler::HandleSearchRequest()
{
    const SearchRequest sr = _HandleSearchRequest();

    const CDataLoader PDataLoader;
    int               totalCount = 0;

    const auto SearchList = PDataLoader.GetPlayersList(sr, &totalCount);

    const uint32 totalResults  = static_cast<uint32>(SearchList.size());
    uint32       currentResult = 0;

    // Iterate through the search list, splitting up the results into
    // smaller chunks.
    auto it = SearchList.begin();

    do
    {
        CSearchListPacket PSearchPacket(totalCount);

        while (currentResult < totalResults)
        {
            bool success = PSearchPacket.AddPlayer(*it);
            if (!success)
            {
                break;
            }

            currentResult++;
            ++it;
        }

        if (currentResult == totalResults)
        {
            PSearchPacket.SetFinal();
        }

        uint16_t length = PSearchPacket.GetSize();

        DebugPrintPacket(PSearchPacket.GetData(), length);
        searchPackets_.emplace_back(PSearchPacket.GetData(), length);

    } while (currentResult < totalResults);
}

void SearchHandler::HandleAuctionHouseRequest()
{
    const uint8 AHCatID = ref<uint8>(buffer_.data(), 0x16);

    // 2 - level
    // 3 - race
    // 4 - job
    // 5 - damage
    // 6 - delay
    // 7 - defense
    // 8 - resistance
    // 9 - name
    std::string OrderByString = "ORDER BY";
    const uint8 paramCount    = ref<uint8>(buffer_.data(), 0x12);
    for (uint8 i = 0; i < paramCount; ++i) // Item sort options
    {
        uint8 param = ref<uint32>(buffer_.data(), 0x18 + 8 * i);
        ShowInfoFmt(" Param{}: {}", i, param);
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

    const CDataLoader PDataLoader;
    const auto        ItemList = PDataLoader.GetAHItemsToCategory(AHCatID, OrderByArray);

    const std::size_t itemListSize = ItemList.size();
    const std::size_t PacketsCount = (itemListSize / 20) + (itemListSize % 20 != 0) + (itemListSize == 0);

    for (std::size_t i = 0; i < PacketsCount; ++i)
    {
        const std::size_t firstItem = 20 * i;

        CAHItemsListPacket PAHPacket(static_cast<uint16>(firstItem));

        PAHPacket.SetItemCount(static_cast<uint16>(itemListSize));

        for (std::size_t y = firstItem; (y < firstItem + 20) && (y < itemListSize); ++y)
        {
            PAHPacket.AddItem(ItemList.at(y));
        }

        const uint16_t length = PAHPacket.GetSize();
        DebugPrintPacket(PAHPacket.GetData(), length);

        searchPackets_.emplace_back(PAHPacket.GetData(), length);
    }
}

void SearchHandler::HandleAuctionHouseHistory()
{
    const uint16 ItemID = ref<uint16>(buffer_.data(), 0x12);
    const uint8  stack  = ref<uint8>(buffer_.data(), 0x15);

    const CDataLoader      PDataLoader;
    const auto             HistoryList = PDataLoader.GetAHItemHistory(ItemID, stack != 0);
    const AuctionHouseItem item        = PDataLoader.GetAHItemFromItemID(ItemID);

    CAHHistoryPacket PAHPacket = CAHHistoryPacket(item, stack);

    for (const auto& i : HistoryList)
    {
        PAHPacket.AddItem(i);
    }

    uint16_t length = PAHPacket.GetSize();

    DebugPrintPacket(PAHPacket.GetData(), length);
    searchPackets_.emplace_back(PAHPacket.GetData(), length);
}

auto SearchHandler::_HandleSearchRequest() -> SearchRequest
{
    // This function constructs a `search_req` based on which query should be sent to the database.
    // The results from the database will eventually be sent to the client.
    SearchRequest sr;

    uint32 bitOffset = 0;

    unsigned char sortDescending = 0;
    unsigned char isPresent      = 0;
    unsigned char areaCount      = 0;

    char  name[16] = {};
    uint8 nameLen  = 0;

    uint8 minLvl = 0;
    uint8 maxLvl = 0;

    uint8 jobid    = 0;
    uint8 raceid   = 255; // 255 because race 0 is an actual filter (hume)
    uint8 nationid = 255; // 255 because nation 0 is an actual filter (sandoria)

    uint8 minRank = 0;
    uint8 maxRank = 0;

    uint16 areas[15] = {};

    uint32 flags = 0;

    uint8 size = ref<uint8>(buffer_.data(), 0x10);

    uint16 workloadBits = size * 8;

    uint8 commentType = 0;

    while (bitOffset < workloadBits)
    {
        if ((bitOffset + 5) >= workloadBits)
        {
            bitOffset = workloadBits;
            break;
        }

        const auto EntryType = static_cast<SearchType>(unpackBitsLE(&buffer_[0x11], bitOffset, 5));
        bitOffset += 5;

        if ((EntryType != SearchType::Friend) && (EntryType != SearchType::Linkshell) && (EntryType != SearchType::Linkshell2) && (EntryType != SearchType::Comment) && (EntryType != SearchType::Flags2))
        {
            if ((bitOffset + 3) >= workloadBits) // so 0000000 at the end does not get interpreted as name entry
            {
                bitOffset = workloadBits;
                break;
            }
            sortDescending = static_cast<unsigned char>(unpackBitsLE(&buffer_[0x11], bitOffset, 1));
            bitOffset += 1;

            isPresent = static_cast<unsigned char>(unpackBitsLE(&buffer_[0x11], bitOffset, 1));
            bitOffset += 1;
        }

        switch (EntryType)
        {
            case SearchType::Name:
            {
                if (isPresent == 0x1) // Name send
                {
                    if ((bitOffset + 5) >= workloadBits)
                    {
                        bitOffset = workloadBits;
                        break;
                    }
                    // 5-bit field (0-31) clamped to name's 15 chars; still consume every char
                    const uint8 rawNameLen = static_cast<uint8>(unpackBitsLE(&buffer_[0x11], bitOffset, 5));
                    bitOffset += 5;

                    nameLen       = std::min<uint8>(rawNameLen, sizeof(name) - 1);
                    name[nameLen] = '\0';

                    for (uint8 i = 0; i < rawNameLen; i++)
                    {
                        const auto nameChar = static_cast<char>(unpackBitsLE(&buffer_[0x11], bitOffset, 7));
                        bitOffset += 7;

                        if (i < nameLen)
                        {
                            name[i] = nameChar;
                        }
                    }
                }
                break;
            }
            case SearchType::Area: // Area Code Entry - 10 bit
            {
                if (isPresent == 0) // no more Area entries
                {
                    ShowTraceFmt("Area List End found.");
                }
                else // 8 Bit = 1 Byte per Area Code
                {
                    const auto area = static_cast<uint16>(unpackBitsLE(&buffer_[0x11], bitOffset, 10));
                    bitOffset += 10;

                    // client controls entry count; only store while areas[] has room
                    if (areaCount < std::size(areas))
                    {
                        areas[areaCount] = area;
                        areaCount++;
                    }
                }
                break;
            }
            case SearchType::Nation: // Country - 2 bit
            {
                if (isPresent == 0x1)
                {
                    unsigned char country = static_cast<unsigned char>(unpackBitsLE(&buffer_[0x11], bitOffset, 2));
                    bitOffset += 2;
                    nationid = country;

                    ShowInfoFmt("Nationality Entry found. ({}) Sorting: ({}).", hex8ToString(country), (sortDescending == 0x00) ? "ascending" : "descending");
                }
                break;
            }
            case SearchType::Job: // Job - 5 bit
            {
                if (isPresent == 0x1)
                {
                    unsigned char job = static_cast<unsigned char>(unpackBitsLE(&buffer_[0x11], bitOffset, 5));
                    bitOffset += 5;
                    jobid = job;
                }
                break;
            }
            case SearchType::Level: // Level- 16 bit
            {
                if (isPresent == 0x1)
                {
                    unsigned char fromLvl = static_cast<unsigned char>(unpackBitsLE(&buffer_[0x11], bitOffset, 8));
                    bitOffset += 8;
                    unsigned char toLvl = static_cast<unsigned char>(unpackBitsLE(&buffer_[0x11], bitOffset, 8));
                    bitOffset += 8;
                    minLvl = fromLvl;
                    maxLvl = toLvl;
                }
                break;
            }
            case SearchType::Race: // Race - 4 bit
            {
                if (isPresent == 0x1)
                {
                    unsigned char race = static_cast<unsigned char>(unpackBitsLE(&buffer_[0x11], bitOffset, 4));
                    bitOffset += 4;
                    raceid = race;

                    ShowInfoFmt("Race Entry found. ({}) Sorting: ({}).", hex8ToString(race), (sortDescending == 0x00) ? "ascending" : "descending");
                }
                ShowInfoFmt("SortByRace: {}.", (sortDescending == 0x00) ? "ascending" : "descending");
                break;
            }
            case SearchType::Rank: // Rank - 2 byte
            {
                if (isPresent == 0x1)
                {
                    unsigned char fromRank = static_cast<unsigned char>(unpackBitsLE(&buffer_[0x11], bitOffset, 8));
                    bitOffset += 8;
                    minRank              = fromRank;
                    unsigned char toRank = static_cast<unsigned char>(unpackBitsLE(&buffer_[0x11], bitOffset, 8));
                    bitOffset += 8;
                    maxRank = toRank;

                    ShowInfoFmt("Rank Entry found. ({} - {}) Sorting: ({}).", fromRank, toRank, (sortDescending == 0x00) ? "ascending" : "descending");
                }
                ShowInfoFmt("SortByRank: {}.", (sortDescending == 0x00) ? "ascending" : "descending");
                break;
            }
            case SearchType::Comment: // 4 Byte
            {
                commentType = static_cast<uint8>(unpackBitsLE(&buffer_[0x11], bitOffset, 32));
                bitOffset += 32;

                ShowInfoFmt("Comment Entry found. ({}).", hex8ToString(commentType));
                break;
            }
            // the following 4 Entries were generated with /sea (ballista|friend|linkshell|away|inv)
            // so they may be off
            case SearchType::Linkshell: // 4 Byte
            {
                sr.lsId = static_cast<uint32>(unpackBitsLE(&buffer_[0x11], bitOffset, 32));
                bitOffset += 32;

                ShowInfoFmt("Linkshell Entry found. Value: {}", hex32ToString(sr.lsId.value()));
                break;
            }
            case SearchType::Linkshell2: // 4 Byte
            {
                sr.lsId = static_cast<uint32>(unpackBitsLE(&buffer_[0x11], bitOffset, 32));
                bitOffset += 32;

                ShowInfoFmt("Linkshell2 Entry found. Value: {}", hex32ToString(sr.lsId.value()));
                break;
            }
            case SearchType::Friend: // Friend Packet, 0 byte
            {
                ShowInfoFmt("Friend Entry found.");
                break;
            }
            case SearchType::Flags1: // Flag Entry #1, 2 byte,
            {
                if (isPresent == 0x1)
                {
                    unsigned short flags1 = static_cast<unsigned short>(unpackBitsLE(&buffer_[0x11], bitOffset, 16));
                    bitOffset += 16;

                    ShowInfoFmt("Flag Entry #1 ({}) found. Sorting: ({}).", hex16ToString(flags1), (sortDescending == 0x00) ? "ascending" : "descending");

                    flags = flags1;
                }
                ShowInfoFmt("SortByFlags: {}", (sortDescending == 0 ? "ascending" : "descending"));
                break;
            }
            case SearchType::Flags2: // Flag Entry #2 - 4 byte
            {
                unsigned int flags2 = static_cast<unsigned int>(unpackBitsLE(&buffer_[0x11], bitOffset, 32));

                bitOffset += 32;
                flags = flags2;
                break;
            }
            default:
            {
                ShowInfoFmt("Unknown Search Param {}!", static_cast<uint8>(EntryType));
                break;
            }
        }
    }

    const auto printableName = nameLen > 0 ? name : "<empty>";
    ShowInfoFmt("Name: {} Job: {} Lvls: {} ~ {}", printableName, jobid, minLvl, maxLvl);

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

auto SearchHandler::getNumSessionsInUse(const std::string& ipAddressStr) const -> uint16_t
{
    DebugSocketsFmt("Checking if IP is in use: {}", ipAddressStr);

    if (IPAddressWhitelist_.read(
            [ipAddressStr](const auto& ipWhitelist)
            {
                return ipWhitelist.find(ipAddressStr) != ipWhitelist.end();
            }))
    {
        return 0;
    }

    return IPAddressesInUse_.read(
        [ipAddressStr](const auto& ipAddrsInUse) -> uint16_t
        {
            if (ipAddrsInUse.find(ipAddressStr) != ipAddrsInUse.end())
            {
                return ipAddrsInUse.at(ipAddressStr);
            }

            return 0;
        });
}

void SearchHandler::removeFromUsedIPAddresses(const std::string& ipAddressStr) const
{
    DebugSocketsFmt("Removing IP from active set: {}", ipAddressStr);

    if (IPAddressWhitelist_.read(
            [ipAddressStr](const auto& ipWhitelist)
            {
                return ipWhitelist.find(ipAddressStr) != ipWhitelist.end();
            }))
    {
        return;
    }

    IPAddressesInUse_.write(
        [ipAddressStr](auto& ipAddrsInUse)
        {
            if (ipAddrsInUse.find(ipAddressStr) != ipAddrsInUse.end())
            {
                ipAddrsInUse[ipAddressStr] -= 1;
            }
            else // Removing nothing, do nothing.
            {
                return;
            }

            // If we got here, check if we want to remove an IP from the map
            if (ipAddrsInUse[ipAddressStr] <= 0)
            {
                ipAddrsInUse.erase(ipAddressStr);
            }
        });
}

void SearchHandler::addToUsedIPAddresses(const std::string& ipAddressStr) const
{
    DebugSocketsFmt("Adding IP to active set: {}", ipAddressStr);

    if (IPAddressWhitelist_.read(
            [ipAddressStr](const auto& ipWhitelist)
            {
                return ipWhitelist.find(ipAddressStr) != ipWhitelist.end();
            }))
    {
        return;
    }

    IPAddressesInUse_.write(
        [ipAddressStr](auto& ipAddrsInUse)
        {
            if (ipAddrsInUse.find(ipAddressStr) == ipAddrsInUse.end())
            {
                ipAddrsInUse[ipAddressStr] = 1;
            }
            else
            {
                ipAddrsInUse[ipAddressStr] += 1;
            }
        });
}
