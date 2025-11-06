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

#include <map>
#include <unordered_set>

#include "packets/auction_history.h"
#include "packets/auction_list.h"
#include "packets/linkshell_list.h"
#include "packets/party_list.h"
#include "packets/search_comment.h"
#include "packets/search_list.h"

search_handler::search_handler(asio::ip::tcp::socket socket, asio::io_context& io_context, SynchronizedShared<std::map<std::string, uint16_t>>& IPAddressesInUseList, SynchronizedShared<std::unordered_set<std::string>>& IPAddressWhitelist)
: socket_(std::move(socket))
, buffer_{}
, IPAddressesInUse_(IPAddressesInUseList)
, IPAddressWhitelist_(IPAddressWhitelist)
, deadline_(io_context)
{
    DebugSocketsFmt("New connection from IP {}", socket_.lowest_layer().remote_endpoint().address().to_string());

    asio::error_code ec = {};
    socket_.lowest_layer().set_option(asio::socket_base::reuse_address(true));
    ipAddress = socket_.lowest_layer().remote_endpoint(ec).address().to_string();

    if (ec)
    {
        ipAddress = "error";
        socket_.lowest_layer().close();
    }
    else
    {
        addToUsedIPAddresses(ipAddress);

        if (getNumSessionsInUse(ipAddress) > 5)
        {
            ShowErrorFmt("More than 5 simultaneous connections from {}. Closing socket.", ipAddress);
            socket_.lowest_layer().close();
            return;
        }
    }
}

search_handler::~search_handler()
{
    DebugSocketsFmt("Connection from IP {} closed", ipAddress);
    removeFromUsedIPAddresses(ipAddress);
}

void search_handler::start()
{
    if (socket_.lowest_layer().is_open())
    {
        deadline_.expires_after(10s); // AH searches can take quite a while
        deadline_.async_wait(std::bind(&search_handler::checkDeadline, this, shared_from_this()));

        do_read();
    }
}

void search_handler::do_read()
{
    std::memset(buffer_.data(), 0, buffer_.size());

    // clang-format off
    socket_.async_read_some(asio::buffer(buffer_.data(), buffer_.size()),
    [this, self = shared_from_this()](std::error_code ec, std::size_t length)
    {
        if (!ec)
        {
            DebugSocketsFmt("async_read_some: Received packet from IP {} ({} bytes)", ipAddress, length);
            read_func(length);
        }
        else
        {
            // EOF when searchPackets is empty is normal. Any other state is a legitimate error.
            if (!searchPackets.empty() || (searchPackets.empty() && ec.value() != asio::error::eof))
            {
                DebugSocketsFmt("async_read_some error in from IP {} ({}: {})", ipAddress, ec.value(), ec.message());
                handle_error(ec, self);
            }
        }
    });
    // clang-format on
}

void search_handler::do_write()
{
    auto packet = searchPackets.front();
    auto length = packet.getSize();

    std::memset(buffer_.data(), 0, buffer_.size());
    std::memcpy(buffer_.data(), packet.getData(), packet.getSize());

    searchPackets.pop_front();

    encrypt(length);

    // clang-format off
    DebugSocketsFmt("async_write: Sending packet to IP {} ({} bytes)", ipAddress, length);
    socket_.async_write_some(asio::buffer(buffer_.data(), length),
    [this, self = shared_from_this()](std::error_code ec, std::size_t /*length*/)
    {
        if (!ec)
        {
            // Apparently a reply is expected. Not sure what the reply contains exactly, but bad things happen if we don't wait for it.
            do_read();
        }
        else
        {
            DebugSocketsFmt("async_write_some error in from IP {} ({}: {})", ipAddress, ec.value(), ec.message());
            handle_error(ec, self);
        }
    });
    // clang-format on
}

void search_handler::decrypt(uint16_t length)
{
    DebugSocketsFmt("Decrypting packet from IP {} ({} bytes)", ipAddress, length);

    // Get key from packet
    ref<uint32>(key, 16) = ref<uint32>(buffer_.data(), length - 4);

    // Decrypt packet
    md5(reinterpret_cast<uint8*>(key), blowfish.hash, 20);

    blowfish_init(reinterpret_cast<int8*>(blowfish.hash), 16, blowfish.P, blowfish.S[0]);

    uint16_t tmp = (length - 12) / 4;
    tmp -= tmp % 2;

    for (uint16_t i = 0; i < tmp; i += 2)
    {
        blowfish_decipher(reinterpret_cast<uint32*>(buffer_.data()) + i + 2, reinterpret_cast<uint32*>(buffer_.data()) + i + 3, blowfish.P, blowfish.S[0]);
    }

    ref<uint32>(key, 20) = ref<uint32>(buffer_.data(), length - 0x18);
}

void search_handler::encrypt(uint16_t length)
{
    DebugSocketsFmt("Encrypting packet for IP {} ({} bytes)", ipAddress, length);

    ref<uint16>(buffer_.data(), 0x00) = length;     // packet size
    ref<uint32>(buffer_.data(), 0x04) = 0x46465849; // "IXFF"

    md5(reinterpret_cast<uint8*>(key), blowfish.hash, 24);

    blowfish_init((int8*)blowfish.hash, 16, blowfish.P, blowfish.S[0]);

    md5(buffer_.data() + 8, buffer_.data() + length - 0x18 + 0x04, length - 0x18 - 0x04);

    uint8 tmp = (length - 12) / 4;
    tmp -= tmp % 2;

    for (uint8 i = 0; i < tmp; i += 2)
    {
        blowfish_encipher(reinterpret_cast<uint32*>(buffer_.data()) + i + 2, reinterpret_cast<uint32*>(buffer_.data()) + i + 3, blowfish.P, blowfish.S[0]);
    }

    memcpy(&buffer_[length] - 0x04, key + 16, 4);
}

bool search_handler::validatePacket(uint16_t length)
{
    DebugSocketsFmt("Validating packet from IP {} ({} bytes)", ipAddress, length);

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

inline std::string searchTypeToString(uint8 type)
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

void search_handler::read_func(uint16_t length)
{
    // if we already have a query in-flight...
    if (!searchPackets.empty())
    {
        do_write();
        return;
    }

    if (length != ref<uint16>(buffer_.data(), 0x00) || length < 28)
    {
        ShowErrorFmt("Search packetsize wrong. Size {} should be {}.", length, ref<uint16>(buffer_.data(), 0x00));
        return;
    }

    deadline_.cancel(); // If we read, don't abort the deadline in the future
    decrypt(length);

    if (validatePacket(length))
    {
        uint8 packetType = buffer_[0x0B];

        ShowInfoFmt("Search Request: {} ({}), size: {}, ip: {}", searchTypeToString(packetType), packetType, length, ipAddress);

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

void search_handler::handle_error(std::error_code ec, std::shared_ptr<search_handler> self)
{
    std::ignore = ec;

    self = nullptr;
}

// Mostly copy-pasted DSP era code. It works, so why change it?
/************************************************************************
 *                                                                       *
 *  Prints the contents of the packet in `data` to the console.          *
 *                                                                       *
 ************************************************************************/

void DebugPrintPacket(char* data, uint16_t size)
{
    if (!settings::get<bool>("logging.DEBUG_PACKETS"))
    {
        return;
    }

    std::string outStr = "\n";
    for (int32 y = 0; y < size; y++)
    {
        outStr += fmt::format("{:02X} ", (uint8)data[y]);
        if (((y + 1) % 16) == 0)
        {
            outStr += "\n";
        }
    }

    // TODO: This can't be the Fmt variant because of constexpr things?
    ShowDebug(outStr);
}

/************************************************************************
 *                                                                       *
 *  Character list request (party/linkshell)                             *
 *                                                                       *
 ************************************************************************/

void search_handler::HandleGroupListRequest()
{
    uint32 partyid      = ref<uint32>(buffer_.data(), 0x10);
    uint32 allianceid   = ref<uint32>(buffer_.data(), 0x14);
    uint32 linkshellid1 = ref<uint32>(buffer_.data(), 0x18);
    uint32 linkshellid2 = ref<uint32>(buffer_.data(), 0x1C);

    ShowInfoFmt("SEARCH::PartyID = {}", partyid);
    ShowInfoFmt("SEARCH::LinkshellIDs = {}, {}", linkshellid1, linkshellid2);

    CDataLoader PDataLoader;

    if (partyid != 0 || allianceid != 0)
    {
        std::list<SearchEntity*> PartyList = PDataLoader.GetPartyList(partyid, allianceid);

        CPartyListPacket PPartyPacket(partyid, (uint32)PartyList.size());

        for (auto& it : PartyList)
        {
            PPartyPacket.AddPlayer(it);
        }

        uint16_t length = PPartyPacket.GetSize();

        DebugPrintPacket((char*)PPartyPacket.GetData(), length);
        searchPackets.emplace_back(PPartyPacket.GetData(), length);
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

            uint16_t length = PLinkshellPacket.GetSize();

            DebugPrintPacket((char*)PLinkshellPacket.GetData(), length);
            searchPackets.emplace_back(PLinkshellPacket.GetData(), length);

        } while (currentResult < totalResults);
    }

    if (!searchPackets.empty())
    {
        do_write();
    }
}

void search_handler::HandleSearchComment()
{
    uint32 playerId = ref<uint32>(buffer_.data(), 0x10);

    CDataLoader PDataLoader;
    std::string comment = PDataLoader.GetSearchComment(playerId);
    if (comment.empty())
    {
        return;
    }

    SearchCommentPacket commentPacket(playerId, comment);

    uint16_t length = commentPacket.GetSize();

    DebugPrintPacket((char*)commentPacket.GetData(), length);
    searchPackets.emplace_back(commentPacket.GetData(), length);

    do_write();
}

void search_handler::HandleSearchRequest()
{
    const search_req sr = _HandleSearchRequest();

    CDataLoader PDataLoader;
    int         totalCount = 0;

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
        {
            PSearchPacket.SetFinal();
        }

        uint16_t length = PSearchPacket.GetSize();

        DebugPrintPacket((char*)PSearchPacket.GetData(), length);
        searchPackets.emplace_back(PSearchPacket.GetData(), length);

    } while (currentResult < totalResults);

    if (!searchPackets.empty())
    {
        do_write();
    }
}

void search_handler::HandleAuctionHouseRequest()
{
    uint8 AHCatID = ref<uint8>(buffer_.data(), 0x16);

    // 2 - level
    // 3 - race
    // 4 - job
    // 5 - damage
    // 6 - delay
    // 7 - defense
    // 8 - resistance
    // 9 - name
    std::string OrderByString = "ORDER BY";
    uint8       paramCount    = ref<uint8>(buffer_.data(), 0x12);
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

        uint16_t length = PAHPacket.GetSize();
        DebugPrintPacket((char*)PAHPacket.GetData(), length);

        searchPackets.emplace_back(PAHPacket.GetData(), length);
    }

    if (!searchPackets.empty())
    {
        do_write();
    }
}

void search_handler::HandleAuctionHouseHistory()
{
    uint16 ItemID = ref<uint16>(buffer_.data(), 0x12);
    uint8  stack  = ref<uint8>(buffer_.data(), 0x15);

    CDataLoader             PDataLoader;
    std::vector<ahHistory*> HistoryList = PDataLoader.GetAHItemHistory(ItemID, stack != 0);
    ahItem                  item        = PDataLoader.GetAHItemFromItemID(ItemID);

    CAHHistoryPacket PAHPacket = CAHHistoryPacket(item, stack);

    for (auto& i : HistoryList)
    {
        PAHPacket.AddItem(i);
    }

    uint16_t length = PAHPacket.GetSize();

    DebugPrintPacket((char*)PAHPacket.GetData(), length);
    searchPackets.emplace_back(PAHPacket.GetData(), length);

    do_write();
}

search_req search_handler::_HandleSearchRequest()
{
    // This function constructs a `search_req` based on which query should be sent to the database.
    // The results from the database will eventually be sent to the client.
    search_req sr;

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

        uint8 EntryType = (uint8)unpackBitsLE(&buffer_[0x11], bitOffset, 5);
        bitOffset += 5;

        if ((EntryType != SEARCH_FRIEND) && (EntryType != SEARCH_LINKSHELL) && (EntryType != SEARCH_LINKSHELL2) && (EntryType != SEARCH_COMMENT) && (EntryType != SEARCH_FLAGS2))
        {
            if ((bitOffset + 3) >= workloadBits) // so 0000000 at the end does not get interpreted as name entry
            {
                bitOffset = workloadBits;
                break;
            }
            sortDescending = (unsigned char)unpackBitsLE(&buffer_[0x11], bitOffset, 1);
            bitOffset += 1;

            isPresent = (unsigned char)unpackBitsLE(&buffer_[0x11], bitOffset, 1);
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
                    nameLen       = (unsigned char)unpackBitsLE(&buffer_[0x11], bitOffset, 5);
                    name[nameLen] = '\0';

                    bitOffset += 5;

                    for (unsigned char i = 0; i < nameLen; i++)
                    {
                        name[i] = (char)unpackBitsLE(&buffer_[0x11], bitOffset, 7);
                        bitOffset += 7;
                    }
                }
                break;
            }
            case SEARCH_AREA: // Area Code Entry - 10 bit
            {
                if (isPresent == 0) // no more Area entries
                {
                    ShowTraceFmt("Area List End found.");
                }
                else // 8 Bit = 1 Byte per Area Code
                {
                    areas[areaCount] = (uint16)unpackBitsLE(&buffer_[0x11], bitOffset, 10);
                    areaCount++;
                    bitOffset += 10;
                }
                break;
            }
            case SEARCH_NATION: // Country - 2 bit
            {
                if (isPresent == 0x1)
                {
                    unsigned char country = (unsigned char)unpackBitsLE(&buffer_[0x11], bitOffset, 2);
                    bitOffset += 2;
                    nationid = country;

                    ShowInfoFmt("Nationality Entry found. ({}) Sorting: ({}).", hex8ToString(country), (sortDescending == 0x00) ? "ascending" : "descending");
                }
                break;
            }
            case SEARCH_JOB: // Job - 5 bit
            {
                if (isPresent == 0x1)
                {
                    unsigned char job = (unsigned char)unpackBitsLE(&buffer_[0x11], bitOffset, 5);
                    bitOffset += 5;
                    jobid = job;
                }
                break;
            }
            case SEARCH_LEVEL: // Level- 16 bit
            {
                if (isPresent == 0x1)
                {
                    unsigned char fromLvl = (unsigned char)unpackBitsLE(&buffer_[0x11], bitOffset, 8);
                    bitOffset += 8;
                    unsigned char toLvl = (unsigned char)unpackBitsLE(&buffer_[0x11], bitOffset, 8);
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
                    unsigned char race = (unsigned char)unpackBitsLE(&buffer_[0x11], bitOffset, 4);
                    bitOffset += 4;
                    raceid = race;

                    ShowInfoFmt("Race Entry found. ({}) Sorting: ({}).", hex8ToString(race), (sortDescending == 0x00) ? "ascending" : "descending");
                }
                ShowInfoFmt("SortByRace: {}.", (sortDescending == 0x00) ? "ascending" : "descending");
                break;
            }
            case SEARCH_RANK: // Rank - 2 byte
            {
                if (isPresent == 0x1)
                {
                    unsigned char fromRank = (unsigned char)unpackBitsLE(&buffer_[0x11], bitOffset, 8);
                    bitOffset += 8;
                    minRank              = fromRank;
                    unsigned char toRank = (unsigned char)unpackBitsLE(&buffer_[0x11], bitOffset, 8);
                    bitOffset += 8;
                    maxRank = toRank;

                    ShowInfoFmt("Rank Entry found. ({} - {}) Sorting: ({}).", fromRank, toRank, (sortDescending == 0x00) ? "ascending" : "descending");
                }
                ShowInfoFmt("SortByRank: {}.", (sortDescending == 0x00) ? "ascending" : "descending");
                break;
            }
            case SEARCH_COMMENT: // 4 Byte
            {
                commentType = (uint8)unpackBitsLE(&buffer_[0x11], bitOffset, 32);
                bitOffset += 32;

                ShowInfoFmt("Comment Entry found. ({}).", hex8ToString(commentType));
                break;
            }
            // the following 4 Entries were generated with /sea (ballista|friend|linkshell|away|inv)
            // so they may be off
            case SEARCH_LINKSHELL: // 4 Byte
            {
                sr.lsId = static_cast<uint32>(unpackBitsLE(&buffer_[0x11], bitOffset, 32));
                bitOffset += 32;

                ShowInfoFmt("Linkshell Entry found. Value: {}", hex32ToString(sr.lsId.value()));
                break;
            }
            case SEARCH_LINKSHELL2: // 4 Byte
            {
                sr.lsId = static_cast<uint32>(unpackBitsLE(&buffer_[0x11], bitOffset, 32));
                bitOffset += 32;

                ShowInfoFmt("Linkshell2 Entry found. Value: {}", hex32ToString(sr.lsId.value()));
                break;
            }
            case SEARCH_FRIEND: // Friend Packet, 0 byte
            {
                ShowInfoFmt("Friend Entry found.");
                break;
            }
            case SEARCH_FLAGS1: // Flag Entry #1, 2 byte,
            {
                if (isPresent == 0x1)
                {
                    unsigned short flags1 = (unsigned short)unpackBitsLE(&buffer_[0x11], bitOffset, 16);
                    bitOffset += 16;

                    ShowInfoFmt("Flag Entry #1 ({}) found. Sorting: ({}).", hex16ToString(flags1), (sortDescending == 0x00) ? "ascending" : "descending");

                    flags = flags1;
                }
                ShowInfoFmt("SortByFlags: {}", (sortDescending == 0 ? "ascending" : "descending"));
                break;
            }
            case SEARCH_FLAGS2: // Flag Entry #2 - 4 byte
            {
                unsigned int flags2 = (unsigned int)unpackBitsLE(&buffer_[0x11], bitOffset, 32);

                bitOffset += 32;
                flags = flags2;
                break;
            }
            default:
            {
                ShowInfoFmt("Unknown Search Param {}!", EntryType);
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

uint16_t search_handler::getNumSessionsInUse(std::string const& ipAddressStr)
{
    DebugSocketsFmt("Checking if IP is in use: {}", ipAddressStr);

    // clang-format off
    if (IPAddressWhitelist_.read([ipAddressStr](auto const& ipWhitelist)
    {
        return ipWhitelist.find(ipAddressStr) != ipWhitelist.end();
    }))
    {
        return 0;
    }
    // clang-format on

    // ShowInfoFmt("Checking if IP is in use: {}", ipAddressStr);
    // clang-format off
    return IPAddressesInUse_.read([ipAddressStr](auto const& ipAddrsInUse) -> uint16_t
    {
        if (ipAddrsInUse.find(ipAddressStr) != ipAddrsInUse.end())
        {
            return ipAddrsInUse.at(ipAddressStr);
        }

        return 0;
    });
    // clang-format on
}

void search_handler::removeFromUsedIPAddresses(std::string const& ipAddressStr)
{
    DebugSocketsFmt("Removing IP from active set: {}", ipAddressStr);

    // clang-format off
    if (IPAddressWhitelist_.read([ipAddressStr](auto const& ipWhitelist)
    {
        return ipWhitelist.find(ipAddressStr) != ipWhitelist.end();
    }))
    {
        return;
    }
    // clang-format on

    // ShowInfoFmt("Removing IP from set: {}", ipAddressStr);
    // clang-format off
    IPAddressesInUse_.write([ipAddressStr](auto& ipAddrsInUse)
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
    // clang-format on
}

void search_handler::addToUsedIPAddresses(std::string const& ipAddressStr)
{
    DebugSocketsFmt("Adding IP to active set: {}", ipAddressStr);

    // clang-format off
    if (IPAddressWhitelist_.read([ipAddressStr](auto const& ipWhitelist)
    {
        return ipWhitelist.find(ipAddressStr) != ipWhitelist.end();
    }))
    {
        return;
    }
    // clang-format on

    // ShowInfoFmt("Adding IP to set: {}", ipAddressStr);
    // clang-format off
    IPAddressesInUse_.write([ipAddressStr](auto& ipAddrsInUse)
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
    // clang-format on
}

void search_handler::checkDeadline(const std::shared_ptr<search_handler>& self) // self to keep the object alive
{
    if (timer::now() > deadline_.expiry())
    {
        DebugSocketsFmt("Socket timed out from {}", ipAddress);
        socket_.cancel();
    }
}
