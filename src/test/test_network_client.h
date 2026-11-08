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

#pragma once

#include <common/blowfish.h>
#include <common/cbasetypes.h>
#include <common/ipp.h>

#include <array>
#include <string>
#include <vector>

class MapNetworking;
class MockSocket;

// The retail client's side of the datagram protocol, per the PS2 decomp, over MockSocket
class TestNetworkClient
{
public:
    enum class Mode : uint8
    {
        Login,     // Mode 6: sending C2S 0x00A until S2C 0x00A arrives
        Loading,   // S2C 0x00A accepted, zone loading, not yet in game
        InGame,    // Mode 9
        LoggedOut, // S2C 0x00B logout accepted in game
        Hung,      // S2C 0x00B arrived outside mode 9. Retail never recovers from this.
    };

    struct Received
    {
        uint16      type{};
        uint16      sync{};
        uint16      datagramSeq{};
        uint32      entityId{};   // the u32 at offset 4, the entity in 0x00D and 0x00E
        uint8       updateMask{}; // the byte at offset 0x0A, the update mask in 0x00D and 0x00E
        uint32      datagram{};   // count of datagrams the client has processed, from 1
        bool        accepted{};
        std::string reason{}; // why the client dropped it, empty when accepted
    };

    struct LoginFaults
    {
        bool dropReply{};   // the server's reply is lost
        bool ignoreLogin{}; // the reply arrives but its 0x00A is dropped
    };

    enum class GameOk : uint8
    {
        Accepted,
        Refused,
    };

    TestNetworkClient(MapNetworking& networking, MockSocket& socket, const IPP& ipp, uint32 charId, const blowfish_t& key);

    // Sends plaintext C2S 0x00A. Returns true once S2C 0x00A is accepted.
    auto login(const LoginFaults& faults) -> bool;

    // Sends a plaintext C2S 0x00A with a chosen header seq and source, as a late duplicate would arrive.
    void sendStaleLogin(uint16 seq, const IPP& from);

    // Sends the C2S 0x011 queued at zone-in, finishes the zone load, then sends C2S 0x00C
    void finishLoading(GameOk gameOk);

    // Sends and receives from a new address from now on, as after a NAT rebind
    void rebind(const IPP& ipp);
    auto ipp() const -> const IPP&;

    // One client send tick: a datagram with whatever is queued, then reads every reply.
    void exchange(const LoginFaults& faults);

    auto mode() const -> Mode;
    auto hangReason() const -> const std::string&;
    auto received() const -> const std::vector<Received>&;
    void clearReceived();

private:
    struct Outgoing
    {
        std::vector<uint8> bytes{};
        uint16             sync{};
    };

    void queue(std::vector<uint8> bytes);
    void sendDatagram();
    void sendPlainLogin(uint16 seq, const IPP& from);
    void readReplies(const LoginFaults& faults);
    void readDatagram(const std::vector<uint8>& bytes, const LoginFaults& faults);
    void onSubPacket(const uint8* data, uint16 sync, uint16 datagramSeq, const LoginFaults& faults);
    void pushRecvStatus(uint8 status);
    void deriveKey();
    void zoneOut();

    MapNetworking& networking_;
    MockSocket&    socket_;
    IPP            ipp_;
    uint32         charId_;
    blowfish_t     key_;

    Mode        mode_{ Mode::InGame };
    std::string hangReason_{};
    bool        zoneSetUp_{ true };
    uint16      clientSeq_{};
    uint16      serverSeq_{};
    uint16      serverAck_{};
    uint32      datagramCount_{};
    std::size_t socketCursor_{};

    std::vector<Outgoing> outgoing_{};
    std::vector<Received> received_{};
    std::array<uint8, 4>  recvStatus_{};
    bool                  pendingZoneOut_{};
};
