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

#include "../common/logging.h"
#include "../common/timer.h"

#include "alliance.h"
#include "entities/battleentity.h"
#include "job_points.h"
#include "latent_effect_container.h"
#include "map.h"
#include "message.h"
#include "party.h"
#include "status_effect_container.h"
#include "treasure_pool.h"
#include "utils/blueutils.h"
#include "utils/charutils.h"
#include "utils/jailutils.h"
#include "utils/zoneutils.h"
#include <cstring>
#include <vector>

#include "packets/char_abilities.h"
#include "packets/char_sync.h"
#include "packets/char_update.h"
#include "packets/menu_config.h"
#include "packets/message_basic.h"
#include "packets/message_standard.h"
#include "packets/party_define.h"
#include "packets/party_effects.h"
#include "packets/party_member_update.h"

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
{
    m_PLeader        = nullptr;
    m_PAlliance      = nullptr;
    m_PSyncTarget    = nullptr;
    m_PQuarterMaster = nullptr;
    m_EffectsChanged = false;
    m_PartyID        = 0;
    m_PartyType      = PARTY_MOBS;
    m_PartyNumber    = 0;

    if (PEntity != nullptr && PEntity->PParty == nullptr)
    {
        m_PartyID   = PEntity->id;
        m_PartyType = PEntity->objtype == TYPE_PC ? PARTY_PCS : PARTY_MOBS;

        AddMember(PEntity);
        SetLeader(PEntity->name);
    }
    else
    {
        ShowWarning("CParty::CParty() - PEntity was null, or party was not null.")
    }
}

CParty::CParty(uint32 id)
{
    m_PAlliance = nullptr;

    m_PartyID     = id;
    m_PartyType   = PARTY_PCS;
    m_PartyNumber = 0;

    m_PLeader        = nullptr;
    m_PSyncTarget    = nullptr;
    m_PQuarterMaster = nullptr;

    m_EffectsChanged = false;
}

void CParty::DisbandParty(bool playerInitiated)
{
    if (m_PAlliance)
    {
        m_PAlliance->removeParty(this);
    }
    m_PSyncTarget = nullptr;
    SetQuarterMaster("");

    m_PLeader   = nullptr;
    m_PAlliance = nullptr;

    if (m_PartyType == PARTY_PCS)
    {
        PushPacket(0, 0, new CPartyDefinePacket(nullptr));

        for (auto& member : members)
        {
            CCharEntity* PChar = (CCharEntity*)member;
            PChar->ClearTrusts();

            PChar->PParty = nullptr;
            PChar->PLatentEffectContainer->CheckLatentsPartyJobs();
            PChar->PLatentEffectContainer->CheckLatentsPartyMembers(members.size());
            PChar->PLatentEffectContainer->CheckLatentsPartyAvatar();
            PChar->pushPacket(new CPartyMemberUpdatePacket(PChar, 0, 0, PChar->getZone()));

            // TODO: TreasurePool should stay with the last character, but now it is not critical

            if (PChar->PTreasurePool != nullptr && PChar->PTreasurePool->GetPoolType() != TREASUREPOOL_ZONE)
            {
                PChar->PTreasurePool->DelMember(PChar);
                PChar->PTreasurePool = new CTreasurePool(TREASUREPOOL_SOLO);
                PChar->PTreasurePool->AddMember(PChar);
                PChar->PTreasurePool->UpdatePool(PChar);
            }
            CStatusEffect* sync = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC);
            if (sync && sync->GetDuration() == 0)
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 30, 553));
                sync->SetStartTime(server_clock::now());
                sync->SetDuration(30000);
            }
            sql->Query("DELETE FROM accounts_parties WHERE charid = %u;", PChar->id);
        }

        // make sure chat server isn't notified of a disband if this came from the chat server already
        if (playerInitiated)
        {
            uint8 data[8]{};
            ref<uint32>(data, 0) = m_PartyID;
            ref<uint32>(data, 4) = m_PartyID;
            message::send(MSG_PT_DISBAND, data, sizeof data, nullptr);
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
void CParty::AssignPartyRole(const std::string& MemberName, uint8 role)
{
    XI_DEBUG_BREAK_IF(m_PartyType != PARTY_PCS);

    // Make sure that the the character is actually a part of this party
    int ret = sql->Query("SELECT chars.charid FROM chars \
                          JOIN accounts_parties ON accounts_parties.charid = chars.charid WHERE charname = '%s' AND partyid = %u;",
                         MemberName, m_PartyID);
    if (ret == SQL_ERROR || sql->NumRows() == 0)
    {
        return;
    }

    switch (role)
    {
        case 0:
            SetLeader(MemberName);
            break;
        case 4:
            SetQuarterMaster(MemberName);
            break;
        case 5:
            SetQuarterMaster("");
            break;
        case 6:
            SetSyncTarget(MemberName, 238);
            break;
        case 7:
            SetSyncTarget("", 553);
            break;
    }
    uint8 data[4]{};
    ref<uint32>(data, 0) = m_PartyID;
    message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);
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
    XI_DEBUG_BREAK_IF(m_PartyType != PARTY_PCS);

    if (memberName == "")
    {
        return nullptr;
    }

    for (auto& member : members)
    {
        if (strcmpi(memberName.c_str(), member->GetName().c_str()) == 0)
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
        for (uint32 i = 0; i < members.size(); ++i)
        {
            if (PEntity == members.at(i))
            {
                members.erase(members.begin() + i);

                if (m_PartyType == PARTY_PCS)
                {
                    CCharEntity* PChar = dynamic_cast<CCharEntity*>(PEntity);
                    if (PChar)
                    {
                        if (m_PQuarterMaster == PChar)
                        {
                            SetQuarterMaster("");
                        }
                        if (m_PSyncTarget == PChar)
                        {
                            SetSyncTarget("", 553);
                            CStatusEffect* sync = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC);
                            if (sync && sync->GetDuration() == 0)
                            {
                                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 30, 553));
                                sync->SetStartTime(server_clock::now());
                                sync->SetDuration(30000);
                            }
                            DisableSync();
                        }
                        if (m_PSyncTarget != nullptr && m_PSyncTarget != PChar)
                        {
                            if (PChar->status != STATUS_TYPE::DISAPPEAR)
                            {
                                CStatusEffect* sync = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC);
                                if (sync && sync->GetDuration() == 0)
                                {
                                    PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 30, 553));
                                    sync->SetStartTime(server_clock::now());
                                    sync->SetDuration(30000);
                                }
                            }
                        }
                        PChar->PLatentEffectContainer->CheckLatentsPartyMembers(members.size());

                        PChar->pushPacket(new CPartyDefinePacket(nullptr));
                        PChar->pushPacket(new CPartyMemberUpdatePacket(PChar, 0, 0, PChar->getZone()));
                        PChar->pushPacket(new CCharUpdatePacket(PChar));
                        PChar->PParty = nullptr;

                        sql->Query("DELETE FROM accounts_parties WHERE charid = %u;", PChar->id);

                        uint8 data[4]{};
                        ref<uint32>(data, 0) = m_PartyID;
                        message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);

                        if (PChar->PTreasurePool != nullptr && PChar->PTreasurePool->GetPoolType() != TREASUREPOOL_ZONE)
                        {
                            PChar->PTreasurePool->DelMember(PChar);
                            PChar->PTreasurePool = new CTreasurePool(TREASUREPOOL_SOLO);
                            PChar->PTreasurePool->AddMember(PChar);
                            PChar->PTreasurePool->UpdatePool(PChar);
                        }
                    }
                }
                break;
            }
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
        for (uint32 i = 0; i < members.size(); ++i)
        {
            if (PEntity == members.at(i))
            {
                members.erase(members.begin() + i);

                if (m_PartyType == PARTY_PCS)
                {
                    CCharEntity* PChar = (CCharEntity*)PEntity;

                    if (m_PQuarterMaster == PChar)
                    {
                        SetQuarterMaster("");
                    }
                    if (m_PSyncTarget == PChar)
                    {
                        SetSyncTarget("", 553);
                        CStatusEffect* sync = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC);
                        if (sync && sync->GetDuration() == 0)
                        {
                            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 30, 553));
                            sync->SetStartTime(server_clock::now());
                            sync->SetDuration(30000);
                        }
                        DisableSync();
                    }
                    if (m_PSyncTarget != nullptr && m_PSyncTarget != PChar)
                    {
                        if (PChar->status != STATUS_TYPE::DISAPPEAR)
                        {
                            CStatusEffect* sync = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEVEL_SYNC);
                            if (sync && sync->GetDuration() == 0)
                            {
                                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 30, 553));
                                sync->SetStartTime(server_clock::now());
                                sync->SetDuration(30000);
                            }
                        }
                    }
                    PChar->PLatentEffectContainer->CheckLatentsPartyMembers(members.size());

                    PChar->pushPacket(new CPartyDefinePacket(nullptr));
                    PChar->pushPacket(new CPartyMemberUpdatePacket(PChar, 0, 0, PChar->getZone()));
                    PChar->pushPacket(new CCharUpdatePacket(PChar));
                    PChar->PParty = nullptr;

                    if (PChar->PTreasurePool != nullptr && PChar->PTreasurePool->GetPoolType() != TREASUREPOOL_ZONE)
                    {
                        PChar->PTreasurePool->DelMember(PChar);
                        PChar->PTreasurePool = new CTreasurePool(TREASUREPOOL_SOLO);
                        PChar->PTreasurePool->AddMember(PChar);
                        PChar->PTreasurePool->UpdatePool(PChar);
                    }
                }
                else
                {
                    PEntity->PParty = nullptr;
                }
                break;
            }
        }
        this->ReloadParty();
    }
}

void CParty::PopMember(CBattleEntity* PEntity)
{
    for (uint32 i = 0; i < members.size(); ++i)
    {
        if (PEntity == members.at(i))
        {
            members.erase(members.begin() + i);
        }
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
            for (std::size_t i = 0; i < m_PAlliance->partyList.size(); ++i)
            {
                if (this == m_PAlliance->partyList.at(i))
                {
                    m_PAlliance->partyList.erase(m_PAlliance->partyList.begin() + i);
                }
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

    int ret = sql->Query("SELECT charname FROM accounts_sessions JOIN chars ON accounts_sessions.charid = chars.charid \
                                    JOIN accounts_parties ON accounts_parties.charid = chars.charid WHERE partyid = %u AND NOT partyflag & %d \
                                    ORDER BY timestamp ASC LIMIT 1;",
                         m_PartyID, PARTY_LEADER);
    if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
    {
        std::string newLeader((const char*)sql->GetData(0));
        SetLeader(newLeader);
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
    int                              ret = sql->Query("SELECT chars.charid, partyid, allianceid, charname, partyflag, pos_zone, pos_prevzone FROM accounts_parties \
                                    LEFT JOIN chars ON accounts_parties.charid = chars.charid WHERE \
                                    (allianceid <> 0 AND allianceid = %d) OR partyid = %d ORDER BY partyflag & %u, timestamp;",
                         m_PAlliance ? m_PAlliance->m_AllianceID : 0, m_PartyID, PARTY_SECOND | PARTY_THIRD);

    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            memberinfo.push_back({ sql->GetUIntData(0), sql->GetUIntData(1), sql->GetUIntData(2),
                                   std::string((const char*)sql->GetData(3)), static_cast<uint16>(sql->GetUIntData(4)),
                                   static_cast<uint16>(sql->GetUIntData(5)), static_cast<uint16>(sql->GetUIntData(6)) });
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

    PEntity->PParty = this;
    members.push_back(PEntity);

    if (PEntity->objtype == TYPE_PC && this->members.size() > 1)
    {
        auto* PLeader = dynamic_cast<CCharEntity*>(CParty::GetLeader());

        if (PLeader)
        {
            PLeader->m_LeaderCreatedPartyTime = server_clock::now();
        }
    }

    if (m_PartyType == PARTY_PCS)
    {
        XI_DEBUG_BREAK_IF(PEntity->objtype != TYPE_PC);

        CCharEntity* PChar = (CCharEntity*)PEntity;

        uint32 allianceid = 0;
        if (m_PAlliance)
        {
            allianceid = m_PAlliance->m_AllianceID;
        }

        sql->Query("INSERT INTO accounts_parties (charid, partyid, allianceid, partyflag) VALUES (%u, %u, %u, %u);", PChar->id, m_PartyID, allianceid,
                   GetMemberFlags(PChar));
        uint8 data[4]{};
        ref<uint32>(data, 0) = m_PartyID;
        message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);
        ReloadTreasurePool(PChar);

        if (PChar->nameflags.flags & FLAG_INVITE)
        {
            PChar->nameflags.flags &= ~FLAG_INVITE;
            PChar->updatemask |= UPDATE_HP;

            charutils::SaveCharStats(PChar);

            PChar->pushPacket(new CMenuConfigPacket(PChar));
            PChar->pushPacket(new CCharUpdatePacket(PChar));
            PChar->pushPacket(new CCharSyncPacket(PChar));
        }
        PChar->PTreasurePool->UpdatePool(PChar);

        // Apply level sync if the party is level synced
        if (m_PSyncTarget != nullptr)
        {
            if (PChar->getZone() == m_PSyncTarget->getZone())
            {
                PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, m_PSyncTarget->GetMLevel(), 540));
                PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_LEVEL_SYNC, EFFECT_LEVEL_SYNC, m_PSyncTarget->GetMLevel(), 0, 0), true);
                PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE | EFFECTFLAG_ON_ZONE);
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CCharSyncPacket(PChar));
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
        sql->Query("INSERT INTO accounts_parties (charid, partyid, allianceid, partyflag) VALUES (%u, %u, %u, %u);", id, m_PartyID, allianceid,
                   Flags);
        uint8 data[8]{};
        ref<uint32>(data, 0) = m_PartyID;
        ref<uint32>(data, 4) = id;
        message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);

        /*if (PChar->nameflags.flags & FLAG_INVITE)
        {
            PChar->nameflags.flags ^= FLAG_INVITE;
            PChar->updatemask |= UPDATE_HP;

            charutils::SaveCharStats(PChar);

            PChar->status = STATUS_UPDATE;
            PChar->pushPacket(new CMenuConfigPacket(PChar));
            PChar->pushPacket(new CCharUpdatePacket(PChar));
            PChar->pushPacket(new CCharSyncPacket(PChar));
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
    members.push_back(PEntity);

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
                PChar->pushPacket(new CPartyDefinePacket(party));
                // auto effects = std::make_unique<CPartyEffectsPacket>();
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
                        PChar->pushPacket(new CPartyMemberUpdatePacket(PPartyMember, j, memberinfo.flags, PChar->getZone()));
                        // if (memberinfo.partyid == party->GetPartyID() && PPartyMember != PChar)
                        //    effects->AddMemberEffects(PChar);
                    }
                    else
                    {
                        uint16 zoneid = memberinfo.zone == 0 ? memberinfo.prev_zone : memberinfo.zone;
                        PChar->pushPacket(new CPartyMemberUpdatePacket(memberinfo.id, memberinfo.name, memberinfo.flags, j, zoneid));
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
        CBattleEntity* PLeader = GetLeader();
        // regular party
        for (auto& member : members)
        {
            CCharEntity* PChar = (CCharEntity*)member;

            PChar->PLatentEffectContainer->CheckLatentsPartyJobs();
            PChar->PLatentEffectContainer->CheckLatentsPartyMembers(members.size());
            PChar->PLatentEffectContainer->CheckLatentsPartyAvatar();
            PChar->ReloadPartyDec();
            PChar->pushPacket(new CPartyDefinePacket(this, PLeader && PChar->getZone() == PLeader->getZone()));
            // auto effects = std::make_unique<CPartyEffectsPacket>();
            uint8 j = 0;
            for (auto&& memberinfo : info)
            {
                auto* PPartyMember = zoneutils::GetChar(memberinfo.id);
                if (PPartyMember)
                {
                    PChar->pushPacket(new CPartyMemberUpdatePacket(PPartyMember, j, memberinfo.flags, PChar->getZone()));
                    // if (PPartyMember != PChar)
                    //    effects->AddMemberEffects(PChar);

                    // Inject the party leader's trusts into the party list
                    CBattleEntity* PLeader = GetLeader();
                    if (PLeader != nullptr)
                    {
                        for (auto* PTrust : ((CCharEntity*)PLeader)->PTrusts)
                        {
                            j++;
                            // trusts don't persist over zonelines, so we know their zone has be the same as the leader.
                            PChar->pushPacket(new CPartyMemberUpdatePacket(PTrust, j));
                        }
                    }
                }
                else
                {
                    uint16 zoneid = memberinfo.zone == 0 ? memberinfo.prev_zone : memberinfo.zone;
                    PChar->pushPacket(new CPartyMemberUpdatePacket(memberinfo.id, memberinfo.name, memberinfo.flags, j, zoneid));
                }
                j++;
            }
        }
    }
}

// update party info for PChar
void CParty::ReloadPartyMembers(CCharEntity* PChar)
{
    PChar->ReloadPartyDec();
    PChar->pushPacket(new CPartyDefinePacket(this));

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
            PChar->pushPacket(new CPartyMemberUpdatePacket(PPartyMember, j, memberinfo.flags, PChar->getZone()));
        }
        else
        {
            uint16 zoneid = memberinfo.zone == 0 ? memberinfo.prev_zone : memberinfo.zone;
            PChar->pushPacket(new CPartyMemberUpdatePacket(memberinfo.id, memberinfo.name, memberinfo.flags, j, zoneid));
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

    if (PChar->PTreasurePool != nullptr && PChar->PTreasurePool->GetPoolType() == TREASUREPOOL_ZONE)
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
                            PChar->PTreasurePool->DelMember(PChar);
                        }
                        PChar->PTreasurePool = PPartyMember->PTreasurePool;
                        PChar->PTreasurePool->AddMember(PChar);
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
                        PChar->PTreasurePool->DelMember(PChar);
                    }
                    PChar->PTreasurePool = PPartyMember->PTreasurePool;
                    PChar->PTreasurePool->AddMember(PChar);
                    return;
                }
            }
        }
    }

    if (PChar->PTreasurePool == nullptr)
    {
        PChar->PTreasurePool = new CTreasurePool(TREASUREPOOL_SOLO);
        PChar->PTreasurePool->AddMember(PChar);
    }
}

void CParty::SetLeader(const std::string& MemberName)
{
    if (m_PartyType == PARTY_PCS)
    {
        uint32 newId = 0;
        int    ret   = sql->Query(
                 "SELECT chars.charid from accounts_sessions JOIN chars ON chars.charid = accounts_sessions.charid WHERE charname = ('%s')", MemberName);

        if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            newId = sql->GetUIntData(0);
        }
        else
        {
            return;
        }

        sql->Query("UPDATE accounts_parties SET partyflag = partyflag & ~%d WHERE partyid = %u AND partyflag & %d", ALLIANCE_LEADER | PARTY_LEADER,
                   m_PartyID, PARTY_LEADER);
        sql->Query("UPDATE accounts_parties SET partyid = %u WHERE partyid = %u", newId, m_PartyID);
        sql->Query("UPDATE accounts_parties SET allianceid = %u WHERE allianceid = %u", newId, m_PartyID);

        m_PLeader = GetMemberByName(MemberName);
        if (this->m_PAlliance && this->m_PAlliance->m_AllianceID == m_PartyID)
        {
            m_PAlliance->m_AllianceID = newId;
        }

        m_PartyID = newId;
        sql->Query("UPDATE accounts_parties SET partyflag = partyflag | IF(allianceid = partyid, %d, %d) WHERE charid = %u",
                   ALLIANCE_LEADER | PARTY_LEADER, PARTY_LEADER, newId);

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

void CParty::SetSyncTarget(const std::string& MemberName, uint16 message)
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
                ((CCharEntity*)GetLeader())->pushPacket(new CMessageBasicPacket((CCharEntity*)GetLeader(), (CCharEntity*)GetLeader(), 0, 10, 541));
                return;
            }
            else if (PChar->getZone() != GetLeader()->getZone())
            {
                ((CCharEntity*)GetLeader())->pushPacket(new CMessageBasicPacket((CCharEntity*)GetLeader(), (CCharEntity*)GetLeader(), 0, 0, 542));
                return;
            }
            else
            {
                for (auto& member : members)
                {
                    if (member->StatusEffectContainer->HasStatusEffect({ EFFECT_LEVEL_RESTRICTION, EFFECT_LEVEL_SYNC, EFFECT_SJ_RESTRICTION, EFFECT_CONFRONTATION, EFFECT_BATTLEFIELD }))
                    {
                        ((CCharEntity*)GetLeader())->pushPacket(new CMessageBasicPacket((CCharEntity*)GetLeader(), (CCharEntity*)GetLeader(), 0, 0, 543));
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
                        member->pushPacket(new CMessageStandardPacket(PChar->GetMLevel(), 0, 0, 0, static_cast<MsgStd>(message)));
                        member->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_LEVEL_SYNC, EFFECT_LEVEL_SYNC, PChar->GetMLevel(), 0, 0), true);
                        member->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE | EFFECTFLAG_ON_ZONE);
                        member->loc.zone->PushPacket(member, CHAR_INRANGE, new CCharSyncPacket(member));
                    }
                }
                sql->Query("UPDATE accounts_parties SET partyflag = partyflag & ~%d WHERE partyid = %u AND partyflag & %d", PARTY_SYNC, m_PartyID,
                           PARTY_SYNC);
                sql->Query("UPDATE accounts_parties SET partyflag = partyflag | %d WHERE partyid = %u AND charid = '%u';", PARTY_SYNC, m_PartyID,
                           PChar->id);
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
                        if (sync && sync->GetDuration() == 0)
                        {
                            member->pushPacket(new CMessageBasicPacket(member, member, 10, 30, message));
                            sync->SetStartTime(server_clock::now());
                            sync->SetDuration(30000);
                        }
                    }
                }
            }
            m_PSyncTarget = nullptr;
            sql->Query("UPDATE accounts_parties SET partyflag = partyflag & ~%d WHERE partyid = %u AND partyflag & %d", PARTY_SYNC, m_PartyID,
                       PARTY_SYNC);
        }
    }
}

void CParty::SetQuarterMaster(const std::string& MemberName)
{
    CBattleEntity* PEntity = GetMemberByName(MemberName);
    m_PQuarterMaster       = PEntity;
    sql->Query("UPDATE accounts_parties SET partyflag = partyflag & ~%d WHERE partyid = %u AND partyflag & %d", PARTY_QM, m_PartyID, PARTY_QM);
    if (PEntity != nullptr)
    {
        sql->Query("UPDATE accounts_parties JOIN chars ON accounts_parties.charid = chars.charid \
                              SET partyflag = partyflag | %d WHERE partyid = %u AND charname = '%s';",
                   PARTY_QM, m_PartyID, MemberName);
    }
}

// Send a packet to all members of the group if the zone is specified as 0
// or to the party members in the specified zone.
// Packet for PPartyMember is not sent in both cases
void CParty::PushPacket(uint32 senderID, uint16 ZoneID, CBasicPacket* packet)
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
                member->pushPacket(new CBasicPacket(*packet));
            }
        }
    }
    destroy(packet);
}

void CParty::PushEffectsPacket()
{
    if (m_EffectsChanged)
    {
        auto info = GetPartyInfo();

        for (auto& PMember : members)
        {
            auto* PMemberChar = static_cast<CCharEntity*>(PMember);
            auto  effects     = std::make_unique<CPartyEffectsPacket>();
            for (auto& memberinfo : info)
            {
                if (memberinfo.partyid == m_PartyID && memberinfo.id != PMemberChar->id)
                {
                    auto* PPartyMember = zoneutils::GetChar(memberinfo.id);
                    if (PPartyMember && PPartyMember->getZone() == PMemberChar->getZone())
                    {
                        effects->AddMemberEffects(PPartyMember);
                    }
                }
            }
            PMemberChar->pushPacket(effects.release());
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
        SetSyncTarget("", 554);
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
            member->SetMLevel(NewMLevel);
            member->SetSLevel(member->jobs.job[member->GetSJob()]);
            charutils::ApplyAllEquipMods(member);

            blueutils::ValidateBlueSpells(member);
            jobpointutils::RefreshGiftMods(member);
            charutils::BuildingCharSkillsTable(member);
            charutils::CalculateStats(member);
            charutils::BuildingCharTraitsTable(member);
            charutils::BuildingCharAbilityTable(member);
            charutils::CheckValidEquipment(member);
            member->pushPacket(new CCharAbilitiesPacket(member));
        }
        member->pushPacket(new CMessageBasicPacket(member, member, 0, syncLevel, 540));
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
    int ret = sql->Query("SELECT COUNT(*) FROM accounts_parties WHERE partyid = %d;", m_PartyID);
    if (ret != SQL_ERROR && sql->NextRow() == SQL_SUCCESS)
    {
        return sql->GetUIntData(0);
    }
    return 0;
}

uint32 CParty::GetTimeLastMemberJoined()
{
    auto* PLeader                    = dynamic_cast<CCharEntity*>(CParty::GetLeader());
    auto  LeaderMemberLastJoinedTime = server_clock::now();

    if (PLeader)
    {
        LeaderMemberLastJoinedTime = PLeader->m_LeaderCreatedPartyTime;
    }

    return (uint32)std::chrono::time_point_cast<std::chrono::seconds>(LeaderMemberLastJoinedTime).time_since_epoch().count();
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
