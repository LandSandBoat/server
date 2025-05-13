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

#include "char_party.h"

#include "common/party/base.h"
#include "common/party/flags.h"
#include "entities/trustentity.h"
#include "job_points.h"
#include "latent_effect_container.h"
#include "packets/char_abilities.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/menu_config.h"
#include "packets/party_define.h"
#include "packets/party_effects.h"
#include "packets/party_member_update.h"
#include "status_effect_container.h"
#include "utils/blueutils.h"
#include "utils/charutils.h"
#include "utils/jailutils.h"
#include "utils/zoneutils.h"

CCharParty::CCharParty(const uint32 leaderId)
: PartyBase(leaderId)
{
}

CCharParty::CCharParty(const PartyFullUpdateMessage& message)
: PartyBase(message)
{
    broadcastPartyPackets();
}

// TODO: Not sure we need this logic since the container only deletes a party when all members are gone
CCharParty::~CCharParty()
{
    for (const auto member : getPlayers())
    {
        ShowErrorFmt("CCharParty destructor called with members.");
        member->clearParty();
    }
}

// If the sync target levelled up/down, recalculate everything
// TODO: No idea why this _has so much more code_ compared to applySync
void CCharParty::refreshSync(CCharEntity* PChar) const
{
    auto* PSync = getSyncTarget();

    if (!PSync)
    {
        return;
    }

    // TODO: may need a zone check
    uint8 syncLevel = PSync->jobs.job[PSync->GetMJob()];

    if (syncLevel < 10)
    {
        clearSyncTarget(MsgStd::LevelSyncRemoveLowLevel);
    }

    uint8 NewMLevel = 0;

    if (syncLevel < PChar->jobs.job[PChar->GetMJob()])
    {
        NewMLevel = syncLevel;
    }
    else
    {
        NewMLevel = PChar->jobs.job[PChar->GetMJob()];
    }

    if (PChar->GetMLevel() != NewMLevel)
    {
        charutils::RemoveAllEquipMods(PChar);
        PChar->m_LevelRestriction = NewMLevel;
        PChar->SetMLevel(NewMLevel);
        PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);
        charutils::ApplyAllEquipMods(PChar);

        blueutils::ValidateBlueSpells(PChar);
        jobpointutils::RefreshGiftMods(PChar);
        charutils::BuildingCharSkillsTable(PChar);
        charutils::CalculateStats(PChar);
        charutils::BuildingCharTraitsTable(PChar);
        charutils::BuildingCharAbilityTable(PChar);
        charutils::BuildingCharWeaponSkills(PChar);
        charutils::CheckValidEquipment(PChar);
        PChar->pushPacket<CCharAbilitiesPacket>(PChar);
    }

    PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, syncLevel, MsgStd::LevelSyncActivated);
}

void CCharParty::refreshSync() const
{
    const auto* PSync = getSyncTarget();

    if (!PSync)
    {
        return;
    }

    for (const auto& member : getPlayers({ .zoneId = PSync->getZone() }))
    {
        refreshSync(member);
    }
}

void CCharParty::applySync(CCharEntity* PChar) const
{
    const auto* PSync = getSyncTarget();

    if (!PSync)
    {
        return;
    }

    if (PChar->status != STATUS_TYPE::DISAPPEAR)
    {
        PChar->pushPacket<CMessageStandardPacket>(PSync->GetMLevel(), 0, 0, 0, MsgStd::LevelSyncSet);
        PChar->StatusEffectContainer->AddStatusEffect(
            new CStatusEffect(EFFECT_LEVEL_SYNC, EFFECT_LEVEL_SYNC, PSync->GetMLevel(), 0s, 0s), EffectNotice::Silent);
        PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE | EFFECTFLAG_ON_ZONE);
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<CCharSyncPacket>(PChar));
    }
}

void CCharParty::disableSync(const CCharEntity* PChar) const
{
    if (CStatusEffect* sync = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC);
        sync && sync->GetDuration() == 0s)
    {
        sync->SetStartTime(timer::now());
        sync->SetDuration(30s);
    }
}

// Receives party updates from the world server
// Determines changes, if any, and updates the party.
// This may trigger additional IPC messages.
void CCharParty::update(const PartyFullUpdateMessage& message)
{
    bool changes = false;

    if (message.leaderUniqueNo != m_LeaderUniqueNo)
    {
        m_LeaderUniqueNo = message.leaderUniqueNo;

        // Changing leader dismisses trusts
        // clang-format off
        ForEveryMember([&](CCharEntity* PChar)
        {
            PChar->ClearTrusts();
        });
        // clang-format on
        changes = true;
    }

    if (message.quartermasterUniqueNo != m_QuartermasterUniqueNo)
    {
        m_QuartermasterUniqueNo = message.quartermasterUniqueNo;
        changes                 = true;
    }

    if (message.syncTargetUniqueNo != m_SyncTargetUniqueNo)
    {
        if (m_SyncTargetUniqueNo == 0 && message.syncTargetUniqueNo != 0)
        {
            m_SyncTargetUniqueNo = message.syncTargetUniqueNo;
            // If sync target is on this server, apply sync effect to all in same zone.
            if (const auto* PSync = getMemberById(message.syncTargetUniqueNo))
            {
                // clang-format off
                ForEveryMember([&](CCharEntity* PChar)
                {
                    if (PChar->getZone() == PSync->getZone())
                    {
                        applySync(PChar);
                    }
                });
                // clang-format on
            }
        }
        else if (m_SyncTargetUniqueNo != 0 && message.syncTargetUniqueNo == 0)
        {
            m_SyncTargetUniqueNo = message.syncTargetUniqueNo;
            // Going from sync to no sync
            // The world server may have sent the reason as a separate message to the players
            // we are merely going to clear the sync effect.

            // clang-format off
            ForEveryMember([&](const CCharEntity* PChar)
            {
                disableSync(PChar);
            });
            // clang-format on
        }

        changes = true;
    }

    // Check if members have changed
    auto [disappeared, appeared, changed] = diff(message);

    for (const auto& member : appeared)
    {
        addMember(member);
        changes = true;
    }

    for (const auto& member : disappeared)
    {
        delMember(member);
        changes = true;
    }

    for (const auto& [oldMember, newMember] : changed)
    {
        // clang-format off
        std::ranges::replace_if(m_Members, [&oldMember](const PartyMember& member)
        {
            return member.getId() == oldMember.get().getId();
        }, newMember.get());
        // clang-format on
        changes = true;
    }

    if (changes)
    {
        broadcastPartyPackets();
    }
}

// Recalculate latents, send party define and party update packets.
// Can optionally be scoped to a single entity.
void CCharParty::broadcastPartyPackets(const CCharEntity* PSingle)
{
    // Retail packet flow:
    // 0xC8: Defines party layout
    // 0xE2: Char Info with trust data
    // 0x0E: NPC update with trust
    // 0x67: Entity status
    // 0xDF: Char update with trust data
    // 0x0E: Several NPC updates with name etc

    // clang-format off
    ForEveryMember([&](CCharEntity* PChar)
    {
        if (PSingle != nullptr && PChar != PSingle)
        {
            return;
        }

        PChar->PLatentEffectContainer->CheckLatentsPartyJobs();
        PChar->PLatentEffectContainer->CheckLatentsPartyMembers(*this);
        PChar->PLatentEffectContainer->CheckLatentsPartyAvatar();
        PChar->pushPacket<CPartyDefinePacket>(PChar, this);
        uint8 i = 0;

        for (const auto& Member : m_Members)
        {
            if (Member.getType() == PartyMemberType::Player)
            {
                PChar->pushPacket<CPartyMemberUpdatePacket>(*this, Member, PChar, i);
            }
            else if (Member.getType() == PartyMemberType::Trust)
            {
                // Trusts are special in the following ways:
                // 1. The way we build the packet is _slightly_ different
                // 2. They do not show in the party list if you're in a different zone
                // 3. They are always attached to the leader.
                // TODO: This is not how retail updates trusts but this is how LSB worked before the rewrite.

                if (const auto PLeader = getLeader(); PLeader && PLeader->getZone() == PChar->getZone())
                {
                    // PLeader is on this process and in the same zone as PChar
                    auto maybeTrust = std::ranges::find_if(PLeader->PTrusts,
                                                   [Member](const CTrustEntity* PTrust)
                                                   {
                                                       return PTrust->id == Member.getId();
                                                   });
                    if (maybeTrust != PLeader->PTrusts.end())
                    {
                        PChar->pushPacket<CPartyMemberUpdatePacket>(*maybeTrust, i);
                    }
                    else
                    {
                        ShowErrorFmt("Could not find trust with ID: {} in leader's trust list?!", Member.getId());
                    }
                }
            }

            ++i;
        }

        pushEffectsPacket(PChar);
    });
    // clang-format on
}

// Returns a vector of CBattleEntity present on this map server
// This is not guaranteed to be the full set of party members.
auto CCharParty::getMembers(const PartyMemberFilter filter) const -> std::vector<CBattleEntity*>
{
    auto  result  = std::vector<CBattleEntity*>{};
    auto* PLeader = getLeader();

    for (const auto& member : PartyBase::getMembers(filter))
    {
        if (member.get().getType() == PartyMemberType::Player)
        {
            if (auto* PChar = zoneutils::GetChar(member.get().getId()))
            {
                result.push_back(PChar);
            }
        }
        else if (member.get().getType() == PartyMemberType::Trust)
        {
            if (PLeader)
            {
                // clang-format off
                auto found = std::ranges::find_if(PLeader->PTrusts,
                    [member](const CTrustEntity* PTrust)
                    {
                        return PTrust->id == member.get().getId();
                    });
                // clang-format on

                if (found != PLeader->PTrusts.end())
                {
                    result.push_back(*found);
                }
            }
        }
    }

    return result;
}

auto CCharParty::getPlayers(PartyMemberFilter filter) const -> std::vector<CCharEntity*>
{
    filter.type = PartyMemberType::Player;
    auto result = std::vector<CCharEntity*>{};

    for (const auto& member : PartyBase::getMembers(filter))
    {
        if (auto* PChar = zoneutils::GetChar(member.get().getId()))
        {
            result.push_back(PChar);
        }
    }

    return result;
}

// Returns the entity representing the party leader
// Returns nullptr if the target is on a different map process.
auto CCharParty::getLeader() const -> CCharEntity*
{
    if (const auto maybeLeader = PartyBase::getLeader())
    {
        const PartyMember& leader = maybeLeader.value();

        if (auto* PLeader = zoneutils::GetChar(leader.getId()))
        {
            return PLeader;
        }
    }

    return nullptr;
}

// Returns the entity representing the quartermaster
// Returns nullptr if the target is on a different map process.
auto CCharParty::getQuartermaster() const -> CCharEntity*
{
    if (const auto maybeQm = PartyBase::getQuartermaster())
    {
        const PartyMember& qm = maybeQm.value();

        if (auto* PQm = zoneutils::GetChar(qm.getId()))
        {
            return PQm;
        }
    }

    return nullptr;
}

// Returns the entity representing the sync target
// Returns nullptr if the target is on a different map process.
auto CCharParty::getSyncTarget() const -> CCharEntity*
{
    if (const auto maybeSync = PartyBase::getSyncTarget())
    {
        const PartyMember& sync = maybeSync.value();

        if (auto* PSync = zoneutils::GetChar(sync.getId()))
        {
            return PSync;
        }
    }

    return nullptr;
}

// Executes an arbitrary function for each (player) party member present on this map process
void CCharParty::ForEveryMember(const std::function<void(CCharEntity*)>& func) const
{
    // clang-format off
    PartyBase::ForEveryMember({ .type = PartyMemberType::Player }, [&func](const PartyMember& member)
    {
          if (auto* charEntity = zoneutils::GetChar(member.getId()))
          {
             func(charEntity);
          }
    });
    // clang-format on
}

// Executes an arbitrary function for each (player) alliance member present on this map process
void CCharParty::ForEveryAllianceMember(std::function<void(CCharEntity*)> func)
{
    // clang-format off
    PartyBase::ForEveryAllianceMember([&func](const PartyMember& member)
    {
          if (auto* charEntity = zoneutils::GetChar(member.getId()))
          {
             func(charEntity);
          }

        // TODO: May need trust fallback if no alliance
    });
    // clang-format on
}

// Executes an arbitrary function for each party member present on this map process, including the trusts.
void CCharParty::ForEveryMemberWithTrusts(const std::function<void(CBattleEntity*)>& func) const
{
    auto* PLeader = getLeader();

    // clang-format off
    PartyBase::ForEveryMember([PLeader, &func](const PartyMember& member)
    {
        if (member.getType() == PartyMemberType::Player)
        {
            if (auto* PChar = zoneutils::GetChar(member.getId()))
            {
                func(PChar);
            }
        }
        else if (member.getType() == PartyMemberType::Trust)
        {
            if (PLeader)
            {
                // clang-format off
                const auto maybeTrust = std::ranges::find_if(PLeader->PTrusts,
                   [member](const CTrustEntity* PTrust)
                   {
                       return PTrust->id == member.getId();
                   });
                // clang-format on
                if (maybeTrust != PLeader->PTrusts.end())
                {
                    func(*maybeTrust);
                }
            }
        } });
    // clang-format on
}

// Sends PChar a packet with the party buffs.
void CCharParty::pushEffectsPacket(CCharEntity* PChar) const
{
    PChar->pushPacket<CPartyEffectsPacket>(PChar, getPlayers({ .zoneId = PChar->getZone() }));
}

// Send a packet to all members of the group if the zone is specified as 0
// or to the party members in the specified zone.
// Packet for PPartyMember is not sent in both cases
void CCharParty::pushPacket(const uint32 senderID, const uint16 ZoneID, const std::unique_ptr<CBasicPacket>& packet) const
{
    for (const auto& member : getPlayers())
    {
        if (member->id != senderID && member->status != STATUS_TYPE::DISAPPEAR && !jailutils::InPrison(member))
        {
            if (ZoneID == 0 || member->getZone() == ZoneID)
            {
                member->pushPacket(packet->copy());
            }
        }
    }
}

// Returns the player entity representing the party member with the given ID
// Returns nullptr if the target is on a different map process.
auto CCharParty::getMemberById(const uint32 charId) const -> CCharEntity*
{
    if (const auto found = PartyBase::getMemberById(charId))
    {
        return zoneutils::GetChar(found->get().getId());
    }

    return nullptr;
}

// Returns the player entity representing the party member with the given name
// Returns nullptr if the target is on a different map process.
auto CCharParty::getMemberByName(const std::string& memberName) const -> CCharEntity*
{
    if (const auto found = PartyBase::getMemberByName(memberName))
    {
        return zoneutils::GetChar(found->get().getId());
    }

    return nullptr;
}

// Sets the party ID for this party.
void CCharParty::setPartyId(const uint32 partyId)
{
    m_PartyId = partyId;
}

void CCharParty::addMember(const PartyMember& member)
{
    m_LastJoined = timer::now();
    m_Members.push_back(member);

    if (member.getType() == PartyMemberType::Player)
    {
        // Char may not be on this server and will be handled by another map process
        if (CCharEntity* PChar = zoneutils::GetChar(member.getId()))
        {
            PChar->setParty(*this);
            // this is garbage and should be handled elsewhere
            //                        ReloadTreasurePool(PChar);

            if (PChar->isSeekingParty())
            {
                PChar->playerConfig.InviteFlg = false;
                PChar->updatemask |= UPDATE_HP;

                charutils::SaveCharStats(PChar);
                charutils::SavePlayerSettings(PChar);

                PChar->pushPacket<CMenuConfigPacket>(PChar);
                PChar->pushPacket<CCharStatusPacket>(PChar);
                PChar->pushPacket<CCharSyncPacket>(PChar);
            }

            PChar->PTreasurePool->updatePool(PChar);

            // Apply level sync if the party is level synced
            if (const auto* PSync = getSyncTarget())
            {
                if (PChar->getZone() == PSync->getZone())
                {
                    applySync(PChar);
                }
            }

            // You lose all your summoned trusts upon joining a party
            // escape hatch for leaders since first trust may exist before we even join the PT
            // TODO: Route Trust summons through the party system
            if (member.getId() != m_LeaderUniqueNo)
            {
                PChar->ClearTrusts();
            }

            PChar->m_charHistory.joinedParties++;
        }
    }
}

void CCharParty::delMember(const PartyMember& member)
{
    // clang-format off
    const auto it = std::ranges::find_if(m_Members,
    [&](const PartyMember& m)
    {
        return m.getId() == member.getId();
    });
    // clang-format on

    if (it != m_Members.end())
    {
        // Char may not be on this server and will be handled by another map process
        if (it->getType() == PartyMemberType::Player)
        {
            if (CCharEntity* PChar = zoneutils::GetChar(it->getId()))
            {
                disableSync(PChar);
                PChar->clearParty();
            }
        }
        else if (it->getType() == PartyMemberType::Trust)
        {
            if (CCharEntity* PLeader = getLeader())
            {
                // clang-format off
                const auto found = std::ranges::find_if(PLeader->PTrusts,
                    [&](const CTrustEntity* PTrust)
                    {
                        return PTrust->id == it->getId();
                    });
                // clang-format on

                if (found != PLeader->PTrusts.end())
                {
                    PLeader->RemoveTrust(*found);
                }
            }
        }

        // but we still remove it from our list!
        m_Members.erase(it);
    }
}

void CCharParty::chatMessage(const ipc::ChatMessageParty& message) const
{
    pushPacket(message.senderId, 0, std::make_unique<CChatMessagePacket>(message.senderName, message.zoneId, message.messageType, message.message, message.gmLevel));
}

void CCharParty::chatMessage(const ipc::ChatMessageAlliance& message) const
{
    pushPacket(message.senderId, 0, std::make_unique<CChatMessagePacket>(message.senderName, message.zoneId, message.messageType, message.message, message.gmLevel));
}

bool CCharParty::hasJob(const uint8 job, std::optional<uint16> zoneId) const
{
    PartyMemberFilter filter{};

    if (zoneId.has_value())
    {
        filter.zoneId = zoneId.value();
    }

    for (const auto& member : getMembers(filter))
    {
        if (member->GetMJob() == job)
        {
            return true;
        }
    }

    return false;
}

bool CCharParty::isAllianced(CCharParty& other) const
{
    // TODO: Implement alliance logic
    return false;
}

bool CCharParty::isPartOfAlliance() const
{
    // TODO: Implement alliance logic
    return false;
}

// Returns the number of actual players on this map process.
size_t CCharParty::getMemberCountOnSelf() const
{
    return getPlayers().size();
}
