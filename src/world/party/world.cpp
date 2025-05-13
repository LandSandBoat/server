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

#include "world.h"

#include "common/database.h"
#include "common/ipc_structs.h"
#include "common/logging.h"
#include "ipc_server.h"

struct CharDatabaseData
{
    std::string charName{};
    uint32      charId{};
    uint16      zoneId{};
    uint8       mJob{};
    uint8       mLvl{};
    uint8       sJob{};
    uint8       sLvl{};
};

auto getCharInfoFromId(uint32 charId) -> std::unique_ptr<CharDatabaseData>
{
    TracyZoneScoped;

    const auto rset = db::preparedStmt(
        "SELECT cs.mjob, cs.mlvl, cs.sjob, cs.slvl, c.pos_zone, c.charname "
        "FROM char_stats cs "
        "JOIN chars c ON cs.charid = c.charid "
        "WHERE cs.charid = ? "
        "LIMIT 1",
        charId);

    FOR_DB_SINGLE_RESULT(rset)
    {
        auto cdb = std::make_unique<CharDatabaseData>();

        cdb->mJob     = rset->get<uint8>("mjob");
        cdb->mLvl     = rset->get<uint8>("mlvl");
        cdb->sJob     = rset->get<uint8>("sjob");
        cdb->sLvl     = rset->get<uint8>("slvl");
        cdb->zoneId   = rset->get<uint16>("pos_zone");
        cdb->charId   = charId;
        cdb->charName = rset->get<std::string>("charname");

        return cdb;
    }

    return nullptr;
}

auto getCharInfoFromName(const std::string& name) -> std::unique_ptr<CharDatabaseData>
{
    const auto rset = db::preparedStmt("SELECT charid FROM chars WHERE charname = ? LIMIT 1", name);
    FOR_DB_SINGLE_RESULT(rset)
    {
        if (const auto charId = rset->get<uint32>("charid"); charId != 0)
        {
            return getCharInfoFromId(charId);
        }
    }

    ShowErrorFmt("Unable to find target with name: {}", name);
    return nullptr;
}

// Construct a new party from a PartyFullUpdateMessage sent by a map server.
WorldParty::WorldParty(const PartyFullUpdateMessage& message, IPCServer* ipcServer)
: PartyBase(message)
, m_IpcServer(ipcServer)
{
    debug("Party created from PartyFullUpdateMessage");
}

// Construct a new party from a LeaderUniqueNo.
WorldParty::WorldParty(uint32 _LeaderUniqueNo, IPCServer* ipcServer)
: PartyBase(_LeaderUniqueNo)
, m_IpcServer(ipcServer)
{
    debug("Party created from LeaderUniqueNo: {}", _LeaderUniqueNo);
}

bool WorldParty::setMemberZone(const uint32 charId, const uint16 zoneId)
{
    // Map server is notifying us that a character is zoning out or in
    // Before updating the zone, we'll handle special cases:

    // 1. If the character is the leader, we clear all trusts
    if (getLeaderId() == charId)
    {
        debug("Leader is zoning out, clearing trusts");
        clearTrusts();
    }

    size_t syncZoneMemberCount = 0;

    if (getSyncTargetId() != 0)
    {
        if (const auto maybeOldSync = getSyncTarget())
        {
            syncZoneMemberCount = getMembers({ .type = PartyMemberType::Player, .zoneId = maybeOldSync->get().getZone() }).size();
        }
    }

    if (getSyncTargetId() == charId || getLeaderId() == charId)
    {
        // 2. If party is synced and the sync target/leader is zoning out, disable sync
        debug("Removing sync target due to leader or sync target zoning out");
        clearSyncTarget(MsgStd::LevelSyncDeactivateLeftArea);
    }
    else if (getSyncTargetId() && syncZoneMemberCount < 2)
    {
        // 3. Anyone else zoning out of the sync zone, check if >= 2 members remain in the sync zone
        if (const auto maybeOldSync = getSyncTarget())
        {
            // TODO: Is the zoning character still in the sync zone?
            const auto syncZoneCount = getMembers({ .type = PartyMemberType::Player, .zoneId = maybeOldSync->get().getZone() }).size();
            if (syncZoneCount < 2)
            {
                debug("Removing sync target due to too few members in sync zone: {}", syncZoneCount);
                clearSyncTarget(MsgStd::LevelSyncRemoveTooFewMembers);
            }
        }
    }

    if (zoneId == 0xFFFF) // Logging out
    {
        return removeMember(charId);
    }

    if (const auto& member = getMemberById(charId))
    {
        debug("Setting zone for member {} to {}", charId, zoneId);
        member->get().setZone(zoneId);
        setDirty(true);
        return true;
    }

    return false;
}

bool WorldParty::setLeader(const std::string& charName)
{
    if (const auto existingMember = getMemberByName(charName))
    {
        return setLeader(existingMember->get().getId());
    }

    debug("Unable to find target member with name: {}", charName);
    return false;
}

bool WorldParty::setLeader(uint32_t UniqueNo)
{
    // TODO: Party container key
    const auto maybeMember = getMemberById(UniqueNo);

    if (maybeMember && maybeMember->get().getType() == PartyMemberType::Player)
    {
        m_LeaderUniqueNo = UniqueNo;
        m_PartyId        = UniqueNo;
        debug("Leader set to {}, changed PartyId", UniqueNo);
        // Changing leader dismisses trusts
        clearTrusts();
        setDirty(true);
        return true;
    }

    debug("Member {} not found in party", UniqueNo);
    return false;
}

bool WorldParty::setQuartermaster(const std::string& charName)
{
    if (const auto existingMember = getMemberByName(charName))
    {
        return setQuartermaster(existingMember->get().getId());
    }

    debug("Unable to find target member with name: {}", charName);
    return false;
}

bool WorldParty::setQuartermaster(uint32_t UniqueNo)
{
    if (UniqueNo == 0)
    {
        m_QuartermasterUniqueNo = 0;
        debug("Quartermaster removed");
        setDirty(true);
        return true;
    }

    if (getMemberById(UniqueNo))
    {
        m_QuartermasterUniqueNo = UniqueNo;
        debug("Quartermaster set to {}", UniqueNo);
        setDirty(true);
        return true;
    }

    debug("Member {} not found in party", UniqueNo);
    return false;
}

bool WorldParty::setSyncTarget(const std::string& charName)
{
    if (const auto existingMember = getMemberByName(charName))
    {
        return setSyncTarget(existingMember->get().getId());
    }

    debug("Unable to find target member with name: {}", charName);
    return false;
}

bool WorldParty::clearSyncTarget(const std::optional<MsgStd> reason)
{
    if (m_SyncTargetUniqueNo)
    {
        if (reason)
        {
            if (const auto syncZone = getSyncZone())
            {
                for (const auto& member : getMembers({ .type = PartyMemberType::Player, .zoneId = syncZone }))
                {
                    m_IpcServer->rerouteMessageToCharId(
                        member.get().getId(),
                        ipc::MessageBasic{
                            .recipientId = member.get().getId(),
                            .message     = *reason,
                            .param1      = 30,
                        });
                }
            }
        }

        m_SyncTargetUniqueNo = 0;
        debug("Sync target removed");
        setDirty(true);
        return true;
    }

    return false;
}

bool WorldParty::setSyncTarget(uint32_t UniqueNo)
{
    if (UniqueNo == 0)
    {
        return clearSyncTarget(std::nullopt);
    }

    if (const auto syncTarget = getMemberById(UniqueNo))
    {
        const auto syncTargetInfo = getCharInfoFromId(UniqueNo);

        // 1. Sync target must be in the same zone as the party leader
        if (syncTarget->get().getZone() != getLeader().value().get().getZone())
        {
            m_IpcServer->rerouteMessageToCharId(
                getLeaderId(),
                ipc::MessageBasic{
                    .recipientId = getLeaderId(),
                    .message     = MsgStd::LevelSyncDesigneeInOtherArea,
                });

            return false;
        }

        // 2. Sync target must be above level 10
        if (syncTargetInfo->mLvl < 10)
        {
            m_IpcServer->rerouteMessageToCharId(
                getLeaderId(),
                ipc::MessageBasic{
                    .recipientId = getLeaderId(),
                    .message     = MsgStd::LevelSyncDesigneeBelowMin,
                    .param1      = 10,
                });

            return false;
        }

        // 3. Certain status effects block sync
        // TODO: Map server is authoritative for this check in SmallPacket0x077
        // Status effects are not saved to database unless specific actions are performed, so we are unable to get a proper view from this side.

        // 4. If the target is alone in the zone, the sync is IMMEDIATELY disabled.
        // Verified to be retail accurate.
        // TODO

        m_SyncTargetUniqueNo = UniqueNo;
        debug("Sync target set to {}", UniqueNo);
        setDirty(true);
        return true;
    }

    debug("Member {} not found in party", UniqueNo);
    return false;
}

bool WorldParty::addMember(uint32_t UniqueNo, PartyMemberType type)
{
    if (getMemberById(UniqueNo))
    {
        debug("Member {} already exists in the party", UniqueNo);
        return false;
    }

    if (!isFull())
    {
        if (type == PartyMemberType::Player)
        {
            const auto newMemberInfo = getCharInfoFromId(UniqueNo);
            if (!newMemberInfo)
            {
                debug("Unable to find target member {}", UniqueNo);
                return false;
            }
            m_Members.emplace_back(UniqueNo, type, newMemberInfo->zoneId, newMemberInfo->charName, std::chrono::system_clock::to_time_t(std::chrono::system_clock::now()));
            debug("Added player {} ({}) (type {})", newMemberInfo->charName, UniqueNo, static_cast<uint8>(type));

            // Adding a player dismisses all trusts, regardless of the state of the party.
            clearTrusts();
        }
        else
        {
            // For trusts, we don't care about their name.
            // (At least while the map server is authoritative on MOST trust checks.)
            // Jury is still out on whether we want the whole trust checks to be handled on world server.
            // Their zoneId is still important, though.
            // The trusts are ALWAYS attached to the leader.
            // TODO: Rework this ugly call + optional check for edge cases.
            m_Members.emplace_back(UniqueNo, type, getLeader().value().get().getZone(), "TRUST", std::chrono::system_clock::to_time_t(std::chrono::system_clock::now()));
        }

        setDirty(true);
        return true;
    }

    debug("Party is full, cannot add member {}", UniqueNo);
    return false;
}

void WorldParty::clearTrusts()
{
    // Trusts can't be QM/Leader/SyncTarget, so we can safely remove them without checking.

    // clang-format off
    const auto removed = std::erase_if(m_Members, [](const auto& member)
    {
        return member.getType() == PartyMemberType::Trust;
    });
    // clang-format on

    if (removed > 0)
    {
        setDirty(true);
    }
}

bool WorldParty::removeMember(const std::string& charName)
{
    if (const auto existingMember = getMemberByName(charName))
    {
        return removeMember(existingMember->get().getId());
    }

    debug("Unable to find target member with name: {}", charName);
    return false;
}

bool WorldParty::removeMember(uint32 UniqueNo)
{
    auto victimMember = getMemberById(UniqueNo);
    if (!victimMember)
    {
        debug("Member {} not found in party", UniqueNo);
        return false;
    }

    if (m_SyncTargetUniqueNo == UniqueNo)
    {
        clearSyncTarget(MsgStd::LevelSyncRemoveLeftParty);
    }

    std::erase_if(m_Members, [UniqueNo](const PartyMember& member)
    {
        return member.getId() == UniqueNo;
    });

    // Handle special role reassignments
    if (m_LeaderUniqueNo == UniqueNo)
    {
        // TODO: Party system key
        reassignLeader();
    }

    if (m_QuartermasterUniqueNo == UniqueNo)
    {
        setQuartermaster(0);
    }

    debug("Removed member {}", UniqueNo);
    setDirty(true);

    // Special case: If we removed the last trust member, and only leader is left, the party is automatically disbanded.
    if (victimMember.value().get().getType() == PartyMemberType::Trust && getMemberCount() == 1)
    {
        debug("Autodisbanding party after removing last trust member");
        return disband();
    }

    return true;
}

bool WorldParty::disband()
{
    for (auto& member : getMembers())
    {
        removeMember(member.get().getId());
    }

    return true;
}
