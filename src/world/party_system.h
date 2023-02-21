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

#include "message_server.h"

#include "common/mmo.h"

struct PartyEntry
{
    uint32 worldId;
    uint16 zoneIndex;
    uint16 zone;
    uint32 partyId;

    std::string name;

    uint8 mainLevel;
};

struct Party
{
    uint32 partyId;

    std::vector<PartyEntry> members;

    // TODO: Leader
    // TODO: Quartermaster
    // TODO: LevelSync
    // TODO: Trusts
    // TODO: TreasurePool
};

struct AllianceEntry
{

};

struct Alliance
{

};

class PartySystem
{
public:
    PartySystem()  = default;
    ~PartySystem() = default;

    void HandleIncoming(zmq::message_t* from, zmq::message_t* message)
    {
        // TODO: Forward to relevant handler
        auto payload = *reinterpret_cast<M2W_PartyInvite*>(message->data());

        // Party Invite Handler

        // TODO: Using information from payload, look up the character making the request,
        //     : and any party information related to them that we might not already have
        //     : cached.
        auto maybeParty = FindPartyByMemberWorldId(payload.senderWorldId);
        if (maybeParty.has_value())
        {
            auto party = *maybeParty;
        }

        // TODO: Ensure recipient doesn't already have a party

        // TODO: Find out which process the recipient is currently on

        W2M_PartyInvite reply;

        // TODO: Populate
        // reply.

        // TODO: Send to relevant map server
        message::send(MSG_W2M_PARTY_INVITE, );
    }

private:
    std::optional<Party> FindPartyByMemberWorldId(uint32 worldId)
    {
        // TODO: Do a better search than this
        for (auto& party : parties)
        {
            for (auto& member : party.members)
            {
                if (member.worldId == worldId)
                {
                    return party;
                }
            }
        }
        return std::nullopt;
    }

    // TODO: A container which makes parties searchable by member Id, but also
    //     : by other dimensions too.
    std::vector<Party> parties;
};
