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

#include "common/logging.h"
#include "common/timer.h"

#include "alliance.h"
#include "entities/battleentity.h"
#include "ipc_client.h"
#include "job_points.h"
#include "latent_effect_container.h"
#include "party.h"
#include "status_effect_container.h"
#include "treasure_pool.h"
#include "utils/blueutils.h"
#include "utils/charutils.h"
#include "utils/jailutils.h"
#include "utils/zoneutils.h"
#include <cstring>
#include <vector>

#include "packets/c2s/0x077_group_change2.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/s2c/0x009_message.h"
#include "packets/s2c/0x029_battle_message.h"
#include "packets/s2c/0x076_group_effects.h"
#include "packets/s2c/0x0ac_command_data.h"
#include "packets/s2c/0x0b4_config.h"
#include "packets/s2c/0x0c8_group_tbl.h"
#include "packets/s2c/0x0dd_group_list.h"

// should have brace-or-equal initializers when MSVC supports it
struct CParty::partyInfo_t
{
    uint32      id         = {};
    uint32      partyid    = {};
    uint32      allianceid = {};
    std::string name       = {};
    uint16      flags      = {};
    uint16      zone       = {};
    uint16      prev_zone  = {};
};

// Constructor
CParty::CParty(CBattleEntity* PEntity)
: m_PartyID(0)
, m_PartyType(PARTY_MOBS)
, m_PartyNumber(0)
{
    m_PLeader        = nullptr;
    m_PAlliance      = nullptr;
    m_PSyncTarget    = nullptr;
    m_PQuarterMaster = nullptr;
    m_EffectsChanged = false;

    if (PEntity != nullptr && PEntity->PParty == nullptr)
    {
        m_PartyID   = PEntity->id;
        m_PartyType = PEntity->objtype == TYPE_PC ? PARTY_PCS : PARTY_MOBS;

        AddMember(PEntity);
        SetLeader(PEntity->name);
    }
    else
    {
        ShowWarning("CParty::CParty() - PEntity was null, or party was not null.");
    }
}

CParty::CParty(uint32 id)
: m_PartyID(id)
, m_PartyType(PARTY_PCS)
, m_PartyNumber(0)
{
    m_PAlliance = nullptr;

    m_PLeader        = nullptr;
    m_PSyncTarget    = nullptr;
    m_PQuarterMaster = nullptr;

    m_EffectsChanged = false;
}

// Dirty, ugly hack to prevent bad refs keeping garbage pointers in memory pointing to things that _could_ still be valid, causing mayhem
CParty::~CParty()
{
    m_PLeader        = nullptr;
    m_PartyID        = 0;
    m_PAlliance      = nullptr;
    m_PSyncTarget    = nullptr;
    m_PQuarterMaster = nullptr;
}

void CParty::DisbandParty(bool playerInitiated)
{
    if (m_PAlliance)
    {
        m_PAlliance->removeParty(this);
    }

    m_PSyncTarget = nullptr;
    m_PLeader     = nullptr;
    m_PAlliance   = nullptr;

    if (m_PartyType == PARTY_PCS)
    {
        SetQuarterMaster("");

        this->PushPacket(0, 0, std::make_unique<GP_SERV_COMMAND_GROUP_TBL>(nullptr));

        for (auto& member : members)
        {
            CCharEntity* PChar = (CCharEntity*)member;
            PChar->ClearTrusts();

            PChar->PParty = nullptr;
            PChar->PLatentEffectContainer->CheckLatentsPartyJobs();
            PChar->PLatentEffectContainer->CheckLatentsPartyMembers(members.size(), 0);
            PChar->PLatentEffectContainer->CheckLatentsPartyAvatar();
            PChar->pushPacket<GP_SERV_COMMAND_GROUP_LIST>(PChar, 0, 0, PChar->getZone());

            // TODO: TreasurePool should stay with the last character, but now it is not critical

            if (PChar->PTreasurePool != nullptr && PChar->PTreasurePool->getPoolType() != TreasurePoolType::Zone)
            {
                PChar->PTreasurePool->delMember(PChar);
                PChar->PTreasurePool = new CTreasurePool(TreasurePoolType::Solo);
                PChar->PTreasurePool->addMember(PChar);
                PChar->PTreasurePool->updatePool(PChar);
            }
            CStatusEffect* sync = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC);
            if (sync && sync->GetDuration() == 0s)
            {
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 30, MsgStd::LevelSyncRemoveLeftParty);
                sync->SetStartTime(timer::now());
                sync->SetDuration(30s);
            }

            db::preparedStmt("DELETE FROM accounts_parties WHERE charid = ?", PChar->id);
        }

        // make sure message server isn't notified of a disband if this came from the message server already
        if (playerInitiated)
        {
            message::send(ipc::PartyDisband{
                .partyId = m_PartyID,
            });
        }
    }
    else if (m_PartyType == PARTY_MOBS)
    {
        for (auto& member : members) // this should really only trigger when a dynamic entity dies and nothing else qualifies for it's party anymore (such as !fafnir in zones without dragons)
        {
            member->PParty = nullptr;
        }
    }

    // TODO: This entire system needs rewriting to both:
    //     : - Make it stable
    //     : - Get rid of `delete this` and manage memory nicely
    delete this; // cpp.sh allow
}

// Assign roles to group members (players only)
void CParty::AssignPartyRole(const std::string& MemberName, const GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND role)
{
    if (m_PartyType != PARTY_PCS)
    {
        ShowWarningFmt("Attempting to assign role ({}) to {} in Mob Party.", static_cast<uint8_t>(role), MemberName);
        return;
    }

    // Make sure that the character is actually a part of this party
    const auto rset = db::preparedStmt("SELECT chars.charid FROM chars JOIN accounts_parties ON accounts_parties.charid = chars.charid WHERE charname = ? AND partyid = ?", MemberName, m_PartyID);
    if (!rset || rset->rowsCount() == 0)
    {
        return;
    }

    switch (role)
    {
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::SetPartyLeader:
            SetLeader(MemberName);
            break;
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::SetQuartermaster:
            SetQuarterMaster(MemberName);
            break;
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::SetLottery:
            SetQuarterMaster("");
            break;
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::SetLevelSync:
            SetSyncTarget(MemberName, MsgStd::LevelSyncSet);
            break;
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::DisableLevelSync:
            SetSyncTarget("", MsgStd::LevelSyncRemoveLeftParty);
            break;
        default:
            return;
    }

    if (m_PAlliance)
    {
        message::send(ipc::AllianceReload{
            .allianceId = m_PAlliance->m_AllianceID,
        });
    }
    else
    {
        message::send(ipc::PartyReload{
            .partyId = m_PartyID,
        });
    }
}

// get number of members in specified zone
uint8 CParty::MemberCount(uint16 ZoneID)
{
    uint8 count = 0;

    for (auto member : members)
    {
        if (member->getZone() == ZoneID)
        {
            count++;
        }
        if (member->objtype == TYPE_PC)
        {
            // clang-format off
            auto* charMember = static_cast<CCharEntity*>(member);
            std::for_each(charMember->PTrusts.begin(), charMember->PTrusts.end(), [&](CTrustEntity* trust)
            {
                count++;
            });
            // clang-format on
        }
    }
    return count;
}

// Returns entity pointer to party member by name (used for /pcmd kick or otherwise)
CBattleEntity* CParty::GetMemberByName(const std::string& memberName)
{
    if (m_PartyType != PARTY_PCS)
    {
        ShowWarning("Attempting to get Member data for %s in Mob Party.", memberName);
        return nullptr;
    }

    if (memberName == "")
    {
        return nullptr;
    }

    for (auto& member : members)
    {
        if (strcmpi(memberName.c_str(), member->getName().c_str()) == 0)
        {
            return member;
        }
    }

    return nullptr;
}

void CParty::RemoveMember(CBattleEntity* PEntity)
{
    if (PEntity == nullptr || PEntity->PParty != this)
    {
        ShowWarning("CParty::RemoveMember() - PEntity was null, or PParty mismatch.");
        return;
    }

    if (m_PLeader == PEntity)
    {
        RemovePartyLeader(PEntity);

        // Remove their trusts
        CCharEntity* PChar = dynamic_cast<CCharEntity*>(PEntity);
        if (PChar)
        {
            PChar->ClearTrusts();
        }
    }
    else
    {
        auto memberToDelete = std::find(members.begin(), members.end(), PEntity);

        if (memberToDelete != members.end())
        {
            if (m_PartyType == PARTY_PCS && PEntity->objtype == TYPE_PC)
            {
                CCharEntity* PChar = static_cast<CCharEntity*>(PEntity);

                if (m_PQuarterMaster == PChar)
                {
                    SetQuarterMaster("");
                }
                if (m_PSyncTarget == PChar)
                {
                    SetSyncTarget("", MsgStd::LevelSyncRemoveLeftParty);
                    CStatusEffect* sync = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC);
                    if (sync && sync->GetDuration() == 0s)
                    {
                        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 30, MsgStd::LevelSyncRemoveLeftParty);
                        sync->SetStartTime(timer::now());
                        sync->SetDuration(30s);
                    }
                    DisableSync();
                }
                if (m_PSyncTarget != nullptr && m_PSyncTarget != PChar)
                {
                    if (PChar->status != STATUS_TYPE::DISAPPEAR)
                    {
                        CStatusEffect* sync = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC);
                        if (sync && sync->GetDuration() == 0s)
                        {
                            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 30, MsgStd::LevelSyncRemoveLeftParty);
                            sync->SetStartTime(timer::now());
                            sync->SetDuration(30s);
                        }
                    }
                }

                size_t trustCount = 0;
                if (m_PLeader != nullptr)
                {
                    trustCount = static_cast<CCharEntity*>(m_PLeader)->PTrusts.size();
                }

                PChar->PLatentEffectContainer->CheckLatentsPartyMembers(members.size(), trustCount);

                PChar->pushPacket<GP_SERV_COMMAND_GROUP_TBL>(nullptr);
                PChar->pushPacket<GP_SERV_COMMAND_GROUP_LIST>(PChar, 0, 0, PChar->getZone());
                PChar->pushPacket<CCharStatusPacket>(PChar);

                db::preparedStmt("DELETE FROM accounts_parties WHERE charid = ?", PChar->id);

                if (m_PAlliance)
                {
                    message::send(ipc::AllianceReload{
                        .allianceId = m_PAlliance->m_AllianceID,
                    });
                }
                else
                {
                    message::send(ipc::PartyReload{
                        .partyId = m_PartyID,
                    });
                }

                if (PChar->PTreasurePool != nullptr && PChar->PTreasurePool->getPoolType() != TreasurePoolType::Zone)
                {
                    PChar->PTreasurePool->delMember(PChar);
                    PChar->PTreasurePool = new CTreasurePool(TreasurePoolType::Solo);
                    PChar->PTreasurePool->addMember(PChar);
                    PChar->PTreasurePool->updatePool(PChar);
                }
            }

            members.erase(memberToDelete);
            PEntity->PParty = nullptr;
        }
    }
}

void CParty::DelMember(CBattleEntity* PEntity)
{
    if (PEntity == nullptr || PEntity->PParty != this)
    {
        ShowWarning("CParty::DelMember() - PEntity was null, or PParty mismatch.");
        return;
    }

    if (m_PLeader == PEntity)
    {
        if (RemovePartyLeader(PEntity)) // Only reload party if party has not disbanded
        {
            this->ReloadParty();
        }
    }
    else
    {
        auto memberToDelete = std::find(members.begin(), members.end(), PEntity);

        if (memberToDelete != members.end())
        {
            if (m_PartyType == PARTY_PCS && PEntity->objtype == TYPE_PC)
            {
                CCharEntity* PChar = static_cast<CCharEntity*>(PEntity);

                if (m_PQuarterMaster == PChar)
                {
                    SetQuarterMaster("");
                }
                if (m_PSyncTarget == PChar)
                {
                    SetSyncTarget("", MsgStd::LevelSyncRemoveLeftParty);
                    CStatusEffect* sync = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC);
                    if (sync && sync->GetDuration() == 0s)
                    {
                        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 30, MsgStd::LevelSyncRemoveLeftParty);
                        sync->SetStartTime(timer::now());
                        sync->SetDuration(30s);
                    }
                    DisableSync();
                }
                if (m_PSyncTarget != nullptr && m_PSyncTarget != PChar)
                {
                    if (PChar->status != STATUS_TYPE::DISAPPEAR)
                    {
                        CStatusEffect* sync = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC);
                        if (sync && sync->GetDuration() == 0s)
                        {
                            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 30, MsgStd::LevelSyncRemoveLeftParty);
                            sync->SetStartTime(timer::now());
                            sync->SetDuration(30s);
                        }
                    }
                }
                PChar->PLatentEffectContainer->CheckLatentsPartyMembers(members.size(), 0);

                PChar->pushPacket<GP_SERV_COMMAND_GROUP_TBL>(nullptr);
                PChar->pushPacket<GP_SERV_COMMAND_GROUP_LIST>(PChar, 0, 0, PChar->getZone());
                PChar->pushPacket<CCharStatusPacket>(PChar);
                PChar->PParty = nullptr;

                if (PChar->PTreasurePool != nullptr && PChar->PTreasurePool->getPoolType() != TreasurePoolType::Zone)
                {
                    PChar->PTreasurePool->delMember(PChar);
                    PChar->PTreasurePool = new CTreasurePool(TreasurePoolType::Solo);
                    PChar->PTreasurePool->addMember(PChar);
                    PChar->PTreasurePool->updatePool(PChar);
                }
            }
            else
            {
                PEntity->PParty = nullptr;
            }
            members.erase(memberToDelete);
        }
        this->ReloadParty();
    }
}

void CParty::PopMember(CBattleEntity* PEntity)
{
    if (PEntity == nullptr || PEntity->PParty != this)
    {
        ShowWarning("CParty::PopMember() - PEntity was null, or PParty mismatch.");
        return;
    }

    auto memberToDelete = std::find(members.begin(), members.end(), PEntity);

    if (memberToDelete != members.end())
    {
        members.erase(memberToDelete);
    }

    // free memory, party will re reinsatiated when they zone back in
    if (members.empty())
    {
        if (m_PAlliance)
        {
            if (m_PAlliance->getMainParty() == this)
            {
                m_PAlliance->setMainParty(nullptr);
            }

            auto it = m_PAlliance->partyList.begin();
            while (it != m_PAlliance->partyList.end())
            {
                if (this == *it)
                {
                    it = m_PAlliance->partyList.erase(it);
                    continue;
                }
                it++;
            }
        }
        delete this; // cpp.sh allow
    }
    PEntity->PParty = nullptr;
}

bool CParty::RemovePartyLeader(CBattleEntity* PEntity)
{
    if (members.empty())
    {
        ShowWarning("CParty::RemovePartyLeader - called when \"member\" list was empty");
        return false;
    }

    if (m_PartyType != PARTYTYPE::PARTY_MOBS)
    {
        const auto rset = db::preparedStmt("SELECT charname FROM accounts_sessions JOIN chars ON accounts_sessions.charid = chars.charid "
                                           "JOIN accounts_parties ON accounts_parties.charid = chars.charid WHERE partyid = ? AND NOT partyflag & ? "
                                           "ORDER BY timestamp ASC LIMIT 1",
                                           m_PartyID, PARTY_LEADER);
        if (rset && rset->rowsCount() && rset->next())
        {
            std::string newLeader = rset->get<std::string>("charname");
            SetLeader(newLeader);
        }
    }

    if (m_PartyType == PARTYTYPE::PARTY_MOBS) // mob party, mob destructor being called and is leader of a party
    {
        for (auto member : members)
        {
            if (member != PEntity) // assign leader to next party member
            {
                m_PLeader = member;
                DelMember(PEntity);

                return true;
            }
        }
    }

    if (m_PLeader == PEntity)
    {
        DisbandParty();
        return false;
    }
    else
    {
        RemoveMember(PEntity);
    }

    return true;
}

std::vector<CParty::partyInfo_t> CParty::GetPartyInfo() const
{
    std::vector<CParty::partyInfo_t> memberinfo;

    if (m_PartyType != PARTY_PCS)
    {
        ShowWarning("Attempting to get Party data for Mob Party.");
        return memberinfo;
    }

    const auto rset = db::preparedStmt("SELECT chars.charid, partyid, allianceid, charname, partyflag, pos_zone, pos_prevzone FROM accounts_parties "
                                       "LEFT JOIN chars ON accounts_parties.charid = chars.charid WHERE "
                                       "(allianceid <> 0 AND allianceid = ?) OR partyid = ? ORDER BY partyflag & ?, timestamp",
                                       m_PAlliance ? m_PAlliance->m_AllianceID : 0, m_PartyID, PARTY_SECOND | PARTY_THIRD);
    if (rset && rset->rowsCount())
    {
        while (rset->next())
        {
            memberinfo.emplace_back(CParty::partyInfo_t{
                .id         = rset->get<uint32>("charid"),
                .partyid    = rset->get<uint32>("partyid"),
                .allianceid = rset->get<uint32>("allianceid"),
                .name       = rset->get<std::string>("charname"),
                .flags      = rset->get<uint16>("partyflag"),
                .zone       = rset->get<uint16>("pos_zone"),
                .prev_zone  = rset->get<uint16>("pos_prevzone"),
            });
        }
    }

    return memberinfo;
}

void CParty::AddMember(CBattleEntity* PEntity)
{
    if (PEntity == nullptr || PEntity->PParty != nullptr)
    {
        ShowWarning("CParty::AddMember() - PEntity was null, or PParty not null.");
        return;
    }

    if (std::find(members.begin(), members.end(), PEntity) != members.end())
    {
        ShowWarning("CParty::AddMember() - PEntity was already in the member list!");
        return;
    }

    if (PEntity->objtype == TYPE_PC && m_PartyType == PARTY_PCS && IsFull())
    {
        ShowWarning("CParty::AddMember() - Party was full when trying to add a member.");
        return;
    }

    if (PEntity->objtype == TYPE_PC && m_PartyType == PARTY_PCS && HasTrusts())
    {
        ShowWarning("CParty::AddMember() - Party had summoned trusts when trying to add a member.");
        return;
    }

    PEntity->PParty = this;
    members.emplace_back(PEntity);

    if (PEntity->objtype == TYPE_PC && this->members.size() > 1)
    {
        auto* PLeader = dynamic_cast<CCharEntity*>(CParty::GetLeader());

        if (PLeader)
        {
            PLeader->m_LeaderCreatedPartyTime = timer::now();
        }
    }

    if (m_PartyType == PARTY_PCS)
    {
        CCharEntity* PChar = dynamic_cast<CCharEntity*>(PEntity);

        if (!PEntity)
        {
            ShowWarning("Non-Player passed into function (%s).", PEntity->getName());
            return;
        }

        uint32 allianceid = 0;
        if (m_PAlliance)
        {
            allianceid = m_PAlliance->m_AllianceID;
        }

        db::preparedStmt("INSERT INTO accounts_parties (charid, partyid, allianceid, partyflag) VALUES (?, ?, ?, ?)",
                         PChar->id, m_PartyID, allianceid, GetMemberFlags(PChar));

        if (m_PAlliance)
        {
            message::send(ipc::AllianceReload{
                .allianceId = m_PAlliance->m_AllianceID,
            });
        }
        else
        {
            message::send(ipc::PartyReload{
                .partyId = m_PartyID,
            });
        }

        ReloadTreasurePool(PChar);

        if (PChar->isSeekingParty())
        {
            PChar->playerConfig.InviteFlg = false;
            PChar->updatemask |= UPDATE_HP;

            charutils::SaveCharStats(PChar);
            charutils::SavePlayerSettings(PChar);

            PChar->pushPacket<GP_SERV_COMMAND_CONFIG>(PChar);
            PChar->pushPacket<CCharStatusPacket>(PChar);
            PChar->pushPacket<CCharSyncPacket>(PChar);
        }

        PChar->PTreasurePool->updatePool(PChar);

        // Apply level sync if the party is level synced
        if (m_PSyncTarget != nullptr)
        {
            if (PChar->getZone() == m_PSyncTarget->getZone())
            {
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, m_PSyncTarget->GetMLevel(), MsgStd::LevelSyncActivated);
                PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_LEVEL_SYNC, EFFECT_LEVEL_SYNC, m_PSyncTarget->GetMLevel(), 0s, 0s), EffectNotice::Silent);
                PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE | EFFECTFLAG_ON_ZONE);
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<CCharSyncPacket>(PChar));
            }
        }

        // You lose all your summoned trusts upon joining a party
        PChar->ClearTrusts();

        PChar->m_charHistory.joinedParties++;
    }
}

void CParty::AddMember(uint32 id)
{
    if (m_PartyType == PARTY_PCS)
    {
        if (IsFull())
        {
            ShowWarning("CParty::AddMember() - Party was full when trying to add a member from out of zone.");
            return;
        }

        if (HasTrusts())
        {
            ShowWarning("CParty::AddMember() - Party had summoned trusts when trying to add a member.");
            return;
        }

        uint32 allianceid = 0;
        uint16 Flags      = 0;
        if (m_PAlliance)
        {
            allianceid = m_PAlliance->m_AllianceID;
            if (this->m_PartyNumber == 1)
            {
                Flags = PARTY_SECOND;
            }
            else if (this->m_PartyNumber == 2)
            {
                Flags = PARTY_THIRD;
            }
        }

        db::preparedStmt("INSERT INTO accounts_parties (charid, partyid, allianceid, partyflag) VALUES (?, ?, ?, ?)",
                         id, m_PartyID, allianceid, Flags);

        if (m_PAlliance)
        {
            message::send(ipc::AllianceReload{
                .allianceId = m_PAlliance->m_AllianceID,
            });
        }
        else
        {
            message::send(ipc::PartyReload{
                .partyId = m_PartyID,
            });
        }

        /*if (PChar->nameflags.flags & FLAG_INVITE)
        {
            PChar->nameflags.flags ^= FLAG_INVITE;
            PChar->updatemask |= UPDATE_HP;

            charutils::SaveCharStats(PChar);

            PChar->status = STATUS_UPDATE;
            PChar->pushPacket<GP_SERV_COMMAND_CONFIG>(PChar);
            PChar->pushPacket<CCharStatusPacket>(PChar);
            PChar->pushPacket<CCharSyncPacket>(PChar);
        }
        PChar->PTreasurePool->UpdatePool(PChar);*/
    }
}

void CParty::PushMember(CBattleEntity* PEntity)
{
    if (PEntity == nullptr || PEntity->PParty != nullptr)
    {
        ShowWarning("CParty::PushMember() - PEntity was null, or PParty not null.");
        return;
    }

    PEntity->PParty = this;
    members.emplace_back(PEntity);

    auto info = GetPartyInfo();

    for (auto&& memberinfo : info)
    {
        if (memberinfo.id == PEntity->id)
        {
            if (memberinfo.flags & PARTY_LEADER)
            {
                m_PLeader = PEntity;
            }
            if (memberinfo.flags & PARTY_QM)
            {
                m_PQuarterMaster = PEntity;
            }
            if (memberinfo.flags & PARTY_SYNC)
            {
                m_PSyncTarget = PEntity;
            }
        }
    }

    ReloadTreasurePool((CCharEntity*)PEntity);
}

void CParty::SetPartyID(uint32 id)
{
    m_PartyID = id;
}

uint32 CParty::GetPartyID() const
{
    return m_PartyID;
}

CBattleEntity* CParty::GetLeader()
{
    return m_PLeader;
}

CBattleEntity* CParty::GetSyncTarget()
{
    return m_PSyncTarget;
}

CBattleEntity* CParty::GetQuaterMaster()
{
    return m_PQuarterMaster;
}

uint16 CParty::GetMemberFlags(CBattleEntity* PEntity)
{
    if (PEntity == nullptr || PEntity->PParty != this)
    {
        ShowWarning("CParty::GetMemberFlags() - PEntity was null, or PParty mismatch.");
        return 0;
    }

    uint16 Flags = 0;

    if (PEntity->PParty->m_PAlliance != nullptr)
    {
        if (PEntity == m_PLeader && PEntity->PParty->m_PAlliance->getMainParty() == PEntity->PParty)
        {
            Flags |= ALLIANCE_LEADER;
        }
    }

    if (PEntity->PParty->m_PartyNumber == 1)
    {
        Flags += PARTY_SECOND;
    }
    else if (PEntity->PParty->m_PartyNumber == 2)
    {
        Flags += PARTY_THIRD;
    }

    if (PEntity == m_PLeader)
    {
        Flags |= PARTY_LEADER;
    }
    if (PEntity == m_PQuarterMaster)
    {
        Flags |= PARTY_QM;
    }
    if (PEntity == m_PSyncTarget)
    {
        Flags |= PARTY_SYNC;
    }

    return Flags;
}

// update the party for all members
void CParty::ReloadParty()
{
    if (m_PartyType == PARTYTYPE::PARTY_MOBS) // Mob parties don't need to send packets
    {
        return;
    }

    auto info = GetPartyInfo();

    // alliance
    if (this->m_PAlliance != nullptr)
    {
        for (auto&& party : m_PAlliance->partyList)
        {
            party->RefreshFlags(info);
            for (auto&& member : party->members)
            {
                CCharEntity* PChar = (CCharEntity*)member;
                PChar->ReloadPartyDec();
                uint16 alliance = 0;
                PChar->pushPacket<GP_SERV_COMMAND_GROUP_TBL>(party);
                // auto effects = std::make_unique<GP_SERV_COMMAND_GROUP_EFFECTS>();
                uint8 j = 0;
                for (auto&& memberinfo : info)
                {
                    if ((memberinfo.flags & (PARTY_SECOND | PARTY_THIRD)) != alliance)
                    {
                        alliance = memberinfo.flags & (PARTY_SECOND | PARTY_THIRD);
                        j        = 0;
                    }
                    auto* PPartyMember = zoneutils::GetChar(memberinfo.id);
                    if (PPartyMember)
                    {
                        PChar->pushPacket<GP_SERV_COMMAND_GROUP_LIST>(PPartyMember, j, memberinfo.flags, PChar->getZone());
                        // if (memberinfo.partyid == party->GetPartyID() && PPartyMember != PChar)
                        //    effects->AddMemberEffects(PChar);
                    }
                    else
                    {
                        uint16 zoneid = memberinfo.zone == 0 ? memberinfo.prev_zone : memberinfo.zone;
                        PChar->pushPacket<GP_SERV_COMMAND_GROUP_LIST>(memberinfo.id, memberinfo.name, memberinfo.flags, j, zoneid);
                    }
                    j++;
                }
                // PChar->pushPacket(effects.release());
            }
        }
    }
    else
    {
        RefreshFlags(info);
        CBattleEntity* PLeader    = GetLeader();
        size_t         trustCount = 0;

        if (PLeader != nullptr)
        {
            trustCount = static_cast<CCharEntity*>(PLeader)->PTrusts.size();
        }

        // regular party
        for (auto& member : members)
        {
            CCharEntity* PChar = (CCharEntity*)member;

            PChar->PLatentEffectContainer->CheckLatentsPartyJobs();
            PChar->PLatentEffectContainer->CheckLatentsPartyMembers(members.size(), trustCount);
            PChar->PLatentEffectContainer->CheckLatentsPartyAvatar();
            PChar->ReloadPartyDec();
            PChar->pushPacket<GP_SERV_COMMAND_GROUP_TBL>(this, PLeader && PChar->getZone() == PLeader->getZone());
            // auto effects = std::make_unique<GP_SERV_COMMAND_GROUP_EFFECTS>();
            uint8 j = 0;
            for (auto&& memberinfo : info)
            {
                auto* PPartyMember = zoneutils::GetChar(memberinfo.id);
                if (PPartyMember)
                {
                    PChar->pushPacket<GP_SERV_COMMAND_GROUP_LIST>(PPartyMember, j, memberinfo.flags, PChar->getZone());

                    // Inject the party leader's trusts into the party list
                    CBattleEntity* PLeader = GetLeader();
                    if (PLeader != nullptr)
                    {
                        for (auto* PTrust : ((CCharEntity*)PLeader)->PTrusts)
                        {
                            j++;
                            // trusts don't persist over zonelines, so we know their zone has be the same as the leader.
                            PChar->pushPacket<GP_SERV_COMMAND_GROUP_LIST>(PTrust, j);
                        }
                    }
                }
                else
                {
                    uint16 zoneid = memberinfo.zone == 0 ? memberinfo.prev_zone : memberinfo.zone;
                    PChar->pushPacket<GP_SERV_COMMAND_GROUP_LIST>(memberinfo.id, memberinfo.name, memberinfo.flags, j, zoneid);
                }
                j++;
            }
        }
    }
}

// update party info for PChar
void CParty::ReloadPartyMembers(CCharEntity* PChar)
{
    if (PChar == nullptr)
    {
        ShowWarning("CParty::ReloadPartyMembers() - PChar was null.");
        return;
    }

    PChar->ReloadPartyDec();
    PChar->pushPacket<GP_SERV_COMMAND_GROUP_TBL>(this);

    int alliance = 0;

    auto info = GetPartyInfo();
    RefreshFlags(info);
    uint8 j = 0;
    for (auto&& memberinfo : info)
    {
        if ((memberinfo.flags & (PARTY_SECOND | PARTY_THIRD)) != alliance)
        {
            alliance = memberinfo.flags & (PARTY_SECOND | PARTY_THIRD);
            j        = 0;
        }
        CCharEntity* PPartyMember = zoneutils::GetChar(memberinfo.id);
        if (PPartyMember)
        {
            PChar->pushPacket<GP_SERV_COMMAND_GROUP_LIST>(PPartyMember, j, memberinfo.flags, PChar->getZone());
        }
        else
        {
            uint16 zoneid = memberinfo.zone == 0 ? memberinfo.prev_zone : memberinfo.zone;
            PChar->pushPacket<GP_SERV_COMMAND_GROUP_LIST>(memberinfo.id, memberinfo.name, memberinfo.flags, j, zoneid);
        }
        j++;
    }
}

// update treasure pool for specified character
void CParty::ReloadTreasurePool(CCharEntity* PChar)
{
    if (PChar == nullptr)
    {
        ShowWarning("CParty::ReloadTreasurePool() - PChar was null.");
        return;
    }

    if (PChar->PTreasurePool != nullptr && PChar->PTreasurePool->getPoolType() == TreasurePoolType::Zone)
    {
        return;
    }

    // alliance
    if (PChar->PParty != nullptr)
    {
        if (PChar->PParty->m_PAlliance != nullptr)
        {
            for (std::size_t a = 0; a < PChar->PParty->m_PAlliance->partyList.size(); ++a)
            {
                for (std::size_t i = 0; i < PChar->PParty->m_PAlliance->partyList.at(a)->members.size(); ++i)
                {
                    CCharEntity* PPartyMember = (CCharEntity*)PChar->PParty->m_PAlliance->partyList.at(a)->members.at(i);

                    if (PPartyMember != PChar && PPartyMember->PTreasurePool != nullptr && PPartyMember->getZone() == PChar->getZone())
                    {
                        if (PChar->PTreasurePool != nullptr)
                        {
                            PChar->PTreasurePool->delMember(PChar);
                        }
                        PChar->PTreasurePool = PPartyMember->PTreasurePool;
                        PChar->PTreasurePool->addMember(PChar);
                        return;
                    }
                }

            } // regular party
        }
        else if (PChar->PParty->m_PAlliance == nullptr)
        {
            for (auto& member : members)
            {
                CCharEntity* PPartyMember = (CCharEntity*)member;

                if (PPartyMember != PChar && PPartyMember->PTreasurePool != nullptr && PPartyMember->getZone() == PChar->getZone())
                {
                    if (PChar->PTreasurePool != nullptr)
                    {
                        PChar->PTreasurePool->delMember(PChar);
                    }
                    PChar->PTreasurePool = PPartyMember->PTreasurePool;
                    PChar->PTreasurePool->addMember(PChar);
                    return;
                }
            }
        }
    }

    if (PChar->PTreasurePool == nullptr)
    {
        PChar->PTreasurePool = new CTreasurePool(TreasurePoolType::Solo);
        PChar->PTreasurePool->addMember(PChar);
    }
}

void CParty::SetLeader(const std::string& MemberName)
{
    if (m_PartyType == PARTY_PCS)
    {
        uint32 newId = 0;

        const auto rset = db::preparedStmt("SELECT chars.charid from accounts_sessions JOIN chars ON chars.charid = accounts_sessions.charid WHERE charname = ?", MemberName);
        if (rset && rset->rowsCount() && rset->next())
        {
            newId = rset->get<uint32>(0);
        }
        else
        {
            return;
        }

        db::preparedStmt("UPDATE accounts_parties SET partyflag = partyflag & ~? WHERE partyid = ? AND partyflag & ?", ALLIANCE_LEADER | PARTY_LEADER, m_PartyID, PARTY_LEADER);
        db::preparedStmt("UPDATE accounts_parties SET partyid = ? WHERE partyid = ?", newId, m_PartyID);
        db::preparedStmt("UPDATE accounts_parties SET allianceid = ? WHERE allianceid = ?", newId, m_PartyID);

        m_PLeader = GetMemberByName(MemberName);
        if (this->m_PAlliance && this->m_PAlliance->m_AllianceID == m_PartyID)
        {
            m_PAlliance->m_AllianceID = newId;
        }

        m_PartyID = newId;
        db::preparedStmt("UPDATE accounts_parties SET partyflag = partyflag | IF(allianceid = partyid, ?, ?) WHERE charid = ?", ALLIANCE_LEADER | PARTY_LEADER, PARTY_LEADER, newId);

        // Passing leader dismisses trusts
        for (auto* PMemberEntity : members)
        {
            if (auto* PMember = dynamic_cast<CCharEntity*>(PMemberEntity))
            {
                PMember->ClearTrusts();
            }
        }
    }
    else
    {
        m_PLeader = members.at(0);
    }
}

void CParty::SetSyncTarget(const std::string& MemberName, MsgStd message)
{
    CBattleEntity* PEntity = GetMemberByName(MemberName);

    if (settings::get<bool>("map.LEVEL_SYNC_ENABLE"))
    {
        if (PEntity && PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)PEntity;
            // enable level sync
            if (PChar->GetMLevel() < 10)
            {
                ((CCharEntity*)GetLeader())->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>((CCharEntity*)GetLeader(), (CCharEntity*)GetLeader(), 0, 10, MsgStd::LevelSyncDesigneeBelowMin);
                return;
            }
            else if (PChar->getZone() != GetLeader()->getZone())
            {
                ((CCharEntity*)GetLeader())->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>((CCharEntity*)GetLeader(), (CCharEntity*)GetLeader(), 0, 0, MsgStd::LevelSyncDesigneeInOtherArea);
                return;
            }
            else
            {
                for (auto& member : members)
                {
                    if (member->StatusEffectContainer->HasStatusEffect({ EFFECT_LEVEL_RESTRICTION, EFFECT_LEVEL_SYNC, EFFECT_SJ_RESTRICTION, EFFECT_CONFRONTATION, EFFECT_BATTLEFIELD }))
                    {
                        ((CCharEntity*)GetLeader())->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>((CCharEntity*)GetLeader(), (CCharEntity*)GetLeader(), 0, 0, MsgStd::LevelSyncPreventedByStatus);
                        return;
                    }
                }
                m_PSyncTarget = PChar;
                for (auto& i : members)
                {
                    if (i->objtype != TYPE_PC)
                    {
                        continue;
                    }

                    CCharEntity* member = (CCharEntity*)i;

                    if (member->status != STATUS_TYPE::DISAPPEAR && member->getZone() == PChar->getZone())
                    {
                        member->pushPacket<GP_SERV_COMMAND_MESSAGE>(PChar->GetMLevel(), 0, 0, 0, message);
                        member->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_LEVEL_SYNC, EFFECT_LEVEL_SYNC, PChar->GetMLevel(), 0s, 0s), EffectNotice::Silent);
                        member->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE | EFFECTFLAG_ON_ZONE);
                        member->loc.zone->PushPacket(member, CHAR_INRANGE, std::make_unique<CCharSyncPacket>(member));
                    }
                }
                db::preparedStmt("UPDATE accounts_parties SET partyflag = partyflag & ~? WHERE partyid = ? AND partyflag & ?",
                                 PARTY_SYNC, m_PartyID, PARTY_SYNC);
                db::preparedStmt("UPDATE accounts_parties SET partyflag = partyflag | ? WHERE partyid = ? AND charid = ?",
                                 PARTY_SYNC, m_PartyID, PChar->id);
            }
        }
        else
        {
            if (m_PSyncTarget != nullptr)
            {
                // disable level sync
                for (auto& i : members)
                {
                    if (i->objtype != TYPE_PC)
                    {
                        continue;
                    }

                    CCharEntity* member = (CCharEntity*)i;

                    if (member->status != STATUS_TYPE::DISAPPEAR)
                    {
                        CStatusEffect* sync = member->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC);
                        if (sync && sync->GetDuration() == 0s)
                        {
                            member->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(member, member, 0, 30, message);
                            sync->SetStartTime(timer::now());
                            sync->SetDuration(30s);
                        }
                    }
                }
            }
            m_PSyncTarget = nullptr;
            db::preparedStmt("UPDATE accounts_parties SET partyflag = partyflag & ~? WHERE partyid = ? AND partyflag & ?",
                             PARTY_SYNC, m_PartyID, PARTY_SYNC);
        }
    }
}

// FIXME: add case for "" membername
void CParty::SetQuarterMaster(const std::string& MemberName)
{
    CBattleEntity* PEntity = GetMemberByName(MemberName);
    m_PQuarterMaster       = PEntity;

    db::preparedStmt("UPDATE accounts_parties SET partyflag = partyflag & ~? WHERE partyid = ? AND partyflag & ?", PARTY_QM, m_PartyID, PARTY_QM);

    if (PEntity != nullptr)
    {
        db::preparedStmt("UPDATE accounts_parties JOIN chars ON accounts_parties.charid = chars.charid "
                         "SET partyflag = partyflag | ? WHERE partyid = ? AND charname = ?",
                         PARTY_QM, m_PartyID, MemberName);
    }
}

// Send a packet to all members of the group if the zone is specified as 0
// or to the party members in the specified zone.
// Packet for PPartyMember is not sent in both cases
void CParty::PushPacket(uint32 senderID, uint16 ZoneID, const std::unique_ptr<CBasicPacket>& packet)
{
    for (auto& i : members)
    {
        if (i == nullptr || i->objtype != TYPE_PC)
        {
            continue;
        }

        CCharEntity* member = (CCharEntity*)i;

        if (member->id != senderID && member->status != STATUS_TYPE::DISAPPEAR && !jailutils::InPrison(member))
        {
            if (ZoneID == 0 || member->getZone() == ZoneID)
            {
                member->pushPacket(packet->copy());
            }
        }
    }
}

void CParty::PushEffectsPacket()
{
    if (m_EffectsChanged)
    {
        auto info = GetPartyInfo();

        for (auto& PMember : members)
        {
            auto*                     PMemberChar = static_cast<CCharEntity*>(PMember);
            std::vector<CCharEntity*> sameZoneMembers;

            for (auto& memberinfo : info)
            {
                if (memberinfo.partyid == m_PartyID && memberinfo.id != PMemberChar->id)
                {
                    auto* PPartyMember = zoneutils::GetChar(memberinfo.id);
                    if (PPartyMember && PPartyMember->getZone() == PMemberChar->getZone())
                    {
                        sameZoneMembers.push_back(PPartyMember);
                    }
                }
            }

            // Make and send packet for PMemberChar
            PMemberChar->pushPacket<GP_SERV_COMMAND_GROUP_EFFECTS>(sameZoneMembers);
        }
        m_EffectsChanged = false;
    }
}

void CParty::EffectsChanged()
{
    m_EffectsChanged = true;
}

void CParty::DisableSync()
{
    m_PSyncTarget = nullptr;
    ReloadParty();
}

void CParty::RefreshSync()
{
    CCharEntity* sync      = (CCharEntity*)m_PSyncTarget;
    uint8        syncLevel = sync->jobs.job[sync->GetMJob()];
    if (syncLevel < 10)
    {
        SetSyncTarget("", MsgStd::LevelSyncRemoveLowLevel);
    }
    for (auto& i : members)
    {
        if (i->objtype != TYPE_PC || i->getZone() != sync->getZone())
        {
            continue;
        }

        CCharEntity* member = (CCharEntity*)i;

        uint8 NewMLevel = 0;

        if (syncLevel < member->jobs.job[member->GetMJob()])
        {
            NewMLevel = syncLevel;
        }
        else
        {
            NewMLevel = member->jobs.job[member->GetMJob()];
        }

        if (member->GetMLevel() != NewMLevel)
        {
            charutils::RemoveAllEquipMods(member);
            member->m_LevelRestriction = NewMLevel;
            member->SetMLevel(NewMLevel);
            member->SetSLevel(member->jobs.job[member->GetSJob()]);
            charutils::ApplyAllEquipMods(member);

            blueutils::ValidateBlueSpells(member);
            jobpointutils::RefreshGiftMods(member);
            charutils::BuildingCharSkillsTable(member);
            charutils::CalculateStats(member);
            charutils::BuildingCharTraitsTable(member);
            charutils::BuildingCharAbilityTable(member);
            charutils::BuildingCharWeaponSkills(member);
            charutils::CheckValidEquipment(member);
            member->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(member);
        }
        member->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(member, member, 0, syncLevel, MsgStd::LevelSyncActivated);
    }
    m_PSyncTarget = sync;
}

void CParty::SetPartyNumber(uint8 number)
{
    m_PartyNumber = number;
}

bool CParty::HasOnlyOneMember() const
{
    if (members.size() != 1)
    {
        return false;
    }

    // Load party size to make sure that there is only one member in the party across all servers
    return LoadPartySize() == 1;
}

bool CParty::IsFull() const
{
    if (members.size() > 5)
    {
        return true;
    }

    // Load party size to make sure that that all members are accounted for across all servers
    return LoadPartySize() > 5;
}

uint32 CParty::LoadPartySize() const
{
    if (m_PartyType != PARTYTYPE::PARTY_PCS)
    {
        return static_cast<uint32>(members.size());
    }

    const auto rset = db::preparedStmt("SELECT COUNT(*) FROM accounts_parties WHERE partyid = ?", m_PartyID);
    if (rset && rset->rowsCount() && rset->next())
    {
        return rset->get<uint32>(0);
    }

    return 0;
}

timer::time_point CParty::GetTimeLastMemberJoined()
{
    auto* PLeader                    = dynamic_cast<CCharEntity*>(CParty::GetLeader());
    auto  LeaderMemberLastJoinedTime = timer::now();

    if (PLeader)
    {
        LeaderMemberLastJoinedTime = PLeader->m_LeaderCreatedPartyTime;
    }

    return LeaderMemberLastJoinedTime;
}

bool CParty::HasTrusts()
{
    for (auto* PMember : members)
    {
        if (auto* PCharMember = dynamic_cast<CCharEntity*>(PMember))
        {
            if (!PCharMember->PTrusts.empty())
            {
                return true;
            }
        }
    }
    return false;
}

void CParty::RefreshFlags(std::vector<partyInfo_t>& info)
{
    // Clear pointers in case they no longer exist on this instance
    m_PLeader        = nullptr;
    m_PQuarterMaster = nullptr;
    m_PSyncTarget    = nullptr;

    for (auto&& memberinfo : info)
    {
        if (memberinfo.partyid == m_PartyID)
        {
            if (memberinfo.flags & PARTY_LEADER)
            {
                bool found = false;
                for (auto* member : members)
                {
                    if (member->id == memberinfo.id)
                    {
                        m_PLeader = member;
                        found     = true;
                    }
                }
                if (!found)
                {
                    m_PLeader = nullptr;
                }
            }
            if (memberinfo.flags & PARTY_QM)
            {
                bool found = false;
                for (auto* member : members)
                {
                    if (member->id == memberinfo.id)
                    {
                        m_PQuarterMaster = member;
                        found            = true;
                    }
                }
                if (!found)
                {
                    m_PQuarterMaster = nullptr;
                }
            }
            if (memberinfo.flags & PARTY_SYNC)
            {
                bool found = false;
                for (auto* member : members)
                {
                    if (member->id == memberinfo.id)
                    {
                        m_PSyncTarget = member;
                        found         = true;
                    }
                }
                if (!found)
                {
                    m_PSyncTarget = nullptr;
                }
            }
            if (memberinfo.flags & ALLIANCE_LEADER && m_PAlliance)
            {
                bool found = false;
                for (auto* member : members)
                {
                    if (member->id == memberinfo.id)
                    {
                        m_PAlliance->setMainParty(this);
                        found = true;
                    }
                }
                if (!found)
                {
                    m_PAlliance->setMainParty(nullptr);
                }
            }
        }
    }
}

std::size_t CParty::GetMemberCountAcrossAllProcesses()
{
    // TODO: We should detect whether or not we're a multi-process
    // setup. So we can avoid asking the database for more information
    // than we need to.
    return GetPartyInfo().size();
}
