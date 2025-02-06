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
#include "common/utils.h"

#include <cstring>

#include "packets/action.h"
#include "packets/basic.h"
#include "packets/char_appearance.h"
#include "packets/char_health.h"
#include "packets/char_recast.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/char_update.h"
#include "packets/entity_update.h"
#include "packets/event.h"
#include "packets/event_string.h"
#include "packets/inventory_finish.h"
#include "packets/key_items.h"
#include "packets/lock_on.h"
#include "packets/menu_raisetractor.h"
#include "packets/message_special.h"
#include "packets/message_standard.h"
#include "packets/message_system.h"
#include "packets/message_text.h"
#include "packets/release.h"

#include "ai/ai_container.h"
#include "ai/controllers/player_controller.h"
#include "ai/helpers/targetfind.h"
#include "ai/states/ability_state.h"
#include "ai/states/attack_state.h"
#include "ai/states/death_state.h"
#include "ai/states/inactive_state.h"
#include "ai/states/item_state.h"
#include "ai/states/magic_state.h"
#include "ai/states/raise_state.h"
#include "ai/states/range_state.h"
#include "ai/states/weaponskill_state.h"

#include "ability.h"
#include "attack.h"
#include "automatonentity.h"
#include "battlefield.h"
#include "char_recast_container.h"
#include "charentity.h"
#include "conquest_system.h"
#include "item_container.h"
#include "items/item_furnishing.h"
#include "items/item_usable.h"
#include "items/item_weapon.h"
#include "job_points.h"
#include "latent_effect_container.h"
#include "linkshell.h"
#include "message.h"
#include "mob_modifier.h"
#include "mobskill.h"
#include "modifier.h"
#include "notoriety_container.h"
#include "packets/char_job_extra.h"
#include "packets/status_effects.h"
#include "petskill.h"
#include "spell.h"
#include "status_effect_container.h"
#include "trade_container.h"
#include "treasure_pool.h"
#include "trustentity.h"
#include "unitychat.h"
#include "universal_container.h"
#include "utils/attackutils.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "utils/gardenutils.h"
#include "utils/moduleutils.h"
#include "utils/petutils.h"
#include "weapon_skill.h"

CCharEntity::CCharEntity()
{
    TracyZoneScoped;
    objtype     = TYPE_PC;
    m_EcoSystem = ECOSYSTEM::HUMANOID;

    eventPreparation = new EventPrep();
    currentEvent     = new EventInfo();

    inSequence = false;
    gotMessage = false;
    m_Locked   = false;

    accid        = 0;
    m_GMlevel    = 0;
    m_isGMHidden = false;

    allegiance = ALLEGIANCE_TYPE::PLAYER;

    TradeContainer = new CTradeContainer();
    Container      = new CTradeContainer();
    UContainer     = new CUContainer();
    CraftContainer = new CTradeContainer();

    m_Inventory  = std::make_unique<CItemContainer>(LOC_INVENTORY);
    m_Mogsafe    = std::make_unique<CItemContainer>(LOC_MOGSAFE);
    m_Storage    = std::make_unique<CItemContainer>(LOC_STORAGE);
    m_Tempitems  = std::make_unique<CItemContainer>(LOC_TEMPITEMS);
    m_Moglocker  = std::make_unique<CItemContainer>(LOC_MOGLOCKER);
    m_Mogsatchel = std::make_unique<CItemContainer>(LOC_MOGSATCHEL);
    m_Mogsack    = std::make_unique<CItemContainer>(LOC_MOGSACK);
    m_Mogcase    = std::make_unique<CItemContainer>(LOC_MOGCASE);
    m_Wardrobe   = std::make_unique<CItemContainer>(LOC_WARDROBE);
    m_Mogsafe2   = std::make_unique<CItemContainer>(LOC_MOGSAFE2);
    m_Wardrobe2  = std::make_unique<CItemContainer>(LOC_WARDROBE2);
    m_Wardrobe3  = std::make_unique<CItemContainer>(LOC_WARDROBE3);
    m_Wardrobe4  = std::make_unique<CItemContainer>(LOC_WARDROBE4);
    m_Wardrobe5  = std::make_unique<CItemContainer>(LOC_WARDROBE5);
    m_Wardrobe6  = std::make_unique<CItemContainer>(LOC_WARDROBE6);
    m_Wardrobe7  = std::make_unique<CItemContainer>(LOC_WARDROBE7);
    m_Wardrobe8  = std::make_unique<CItemContainer>(LOC_WARDROBE8);
    m_RecycleBin = std::make_unique<CItemContainer>(LOC_RECYCLEBIN);

    keys = {};
    std::memset(&equip, 0, sizeof(equip));
    std::memset(&equipLoc, 0, sizeof(equipLoc));

    m_SpellList = {};
    std::memset(&m_LearnedAbilities, 0, sizeof(m_LearnedAbilities));
    std::memset(&m_TitleList, 0, sizeof(m_TitleList));
    std::memset(&m_ZonesList, 0, sizeof(m_ZonesList));
    std::memset(&m_Abilities, 0, sizeof(m_Abilities));
    std::memset(&m_TraitList, 0, sizeof(m_TraitList));
    std::memset(&m_PetCommands, 0, sizeof(m_PetCommands));
    std::memset(&m_WeaponSkills, 0, sizeof(m_WeaponSkills));
    std::memset(&m_SetBlueSpells, 0, sizeof(m_SetBlueSpells));
    std::memset(&m_FieldChocobo, 0, sizeof(m_FieldChocobo));
    std::memset(&m_unlockedAttachments, 0, sizeof(m_unlockedAttachments));

    std::memset(&m_questLog, 0, sizeof(m_questLog));
    std::memset(&m_missionLog, 0, sizeof(m_missionLog));
    m_eminenceCache.activemap.reset();

    std::memset(&m_claimedDeeds, 0, sizeof(m_claimedDeeds));

    for (uint8 i = 0; i <= 3; ++i)
    {
        m_missionLog[i].current = 0xFFFF;
    }

    m_missionLog[4].current = 0;   // MISSION_TOAU
    m_missionLog[5].current = 0;   // MISSION_WOTG
    m_missionLog[6].current = 101; // MISSION_COP
    for (auto& i : m_missionLog)
    {
        i.statusUpper = 0;
        i.statusLower = 0;
    }

    m_copCurrent = 0;
    m_acpCurrent = 0;
    m_mkeCurrent = 0;
    m_asaCurrent = 0;

    m_PMonstrosity = nullptr;

    m_Costume            = 0;
    m_Costume2           = 0;
    m_hasTractor         = 0;
    m_hasRaise           = 0;
    m_weaknessLvl        = 0;
    m_hasArise           = false;
    m_LevelRestriction   = 0;
    m_lastBcnmTimePrompt = 0;
    m_AHHistoryTimestamp = 0;
    m_DeathTimestamp     = 0;

    m_EquipFlag         = 0;
    m_EquipBlock        = 0;
    m_StatsDebilitation = 0;
    m_EquipSwap         = false;

    MeritMode    = false;
    PMeritPoints = nullptr;
    PJobPoints   = nullptr;

    PGuildShop = nullptr;

    m_isStyleLocked = false;
    m_isBlockingAid = false;

    BazaarID.clean();

    WideScanTarget = std::nullopt;

    lastTradeInvite = {};
    TradePending.clean();
    InvitePending.clean();

    PLinkshell1   = nullptr;
    PLinkshell2   = nullptr;
    PUnityChat    = nullptr;
    PTreasurePool = nullptr;

    PClaimedMob            = nullptr;
    PRecastContainer       = std::make_unique<CCharRecastContainer>(this);
    PLatentEffectContainer = new CLatentEffectContainer(this);

    requestedWarp       = false;
    requestedZoneChange = false;

    retriggerLatents = false;

    resetPetZoningInfo();
    petZoningInfo.petID = 0;

    m_PlayTime    = 0;
    m_SaveTime    = 0;
    m_reloadParty = false;

    m_moghouseID     = 0;
    m_moghancementID = 0;

    m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;

    playerConfig = {};

    PAI = std::make_unique<CAIContainer>(this, nullptr, std::make_unique<CPlayerController>(this), std::make_unique<CTargetFind>(this));

    hookedFish   = nullptr;
    lastCastTime = 0;
    nextFishTime = 0;
    fishingToken = 0;
    hookDelay    = 13;

    profile = {};
    search  = {};
    std::memset(&styleItems, 0, sizeof(styleItems));

    m_StartActionPos   = {};
    m_ActionOffsetPos  = {};
    m_previousLocation = {};

    m_mentorUnlocked   = false;
    m_jobMasterDisplay = false;
    m_EffectsChanged   = false;

    visibleGmLevel        = 0;
    wallhackEnabled       = false;
    isSettingBazaarPrices = false;
    isLinkDead            = false;
    pendingPositionUpdate = false;
}

CCharEntity::~CCharEntity()
{
    TracyZoneScoped;
    clearPacketList();

    if (PTreasurePool != nullptr)
    {
        // remove myself
        PTreasurePool->DelMember(this);
    }

    ClearTrusts(); // trusts don't survive zone lines

    if (PLinkshell1 != nullptr)
    {
        PLinkshell1->DelMember(this);
    }

    if (PLinkshell2 != nullptr)
    {
        PLinkshell2->DelMember(this);
    }

    if (PUnityChat != nullptr)
    {
        PUnityChat->DelMember(this);
    }

    if (isDead())
    {
        charutils::SaveDeathTime(this);
    }

    if (m_LevelRestriction != 0)
    {
        if (PParty)
        {
            if (PParty->GetSyncTarget() == this || PParty->GetLeader() == this)
            {
                PParty->SetSyncTarget("", MsgStd::LevelSyncDeactivateLeftArea);
            }
            if (PParty->GetSyncTarget() != nullptr)
            {
                uint8 count = 0;
                for (uint32 i = 0; i < PParty->members.size(); ++i)
                {
                    if (PParty->members.at(i) != this && PParty->members.at(i)->getZone() == PParty->GetSyncTarget()->getZone())
                    {
                        count++;
                    }
                }
                if (count < 2) // 3, because one is zoning out - thus at least 2 will be left
                {
                    PParty->SetSyncTarget("", MsgStd::LevelSyncRemoveTooFewMembers);
                }
            }
        }
        StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEVEL_SYNC);
        StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEVEL_RESTRICTION);
    }

    if (PParty && loc.destination != 0 && m_moghouseID == 0)
    {
        uint8 data[4]{};

        if (PParty->m_PAlliance)
        {
            ref<uint32>(data, 0) = PParty->m_PAlliance->m_AllianceID;
            message::send(MSG_ALLIANCE_RELOAD, data, sizeof(data), nullptr);
        }
        else
        {
            ref<uint32>(data, 0) = PParty->GetPartyID();
            message::send(MSG_PT_RELOAD, data, sizeof(data), nullptr);
        }
    }

    SpawnPCList.clear();
    SpawnNPCList.clear();
    SpawnMOBList.clear();
    SpawnPETList.clear();
    SpawnTRUSTList.clear();

    if (PParty)
    {
        PParty->PopMember(this);
    }

    charutils::WriteHistory(this);

    destroy(TradeContainer);
    destroy(Container);
    destroy(UContainer);
    destroy(CraftContainer);
    destroy(PMeritPoints);
    destroy(PJobPoints);
    destroy(PLatentEffectContainer);

    PGuildShop = nullptr;

    destroy(eventPreparation);
    destroy(currentEvent);

    while (!eventQueue.empty())
    {
        auto head = eventQueue.front();
        eventQueue.pop_front();
        destroy(head);
    }
}

uint8 CCharEntity::GetGender()
{
    return (look.race) % 2 ^ (look.race > 6);
}

bool CCharEntity::isPacketListEmpty()
{
    return PacketList.empty();
}

auto CCharEntity::getPacketList() const -> const std::deque<std::unique_ptr<CBasicPacket>>&
{
    return PacketList;
}

auto CCharEntity::getPacketListCopy() -> std::deque<std::unique_ptr<CBasicPacket>>
{
    std::deque<std::unique_ptr<CBasicPacket>> PacketListCopy;
    for (const auto& packet : PacketList)
    {
        PacketListCopy.emplace_back(std::make_unique<CBasicPacket>(packet));
    }
    return PacketListCopy;
}

void CCharEntity::clearPacketList()
{
    while (!PacketList.empty())
    {
        std::ignore = popPacket();
    }
}

void CCharEntity::pushPacket(std::unique_ptr<CBasicPacket>&& packet)
{
    TracyZoneScoped;
    TracyZoneString(getName());
    TracyZoneHex16(packet->getType());

    if (isPacketFiltered(packet))
    {
        // packet will destruct itself when it goes out of scope
        return;
    }

    moduleutils::OnPushPacket(this, packet);

    if (packet->getType() == 0x5B)
    {
        if (packet->ref<uint32>(0x10) == this->id)
        {
            pendingPositionUpdate = true;
        }
    }

    PacketList.emplace_back(std::move(packet));
}

void CCharEntity::updateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask)
{
    auto       itr              = EntityUpdatePackets.find(PEntity->id);
    const bool hasPendingPacket = itr != EntityUpdatePackets.end() && itr->second != nullptr;
    auto*      PChar            = dynamic_cast<CCharEntity*>(PEntity);
    if (hasPendingPacket)
    {
        // Found existing packet update for the given entity, so we update it instead of pushing new
        auto& packet = itr->second;
        if (PChar)
        {
            static_cast<CCharUpdatePacket*>(packet)->updateWith(PChar, type, updatemask);
        }
        else
        {
            static_cast<CEntityUpdatePacket*>(packet)->updateWith(PEntity, type, updatemask);
        }
    }
    else
    {
        // No existing packet update for the given entity, so we push new packet
        if (PChar)
        {
            auto packet                    = std::make_unique<CCharUpdatePacket>(PChar, type, updatemask);
            EntityUpdatePackets[PChar->id] = packet.get();
            PacketList.emplace_back(std::move(packet));
        }
        else
        {
            auto packet                      = std::make_unique<CEntityUpdatePacket>(PEntity, type, updatemask);
            EntityUpdatePackets[PEntity->id] = packet.get();
            PacketList.emplace_back(std::move(packet));
        }
    }
}

auto CCharEntity::popPacket() -> std::unique_ptr<CBasicPacket>
{
    auto PPacket = std::move(PacketList.front());
    PacketList.pop_front();

    // Clean up pending
    switch (PPacket->getType())
    {
        case 0x0D: // Char update
            [[fallthrough]];
        case 0x0E: // Entity update
            EntityUpdatePackets.erase(PPacket->ref<uint32>(0x04));
            break;
        case 0x5B: // Position update
            if (PPacket->ref<uint32>(0x10) == this->id)
            {
                pendingPositionUpdate = false;
            }
            break;
        default:
            break;
    }

    return PPacket;
}

size_t CCharEntity::getPacketCount()
{
    return PacketList.size();
}

void CCharEntity::erasePackets(uint8 num)
{
    for (auto i = 0; i < num; i++)
    {
        std::ignore = popPacket();
    }
}

bool CCharEntity::isPacketFiltered(std::unique_ptr<CBasicPacket>& packet)
{
    // Filter others synthesis results
    if (packet->getType() == 0x70 && playerConfig.MessageFilter.others_synthesis_and_fishing_results)
    {
        return true;
    }

    return false;
}

bool CCharEntity::isNewPlayer() const
{
    return !playerConfig.NewAdventurerOffFlg;
}

bool CCharEntity::isSeekingParty() const
{
    return playerConfig.InviteFlg;
}

bool CCharEntity::isAnon() const
{
    return playerConfig.AnonymityFlg;
}

bool CCharEntity::isAway() const
{
    return playerConfig.AwayFlg;
}

bool CCharEntity::isMentor() const
{
    return playerConfig.MentorFlg;
}

bool CCharEntity::hasAutoTargetEnabled() const
{
    return !playerConfig.AutoTargetOffFlg;
}

void CCharEntity::setPetZoningInfo()
{
    if (PPet == nullptr || PPet->objtype != TYPE_PET)
    {
        return;
    }

    auto PPetEntity = dynamic_cast<CPetEntity*>(PPet);
    if (PPetEntity == nullptr)
    {
        return;
    }
    petZoningInfo.petID = PPetEntity->m_PetID;

    switch (PPetEntity->getPetType())
    {
        case PET_TYPE::JUG_PET:
            if (!settings::get<bool>("map.KEEP_JUGPET_THROUGH_ZONING"))
            {
                break;
            }
            petZoningInfo.jugSpawnTime = PPetEntity->getJugSpawnTime();
            petZoningInfo.jugDuration  = PPetEntity->getJugDuration();
            [[fallthrough]];
        case PET_TYPE::AVATAR:
        case PET_TYPE::AUTOMATON:
        case PET_TYPE::WYVERN:
            petZoningInfo.petLevel = PPetEntity->getSpawnLevel();
            petZoningInfo.petHP    = PPet->health.hp;
            petZoningInfo.petTP    = PPet->health.tp;
            petZoningInfo.petMP    = PPet->health.mp;
            petZoningInfo.petType  = PPetEntity->getPetType();
            break;
        default:
            break;
    }

    petZoningInfo.respawnPet = true;
}

void CCharEntity::resetPetZoningInfo()
{
    // reset the petZoning info
    petZoningInfo.petLevel     = 0;
    petZoningInfo.petHP        = 0;
    petZoningInfo.petTP        = 0;
    petZoningInfo.petMP        = 0;
    petZoningInfo.respawnPet   = false;
    petZoningInfo.petType      = PET_TYPE::AVATAR;
    petZoningInfo.jugSpawnTime = 0;
    petZoningInfo.jugDuration  = 0;
}

bool CCharEntity::shouldPetPersistThroughZoning()
{
    PET_TYPE petType{};
    auto     PPetEntity = dynamic_cast<CPetEntity*>(PPet);

    if (PPetEntity == nullptr && !petZoningInfo.respawnPet)
    {
        return false;
    }

    if (PPetEntity != nullptr)
    {
        petType = PPetEntity->getPetType();
    }
    else // petZoningInfo.respawnPet == true
    {
        petType = petZoningInfo.petType;
    }

    return petType == PET_TYPE::WYVERN ||
           petType == PET_TYPE::AVATAR ||
           petType == PET_TYPE::AUTOMATON ||
           (petType == PET_TYPE::JUG_PET && settings::get<bool>("map.KEEP_JUGPET_THROUGH_ZONING"));
}

void CCharEntity::setAutomatonFrame(AUTOFRAMETYPE frame)
{
    automatonInfo.m_Equip.Frame = frame;
}

void CCharEntity::setAutomatonHead(AUTOHEADTYPE head)
{
    automatonInfo.m_Equip.Head = head;
}

void CCharEntity::setAutomatonAttachment(uint8 slotid, uint8 id)
{
    automatonInfo.m_Equip.Attachments[slotid] = id;
}

void CCharEntity::setAutomatonElementMax(uint8 element, uint8 max)
{
    automatonInfo.m_ElementMax[element] = max;
}
void CCharEntity::addAutomatonElementCapacity(uint8 element, int8 value)
{
    automatonInfo.m_ElementEquip[element] += value;
}

void CCharEntity::setAutomatonElementalCapacityBonus(uint8 bonus)
{
    if (bonus == automatonInfo.m_elementalCapacityBonus)
    {
        return;
    }

    int8 difference = static_cast<int8>(bonus) - automatonInfo.m_elementalCapacityBonus;
    for (size_t i = 0; i < automatonInfo.m_ElementMax.size(); ++i)
    {
        automatonInfo.m_ElementMax[i] += difference;
    }

    automatonInfo.m_elementalCapacityBonus = bonus;
}

AUTOFRAMETYPE CCharEntity::getAutomatonFrame() const
{
    return static_cast<AUTOFRAMETYPE>(automatonInfo.m_Equip.Frame);
}

AUTOHEADTYPE CCharEntity::getAutomatonHead() const
{
    return static_cast<AUTOHEADTYPE>(automatonInfo.m_Equip.Head);
}

uint8 CCharEntity::getAutomatonAttachment(uint8 slotid)
{
    return automatonInfo.m_Equip.Attachments[slotid];
}

bool CCharEntity::hasAutomatonAttachment(uint8 attachment)
{
    for (auto&& attachmentid : automatonInfo.m_Equip.Attachments)
    {
        if (attachmentid == attachment)
        {
            return true;
        }
    }
    return false;
}

uint8 CCharEntity::getAutomatonElementMax(uint8 element)
{
    return automatonInfo.m_ElementMax[element];
}

uint8 CCharEntity::getAutomatonElementCapacity(uint8 element)
{
    return automatonInfo.m_ElementEquip[element];
}

/************************************************************************
 *
 * Return the container with the specified ID.If the ID goes beyond, then *
 * We protect the server from falling the use of temporary container *
 * Items as a plug (from this container items can not *
 * Move, wear, transmit, sell, etc.).Display *
 * Fatal error message.*
 *
 ************************************************************************/

CItemContainer* CCharEntity::getStorage(uint8 LocationID)
{
    switch (LocationID)
    {
        case LOC_INVENTORY:
            return m_Inventory.get();
        case LOC_MOGSAFE:
            return m_Mogsafe.get();
        case LOC_STORAGE:
            return m_Storage.get();
        case LOC_TEMPITEMS:
            return m_Tempitems.get();
        case LOC_MOGLOCKER:
            return m_Moglocker.get();
        case LOC_MOGSATCHEL:
            return m_Mogsatchel.get();
        case LOC_MOGSACK:
            return m_Mogsack.get();
        case LOC_MOGCASE:
            return m_Mogcase.get();
        case LOC_WARDROBE:
            return m_Wardrobe.get();
        case LOC_MOGSAFE2:
            return m_Mogsafe2.get();
        case LOC_WARDROBE2:
            return m_Wardrobe2.get();
        case LOC_WARDROBE3:
            return m_Wardrobe3.get();
        case LOC_WARDROBE4:
            return m_Wardrobe4.get();
        case LOC_WARDROBE5:
            return m_Wardrobe5.get();
        case LOC_WARDROBE6:
            return m_Wardrobe6.get();
        case LOC_WARDROBE7:
            return m_Wardrobe7.get();
        case LOC_WARDROBE8:
            return m_Wardrobe8.get();
        case LOC_RECYCLEBIN:
            return m_RecycleBin.get();
    }

    ShowWarning("Unhandled or Invalid Location ID (%d) passed to function.", LocationID);
    return nullptr;
}

int8 CCharEntity::getShieldSize()
{
    CItemEquipment* PItem = getEquip(SLOT_SUB);

    if (PItem == nullptr)
    {
        return 0;
    }

    if (!PItem->IsShield())
    {
        return 0;
    }

    return PItem->getShieldSize();
}

int16 CCharEntity::getShieldDefense()
{
    CItemEquipment* PItem = getEquip(SLOT_SUB);

    if (PItem && PItem->IsShield())
    {
        return PItem->getModifier(Mod::DEF);
    }

    return 0;
}

bool CCharEntity::hasBazaar()
{
    if (isSettingBazaarPrices)
    {
        return false;
    }

    CItemContainer* playerInventory = getStorage(LOC_INVENTORY);

    if (playerInventory)
    {
        for (uint8 slotID = 1; slotID <= playerInventory->GetSize(); ++slotID)
        {
            CItem* PItem = playerInventory->GetItem(slotID);

            if ((PItem != nullptr) && (PItem->getCharPrice() != 0))
            {
                return true;
                break;
            }
        }
    }
    return false;
}

void CCharEntity::SetName(const std::string& name)
{
    this->name = name;

    if (this->name.size() > PacketNameLength)
    {
        this->name.resize(PacketNameLength); // Enforce max name limit
    }
}

int16 CCharEntity::addTP(int16 tp)
{
    tp = CBattleEntity::addTP(tp);
    PLatentEffectContainer->CheckLatentsTP();

    return abs(tp);
}

int32 CCharEntity::addHP(int32 hp)
{
    hp = CBattleEntity::addHP(hp);
    PLatentEffectContainer->CheckLatentsHP();

    return abs(hp);
}

int32 CCharEntity::addMP(int32 mp)
{
    mp = CBattleEntity::addMP(mp);
    PLatentEffectContainer->CheckLatentsMP();

    return abs(mp);
}

bool CCharEntity::getStyleLocked() const
{
    return m_isStyleLocked;
}

void CCharEntity::setStyleLocked(bool isStyleLocked)
{
    m_isStyleLocked = isStyleLocked;
}

bool CCharEntity::getBlockingAid() const
{
    return m_isBlockingAid;
}

void CCharEntity::setBlockingAid(bool isBlockingAid)
{
    m_isBlockingAid = isBlockingAid;
}

void CCharEntity::SetPlayTime(uint32 playTime)
{
    m_PlayTime = playTime;
    m_SaveTime = gettick() / 1000;
}

uint32 CCharEntity::GetPlayTime(bool needUpdate)
{
    if (needUpdate)
    {
        uint32 currentTime = gettick() / 1000;

        m_PlayTime += currentTime - m_SaveTime;
        m_SaveTime = currentTime;
    }

    return m_PlayTime;
}

CItemEquipment* CCharEntity::getEquip(SLOTTYPE slot)
{
    uint8           loc  = equip[slot];
    uint8           est  = equipLoc[slot];
    CItemEquipment* item = nullptr;

    if (loc != 0)
    {
        item = (CItemEquipment*)getStorage(est)->GetItem(loc);
    }
    return item;
}

void CCharEntity::ReloadPartyInc()
{
    m_reloadParty = true;
}

void CCharEntity::ReloadPartyDec()
{
    m_reloadParty = false;
}

bool CCharEntity::ReloadParty() const
{
    return m_reloadParty;
}

void CCharEntity::RemoveTrust(CTrustEntity* PTrust)
{
    if (!PTrust->PAI->IsSpawned())
    {
        return;
    }

    // clang-format off
    auto trustIt = std::find_if(PTrusts.begin(), PTrusts.end(), [PTrust](auto trust)
    {
        return PTrust == trust;
    });
    // clang-format on

    if (trustIt != PTrusts.end())
    {
        if (PTrust->animation == ANIMATION_DESPAWN)
        {
            luautils::OnMobDespawn(PTrust);
        }
        PTrust->PAI->Despawn();
        PTrusts.erase(trustIt);
    }

    ReloadPartyInc();
}

void CCharEntity::ClearTrusts()
{
    for (auto* PTrust : PTrusts)
    {
        PTrust->PAI->Despawn();
    }
    PTrusts.clear();

    ReloadPartyInc();
}

void CCharEntity::RequestPersist(CHAR_PERSIST toPersist)
{
    dataToPersist |= toPersist;
}

bool CCharEntity::PersistData()
{
    bool didPersist = false;

    if (!charVarChanges.empty())
    {
        for (auto&& charVarName : charVarChanges)
        {
            charutils::PersistCharVar(this->id, charVarName.c_str(), charVarCache[charVarName].first, charVarCache[charVarName].second);
        }

        charVarChanges.clear();
        didPersist = true;
    }

    if (!dataToPersist)
    {
        return didPersist;
    }
    else
    {
        didPersist = true;
    }

    if (dataToPersist & CHAR_PERSIST::EQUIP)
    {
        charutils::SaveCharEquip(this);
        charutils::SaveCharLook(this);
    }

    if (dataToPersist & CHAR_PERSIST::POSITION)
    {
        charutils::SaveCharPosition(this);
    }

    if (dataToPersist & CHAR_PERSIST::EFFECTS)
    {
        StatusEffectContainer->SaveStatusEffects(true);
    }

    /* TODO
    if (dataToPersist & CHAR_PERSIST::LINKSHELL)
    {
        charutils::SaveCharLinkshells(this);
    }
    */

    dataToPersist = 0;
    return didPersist;
}

bool CCharEntity::PersistData(time_point tick)
{
    if (tick < nextDataPersistTime || !PersistData())
    {
        return false;
    }

    nextDataPersistTime = tick + TIME_BETWEEN_PERSIST;
    return true;
}

void CCharEntity::Tick(time_point tick)
{
    TracyZoneScoped;
    CBattleEntity::Tick(tick);
    if (m_DeathTimestamp > 0 && tick >= m_deathSyncTime)
    {
        // Send an update packet at a regular interval to keep the player's death variables synced
        updatemask |= UPDATE_STATUS;
        m_deathSyncTime = tick + death_update_frequency;
    }

    if (m_moghouseID != 0)
    {
        gardenutils::UpdateGardening(this, true);
    }
}

void CCharEntity::PostTick()
{
    TracyZoneScoped;

    CBattleEntity::PostTick();

    if (m_EquipSwap)
    {
        updatemask |= UPDATE_HP;
        m_EquipSwap = false;
        pushPacket<CCharAppearancePacket>(this);
    }

    // notify client containers are dirty and then no longer dirty
    if (!dirtyInventoryContainers.empty())
    {
        // Notify client containers were dirty
        // Note: Retail sends this in the same chunk as the inventory equip packets, but it doesnt seem to matter as long as it arrives
        for (const auto& [container, dirty] : dirtyInventoryContainers)
        {
            pushPacket<CInventoryFinishPacket>(container);
        }

        dirtyInventoryContainers.clear();

        // Notify client containers are now ok
        pushPacket<CInventoryFinishPacket>();
    }

    if (ReloadParty())
    {
        charutils::ReloadParty(this);
    }

    if (m_EffectsChanged)
    {
        pushPacket<CCharStatusPacket>(this);
        pushPacket<CCharSyncPacket>(this);
        pushPacket<CCharJobExtraPacket>(this, true);
        pushPacket<CCharJobExtraPacket>(this, false);
        pushPacket<CStatusEffectPacket>(this);
        if (PParty)
        {
            PParty->PushEffectsPacket();
        }
        m_EffectsChanged = false;
    }

    std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();

    if (updatemask && now > m_nextUpdateTimer)
    {
        m_nextUpdateTimer = now + 250ms;

        if (loc.zone && !m_isGMHidden)
        {
            loc.zone->UpdateEntityPacket(this, ENTITY_UPDATE, updatemask);
        }

        if (isCharmed)
        {
            updateEntityPacket(this, ENTITY_UPDATE, updatemask);
        }

        if (updatemask & UPDATE_HP)
        {
            // clang-format off
            ForAlliance([&](auto PEntity)
            {
                static_cast<CCharEntity*>(PEntity)->pushPacket<CCharHealthPacket>(this);
            });
            // clang-format on
        }
        // Do not send an update packet when only the position has change
        if (updatemask ^ UPDATE_POS)
        {
            pushPacket<CCharStatusPacket>(this);
        }
        updatemask = 0;
    }
}

void CCharEntity::addTrait(CTrait* PTrait)
{
    CBattleEntity::addTrait(PTrait);
    charutils::addTrait(this, PTrait->getID());
}

void CCharEntity::delTrait(CTrait* PTrait)
{
    CBattleEntity::delTrait(PTrait);
    charutils::delTrait(this, PTrait->getID());
}

bool CCharEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    TracyZoneScoped;

    if (StatusEffectContainer->GetConfrontationEffect() != PInitiator->StatusEffectContainer->GetConfrontationEffect())
    {
        return false;
    }

    if (isDead())
    {
        return (targetFlags & TARGET_PLAYER_DEAD) != 0;
    }

    if ((targetFlags & TARGET_PLAYER) && allegiance == PInitiator->allegiance)
    {
        return true;
    }

    if (CBattleEntity::ValidTarget(PInitiator, targetFlags))
    {
        return true;
    }

    bool isSameParty      = PParty && PInitiator->PParty && PInitiator->PParty == PParty;
    bool isSameAlliance   = PParty && PParty->m_PAlliance && PInitiator->PParty && PInitiator->PParty->m_PAlliance && PParty->m_PAlliance == PInitiator->PParty->m_PAlliance;
    bool isPartyPetMaster = PInitiator->PMaster && PInitiator->PMaster->PParty && PInitiator->PMaster->PParty == PParty;
    bool isSoloPetMaster  = PParty == nullptr && PInitiator->PMaster == this;
    bool targetsParty     = targetFlags & TARGET_PLAYER_PARTY;
    bool targetsAlliance  = targetFlags & TARGET_PLAYER_ALLIANCE;
    bool hasPianissimo    = (targetFlags & TARGET_PLAYER_PARTY_PIANISSIMO) && PInitiator->StatusEffectContainer->HasStatusEffect(EFFECT_PIANISSIMO);
    bool hasEntrust       = (targetFlags & TARGET_PLAYER_PARTY_ENTRUST) && PInitiator->StatusEffectContainer->HasStatusEffect(EFFECT_ENTRUST);
    bool isDifferentChar  = PInitiator != this;
    bool isTrust          = PInitiator->objtype == TYPE_TRUST;

    // Alliance member valid target.
    if (targetsAlliance &&
        isSameAlliance &&
        isDifferentChar)
    {
        return true;
    }

    // Party member valid targeting.
    if ((targetsParty || hasPianissimo) &&
        (isSameParty || isPartyPetMaster || isSoloPetMaster) &&
        isDifferentChar)
    {
        return true;
    }

    if (hasEntrust && (isSameParty || isTrust))
    {
        return true;
    }

    return false;
}

bool CCharEntity::CanUseSpell(CSpell* PSpell)
{
    TracyZoneScoped;
    return charutils::hasSpell(this, static_cast<uint16>(PSpell->getID())) && CBattleEntity::CanUseSpell(PSpell);
}

void CCharEntity::OnChangeTarget(CBattleEntity* PNewTarget)
{
    TracyZoneScoped;
    battleutils::RelinquishClaim(this);
    pushPacket<CLockOnPacket>(this, PNewTarget);
    PLatentEffectContainer->CheckLatentsTargetChange();
}

void CCharEntity::OnEngage(CAttackState& state)
{
    TracyZoneScoped;
    CBattleEntity::OnEngage(state);
    PLatentEffectContainer->CheckLatentsTargetChange();
    this->m_charHistory.battlesFought++;
}

void CCharEntity::OnDisengage(CAttackState& state)
{
    TracyZoneScoped;
    battleutils::RelinquishClaim(this);
    CBattleEntity::OnDisengage(state);
    if (state.HasErrorMsg())
    {
        pushPacket(state.GetErrorMsg());
    }
    PLatentEffectContainer->CheckLatentsWeaponDraw(false);
}

bool CCharEntity::CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg)
{
    TracyZoneScoped;

    if (PTarget->PAI->IsUntargetable())
    {
        return false;
    }

    float dist = distance(loc.p, PTarget->loc.p);

    if (!IsMobOwner(PTarget))
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_ALREADY_CLAIMED);

        PAI->Disengage();
        return false;
    }
    else if (!this->StatusEffectContainer->HasStatusEffect({ EFFECT_CHARM, EFFECT_CHARM_II }) && dist > 30)
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_LOSE_SIGHT);
        PAI->Disengage();
        return false;
    }
    else if (!facing(this->loc.p, PTarget->loc.p, 64))
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_UNABLE_TO_SEE_TARG);
        return false;
    }
    else if ((dist - PTarget->m_ModelRadius) > GetMeleeRange())
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_TARG_OUT_OF_RANGE);
        return false;
    }
    return true;
}

bool CCharEntity::OnAttack(CAttackState& state, action_t& action)
{
    TracyZoneScoped;
    auto* controller{ static_cast<CPlayerController*>(PAI->GetController()) };
    controller->setLastAttackTime(server_clock::now());
    auto ret = CBattleEntity::OnAttack(state, action);

    return ret;
}

void CCharEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    TracyZoneScoped;

    auto* PSpell  = state.GetSpell();
    auto* PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    // not ideal, since Trick Attack character (taChar) is also calculated on the lua side for the base spell.
    // Only blue spells that act as a physical WS can TA.
    CBattleEntity* taChar = nullptr;

    if (StatusEffectContainer->HasStatusEffect(EFFECT_TRICK_ATTACK) &&
        PSpell->getSpellGroup() == SPELLGROUP_BLUE &&
        PSpell->dealsDamage())
    {
        taChar = battleutils::getAvailableTrickAttackChar(this, PTarget);
    }

    CBattleEntity::OnCastFinished(state, action);

    for (auto&& actionList : action.actionLists)
    {
        for (auto&& actionTarget : actionList.actionTargets)
        {
            if (actionTarget.param > 0 &&
                PSpell->dealsDamage() &&
                PSpell->getSpellGroup() == SPELLGROUP_BLUE &&
                (StatusEffectContainer->HasStatusEffect(EFFECT_CHAIN_AFFINITY) || StatusEffectContainer->HasStatusEffect(EFFECT_AZURE_LORE)) &&
                static_cast<CBlueSpell*>(PSpell)->getPrimarySkillchain() != 0)
            {
                auto*     PBlueSpell = static_cast<CBlueSpell*>(PSpell);
                SUBEFFECT effect     = battleutils::GetSkillChainEffect(PTarget, PBlueSpell->getPrimarySkillchain(), PBlueSpell->getSecondarySkillchain(), 0);
                if (effect != SUBEFFECT_NONE)
                {
                    uint16 skillChainDamage = battleutils::TakeSkillchainDamage(static_cast<CBattleEntity*>(this), PTarget, actionTarget.param, taChar);

                    actionTarget.addEffectParam   = skillChainDamage;
                    actionTarget.addEffectMessage = 287 + effect;
                    actionTarget.additionalEffect = effect;
                }
                if (StatusEffectContainer->HasStatusEffect({ EFFECT_SEKKANOKI, EFFECT_MEIKYO_SHISUI }))
                {
                    health.tp = (health.tp > 1000 ? health.tp - 1000 : 0);
                }
                else
                {
                    health.tp = 0;
                }

                StatusEffectContainer->DelStatusEffectSilent(EFFECT_CHAIN_AFFINITY);
            }

            // Immanence will create or extend a skillchain for elemental spells
            if (PTarget->health.hp > 0 &&
                actionTarget.param >= 0 &&
                PSpell->dealsDamage() &&
                PSpell->getSpellGroup() == SPELLGROUP_BLACK &&
                (StatusEffectContainer->HasStatusEffect(EFFECT_IMMANENCE)))
            {
                auto      immanenceApplies = true;
                auto      isHelix          = false;
                SUBEFFECT effect           = SUBEFFECT_NONE;
                switch (PSpell->getSpellFamily())
                {
                    case SPELLFAMILY_GEOHELIX:
                        isHelix = true;
                        [[fallthrough]];
                    case SPELLFAMILY_STONE:
                        effect = battleutils::GetSkillChainEffect(PTarget, SKILLCHAIN_ELEMENT::SC_SCISSION, 0, 0);
                        break;
                    case SPELLFAMILY_HYDROHELIX:
                        isHelix = true;
                        [[fallthrough]];
                    case SPELLFAMILY_WATER:
                        effect = battleutils::GetSkillChainEffect(PTarget, SKILLCHAIN_ELEMENT::SC_REVERBERATION, 0, 0);
                        break;
                    case SPELLFAMILY_ANEMOHELIX:
                        isHelix = true;
                        [[fallthrough]];
                    case SPELLFAMILY_AERO:
                        effect = battleutils::GetSkillChainEffect(PTarget, SKILLCHAIN_ELEMENT::SC_DETONATION, 0, 0);
                        break;
                    case SPELLFAMILY_PYROHELIX:
                        isHelix = true;
                        [[fallthrough]];
                    case SPELLFAMILY_FIRE:
                        effect = battleutils::GetSkillChainEffect(PTarget, SKILLCHAIN_ELEMENT::SC_LIQUEFACTION, 0, 0);
                        break;
                    case SPELLFAMILY_CRYOHELIX:
                        isHelix = true;
                        [[fallthrough]];
                    case SPELLFAMILY_BLIZZARD:
                        effect = battleutils::GetSkillChainEffect(PTarget, SKILLCHAIN_ELEMENT::SC_INDURATION, 0, 0);
                        break;
                    case SPELLFAMILY_IONOHELIX:
                        isHelix = true;
                        [[fallthrough]];
                    case SPELLFAMILY_THUNDER:
                        effect = battleutils::GetSkillChainEffect(PTarget, SKILLCHAIN_ELEMENT::SC_IMPACTION, 0, 0);
                        break;
                    case SPELLFAMILY_NOCTOHELIX:
                        isHelix = true;
                        effect  = battleutils::GetSkillChainEffect(PTarget, SKILLCHAIN_ELEMENT::SC_COMPRESSION, 0, 0);
                        break;
                    case SPELLFAMILY_LUMINOHELIX:
                        isHelix = true;
                        effect  = battleutils::GetSkillChainEffect(PTarget, SKILLCHAIN_ELEMENT::SC_TRANSFIXION, 0, 0);
                        break;
                    default:
                        immanenceApplies = false;
                        break;
                }

                if (immanenceApplies)
                {
                    StatusEffectContainer->DelStatusEffect(EFFECT_IMMANENCE);
                }

                if (effect != SUBEFFECT_NONE)
                {
                    int32 skillChainDamage = battleutils::TakeSkillchainDamage(static_cast<CBattleEntity*>(this), PTarget, actionTarget.param, nullptr);

                    if (skillChainDamage < 0)
                    {
                        actionTarget.addEffectParam   = -skillChainDamage;
                        actionTarget.addEffectMessage = 384 + effect;
                    }
                    else
                    {
                        actionTarget.addEffectParam   = skillChainDamage;
                        actionTarget.addEffectMessage = 287 + effect;
                    }
                    actionTarget.additionalEffect = effect;

                    // Closing a skillchain with an immanence Helix will make the magic burst window longer
                    auto scEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);
                    if (isHelix && scEffect)
                    {
                        scEffect->SetDuration(scEffect->GetDuration() + 2000);
                    }
                }
            }
        }
    }
    charutils::RemoveStratagems(this, PSpell);
    if (PSpell->tookEffect())
    {
        charutils::TrySkillUP(this, (SKILLTYPE)PSpell->getSkillType(), PTarget->GetMLevel());

        CItemWeapon* PItem = static_cast<CItemWeapon*>(getEquip(SLOT_RANGED));

        if (PItem && PItem->isType(ITEM_EQUIPMENT))
        {
            SKILLTYPE Skilltype = (SKILLTYPE)PItem->getSkillType();

            switch (PSpell->getSkillType())
            {
                case SKILL_GEOMANCY:
                    if (Skilltype == SKILL_HANDBELL)
                    {
                        charutils::TrySkillUP(this, Skilltype, PTarget->GetMLevel());
                    }
                    break;
                case SKILL_SINGING:
                    if (Skilltype == SKILL_STRING_INSTRUMENT || Skilltype == SKILL_WIND_INSTRUMENT || Skilltype == SKILL_SINGING)
                    {
                        charutils::TrySkillUP(this, Skilltype, PTarget->GetMLevel());
                    }
                    break;
                default:
                    break;
            }
        }
    }
}

void CCharEntity::OnCastInterrupted(CMagicState& state, action_t& action, MSGBASIC_ID msg, bool blockedCast)
{
    TracyZoneScoped;
    CBattleEntity::OnCastInterrupted(state, action, msg, blockedCast);

    if (state.HasErrorMsg())
    {
        auto message = state.GetErrorMsg();

        if (message && action.actiontype != ACTION_MAGIC_INTERRUPT) // Interrupt is handled elsewhere
        {
            pushPacket(std::move(message));
        }
    }
}

void CCharEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    TracyZoneScoped;
    CBattleEntity::OnWeaponSkillFinished(state, action);

    auto* PWeaponSkill  = state.GetSkill();
    auto* PBattleTarget = static_cast<CBattleEntity*>(state.GetTarget());

    int16 tp = state.GetSpentTP();
    tp       = battleutils::CalculateWeaponSkillTP(this, PWeaponSkill, tp);

    PLatentEffectContainer->CheckLatentsTP();
    PLatentEffectContainer->CheckLatentsWS(true);

    SLOTTYPE damslot    = SLOT_MAIN;
    bool     isRangedWS = (PWeaponSkill->getID() >= 192 && PWeaponSkill->getID() <= 218);

    if (distance(loc.p, PBattleTarget->loc.p) - PBattleTarget->m_ModelRadius <= PWeaponSkill->getRange())
    {
        if (PWeaponSkill->getID() >= 192 && PWeaponSkill->getID() <= 221)
        {
            damslot = SLOT_RANGED;
        }

        PAI->TargetFind->reset();
        // TODO: revise parameters
        if (PWeaponSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PBattleTarget, AOE_RADIUS::TARGET, 10, FINDFLAGS_NONE, TARGET_NONE);
        }
        else
        {
            PAI->TargetFind->findSingleTarget(PBattleTarget, FINDFLAGS_NONE, TARGET_NONE);
        }

        // Assumed, it's very difficult to produce this due to WS being nearly instant
        // TODO: attempt to verify.
        if (PAI->TargetFind->m_targets.size() == 0)
        {
            // No targets, perhaps something like Super Jump or otherwise untargetable
            action.actiontype         = ACTION_MAGIC_FINISH;
            action.actionid           = 28787; // Some hardcoded magic for interrupts
            actionList_t& actionList  = action.getNewActionList();
            actionList.ActionTargetID = id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();

            actionTarget.animation = 0x1FC; // Assumed, but not verified.
            actionTarget.messageID = 0;
            actionTarget.reaction  = REACTION::ABILITY | REACTION::HIT;

            return;
        }

        for (auto&& PTarget : PAI->TargetFind->m_targets)
        {
            bool          primary     = PTarget == PBattleTarget;
            actionList_t& actionList  = action.getNewActionList();
            actionList.ActionTargetID = PTarget->id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();

            uint16         tpHitsLanded    = 0;
            uint16         extraHitsLanded = 0;
            int32          damage          = 0;
            CBattleEntity* taChar          = battleutils::getAvailableTrickAttackChar(this, PTarget);

            actionTarget.reaction                           = REACTION::NONE;
            actionTarget.speceffect                         = SPECEFFECT::NONE;
            actionTarget.animation                          = PWeaponSkill->getAnimationId();
            actionTarget.messageID                          = 0;
            std::tie(damage, tpHitsLanded, extraHitsLanded) = luautils::OnUseWeaponSkill(this, PTarget, PWeaponSkill, tp, primary, action, taChar);

            if (!battleutils::isValidSelfTargetWeaponskill(PWeaponSkill->getID()))
            {
                if (primary && PBattleTarget->objtype == TYPE_MOB)
                {
                    luautils::OnWeaponskillHit(PBattleTarget, this, PWeaponSkill->getID());
                }
            }
            else
            {
                actionTarget.messageID = primary ? 224 : 276; // restores mp msg
                actionTarget.reaction  = REACTION::HIT;
                damage                 = std::max(damage, 0);
                actionTarget.param     = PTarget->addMP(damage);
            }

            if (primary)
            {
                if (isRangedWS)
                {
                    uint16 recycleChance = getMod(Mod::RECYCLE) + PMeritPoints->GetMeritValue(MERIT_RECYCLE, this) + this->PJobPoints->GetJobPointValue(JP_AMMO_CONSUMPTION);

                    if (StatusEffectContainer->HasStatusEffect(EFFECT_UNLIMITED_SHOT))
                    {
                        StatusEffectContainer->DelStatusEffect(EFFECT_UNLIMITED_SHOT);
                        recycleChance = 100;
                    }

                    if (xirand::GetRandomNumber(100) > recycleChance)
                    {
                        battleutils::RemoveAmmo(this);
                    }
                }

                // See battleentity.h for REACTION class
                // On retail, weaponskills will contain 0x08, 0x10 (HIT, ABILITY) on hit and may include the following:
                // 0x01, 0x02, 0x04 (MISS, GUARDED, BLOCK)
                // TODO: refactor this so lua returns the number of hits so we don't have to check the reaction bits.
                // check if reaction bits don't contain miss (this WS was *fully* evaded or *fully* parried) (actionTarget.reaction & 0x01 == 0)
                if ((actionTarget.reaction & REACTION::MISS) == REACTION::NONE)
                {
                    int wspoints = settings::get<uint8>("map.WS_POINTS_BASE");

                    if (PBattleTarget->health.hp > 0 && PWeaponSkill->getPrimarySkillchain() != 0)
                    {
                        // NOTE: GetSkillChainEffect is INSIDE this if statement because it
                        //  ALTERS the state of the resonance, which misses and non-elemental skills should NOT do.
                        SUBEFFECT effect = battleutils::GetSkillChainEffect(PBattleTarget, PWeaponSkill->getPrimarySkillchain(),
                                                                            PWeaponSkill->getSecondarySkillchain(), PWeaponSkill->getTertiarySkillchain());
                        // See SUBEFFECT enum in battleentity.h
                        if (effect != SUBEFFECT_NONE)
                        {
                            actionTarget.addEffectParam = battleutils::TakeSkillchainDamage(this, PBattleTarget, damage, taChar);
                            if (actionTarget.addEffectParam < 0)
                            {
                                actionTarget.addEffectParam   = -actionTarget.addEffectParam;
                                actionTarget.addEffectMessage = 384 + effect;
                            }
                            else
                            {
                                actionTarget.addEffectMessage = 287 + effect;
                            }

                            actionTarget.additionalEffect = effect;

                            // Despite appearances, ws_points_skillchain is not a multiplier it is just an amount "per element"
                            auto wsPointsSkillchain = settings::get<uint8>("map.WS_POINTS_SKILLCHAIN");
                            if (effect >= 7 && effect < 15)
                            {
                                wspoints += (1 * wsPointsSkillchain); // 1 element
                            }
                            else if (effect >= 3)
                            {
                                wspoints += (2 * wsPointsSkillchain); // 2 elements
                            }
                            else
                            {
                                wspoints += (4 * wsPointsSkillchain); // 4 elements
                            }
                        }
                    }
                    // check for ws points
                    if (charutils::CheckMob(this->GetMLevel(), PTarget->GetMLevel()) > EMobDifficulty::TooWeak)
                    {
                        charutils::AddWeaponSkillPoints(this, damslot, wspoints);
                    }
                }
            }
        }
        battleutils::ClaimMob(PBattleTarget, this);
    }
    else
    {
        actionList_t& actionList  = action.getNewActionList();
        actionList.ActionTargetID = PBattleTarget->id;
        action.actiontype         = ACTION_MAGIC_FINISH; // all "Too Far" messages use cat 4

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation       = 0x1FC; // Seems hardcoded, two bits away from 0x1FF
        actionTarget.messageID       = MSGBASIC_TOO_FAR_AWAY;

        // While it doesn't seem that speceffect is actually used at all in this "do nothing" animation, this is here for accuracy.
        if (isRangedWS) // Ranged WS seem to stay 0 on Reaction
        {
            actionTarget.speceffect = SPECEFFECT::NONE;
        }
        else // Always 2 observed on various melee weapons
        {
            actionTarget.speceffect = SPECEFFECT::BLOOD;
        }
    }

    PLatentEffectContainer->CheckLatentsWS(false);
}

void CCharEntity::OnAbility(CAbilityState& state, action_t& action)
{
    TracyZoneScoped;
    auto* PAbility = state.GetAbility();
    if (this->PRecastContainer->HasRecast(RECAST_ABILITY, PAbility->getRecastId(), PAbility->getRecastTime()))
    {
        pushPacket<CMessageBasicPacket>(this, this, 0, 0, MSGBASIC_WAIT_LONGER);
        return;
    }
    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_AMNESIA))
    {
        pushPacket<CMessageBasicPacket>(this, this, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2);
        return;
    }

    uint8 findFlags = 0;

    if ((PAbility->getValidTarget() & TARGET_PLAYER_DEAD) == TARGET_PLAYER_DEAD)
    {
        findFlags |= FINDFLAGS_DEAD;
    }

    auto* PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    PAI->TargetFind->reset();
    PAI->TargetFind->findSingleTarget(PTarget, findFlags, PAbility->getValidTarget());

    // Check if target is untargetable
    if (PAI->TargetFind->m_targets.size() == 0)
    {
        return;
    }

    std::unique_ptr<CBasicPacket> errMsg;
    if (IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
    {
        if (this != PTarget && distance(this->loc.p, PTarget->loc.p) > PAbility->getRange())
        {
            setActionInterrupted(action, PTarget, MSGBASIC_TOO_FAR_AWAY, 0);
            return;
        }

        // TODO: Remove me when all pet abilities are ported to PetSkill
        if (PAbility->getID() >= ABILITY_HEALING_RUBY && PAbility->getID() <= ABILITY_PERFECT_DEFENSE && !battleutils::GetPetSkill(PAbility->getID()))
        {
            // Blood pact MP costs are stored under animation ID
            float mpCost = PAbility->getAnimationID();
            if (StatusEffectContainer->HasStatusEffect(EFFECT_APOGEE))
            {
                mpCost *= 1.5f;
            }

            if (this->health.mp < mpCost)
            {
                setActionInterrupted(action, PTarget, MSGBASIC_UNABLE_TO_USE_JA, 0);
                return;
            }
        }

        if (battleutils::IsParalyzed(this))
        {
            setActionInterrupted(action, PTarget, MSGBASIC_IS_PARALYZED, 0);
            return;
        }

        // get any available merit recast reduction
        uint8 meritRecastReduction = 0;

        if (PAbility->getMeritModID() > 0 && !(PAbility->getAddType() & ADDTYPE_MERIT))
        {
            meritRecastReduction = PMeritPoints->GetMeritValue((MERIT_TYPE)PAbility->getMeritModID(), this);
        }

        auto* charge = ability::GetCharge(this, PAbility->getRecastId());
        if (charge && PAbility->getID() != ABILITY_SIC)
        {
            action.recast = charge->chargeTime * PAbility->getRecastTime() - meritRecastReduction;
        }
        else
        {
            action.recast = PAbility->getRecastTime() - meritRecastReduction;
        }

        if (PAbility->getID() == ABILITY_LIGHT_ARTS || PAbility->getID() == ABILITY_DARK_ARTS || PAbility->getRecastId() == 231) // stratagems
        {
            if (this->StatusEffectContainer->HasStatusEffect(EFFECT_TABULA_RASA))
            {
                action.recast = 0;
            }
        }
        else if (PAbility->getRecastId() == 173 || PAbility->getRecastId() == 174) // BP rage, BP ward
        {
            uint16 favorReduction          = 0;
            uint16 bloodPact_I_Reduction   = std::min<int16>(getMod(Mod::BP_DELAY), 15);
            uint16 bloodPact_II_Reduction  = std::min<int16>(getMod(Mod::BP_DELAY_II), 15);
            uint16 bloodPact_III_Reduction = 0; // std::min<int16>(getMod(Mod::BP_DELAY_III, 10); TODO: BP Delay III (SMN JP gift) not implemented

            CStatusEffect* avatarsFavor = this->StatusEffectContainer->GetStatusEffect(EFFECT_AVATARS_FAVOR);
            if (avatarsFavor)
            {
                favorReduction = std::min<int16>(avatarsFavor->GetPower(), 10);
            }

            int16 bloodPactDelayReduction = favorReduction + std::min<int16>(bloodPact_I_Reduction + bloodPact_II_Reduction + bloodPact_III_Reduction, 30);

            // Localvar will set the BP ability timer when the move consumes MP
            // The delay is snapshot when the player uses the ability: https://www.bg-wiki.com/ffxi/Blood_Pact_Ability_Delay
            this->SetLocalVar("bpRecastTime", static_cast<uint16>(std::max<int16>(0, action.recast - bloodPactDelayReduction)));

            // Recast is actually triggered when the bp goes off (no recast packet at all on using a bp and the target moving out of range of the pet)
            action.recast = 0;
        }

        // remove invisible if aggressive
        if (PAbility->getID() != ABILITY_TAME && PAbility->getID() != ABILITY_FIGHT && PAbility->getID() != ABILITY_DEPLOY && PAbility->getID() != ABILITY_GAUGE)
        {
            if (PAbility->getValidTarget() & TARGET_ENEMY)
            {
                if (PAbility->getID() == ABILITY_ASSAULT)
                {
                    StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_INVISIBLE);
                }
                // generic aggressive action
                else
                {
                    StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
                }
                StatusEffectContainer->DelStatusEffect(EFFECT_ILLUSION);
            }
            else if (PAbility->getID() != ABILITY_TRICK_ATTACK)
            {
                // remove invisible only
                StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_INVISIBLE);
                StatusEffectContainer->DelStatusEffect(EFFECT_ILLUSION);
            }
        }

        if (PAbility->getID() == ABILITY_REWARD)
        {
            CItem* PItem = getEquip(SLOT_HEAD);
            if (PItem && (PItem->getID() == 15157 || PItem->getID() == 15158 || PItem->getID() == 16104 || PItem->getID() == 16105))
            {
                // TODO: Transform this into an item Mod::REWARD_RECAST perhaps ?
                // The Bison/Brave's Warbonnet & Khimaira/Stout Bonnet reduces recast time by 10 seconds.
                action.recast -= 10; // remove 10 seconds
            }
        }
        else if (PAbility->getID() == ABILITY_READY || PAbility->getID() == ABILITY_SIC)
        {
            action.recast = static_cast<uint16>(std::max<int16>(0, action.recast - getMod(Mod::SIC_READY_RECAST)));
        }

        action.id         = this->id;
        action.actiontype = PAbility->getActionType();
        action.actionid   = PAbility->getID();

        // Normal AoE check,
        // Special cases go here
        auto isAbilityAoE = [&]() -> bool
        {
            if (this->PParty != nullptr)
            {
                if (PAbility->isAoE())
                {
                    return true;
                }
                else if (PAbility->getID() == ABILITY_LIEMENT && getMod(Mod::LIEMENT_EXTENDS_TO_AREA) > 0)
                {
                    return true;
                }
                else if (PAbility->getID() == ABILITY_HEALING_WALTZ && StatusEffectContainer->HasStatusEffect(EFFECT_CONTRADANCE))
                {
                    // 10.1 = 10' in game. Unsure why 10' means 9.9' works but 10' doesn't... Epsilon check gone wrong?
                    PAbility->setRange(10.1); // This is playing double duty as both target range and AoE range --
                                              // by the time this lambda is called the target range has already been checked and can be used normally
                    return true;
                }
            }

            return false;
        };

        // TODO: get rid of this to script, too
        if (PAbility->isPetAbility())
        {
            CPetEntity* PPetEntity = dynamic_cast<CPetEntity*>(PPet);
            CPetSkill*  PPetSkill  = battleutils::GetPetSkill(PAbility->getID());

            if (PPetEntity && PPetEntity->getPetType() != PET_TYPE::JUG_PET && PPetSkill) // is a real pet (not charmed or a jugpet which is mob-like) and has pet ability - don't display msg and notify pet
            {
                actionList_t& actionList     = action.getNewActionList();
                actionList.ActionTargetID    = PTarget->id;
                actionTarget_t& actionTarget = actionList.getNewActionTarget();
                actionTarget.animation       = 94; // assault anim
                actionTarget.reaction        = REACTION::NONE;
                actionTarget.speceffect      = SPECEFFECT::RECOIL;
                actionTarget.param           = 0;
                actionTarget.messageID       = 0;

                auto PPetTarget = PTarget->targid;

                PPetEntity->PAI->PetSkill(PPetTarget, PPetSkill->getID());
            }
            else if (PPet) // may be a bp, fallback - don't display msg and notify pet
            {
                actionList_t& actionList     = action.getNewActionList();
                actionList.ActionTargetID    = PTarget->id;
                actionTarget_t& actionTarget = actionList.getNewActionTarget();
                actionTarget.animation       = 94; // assault anim
                actionTarget.reaction        = REACTION::NONE;
                actionTarget.speceffect      = SPECEFFECT::RECOIL;
                actionTarget.param           = 0;
                actionTarget.messageID       = 0;

                auto PPetTarget = PTarget->targid;
                if (PAbility->getID() >= ABILITY_HEALING_RUBY && PAbility->getID() <= ABILITY_PERFECT_DEFENSE)
                {
                    // Blood Pact mp cost stored in animation ID
                    float mpCost = PAbility->getAnimationID();

                    if (StatusEffectContainer->HasStatusEffect(EFFECT_APOGEE))
                    {
                        mpCost *= 1.5f;
                        StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_BLOODPACT);
                        this->SetLocalVar("bpRecastTime", 0);
                    }

                    // Blood Boon (does not affect Astral Flow BPs)
                    if ((PAbility->getAddType() & ADDTYPE_ASTRAL_FLOW) == 0)
                    {
                        int16 bloodBoonRate = getMod(Mod::BLOOD_BOON);
                        if (xirand::GetRandomNumber(100) < bloodBoonRate)
                        {
                            mpCost *= xirand::GetRandomNumber(8.f, 16.f) / 16.f;
                        }
                    }

                    addMP((int32)-mpCost);
                    if (this->GetLocalVar("bpRecastTime") > 0) // This will go away when all smn petskills are handled via jobutils/summoner.lua
                    {
                        action.recast = this->GetLocalVar("bpRecastTime");
                    }

                    if (PAbility->getValidTarget() == TARGET_SELF)
                    {
                        PPetTarget = PPet->targid;
                    }
                }
                else if (PAbility->getID() >= ABILITY_CONCENTRIC_PULSE && PAbility->getID() <= ABILITY_RADIAL_ARCANA)
                {
                    // use the animation id to get the pet version of this ability
                    PAbility->setID(PAbility->getAnimationID());
                    action.actionid = PAbility->getAnimationID();

                    if (PAbility->getValidTarget() == TARGET_SELF)
                    {
                        PPetTarget = PPet->targid;
                    }
                }
                else
                {
                    auto* PMobSkill = battleutils::GetMobSkill(PAbility->getMobSkillID());
                    if (PMobSkill)
                    {
                        if (PMobSkill->getValidTargets() & TARGET_ENEMY)
                        {
                            PPetTarget = PPet->GetBattleTargetID();
                        }
                        else
                        {
                            PPetTarget = PPet->targid;
                        }
                    }
                }
                PPet->PAI->MobSkill(PPetTarget, PAbility->getMobSkillID());
            }
        }
        // TODO: make this generic enough to not require an if
        else if (isAbilityAoE())
        {
            PAI->TargetFind->reset();

            float distance = PAbility->getRange();

            PAI->TargetFind->findWithinArea(this, AOE_RADIUS::ATTACKER, distance, findFlags, PAbility->getValidTarget());

            uint16 prevMsg = 0;
            for (auto&& PTargetFound : PAI->TargetFind->m_targets)
            {
                actionList_t& actionList     = action.getNewActionList();
                actionList.ActionTargetID    = PTargetFound->id;
                actionTarget_t& actionTarget = actionList.getNewActionTarget();
                actionTarget.reaction        = REACTION::NONE;
                actionTarget.speceffect      = SPECEFFECT::NONE;
                actionTarget.animation       = PAbility->getAnimationID();
                actionTarget.messageID       = PAbility->getMessage();
                actionTarget.param           = 0;

                int32 value = luautils::OnUseAbility(this, PTargetFound, PAbility, &action);

                if (prevMsg == 0) // get default message for the first target
                {
                    actionTarget.messageID = PAbility->getMessage();
                }
                else // get AoE message for second, if there's a manual override, otherwise return message from PAbility->getMessage().
                {
                    actionTarget.messageID = PAbility->getAoEMsg();
                }

                actionTarget.param = value;

                if (value < 0)
                {
                    actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
                    actionTarget.param     = -actionTarget.param;
                }

                prevMsg = actionTarget.messageID;

                state.ApplyEnmity();
            }
        }
        else
        {
            actionList_t& actionList     = action.getNewActionList();
            actionList.ActionTargetID    = PTarget->id;
            actionTarget_t& actionTarget = actionList.getNewActionTarget();
            actionTarget.reaction        = REACTION::NONE;
            actionTarget.speceffect      = SPECEFFECT::RECOIL;
            actionTarget.animation       = PAbility->getAnimationID();
            actionTarget.param           = 0;
            uint16 prevMsg               = actionTarget.messageID;

            // Check for special situations from Steal (The Tenshodo Showdown quest)
            if (PAbility->getID() == ABILITY_STEAL)
            {
                // Force a specific result to be stolen based on the mob LUA
                actionTarget.param = luautils::OnSteal(this, PTarget, PAbility, &action);
            }

            int32 value = luautils::OnUseAbility(this, PTarget, PAbility, &action);

            if (prevMsg == actionTarget.messageID)
            {
                actionTarget.messageID = PAbility->getMessage();
            }

            if (actionTarget.messageID == 0)
            {
                actionTarget.messageID = MSGBASIC_USES_JA;
            }

            actionTarget.param = value;

            if (value < 0)
            {
                actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
                actionTarget.param     = -value;
            }

            state.ApplyEnmity();

            // Some mobs respond to abilities (ex. Absolute Virtue / Ob)
            for (CBattleEntity* PBattleEntity : *PNotorietyContainer)
            {
                if (CMobEntity* PMob = dynamic_cast<CMobEntity*>(PBattleEntity))
                {
                    if (PMob->getMobMod(MOBMOD_ABILITY_RESPONSE) && PMob->getZone() == this->getZone())
                    {
                        luautils::OnPlayerAbilityUse(PMob, this, PAbility);
                    }
                }
            }
        }

        // Cleanup "consumed" abilities after action like Contradance
        StatusEffectContainer->DelStatusEffect(PAbility->getPostActionEffectCleanup());

        if (charge)
        {
            PRecastContainer->Add(RECAST_ABILITY, PAbility->getRecastId(), action.recast, charge->chargeTime, charge->maxCharges);
        }
        else
        {
            PRecastContainer->Add(RECAST_ABILITY, PAbility->getRecastId(), action.recast);
        }

        uint16 recastID = PAbility->getRecastId();
        if (settings::get<bool>("map.BLOOD_PACT_SHARED_TIMER") && (recastID == 173 || recastID == 174))
        {
            PRecastContainer->Add(RECAST_ABILITY, (recastID == 173 ? 174 : 173), action.recast);
        }

        pushPacket<CCharRecastPacket>(this);

        // TODO: refactor
        //  if (this->getMijinGakure())
        //{
        //     m_ActionType = ACTION_FALL;
        //     ActionFall();
        // }
    }
    else if (errMsg)
    {
        pushPacket(std::move(errMsg));
    }
}

void CCharEntity::OnRangedAttack(CRangeState& state, action_t& action)
{
    TracyZoneScoped;
    auto* PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    if (battleutils::IsParalyzed(this))
    {
        // setup new action packet to send paralyze message
        action_t paralyze_action = {};
        setActionInterrupted(paralyze_action, PTarget, MSGBASIC_IS_PARALYZED, 0);
        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(paralyze_action));

        // Set up /ra action to be interrupted
        action.actiontype = ACTION_RANGED_INTERRUPT; // This handles some magic numbers in CActionPacket to cancel actions
        action.id         = id;

        actionList_t& actionList  = action.getNewActionList();
        actionList.ActionTargetID = id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation       = 0x1FC; // Seems hardcoded, two bits away from 0x1FF (0x1FC = 1 1111 1100)
        actionTarget.speceffect      = SPECEFFECT::RECOIL;
        actionTarget.reaction        = REACTION::NONE;

        return;
    }

    int32 damage      = 0;
    int32 totalDamage = 0;

    action.id         = id;
    action.actiontype = ACTION_RANGED_FINISH;

    actionList_t& actionList  = action.getNewActionList();
    actionList.ActionTargetID = PTarget->id;

    actionTarget_t& actionTarget = actionList.getNewActionTarget();
    actionTarget.reaction        = REACTION::HIT;   // 0x10
    actionTarget.speceffect      = SPECEFFECT::HIT; // 0x60 (SPECEFFECT_HIT + SPECEFFECT_RECOIL)
    actionTarget.messageID       = 352;

    CItemWeapon* PItem = (CItemWeapon*)this->getEquip(SLOT_RANGED);
    CItemWeapon* PAmmo = (CItemWeapon*)this->getEquip(SLOT_AMMO);

    bool  ammoThrowing   = PAmmo ? PAmmo->isThrowing() : false;
    bool  rangedThrowing = PItem ? PItem->isThrowing() : false;
    uint8 slot           = SLOT_RANGED;

    if (ammoThrowing)
    {
        slot  = SLOT_AMMO;
        PItem = nullptr;
    }
    if (rangedThrowing)
    {
        PAmmo = nullptr;
    }

    uint8 shadowsTaken = 0;
    uint8 hitCount     = 1; // 1 hit by default
    uint8 realHits     = 0; // to store the real number of hit for tp multiplier
    auto  ammoConsumed = 0;
    bool  hitOccured   = false; // track if player hit mob at all
    bool  isBarrage    = StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE, 0);

    // if barrage is detected, getBarrageShotCount also checks for ammo count
    if (!ammoThrowing && !rangedThrowing && isBarrage)
    {
        hitCount += battleutils::getBarrageShotCount(this);
    }
    else if (this->StatusEffectContainer->HasStatusEffect(EFFECT_DOUBLE_SHOT) && xirand::GetRandomNumber(100) < (40 + this->getMod(Mod::DOUBLE_SHOT_RATE)))
    {
        hitCount = 2;
    }
    else if (this->StatusEffectContainer->HasStatusEffect(EFFECT_TRIPLE_SHOT) && xirand::GetRandomNumber(100) < (40 + this->getMod(Mod::TRIPLE_SHOT_RATE)))
    {
        hitCount = 3;
    }

    // loop for barrage hits, if a miss occurs, the loop will end
    for (uint8 i = 1; i <= hitCount; ++i)
    {
        // TODO: add Barrage mod racc bonus
        if (xirand::GetRandomNumber(100) < battleutils::GetRangedHitRate(this, PTarget, isBarrage, 0)) // hit!
        {
            // absorbed by shadow
            if (battleutils::IsAbsorbByShadow(PTarget, this))
            {
                shadowsTaken++;
            }
            else
            {
                // TODO: add Barrage ratt bonus from job points
                bool  isCritical = xirand::GetRandomNumber(100) < battleutils::GetRangedCritHitRate(this, PTarget);
                float pdif       = battleutils::GetRangedDamageRatio(this, PTarget, isCritical, 0);

                if (isCritical)
                {
                    actionTarget.speceffect = SPECEFFECT::CRITICAL_HIT;
                    actionTarget.messageID  = 353;
                }

                // at least 1 hit occured
                hitOccured = true;
                realHits++;

                damage = (int32)((this->GetRangedWeaponDmg() + battleutils::GetFSTR(this, PTarget, slot)) * pdif);

                if (slot == SLOT_RANGED)
                {
                    if (PItem != nullptr)
                    {
                        charutils::TrySkillUP(this, (SKILLTYPE)PItem->getSkillType(), PTarget->GetMLevel());
                    }
                }
                else if (slot == SLOT_AMMO && PAmmo != nullptr)
                {
                    charutils::TrySkillUP(this, (SKILLTYPE)PAmmo->getSkillType(), PTarget->GetMLevel());
                }
                totalDamage += damage;
            }
        }
        else // miss
        {
            damage                  = 0;
            actionTarget.reaction   = REACTION::EVADE;
            actionTarget.speceffect = SPECEFFECT::NONE;
            actionTarget.messageID  = 354;
            hitCount                = i; // end barrage, shot missed
        }

        // check for recycle chance
        uint16 recycleChance = getMod(Mod::RECYCLE);
        if (charutils::hasTrait(this, TRAIT_RECYCLE))
        {
            recycleChance += PMeritPoints->GetMeritValue(MERIT_RECYCLE, this);
        }

        recycleChance += this->PJobPoints->GetJobPointValue(JP_AMMO_CONSUMPTION);

        if (this->StatusEffectContainer->HasStatusEffect(EFFECT_UNLIMITED_SHOT))
        {
            // Never consume ammo with Unlimited Shot active
            recycleChance = 100;
            // Only remove unlimited shot on hit
            if (hitOccured)
            {
                StatusEffectContainer->DelStatusEffect(EFFECT_UNLIMITED_SHOT);
            }
        }

        if (PAmmo != nullptr && xirand::GetRandomNumber(100) > recycleChance)
        {
            ++ammoConsumed;
            TrackArrowUsageForScavenge(PAmmo);
            if (PAmmo->getQuantity() == i)
            {
                hitCount = i;
            }
        }
    }

    // if a hit did occur (even without barrage)
    if (hitOccured)
    {
        // any misses with barrage cause remaining shots to miss, meaning we must check Action.reaction
        if ((actionTarget.reaction & REACTION::MISS) != REACTION::NONE && StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE))
        {
            actionTarget.messageID  = 352;
            actionTarget.reaction   = REACTION::HIT;
            actionTarget.speceffect = SPECEFFECT::CRITICAL_HIT;
        }

        if (slot == SLOT_RANGED)
        {
            auto attackType = (state.IsRapidShot()) ? PHYSICAL_ATTACK_TYPE::RAPID_SHOT : PHYSICAL_ATTACK_TYPE::RANGED;
            totalDamage     = attackutils::CheckForDamageMultiplier(this, PItem, totalDamage, attackType, slot, true);
        }
        actionTarget.param =
            battleutils::TakePhysicalDamage(this, PTarget, PHYSICAL_ATTACK_TYPE::RANGED, totalDamage, false, slot, realHits, nullptr, true, true);

        // absorb message
        if (actionTarget.param < 0)
        {
            actionTarget.param     = -(actionTarget.param);
            actionTarget.messageID = 382;
        }

        // add additional effects
        // this should go AFTER damage taken
        // or else sleep effect won't work
        // battleutils::HandleRangedAdditionalEffect(this,PTarget,&Action);
        // TODO: move all hard coded additional effect ammo to scripts
        if ((PAmmo != nullptr && battleutils::GetScaledItemModifier(this, PAmmo, Mod::ITEM_ADDEFFECT_TYPE) > 0) ||
            (PItem != nullptr && battleutils::GetScaledItemModifier(this, PItem, Mod::ITEM_ADDEFFECT_TYPE) > 0))
        {
            // TODO
        }
        luautils::additionalEffectAttack(this, PTarget, (PAmmo != nullptr ? PAmmo : PItem), &actionTarget, totalDamage);
    }
    else if (shadowsTaken > 0)
    {
        // shadows took damage
        actionTarget.messageID = MSGBASIC_SHADOW_ABSORB;
        actionTarget.reaction  = REACTION::EVADE;
        actionTarget.param     = shadowsTaken;
    }

    if (actionTarget.speceffect == SPECEFFECT::HIT && actionTarget.param > 0)
    {
        actionTarget.speceffect = SPECEFFECT::RECOIL;
    }

    // remove barrage effect if present
    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE, 0))
    {
        StatusEffectContainer->DelStatusEffect(EFFECT_BARRAGE, 0);
    }

    battleutils::ClaimMob(PTarget, this);
    battleutils::RemoveAmmo(this, ammoConsumed);

    // Handle Camouflage effects
    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_CAMOUFLAGE, 0))
    {
        int16 retainChance     = 40; // Estimate base ~40% chance to keep Camouflage on a ranged attack
        uint8 rotAllowance     = 25; // Allow for some slight variance in direction faced to be "behind" or "beside" the mob
        float distanceToTarget = distance(this->loc.p, PTarget->loc.p);
        float meleeRange       = PTarget->GetMeleeRange();

        if (isBarrage)
        {
            // Camouflage is never retained if Barrage is fired
            retainChance = 0;
        }
        else if (behind(this->loc.p, PTarget->loc.p, rotAllowance))
        {
            // Max melee distance + .6 = safe
            // Max melee distance + (.1~.5) = chance of deactivation
            // Under max melee distance = certain deactivation
            if (distanceToTarget > meleeRange + .6)
            {
                retainChance = 100;
            }
            else if (distanceToTarget > meleeRange + .1)
            {
                retainChance += 1.6 * distanceToTarget;
            }
            else
            {
                retainChance = 0;
            }
        }
        else if (beside(this->loc.p, PTarget->loc.p, rotAllowance))
        {
            // Max melee distance + 5 yalms = safe
            // (Max melee distance + 3.3) + (0.0~1.6) = chance of deactivation
            // Under Max melee distance + 3.3 = certain deactivation
            if (distanceToTarget > meleeRange + 5)
            {
                retainChance = 100;
            }
            else if (distanceToTarget > meleeRange + 3.3)
            {
                retainChance += 1.6 * distanceToTarget;
            }
            else
            {
                retainChance = 0;
            }
        }
        else
        {
            // Max melee distance + 8.1 yalms = safe
            // (Max melee distance + 7.1) + (0.0~.99) = chance of deactivation
            // Under Max melee distance + 7.1 = certain deactivation
            if (distanceToTarget > meleeRange + 8.1)
            {
                retainChance = 100;
            }
            else if (distanceToTarget > meleeRange + 7.1)
            {
                retainChance += 1.6 * distanceToTarget;
            }
            else
            {
                retainChance = 0;
            }
        }

        if (xirand::GetRandomNumber(100) > retainChance)
        {
            // Camouflage was up, but is lost, so now all detectable effects must be dropped
            StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
        }
        else
        {
            // Camouflage up, and retained, but all other effects must be dropped
            StatusEffectContainer->DelStatusEffect(EFFECT_SNEAK);
            StatusEffectContainer->DelStatusEffect(EFFECT_INVISIBLE);
            StatusEffectContainer->DelStatusEffect(EFFECT_DEODORIZE);
            StatusEffectContainer->DelStatusEffect(EFFECT_ILLUSION);
        }
    }
    else
    {
        // Camouflage not up, so remove all detectable status effects
        StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
    }
}

bool CCharEntity::IsMobOwner(CBattleEntity* PBattleTarget)
{
    TracyZoneScoped;

    if (PBattleTarget == nullptr)
    {
        ShowWarning("CCharEntity::IsMobOwner() - PBattleTarget was null.");
        return false;
    }

    if (PBattleTarget->m_OwnerID.id == 0 || PBattleTarget->m_OwnerID.id == this->id || PBattleTarget->objtype == TYPE_PC)
    {
        return true;
    }

    bool found = false;

    // clang-format off
    ForAlliance([&PBattleTarget, &found](CBattleEntity* PEntity)
    {
        if (PEntity->id == PBattleTarget->m_OwnerID.id)
        {
            found = true;
        }
    });
    // clang-format on

    return found;
}

void CCharEntity::HandleErrorMessage(std::unique_ptr<CBasicPacket>& msg)
{
    TracyZoneScoped;
    if (msg && !isCharmed)
    {
        pushPacket(std::move(msg));
    }
}

void CCharEntity::OnDeathTimer()
{
    TracyZoneScoped;
    charutils::SetCharVar(this, "expLost", 0);
    charutils::HomePoint(this, true);
}

void CCharEntity::OnRaise()
{
    TracyZoneScoped;
    // TODO: Moghancement Experience needs to be factored in here somewhere.
    if (m_hasRaise > 0)
    {
        // Player had no weakness prior, so set this to 1
        if (m_weaknessLvl == 0)
        {
            m_weaknessLvl = 1;
        }

        // add weakness effect (75% reduction in HP/MP)
        if (GetLocalVar("MijinGakure") == 0)
        {
            uint32 weaknessTime = 300;

            // Arise has a reduced weakness time of 3 mins
            if (m_hasArise)
            {
                weaknessTime = 180;
            }

            CStatusEffect* PWeaknessEffect = new CStatusEffect(EFFECT_WEAKNESS, EFFECT_WEAKNESS, m_weaknessLvl, 0, weaknessTime);
            StatusEffectContainer->AddStatusEffect(PWeaknessEffect);
        }

        double ratioReturned = 0.0f;
        uint16 hpReturned    = 1;

        action_t action;
        action.id          = id;
        action.actiontype  = ACTION_RAISE_MENU_SELECTION;
        auto& list         = action.getNewActionList();
        auto& actionTarget = list.getNewActionTarget();

        list.ActionTargetID = id;
        // Mijin Gakure used with MIJIN_RERAISE MOD
        if (GetLocalVar("MijinGakure") != 0 && getMod(Mod::MIJIN_RERAISE) != 0)
        {
            actionTarget.animation = 511;
            hpReturned             = (uint16)(GetMaxHP());
        }
        else if (m_hasRaise == 1)
        {
            actionTarget.animation = 511;
            hpReturned             = (uint16)((GetLocalVar("MijinGakure") != 0) ? GetMaxHP() * 0.5 : GetMaxHP() * 0.1);
            ratioReturned          = 0.50f * static_cast<double>(1 - settings::get<uint8>("map.EXP_RETAIN"));
        }
        else if (m_hasRaise == 2)
        {
            actionTarget.animation = 512;
            hpReturned             = (uint16)((GetLocalVar("MijinGakure") != 0) ? GetMaxHP() * 0.5 : GetMaxHP() * 0.25);
            ratioReturned          = ((GetMLevel() <= 50) ? 0.50f : 0.75f) * static_cast<double>(1 - settings::get<uint8>("map.EXP_RETAIN"));
        }
        else if (m_hasRaise == 3)
        {
            actionTarget.animation = 496;
            hpReturned             = (uint16)(GetMaxHP() * 0.5);
            ratioReturned          = ((GetMLevel() <= 50) ? 0.50f : 0.90f) * static_cast<double>(1 - settings::get<uint8>("map.EXP_RETAIN"));
        }
        else if (m_hasRaise == 4) // Used for spell "Arise" and Arise from the spell "Reraise IV"
        {
            actionTarget.animation = 496;
            hpReturned             = (uint16)GetMaxHP();
            ratioReturned          = ((GetMLevel() <= 50) ? 0.50f : 0.90f) * static_cast<double>(1 - settings::get<uint8>("map.EXP_RETAIN"));
        }

        addHP(((hpReturned < 1) ? 1 : hpReturned));
        updatemask |= UPDATE_HP;
        actionTarget.speceffect = SPECEFFECT::RAISE;

        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(action));

        // Do not return EXP to the player if they do not have experienceLost variable.
        uint16 expLost = charutils::GetCharVar(this, "expLost");

        if (expLost != 0)
        {
            uint16 xpReturned = (uint16)(ceil(expLost * ratioReturned));
            charutils::AddExperiencePoints(true, this, this, xpReturned);

            charutils::SetCharVar(this, "expLost", 0);
        }

        // If Arise was used then apply a reraise 3 effect on the target
        if (m_hasArise)
        {
            CStatusEffect* PReraiseEffect = new CStatusEffect(EFFECT_RERAISE, EFFECT_RERAISE, 3, 0, 3600);
            StatusEffectContainer->AddStatusEffect(PReraiseEffect);
        }

        SetLocalVar("MijinGakure", 0);
        m_hasArise = false;
        m_hasRaise = 0;
    }
}

void CCharEntity::OnItemFinish(CItemState& state, action_t& action)
{
    TracyZoneScoped;
    auto* PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    auto* PItem   = state.GetItem();

    if (!PItem->isType(ITEM_EQUIPMENT) && (PItem->getQuantity() < 1 || PItem->getReserve() > 0))
    {
        ShowWarning("OnItemFinish: %s attempted to use reserved/insufficient %s (%u).", this->getName(), PItem->getName(), PItem->getID());
        this->pushPacket<CMessageBasicPacket>(this, this, PItem->getID(), 0, MSGBASIC_ITEM_FAILS_TO_ACTIVATE);

        return;
    }

    // TODO: I'm sure this is supposed to be in the action packet... (animation, message)
    if (PItem->getAoE())
    {
        // clang-format off
        PTarget->ForParty([this, PItem, PTarget](CBattleEntity* PMember)
        {
            if (!PMember->isDead() && distance(PTarget->loc.p, PMember->loc.p) <= 10)
            {
                luautils::OnItemUse(this, PMember, PItem);
            }
        });
        // clang-format on
    }
    else
    {
        luautils::OnItemUse(this, PTarget, PItem);
    }

    action.id         = this->id;
    action.actiontype = ACTION_ITEM_FINISH;
    action.actionid   = PItem->getID();

    actionList_t& actionList  = action.getNewActionList();
    actionList.ActionTargetID = PTarget->id;

    actionTarget_t& actionTarget = actionList.getNewActionTarget();
    actionTarget.animation       = PItem->getAnimationID();

    if (PItem->isType(ITEM_EQUIPMENT))
    {
        if (PItem->getMaxCharges() > 1)
        {
            PItem->setCurrentCharges(PItem->getCurrentCharges() - 1);
        }
        PItem->setLastUseTime(CVanaTime::getInstance()->getVanaTime());

        char extra[sizeof(PItem->m_extra) * 2 + 1];
        _sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

        const char* Query = "UPDATE char_inventory "
                            "SET extra = '%s' "
                            "WHERE charid = %u AND location = %u AND slot = %u";

        _sql->Query(Query, extra, this->id, PItem->getLocationID(), PItem->getSlotID());

        if (PItem->getCurrentCharges() != 0)
        {
            this->PRecastContainer->Add(RECAST_ITEM, PItem->getSlotID() << 8 | PItem->getLocationID(),
                                        PItem->getReuseTime() / 1000); // add recast timer to Recast List from any bag
        }
    }
    else // unlock all items except equipment
    {
        PItem->setSubType(ITEM_UNLOCKED);

        charutils::UpdateItem(this, PItem->getLocationID(), PItem->getSlotID(), -1, true);
    }
}

CBattleEntity* CCharEntity::IsValidTarget(uint16 targid, uint16 validTargetFlags, std::unique_ptr<CBasicPacket>& errMsg)
{
    TracyZoneScoped;
    auto* PTarget = CBattleEntity::IsValidTarget(targid, validTargetFlags, errMsg);
    if (PTarget)
    {
        if (PTarget->objtype == TYPE_PC && charutils::IsAidBlocked(this, static_cast<CCharEntity*>(PTarget)))
        {
            // Target is blocking assistance
            errMsg = std::make_unique<CMessageSystemPacket>(0, 0, MsgStd::TargetIsCurrentlyBlocking);
            // Interaction was blocked
            static_cast<CCharEntity*>(PTarget)->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::BlockedByBlockaid);
        }
        else if (IsMobOwner(PTarget))
        {
            if (PTarget->isAlive() || (validTargetFlags & TARGET_PLAYER_DEAD) != 0)
            {
                return PTarget;
            }
            else
            {
                errMsg = std::make_unique<CMessageBasicPacket>(this, this, 0, 0, MSGBASIC_CANNOT_ON_THAT_TARG);
            }
        }
        else
        {
            errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_ALREADY_CLAIMED);
        }
    }
    else
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, this, 0, 0, MSGBASIC_CANNOT_ATTACK_TARGET);
    }
    return nullptr;
}

void CCharEntity::Die()
{
    TracyZoneScoped;
    if (PLastAttacker)
    {
        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, std::make_unique<CMessageBasicPacket>(PLastAttacker, this, 0, 0, MSGBASIC_PLAYER_DEFEATED_BY));
    }
    else
    {
        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, std::make_unique<CMessageBasicPacket>(this, this, 0, 0, MSGBASIC_FALLS_TO_GROUND));
    }

    battleutils::RelinquishClaim(this);

    if (this->PPet)
    {
        petutils::DespawnPet(this);
    }

    Die(death_duration);
    SetDeathTimestamp((uint32)time(nullptr));

    setBlockingAid(false);

    // influence for conquest system
    conquest::LoseInfluencePoints(this);

    if (GetLocalVar("MijinGakure") == 0 &&
        (PBattlefield == nullptr || (PBattlefield->GetRuleMask() & RULES_LOSE_EXP) == RULES_LOSE_EXP) &&
        GetMLevel() >= settings::get<uint8>("map.EXP_LOSS_LEVEL"))
    {
        float retainPercent = std::clamp(settings::get<uint8>("map.EXP_RETAIN") + getMod(Mod::EXPERIENCE_RETAINED) / 100.0f, 0.0f, 1.0f);
        charutils::DelExperiencePoints(this, retainPercent, 0);
    }

    luautils::OnPlayerDeath(this);
}

void CCharEntity::Die(duration _duration)
{
    TracyZoneScoped;
    this->ClearTrusts();

    if (StatusEffectContainer->HasStatusEffect(EFFECT_WEAKNESS))
    {
        // Remove weakness effect as per retail but keep track of weakness
        StatusEffectContainer->DelStatusEffectSilent(EFFECT_WEAKNESS);
        // Increase the weakness counter if previously weakened
        m_weaknessLvl++;
    }
    else
    {
        // Reset weakness here, then +1 it on raise as we had no weakness prior
        m_weaknessLvl = 0;
    }

    m_deathSyncTime = server_clock::now() + death_update_frequency;
    PAI->ClearStateStack();
    PAI->Internal_Die(_duration);

    // If player allegiance is not reset on death they will auto-homepoint
    allegiance = ALLEGIANCE_TYPE::PLAYER;

    // reraise modifiers
    if (this->getMod(Mod::RERAISE_I) > 0)
    {
        m_hasRaise = 1;
    }

    if (this->getMod(Mod::RERAISE_II) > 0)
    {
        m_hasRaise = 2;
    }

    if (this->getMod(Mod::RERAISE_III) > 0)
    {
        m_hasRaise = 3;
    }
    // MIJIN_RERAISE checks
    if (m_hasRaise == 0 && this->getMod(Mod::MIJIN_RERAISE) > 0)
    {
        m_hasRaise = 1;
    }

    this->m_charHistory.timesKnockedOut++;

    CBattleEntity::Die();
}

void CCharEntity::Raise()
{
    TracyZoneScoped;
    PAI->Internal_Raise();
    SetDeathTimestamp(0);
}

void CCharEntity::SetDeathTimestamp(uint32 timestamp)
{
    m_DeathTimestamp = timestamp;
}

int32 CCharEntity::GetSecondsElapsedSinceDeath() const
{
    return m_DeathTimestamp > 0 ? (uint32)time(nullptr) - m_DeathTimestamp : 0;
}

int32 CCharEntity::GetTimeRemainingUntilDeathHomepoint() const
{
    // 0x0003A020 is 60 * 3960 and 3960 is 66 minutes in seconds
    // The client uses this time as the maximum amount of time for death
    // We convert the elapsed death time to this total time and subtract it which gives us the remaining time to a forced homepoint
    // Once the returned value here reaches below 360 then the client with force homepoint the character
    return 0x0003A020 - (60 * GetSecondsElapsedSinceDeath());
}

int32 CCharEntity::GetTimeCreated()
{
    TracyZoneScoped;
    const char* fmtQuery = "SELECT UNIX_TIMESTAMP(timecreated) FROM chars WHERE charid = %u";

    int32 ret = _sql->Query(fmtQuery, id);

    if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
    {
        return _sql->GetIntData(0);
    }

    return 0;
}

uint8 CCharEntity::getHighestJobLevel()
{
    uint8 maxJobLevel = 0;

    for (uint8 jobId = 0; jobId < MAX_JOBTYPE; jobId++)
    {
        if (jobs.job[jobId] > maxJobLevel)
        {
            maxJobLevel = jobs.job[jobId];
        }
    }

    return maxJobLevel;
}

bool CCharEntity::hasMoghancement(uint16 moghancementID) const
{
    return m_moghancementID == moghancementID;
}

void CCharEntity::UpdateMoghancement()
{
    TracyZoneScoped;

    // Add up all of the installed furniture auras
    std::array<uint16, 8> elements = { 0 };
    for (auto containerID : { LOC_MOGSAFE, LOC_MOGSAFE2 })
    {
        CItemContainer* PContainer = getStorage(containerID);
        for (int slotID = 1; slotID <= PContainer->GetSize(); ++slotID)
        {
            CItem* PItem = PContainer->GetItem(slotID);
            if (PItem != nullptr && PItem->isType(ITEM_FURNISHING))
            {
                CItemFurnishing* PFurniture = static_cast<CItemFurnishing*>(PItem);
                if (PFurniture->isInstalled() && !PFurniture->getOn2ndFloor())
                {
                    elements[PFurniture->getElement() - 1] += PFurniture->getAura();
                }
            }
        }
    }

    // Determine the dominant aura
    uint8  dominantElement = 0;
    uint16 dominantAura    = 0;
    bool   hasTiedElements = false;
    for (uint8 elementID = 1; elementID < 9; ++elementID)
    {
        uint16 aura = elements[elementID - 1];
        if (aura > dominantAura)
        {
            dominantElement = elementID;
            dominantAura    = aura;
            hasTiedElements = false;
        }
        else if (aura == dominantAura)
        {
            hasTiedElements = true;
        }
    }

    // Determine which moghancement to use from the dominant element
    uint8  bestAura          = 0;
    uint8  bestOrder         = 255;
    uint16 newMoghancementID = 0;
    if (!hasTiedElements && dominantAura > 0)
    {
        for (auto containerID : { LOC_MOGSAFE, LOC_MOGSAFE2 })
        {
            CItemContainer* PContainer = getStorage(containerID);
            for (int slotID = 1; slotID <= PContainer->GetSize(); ++slotID)
            {
                CItem* PItem = PContainer->GetItem(slotID);
                if (PItem != nullptr && PItem->isType(ITEM_FURNISHING))
                {
                    CItemFurnishing* PFurniture = static_cast<CItemFurnishing*>(PItem);
                    // If aura is tied then use whichever furniture was placed most recently
                    if (PFurniture->isInstalled() && !PFurniture->getOn2ndFloor() && PFurniture->getElement() == dominantElement &&
                        (PFurniture->getAura() > bestAura || (PFurniture->getAura() == bestAura && PFurniture->getOrder() < bestOrder)))
                    {
                        bestAura          = PFurniture->getAura();
                        bestOrder         = PFurniture->getOrder();
                        newMoghancementID = PFurniture->getMoghancement();
                    }
                }
            }
        }
    }

    // Always show which moghancement the player has if they have one at all
    if (newMoghancementID != 0)
    {
        pushPacket<CMessageSpecialPacket>(this, luautils::GetTextIDVariable(getZone(), "KEYITEM_OBTAINED"), newMoghancementID, 0, 0, 0, false);
    }

    if (newMoghancementID != m_moghancementID)
    {
        // Remove the previous moghancement
        if (m_moghancementID != 0)
        {
            charutils::delKeyItem(this, m_moghancementID);
        }

        // Add the new moghancement
        if (newMoghancementID != 0)
        {
            charutils::addKeyItem(this, newMoghancementID);
        }

        // Send only one key item packet if they are in the same key item table
        uint8 newTable     = newMoghancementID >> 9;
        uint8 currentTable = m_moghancementID >> 9;
        if (newTable == currentTable)
        {
            pushPacket<CKeyItemsPacket>(this, (KEYS_TABLE)newTable);
        }
        else
        {
            if (newTable != 0)
            {
                pushPacket<CKeyItemsPacket>(this, (KEYS_TABLE)newTable);
            }
            if (currentTable != 0)
            {
                pushPacket<CKeyItemsPacket>(this, (KEYS_TABLE)currentTable);
            }
        }
        charutils::SaveKeyItems(this);

        SetMoghancement(newMoghancementID);
        charutils::SaveCharMoghancement(this);
    }
}

void CCharEntity::SetMoghancement(uint16 moghancementID)
{
    // Remove the previous Moghancement first
    changeMoghancement(m_moghancementID, false);
    changeMoghancement(moghancementID, true);
    m_moghancementID = moghancementID;
}

void CCharEntity::changeMoghancement(uint16 moghancementID, bool isAdding)
{
    TracyZoneScoped;
    if (moghancementID == 0)
    {
        return;
    }

    // Apply the Moghancement
    int16 multiplier = isAdding ? 1 : -1;
    switch (moghancementID)
    {
        case MOGHANCEMENT_FIRE:
            addModifier(Mod::SYNTH_MATERIAL_LOSS_FIRE, 5 * multiplier);
            break;
        case MOGHANCEMENT_ICE:
            addModifier(Mod::SYNTH_MATERIAL_LOSS_ICE, 5 * multiplier);
            break;
        case MOGHANCEMENT_WIND:
            addModifier(Mod::SYNTH_MATERIAL_LOSS_WIND, 5 * multiplier);
            break;
        case MOGHANCEMENT_EARTH:
            addModifier(Mod::SYNTH_MATERIAL_LOSS_EARTH, 5 * multiplier);
            break;
        case MOGHANCEMENT_LIGHTNING:
            addModifier(Mod::SYNTH_MATERIAL_LOSS_THUNDER, 5 * multiplier);
            break;
        case MOGHANCEMENT_WATER:
            addModifier(Mod::SYNTH_MATERIAL_LOSS_WATER, 5 * multiplier);
            break;
        case MOGHANCEMENT_LIGHT:
            addModifier(Mod::SYNTH_MATERIAL_LOSS_LIGHT, 5 * multiplier);
            break;
        case MOGHANCEMENT_DARK:
            addModifier(Mod::SYNTH_MATERIAL_LOSS_DARK, 5 * multiplier);
            break;

        case MOGHANCEMENT_FISHING:
            addModifier(Mod::FISH, 1 * multiplier);
            break;
        case MOGHANCEMENT_WOODWORKING:
            addModifier(Mod::WOOD, 1 * multiplier);
            break;
        case MOGHANCEMENT_SMITHING:
            addModifier(Mod::SMITH, 1 * multiplier);
            break;
        case MOGHANCEMENT_GOLDSMITHING:
            addModifier(Mod::GOLDSMITH, 1 * multiplier);
            break;
        case MOGHANCEMENT_CLOTHCRAFT:
            addModifier(Mod::CLOTH, 1 * multiplier);
            break;
        case MOGHANCEMENT_LEATHERCRAFT:
            addModifier(Mod::LEATHER, 1 * multiplier);
            break;
        case MOGHANCEMENT_BONECRAFT:
            addModifier(Mod::BONE, 1 * multiplier);
            break;
        case MOGHANCEMENT_ALCHEMY:
            addModifier(Mod::ALCHEMY, 1 * multiplier);
            break;
        case MOGHANCEMENT_COOKING:
            addModifier(Mod::COOK, 1 * multiplier);
            break;

        case MOGLIFICATION_FISHING:
            addModifier(Mod::FISH, 1 * multiplier);
            // TODO: "makes it slightly easier to reel in your catch"
            break;
        case MOGLIFICATION_WOODWORKING:
            addModifier(Mod::WOOD, 1 * multiplier);
            addModifier(Mod::SYNTH_MATERIAL_LOSS_WOODWORKING, 5 * multiplier);
            break;
        case MOGLIFICATION_SMITHING:
            addModifier(Mod::SMITH, 1 * multiplier);
            addModifier(Mod::SYNTH_MATERIAL_LOSS_SMITHING, 5 * multiplier);
            break;
        case MOGLIFICATION_GOLDSMITHING:
            addModifier(Mod::GOLDSMITH, 1 * multiplier);
            addModifier(Mod::SYNTH_MATERIAL_LOSS_GOLDSMITHING, 5 * multiplier);
            break;
        case MOGLIFICATION_CLOTHCRAFT:
            addModifier(Mod::CLOTH, 1 * multiplier);
            addModifier(Mod::SYNTH_MATERIAL_LOSS_CLOTHCRAFT, 5 * multiplier);
            break;
        case MOGLIFICATION_LEATHERCRAFT:
            addModifier(Mod::LEATHER, 1 * multiplier);
            addModifier(Mod::SYNTH_MATERIAL_LOSS_LEATHERCRAFT, 5 * multiplier);
            break;
        case MOGLIFICATION_BONECRAFT:
            addModifier(Mod::BONE, 1 * multiplier);
            addModifier(Mod::SYNTH_MATERIAL_LOSS_BONECRAFT, 5 * multiplier);
            break;
        case MOGLIFICATION_ALCHEMY:
            addModifier(Mod::ALCHEMY, 1 * multiplier);
            addModifier(Mod::SYNTH_MATERIAL_LOSS_ALCHEMY, 5 * multiplier);
            break;
        case MOGLIFICATION_COOKING:
            addModifier(Mod::COOK, 1 * multiplier);
            addModifier(Mod::SYNTH_MATERIAL_LOSS_COOKING, 5 * multiplier);
            break;

        // Mega Moglifications do not state anything about lowering material loss.
        case MEGA_MOGLIFICATION_FISHING:
            addModifier(Mod::FISH, 5 * multiplier);
            break;
        case MEGA_MOGLIFICATION_WOODWORKING:
            addModifier(Mod::WOOD, 5 * multiplier);
            break;
        case MEGA_MOGLIFICATION_SMITHING:
            addModifier(Mod::SMITH, 5 * multiplier);
            break;
        case MEGA_MOGLIFICATION_GOLDSMITHING:
            addModifier(Mod::GOLDSMITH, 5 * multiplier);
            break;
        case MEGA_MOGLIFICATION_CLOTHCRAFT:
            addModifier(Mod::CLOTH, 5 * multiplier);
            break;
        case MEGA_MOGLIFICATION_LEATHERCRAFT:
            addModifier(Mod::LEATHER, 5 * multiplier);
            break;
        case MEGA_MOGLIFICATION_BONECRAFT:
            addModifier(Mod::BONE, 5 * multiplier);
            break;
        case MEGA_MOGLIFICATION_ALCHEMY:
            addModifier(Mod::ALCHEMY, 5 * multiplier);
            break;
        case MEGA_MOGLIFICATION_COOKING:
            addModifier(Mod::COOK, 5 * multiplier);
            break;

        case MOGHANCEMENT_EXPERIENCE:
            addModifier(Mod::EXPERIENCE_RETAINED, 5 * multiplier);
            break;
        case MOGHANCEMENT_GARDENING:
            addModifier(Mod::GARDENING_WILT_BONUS, 36 * multiplier);
            break;
        case MOGHANCEMENT_DESYNTHESIS:
            addModifier(Mod::SYNTH_SUCCESS_RATE_DESYNTHESIS, 2 * multiplier);
            break;
        case MOGHANCEMENT_CONQUEST:
            addModifier(Mod::CONQUEST_BONUS, 6 * multiplier);
            break;
        case MOGHANCEMENT_REGION:
            addModifier(Mod::CONQUEST_REGION_BONUS, 10 * multiplier);
            break;
        case MOGHANCEMENT_FISHING_ITEM:
            // TODO: Increases the chances of finding items when fishing
            break;
        case MOGHANCEMENT_SANDORIA_CONQUEST:
            if (profile.nation == 0)
            {
                addModifier(Mod::CONQUEST_BONUS, 6 * multiplier);
            }
            break;
        case MOGHANCEMENT_BASTOK_CONQUEST:
            if (profile.nation == 1)
            {
                addModifier(Mod::CONQUEST_BONUS, 6 * multiplier);
            }
            break;
        case MOGHANCEMENT_WINDURST_CONQUEST:
            if (profile.nation == 2)
            {
                addModifier(Mod::CONQUEST_BONUS, 6 * multiplier);
            }
            break;
        case MOGHANCEMENT_MONEY:
            addModifier(Mod::GILFINDER, 10 * multiplier);
            break;
        case MOGHANCEMENT_CAMPAIGN:
            addModifier(Mod::CAMPAIGN_BONUS, 5 * multiplier);
            break;
        case MOGHANCEMENT_MONEY_II:
            addModifier(Mod::GILFINDER, 15 * multiplier);
            break;
        case MOGHANCEMENT_SKILL_GAINS:
            // NOTE: Exact value is unknown but considering this only granted by a newish item it makes sense SE made it fairly strong
            addModifier(Mod::COMBAT_SKILLUP_RATE, 25 * multiplier);
            addModifier(Mod::MAGIC_SKILLUP_RATE, 25 * multiplier);
            break;
        case MOGHANCEMENT_BOUNTY:
            addModifier(Mod::EXP_BONUS, 10 * multiplier);
            addModifier(Mod::CAPACITY_BONUS, 10 * multiplier);
            break;
        case MOGLIFICATION_EXPERIENCE_BOOST:
            addModifier(Mod::EXP_BONUS, 15 * multiplier);
            break;
        case MOGLIFICATION_CAPACITY_BOOST:
            addModifier(Mod::CAPACITY_BONUS, 15 * multiplier);
            break;

        // NOTE: Exact values for resistances is unknown
        case MOGLIFICATION_RESIST_DEATH:
            addModifier(Mod::DEATHRES, 10 * multiplier);
            break;
        case MOGLIFICATION_RESIST_SLEEP:
            addModifier(Mod::SLEEPRES, 10 * multiplier);
            break;
        case MOGLIFICATION_RESIST_POISON:
            addModifier(Mod::POISONRES, 10 * multiplier);
            break;
        case MOGLIFICATION_RESIST_PARALYSIS:
            addModifier(Mod::PARALYZERES, 10 * multiplier);
            break;
        case MOGLIFICATION_RESIST_SILENCE:
            addModifier(Mod::SILENCERES, 10 * multiplier);
            break;
        case MOGLIFICATION_RESIST_PETRIFICATION:
            addModifier(Mod::PETRIFYRES, 10 * multiplier);
            break;
        case MOGLIFICATION_RESIST_VIRUS:
            addModifier(Mod::VIRUSRES, 10 * multiplier);
            break;
        case MOGLIFICATION_RESIST_CURSE:
            addModifier(Mod::CURSERES, 10 * multiplier);
            break;
        default:
            break;
    }
}

void CCharEntity::TrackArrowUsageForScavenge(CItemWeapon* PAmmo)
{
    TracyZoneScoped;
    // Check if local has been set yet
    if (this->GetLocalVar("ArrowsUsed") == 0)
    {
        // Local not set yet so set
        this->SetLocalVar("ArrowsUsed", PAmmo->getID() * 10000 + 1);
    }
    else
    {
        // Local exists now check if arrow used is same as last time
        if ((floor(this->GetLocalVar("ArrowsUsed") / 10000)) == PAmmo->getID())
        {
            // Same arrow used as last time now check that arrows used do not go above 1980
            if (!(floor(this->GetLocalVar("ArrowsUsed") % 10000) >= 1980))
            {
                // Safe to increment arrows used
                this->SetLocalVar("ArrowsUsed", this->GetLocalVar("ArrowsUsed") + 1);
            }
        }
        else
        {
            // Different arrow is being used so remake local
            this->SetLocalVar("ArrowsUsed", PAmmo->getID() * 10000 + 1);
        }
    }
}

bool CCharEntity::OnAttackError(CAttackState& state)
{
    TracyZoneScoped;
    auto* controller{ static_cast<CPlayerController*>(PAI->GetController()) };
    if (controller->getLastErrMsgTime() + std::chrono::milliseconds(this->GetWeaponDelay(false)) < PAI->getTick())
    {
        controller->setLastErrMsgTime(PAI->getTick());
        return true;
    }
    return false;
}

bool CCharEntity::isInTriggerArea(uint32 triggerAreaID)
{
    return charTriggerAreaIDs.find(triggerAreaID) != charTriggerAreaIDs.end();
}

void CCharEntity::onTriggerAreaEnter(uint32 triggerAreaID)
{
    charTriggerAreaIDs.insert(triggerAreaID);
}

void CCharEntity::onTriggerAreaLeave(uint32 triggerAreaID)
{
    charTriggerAreaIDs.erase(triggerAreaID);
}

void CCharEntity::clearTriggerAreas()
{
    charTriggerAreaIDs.clear();
}

bool CCharEntity::isInEvent()
{
    return currentEvent->eventId != -1;
}

bool CCharEntity::isNpcLocked()
{
    return isInEvent() || inSequence;
}

void CCharEntity::endCurrentEvent()
{
    currentEvent->reset();
    eventPreparation->reset();
    setLocked(false);
    m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
    tryStartNextEvent();
}

void CCharEntity::queueEvent(EventInfo* eventToQueue)
{
    for (auto& eventElement : eventQueue)
    {
        if (eventElement->eventId == eventToQueue->eventId)
        {
            ShowError("CCharEntity::queueEvent: Character attempted to start multiple of the same event.");
            return;
        }
    }

    eventQueue.emplace_back(eventToQueue);
    tryStartNextEvent();
}

void CCharEntity::tryStartNextEvent()
{
    TracyZoneScoped;
    if (isInEvent() || eventQueue.empty())
        return;

    EventInfo* oldEvent = currentEvent;
    currentEvent        = eventQueue.front();
    eventQueue.pop_front();
    destroy(oldEvent);

    eventPreparation->reset();

    m_Substate = CHAR_SUBSTATE::SUBSTATE_IN_CS;
    if (animation == ANIMATION_HEALING)
    {
        StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
    }

    if (PPet)
    {
        PPet->PAI->Disengage();
    }

    auto PNpc = currentEvent->targetEntity;
    if (PNpc && PNpc->objtype == TYPE_NPC)
    {
        PNpc->SetLocalVar("pauseNPCPathing", 1);
    }

    // If it's a cutscene, we lock the player immediately
    setLocked(currentEvent->type == CUTSCENE);

    if (currentEvent->strings.empty())
    {
        pushPacket<CEventPacket>(this, currentEvent);
    }
    else
    {
        pushPacket<CEventStringPacket>(this, currentEvent);
    }
}

void CCharEntity::skipEvent()
{
    TracyZoneScoped;
    if (!m_Locked && !isInEvent() && (!currentEvent->cutsceneOptions.empty() || currentEvent->interruptText != 0))
    {
        pushPacket<CMessageSystemPacket>(0, 0, MsgStd::EventSkipped);
        pushPacket<CReleasePacket>(this, RELEASE_TYPE::SKIPPING);
        m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;

        if (currentEvent->interruptText != 0)
        {
            pushPacket<CMessageTextPacket>(currentEvent->targetEntity, currentEvent->interruptText, false);
        }

        endCurrentEvent();
    }
}

void CCharEntity::setLocked(bool locked)
{
    TracyZoneScoped;
    m_Locked = locked;
    if (locked)
    {
        // Player and pet enmity are handled in mobcontroler.cpp, CheckLock() fucntion.
        // Mob casting interruption handled in magic_state.cpp, CMagicState::Update boolean.
        PAI->Disengage();
        if (PPet)
        {
            PPet->PAI->Disengage();
        }
        battleutils::RelinquishClaim(this);
    }
}

int32 CCharEntity::getCharVar(std::string const& charVarName)
{
    if (auto charVar = charVarCache.find(charVarName); charVar != charVarCache.end())
    {
        std::pair cachedVarData    = charVar->second;
        uint32    currentTimestamp = CVanaTime::getInstance()->getSysTime();

        // If the cached variable is not expired, return it.  Else, fall through so that the
        // database can be cleaned up.
        if (cachedVarData.second == 0 || cachedVarData.second > currentTimestamp)
        {
            return cachedVarData.first;
        }
    }

    auto value = charutils::FetchCharVar(this->id, charVarName);

    charVarCache[charVarName] = value;
    return value.first;
}

void CCharEntity::setCharVar(std::string const& charVarName, int32 value, uint32 expiry /* = 0 */)
{
    charVarCache[charVarName] = { value, expiry };
    charutils::PersistCharVar(this->id, charVarName, value, expiry);
}

void CCharEntity::setVolatileCharVar(std::string const& charVarName, int32 value, uint32 expiry /* = 0 */)
{
    charVarCache[charVarName] = { value, expiry };
    charVarChanges.insert(charVarName);
}

void CCharEntity::updateCharVarCache(std::string const& charVarName, int32 value, uint32 expiry /* = 0 */)
{
    charVarCache[charVarName] = { value, expiry };
}

void CCharEntity::removeFromCharVarCache(std::string const& varName)
{
    charVarCache.erase(varName);
}

void CCharEntity::clearCharVarsWithPrefix(std::string const& prefix)
{
    if (prefix.size() < 5)
    {
        ShowError("Prefix too short to clear with: '%s'", prefix);
        return;
    }

    auto iter = charVarCache.begin();
    while (iter != charVarCache.end())
    {
        if (iter->first.rfind(prefix, 0) == 0)
        {
            iter->second = { 0, 0 };
        }
        ++iter;
    }

    _sql->Query("DELETE FROM char_vars WHERE charid = %u AND varname LIKE '%s%%'", this->id, prefix.c_str());
}
