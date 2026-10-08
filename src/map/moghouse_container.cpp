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

#include "moghouse_container.h"

#include "alliance.h"
#include "common/database.h"
#include "entities/char_entity.h"
#include "ipc_client.h"
#include "packets/char_sync.h"
#include "party.h"
#include "utils/charutils.h"
#include "utils/zoneutils.h"

#include <algorithm>

namespace
{

void sendPartyReload(const CCharEntity* PChar)
{
    if (PChar->PParty == nullptr)
    {
        return;
    }

    if (PChar->PParty->m_PAlliance)
    {
        message::send(ipc::AllianceReload{
            .allianceId = PChar->PParty->m_PAlliance->m_AllianceID,
        });
    }
    else
    {
        message::send(ipc::PartyReload{
            .partyId = PChar->PParty->GetPartyID(),
        });
    }
}

void sendVisitorTo(CCharEntity* PChar, xi::ZoneId destination, uint32 moghouseId)
{
    PChar->ClearTrusts();

    PChar->m_moghouseID    = moghouseId;
    PChar->loc.destination = destination;
    PChar->loc.p           = {};
    PChar->loc.boundary    = 0;
    PChar->status          = xi::Status::Disappear;

    PChar->clearPacketList();
    PChar->requestedZoneChange = true;
}

} // namespace

MogHouseContainer::MogHouseContainer(CCharEntity& owner)
: owner_(owner)
{
}

auto MogHouseContainer::isOpen() const -> bool
{
    return open_;
}

void MogHouseContainer::open()
{
    open_ = true;

    db::preparedStmt("UPDATE accounts_parties SET partyflag = partyflag | ? WHERE charid = ?", PARTY_MOGHOUSE, owner_.id);
    sendPartyReload(&owner_);

    owner_.pushPacket<CCharSyncPacket>(&owner_);
}

void MogHouseContainer::close()
{
    if (!open_)
    {
        return;
    }

    open_ = false;

    db::preparedStmt("UPDATE accounts_parties SET partyflag = partyflag & ~? WHERE charid = ?", PARTY_MOGHOUSE, owner_.id);
    sendPartyReload(&owner_);

    owner_.updatemask |= UPDATE_HP;
    owner_.pushPacket<CCharSyncPacket>(&owner_);

    for (auto* PVisitor : visitors())
    {
        PVisitor->moghouse().expel();
    }

    visitors_.clear();
}

auto MogHouseContainer::visitors() -> std::vector<CCharEntity*>
{
    std::vector<CCharEntity*> visitors;

    std::erase_if(visitors_,
                  [&](const EntityId& visitorId)
                  {
                      auto* PVisitor = visitorId.resolve<CCharEntity>();
                      if (PVisitor == nullptr || PVisitor->m_moghouseID != owner_.id || PVisitor->getZone() != owner_.getZone())
                      {
                          return true;
                      }

                      visitors.emplace_back(PVisitor);
                      return false;
                  });

    return visitors;
}

void MogHouseContainer::addVisitor(CCharEntity* PVisitor)
{
    if (std::ranges::none_of(visitors_,
                             [&](const EntityId& visitorId)
                             {
                                 return visitorId == PVisitor;
                             }))
    {
        visitors_.emplace_back(PVisitor);
    }
}

auto MogHouseContainer::host() const -> CCharEntity*
{
    if (owner_.inMogHouse(xi::MogHouse::Own))
    {
        return &owner_;
    }

    if (!owner_.inMogHouse())
    {
        return nullptr;
    }

    auto* PHost = zoneutils::GetChar(owner_.m_moghouseID);
    if (PHost == nullptr || PHost->getZone() != owner_.getZone() || !PHost->inMogHouse(xi::MogHouse::Own))
    {
        return nullptr;
    }

    return PHost;
}

auto MogHouseContainer::visit(const uint32 hostId, const CBaseEntity* PNpc) -> bool
{
    if (owner_.PParty == nullptr || owner_.inMogHouse() || hostId == owner_.id)
    {
        return false;
    }

    const auto region = zoneutils::GetCurrentRegion(owner_.getZone());

    uint32 allianceId = 0;
    if (owner_.PParty->m_PAlliance)
    {
        allianceId = owner_.PParty->m_PAlliance->m_AllianceID;
    }

    const auto rset = db::preparedStmt("SELECT chars.pos_zone, chars.nation FROM accounts_parties "
                                       "JOIN chars ON chars.charid = accounts_parties.charid "
                                       "WHERE accounts_parties.charid = ? AND partyflag & ? "
                                       "AND (partyid = ? OR (allianceid <> 0 AND allianceid = ?)) LIMIT 1",
                                       hostId,
                                       PARTY_MOGHOUSE,
                                       owner_.PParty->GetPartyID(),
                                       allianceId);
    FOR_DB_SINGLE_RESULT(rset)
    {
        const auto hostZone   = rset->get<xi::ZoneId>("pos_zone");
        const auto hostNation = rset->get<uint8>("nation");
        if (zoneutils::GetCurrentRegion(hostZone) != region || !charutils::IsHomeNation(hostNation, region) || zoneutils::GetZoneIPP(hostZone) == 0)
        {
            return false;
        }

        owner_.setCharVar("mh-visit-npc", static_cast<int32>(PNpc->id));
        owner_.loc.prevzone = owner_.getZone();

        sendVisitorTo(&owner_, hostZone, hostId);

        return true;
    }

    return false;
}

void MogHouseContainer::expel()
{
    sendVisitorTo(&owner_, returnZone(), 0);
}

auto MogHouseContainer::returnZone() const -> xi::ZoneId
{
    const auto npcId       = static_cast<uint32>(owner_.getCharVar("mh-visit-npc"));
    auto       destination = owner_.loc.prevzone;
    if (npcId != 0)
    {
        destination = static_cast<xi::ZoneId>((npcId >> 12) & 0xFFF);
    }

    if (zoneutils::GetZoneIPP(destination) == 0)
    {
        destination = owner_.getZone();
    }

    return destination;
}
