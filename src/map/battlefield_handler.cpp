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

#include <algorithm>
#include <cstring>

#include "ai/states/death_state.h"

#include "alliance.h"

#include "battlefield.h"
#include "battlefield_handler.h"

#include "entities/battleentity.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"

#include "lua/luautils.h"

#include "packets/char_recast.h"
#include "packets/char_skills.h"
#include "packets/message_basic.h"

#include "recast_container.h"
#include "status_effect.h"
#include "status_effect_container.h"

#include "utils/charutils.h"
#include "utils/zoneutils.h"

#include "zone.h"

CBattlefieldHandler::CBattlefieldHandler(CZone* PZone)
: m_PZone(PZone)
, m_MaxBattlefields(luautils::OnBattlefieldHandlerInitialise(PZone))
{
}

void CBattlefieldHandler::HandleBattlefields(time_point tick)
{
    TracyZoneScoped;
    // todo: use raw pointers otherwise might be harming lua
    // dont want this to run again if we removed a battlefield
    for (auto& PBattlefield : m_Battlefields)
    {
        if (!PBattlefield.second->CanCleanup())
        {
            PBattlefield.second->onTick(tick);
        }
    }

    // can't std::remove_if in map so i'll workaround it
    for (auto it = m_Battlefields.begin(); it != m_Battlefields.end();)
    {
        auto* PBattlefield = it->second;
        if (PBattlefield->CanCleanup())
        {
            if (PBattlefield->Cleanup(tick, false))
            {
                it = m_Battlefields.erase(it);
                ShowDebug("[CBattlefieldHandler]HandleBattlefields cleaned up Battlefield %s", PBattlefield->GetName().c_str());
                destroy(PBattlefield);
                continue;
            }
        }

        ++it;
    }

    for (auto iter = m_orphanedPlayers.begin(); iter != m_orphanedPlayers.end();)
    {
        if (tick < (*iter).second)
        {
            ++iter;
            continue;
        }

        auto* PChar = m_PZone->GetCharByID((*iter).first);
        if (PChar)
        {
            luautils::OnBattlefieldKick(PChar);
            PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_CONFRONTATION, true);
            m_PZone->updateCharLevelRestriction(PChar);
        }
        iter = m_orphanedPlayers.erase(iter);
    }
}

uint8 CBattlefieldHandler::LoadBattlefield(CCharEntity* PChar, const BattlefieldRegistration& registration)
{
    TracyZoneScoped;
    if (PChar->PBattlefield != nullptr || m_Battlefields.size() >= m_MaxBattlefields)
    {
        return BATTLEFIELD_RETURN_CODE_WAIT;
    }

    for (auto&& battlefield : m_Battlefields)
    {
        if (battlefield.first == registration.area)
        {
            return BATTLEFIELD_RETURN_CODE_INCREMENT_REQUEST;
        }
    }

    if (registration.id == 0xFFFF)
    {
        // made it this far so looks like there's a free battlefield
        return BATTLEFIELD_RETURN_CODE_CUTSCENE;
    }

    // maxplayers being 0 means that all the battlefield information needs to come from the database
    if (registration.maxPlayers == 0)
    {
        const auto* fmtQuery = "SELECT name, fastestName, fastestTime, fastestPartySize, timeLimit, levelCap, lootDropId, partySize, rules, isMission\
                            FROM bcnm_info i\
                            WHERE bcnmId = %u";

        auto ret = _sql->Query(fmtQuery, registration.id);

        if (ret == SQL_ERROR || _sql->NumRows() == 0 || _sql->NextRow() != SQL_SUCCESS)
        {
            ShowError("Cannot load battlefield : %u ", registration.id);
            return BATTLEFIELD_RETURN_CODE_REQS_NOT_MET;
        }

        auto* PBattlefield = new CBattlefield(registration.id, m_PZone, registration.area, PChar, false);

        auto name                 = _sql->GetStringData(0);
        auto recordholder         = _sql->GetStringData(1);
        auto recordtime           = std::chrono::seconds(_sql->GetUIntData(2));
        auto recordPartySize      = _sql->GetUIntData(3);
        auto timelimit            = std::chrono::seconds(_sql->GetUIntData(4));
        auto levelcap             = _sql->GetUIntData(5);
        auto lootid               = _sql->GetUIntData(6);
        auto maxplayers           = _sql->GetUIntData(7);
        auto rulemask             = _sql->GetUIntData(8);
        PBattlefield->m_isMission = _sql->GetUIntData(9);

        PBattlefield->SetName(name);
        PBattlefield->SetRecord(recordholder, recordtime, recordPartySize);
        PBattlefield->SetTimeLimit(timelimit);
        PBattlefield->SetLevelCap(levelcap);

        PBattlefield->SetMaxParticipants(maxplayers);
        PBattlefield->SetRuleMask(rulemask);

        m_Battlefields.insert(std::make_pair(PBattlefield->GetArea(), PBattlefield));

        if (!PBattlefield->LoadMobs())
        {
            PBattlefield->SetStatus(BATTLEFIELD_STATUS_LOST);
            PBattlefield->CanCleanup(true);
            PBattlefield->Cleanup(time_point{}, true);
            ShowDebug("battlefield loading failed");
            return BATTLEFIELD_RETURN_CODE_WAIT;
        }

        if (lootid != 0)
        {
            PBattlefield->SetLocalVar("loot", lootid);
        }

        if (!PChar->StatusEffectContainer->GetStatusEffect(EFFECT_BATTLEFIELD))
        {
            PChar->StatusEffectContainer->AddStatusEffect(
                new CStatusEffect(EFFECT_BATTLEFIELD, EFFECT_BATTLEFIELD, PBattlefield->GetID(), 0, 0, PChar->id, PBattlefield->GetArea()), true);
        }

        luautils::OnBattlefieldRegister(PChar, PBattlefield);
        luautils::OnBattlefieldInitialise(PBattlefield);
        PBattlefield->InsertEntity(PChar, true);

        return BATTLEFIELD_RETURN_CODE_CUTSCENE;
    }

    auto* PBattlefield = new CBattlefield(registration.id, m_PZone, registration.area, PChar, true);

    const auto* fmtQuery = "SELECT name, fastestName, fastestTime, fastestPartySize\
                            FROM bcnm_info i\
                            WHERE bcnmId = %u";

    auto ret = _sql->Query(fmtQuery, registration.id);

    if (ret == SQL_ERROR || _sql->NumRows() == 0 || _sql->NextRow() != SQL_SUCCESS)
    {
        ShowError("Cannot load battlefield : %u ", registration.id);
        return BATTLEFIELD_RETURN_CODE_REQS_NOT_MET;
    }

    auto name            = _sql->GetStringData(0);
    auto recordholder    = _sql->GetStringData(1);
    auto recordtime      = std::chrono::seconds(_sql->GetUIntData(2));
    auto recordPartySize = _sql->GetUIntData(3);

    PBattlefield->SetName(name);
    PBattlefield->SetRecord(recordholder, recordtime, recordPartySize);
    PBattlefield->SetTimeLimit(registration.timeLimit);
    PBattlefield->SetLevelCap(registration.levelCap);
    PBattlefield->SetMaxParticipants(registration.maxPlayers);
    PBattlefield->SetRuleMask(registration.rules);
    PBattlefield->m_isMission = registration.isMission;
    PBattlefield->m_showTimer = registration.showTimer;

    m_Battlefields.insert(std::make_pair(PBattlefield->GetArea(), PBattlefield));

    if (!PChar->StatusEffectContainer->GetStatusEffect(EFFECT_BATTLEFIELD))
    {
        PChar->StatusEffectContainer->AddStatusEffect(
            new CStatusEffect(EFFECT_BATTLEFIELD, EFFECT_BATTLEFIELD, PBattlefield->GetID(), 0, 0, PChar->id, PBattlefield->GetArea()), true);
    }

    luautils::OnBattlefieldRegister(PChar, PBattlefield);
    luautils::OnBattlefieldInitialise(PBattlefield);
    PBattlefield->InsertEntity(PChar, true);

    return BATTLEFIELD_RETURN_CODE_CUTSCENE;
}

CBattlefield* CBattlefieldHandler::GetBattlefield(CBaseEntity* PEntity, bool checkRegistered)
{
    auto* entity = dynamic_cast<CBattleEntity*>(PEntity);

    if (checkRegistered && entity && entity->objtype == TYPE_PC)
    {
        for (auto& battlefield : m_Battlefields)
        {
            if (battlefield.second->IsRegistered(static_cast<CCharEntity*>(entity)))
            {
                return battlefield.second;
            }
        }
        return nullptr;
    }

    for (auto& battlefield : m_Battlefields)
    {
        if (battlefield.second->GetEntity(entity))
        {
            return battlefield.second;
        }
    }
    return nullptr;
}

CBattlefield* CBattlefieldHandler::GetBattlefieldByArea(uint8 area) const
{
    const auto it = m_Battlefields.find(area);
    return it != m_Battlefields.end() ? it->second : nullptr;
}

CBattlefield* CBattlefieldHandler::GetBattlefieldByInitiator(uint32 charID)
{
    for (auto& battlefield : m_Battlefields)
    {
        if (battlefield.second->GetInitiator().id == charID)
        {
            return battlefield.second;
        }
    }
    return nullptr;
}

uint8 CBattlefieldHandler::RegisterBattlefield(CCharEntity* PChar, const BattlefieldRegistration& registration)
{
    if (PChar->PBattlefield)
    {
        ShowDebug("%s tried to enter another battlefield", PChar->getName());
        return BATTLEFIELD_RETURN_CODE_WAIT;
    }
    // attempt to add to an existing battlefield
    auto* PBattlefield = GetBattlefield(PChar, true);

    // Could not find this character registered, try find by id and initiator
    if (!PBattlefield)
    {
        for (const auto& battlefield : m_Battlefields)
        {
            if (battlefield.second->GetInitiator().id == registration.initiator && battlefield.second->GetID() == registration.id)
            {
                PBattlefield = battlefield.second;
                break;
            }
        }
    }
    // Entity wasn't found in battlefield, assume they have the effect but not physically inside battlefield
    if (PBattlefield)
    {
        if (!PBattlefield->CheckInProgress())
        {
            // players haven't started fighting yet, try entering
            if (registration.area != PBattlefield->GetArea())
            {
                return BATTLEFIELD_RETURN_CODE_INCREMENT_REQUEST;
            }

            return PBattlefield->InsertEntity(PChar, false) ? BATTLEFIELD_RETURN_CODE_CUTSCENE : BATTLEFIELD_RETURN_CODE_BATTLEFIELD_FULL;
        }
        else
        {
            // todo: probably clear registered chars
            // can't enter, mobs been slapped
            return BATTLEFIELD_RETURN_CODE_LOCKED;
        }
    }
    return LoadBattlefield(PChar, registration);
}

bool CBattlefieldHandler::RemoveFromBattlefield(CBaseEntity* PEntity, CBattlefield* PBattlefield, uint8 leavecode)
{
    PBattlefield = PBattlefield ? PBattlefield : GetBattlefield(PEntity);
    return PBattlefield ? PBattlefield->RemoveEntity(PEntity, leavecode) : false;
}

bool CBattlefieldHandler::IsRegistered(CCharEntity* PChar)
{
    for (const auto& battlefield : m_Battlefields)
    {
        if (battlefield.second->IsRegistered(PChar))
        {
            return true;
        }
    }
    return false;
}

bool CBattlefieldHandler::ReachedMaxCapacity(int battlefieldId) const
{
    // area all areas full
    if (m_Battlefields.size() >= (size_t)m_MaxBattlefields)
    {
        return true;
    }

    // we have at least one free area and id has been passed so lets look it up
    if (battlefieldId != -1)
    {
        std::string query("SELECT battlefieldNumber FROM bcnm_battlefield WHERE bcnmId = %i;");
        auto        ret = _sql->Query(query.c_str(), battlefieldId);
        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                auto area = _sql->GetUIntData(0);
                if (m_Battlefields.find(area) == m_Battlefields.end())
                {
                    return false; // this area hasnt been loaded in for this battlefield
                }
            }
        }
        // all areas for this battlefield are full
        return true;
    }
    // we have a free battlefield
    return false;
}

uint8 CBattlefieldHandler::MaxBattlefieldAreas() const
{
    return m_MaxBattlefields;
}

void CBattlefieldHandler::addOrphanedPlayer(CCharEntity* PChar)
{
    auto orphan = std::make_pair(PChar->id, server_clock::now() + 5s);
    m_orphanedPlayers.emplace_back(orphan);
}
