/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "test_network_client.h"

#include "mock_socket.h"

#include <common/huffman.h>
#include <common/md52.h>
#include <common/mmo.h>

#include <map/map_networking.h>
#include <map/packets/c2s/0x00c_gameok.h>
#include <map/packets/c2s/0x00d_netend.h>
#include <map/packets/c2s/0x011_zone_transition.h>

#include <algorithm>
#include <cstring>
#include <fmt/format.h>
#include <utility>

namespace
{

// The client's receive buffer. LSB caps its datagrams at 1300 bytes.
constexpr auto kMaxDatagramSize = 1360U;

// Status codes the client keeps in C2S 0x00A, from its receive path
constexpr auto kStatusBadMD5        = uint8{ 2 };
constexpr auto kStatusBadDecode     = uint8{ 3 };
constexpr auto kStatusOldDatagram   = uint8{ 6 };
constexpr auto kStatusOldSubPacket  = uint8{ 8 };
constexpr auto kStatusNoHandler     = uint8{ 10 };
constexpr auto kStatusLoginBadState = uint8{ 16 };

// The client's ZoneSetup handlers. Earlier arrivals are dropped but still acked
constexpr auto kZoneHandlers = std::to_array<uint16>({
    0x00D,
    0x00E,
    0x011,
    0x014,
    0x016,
    0x027,
    0x028,
    0x029,
    0x02A,
    0x02D,
    0x02E,
    0x02F,
    0x030,
    0x031,
    0x032,
    0x033,
    0x034,
    0x036,
    0x037,
    0x038,
    0x039,
    0x03A,
    0x03B,
    0x043,
    0x048,
    0x04B,
    0x04C,
    0x04D,
    0x051,
    0x052,
    0x053,
    0x054,
    0x055,
    0x056,
    0x057,
    0x058,
    0x059,
    0x05A,
    0x05B,
    0x05C,
    0x05D,
    0x05E,
    0x05F,
    0x060,
    0x061,
    0x062,
    0x063,
    0x065,
    0x067,
    0x068,
    0x071,
    0x072,
    0x075,
    0x076,
    0x077,
    0x081,
    0x0B7,
    0x0BF,
    0x0E6,
    0x0F9,
    0x10E,
    0x10F,
    0x110,
    0x111,
    0x112,
    0x113,
    0x115,
    0x118,
    0x119,
    0x11A,
    0x11E,
});

constexpr auto kLogoutCancel = 4U;
constexpr auto kLogoutLogout = 1U;

// The client's 16-bit sequence test: seq is in (last, last + 0x8000]
auto isNewer(const uint16 seq, const uint16 last) -> bool
{
    return static_cast<uint16>(last - seq) >= 0x8000;
}

auto makeSubPacket(const uint16 type, const std::size_t size) -> std::vector<uint8>
{
    auto bytes = std::vector<uint8>((size + 3) & ~3U);

    ref<uint16>(bytes.data(), 0) = type & 0x1FF;
    ref<uint8>(bytes.data(), 1) |= static_cast<uint8>(bytes.size() / 2);

    return bytes;
}

} // namespace

TestNetworkClient::TestNetworkClient(MapNetworking& networking, MockSocket& socket, const IPP& ipp, const uint32 charId, const blowfish_t& key)
: networking_(networking)
, socket_(socket)
, ipp_(ipp)
, charId_(charId)
, key_(key)
, socketCursor_(socket.sent.size())
{
    deriveKey();
}

auto TestNetworkClient::login(const LoginFaults& faults) -> bool
{
    if (mode_ != Mode::Login)
    {
        return false;
    }

    clientSeq_ += 1;
    if (clientSeq_ == 0)
    {
        clientSeq_ = 1;
    }

    sendPlainLogin(clientSeq_, ipp_);
    readReplies(faults);

    return mode_ == Mode::Loading;
}

void TestNetworkClient::sendStaleLogin(const uint16 seq, const IPP& from)
{
    sendPlainLogin(seq, from);
    readReplies({});
}

void TestNetworkClient::finishLoading(const GameOk gameOk)
{
    if (mode_ != Mode::Loading)
    {
        return;
    }

    // The 0x011 queued with the zone-in goes first, so its reply arrives before ZoneSetup
    sendDatagram();
    readReplies({});

    if (mode_ != Mode::Loading)
    {
        return;
    }

    // ZoneSetup, then ZoneStartOk queues C2S 0x00C
    zoneSetUp_ = true;

    auto packet = makeSubPacket(std::to_underlying(GP_CLI_COMMAND_GAMEOK::packetId), sizeof(GP_CLI_COMMAND_GAMEOK));
    if (gameOk == GameOk::Refused)
    {
        // A ClientState the handler's validation rejects
        packet[4] = 1;
    }

    queue(std::move(packet));
    sendDatagram();
    mode_ = Mode::InGame;
    readReplies({});
}

void TestNetworkClient::rebind(const IPP& ipp)
{
    ipp_ = ipp;
}

auto TestNetworkClient::ipp() const -> const IPP&
{
    return ipp_;
}

void TestNetworkClient::exchange(const LoginFaults& faults)
{
    if (mode_ != Mode::InGame && mode_ != Mode::Loading)
    {
        return;
    }

    sendDatagram();
    readReplies(faults);
}

auto TestNetworkClient::mode() const -> Mode
{
    return mode_;
}

auto TestNetworkClient::hangReason() const -> const std::string&
{
    return hangReason_;
}

auto TestNetworkClient::received() const -> const std::vector<Received>&
{
    return received_;
}

void TestNetworkClient::clearReceived()
{
    received_.clear();
}

void TestNetworkClient::queue(std::vector<uint8> bytes)
{
    outgoing_.push_back({ .bytes = std::move(bytes), .sync = 0 });
}

void TestNetworkClient::sendDatagram()
{
    clientSeq_ += 1;
    if (clientSeq_ == 0)
    {
        clientSeq_ = 1;
    }

    // Unacked sub-packets ride in every datagram, keeping the sync they were first sent with
    auto payload = std::vector<uint8>{};
    for (auto& packet : outgoing_)
    {
        if (packet.sync == 0)
        {
            packet.sync = clientSeq_;
        }

        ref<uint16>(packet.bytes.data(), 2) = packet.sync;
        payload.insert(payload.end(), packet.bytes.begin(), packet.bytes.end());
    }

    auto buffer = NetworkBuffer{};

    ref<uint16>(buffer.data(), 0) = clientSeq_;
    ref<uint16>(buffer.data(), 2) = serverSeq_;

    const auto encoded = huffman_encode(payload, std::span(buffer).subspan(FFXI_HEADER_SIZE, kMaxBufferSize - FFXI_HEADER_SIZE - sizeof(uint32) - 16));
    if (!encoded)
    {
        hangReason_ = "TestNetworkClient: huffman encode failed";
        mode_       = Mode::Hung;
        return;
    }

    const auto bitsOffset = FFXI_HEADER_SIZE + huffman_byte_size(*encoded);

    ref<uint32>(buffer.data(), bitsOffset) = *encoded;

    const auto hashOffset = bitsOffset + sizeof(uint32);
    md5(buffer.data() + FFXI_HEADER_SIZE, buffer.data() + hashOffset, static_cast<int32>(hashOffset - FFXI_HEADER_SIZE));

    const auto size = hashOffset + 16;

    const auto words = ((size - FFXI_HEADER_SIZE) / 4) & ~1U;
    blowfish_encipher_blocks(reinterpret_cast<uint32*>(buffer.data()) + 7, words / 2, key_.P, key_.S[0]);

    networking_.handle_incoming_packet({ buffer.data(), size }, ipp_);
}

void TestNetworkClient::sendPlainLogin(const uint16 seq, const IPP& from)
{
    auto login = GP_CLI_LOGIN{};

    login.id   = 0x00A;
    login.size = sizeof(GP_CLI_LOGIN) / 4;
    login.sync = seq;

    // The client's live diagnostics: connection state and the last four receive statuses
    login.unknown00 = [&]
    {
        if (serverSeq_ != 0)
        {
            return static_cast<uint16>(3);
        }

        return static_cast<uint16>(2);
    }();
    std::memcpy(&login.unknown01, recvStatus_.data(), recvStatus_.size());
    login.UniqueNo = charId_;

    const auto checksumOffset = offsetof(GP_CLI_LOGIN, unknown01);
    for (auto i = checksumOffset; i < sizeof(GP_CLI_LOGIN); ++i)
    {
        login.LoginPacketCheck += ref<uint8>(&login, i);
    }

    auto buffer = NetworkBuffer{};

    ref<uint16>(buffer.data(), 0) = seq;
    ref<uint16>(buffer.data(), 2) = serverSeq_;
    std::memcpy(buffer.data() + FFXI_HEADER_SIZE, &login, sizeof(GP_CLI_LOGIN));

    const auto hashOffset = FFXI_HEADER_SIZE + sizeof(GP_CLI_LOGIN);
    md5(buffer.data() + FFXI_HEADER_SIZE, buffer.data() + hashOffset, static_cast<int32>(sizeof(GP_CLI_LOGIN)));

    networking_.handle_incoming_packet({ buffer.data(), hashOffset + 16 }, from);
}

void TestNetworkClient::readReplies(const LoginFaults& faults)
{
    // Bounded by what the server has sent since the last read
    const auto end = socket_.sent.size();
    for (; socketCursor_ < end; ++socketCursor_)
    {
        const auto& datagram = socket_.sent[socketCursor_];
        if (datagram.ipp != ipp_ || faults.dropReply)
        {
            continue;
        }

        readDatagram(datagram.bytes, faults);
    }
}

void TestNetworkClient::readDatagram(const std::vector<uint8>& bytes, const LoginFaults& faults)
{
    if (mode_ == Mode::Hung || mode_ == Mode::LoggedOut)
    {
        return;
    }

    datagramCount_ += 1;

    const auto dropDatagram = [&](const uint8 status, const std::string& reason)
    {
        pushRecvStatus(status);
        received_.push_back({ .datagram = datagramCount_, .accepted = false, .reason = reason });
    };

    if (bytes.size() > kMaxDatagramSize || bytes.size() <= FFXI_HEADER_SIZE + sizeof(uint32) + 16)
    {
        dropDatagram(kStatusBadDecode, fmt::format("datagram size {}", bytes.size()));
        return;
    }

    auto buffer = NetworkBuffer{};
    std::memcpy(buffer.data(), bytes.data(), bytes.size());

    const auto size  = bytes.size();
    const auto words = ((size - FFXI_HEADER_SIZE) / 4) & ~1U;
    blowfish_decipher_blocks(reinterpret_cast<uint32*>(buffer.data()) + 7, words / 2, key_.P, key_.S[0]);

    auto hash = std::array<uint8, 16>{};
    md5(buffer.data() + FFXI_HEADER_SIZE, hash.data(), static_cast<int32>(size - FFXI_HEADER_SIZE - 16));
    if (std::memcmp(hash.data(), buffer.data() + size - 16, 16) != 0)
    {
        dropDatagram(kStatusBadMD5, "MD5 mismatch (wrong key)");
        return;
    }

    const auto bits    = ref<uint32>(buffer.data(), size - sizeof(uint32) - 16);
    const auto encoded = std::span<const uint8>(buffer.data() + FFXI_HEADER_SIZE, size - FFXI_HEADER_SIZE - sizeof(uint32) - 16);

    auto       decoded     = NetworkBuffer{};
    const auto decodedSize = huffman_decode(encoded, bits, decoded);
    if (!decodedSize)
    {
        dropDatagram(kStatusBadDecode, "huffman decode failed");
        return;
    }

    const auto seq = ref<uint16>(buffer.data(), 0);
    const auto ack = ref<uint16>(buffer.data(), 2);

    // Before S2C 0x00A the client has no datagram dedupe
    if (mode_ != Mode::Login && !isNewer(seq, serverSeq_))
    {
        dropDatagram(kStatusOldDatagram, fmt::format("datagram seq {} not newer than {}", seq, serverSeq_));
        return;
    }

    const auto previous = serverSeq_;

    for (auto offset = std::size_t{ 0 }; offset + 4 <= *decodedSize;)
    {
        const auto* data        = decoded.data() + offset;
        const auto  packetBytes = static_cast<std::size_t>(ref<uint8>(data, 1) & 0xFE) * 2;
        if (packetBytes == 0 || offset + packetBytes > *decodedSize)
        {
            break;
        }

        const auto sync = ref<uint16>(data, 2);
        if (!isNewer(sync, previous))
        {
            pushRecvStatus(kStatusOldSubPacket);
            received_.push_back({
                .type        = static_cast<uint16>(ref<uint16>(data, 0) & 0x1FF),
                .sync        = sync,
                .datagramSeq = seq,
                .datagram    = datagramCount_,
                .accepted    = false,
                .reason      = fmt::format("sync {} not newer than {}", sync, previous),
            });
        }
        else
        {
            onSubPacket(data, sync, seq, faults);
        }

        offset += packetBytes;
    }

    serverSeq_ = seq;
    serverAck_ = ack;

    std::erase_if(
        outgoing_,
        [&](const Outgoing& packet)
        {
            return packet.sync != 0 && !isNewer(packet.sync, serverAck_);
        });

    if (pendingZoneOut_)
    {
        pendingZoneOut_ = false;
        zoneOut();
    }
}

void TestNetworkClient::onSubPacket(const uint8* data, const uint16 sync, const uint16 datagramSeq, const LoginFaults& faults)
{
    const auto type = static_cast<uint16>(ref<uint16>(data, 0) & 0x1FF);

    auto entry = Received{
        .type        = type,
        .sync        = sync,
        .datagramSeq = datagramSeq,
        .entityId    = ref<uint32>(data, 4),
        .updateMask  = ref<uint8>(data, 0x0A),
        .datagram    = datagramCount_,
        .accepted    = true,
    };

    if (mode_ == Mode::Hung)
    {
        entry.accepted = false;
        entry.reason   = "client is hung";
    }
    else if (type == 0x00A)
    {
        if (mode_ != Mode::Login)
        {
            pushRecvStatus(kStatusLoginBadState);
            entry.accepted = false;
            entry.reason   = "S2C 0x00A outside the login state";
        }
        else if (faults.ignoreLogin)
        {
            entry.accepted = false;
            entry.reason   = "dropped by the test";
        }
        else
        {
            mode_      = Mode::Loading;
            zoneSetUp_ = false;

            auto transition = makeSubPacket(std::to_underlying(GP_CLI_COMMAND_ZONE_TRANSITION::packetId), sizeof(GP_CLI_COMMAND_ZONE_TRANSITION));
            transition[4]   = 2;
            queue(std::move(transition));
        }
    }
    else if (type == 0x00B)
    {
        const auto state = ref<uint32>(data, 4);
        if (state == kLogoutCancel)
        {
            // Cancels a zone request and is harmless in any mode
        }
        else if (mode_ != Mode::InGame)
        {
            mode_       = Mode::Hung;
            hangReason_ = fmt::format("S2C 0x00B (state {}) arrived outside mode 9", state);
        }
        else if (state == kLogoutLogout)
        {
            mode_ = Mode::LoggedOut;
        }
        else
        {
            // The rest of the datagram is read before the client switches zones
            pendingZoneOut_ = true;
        }
    }
    else if (!zoneSetUp_ && std::ranges::contains(kZoneHandlers, type))
    {
        pushRecvStatus(kStatusNoHandler);
        entry.accepted = false;
        entry.reason   = "no handler until the zone loads";
    }

    received_.push_back(std::move(entry));
}

void TestNetworkClient::pushRecvStatus(const uint8 status)
{
    if (std::ranges::contains(recvStatus_, status))
    {
        return;
    }

    std::shift_left(recvStatus_.begin(), recvStatus_.end(), 1);
    recvStatus_.back() = status;
}

void TestNetworkClient::deriveKey()
{
    md5(reinterpret_cast<uint8*>(key_.key), key_.hash, 20);

    for (auto i = 0U; i < 16; ++i)
    {
        if (key_.hash[i] == 0)
        {
            std::memset(key_.hash + i, 0, 16 - i);
            break;
        }
    }

    blowfish_init(reinterpret_cast<int8*>(key_.hash), 16, key_.P, key_.S[0]);
}

void TestNetworkClient::zoneOut()
{
    // 0x00D goes out once, under the old key, and is never resent
    outgoing_.clear();
    queue(makeSubPacket(std::to_underlying(GP_CLI_COMMAND_NETEND::packetId), sizeof(GP_CLI_COMMAND_NETEND)));
    sendDatagram();

    // The lobby DLL adds 1 to the key twice before the next zone-in
    key_.key[4] += 2;
    deriveKey();

    mode_       = Mode::Login;
    zoneSetUp_  = false;
    clientSeq_  = 0;
    serverSeq_  = 0;
    serverAck_  = 0;
    recvStatus_ = {};
    outgoing_.clear();
}
