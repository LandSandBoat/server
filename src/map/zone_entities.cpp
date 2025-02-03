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

#include "common/utils.h"
#include "enmity_container.h"
#include "latent_effect_container.h"
#include "mob_modifier.h"
#include "party.h"
#include "recast_container.h"
#include "status_effect_container.h"
#include "trade_container.h"
#include "treasure_pool.h"

#include "ai/ai_container.h"
#include "ai/controllers/mob_controller.h"

#include "entities/mobentity.h"
#include "entities/npcentity.h"
#include "entities/trustentity.h"

#include "packets/change_music.h"
#include "packets/char.h"
#include "packets/char_sync.h"
#include "packets/entity_set_name.h"
#include "packets/entity_update.h"
#include "packets/entity_visual.h"
#include "packets/wide_scan.h"

#include "lua/luautils.h"

#include "battlefield.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "utils/moduleutils.h"
#include "utils/petutils.h"
#include "utils/synthutils.h"
#include "utils/zoneutils.h"

#include <unordered_set>

namespace
{
    constexpr auto DYNAMIC_ENTITY_TARGID_RANGE_START      = 0x700;
    constexpr auto ENTITY_RENDER_DISTANCE                 = 50.0f;
    constexpr auto ENTITY_VERTICAL_RENDER_DISTANCE        = 20.0f;
    constexpr auto VERTICAL_RENDER_DISTANCE_OFFSET        = 0.5f;
    constexpr auto CHARACTER_SYNC_DISTANCE                = 45.0f;
    constexpr auto CHARACTER_DESPAWN_DISTANCE             = 50.0f;
    constexpr auto CHARACTER_SWAP_MAX                     = 5U;
    constexpr auto CHARACTER_SYNC_LIMIT_MAX               = 32U;
    constexpr auto CHARACTER_SYNC_DISTANCE_SWAP_THRESHOLD = 30U;
    constexpr auto CHARACTER_SYNC_PARTY_SIGNIFICANCE      = 100000U;
    constexpr auto CHARACTER_SYNC_ALLI_SIGNIFICANCE       = 10000U;
    constexpr auto PERSIST_CHECK_CHARACTERS               = 20U;
    constexpr auto INTERMEDIATE_CONTAINER_RESERVE_SIZE    = 16U;

    inline bool isWithinVerticalDistance(CBaseEntity* source, CBaseEntity* target)
    {
        const float verticalDistance = target->loc.p.y - source->loc.p.y - VERTICAL_RENDER_DISTANCE_OFFSET;
        return std::abs(verticalDistance) <= ENTITY_VERTICAL_RENDER_DISTANCE;
    }
} // namespace

typedef std::pair<float, CCharEntity*> CharScorePair;

CZoneEntities::CZoneEntities(CZone* zone)
: m_zone(zone)
, m_nextDynamicTargID(DYNAMIC_ENTITY_TARGID_RANGE_START)
{
    // Ensure internal collections have enough capacity so they won't resize at runtime.
    m_mobsToDelete.reserve(INTERMEDIATE_CONTAINER_RESERVE_SIZE);
    m_npcsToDelete.reserve(INTERMEDIATE_CONTAINER_RESERVE_SIZE);
    m_petsToDelete.reserve(INTERMEDIATE_CONTAINER_RESERVE_SIZE);
    m_trustsToDelete.reserve(INTERMEDIATE_CONTAINER_RESERVE_SIZE);
    m_aggroableMobs.reserve(INTERMEDIATE_CONTAINER_RESERVE_SIZE);
    m_charsToLogout.reserve(INTERMEDIATE_CONTAINER_RESERVE_SIZE);
    m_charsToWarp.reserve(INTERMEDIATE_CONTAINER_RESERVE_SIZE);
    m_charsToChangeZone.reserve(INTERMEDIATE_CONTAINER_RESERVE_SIZE);
}

CZoneEntities::~CZoneEntities()
{
    for (auto ally : m_allyList)
    {
        destroy(ally.second);
    }

    for (auto mob : m_mobList)
    {
        destroy(mob.second);
    }

    for (auto pet : m_petList)
    {
        destroy(pet.second);
    }

    for (auto trust : m_trustList)
    {
        destroy(trust.second);
    }

    for (auto npc : m_npcList)
    {
        destroy(npc.second);
    }

    for (auto character : m_charList)
    {
        destroy(character.second);
    }

    for (auto transport : m_TransportList)
    {
        destroy(transport.second);
    }
}

void CZoneEntities::HealAllMobs()
{
    TracyZoneScoped;

    FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PCurrentMob, m_mobList)
    {
        // keep resting until i'm full
        PCurrentMob->Rest(1);
    }
}

void CZoneEntities::TryAddToNearbySpawnLists(CBaseEntity* PEntity)
{
    TracyZoneScoped;

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
    {
        const auto isInHeightRange = isWithinVerticalDistance(PEntity, PCurrentChar);
        const auto isInRange       = isWithinDistance(PEntity->loc.p, PCurrentChar->loc.p, ENTITY_RENDER_DISTANCE);

        if (isInHeightRange && isInRange)
        {
            switch (PEntity->objtype)
            {
                case TYPE_PC:
                {
                    auto* PChar = static_cast<CCharEntity*>(PEntity);
                    if (PChar->m_moghouseID != PCurrentChar->m_moghouseID)
                    {
                        continue;
                    }

                    PCurrentChar->SpawnPCList[PEntity->id] = PEntity;
                    PCurrentChar->updateCharPacket(PChar, ENTITY_SPAWN, UPDATE_ALL_CHAR);
                    break;
                }
                case TYPE_NPC:
                {
                    PCurrentChar->SpawnNPCList[PEntity->id] = PEntity;
                    PCurrentChar->updateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
                    break;
                }
                case TYPE_MOB:
                {
                    PCurrentChar->SpawnMOBList[PEntity->id] = PEntity;
                    PCurrentChar->updateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
                    break;
                }
                case TYPE_PET:
                {
                    PCurrentChar->SpawnPETList[PEntity->id] = PEntity;
                    PCurrentChar->updateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
                    break;
                }
                case TYPE_TRUST:
                {
                    PCurrentChar->SpawnTRUSTList[PEntity->id] = PEntity;
                    PCurrentChar->updateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
                    break;
                }
                // case TYPE_FELLOW:
                // {
                //     PCurrentChar->SpawnFellowList[PEntity->id] = PEntity;
                //     PCurrentChar->updateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
                //     break;
                // }
                default:
                    return;
                    break;
            }
        }
    }
}

void CZoneEntities::InsertPC(CCharEntity* PChar)
{
    TracyZoneScoped;

    PChar->loc.zone = m_zone;
    m_charTargIds.insert(PChar->targid);
    m_charList[PChar->targid] = PChar;

    TryAddToNearbySpawnLists(PChar);

    ShowDebug("CZone:: %s IncreaseZoneCounter <%u> %s", m_zone->getName(), m_charList.size(), PChar->getName());
}

void CZoneEntities::InsertAlly(CBaseEntity* PMob)
{
    TracyZoneScoped;

    if (PMob != nullptr && PMob->objtype == TYPE_MOB)
    {
        PMob->loc.zone           = m_zone;
        m_allyList[PMob->targid] = PMob;

        TryAddToNearbySpawnLists(PMob);
    }
}

void CZoneEntities::InsertMOB(CBaseEntity* PMob)
{
    TracyZoneScoped;

    if (PMob != nullptr && PMob->objtype == TYPE_MOB)
    {
        PMob->loc.zone = m_zone;

        FindPartyForMob(PMob);
        m_mobList[PMob->targid] = PMob;

        TryAddToNearbySpawnLists(PMob);
    }
}

void CZoneEntities::InsertNPC(CBaseEntity* PNpc)
{
    TracyZoneScoped;

    if (PNpc != nullptr && PNpc->objtype == TYPE_NPC)
    {
        PNpc->loc.zone = m_zone;

        if (PNpc->look.size == MODEL_SHIP)
        {
            if (m_TransportList.contains(PNpc->targid))
            {
                ShowError("Error: Inserting Transport NPC with duplicate ID!");
            }

            m_TransportList[PNpc->targid] = PNpc;
        }
        else
        {
            if (m_npcList.contains(PNpc->targid))
            {
                ShowError("Error: Inserting NPC with duplicate ID!");
            }

            m_npcList[PNpc->targid] = PNpc;
        }

        TryAddToNearbySpawnLists(PNpc);
    }
}

void CZoneEntities::InsertPET(CBaseEntity* PPet)
{
    TracyZoneScoped;

    if (PPet != nullptr)
    {
        m_zone->GetZoneEntities()->AssignDynamicTargIDandLongID(PPet);

        m_petList[PPet->targid] = PPet;

        TryAddToNearbySpawnLists(PPet);

        PPet->spawnAnimation = SPAWN_ANIMATION::NORMAL; // Turn off special spawn animation

        return;
    }
    ShowError("CZone::InsertPET : entity is null");
}

void CZoneEntities::InsertTRUST(CBaseEntity* PTrust)
{
    TracyZoneScoped;

    if (PTrust != nullptr)
    {
        m_zone->GetZoneEntities()->AssignDynamicTargIDandLongID(PTrust);
        m_trustList[PTrust->targid] = PTrust;

        TryAddToNearbySpawnLists(PTrust);

        PTrust->spawnAnimation = SPAWN_ANIMATION::NORMAL; // Turn off special spawn animation

        return;
    }
}

void CZoneEntities::FindPartyForMob(CBaseEntity* PEntity)
{
    TracyZoneScoped;

    if (PEntity == nullptr)
    {
        ShowWarning("PEntity was null.");
        return;
    }

    if (PEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Non-MOB was passed into function (%s).", PEntity->getName());
        return;
    }

    CMobEntity* PMob = static_cast<CMobEntity*>(PEntity);

    // force all mobs in a burning circle to link
    ZONE_TYPE zonetype  = m_zone->GetTypeMask();
    bool      forceLink = zonetype & ZONE_TYPE::DYNAMIS || PMob->getMobMod(MOBMOD_SUPERLINK);

    if ((forceLink || PMob->m_Link || PMob->m_Type & MOBTYPE_BATTLEFIELD) && PMob->PParty == nullptr)
    {
        FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PCurrentMob, m_mobList)
        {
            if (!forceLink && !PCurrentMob->m_Link)
            {
                continue;
            }

            int16 sublink = PMob->getMobMod(MOBMOD_SUBLINK);

            if (PCurrentMob->allegiance == PMob->allegiance &&
                (forceLink || PCurrentMob->m_Family == PMob->m_Family || (sublink && sublink == PCurrentMob->getMobMod(MOBMOD_SUBLINK))))
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
    TracyZoneScoped;

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
    {
        if (PCurrentChar->loc.boundary == boundary)
        {
            if (PCurrentChar->eventPreparation->targetEntity != nullptr)
            {
                // The player talked to one of the guys on the boat, and the event target is wrong.
                // This leads to the wrong script being loaded and you get stuck on a black screen
                // instead of loading into the port.

                // Attempt to load the proper script
                PCurrentChar->eventPreparation->targetEntity = nullptr;
                size_t deleteStart                           = PCurrentChar->eventPreparation->scriptFile.find("npcs/");
                size_t deleteEnd                             = PCurrentChar->eventPreparation->scriptFile.find(".lua");

                if (deleteStart != std::string::npos && deleteEnd != std::string::npos)
                {
                    PCurrentChar->eventPreparation->scriptFile.replace(deleteStart, deleteEnd - deleteStart, "Zone");
                }
            }

            luautils::OnTransportEvent(PCurrentChar, zone);
        }
    }
}

void CZoneEntities::WeatherChange(WEATHER weather)
{
    TracyZoneScoped;

    const auto element = zoneutils::GetWeatherElement(weather);

    FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PCurrentMob, m_mobList)
    {
        PCurrentMob->PAI->EventHandler.triggerListener("WEATHER_CHANGE", CLuaBaseEntity(PCurrentMob), static_cast<int>(weather), element);

        // can't detect by scent in this weather
        if (PCurrentMob->getMobMod(MOBMOD_DETECTION) & DETECT_SCENT)
        {
            PCurrentMob->m_disableScent = (weather == WEATHER_RAIN || weather == WEATHER_SQUALL || weather == WEATHER_BLIZZARDS);
        }

        if (PCurrentMob->m_EcoSystem == ECOSYSTEM::ELEMENTAL && PCurrentMob->PMaster == nullptr && PCurrentMob->m_SpawnType & SPAWNTYPE_WEATHER)
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

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
    {
        PCurrentChar->PLatentEffectContainer->CheckLatentsWeather(weather);
        PCurrentChar->PAI->EventHandler.triggerListener("WEATHER_CHANGE", CLuaBaseEntity(PCurrentChar), static_cast<int>(weather), element);
    }
}

void CZoneEntities::MusicChange(uint16 BlockID, uint16 MusicTrackID)
{
    TracyZoneScoped;

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PChar, m_charList)
    {
        PChar->pushPacket<CChangeMusicPacket>(BlockID, MusicTrackID);
    }
}

void CZoneEntities::DecreaseZoneCounter(CCharEntity* PChar)
{
    TracyZoneScoped;

    if (PChar == nullptr)
    {
        ShowWarning("PChar is null.");
        return;
    }

    if (PChar->loc.zone != m_zone)
    {
        ShowWarning("Zone mismatch for %s.", PChar->getName());
        return;
    }

    battleutils::RelinquishClaim(PChar);

    // Remove pets
    if (PChar->PPet != nullptr)
    {
        auto* PPet = static_cast<CPetEntity*>(PChar->PPet);

        charutils::BuildingCharPetAbilityTable(PChar, PPet, 0); // blank the pet commands

        if (PChar->PPet->isCharmed)
        {
            petutils::DespawnPet(PChar);
        }
        else
        {
            PChar->PPet->status = STATUS_TYPE::DISAPPEAR;
            if (static_cast<CPetEntity*>(PChar->PPet)->getPetType() == PET_TYPE::AVATAR)
            {
                PChar->setModifier(Mod::AVATAR_PERPETUATION, 0);
            }
        }

        // It may have been nullptred by DespawnPet
        if (PChar->PPet != nullptr)
        {
            PChar->PPet->PAI->Disengage();

            FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
            {
                // inform other players of the pets removal
                SpawnIDList_t::iterator itr = PCurrentChar->SpawnPETList.find(PChar->PPet->id);

                if (itr != PCurrentChar->SpawnPETList.end())
                {
                    PCurrentChar->SpawnPETList.erase(itr);
                    PCurrentChar->updateEntityPacket(PChar->PPet, ENTITY_DESPAWN, UPDATE_NONE);
                }
            }

            PChar->PPet = nullptr;
        }
    }

    // Remove trusts
    for (const auto& PTrust : PChar->PTrusts)
    {
        FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
        {
            // inform other players of the trusts removal
            PCurrentChar->updateEntityPacket(PTrust, ENTITY_DESPAWN, UPDATE_NONE);
        }
    }
    PChar->ClearTrusts();
    PChar->SpawnTRUSTList.clear();

    if (m_zone->m_BattlefieldHandler)
    {
        m_zone->m_BattlefieldHandler->RemoveFromBattlefield(PChar, PChar->PBattlefield, BATTLEFIELD_LEAVE_CODE_WARPDC);
    }

    FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PCurrentMob, m_mobList)
    {
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

    // Duplicated from charUtils, it is theoretically possible through d/c magic to hit this block and not sendToZone
    if (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() > 0)
    {
        charutils::forceSynthCritFail("DecreaseZoneCounter", PChar);
    }

    if (PChar->animation == ANIMATION_SYNTH)
    {
        PChar->CraftContainer->setQuantity(0, synthutils::SYNTHESIS_FAIL);
        synthutils::sendSynthDone(PChar);
    }

    // Need to interupt fishing on zone out otherwise fished up mobs get stuck in hooked state
    if (PChar->hookedFish && PChar->hookedFish->hooked)
    {
        fishingutils::InterruptFishing(PChar);
    }

    m_charList.erase(PChar->targid);
    m_charTargIds.erase(PChar->targid);

    ShowDebug("CZone:: %s DecreaseZoneCounter <%u> %s", m_zone->getName(), m_charList.size(), PChar->getName());
}

uint16 CZoneEntities::GetNewCharTargID()
{
    // NOTE: 0x0D (char_update) entity updates are valid for 1024 to 1791
    uint16 targid = 0x400;
    for (auto it : m_charTargIds)
    {
        if (targid != it)
        {
            break;
        }
        ++targid;
    }
    if (targid >= 0x700)
    {
        ShowError("targid is high (03hX), update packets will be ignored!", targid);
    }
    return targid;
}

// Handles the generation and/or assignment of:
// - Index (targid)
// - Current Zone
// - Global ID (id)
// - Insertion into the zone's dynamicTargIds list
void CZoneEntities::AssignDynamicTargIDandLongID(CBaseEntity* PEntity)
{
    // NOTE: 0x0E (entity_update) entity updates are valid for 0 to 1023 and 1792 to 2303
    // Step targid up linearly from 0x700 one by one to 0x8FF unless that ID is already occupied.
    uint16 targid = m_nextDynamicTargID;

    // Wrap around 0x8FF to 0x700
    if (targid > 0x8FF)
    {
        targid = 0x700;
    }

    uint16 counter = 0;

    // Find next available targid, starting with the computed one above.
    while (std::find(m_dynamicTargIds.begin(), m_dynamicTargIds.end(), targid) != m_dynamicTargIds.end())
    {
        ++targid;

        // Wrap around 0x8FF to 0x700
        if (targid > 0x8FF)
        {
            targid = 0x700;
        }

        if (counter > 0x1FF)
        {
            ShowCriticalFmt("dynamicTargIds list full in zone {}!", m_zone->getName());
            targid = 0x900;
            break;
        }
        ++counter;
    }

    // We found our targid, the next dynamic entity will want to start searching at +1 of this.
    m_nextDynamicTargID = targid + 1;

    auto id = 0x01000000 | (m_zone->GetID() << 0x0C) | (targid + 0x0100);

    m_dynamicTargIds.insert(targid);

    PEntity->targid   = targid;
    PEntity->id       = id;
    PEntity->loc.zone = m_zone;

    // NOTE: If the targid is too high, things start to break
    if (targid >= 0x900)
    {
        ShowError("targid is high (03hX), update packets will be ignored!", targid);
    }
}

void CZoneEntities::EraseStaleDynamicTargIDs()
{
    for (auto it = m_dynamicTargIdsToDelete.begin(); it != m_dynamicTargIdsToDelete.end();)
    {
        // Erase dynamic targid if it's stale enough
        if ((server_clock::now() - it->second) > 60s)
        {
            m_dynamicTargIds.erase(it->first);
            it = m_dynamicTargIdsToDelete.erase(it);
        }
        else
        {
            ++it;
        }
    }
}

// The range for dynamic targids is [0x700, 0x900), so a possible 0x1FF (511) entities can be in the zone at once.
auto CZoneEntities::GetUsedDynamicTargIDsCount() const -> std::size_t
{
    return m_dynamicTargIds.size();
}

bool CZoneEntities::CharListEmpty() const
{
    return m_charList.empty();
}

void CZoneEntities::ForEachChar(std::function<void(CCharEntity*)> const& func)
{
    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PChar, m_charList)
    {
        func(PChar);
    }
}

void CZoneEntities::ForEachMob(std::function<void(CMobEntity*)> const& func)
{
    FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PMob, m_mobList)
    {
        func(PMob);
    }
}

void CZoneEntities::ForEachNpc(std::function<void(CNpcEntity*)> const& func)
{
    FOR_EACH_PAIR_CAST_SECOND(CNpcEntity*, PNpc, m_npcList)
    {
        func(PNpc);
    }
}

void CZoneEntities::ForEachTrust(std::function<void(CTrustEntity*)> const& func)
{
    FOR_EACH_PAIR_CAST_SECOND(CTrustEntity*, PTrust, m_trustList)
    {
        func(PTrust);
    }
}

void CZoneEntities::ForEachPet(std::function<void(CPetEntity*)> const& func)
{
    FOR_EACH_PAIR_CAST_SECOND(CPetEntity*, PPet, m_petList)
    {
        func(PPet);
    }
}

void CZoneEntities::ForEachAlly(std::function<void(CMobEntity*)> const& func)
{
    FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PAlly, m_allyList)
    {
        func(PAlly);
    }
}

void CZoneEntities::DespawnPC(CCharEntity* PChar)
{
    TracyZoneScoped;

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
    {
        const auto itr           = PCurrentChar->SpawnPCList.find(PChar->id);
        const auto isInSpawnList = itr != PCurrentChar->SpawnPCList.end();

        if (isInSpawnList)
        {
            PCurrentChar->SpawnPCList.erase(itr);
            PCurrentChar->updateCharPacket(PChar, ENTITY_DESPAWN, UPDATE_NONE);
        }
    }
}

void CZoneEntities::SpawnMOBs(CCharEntity* PChar)
{
    TracyZoneScoped;

    FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PCurrentMob, m_mobList)
    {
        auto& spawnList = PChar->SpawnMOBList;

        const auto id              = PCurrentMob->id;
        const auto itr             = spawnList.find(id);
        const auto isInSpawnList   = itr != spawnList.end();
        const auto isInHeightRange = isWithinVerticalDistance(PChar, PCurrentMob);
        const auto isInRange       = isWithinDistance(PChar->loc.p, PCurrentMob->loc.p, ENTITY_RENDER_DISTANCE);
        const auto isVisibleStatus = PCurrentMob->status != STATUS_TYPE::DISAPPEAR;

        const auto tryAddToSpawnList = [&]()
        {
            if (!isInSpawnList)
            {
                spawnList.insert(itr, SpawnIDList_t::value_type(id, PCurrentMob));
                PChar->updateEntityPacket(PCurrentMob, ENTITY_SPAWN, UPDATE_ALL_MOB);
            }
        };

        const auto tryRemoveFromSpawnList = [&]()
        {
            if (isInSpawnList)
            {
                spawnList.erase(itr);
                PChar->updateEntityPacket(PCurrentMob, ENTITY_DESPAWN, UPDATE_NONE);
            }
        };

        const auto tapAggro = [&]()
        {
            // Check to skip aggro routine
            if (PChar->isDead() || PChar->visibleGmLevel >= 3 || PCurrentMob->PMaster)
            {
                return;
            }

            // checking monsters night/daytime sleep is already taken into account in the CurrentAction check, because monsters don't move in their sleep
            const EMobDifficulty mobCheck = charutils::CheckMob(PChar->GetMLevel(), PCurrentMob->GetMLevel());

            CMobController* PController = static_cast<CMobController*>(PCurrentMob->PAI->GetController());

            // Check if this mob follows targets and if so then it should not aggro
            if (PCurrentMob->m_roamFlags & ROAMFLAG_FOLLOW)
            {
                if (PController->CanFollowTarget(PChar))
                {
                    PController->SetFollowTarget(PChar, FollowType::Roam);
                }
                return;
            }

            bool validAggro = mobCheck > EMobDifficulty::TooWeak || PChar->isSitting() || PCurrentMob->getMobMod(MOBMOD_ALWAYS_AGGRO);
            if (validAggro && PController->CanAggroTarget(PChar))
            {
                PCurrentMob->PAI->Engage(PChar->targid);
            }
        };

        // Is this mob "visible" to the player?
        if (isVisibleStatus && isInHeightRange && isInRange)
        {
            tryAddToSpawnList();

            // TODO: Can/should this aggro routine be moved out of here and into the entity's first tick/spawn?
            tapAggro();
        }
        else
        {
            tryRemoveFromSpawnList();
        }
    }
}

void CZoneEntities::SpawnPETs(CCharEntity* PChar)
{
    TracyZoneScoped;

    // TODO: Rather than iterating every entity in the zone, we should be doing
    //     : spatial partitioning to only check entities within a certain range of the player.
    //     : This would change this loop to look like:
    //     : Compare previous and current spatial partitioning results to determine which entities to add/remove from the spawn list.
    for (const auto& [_, PCurrentEntity] : m_petList)
    {
        auto& spawnList = PChar->SpawnPETList;

        const auto id              = PCurrentEntity->id;
        const auto itr             = spawnList.find(id);
        const auto isInSpawnList   = itr != spawnList.end();
        const auto isInHeightRange = isWithinVerticalDistance(PChar, PCurrentEntity);
        const auto isInRange       = isWithinDistance(PChar->loc.p, PCurrentEntity->loc.p, ENTITY_RENDER_DISTANCE);
        const auto isVisibleStatus = PCurrentEntity->status == STATUS_TYPE::NORMAL || PCurrentEntity->status == STATUS_TYPE::UPDATE;

        const auto tryAddToSpawnList = [&]()
        {
            if (!isInSpawnList)
            {
                spawnList.insert(itr, SpawnIDList_t::value_type(id, PCurrentEntity));
                PChar->updateEntityPacket(PCurrentEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
            }
        };

        const auto tryRemoveFromSpawnList = [&]()
        {
            if (isInSpawnList)
            {
                spawnList.erase(itr);
                PChar->updateEntityPacket(PCurrentEntity, ENTITY_DESPAWN, UPDATE_NONE);
            }
        };

        if (isVisibleStatus && isInHeightRange && isInRange)
        {
            tryAddToSpawnList();
        }
        else
        {
            tryRemoveFromSpawnList();
        }
    }
}

void CZoneEntities::SpawnNPCs(CCharEntity* PChar)
{
    TracyZoneScoped;

    if (PChar->m_moghouseID)
    {
        return;
    }

    // TODO: Rather than iterating every entity in the zone, we should be doing
    //     : spatial partitioning to only check entities within a certain range of the player.
    //     : This would change this loop to look like:
    //     : Compare previous and current spatial partitioning results to determine which entities to add/remove from the spawn list.
    for (const auto& [_, PCurrentEntity] : m_npcList)
    {
        auto& spawnList = PChar->SpawnNPCList;

        const auto id              = PCurrentEntity->id;
        const auto itr             = spawnList.find(id);
        const auto isInSpawnList   = itr != spawnList.end();
        const auto isInHeightRange = isWithinVerticalDistance(PChar, PCurrentEntity);
        const auto isInRange       = isWithinDistance(PChar->loc.p, PCurrentEntity->loc.p, ENTITY_RENDER_DISTANCE);
        const auto isVisibleStatus = PCurrentEntity->status == STATUS_TYPE::NORMAL || PCurrentEntity->status == STATUS_TYPE::UPDATE;

        const auto tryAddToSpawnList = [&]()
        {
            if (!isInSpawnList)
            {
                spawnList.insert(itr, SpawnIDList_t::value_type(id, PCurrentEntity));
                PChar->updateEntityPacket(PCurrentEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
            }
        };

        const auto tryRemoveFromSpawnList = [&]()
        {
            if (isInSpawnList)
            {
                spawnList.erase(itr);
                PChar->updateEntityPacket(PCurrentEntity, ENTITY_DESPAWN, UPDATE_NONE);
            }
        };

        if (isVisibleStatus && isInHeightRange && isInRange)
        {
            tryAddToSpawnList();
        }
        else
        {
            tryRemoveFromSpawnList();
        }
    }
}

void CZoneEntities::SpawnTRUSTs(CCharEntity* PChar)
{
    TracyZoneScoped;

    // TODO: Rather than iterating every entity in the zone, we should be doing
    //     : spatial partitioning to only check entities within a certain range of the player.
    //     : This would change this loop to look like:
    //     : Compare previous and current spatial partitioning results to determine which entities to add/remove from the spawn list.
    for (const auto& [_, PCurrentEntity] : m_trustList)
    {
        auto& spawnList = PChar->SpawnTRUSTList;

        const auto id              = PCurrentEntity->id;
        const auto itr             = spawnList.find(id);
        const auto isInSpawnList   = itr != spawnList.end();
        const auto isInHeightRange = isWithinVerticalDistance(PChar, PCurrentEntity);
        const auto isInRange       = isWithinDistance(PChar->loc.p, PCurrentEntity->loc.p, ENTITY_RENDER_DISTANCE);
        const auto isVisibleStatus = PCurrentEntity->status == STATUS_TYPE::NORMAL || PCurrentEntity->status == STATUS_TYPE::UPDATE;

        const auto tryAddToSpawnList = [&]()
        {
            if (!isInSpawnList)
            {
                spawnList.insert(itr, SpawnIDList_t::value_type(id, PCurrentEntity));
                PChar->updateEntityPacket(PCurrentEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
            }
        };

        const auto tryRemoveFromSpawnList = [&]()
        {
            if (isInSpawnList)
            {
                spawnList.erase(itr);
                PChar->updateEntityPacket(PCurrentEntity, ENTITY_DESPAWN, UPDATE_NONE);
            }
        };

        if (isVisibleStatus && isInHeightRange && isInRange)
        {
            tryAddToSpawnList();
        }
        else
        {
            tryRemoveFromSpawnList();
        }
    }
}

float getSignificanceScore(CCharEntity* originChar, CCharEntity* targetChar)
{
    if (targetChar->m_GMlevel > 0 && !targetChar->m_isGMHidden)
    {
        return CHARACTER_SYNC_ALLI_SIGNIFICANCE;
    }

    if (originChar->PParty && targetChar->PParty)
    {
        if (originChar->PParty->GetPartyID() == targetChar->PParty->GetPartyID())
        {
            // Same party
            return CHARACTER_SYNC_PARTY_SIGNIFICANCE;
        }
        else if (originChar->PParty->m_PAlliance && targetChar->PParty->m_PAlliance && originChar->PParty->m_PAlliance->m_AllianceID == targetChar->PParty->m_PAlliance->m_AllianceID)
        {
            // Same alliance
            return CHARACTER_SYNC_ALLI_SIGNIFICANCE;
        }
    }

    return 0;
}

void CZoneEntities::SpawnPCs(CCharEntity* PChar)
{
    TracyZoneScoped;

    // TODO: This is a temporary fix so that Feretory and Mog Garden _seem_ like a solo zones.
    if (PChar->loc.zone->GetID() == ZONE_FERETORY || PChar->loc.zone->GetID() == ZONE_MOG_GARDEN)
    {
        return;
    }

    // Provide bonus score to characters targeted by spawned mobs or other conflict players, if in conflict
    std::unordered_map<uint32, float> scoreBonus = std::unordered_map<uint32, float>();

    FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PMob, PChar->SpawnMOBList)
    {
        CState* PState = PMob->PAI->GetCurrentState();
        if (!PState)
        {
            continue;
        }

        CBaseEntity* PTarget = PState->GetTarget();
        if (PTarget && PTarget->objtype == TYPE_PC && PTarget->id != PChar->id)
        {
            scoreBonus[PTarget->id] += CHARACTER_SYNC_DISTANCE_SWAP_THRESHOLD;
        }
    }

    // Loop through all chars in zone and find candidate characters to spawn, and scores of already spawned characters
    MinHeap<CharScorePair>    spawnedCharacters;
    std::vector<CCharEntity*> toRemove;

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, PChar->SpawnPCList)
    {
        // Despawn character if it's a hidden GM, is in a different mog house, or if player is in a conflict while other is not, or too far up/down
        if (PCurrentChar->m_isGMHidden ||
            PChar->m_moghouseID != PCurrentChar->m_moghouseID ||
            !isWithinVerticalDistance(PChar, PCurrentChar))
        {
            toRemove.emplace_back(PCurrentChar);
            continue;
        }

        // Despawn character if it's currently spawned and is far away
        float charDistance = distance(PChar->loc.p, PCurrentChar->loc.p);
        if (charDistance >= CHARACTER_DESPAWN_DISTANCE)
        {
            toRemove.emplace_back(PCurrentChar);
            continue;
        }

        // Total score is determined by the significance between the characters, adding any bonuses,
        // and then subtracting the distance to make characters further away less important.
        float significanceScore = getSignificanceScore(PChar, PCurrentChar);
        auto  bonusIter         = scoreBonus.find(PCurrentChar->id);
        auto  bonus             = bonusIter == scoreBonus.end() ? 0 : bonusIter->second;
        float totalScore        = significanceScore + bonus - charDistance + CHARACTER_SYNC_DISTANCE_SWAP_THRESHOLD;

        if (significanceScore < CHARACTER_SYNC_ALLI_SIGNIFICANCE)
        {
            // Is spawned and should be considered for removal if necessary
            if (spawnedCharacters.size() < CHARACTER_SYNC_LIMIT_MAX)
            {
                spawnedCharacters.emplace(std::make_pair(totalScore, PCurrentChar));
            }
            else if (!spawnedCharacters.empty() && spawnedCharacters.top().first < totalScore)
            {
                spawnedCharacters.emplace(std::make_pair(totalScore, PCurrentChar));
                spawnedCharacters.pop();
            }
        }
    }

    for (const auto& removeChar : toRemove)
    {
        PChar->updateCharPacket(removeChar, ENTITY_DESPAWN, UPDATE_NONE);
        PChar->SpawnPCList.erase(removeChar->id);
    }

    // Find candidates to spawn
    MinHeap<CharScorePair> candidateCharacters;

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
    {
        if (PCurrentChar != nullptr && PChar != PCurrentChar && PChar->SpawnPCList.find(PCurrentChar->id) == PChar->SpawnPCList.end())
        {
            if (PCurrentChar->m_isGMHidden || PChar->m_moghouseID != PCurrentChar->m_moghouseID)
            {
                continue;
            }

            float charDistance = distance(PChar->loc.p, PCurrentChar->loc.p);
            if (charDistance > CHARACTER_SYNC_DISTANCE)
            {
                continue;
            }

            float significanceScore = getSignificanceScore(PChar, PCurrentChar);

            // Total score is determined by the significance between the characters, adding any bonuses,
            // and then subtracting the distance to make characters further away less important.
            auto  bonusIter  = scoreBonus.find(PCurrentChar->id);
            auto  bonus      = bonusIter == scoreBonus.end() ? 0 : bonusIter->second;
            float totalScore = significanceScore + bonus - charDistance;

            if (PChar->SpawnPCList.size() < CHARACTER_SYNC_LIMIT_MAX ||
                (!spawnedCharacters.empty() && totalScore > spawnedCharacters.top().first))
            {
                // Is nearby and should be considered as a candidate to be spawned
                candidateCharacters.emplace(totalScore, PCurrentChar);
                if (candidateCharacters.size() > CHARACTER_SYNC_LIMIT_MAX)
                {
                    candidateCharacters.pop();
                }
            }
        }
    }

    // Check if any of the candidates can/should be spawned
    if (!candidateCharacters.empty())
    {
        std::vector<CharScorePair> candidates;
        while (!candidateCharacters.empty())
        {
            candidates.emplace_back(candidateCharacters.top());
            candidateCharacters.pop();
        }
        std::reverse(candidates.begin(), candidates.end());

        // Track how many characters have been spawned/despawned this check and limit it to avoid flooding the client
        uint8 swapCount = 0;

        // Loop through candidates to be spawned from best to worst
        for (const auto& [candidateScore, candidateChar] : candidates)
        {
            if (swapCount >= CHARACTER_SWAP_MAX)
            {
                break;
            }

            // If max amount of characters are currently spawned, we need to despawn one before we can spawn a new one
            if (PChar->SpawnPCList.size() >= CHARACTER_SYNC_LIMIT_MAX)
            {
                if (spawnedCharacters.size() == 0)
                {
                    // No spawned characters left that we can swap with
                    break;
                }

                // Check that the candidate score is better than the worst spawned score by a certain threshold,
                // to avoid causing a lot of spawn/despawns all the time as people move around.
                if (candidateScore > spawnedCharacters.top().first)
                {
                    CCharEntity* spawnedChar = spawnedCharacters.top().second;
                    PChar->SpawnPCList.erase(spawnedChar->id);
                    PChar->updateCharPacket(spawnedChar, ENTITY_DESPAWN, UPDATE_NONE);
                    spawnedCharacters.pop();
                    ++swapCount;
                }
                else
                {
                    // Best candidate score did not beat the worst spawned score, so we can break out of spawn loop,
                    // since the rest won't improve on that difference.
                    break;
                }
            }

            // Spawn best candidate character
            PChar->SpawnPCList[candidateChar->id] = candidateChar;
            PChar->updateCharPacket(candidateChar, ENTITY_SPAWN, UPDATE_ALL_CHAR);
            PChar->pushPacket<CCharSyncPacket>(candidateChar);
        }
    }
}

void CZoneEntities::SpawnConditionalNPCs(CCharEntity* PChar)
{
    TracyZoneScoped;

    // Player information
    const bool inMogHouse       = PChar->m_moghouseID > 0;
    const bool inMHinHomeNation = inMogHouse && [&]()
    {
        switch (zoneutils::GetCurrentRegion(PChar->getZone()))
        {
            case REGION_TYPE::SANDORIA:
                return PChar->profile.nation == NATION_SANDORIA;
            case REGION_TYPE::BASTOK:
                return PChar->profile.nation == NATION_BASTOK;
            case REGION_TYPE::WINDURST:
                return PChar->profile.nation == NATION_WINDURST;
            default:
                return false;
        }
    }();
    const bool onMH2F            = PChar->profile.mhflag & 0x40;
    const bool orchestrionPlaced = charutils::isOrchestrionPlaced(PChar);

    // NOTE: We're not changing the NPC's status to NORMAL here, because we don't want them to be visible to all players.
    //     : We're sending updates AS IF they were visible, but only to this current player based on their conditions.
    const auto toggleVisibilityForPlayer = [PChar](CBaseEntity* PEntity, bool visible)
    {
        if (visible)
        {
            PEntity->status = STATUS_TYPE::NORMAL;
        }
        else
        {
            PEntity->status = STATUS_TYPE::DISAPPEAR;
        }

        PChar->updateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
        PEntity->status = STATUS_TYPE::DISAPPEAR;
    };

    for (const auto& [_, PCurrentEntity] : m_npcList)
    {
        // TODO: Come up with a sane way to mark "You only" NPCs

        if (PCurrentEntity->name == "Moogle" && PCurrentEntity->loc.p.z == 1.5 && PCurrentEntity->look.face == 0x52)
        {
            toggleVisibilityForPlayer(PCurrentEntity, inMogHouse && !onMH2F);
            continue;
        }

        if (PCurrentEntity->name == "Symphonic_Curator")
        {
            toggleVisibilityForPlayer(PCurrentEntity, inMHinHomeNation && orchestrionPlaced);
            continue;
        }
    }
}

void CZoneEntities::SpawnTransport(CCharEntity* PChar)
{
    TracyZoneScoped;

    FOR_EACH_PAIR_CAST_SECOND(CNpcEntity*, PEntity, m_TransportList)
    {
        PChar->updateEntityPacket(PEntity, ENTITY_SPAWN, UPDATE_ALL_MOB);
    }
}

CBaseEntity* CZoneEntities::GetEntity(uint16 targid, uint8 filter)
{
    TracyZoneScoped;

    const auto findEntity = [&](const EntityList_t& entityList) -> CBaseEntity*
    {
        const auto it = entityList.find(targid);
        if (it != entityList.end())
        {
            return it->second;
        }
        return nullptr;
    };

    if (targid < 0x400)
    {
        if (filter & TYPE_MOB)
        {
            if (const auto& PEntity = findEntity(m_mobList))
            {
                return PEntity;
            }
        }
        if (filter & TYPE_NPC)
        {
            if (const auto& PEntity = findEntity(m_npcList))
            {
                return PEntity;
            }
        }
        if (filter & TYPE_SHIP)
        {
            if (const auto& PEntity = findEntity(m_TransportList))
            {
                return PEntity;
            }
        }
    }
    else if (targid < 0x700)
    {
        if (filter & TYPE_PC)
        {
            if (const auto& PEntity = findEntity(m_charList))
            {
                return PEntity;
            }
        }
    }
    else if (targid < 0x1000) // 1792 - 4096 are dynamic entities
    {
        if (filter & TYPE_PET)
        {
            if (const auto& PEntity = findEntity(m_petList))
            {
                return PEntity;
            }
        }
        if (filter & TYPE_TRUST)
        {
            if (const auto& PEntity = findEntity(m_trustList))
            {
                return PEntity;
            }
        }
        if (filter & TYPE_NPC)
        {
            if (const auto& PEntity = findEntity(m_npcList))
            {
                return PEntity;
            }
        }
        if (filter & TYPE_MOB)
        {
            if (const auto& PEntity = findEntity(m_mobList))
            {
                return PEntity;
            }
        }
    }
    else
    {
        ShowError("Trying to get entity outside of valid id bounds (%u)", targid);
    }

    return nullptr;
}

void CZoneEntities::TOTDChange(TIMETYPE TOTD)
{
    TracyZoneScoped;

    SCRIPTTYPE ScriptType = SCRIPT_NONE;

    switch (TOTD)
    {
        case TIME_MIDNIGHT:
        {
        }
        break;
        case TIME_NEWDAY:
        {
            FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PMob, m_mobList)
            {
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

            FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PMob, m_mobList)
            {
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

            FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PMob, m_mobList)
            {
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
            FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PMob, m_mobList)
            {
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
        FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PChar, m_charList)
        {
            charutils::CheckEquipLogic(PChar, ScriptType, TOTD);
        }
    }
}

void CZoneEntities::SavePlayTime()
{
    TracyZoneScoped;

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PChar, m_charList)
    {
        charutils::SavePlayTime(PChar);
    }
}

CCharEntity* CZoneEntities::GetCharByName(const std::string& name)
{
    TracyZoneScoped;

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
    {
        if (strcmpi(PCurrentChar->getName().c_str(), name.c_str()) == 0)
        {
            return PCurrentChar;
        }
    }
    return nullptr;
}

CCharEntity* CZoneEntities::GetCharByID(uint32 id)
{
    TracyZoneScoped;

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
    {
        if (PCurrentChar->id == id)
        {
            return PCurrentChar;
        }
    }
    return nullptr;
}

void CZoneEntities::UpdateCharPacket(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask)
{
    TracyZoneScoped;

    // Do not send packets that are updates of a hidden GM
    if (PChar->m_isGMHidden && type != ENTITY_DESPAWN)
    {
        return;
    }

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
    {
        if (PCurrentChar == PChar)
        {
            continue;
        }

        if (type == ENTITY_SPAWN || type == ENTITY_DESPAWN || PCurrentChar->SpawnPCList.find(PChar->id) != PCurrentChar->SpawnPCList.end())
        {
            PCurrentChar->updateCharPacket(PChar, type, updatemask);
        }
    }
}

void CZoneEntities::UpdateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask, bool alwaysInclude)
{
    TracyZoneScoped;

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
    {
        if (alwaysInclude || type == ENTITY_SPAWN || type == ENTITY_DESPAWN || charutils::hasEntitySpawned(PCurrentChar, PEntity))
        {
            PCurrentChar->updateEntityPacket(PEntity, type, updatemask);
        }
    }
}

void CZoneEntities::PushPacket(CBaseEntity* PEntity, GLOBAL_MESSAGE_TYPE message_type, const std::unique_ptr<CBasicPacket>& packet)
{
    TracyZoneScoped;
    TracyZoneHex16(packet->getType());

    if (!packet)
    {
        return;
    }

    // Do not send packets that are updates of a hidden GM..
    if (packet->getType() == 0x00D && PEntity != nullptr && PEntity->objtype == TYPE_PC)
    {
        auto* PChar = static_cast<CCharEntity*>(PEntity);

        // Ensure this packet is not despawning us..
        if (PChar->m_isGMHidden && packet->ref<uint8>(0x0A) != 0x20)
        {
            return;
        }
    }

    if (!m_charList.empty())
    {
        // clang-format off
        switch (message_type)
        {
            case CHAR_INRANGE_SELF: // NOTE!!!: This falls through to CHAR_INRANGE so both self and the local area get the packet
            {
                TracyZoneCString("CHAR_INRANGE_SELF");
                if (auto* PChar = dynamic_cast<CCharEntity*>(PEntity))
                {
                    PChar->pushPacket(packet->copy());
                }
            }
            [[fallthrough]];
            case CHAR_INRANGE:
            {
                TracyZoneCString("CHAR_INRANGE");
                // TODO: rewrite packet handlers and use enums instead of rawdog packet ids
                // 30 yalms if action packet, 50 otherwise
                const int checkDistance = packet->getType() == 0x0028 ? 30 : 50;

                FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
                {
                    if (PEntity != PCurrentChar)
                    {
                        if (isWithinDistance(PEntity->loc.p, PCurrentChar->loc.p, checkDistance) &&
                            (PEntity->objtype != TYPE_PC || static_cast<CCharEntity*>(PEntity)->m_moghouseID == PCurrentChar->m_moghouseID))
                        {
                            uint16 packetType = packet->getType();
                            if
                                ((packetType == 0x00E && // Entity Update
                                (packet->ref<uint8>(0x0A) != 0x20 ||
                                packet->ref<uint8>(0x0A) != 0x0F)) ||
                                packetType == 0x028) // Action packet
                            {
                                uint32 id           = 0;
                                uint16 targid       = 0;
                                CBaseEntity* entity = nullptr;

                                if (packetType == 0x00E) // Entity update
                                {
                                    id     = packet->ref<uint32>(0x04);
                                    targid = packet->ref<uint16>(0x08);
                                    entity = GetEntity(targid);
                                }
                                else if (packetType == 0x028) // Action packet
                                {
                                    id     = packet->ref<uint32>(0x05);
                                    // Try char
                                    entity = GetCharByID(id);

                                    // Try everything else
                                    if (!entity)
                                    {
                                        entity = zoneutils::GetEntity(id);
                                    }
                                }

                                // If everything else failed
                                if (!entity)
                                {
                                    // No target entity in spawnlists found, so we're just going to skip this packet
                                    break;
                                }

                                auto pushPacketIfInSpawnList = [&](CCharEntity* PChar, SpawnIDList_t const& spawnlist)
                                {
                                    auto iter = spawnlist.lower_bound(id);
                                    if (iter != spawnlist.end() && !spawnlist.key_comp()(id, iter->first))
                                    {
                                        PCurrentChar->pushPacket(packet->copy());
                                    }
                                };

                                switch(entity->objtype)
                                {
                                    case TYPE_MOB:
                                        pushPacketIfInSpawnList(PCurrentChar, PCurrentChar->SpawnMOBList);
                                        break;
                                    case TYPE_NPC:
                                        pushPacketIfInSpawnList(PCurrentChar, PCurrentChar->SpawnNPCList);
                                        break;
                                    case TYPE_PET:
                                        pushPacketIfInSpawnList(PCurrentChar, PCurrentChar->SpawnPETList);
                                        break;
                                    case TYPE_TRUST:
                                        pushPacketIfInSpawnList(PCurrentChar, PCurrentChar->SpawnTRUSTList);
                                        break;
                                    case TYPE_PC:
                                        pushPacketIfInSpawnList(PCurrentChar, PCurrentChar->SpawnPCList);
                                        break;
                                    default:
                                        break;
                                }
                            }
                            else
                            {
                                PCurrentChar->pushPacket(packet->copy());
                            }
                        }
                    }
                }
            }
            break;
            case CHAR_INSHOUT:
            {
                TracyZoneCString("CHAR_INSHOUT");
                FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
                {
                    if (PEntity != PCurrentChar)
                    {
                        if (distance(PEntity->loc.p, PCurrentChar->loc.p) < 180.0f &&
                            (PEntity->objtype != TYPE_PC || static_cast<CCharEntity*>(PEntity)->m_moghouseID == PCurrentChar->m_moghouseID))
                        {
                            PCurrentChar->pushPacket(packet->copy());
                        }
                    }
                }
            }
            break;
            case CHAR_INZONE:
            {
                TracyZoneCString("CHAR_INZONE");
                FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PCurrentChar, m_charList)
                {
                    if (PCurrentChar->m_moghouseID == 0)
                    {
                        if (PEntity != PCurrentChar)
                        {
                            PCurrentChar->pushPacket(packet->copy());
                        }
                    }
                }
            }
            break;
        }
        // clang-format on
    }
}

void CZoneEntities::WideScan(CCharEntity* PChar, uint16 radius)
{
    TracyZoneScoped;

    PChar->pushPacket<CWideScanPacket>(WIDESCAN_BEGIN);
    for (const auto& entityList : { m_npcList, m_mobList })
    {
        for (const auto& [_, PEntity] : entityList)
        {
            if (PEntity->isWideScannable() && isWithinDistance(PChar->loc.p, PEntity->loc.p, radius))
            {
                PChar->pushPacket<CWideScanPacket>(PChar, PEntity);
            }
        }
    }
    PChar->pushPacket<CWideScanPacket>(WIDESCAN_END);
}

void CZoneEntities::ZoneServer(time_point tick)
{
    TracyZoneScoped;
    TracyZoneString(m_zone->getName());

    luautils::OnZoneTick(this->m_zone);

    //
    // Mob tick logic
    //

    FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PMob, m_mobList)
    {
        if (!PMob)
        {
            continue;
        }

        ShowTrace(fmt::format("CZoneEntities::ZoneServer: Mob: {} ({})", PMob->getName(), PMob->id).c_str());

        if (PMob->PBattlefield && PMob->PBattlefield->CanCleanup())
        {
            continue;
        }

        PMob->PRecastContainer->Check();
        PMob->StatusEffectContainer->CheckEffectsExpiry(tick);
        if (tick > m_EffectCheckTime)
        {
            PMob->StatusEffectContainer->TickRegen(tick);
            PMob->StatusEffectContainer->TickEffects(tick);
        }

        PMob->PAI->Tick(tick);

        // This is only valid for dynamic entities
        if (PMob->status == STATUS_TYPE::DISAPPEAR && PMob->m_bReleaseTargIDOnDisappear)
        {
            if (PMob->PPet != nullptr)
            {
                PMob->PPet->PMaster = nullptr;
            }

            if (PMob->PMaster != nullptr)
            {
                PMob->PMaster->PPet = nullptr;
            }

            FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, POtherMob, m_mobList)
            {
                POtherMob->PEnmityContainer->Clear(PMob->id);
            }

            if (PMob->PParty)
            {
                PMob->PParty->RemoveMember(PMob);
            }

            FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PChar, m_charList)
            {
                if (PChar->PClaimedMob == PMob)
                {
                    PChar->PClaimedMob = nullptr;
                }

                if (PChar->currentEvent && PChar->currentEvent->targetEntity == PMob)
                {
                    PChar->currentEvent->targetEntity = nullptr;
                }

                if (PChar->SpawnMOBList.find(PMob->id) != PChar->SpawnMOBList.end())
                {
                    PChar->SpawnMOBList.erase(PMob->id);
                }
            }

            m_mobsToDelete.emplace_back(PMob);
            continue;
        }

        if (PMob->allegiance == ALLEGIANCE_TYPE::PLAYER && PMob->m_isAggroable)
        {
            m_aggroableMobs.emplace_back(PMob);
        }
    }

    // Check to see if any aggroable mobs should be aggroed by other mobs
    for (const auto& PMob : m_aggroableMobs)
    {
        FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PCurrentMob, m_mobList)
        {
            const auto isInHeightRange = isWithinVerticalDistance(PMob, PCurrentMob);
            const auto isInRange       = isWithinDistance(PMob->loc.p, PCurrentMob->loc.p, ENTITY_RENDER_DISTANCE);

            if (PCurrentMob != nullptr && PCurrentMob->isAlive() && PMob->allegiance != PCurrentMob->allegiance && isInHeightRange && isInRange)
            {
                CMobController* PController = static_cast<CMobController*>(PCurrentMob->PAI->GetController());
                if (PController != nullptr && PController->CanAggroTarget(PMob))
                {
                    PCurrentMob->PAI->Engage(PMob->targid);
                }
            }
        }
    }

    //
    // NPC tick logic
    //

    FOR_EACH_PAIR_CAST_SECOND(CNpcEntity*, PNpc, m_npcList)
    {
        ShowTrace(fmt::format("CZoneEntities::ZoneServer: NPC: {} ({})", PNpc->getName(), PNpc->id).c_str());

        PNpc->PAI->Tick(tick);

        // This is only valid for dynamic entities
        if (PNpc->status == STATUS_TYPE::DISAPPEAR && PNpc->m_bReleaseTargIDOnDisappear)
        {
            FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PChar, m_charList)
            {
                if (PChar->SpawnNPCList.find(PNpc->id) != PChar->SpawnNPCList.end())
                {
                    PChar->SpawnNPCList.erase(PNpc->id);
                }
            }

            m_npcsToDelete.emplace_back(PNpc);
            continue;
        }
    }

    //
    // Pet tick logic
    //

    FOR_EACH_PAIR_CAST_SECOND(CPetEntity*, PPet, m_petList)
    {
        // TODO: The static_cast in this loop includes Battlefield Allies. Allies shouldn't be handled here in
        //     : this way, but we need to do this to keep allies working (for now).
        ShowTrace(fmt::format("CZoneEntities::ZoneServer: Pet: {} ({})", PPet->getName(), PPet->id).c_str());

        // TODO: Is this still necessary?

        // Pets specifically need to have their AI tick skipped if they're marked for deletion
        // to prevent a number of issues which can result from a pet having a deleted/nullptr'd PMaster
        if (PPet->status == STATUS_TYPE::DISAPPEAR)
        {
            FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PCurrentMob, m_mobList)
            {
                PCurrentMob->PEnmityContainer->Clear(PPet->id);
            }

            m_petsToDelete.emplace_back(PPet);
            continue;
        }

        PPet->PRecastContainer->Check();
        PPet->StatusEffectContainer->CheckEffectsExpiry(tick);
        if (tick > m_EffectCheckTime)
        {
            PPet->StatusEffectContainer->TickRegen(tick);
            PPet->StatusEffectContainer->TickEffects(tick);
        }

        PPet->PAI->Tick(tick);
    }

    //
    // Trust tick logic
    //

    FOR_EACH_PAIR_CAST_SECOND(CTrustEntity*, PTrust, m_trustList)
    {
        ShowTrace(fmt::format("CZoneEntities::ZoneServer: Trust: {} ({})", PTrust->getName(), PTrust->id).c_str());

        PTrust->PRecastContainer->Check();
        PTrust->StatusEffectContainer->CheckEffectsExpiry(tick);
        if (tick > m_EffectCheckTime)
        {
            PTrust->StatusEffectContainer->TickRegen(tick);
            PTrust->StatusEffectContainer->TickEffects(tick);
        }

        PTrust->PAI->Tick(tick);

        if (PTrust->status == STATUS_TYPE::DISAPPEAR)
        {
            FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PCurrentMob, m_mobList)
            {
                PCurrentMob->PEnmityContainer->Clear(PTrust->id);
            }

            FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PChar, m_charList)
            {
                if (distance(PChar->loc.p, PTrust->loc.p) < ENTITY_RENDER_DISTANCE)
                {
                    PChar->SpawnTRUSTList.erase(PTrust->id);
                }
            }

            m_trustsToDelete.emplace_back(PTrust);
            continue;
        }
    }

    //
    // Char tick logic
    //

    FOR_EACH_PAIR_CAST_SECOND(CCharEntity*, PChar, m_charList)
    {
        ShowTrace(fmt::format("CZoneEntities::ZoneServer: Char: {} ({})", PChar->getName(), PChar->id).c_str());

        if (PChar->status != STATUS_TYPE::SHUTDOWN)
        {
            PChar->PRecastContainer->Check();
            PChar->StatusEffectContainer->CheckEffectsExpiry(tick);
            if (tick > m_EffectCheckTime)
            {
                PChar->StatusEffectContainer->TickRegen(tick);
                PChar->StatusEffectContainer->TickEffects(tick);
            }

            PChar->PAI->Tick(tick);

            if (PChar->PTreasurePool)
            {
                PChar->PTreasurePool->CheckItems(tick);
            }
        }

        // Else-if chain so only one end-result can be processed.
        // This is done to prevent multiple-deletion of PChar
        if (PChar->status == STATUS_TYPE::SHUTDOWN) // EFFECT_LEAVEGAME effect wore off or char got SHUTDOWN from some other location
        {
            m_charsToLogout.emplace_back(PChar);
        }
        else if (PChar->requestedWarp) // EFFECT_TELEPORT can request players to warp
        {
            m_charsToWarp.emplace_back(PChar);
        }
        else if (PChar->requestedZoneChange) // EFFECT_TELEPORT can request players to change zones
        {
            m_charsToChangeZone.emplace_back(PChar);
        }
    }

    //
    // Cleanup logic
    //

    for (const auto* PMob : m_mobsToDelete)
    {
        if (auto itr = m_mobList.find(PMob->targid); itr != m_mobList.end())
        {
            m_mobList.erase(itr);
            m_dynamicTargIdsToDelete.emplace_back(PMob->targid, server_clock::now());
            destroy(PMob);
        }
    }

    for (const auto* PNpc : m_npcsToDelete)
    {
        if (auto itr = m_npcList.find(PNpc->targid); itr != m_npcList.end())
        {
            m_npcList.erase(itr);
            m_dynamicTargIdsToDelete.emplace_back(PNpc->targid, server_clock::now());
            destroy(PNpc);
        }
    }

    for (const auto* PPet : m_petsToDelete)
    {
        if (auto itr = m_petList.find(PPet->targid); itr != m_petList.end())
        {
            m_petList.erase(itr);
            m_dynamicTargIdsToDelete.emplace_back(PPet->targid, server_clock::now());
            destroy(PPet);
        }
    }

    for (const auto* PTrust : m_trustsToDelete)
    {
        if (auto itr = m_trustList.find(PTrust->targid); itr != m_trustList.end())
        {
            m_trustList.erase(itr);
            m_dynamicTargIdsToDelete.emplace_back(PTrust->targid, server_clock::now());
            destroy(PTrust);
        }
    }

    // forceLogout eventually removes the char from m_charList -- so we must remove them here
    for (auto* PChar : m_charsToLogout)
    {
        PChar->clearPacketList();
        charutils::ForceLogout(PChar);
    }

    // Warp players (do not recover HP/MP)
    for (auto* PChar : m_charsToWarp)
    {
        PChar->clearPacketList();
        charutils::HomePoint(PChar, false);
    }

    // Change player's zone (teleports, etc)
    for (auto* PChar : m_charsToChangeZone)
    {
        PChar->clearPacketList();

        auto ipp = zoneutils::GetZoneIPP(PChar->loc.destination);

        // This is already checked in CLueBaseEntity::setPos, but better to have a check...
        if (ipp == 0)
        {
            ShowWarning(fmt::format("Char {} requested zone ({}) returned IPP of 0", PChar->name, PChar->loc.destination));
            continue;
        }

        charutils::SendToZone(PChar, 2, ipp);
    }

    if (tick > m_EffectCheckTime)
    {
        m_EffectCheckTime = m_EffectCheckTime + 3s > tick ? m_EffectCheckTime + 3s : tick + 3s;
    }

    if (tick > m_charPersistTime && !m_charTargIds.empty())
    {
        m_charPersistTime = tick + 1s;

        std::set<uint16>::iterator charTargIdIter = m_charTargIds.lower_bound(m_lastCharPersistTargId);
        if (charTargIdIter == m_charTargIds.end())
        {
            charTargIdIter = m_charTargIds.begin();
        }

        size_t maxChecks = std::min<size_t>(m_charTargIds.size(), PERSIST_CHECK_CHARACTERS);

        for (size_t i = 0; i < maxChecks; i++)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(m_charList[*charTargIdIter]);
            ++charTargIdIter;
            if (charTargIdIter == m_charTargIds.end())
            {
                charTargIdIter = m_charTargIds.begin();
            }

            if (PChar && PChar->PersistData(tick))
            {
                // We only want to persist at most 1 character per zone tick
                break;
            }
        }
        m_lastCharPersistTargId = *charTargIdIter;
    }

    if (tick > m_computeTime && !m_charTargIds.empty())
    {
        // Tick time is irregular to avoid consistently happening at the same time as char persistence
        m_computeTime = tick + 567ms;

        std::set<uint16>::iterator charTargIdIter = m_charTargIds.lower_bound(m_lastCharComputeTargId);
        if (charTargIdIter == m_charTargIds.end())
        {
            charTargIdIter = m_charTargIds.begin();
        }

        std::size_t maxIterations = std::min<std::size_t>(m_charTargIds.size(), std::min<std::size_t>(10000U / m_charTargIds.size(), 20U));

        for (std::size_t i = 0; i < maxIterations; i++)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(m_charList[*charTargIdIter]);
            ++charTargIdIter;

            if (charTargIdIter == m_charTargIds.end())
            {
                charTargIdIter = m_charTargIds.begin();
            }

            if (PChar && PChar->requestedInfoSync)
            {
                PChar->requestedInfoSync = false;
                SpawnPCs(PChar);
            }
        }

        m_lastCharComputeTargId = *charTargIdIter;
    }

    moduleutils::OnZoneTick(m_zone);

    // Clear intermediate containers
    m_mobsToDelete.clear();
    m_npcsToDelete.clear();
    m_petsToDelete.clear();
    m_trustsToDelete.clear();
    m_aggroableMobs.clear();
    m_charsToLogout.clear();
    m_charsToWarp.clear();
    m_charsToChangeZone.clear();
}

CZone* CZoneEntities::GetZone()
{
    return m_zone;
}

EntityList_t CZoneEntities::GetCharList() const
{
    return m_charList;
}

EntityList_t CZoneEntities::GetMobList() const
{
    return m_mobList;
}
