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

#include "zone_instance.h"
#include "ai/ai_container.h"
#include "common/timer.h"
#include "entities/charentity.h"
#include "lua/luautils.h"
#include "status_effect_container.h"
#include "utils/charutils.h"
#include "utils/zoneutils.h"

CZoneInstance::CZoneInstance(ZONEID ZoneID, REGION_TYPE RegionID, CONTINENT_TYPE ContinentID, uint8 levelRestriction)
: CZone(ZoneID, RegionID, ContinentID, levelRestriction)
{
    TracyZoneScoped;
}

CZoneInstance::~CZoneInstance()
{
    TracyZoneScoped;
}

CCharEntity* CZoneInstance::GetCharByName(const std::string& name)
{
    TracyZoneScoped;
    CCharEntity* PEntity = nullptr;
    for (const auto& PInstance : m_InstanceList)
    {
        PEntity = PInstance->GetCharByName(name);
        if (PEntity)
        {
            break;
        }
    }
    return PEntity;
}

CCharEntity* CZoneInstance::GetCharByID(uint32 id)
{
    TracyZoneScoped;
    CCharEntity* PEntity = nullptr;
    for (const auto& PInstance : m_InstanceList)
    {
        PEntity = PInstance->GetCharByID(id);
        if (PEntity)
        {
            break;
        }
    }
    return PEntity;
}

CBaseEntity* CZoneInstance::GetEntity(uint16 targid, uint8 filter)
{
    TracyZoneScoped;
    CBaseEntity* PEntity = nullptr;
    if (filter & TYPE_PC)
    {
        for (const auto& PInstance : m_InstanceList)
        {
            PEntity = PInstance->GetEntity(targid, filter);
            if (PEntity)
            {
                break;
            }
        }
    }
    return PEntity;
}

void CZoneInstance::InsertMOB(CBaseEntity* PMob)
{
    TracyZoneScoped;
    if (PMob->PInstance)
    {
        PMob->PInstance->InsertMOB(PMob);
    }
}

void CZoneInstance::InsertNPC(CBaseEntity* PNpc)
{
    TracyZoneScoped;
    if (PNpc->PInstance)
    {
        PNpc->PInstance->InsertNPC(PNpc);
    }
}

void CZoneInstance::InsertPET(CBaseEntity* PPet)
{
    TracyZoneScoped;
    if (PPet->PInstance)
    {
        PPet->PInstance->InsertPET(PPet);
    }
}

void CZoneInstance::InsertTRUST(CBaseEntity* PTrust)
{
    TracyZoneScoped;
    if (PTrust->PInstance)
    {
        PTrust->PInstance->InsertTRUST(PTrust);
    }
}

void CZoneInstance::FindPartyForMob(CBaseEntity* PEntity)
{
    TracyZoneScoped;
    if (PEntity->PInstance)
    {
        PEntity->PInstance->FindPartyForMob(PEntity);
    }
}

void CZoneInstance::TransportDepart(uint16 boundary, uint16 zone)
{
    TracyZoneScoped;
    for (const auto& PInstance : m_InstanceList)
    {
        PInstance->TransportDepart(boundary, zone);
    }
}

void CZoneInstance::DecreaseZoneCounter(CCharEntity* PChar)
{
    TracyZoneScoped;
    CInstance* PInstance = PChar->PInstance;
    if (PInstance)
    {
        PInstance->DecreaseZoneCounter(PChar);
        PInstance->DespawnPC(PChar);
        CharZoneOut(PChar);
        PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEVEL_RESTRICTION);
        PChar->PInstance = nullptr;

        if (PInstance->CharListEmpty())
        {
            if (!(PInstance->Failed() || PInstance->Completed()))
            {
                PInstance->SetWipeTime(PInstance->GetElapsedTime(server_clock::now()));
            }
        }
    }
}

void CZoneInstance::IncreaseZoneCounter(CCharEntity* PChar)
{
    TracyZoneScoped;
    if (PChar == nullptr)
    {
        ShowWarning("PChar is null.");
        return;
    }

    if (PChar->loc.zone != nullptr)
    {
        ShowWarning("Zone was not null for %s.", PChar->getName());
        return;
    }

    if (PChar->PTreasurePool != nullptr)
    {
        ShowWarning("PTreasurePool was not empty for %s.", PChar->getName());
        return;
    }

    // return char to instance (d/c or logout)
    if (!PChar->PInstance)
    {
        for (const auto& PInstance : m_InstanceList)
        {
            if (PInstance->CharRegistered(PChar))
            {
                PChar->PInstance = PInstance.get();
            }
        }
    }

    if (PChar->PInstance)
    {
        if (!ZoneTimer)
        {
            createZoneTimers();
        }

        PChar->targid = PChar->PInstance->GetNewCharTargID();

        if (PChar->targid >= 0x700)
        {
            ShowError("CZone::InsertChar : targid is high (03hX), update packets will be ignored", PChar->targid);
            return;
        }

        PChar->PInstance->InsertPC(PChar);
        luautils::OnInstanceZoneIn(PChar, PChar->PInstance);
        CharZoneIn(PChar);

        if (PChar->PInstance->GetLevelCap() > 0)
        {
            PChar->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_LEVEL_RESTRICTION, EFFECT_LEVEL_RESTRICTION, PChar->PInstance->GetLevelCap(), 0, 0));
        }

        if (PChar->PInstance->CheckFirstEntry(PChar->id))
        {
            PChar->loc.p = PChar->PInstance->GetEntryLoc();
            PChar->PAI->QueueAction(queueAction_t(400ms, false, luautils::AfterInstanceRegister));
        }
    }
    else
    {
        ShowWarning(fmt::format("Failed to place {} in {} ({}). Placing them in that zone's instance exit area.",
                                PChar->name, this->getName(), this->GetID())
                        .c_str());

        // instance no longer exists: put them outside (at exit)
        uint16 zoneid = luautils::OnInstanceLoadFailed(this);

        CZone* PZone = zoneutils::GetZone(zoneid);
        // At this stage, can only send the player to a zone on this map server
        // reset position in the case of a zone crash while in an instance
        PChar->loc.p.x = 0;
        PChar->loc.p.y = 0;
        PChar->loc.p.z = 0;
        if (PZone)
        {
            PZone->IncreaseZoneCounter(PChar);
        }
        else
        {
            // if we can't get the instance failed destination zone, get their previous zone
            zoneid = PChar->loc.prevzone;
            zoneutils::GetZone(zoneid)->IncreaseZoneCounter(PChar);
        }

        // They are properly sent to zone, but bypassed the onZoneIn position fixup, do that now
        PChar->loc.prevzone    = GetID();
        PChar->loc.destination = zoneid;
        luautils::OnZoneIn(PChar);
        charutils::SaveCharPosition(PChar);
    }
}

void CZoneInstance::SpawnMOBs(CCharEntity* PChar)
{
    TracyZoneScoped;
    if (PChar->PInstance)
    {
        PChar->PInstance->SpawnMOBs(PChar);
    }
}

void CZoneInstance::SpawnPETs(CCharEntity* PChar)
{
    TracyZoneScoped;
    if (PChar->PInstance)
    {
        PChar->PInstance->SpawnPETs(PChar);
    }
}

void CZoneInstance::SpawnTRUSTs(CCharEntity* PChar)
{
    TracyZoneScoped;
    if (PChar->PInstance)
    {
        PChar->PInstance->SpawnTRUSTs(PChar);
    }
}

void CZoneInstance::SpawnNPCs(CCharEntity* PChar)
{
    TracyZoneScoped;
    if (PChar->PInstance)
    {
        PChar->PInstance->SpawnNPCs(PChar);
    }
}

void CZoneInstance::SpawnPCs(CCharEntity* PChar)
{
    TracyZoneScoped;
    if (PChar->PInstance)
    {
        PChar->PInstance->SpawnPCs(PChar);
    }
}

void CZoneInstance::SpawnConditionalNPCs(CCharEntity* PChar)
{
    TracyZoneScoped;
    if (PChar->PInstance)
    {
        PChar->PInstance->SpawnConditionalNPCs(PChar);
    }
}

void CZoneInstance::SpawnTransport(CCharEntity* PChar)
{
    TracyZoneScoped;
    if (PChar->PInstance)
    {
        PChar->PInstance->SpawnTransport(PChar);
    }
}

void CZoneInstance::TOTDChange(TIMETYPE TOTD)
{
    TracyZoneScoped;
    for (const auto& PInstance : m_InstanceList)
    {
        PInstance->TOTDChange(TOTD);
    }
}

void CZoneInstance::PushPacket(CBaseEntity* PEntity, GLOBAL_MESSAGE_TYPE message_type, const std::unique_ptr<CBasicPacket>& packet)
{
    TracyZoneScoped;

    if (PEntity)
    {
        if (PEntity->PInstance)
        {
            PEntity->PInstance->PushPacket(PEntity, message_type, packet);
        }
    }
    else
    {
        for (const auto& PInstance : m_InstanceList)
        {
            PInstance->PushPacket(PEntity, message_type, packet);
        }
    }
}

void CZoneInstance::UpdateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask, bool alwaysInclude)
{
    TracyZoneScoped;

    if (PEntity)
    {
        if (PEntity->PInstance)
        {
            PEntity->PInstance->UpdateEntityPacket(PEntity, type, updatemask, alwaysInclude);
        }
    }
    else
    {
        for (const auto& PInstance : m_InstanceList)
        {
            PInstance->UpdateEntityPacket(PEntity, type, updatemask, alwaysInclude);
        }
    }
}

void CZoneInstance::WideScan(CCharEntity* PChar, uint16 radius)
{
    TracyZoneScoped;

    if (PChar->PInstance)
    {
        PChar->PInstance->WideScan(PChar, radius);
    }
}

void CZoneInstance::ZoneServer(time_point tick)
{
    TracyZoneScoped;

    std::vector<CInstance*> instancesToRemove;
    for (const auto& PInstance : m_InstanceList)
    {
        PInstance->ZoneServer(tick);
        PInstance->CheckTime(tick);

        if ((PInstance->Failed() || PInstance->Completed()) && PInstance->CharListEmpty())
        {
            instancesToRemove.push_back(PInstance.get());
        }
    }

    for (const auto& PInstance : instancesToRemove)
    {
        ShowDebug("[CZoneInstance] ZoneServer cleaned up Instance %s", PInstance->GetName());

        // clang-format off
        m_InstanceList.erase(std::find_if(m_InstanceList.begin(), m_InstanceList.end(), [&PInstance](const auto& el)
        {
            return el.get() == PInstance;
        }));
        // clang-format on
    }
}

void CZoneInstance::CheckTriggerAreas()
{
    TracyZoneScoped;

    for (const auto& PInstance : m_InstanceList)
    {
        // clang-format off
        PInstance->ForEachChar([&](CCharEntity* PChar)
        {
            // TODO: When we start to use octrees or spatial hashing to split up zones,
            //     : use them here to make the search domain smaller.

            // Do not enter trigger areas while loading in. Set in xi.player.onGameIn
            if (PChar->GetLocalVar("ZoningIn") > 0)
            {
                return;
            }

            for (const auto& triggerArea : m_triggerAreaList)
            {
                const auto triggerAreaID = triggerArea->getTriggerAreaID();
                if (triggerArea->isPointInside(PChar->loc.p))
                {
                    if (!PChar->isInTriggerArea(triggerAreaID))
                    {
                        // Add the TriggerArea to the players cache of current TriggerAreas
                        PChar->onTriggerAreaEnter(triggerAreaID);
                        luautils::OnTriggerAreaEnter(PChar, triggerArea);
                    }
                }
                else if (PChar->isInTriggerArea(triggerAreaID))
                {
                    // Remove the TriggerArea from the players cache of current TriggerAreas
                    PChar->onTriggerAreaLeave(triggerAreaID);
                    luautils::OnTriggerAreaLeave(PChar, triggerArea);
                }
            }
        });
        // clang-format on
    }
}

void CZoneInstance::ForEachChar(const std::function<void(CCharEntity*)>& func)
{
    TracyZoneScoped;

    for (const auto& PInstance : m_InstanceList)
    {
        PInstance->ForEachChar(func);
    }
}

void CZoneInstance::ForEachCharInstance(CBaseEntity* PEntity, const std::function<void(CCharEntity*)>& func)
{
    TracyZoneScoped;

    if (PEntity->PInstance)
    {
        PEntity->PInstance->ForEachChar(func);
    }
}

void CZoneInstance::ForEachMob(const std::function<void(CMobEntity*)>& func)
{
    TracyZoneScoped;

    for (const auto& PInstance : m_InstanceList)
    {
        PInstance->ForEachMob(func);
    }
}

void CZoneInstance::ForEachMobInstance(CBaseEntity* PEntity, const std::function<void(CMobEntity*)>& func)
{
    TracyZoneScoped;

    if (PEntity->PInstance)
    {
        PEntity->PInstance->ForEachMob(func);
    }
}

void CZoneInstance::ForEachNpc(const std::function<void(CNpcEntity*)>& func)
{
    TracyZoneScoped;

    for (const auto& PInstance : m_InstanceList)
    {
        PInstance->ForEachNpc(func);
    }
}

void CZoneInstance::ForEachNpcInstance(CBaseEntity* PEntity, const std::function<void(CNpcEntity*)>& func)
{
    TracyZoneScoped;

    if (PEntity->PInstance)
    {
        PEntity->PInstance->ForEachNpc(func);
    }
}

void CZoneInstance::ForEachTrust(const std::function<void(CTrustEntity*)>& func)
{
    TracyZoneScoped;

    for (const auto& PInstance : m_InstanceList)
    {
        PInstance->ForEachTrust(func);
    }
}

void CZoneInstance::ForEachTrustInstance(CBaseEntity* PEntity, const std::function<void(CTrustEntity*)>& func)
{
    TracyZoneScoped;

    if (PEntity->PInstance)
    {
        PEntity->PInstance->ForEachTrust(func);
    }
}

void CZoneInstance::ForEachPet(const std::function<void(CPetEntity*)>& func)
{
    TracyZoneScoped;

    for (const auto& PInstance : m_InstanceList)
    {
        PInstance->ForEachPet(func);
    }
}

void CZoneInstance::ForEachPetInstance(CBaseEntity* PEntity, const std::function<void(CPetEntity*)>& func)
{
    TracyZoneScoped;

    if (PEntity->PInstance)
    {
        PEntity->PInstance->ForEachPet(func);
    }
}

void CZoneInstance::ForEachAlly(const std::function<void(CMobEntity*)>& func)
{
    TracyZoneScoped;

    for (const auto& PInstance : m_InstanceList)
    {
        PInstance->ForEachAlly(func);
    }
}

void CZoneInstance::ForEachAllyInstance(CBaseEntity* PEntity, const std::function<void(CMobEntity*)>& func)
{
    TracyZoneScoped;

    if (PEntity->PInstance)
    {
        PEntity->PInstance->ForEachAlly(func);
    }
}

CInstance* CZoneInstance::CreateInstance(uint16 instanceid)
{
    TracyZoneScoped;
    m_InstanceList.emplace_back(std::make_unique<CInstance>(this, instanceid));
    return m_InstanceList.back().get();
}
