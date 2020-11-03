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

#include "zone_entities.h"

#include "../common/utils.h"
#include "party.h"
#include "latent_effect_container.h"
#include "status_effect_container.h"
#include "recast_container.h"
#include "treasure_pool.h"
#include "mob_modifier.h"
#include "enmity_container.h"
#include "trade_container.h"

#include "ai/ai_container.h"
#include "ai/controllers/mob_controller.h"

#include "entities/trustentity.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"

#include "packets/char.h"
#include "packets/char_sync.h"
#include "packets/trust_sync.h"
#include "packets/entity_update.h"
#include "packets/entity_visual.h"
#include "packets/wide_scan.h"

#include "lua/luautils.h"

#include "utils/battlefieldutils.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "utils/petutils.h"
#include "utils/zoneutils.h"
#include "utils/synthutils.h"
#include "battlefield.h"

CZoneEntities::CZoneEntities(CZone* zone)
{
    m_zone = zone;
    m_Transport = nullptr;
}

CZoneEntities::~CZoneEntities()
{

}

void CZoneEntities::HealAllMobs()
{
    for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
    {
        CMobEntity* PCurrentMob = (CMobEntity*)it->second;

        // keep resting until i'm full
        PCurrentMob->Rest(1);
    }
}

void CZoneEntities::InsertPC(CCharEntity* PChar)
{
    m_charList[PChar->targid] = PChar;
    ShowDebug(CL_CYAN"CZone:: %s IncreaseZoneCounter <%u> %s \n" CL_RESET, m_zone->GetName(), m_charList.size(), PChar->GetName());
}

void CZoneEntities::InsertAlly(CBaseEntity* PMob)
{
    if ((PMob != nullptr) && (PMob->objtype == TYPE_MOB))
    {
        PMob->loc.zone = m_zone;
        m_allyList[PMob->targid] = PMob;
    }
}

void CZoneEntities::InsertMOB(CBaseEntity* PMob)
{
    if ((PMob != nullptr) && (PMob->objtype == TYPE_MOB))
    {
        PMob->loc.zone = m_zone;

        FindPartyForMob(PMob);
        m_mobList[PMob->targid] = PMob;
    }
}

void CZoneEntities::InsertNPC(CBaseEntity* PNpc)
{
    if ((PNpc != nullptr) && (PNpc->objtype == TYPE_NPC))
    {
        PNpc->loc.zone = m_zone;

        if (PNpc->look.size == MODEL_SHIP)
        {
            m_Transport = PNpc;
            return;
        }
        m_npcList[PNpc->targid] = PNpc;
    }
}

void CZoneEntities::DeletePET(CBaseEntity* PPet)
{
    if (PPet != nullptr)
    {
        m_petList.erase(PPet->targid);
    }
}

void CZoneEntities::InsertPET(CBaseEntity* PPet)
{
    if (PPet != nullptr)
    {
        uint16 targid = 0x700;

        for (EntityList_t::const_iterator it = m_petList.begin(); it != m_petList.end(); ++it)
        {
            if (targid != it->first)
            {
                break;
            }
            targid++;
        }
        if (targid >= 0x780)
        {
            ShowError(CL_RED"CZone::InsertPET : targid is high (03hX)\n" CL_RESET, targid);
            return;
        }
        PPet->id = 0x1000000 + (m_zone->GetID() << 12) + targid;
        PPet->targid = targid;
        PPet->loc.zone = m_zone;
        m_petList[PPet->targid] = PPet;

        for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
        {
            CCharEntity* PCurrentChar = (CCharEntity*)it->second;

            if (distance(PPet->loc.p, PCurrentChar->loc.p) < 50)
            {
                PCurrentChar->SpawnPETList[PPet->id] = PPet;
                PCurrentChar->pushPacket(new CEntityUpdatePacket(PPet, ENTITY_SPAWN, UPDATE_ALL_MOB));
            }
        }
        return;
    }
    ShowError(CL_RED"CZone::InsertPET : entity is null\n" CL_RESET);
}

void CZoneEntities::InsertTRUST(CBaseEntity* PTrust)
{
    if (PTrust != nullptr)
    {
        uint16 targid = 0x780;

        for (EntityList_t::const_iterator it = m_trustList.begin(); it != m_trustList.end(); ++it)
        {
            if (targid != it->first)
            {
                break;
            }
            targid++;
        }
        if (targid >= 0x800)
        {
            ShowError(CL_RED"CZone::InsertTRUST : targid is high (03hX)\n" CL_RESET, targid);
            return;
        }
        PTrust->id = 0x1000000 + (m_zone->GetID() << 12) + targid;
        PTrust->targid = targid;
        PTrust->loc.zone = m_zone;
        m_trustList[PTrust->targid] = PTrust;

        for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
        {
            CCharEntity* PCurrentChar = (CCharEntity*)it->second;

            if (distance(PTrust->loc.p, PCurrentChar->loc.p) < 50)
            {
                if (PCurrentChar->targid == ((CBattleEntity*)PTrust)->PMaster->targid)
                {
                    PCurrentChar->SpawnTRUSTList[PTrust->id] = PTrust;
                }
                PCurrentChar->pushPacket(new CEntityUpdatePacket(PTrust, ENTITY_SPAWN, UPDATE_ALL_MOB));
            }
        }
        return;
    }
}

void CZoneEntities::DeleteTRUST(CBaseEntity* PTrust)
{
    if (PTrust != nullptr)
    {
        m_trustList.erase(PTrust->id);
    }
}

void CZoneEntities::FindPartyForMob(CBaseEntity* PEntity)
{
    TPZ_DEBUG_BREAK_IF(PEntity == nullptr);
    TPZ_DEBUG_BREAK_IF(PEntity->objtype != TYPE_MOB);

    CMobEntity* PMob = (CMobEntity*)PEntity;

    // force all mobs in a burning circle to link
    ZONETYPE zonetype = m_zone->GetType();
    bool forceLink = zonetype == ZONETYPE_DYNAMIS || PMob->getMobMod(MOBMOD_SUPERLINK);

    if ((forceLink || PMob->m_Link) && PMob->PParty == nullptr)
    {
        for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
        {
            CMobEntity* PCurrentMob = (CMobEntity*)it->second;

            if (!forceLink && !PCurrentMob->m_Link) continue;

            int16 sublink = PMob->getMobMod(MOBMOD_SUBLINK);

            if (PCurrentMob->allegiance == PMob->allegiance &&
                (forceLink ||
                    PCurrentMob->m_Family == PMob->m_Family ||
                    (sublink && sublink == PCurrentMob->getMobMod(MOBMOD_SUBLINK))))
            {

                if (PCurrentMob->PMaster == nullptr || PCurrentMob->PMaster->objtype == TYPE_MOB)
                {
                    PCurrentMob->PParty->AddMember(PMob);
                    return;
                }
            }
        }
        PMob->PParty = new CParty(PMob);
    }
}

void CZoneEntities::TransportDepart(uint16 boundary, uint16 zone)
{
    for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
    {
        CCharEntity* PCurrentChar = (CCharEntity*)it->second;

        if (PCurrentChar->loc.boundary == boundary)
        {
            if (PCurrentChar->m_event.Target != nullptr)
            {
                //The player talked to one of the guys on the boat, and the event target is wrong.
                //This leads to the wrong script being loaded and you get stuck on a black screen
                //instead of loading into the port.

                //Attempt to load the proper script
                PCurrentChar->m_event.Target = nullptr;
                size_t deleteStart = PCurrentChar->m_event.Script.find("npcs/");
                size_t deleteEnd = PCurrentChar->m_event.Script.find(".lua");

                if (deleteStart != std::string::npos && deleteEnd != std::string::npos)
                    PCurrentChar->m_event.Script.replace(deleteStart, deleteEnd - deleteStart, "Zone");
            }
            luautils::OnTransportEvent(PCurrentChar, zone);
        }

    }
}

void CZoneEntities::WeatherChange(WEATHER weather)
{
    TracyZoneScoped;
    auto element = zoneutils::GetWeatherElement(weather);
    for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
    {
        CMobEntity* PCurrentMob = (CMobEntity*)it->second;

        PCurrentMob->PAI->EventHandler.triggerListener("WEATHER_CHANGE", PCurrentMob, static_cast<int>(weather), element);
        // can't detect by scent in this weather
        if (PCurrentMob->m_Detects & DETECT_SCENT)
        {
            PCurrentMob->m_disableScent = (weather == WEATHER_RAIN || weather == WEATHER_SQUALL || weather == WEATHER_BLIZZARDS);
        }

        if (PCurrentMob->m_EcoSystem == SYSTEM_ELEMENTAL && PCurrentMob->PMaster == nullptr && PCurrentMob->m_SpawnType & SPAWNTYPE_WEATHER)
        {
            if (PCurrentMob->m_Element == element)
            {
                PCurrentMob->SetDespawnTime(0s);
                PCurrentMob->m_AllowRespawn = true;
                PCurrentMob->Spawn();
            }
            else
            {
                PCurrentMob->SetDespawnTime(1s);
                PCurrentMob->m_AllowRespawn = false;
            }
        }
        else if (PCurrentMob->m_SpawnType & SPAWNTYPE_FOG)
        {
            if (weather == WEATHER_FOG)
            {
                PCurrentMob->SetDespawnTime(0s);
                PCurrentMob->m_AllowRespawn = true;
                PCurrentMob->Spawn();
            }
            else
            {
                PCurrentMob->SetDespawnTime(1s);
                PCurrentMob->m_AllowRespawn = false;
            }
        }
    }

    for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
    {
        CCharEntity* PChar = (CCharEntity*)it->second;

        PChar->PLatentEffectContainer->CheckLatentsWeather(weather);
        PChar->PAI->EventHandler.triggerListener("WEATHER_CHANGE", PChar, static_cast<int>(weather), element);
    }
}

void CZoneEntities::DecreaseZoneCounter(CCharEntity* PChar)
{
    TPZ_DEBUG_BREAK_IF(PChar == nullptr);
    TPZ_DEBUG_BREAK_IF(PChar->loc.zone != m_zone);
    TracyZoneScoped;

    battleutils::RelinquishClaim(PChar);

    //remove pets
    if (PChar->PPet != nullptr)
    {
        charutils::BuildingCharPetAbilityTable(PChar, (CPetEntity*)PChar->PPet, 0);//blank the pet commands
        if (PChar->PPet->isCharmed) {
            petutils::DespawnPet(PChar);
        }
        else {
            PChar->PPet->status = STATUS_DISAPPEAR;
            if (((CPetEntity*)(PChar->PPet))->getPetType() == PETTYPE_AVATAR)
                PChar->setModifier(Mod::AVATAR_PERPETUATION, 0);
        }
        // It may have been nullptred by DespawnPet
        if (PChar->PPet != nullptr) {
            PChar->PPet->PAI->Disengage();

            for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
            {
                //inform other players of the pets removal
                CCharEntity* PCurrentChar = (CCharEntity*)it->second;
                SpawnIDList_t::iterator PET = PCurrentChar->SpawnPETList.find(PChar->PPet->id);

                if (PET != PCurrentChar->SpawnPETList.end())
                {
                    PCurrentChar->SpawnPETList.erase(PET);
                    PCurrentChar->pushPacket(new CEntityUpdatePacket(PChar->PPet, ENTITY_DESPAWN, UPDATE_NONE));
                }
            }
            PChar->PPet = nullptr;
        }
    }

    //remove trusts
    for (auto trust : PChar->PTrusts)
    {
        for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
        {
            //inform other players of the pets removal
            CCharEntity* PCurrentChar = (CCharEntity*)it->second;
            PCurrentChar->pushPacket(new CEntityUpdatePacket(trust, ENTITY_DESPAWN, UPDATE_NONE));
        }
    }
    PChar->ClearTrusts();
    PChar->SpawnTRUSTList.clear();

    if (m_zone->m_BattlefieldHandler)
        m_zone->m_BattlefieldHandler->RemoveFromBattlefield(PChar, PChar->PBattlefield, BATTLEFIELD_LEAVE_CODE_WARPDC);

    for (auto PMobIt : m_mobList)
    {
        CMobEntity* PCurrentMob = (CMobEntity*)PMobIt.second;
        PCurrentMob->PEnmityContainer->LogoutReset(PChar->id);
        if (PCurrentMob->m_OwnerID.id == PChar->id)
        {
            PCurrentMob->m_OwnerID.clean();
            PCurrentMob->updatemask |= UPDATE_STATUS;
        }
        if (PCurrentMob->GetBattleTargetID() == PChar->targid)
        {
            PCurrentMob->SetBattleTargetID(0);
        }
    }

    if (PChar->animation == ANIMATION_SYNTH)
    {
        PChar->CraftContainer->setQuantity(0, synthutils::SYNTHESIS_FAIL);
        synthutils::sendSynthDone(PChar);
    }

    // TODO: могут возникать проблемы с переходом между одной и той же зоной (zone == prevzone)

    m_charList.erase(PChar->targid);

    ShowDebug(CL_CYAN"CZone:: %s DecreaseZoneCounter <%u> %s\n" CL_RESET, m_zone->GetName(), m_charList.size(), PChar->GetName());
}

uint16 CZoneEntities::GetNewTargID()
{
    uint16 targid = 0x400;
    for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
    {
        if (targid != it->first)
        {
            break;
        }
        targid++;
    }
    return targid;
}

bool CZoneEntities::CharListEmpty()
{
    return m_charList.empty();
}

void CZoneEntities::DespawnPC(CCharEntity* PChar)
{
    for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
    {
        CCharEntity* PCurrentChar = (CCharEntity*)it->second;
        SpawnIDList_t::iterator PC = PCurrentChar->SpawnPCList.find(PChar->id);

        if (PC != PCurrentChar->SpawnPCList.end())
        {
            PCurrentChar->SpawnPCList.erase(PC);
            PCurrentChar->pushPacket(new CCharPacket(PChar, ENTITY_DESPAWN, 0));
        }
    }
}

void CZoneEntities::SpawnMOBs(CCharEntity* PChar)
{
    TracyZoneScoped;
    for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
    {
        CMobEntity* PCurrentMob = (CMobEntity*)it->second;
        SpawnIDList_t::iterator MOB = PChar->SpawnMOBList.lower_bound(PCurrentMob->id);

        float CurrentDistance = distance(PChar->loc.p, PCurrentMob->loc.p);

        if (PCurrentMob->status != STATUS_DISAPPEAR && CurrentDistance < 50)
        {
            if (MOB == PChar->SpawnMOBList.end() || PChar->SpawnMOBList.key_comp()(PCurrentMob->id, MOB->first))
            {
                PChar->SpawnMOBList.insert(MOB, SpawnIDList_t::value_type(PCurrentMob->id, PCurrentMob));
                PChar->pushPacket(new CEntityUpdatePacket(PCurrentMob, ENTITY_SPAWN, UPDATE_ALL_MOB));
            }

            if (PChar->isDead() || PChar->nameflags.flags & FLAG_GM || PCurrentMob->PMaster)
                continue;

            // проверка ночного/дневного сна монстров уже учтена в проверке CurrentAction, т.к. во сне монстры не ходят ^^

            const EMobDifficulty mobCheck = charutils::CheckMob(PChar->GetMLevel(), PCurrentMob->GetMLevel());

            CMobController* PController = static_cast<CMobController*>(PCurrentMob->PAI->GetController());

            bool validAggro = mobCheck > EMobDifficulty::TooWeak || PChar->isSitting() || PCurrentMob->getMobMod(MOBMOD_ALWAYS_AGGRO);

            if (validAggro && PController->CanAggroTarget(PChar))
                PCurrentMob->PEnmityContainer->AddBaseEnmity(PChar);
        }
        else
        {
            if (MOB != PChar->SpawnMOBList.end() && !(PChar->SpawnMOBList.key_comp()(PCurrentMob->id, MOB->first)))
            {
                PChar->SpawnMOBList.erase(MOB);
                PChar->pushPacket(new CEntityUpdatePacket(PCurrentMob, ENTITY_DESPAWN, UPDATE_NONE));
            }
        }
    }
}

void CZoneEntities::SpawnPETs(CCharEntity* PChar)
{
    TracyZoneScoped;
    for (EntityList_t::const_iterator it = m_petList.begin(); it != m_petList.end(); ++it)
    {
        CPetEntity* PCurrentPet = (CPetEntity*)it->second;
        SpawnIDList_t::iterator PET = PChar->SpawnPETList.lower_bound(PCurrentPet->id);

        if ((PCurrentPet->status == STATUS_NORMAL || PCurrentPet->status == STATUS_MOB) &&
            distance(PChar->loc.p, PCurrentPet->loc.p) < 50)
        {
            if (PET == PChar->SpawnPETList.end() ||
                PChar->SpawnPETList.key_comp()(PCurrentPet->id, PET->first))
            {
                PChar->SpawnPETList.insert(PET, SpawnIDList_t::value_type(PCurrentPet->id, PCurrentPet));
                PChar->pushPacket(new CEntityUpdatePacket(PCurrentPet, ENTITY_SPAWN, UPDATE_ALL_MOB));
            }
        }
        else {
            if (PET != PChar->SpawnPETList.end() &&
                !(PChar->SpawnPETList.key_comp()(PCurrentPet->id, PET->first)))
            {
                PChar->SpawnPETList.erase(PET);
                PChar->pushPacket(new CEntityUpdatePacket(PCurrentPet, ENTITY_DESPAWN, UPDATE_NONE));
            }
        }
    }
}

void CZoneEntities::SpawnNPCs(CCharEntity* PChar)
{
    TracyZoneScoped;
    if (!PChar->m_moghouseID)
    {
        for (EntityList_t::const_iterator it = m_npcList.begin(); it != m_npcList.end(); ++it)
        {
            CNpcEntity* PCurrentNpc = (CNpcEntity*)it->second;
            SpawnIDList_t::iterator NPC = PChar->SpawnNPCList.lower_bound(PCurrentNpc->id);

            if (PCurrentNpc->status == STATUS_NORMAL || PCurrentNpc->status == STATUS_MOB)
            {
                if (distance(PChar->loc.p, PCurrentNpc->loc.p) < 50)
                {
                    if (NPC == PChar->SpawnNPCList.end() ||
                        PChar->SpawnNPCList.key_comp()(PCurrentNpc->id, NPC->first))
                    {
                        PChar->SpawnNPCList.insert(NPC, SpawnIDList_t::value_type(PCurrentNpc->id, PCurrentNpc));
                        PChar->pushPacket(new CEntityUpdatePacket(PCurrentNpc, ENTITY_SPAWN, UPDATE_ALL_MOB));
                    }
                }
                else {
                    if (NPC != PChar->SpawnNPCList.end() &&
                        !(PChar->SpawnNPCList.key_comp()(PCurrentNpc->id, NPC->first)))
                    {
                        PChar->SpawnNPCList.erase(NPC);
                        PChar->pushPacket(new CEntityUpdatePacket(PCurrentNpc, ENTITY_DESPAWN, UPDATE_NONE));
                    }
                }
            }
        }
    }
}

void CZoneEntities::SpawnTRUSTs(CCharEntity* PChar)
{
    for (EntityList_t::const_iterator TrustItr = m_trustList.begin(); TrustItr != m_trustList.end(); ++TrustItr)
    {
        if (CTrustEntity* PCurrentTrust = dynamic_cast<CTrustEntity*>(TrustItr->second))
        {
            SpawnIDList_t::iterator SpawnTrustItr = PChar->SpawnTRUSTList.lower_bound(PCurrentTrust->id);
            CCharEntity* PMaster = dynamic_cast<CCharEntity*>(PCurrentTrust->PMaster);

            if (PCurrentTrust->status == STATUS_NORMAL && distance(PChar->loc.p, PCurrentTrust->loc.p) < 50)
            {
                if (SpawnTrustItr == PChar->SpawnTRUSTList.end() || PChar->SpawnTRUSTList.key_comp()(PCurrentTrust->id, SpawnTrustItr->first))
                {
                    PChar->SpawnTRUSTList.insert(SpawnTrustItr, SpawnIDList_t::value_type(PCurrentTrust->id, PCurrentTrust));
                    PChar->pushPacket(new CEntityUpdatePacket(PCurrentTrust, ENTITY_SPAWN, UPDATE_ALL_MOB));
                    if (PMaster)
                    {
                        PChar->pushPacket(new CTrustSyncPacket(PMaster, PCurrentTrust));
                    }  
                }
            }
            else
            {
                if (SpawnTrustItr != PChar->SpawnTRUSTList.end() && !(PChar->SpawnTRUSTList.key_comp()(PCurrentTrust->id, SpawnTrustItr->first)))
                {
                    PChar->SpawnTRUSTList.erase(SpawnTrustItr);
                    PChar->pushPacket(new CEntityUpdatePacket(PCurrentTrust, ENTITY_DESPAWN, UPDATE_NONE));
                }
            }
        }
    }
}

void CZoneEntities::SpawnPCs(CCharEntity* PChar)
{
    TracyZoneScoped;
    for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
    {
        CCharEntity* PCurrentChar = (CCharEntity*)it->second;
        SpawnIDList_t::iterator PC = PChar->SpawnPCList.find(PCurrentChar->id);

        if (PChar != PCurrentChar)
        {
            if (distance(PChar->loc.p, PCurrentChar->loc.p) < 50 && PChar->m_moghouseID == PCurrentChar->m_moghouseID)
            {
                if (PC == PChar->SpawnPCList.end())
                {
                    if (PCurrentChar->m_isGMHidden == false)
                    {
                        PChar->SpawnPCList[PCurrentChar->id] = PCurrentChar;
                        PChar->pushPacket(new CCharPacket(PCurrentChar, ENTITY_SPAWN, UPDATE_ALL_CHAR));
                        PChar->pushPacket(new CCharSyncPacket(PCurrentChar));
                    }

                    if (PChar->m_isGMHidden == false)
                    {
                        PCurrentChar->SpawnPCList[PChar->id] = PChar;
                        PCurrentChar->pushPacket(new CCharPacket(PChar, ENTITY_SPAWN, UPDATE_ALL_CHAR));
                        PCurrentChar->pushPacket(new CCharSyncPacket(PChar));
                    }
                }
                else
                {
                    if (PCurrentChar->m_isGMHidden == true)
                    {
                        PChar->SpawnPCList.erase(PC);
                    }
                    // TODO: figure out a way to push these packets in response to 0x015s while preserving the mask
                    //  every operation on the mask should persist for 400ms (0x015 frequency)
                    /*else if (PChar->updatemask != 0)
                    {
                        PCurrentChar->pushPacket(new CCharPacket(PChar, ENTITY_UPDATE, PChar->updatemask));
                    }*/
                }
            }
            else
            {
                if (PC != PChar->SpawnPCList.end())
                {
                    PChar->SpawnPCList.erase(PC);
                    PChar->pushPacket(new CCharPacket(PCurrentChar, ENTITY_DESPAWN, 0));

                    PCurrentChar->SpawnPCList.erase(PChar->id);
                    PCurrentChar->pushPacket(new CCharPacket(PChar, ENTITY_DESPAWN, 0));
                }
            }
        }
    }
}

void CZoneEntities::SpawnMoogle(CCharEntity* PChar)
{
    for (EntityList_t::const_iterator it = m_npcList.begin(); it != m_npcList.end(); ++it)
    {
        CNpcEntity* PCurrentNpc = (CNpcEntity*)it->second;

        if (PCurrentNpc->loc.p.z == 1.5 &&
            PCurrentNpc->look.face == 0x52)
        {
            PCurrentNpc->status = STATUS_NORMAL;
            PChar->pushPacket(new CEntityUpdatePacket(PCurrentNpc, ENTITY_SPAWN, UPDATE_ALL_MOB));
            PCurrentNpc->status = STATUS_DISAPPEAR;
            return;
        }
    }
}

void CZoneEntities::SpawnTransport(CCharEntity* PChar)
{
    if (m_Transport != nullptr)
    {
        PChar->pushPacket(new CEntityUpdatePacket(m_Transport, ENTITY_SPAWN, UPDATE_ALL_MOB));
        return;
    }
}

CBaseEntity* CZoneEntities::GetEntity(uint16 targid, uint8 filter)
{
    if (targid < 0x400)
    {
        if (filter & TYPE_MOB)
        {
            EntityList_t::const_iterator it = m_mobList.find(targid);
            if (it != m_mobList.end())
            {
                return it->second;
            }
        }
        if (filter & TYPE_NPC)
        {
            EntityList_t::const_iterator it = m_npcList.find(targid);
            if (it != m_npcList.end())
            {
                return it->second;
            }
        }
        if (filter & TYPE_SHIP)
        {
            if (m_Transport != nullptr && m_Transport->targid == targid)
            {
                return m_Transport;
            }
        }
    }
    else if (targid < 0x700)
    {
        if (filter & TYPE_PC)
        {
            EntityList_t::const_iterator it = m_charList.find(targid);
            if (it != m_charList.end())
            {
                return it->second;
            }
        }
    }
    else if (targid < 0x780)
    {
        if (filter & TYPE_PET)
        {
            EntityList_t::const_iterator it = m_petList.find(targid);
            if (it != m_petList.end())
            {
                return it->second;
            }
        }
    }
    else if (targid < 0x800)
    {
        if (filter & TYPE_TRUST)
        {
            EntityList_t::const_iterator it = m_trustList.find(targid);
            if (it != m_trustList.end())
            {
                return it->second;
            }
        }
    }
    return nullptr;
}

void CZoneEntities::TOTDChange(TIMETYPE TOTD)
{
    SCRIPTTYPE ScriptType = SCRIPT_NONE;

    switch (TOTD)
    {
        case TIME_MIDNIGHT:
        {

        }
        break;
        case TIME_NEWDAY:
        {
            for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
            {
                CMobEntity* PMob = (CMobEntity*)it->second;

                if (PMob->m_SpawnType & SPAWNTYPE_ATNIGHT)
                {
                    PMob->SetDespawnTime(1ms);
                    PMob->m_AllowRespawn = false;
                }
            }
        }
        break;
        case TIME_DAWN:
        {
            ScriptType = SCRIPT_TIME_DAWN;

            for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
            {
                CMobEntity* PMob = (CMobEntity*)it->second;

                if (PMob->m_SpawnType & SPAWNTYPE_ATEVENING)
                {
                    PMob->SetDespawnTime(1ms);
                    PMob->m_AllowRespawn = false;
                }
            }
        }
        break;
        case TIME_DAY:
        {
            ScriptType = SCRIPT_TIME_DAY;
        }
        break;
        case TIME_DUSK:
        {
            ScriptType = SCRIPT_TIME_DUSK;
        }
        break;
        case TIME_EVENING:
        {
            ScriptType = SCRIPT_TIME_EVENING;

            for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
            {
                CMobEntity* PMob = (CMobEntity*)it->second;

                if (PMob->m_SpawnType & SPAWNTYPE_ATEVENING)
                {
                    PMob->SetDespawnTime(0s);
                    PMob->m_AllowRespawn = true;
                    PMob->Spawn();
                }
            }
        }
        break;
        case TIME_NIGHT:
        {
            for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
            {
                CMobEntity* PMob = (CMobEntity*)it->second;

                if (PMob->m_SpawnType & SPAWNTYPE_ATNIGHT)
                {
                    PMob->SetDespawnTime(0s);
                    PMob->m_AllowRespawn = true;
                    PMob->Spawn();
                }
            }
        }
        break;
        default:
            break;
    }
    if (ScriptType != SCRIPT_NONE)
    {
        for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
        {
            charutils::CheckEquipLogic((CCharEntity*)it->second, ScriptType, TOTD);
        }
    }
}

void CZoneEntities::SavePlayTime()
{
    if (!m_charList.empty())
    {
        for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
        {
            CCharEntity* PChar = (CCharEntity*)it->second;
            charutils::SavePlayTime(PChar);
        }
    }
}

CCharEntity* CZoneEntities::GetCharByName(int8* name)
{
    if (!m_charList.empty())
    {
        for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
        {
            CCharEntity* PCurrentChar = (CCharEntity*)it->second;
            if (stricmp((char*)PCurrentChar->GetName(), (const char*)name) == 0)
            {
                return PCurrentChar;
            }
        }
    }
    return nullptr;
}

CCharEntity* CZoneEntities::GetCharByID(uint32 id)
{
    for (auto PChar : m_charList)
    {
        if (PChar.second->id == id)
        {
            return (CCharEntity*)PChar.second;
        }
    }
    return nullptr;
}

void CZoneEntities::PushPacket(CBaseEntity* PEntity, GLOBAL_MESSAGE_TYPE message_type, CBasicPacket* packet)
{
    TracyZoneScoped;
    TracyZoneHex16(packet->id());

    if (!packet) { return; }
    // Do not send packets that are updates of a hidden GM..
    if (packet->id() == 0x00D && PEntity != nullptr && PEntity->objtype == TYPE_PC && ((CCharEntity*)PEntity)->m_isGMHidden)
    {
        // Ensure this packet is not despawning us..
        if (packet->ref<uint8>(0x0A) != 0x20)
        {
            delete packet;
            return;
        }
    }

    if (!m_charList.empty())
    {
        switch (message_type)
        {
            case CHAR_INRANGE_SELF:
            {
                TracyZoneCString("CHAR_INRANGE_SELF");
                if (PEntity->objtype == TYPE_PC)
                {
                    ((CCharEntity*)PEntity)->pushPacket(new CBasicPacket(*packet));
                }
            }
            case CHAR_INRANGE:
            {
                TracyZoneCString("CHAR_INRANGE");
                // todo: rewrite packet handlers and use enums instead of rawdog packet ids
                // 30 yalms if action packet, 50 otherwise
                const int checkDistanceSq = packet->id() == 0x0028 ? 900 : 2500;

                for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
                {
                    CCharEntity* PCurrentChar = (CCharEntity*)it->second;
                    if (PEntity != PCurrentChar)
                    {
                        if (distanceSquared(PEntity->loc.p, PCurrentChar->loc.p) < checkDistanceSq &&
                            ((PEntity->objtype != TYPE_PC) || (((CCharEntity*)PEntity)->m_moghouseID == PCurrentChar->m_moghouseID)))
                        {
                            if (packet->id() == 0x00E &&
                                (packet->ref<uint8>(0x0A) != 0x20 || packet->ref<uint8>(0x0A) != 0x0F))
                            {
                                uint32 id = packet->ref<uint32>(0x04);
                                uint16 targid = packet->ref<uint16>(0x08);

                                CBaseEntity* entity = GetEntity(targid);

                                SpawnIDList_t spawnlist;

                                if (entity)
                                {
                                    if (entity->targid < 0x400)
                                    {
                                        if (entity->objtype == TYPE_MOB)
                                        {
                                            spawnlist = PCurrentChar->SpawnMOBList;
                                        }
                                        else if (entity->objtype == TYPE_NPC)
                                        {
                                            spawnlist = PCurrentChar->SpawnNPCList;
                                        }
                                    }
                                    else if (entity->targid < 0x780)
                                    {
                                        spawnlist = PCurrentChar->SpawnPETList;
                                    }
                                    else if (entity->targid < 0x800)
                                    {
                                        spawnlist = PCurrentChar->SpawnTRUSTList;
                                    }
                                    else
                                    {
                                        entity = nullptr;
                                    }
                                }
                                if (!entity)
                                {
                                    // got a char or nothing as the target of this entity update (which really shouldn't happen ever)
                                    // so we're just going to skip this packet
                                    break;
                                }
                                SpawnIDList_t::iterator iter = spawnlist.lower_bound(id);

                                if (!(iter == spawnlist.end() ||
                                    spawnlist.key_comp()(id, iter->first)))
                                {
                                    PCurrentChar->pushPacket(new CBasicPacket(*packet));
                                }
                            }
                            else
                            {
                                PCurrentChar->pushPacket(new CBasicPacket(*packet));
                            }
                        }
                    }
                }
            }
            break;
            case CHAR_INSHOUT:
            {
                TracyZoneCString("CHAR_INSHOUT");
                for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
                {
                    CCharEntity* PCurrentChar = (CCharEntity*)it->second;
                    if (PEntity != PCurrentChar)
                    {
                        if (distance(PEntity->loc.p, PCurrentChar->loc.p) < 180 &&
                            ((PEntity->objtype != TYPE_PC) || (((CCharEntity*)PEntity)->m_moghouseID == PCurrentChar->m_moghouseID)))
                        {
                            PCurrentChar->pushPacket(new CBasicPacket(*packet));
                        }
                    }
                }
            }
            break;
            case CHAR_INZONE:
            {
                TracyZoneCString("CHAR_INZONE");
                for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
                {
                    CCharEntity* PCurrentChar = (CCharEntity*)it->second;

                    if (PCurrentChar->m_moghouseID == 0)
                    {
                        if (PEntity != PCurrentChar)
                        {
                            PCurrentChar->pushPacket(new CBasicPacket(*packet));
                        }
                    }
                }
            }
            break;
        }
    }
    delete packet;
}

void CZoneEntities::WideScan(CCharEntity* PChar, uint16 radius)
{
    TracyZoneScoped;
    PChar->pushPacket(new CWideScanPacket(WIDESCAN_BEGIN));
    for (EntityList_t::const_iterator it = m_npcList.begin(); it != m_npcList.end(); ++it)
    {
        CNpcEntity* PNpc = (CNpcEntity*)it->second;
        if (PNpc->isWideScannable() && distance(PChar->loc.p, PNpc->loc.p) < radius)
        {
            PChar->pushPacket(new CWideScanPacket(PChar, PNpc));
        }
    }
    for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
    {
        CMobEntity* PMob = (CMobEntity*)it->second;
        if (PMob->isWideScannable() && distance(PChar->loc.p, PMob->loc.p) < radius)
        {
            PChar->pushPacket(new CWideScanPacket(PChar, PMob));
        }
    }
    PChar->pushPacket(new CWideScanPacket(WIDESCAN_END));
}

void CZoneEntities::ZoneServer(time_point tick, bool check_regions)
{
    TracyZoneScoped;
    TracyZoneIString(m_zone->GetName());

    for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
    {
        CMobEntity* PMob = (CMobEntity*)it->second;

        if (PMob->PBattlefield && PMob->PBattlefield->CanCleanup())
        {
            continue;
        }

        PMob->PRecastContainer->Check();
        PMob->StatusEffectContainer->CheckEffectsExpiry(tick);
        if(tick > m_EffectCheckTime)
        {
            PMob->StatusEffectContainer->TickRegen(tick);
            PMob->StatusEffectContainer->TickEffects(tick);
        }
        PMob->PAI->Tick(tick);
    }

    for (EntityList_t::const_iterator it = m_npcList.begin(); it != m_npcList.end(); ++it)
    {
        CNpcEntity* PNpc = (CNpcEntity*)it->second;

        PNpc->PAI->Tick(tick);
    }

    EntityList_t::const_iterator pit = m_petList.begin();
    while (pit != m_petList.end())
    {
        CPetEntity* PPet = (CPetEntity*)pit->second;
        PPet->PRecastContainer->Check();
        PPet->StatusEffectContainer->CheckEffectsExpiry(tick);
        if(tick > m_EffectCheckTime)
        {
            PPet->StatusEffectContainer->TickRegen(tick);
            PPet->StatusEffectContainer->TickEffects(tick);
        }
        PPet->PAI->Tick(tick);
        if (PPet->status == STATUS_DISAPPEAR)
        {
            for (auto PMobIt : m_mobList)
            {
                CMobEntity* PCurrentMob = (CMobEntity*)PMobIt.second;
                PCurrentMob->PEnmityContainer->Clear(PPet->id);
            }
            if (PPet->getPetType() != PETTYPE_AUTOMATON || !PPet->PMaster)
            {
                delete pit->second;
            }
            m_petList.erase(pit++);
        }
        else {
            ++pit;
        }
    }

    EntityList_t::const_iterator trustit = m_trustList.begin();
    while (trustit != m_trustList.end())
    {
        if (CTrustEntity* PTrust = dynamic_cast<CTrustEntity*>(trustit->second))
        {
            PTrust->PRecastContainer->Check();
            PTrust->StatusEffectContainer->CheckEffectsExpiry(tick);
            if (tick > m_EffectCheckTime)
            {
                PTrust->StatusEffectContainer->TickRegen(tick);
                PTrust->StatusEffectContainer->TickEffects(tick);
            }
            PTrust->PAI->Tick(tick);
            if (PTrust->status == STATUS_DISAPPEAR)
            {
                for (auto PMobIt : m_mobList)
                {
                    CMobEntity* PCurrentMob = (CMobEntity*)PMobIt.second;
                    PCurrentMob->PEnmityContainer->Clear(PTrust->id);
                }

                for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
                {
                    CCharEntity* PChar = (CCharEntity*)it->second;
                    if (distance(PChar->loc.p, PTrust->loc.p) < 50)
                    {
                        PChar->SpawnTRUSTList.erase(PTrust->id);
                        PChar->ReloadPartyInc();
                    }
                }

                delete trustit->second;
                m_trustList.erase(trustit++);
            }
            else
            {
                ++trustit;
            }
        }
        else
        {
            ++trustit;
        }
    }

    for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
    {
        CCharEntity* PChar = (CCharEntity*)it->second;

        if (PChar->status != STATUS_SHUTDOWN)
        {
            PChar->PRecastContainer->Check();
            PChar->StatusEffectContainer->CheckEffectsExpiry(tick);
            if (tick > m_EffectCheckTime)
            {
                PChar->StatusEffectContainer->TickRegen(tick);
                PChar->StatusEffectContainer->TickEffects(tick);
            }
            PChar->PAI->Tick(tick);
            PChar->PTreasurePool->CheckItems(tick);
            if (check_regions)
            {
                m_zone->CheckRegions(PChar);
            }
        }
    }

    if (tick > m_EffectCheckTime)
    {
        m_EffectCheckTime = m_EffectCheckTime + 3s > tick ? m_EffectCheckTime + 3s : tick + 3s;
    }
}

CZone* CZoneEntities::GetZone()
{
    return m_zone;
}

EntityList_t CZoneEntities::GetCharList()
{
    return m_charList;
}
