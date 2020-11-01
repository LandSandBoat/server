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

#include "../common/showmsg.h"
#include "../common/timer.h"

#include <vector>
#include <string.h>
#include "alliance.h"
#include "entities/battleentity.h"
#include "utils/charutils.h"
#include "utils/blueutils.h"
#include "utils/jailutils.h"
#include "utils/zoneutils.h"
#include "map.h"
#include "party.h"
#include "treasure_pool.h"
#include "message.h"
#include "latent_effect_container.h"
#include "status_effect_container.h"

#include "packets/char_sync.h"
#include "packets/char_update.h"
#include "packets/char_abilities.h"
#include "packets/menu_config.h"
#include "packets/message_standard.h"
#include "packets/party_define.h"
#include "packets/party_effects.h"
#include "packets/party_member_update.h"
#include "packets/message_basic.h"

//should have brace-or-equal initializers when MSVC supports it
struct CParty::partyInfo_t
{
    uint32 id;
    uint32 partyid;
    uint32 allianceid;
    std::string name;
    uint16 flags;
    uint16 zone;
    uint16 prev_zone;
};

/************************************************************************
*																		*
*  Конструктор   														*
*																		*
************************************************************************/

CParty::CParty(CBattleEntity* PEntity)
{
    TPZ_DEBUG_BREAK_IF(PEntity == nullptr);
    TPZ_DEBUG_BREAK_IF(PEntity->PParty != nullptr);

    m_PartyID = PEntity->id;
    m_PartyType = PEntity->objtype == TYPE_PC ? PARTY_PCS : PARTY_MOBS;
    m_PartyNumber = 0;

    m_PLeader = nullptr;
    m_PAlliance = nullptr;
    m_PSyncTarget = nullptr;
    m_PQuaterMaster = nullptr;

    m_EffectsChanged = false;
    AddMember(PEntity);
    SetLeader((char*)PEntity->name.c_str());
}

CParty::CParty(uint32 id)
{
    m_PAlliance = nullptr;

    m_PartyID = id;
    m_PartyType = PARTY_PCS;
    m_PartyNumber = 0;

    m_PLeader = nullptr;
    m_PSyncTarget = nullptr;
    m_PQuaterMaster = nullptr;

    m_EffectsChanged = false;
}

/************************************************************************
*																		*
*  Распускаем группу													*
*																		*
************************************************************************/

void CParty::DisbandParty(bool playerInitiated)
{
    if (m_PAlliance)
    {
        m_PAlliance->removeParty(this);
    }
    m_PSyncTarget = nullptr;
    SetQuarterMaster(nullptr);

    m_PLeader = nullptr;
    m_PAlliance = nullptr;

    if (m_PartyType == PARTY_PCS)
    {
        PushPacket(0, 0, new CPartyDefinePacket(nullptr));

        for (uint8 i = 0; i < members.size(); ++i)
        {
            CCharEntity* PChar = (CCharEntity*)members.at(i);
            PChar->ClearTrusts();

            PChar->PParty = nullptr;
            PChar->PLatentEffectContainer->CheckLatentsPartyJobs();
            PChar->PLatentEffectContainer->CheckLatentsPartyMembers(members.size());
            PChar->PLatentEffectContainer->CheckLatentsPartyAvatar();
            PChar->pushPacket(new CPartyMemberUpdatePacket(PChar, 0, 0, PChar->getZone()));

            // TODO: TreasurePool должен оставаться у последнего персонажа, но сейчас это не критично

            if (PChar->PTreasurePool != nullptr &&
                PChar->PTreasurePool->GetPoolType() != TREASUREPOOL_ZONE)
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
            Sql_Query(SqlHandle, "DELETE FROM accounts_parties WHERE charid = %u;", PChar->id);
        }

        // make sure chat server isn't notified of a disband if this came from the chat server already
        if (playerInitiated)
        {
            uint8 data[8] {};
            ref<uint32>(data, 0) = m_PartyID;
            ref<uint32>(data, 4) = m_PartyID;
            message::send(MSG_PT_DISBAND, data, sizeof data, nullptr);
        }
    }
    delete this;
}

/************************************************************************
*                                                                       *
*  Назначаем роли участникам группы	(только для персонажей)             *
*                                                                       *
************************************************************************/

void CParty::AssignPartyRole(int8* MemberName, uint8 role)
{
    TPZ_DEBUG_BREAK_IF(m_PartyType != PARTY_PCS);

    switch (role)
    {
        case 0: SetLeader((const char*)MemberName);		    break;
        case 4: SetQuarterMaster((const char*)MemberName);   break;
        case 5: SetQuarterMaster(nullptr);	        break;
        case 6: SetSyncTarget(MemberName, 238);	break;
        case 7: SetSyncTarget(nullptr, 553);       break;
    }
    uint8 data[4] {};
    ref<uint32>(data, 0) = m_PartyID;
    message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);
    return;
}

/************************************************************************
*																		*
*  Узнаем количество участников группы в указанной зоне					*
*																		*
************************************************************************/

uint8 CParty::MemberCount(uint16 ZoneID)
{
    uint8 count = 0;

    for (uint32 i = 0; i < members.size(); ++i)
    {
        auto* member = members.at(i);
        if (member->getZone() == ZoneID)
        {
            count++;
        }
        if (member->objtype == TYPE_PC)
        {
            auto* charMember = static_cast<CCharEntity*>(member);
            std::for_each(charMember->PTrusts.begin(), charMember->PTrusts.end(), [&](CTrustEntity* trust) {
                count++;
            });
        }
    }
    return count;
}

/************************************************************************
*                                                                       *
*  Returns Entity Pointer to Party Member by Name (used for kick)       *
*                                                                       *
************************************************************************/

CBattleEntity* CParty::GetMemberByName(const int8* MemberName)
{
    TPZ_DEBUG_BREAK_IF(m_PartyType != PARTY_PCS);

    for (uint32 i = 0; i < members.size(); ++i)
        if (strcmp((const char*)MemberName, (const char*)members.at(i)->GetName()) == 0)
            return members.at(i);

    return nullptr;
}

/************************************************************************
*																		*
*  Удаляем персонажа из группы				  							*
*																		*
************************************************************************/

void CParty::RemoveMember(CBattleEntity* PEntity)
{
    TPZ_DEBUG_BREAK_IF(PEntity == nullptr);
    TPZ_DEBUG_BREAK_IF(PEntity->PParty != this);

    if (m_PLeader == PEntity)
    {
        RemovePartyLeader(PEntity);

        // Remove their trusts
        CCharEntity* PChar = (CCharEntity*)PEntity;
        PChar->ClearTrusts();
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

                    if (m_PQuaterMaster == PChar)
                    {
                        SetQuarterMaster(nullptr);
                    }
                    if (m_PSyncTarget == PChar)
                    {
                        SetSyncTarget(nullptr, 553);
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
                        if (PChar->status != STATUS_DISAPPEAR)
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

                    Sql_Query(SqlHandle, "DELETE FROM accounts_parties WHERE charid = %u;", PChar->id);

                    uint8 data[4] {};
                    ref<uint32>(data, 0) = m_PartyID;
                    message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);

                    if (PChar->PTreasurePool != nullptr &&
                        PChar->PTreasurePool->GetPoolType() != TREASUREPOOL_ZONE)
                    {
                        PChar->PTreasurePool->DelMember(PChar);
                        PChar->PTreasurePool = new CTreasurePool(TREASUREPOOL_SOLO);
                        PChar->PTreasurePool->AddMember(PChar);
                        PChar->PTreasurePool->UpdatePool(PChar);
                    }
                }
                break;
            }
        }
    }
}

void CParty::DelMember(CBattleEntity* PEntity)
{
    TPZ_DEBUG_BREAK_IF(PEntity == nullptr);
    TPZ_DEBUG_BREAK_IF(PEntity->PParty != this);

    if (m_PLeader == PEntity)
    {
        RemovePartyLeader(PEntity);
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

                    if (m_PQuaterMaster == PChar)
                    {
                        SetQuarterMaster(nullptr);
                    }
                    if (m_PSyncTarget == PChar)
                    {
                        SetSyncTarget(nullptr, 553);
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
                        if (PChar->status != STATUS_DISAPPEAR)
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

                    if (PChar->PTreasurePool != nullptr &&
                        PChar->PTreasurePool->GetPoolType() != TREASUREPOOL_ZONE)
                    {
                        PChar->PTreasurePool->DelMember(PChar);
                        PChar->PTreasurePool = new CTreasurePool(TREASUREPOOL_SOLO);
                        PChar->PTreasurePool->AddMember(PChar);
                        PChar->PTreasurePool->UpdatePool(PChar);
                    }
                }
                break;
            }
        }
    }
    this->ReloadParty();
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
    //free memory, party will re reinsatiated when they zone back in
    if (members.empty())
    {
        if (m_PAlliance)
        {
            if (m_PAlliance->getMainParty() == this)
            {
                m_PAlliance->setMainParty(nullptr);
            }
            for (uint8 i = 0; i < m_PAlliance->partyList.size(); ++i)
            {
                if (this == m_PAlliance->partyList.at(i))
                    m_PAlliance->partyList.erase(m_PAlliance->partyList.begin() + i);
            }
        }
        delete this;
    }
    PEntity->PParty = nullptr;
}

/************************************************************************
*																		*
*  Лидер покидает группу												*
*																		*
************************************************************************/

void CParty::RemovePartyLeader(CBattleEntity* PEntity)
{
    TPZ_DEBUG_BREAK_IF(members.empty());

    int ret = Sql_Query(SqlHandle, "SELECT charname FROM accounts_sessions JOIN chars ON accounts_sessions.charid = chars.charid \
                                    JOIN accounts_parties ON accounts_parties.charid = chars.charid WHERE partyid = %u AND NOT partyflag & %d \
                                    ORDER BY timestamp ASC LIMIT 1;", m_PartyID, PARTY_LEADER);
    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        std::string newLeader((const char*)Sql_GetData(SqlHandle, 0));
        SetLeader(newLeader.c_str());
    }
    if (m_PLeader == PEntity)
    {
        DisbandParty();
    }
    else
    {
        RemoveMember(PEntity);
    }
}

std::vector<CParty::partyInfo_t> CParty::GetPartyInfo()
{
    std::vector<CParty::partyInfo_t> memberinfo;
    int ret = Sql_Query(SqlHandle, "SELECT chars.charid, partyid, allianceid, charname, partyflag, pos_zone, pos_prevzone FROM accounts_parties \
                                    LEFT JOIN chars ON accounts_parties.charid = chars.charid WHERE \
                                    (allianceid <> 0 AND allianceid = %d) OR partyid = %d ORDER BY partyflag & %u, timestamp;",
        m_PAlliance ? m_PAlliance->m_AllianceID : 0, m_PartyID, PARTY_SECOND | PARTY_THIRD);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            memberinfo.push_back({Sql_GetUIntData(SqlHandle,0), Sql_GetUIntData(SqlHandle, 1),
                Sql_GetUIntData(SqlHandle, 2), std::string((const char*)Sql_GetData(SqlHandle, 3)),
                static_cast<uint16>(Sql_GetUIntData(SqlHandle, 4)),
                static_cast<uint16>(Sql_GetUIntData(SqlHandle, 5)),
                static_cast<uint16>(Sql_GetUIntData(SqlHandle, 6))});
        }
    }
    return memberinfo;
}

/************************************************************************
*																		*
*  Добавляем персонажа в группу											*
*																		*
************************************************************************/

void CParty::AddMember(CBattleEntity* PEntity)
{
    TPZ_DEBUG_BREAK_IF(PEntity == nullptr);
    TPZ_DEBUG_BREAK_IF(PEntity->PParty != nullptr);

    PEntity->PParty = this;
    members.push_back(PEntity);

    if (PEntity->objtype == TYPE_PC && this->members.size() > 1)
    {
        this->m_TimeLastMemberJoined = server_clock::now();
    }

    if (m_PartyType == PARTY_PCS)
    {
        TPZ_DEBUG_BREAK_IF(PEntity->objtype != TYPE_PC);

        CCharEntity* PChar = (CCharEntity*)PEntity;

        uint32 allianceid = 0;
        if (m_PAlliance)
        {
            allianceid = m_PAlliance->m_AllianceID;
        }

        Sql_Query(SqlHandle, "INSERT INTO accounts_parties (charid, partyid, allianceid, partyflag) VALUES (%u, %u, %u, %u);", PChar->id, m_PartyID, allianceid, GetMemberFlags(PChar));
        uint8 data[4] {};
        ref<uint32>(data, 0) = m_PartyID;
        message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);
        ReloadTreasurePool(PChar);

        if (PChar->nameflags.flags & FLAG_INVITE)
        {
            PChar->nameflags.flags ^= FLAG_INVITE;
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
                PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(
                    EFFECT_LEVEL_SYNC,
                    EFFECT_LEVEL_SYNC,
                    m_PSyncTarget->GetMLevel(),
                    0,
                    0), true);
                PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE | EFFECTFLAG_ON_ZONE);
                PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CCharSyncPacket(PChar));
            }
        }

        // You lose all your summoned trusts upon joining a party
        PChar->ClearTrusts();
    }
}

void CParty::AddMember(uint32 id)
{
    if (m_PartyType == PARTY_PCS)
    {
        uint32 allianceid = 0;
        uint16 Flags = 0;
        if (m_PAlliance)
        {
            allianceid = m_PAlliance->m_AllianceID;
            if (this->m_PartyNumber == 1)
                Flags = PARTY_SECOND;
            else if (this->m_PartyNumber == 2)
                Flags = PARTY_THIRD;
        }
        Sql_Query(SqlHandle, "INSERT INTO accounts_parties (charid, partyid, allianceid, partyflag) VALUES (%u, %u, %u, %u);", id, m_PartyID, allianceid, Flags);
        uint8 data[8] {};
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
    TPZ_DEBUG_BREAK_IF(PEntity == nullptr);
    TPZ_DEBUG_BREAK_IF(PEntity->PParty != nullptr);

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
                m_PQuaterMaster = PEntity;
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

/************************************************************************
*																		*
*  Получаем уникальный ID группы										*
*																		*
************************************************************************/

uint32 CParty::GetPartyID()
{
    return m_PartyID;
}

/************************************************************************
*																		*
*  Получаем указатель на лидера группы									*
*																		*
************************************************************************/

CBattleEntity* CParty::GetLeader()
{
    return m_PLeader;
}

/************************************************************************
*																		*
*  Получаем указатель на цель синхронизации уровней						*
*																		*
************************************************************************/

CBattleEntity* CParty::GetSyncTarget()
{
    return m_PSyncTarget;
}

/************************************************************************
*																		*
*  Получаем указатель на владельца сокровищ								*
*																		*
************************************************************************/

CBattleEntity* CParty::GetQuaterMaster()
{
    return m_PQuaterMaster;
}

/************************************************************************
*                                                                       *
*  Получаем список флагов персонажа                                     *
*                                                                       *
************************************************************************/

uint16 CParty::GetMemberFlags(CBattleEntity* PEntity)
{
    TPZ_DEBUG_BREAK_IF(PEntity == nullptr);
    TPZ_DEBUG_BREAK_IF(PEntity->PParty != this);

    uint16 Flags = 0;

    if (PEntity->PParty->m_PAlliance != nullptr)
    {
        if (PEntity == m_PLeader && PEntity->PParty->m_PAlliance->getMainParty() == PEntity->PParty)
            Flags |= ALLIANCE_LEADER;
    }

    if (PEntity->PParty->m_PartyNumber == 1)
        Flags += PARTY_SECOND;
    else if (PEntity->PParty->m_PartyNumber == 2)
        Flags += PARTY_THIRD;

    if (PEntity == m_PLeader)       Flags |= PARTY_LEADER;
    if (PEntity == m_PQuaterMaster) Flags |= PARTY_QM;
    if (PEntity == m_PSyncTarget)   Flags |= PARTY_SYNC;

    return Flags;
}

/************************************************************************
*                                                                       *
*  Обновляем карту группы для всех членов группы                        *
*                                                                       *
************************************************************************/

void CParty::ReloadParty()
{
    auto info = GetPartyInfo();

    //alliance
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
                //auto effects = std::make_unique<CPartyEffectsPacket>();
                uint8 j = 0;
                for (auto&& memberinfo : info)
                {
                    if ((memberinfo.flags & (PARTY_SECOND | PARTY_THIRD)) != alliance)
                    {
                        alliance = memberinfo.flags & (PARTY_SECOND | PARTY_THIRD);
                        j = 0;
                    }
                    auto PPartyMember = zoneutils::GetChar(memberinfo.id);
                    if (PPartyMember)
                    {
                        PChar->pushPacket(new CPartyMemberUpdatePacket(PPartyMember, j, memberinfo.flags, PChar->getZone()));
                        //if (memberinfo.partyid == party->GetPartyID() && PPartyMember != PChar)
                        //    effects->AddMemberEffects(PChar);
                    }
                    else
                    {
                        uint16 zoneid = memberinfo.zone == 0 ? memberinfo.prev_zone : memberinfo.zone;
                        PChar->pushPacket(new CPartyMemberUpdatePacket(
                            memberinfo.id, (const int8*)memberinfo.name.c_str(),
                            memberinfo.flags, j, zoneid));
                    }
                    j++;
                }
                //PChar->pushPacket(effects.release());
            }
        }
    }
    else
    {
        RefreshFlags(info);
        CBattleEntity* PLeader = GetLeader();
        //regular party
        for (uint8 i = 0; i < members.size(); ++i)
        {
            CCharEntity* PChar = (CCharEntity*)members.at(i);

            PChar->PLatentEffectContainer->CheckLatentsPartyJobs();
            PChar->PLatentEffectContainer->CheckLatentsPartyMembers(members.size());
            PChar->PLatentEffectContainer->CheckLatentsPartyAvatar();
            PChar->ReloadPartyDec();
            if (PLeader)
            {
                PChar->pushPacket(new CPartyDefinePacket(this, PChar->getZone() == PLeader->getZone()));
            }
            //auto effects = std::make_unique<CPartyEffectsPacket>();
            uint8 j = 0;
            for (auto&& memberinfo : info)
            {
                auto PPartyMember = zoneutils::GetChar(memberinfo.id);
                if (PPartyMember)
                {
                    PChar->pushPacket(new CPartyMemberUpdatePacket(PPartyMember, j, memberinfo.flags, PChar->getZone()));
                    //if (PPartyMember != PChar)
                    //    effects->AddMemberEffects(PChar);

                    // Inject the party leader's trusts into the party list
                    CBattleEntity* PLeader = GetLeader();
                    if (PLeader != nullptr)
                    {
                        for (auto PTrust : ((CCharEntity*)PLeader)->PTrusts)
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
                    PChar->pushPacket(new CPartyMemberUpdatePacket(
                        memberinfo.id, (const int8*)memberinfo.name.c_str(),
                        memberinfo.flags, j, zoneid));
                }
                j++;
            }
        }
    }
}

/************************************************************************
*																		*
*  Обновляем статусы членов группы для выбранного персонажа				*
*  Возвращаем номер персонажа в группе									*
*																		*
************************************************************************/

void CParty::ReloadPartyMembers(CCharEntity* PChar)
{
    PChar->ReloadPartyDec();
    PChar->pushPacket(new CPartyDefinePacket(this));

    int alliance = 0;

    auto info = GetPartyInfo();
    uint8 j = 0;
    for (auto&& memberinfo : info)
    {
        if ((memberinfo.flags & (PARTY_SECOND | PARTY_THIRD)) != alliance)
        {
            alliance = memberinfo.flags & (PARTY_SECOND | PARTY_THIRD);
            j = 0;
        }
        CCharEntity* PPartyMember = zoneutils::GetChar(memberinfo.zone);
        if (PPartyMember)
        {
            PChar->pushPacket(new CPartyMemberUpdatePacket(PPartyMember, j, memberinfo.flags, PChar->getZone()));
        }
        else
        {
            uint16 zoneid = memberinfo.zone == 0 ? memberinfo.prev_zone : memberinfo.zone;
            PChar->pushPacket(new CPartyMemberUpdatePacket(
                memberinfo.id, (const int8*)memberinfo.name.c_str(),
                memberinfo.flags, j, zoneid));
        }
        j++;
    }
}

/************************************************************************
*																		*
*  Обновляем TreasurePool для указанного персонажа						*
*																		*
************************************************************************/

void CParty::ReloadTreasurePool(CCharEntity* PChar)
{
    TPZ_DEBUG_BREAK_IF(PChar == nullptr);

    if (PChar->PTreasurePool != nullptr && PChar->PTreasurePool->GetPoolType() == TREASUREPOOL_ZONE)
        return;



    //alliance
    if (PChar->PParty != nullptr)
    {
        if (PChar->PParty->m_PAlliance != nullptr)
        {
            for (uint8 a = 0; a < PChar->PParty->m_PAlliance->partyList.size(); ++a)
            {
                for (uint8 i = 0; i < PChar->PParty->m_PAlliance->partyList.at(a)->members.size(); ++i)
                {
                    CCharEntity* PPartyMember = (CCharEntity*)PChar->PParty->m_PAlliance->partyList.at(a)->members.at(i);

                    if (PPartyMember != PChar && PPartyMember->PTreasurePool != nullptr &&	PPartyMember->getZone() == PChar->getZone())
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

            }//regular party
        }
        else if (PChar->PParty->m_PAlliance == nullptr)
        {
            for (uint8 i = 0; i < members.size(); ++i)
            {
                CCharEntity* PPartyMember = (CCharEntity*)members.at(i);

                if (PPartyMember != PChar &&
                    PPartyMember->PTreasurePool != nullptr &&
                    PPartyMember->getZone() == PChar->getZone())
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

/************************************************************************
*																		*
*  Устанавливаем лидера группы											*
*																		*
************************************************************************/

void CParty::SetLeader(const char* MemberName)
{
    if (m_PartyType == PARTY_PCS)
    {
        uint32 newId = 0;
        int ret = Sql_Query(SqlHandle, "SELECT chars.charid from accounts_sessions JOIN chars ON chars.charid = accounts_sessions.charid WHERE charname = ('%s')", MemberName);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            newId = Sql_GetUIntData(SqlHandle, 0);
        }
        else
        {
            return;
        }

        Sql_Query(SqlHandle, "UPDATE accounts_parties SET partyflag = partyflag & ~%d WHERE partyid = %u AND partyflag & %d", ALLIANCE_LEADER | PARTY_LEADER, m_PartyID, PARTY_LEADER);
        Sql_Query(SqlHandle, "UPDATE accounts_parties SET partyid = %u WHERE partyid = %u", newId, m_PartyID);
        Sql_Query(SqlHandle, "UPDATE accounts_parties SET allianceid = %u WHERE allianceid = %u", newId, m_PartyID);

        m_PLeader = GetMemberByName((const int8*)MemberName);
        if (this->m_PAlliance && this->m_PAlliance->m_AllianceID == m_PartyID)
        {
            m_PAlliance->m_AllianceID = newId;
        }

        m_PartyID = newId;
        Sql_Query(SqlHandle, "UPDATE accounts_parties SET partyflag = partyflag | IF(allianceid = partyid, %d, %d) WHERE charid = %u", ALLIANCE_LEADER | PARTY_LEADER, PARTY_LEADER, newId);

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

/************************************************************************
*																		*
*  Устанавливаем цель синхронизации уровней								*
*																		*
************************************************************************/

void CParty::SetSyncTarget(int8* MemberName, uint16 message)
{
    CBattleEntity* PEntity = nullptr;
    if (MemberName)
    {
        PEntity = GetMemberByName(MemberName);
    }

    if (map_config.level_sync_enable)
    {
        if (PEntity && PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)PEntity;
            //enable level sync
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
                for (uint8 i = 0; i < members.size(); ++i)
                {
                    if (members.at(i)->StatusEffectContainer->HasStatusEffect({EFFECT_LEVEL_RESTRICTION, EFFECT_LEVEL_SYNC}))
                    {
                        ((CCharEntity*)GetLeader())->pushPacket(new CMessageBasicPacket((CCharEntity*)GetLeader(), (CCharEntity*)GetLeader(), 0, 0, 543));
                        return;
                    }
                }
                m_PSyncTarget = PChar;
                for (uint8 i = 0; i < members.size(); ++i)
                {
                    if (members.at(i)->objtype != TYPE_PC) continue;

                    CCharEntity* member = (CCharEntity*)members.at(i);

                    if (member->status != STATUS_DISAPPEAR &&
                        member->getZone() == PChar->getZone())
                    {
                        member->pushPacket(new CMessageStandardPacket(PChar->GetMLevel(), 0, 0, 0, static_cast<MsgStd>(message)));
                        member->StatusEffectContainer->AddStatusEffect(new CStatusEffect(
                            EFFECT_LEVEL_SYNC,
                            EFFECT_LEVEL_SYNC,
                            PChar->GetMLevel(),
                            0,
                            0), true);
                        member->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DISPELABLE | EFFECTFLAG_ON_ZONE);
                        member->loc.zone->PushPacket(member, CHAR_INRANGE, new CCharSyncPacket(member));
                    }
                }
                Sql_Query(SqlHandle, "UPDATE accounts_parties SET partyflag = partyflag & ~%d WHERE partyid = %u AND partyflag & %d", PARTY_SYNC, m_PartyID, PARTY_SYNC);
                Sql_Query(SqlHandle, "UPDATE accounts_parties SET partyflag = partyflag | %d WHERE partyid = %u AND charid = '%u';", PARTY_SYNC, m_PartyID, PChar->id);
            }
        }
        else
        {
            if (m_PSyncTarget != nullptr)
            {
                //disable level sync
                for (uint8 i = 0; i < members.size(); ++i)
                {
                    if (members.at(i)->objtype != TYPE_PC) continue;

                    CCharEntity* member = (CCharEntity*)members.at(i);

                    if (member->status != STATUS_DISAPPEAR)
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
            Sql_Query(SqlHandle, "UPDATE accounts_parties SET partyflag = partyflag & ~%d WHERE partyid = %u AND partyflag & %d", PARTY_SYNC, m_PartyID, PARTY_SYNC);
        }
    }
}

/************************************************************************
*																		*
*  Усранавливаем владельца сокровищ										*
*																		*
************************************************************************/

void CParty::SetQuarterMaster(const char* MemberName)
{
    CBattleEntity* PEntity = MemberName ? GetMemberByName((const int8*)MemberName) : nullptr;
    m_PQuaterMaster = PEntity;
    Sql_Query(SqlHandle, "UPDATE accounts_parties SET partyflag = partyflag & ~%d WHERE partyid = %u AND partyflag & %d", PARTY_QM, m_PartyID, PARTY_QM);
    if (MemberName != nullptr)
    {
        Sql_Query(SqlHandle, "UPDATE accounts_parties JOIN chars ON accounts_parties.charid = chars.charid \
                              SET partyflag = partyflag | %d WHERE partyid = %u AND charname = '%s';", PARTY_QM, m_PartyID, MemberName);
    }
}

/************************************************************************
*																		*
*  Отправляем пакет всем членам группы, если зона указана как 0 или		*
*  членам группы в указанной зоне.										*
*  Пакет для PPartyMember не отправляется в обоих случаях.				*
*																		*
************************************************************************/

void CParty::PushPacket(uint32 senderID, uint16 ZoneID, CBasicPacket* packet)
{
    for (uint32 i = 0; i < members.size(); ++i)
    {
        if (members.at(i) == nullptr || members.at(i)->objtype != TYPE_PC)
        {
            continue;
        }

        CCharEntity* member = (CCharEntity*)members.at(i);

        if (member->id != senderID &&
            member->status != STATUS_DISAPPEAR &&
            !jailutils::InPrison(member))
        {
            if (ZoneID == 0 || member->getZone() == ZoneID)
            {
                member->pushPacket(new CBasicPacket(*packet));
            }
        }
    }
    delete packet;
}

void CParty::PushEffectsPacket()
{
    if (m_EffectsChanged)
    {
        auto info = GetPartyInfo();

        for (auto& PMember : members)
        {
            auto PMemberChar = static_cast<CCharEntity*>(PMember);
            auto effects = std::make_unique<CPartyEffectsPacket>();
            for (auto& memberinfo : info)
            {
                if (memberinfo.partyid == m_PartyID && memberinfo.id != PMemberChar->id)
                {
                    auto PPartyMember = zoneutils::GetChar(memberinfo.id);
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
    CCharEntity* sync = (CCharEntity*)m_PSyncTarget;
    uint8 syncLevel = sync->jobs.job[sync->GetMJob()];
    if (syncLevel < 10)
    {
        SetSyncTarget(nullptr, 554);
    }
    for (uint8 i = 0; i < members.size(); ++i)
    {
        if (members.at(i)->objtype != TYPE_PC || members.at(i)->getZone() != sync->getZone()) continue;

        CCharEntity* member = (CCharEntity*)members.at(i);

        uint8 NewMLevel = 0;

        if (syncLevel < member->jobs.job[member->GetMJob()])
        {
            NewMLevel = syncLevel;
        }
        else {
            NewMLevel = member->jobs.job[member->GetMJob()];
        }

        if (member->GetMLevel() != NewMLevel)
        {
            charutils::RemoveAllEquipMods(member);
            member->SetMLevel(NewMLevel);
            member->SetSLevel(member->jobs.job[member->GetSJob()]);
            charutils::ApplyAllEquipMods(member);

            blueutils::ValidateBlueSpells(member);
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

uint32 CParty::GetTimeLastMemberJoined()
{
    return (uint32)std::chrono::time_point_cast<std::chrono::seconds>(m_TimeLastMemberJoined).time_since_epoch().count();
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
                for (auto member : members)
                {
                    if (member->id == memberinfo.id)
                    {
                        m_PLeader = member;
                        found = true;
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
                for (auto member : members)
                {
                    if (member->id == memberinfo.id)
                    {
                        m_PQuaterMaster = member;
                        found = true;
                    }
                }
                if (!found)
                {
                    m_PQuaterMaster = nullptr;
                }
            }
            if (memberinfo.flags & PARTY_SYNC)
            {
                bool found = false;
                for (auto member : members)
                {
                    if (member->id == memberinfo.id)
                    {
                        m_PSyncTarget = member;
                        found = true;
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
                for (auto member : members)
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
