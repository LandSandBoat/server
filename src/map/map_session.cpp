/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "map_session.h"

#include "common/md52.h"
#include "entities/char_entity.h"

namespace
{

// Seqs wrap, so one up to half the range behind another counts as older
auto isSeqAtOrBefore(const uint16 seq, const uint16 other) -> bool
{
    return static_cast<uint16>(other - seq) < 0x8000;
}

} // namespace

MapSession::MapSession()  = default;
MapSession::~MapSession() = default;

auto MapSession::hasLoadedZone() const -> bool
{
    return hasSentGameOk || timer::now() > loginTime + kZoneLoadTimeout;
}

auto MapSession::canZoneOut() const -> bool
{
    return hasLoadedZone() && timer::now() >= gameOkTime + kGameOkSettleTime;
}

auto MapSession::isStaleLogin(const uint16 seq, const IPP& from) const -> bool
{
    // The client counts from 1, and loginSeq 0 means no 0x00A taken for this key
    if (seq == 0)
    {
        return true;
    }

    // Seqs are compared per address, so a forged 0x00A from elsewhere can't put the real client's retries behind it
    const auto lastSeq = [&]() -> uint16
    {
        if (from == loginIpp)
        {
            return loginSeq;
        }

        if (from == previousLoginIpp)
        {
            return previousLoginSeq;
        }

        return 0;
    }();

    // An older or repeated seq would rewind the counters, and the client drops replies older than one it has seen
    if (lastSeq != 0 && isSeqAtOrBefore(seq, lastSeq))
    {
        return true;
    }

    // S2C 0x00B is still queued, so this retry belongs to the zone-in before it
    return blowfish.status == BLOWFISH_PENDING_ZONE && PChar != nullptr;
}

void MapSession::takeLogin(const uint16 seq, const IPP& from)
{
    // Only the first 0x00A for this key opens the load window, so retries can't hold the gate shut
    if (loginSeq == 0)
    {
        hasSentGameOk = false;
        loginTime     = timer::now();
    }

    // Keep the address before a NAT rebind, so a late retry from it is still checked against its own seq
    if (!(loginIpp == from))
    {
        previousLoginIpp = loginIpp;
        previousLoginSeq = loginSeq;
        loginIpp         = from;
    }

    loginSeq = seq;
}

void MapSession::incrementBlowfish()
{
    hasDecryptedPacket = false;
    loginSeq           = 0;
    previousLoginSeq   = 0;
    prev_blowfish      = blowfish;

    blowfish.key[4] += 2;

    initBlowfish();
}

void MapSession::initBlowfish()
{
    md5(reinterpret_cast<uint8*>(blowfish.key), blowfish.hash, 20);

    for (uint32 i = 0; i < 16; ++i)
    {
        if (blowfish.hash[i] == 0)
        {
            std::memset(blowfish.hash + i, 0, 16 - i);
            break;
        }
    }
    blowfish_init(reinterpret_cast<int8*>(blowfish.hash), 16, blowfish.P, blowfish.S[0]);
}

auto MapSession::toString() const -> std::string
{
    return fmt::format("MapSession: client_ipp: {}", client_ipp.toString());
}

void MapSession::tapLastUpdate()
{
    if (!forceLinkDead)
    {
        last_update = earth_time::now();
    }
}
