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

#include "item_equipment.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/utils.h"
#include "exdata/augment_standard.h"
#include "exdata/augment_trial.h"

#include <cstring>

namespace
{

/*
From augments.sql:

`augmentId` smallint(5) unsigned NOT NULL,
`multiplier` smallint(2) NOT NULL DEFAULT 0,
`modId` smallint(5) unsigned NOT NULL DEFAULT 0,
`value` smallint(5) NOT NULL DEFAULT 0,
`isPet` tinyint(1) NOT NULL DEFAULT 0,
`petType` tinyint(3) unsigned NOT NULL DEFAULT 0,
*/
struct AugmentDataRow
{
    uint16 augmentId;
    uint16 multiplier;
    uint16 modId;
    int16  value; // Can be negative
    uint8  isPet;
    uint8  petType;
};

using AugmentDataRows = std::vector<AugmentDataRow>;
std::unordered_map<uint16, AugmentDataRows> sAugmentData;

} // namespace

void CItemEquipment::LoadAugmentData()
{
    const auto rset = db::preparedStmt("SELECT `augmentId`, `multiplier`, `modId`, `value`, `isPet`, `petType` FROM `augments`");
    if (rset)
    {
        while (rset->next())
        {
            const auto augmentId = rset->get<uint16>("augmentId");

            AugmentDataRow augmentData = {
                .augmentId  = augmentId,
                .multiplier = rset->get<uint16>("multiplier"),
                .modId      = rset->get<uint16>("modId"),
                .value      = rset->get<int16>("value"),
                .isPet      = rset->get<uint8>("isPet"),
                .petType    = rset->get<uint8>("petType"),
            };

            sAugmentData[augmentId].push_back(augmentData);
        }
    }
}

CItemEquipment::CItemEquipment(uint16 id)
: CItemUsable(id)
{
    setType(ITEM_EQUIPMENT);

    m_jobs             = 0;
    m_modelID          = 0;
    m_removeSlotID     = 0;
    m_removeSlotLookID = 0;
    m_shieldSize       = 0;
    m_scriptType       = 0;
    m_reqLvl           = 255;
    m_iLvl             = 0;
    m_equipSlotID      = 255;
    m_absorption       = 0;
    m_superiorLevel    = 0;
}

CItemEquipment::CItemEquipment(const CItemEquipment& other)
: CItemUsable(other)
, modList(other.modList)
, petModList(other.petModList)
, latentList(other.latentList)
, m_reqLvl(other.m_reqLvl)
, m_iLvl(other.m_iLvl)
, m_jobs(other.m_jobs)
, m_modelID(other.m_modelID)
, m_scriptType(other.m_scriptType)
, m_shieldSize(other.m_shieldSize)
, m_absorption(other.m_absorption)
, m_equipSlotID(other.m_equipSlotID)
, m_removeSlotID(other.m_removeSlotID)
, m_removeSlotLookID(other.m_removeSlotLookID)
, m_superiorLevel(other.m_superiorLevel)
{
}

CItemEquipment::~CItemEquipment()
{
}

uint16 CItemEquipment::getModelId() const
{
    return m_modelID;
}

uint8 CItemEquipment::getShieldSize() const
{
    return m_shieldSize;
}

uint16 CItemEquipment::getEquipSlotId() const
{
    return m_equipSlotID;
}

/// <summary>
/// Gets the equip slots which should be unequipped when the item is equipped
/// Used for items which occupy multiple equipslots - eg. Cloaks which occupy body and head
/// </summary>
/// <returns>An integer representing a bitmask corresponding to BattleEntity SLOTTYPE</returns>
uint16 CItemEquipment::getRemoveSlotId() const
{
    return m_removeSlotID;
}

/// <summary>
/// Gets the equip slots which should be set to blank from the characters appearance when the item is equipped or lockstyled
/// Used for items which occupy multiple appearance slots
/// eg. Mandragora Suit which has a getRemoveSlotId of body and legs - but appearance wise occupies hands, body, legs, and feet
/// </summary>
/// <returns>An integer representing a bitmask corresponding to BattleEntity SLOTTYPE</returns>
uint16 CItemEquipment::getRemoveSlotLookId() const
{
    return m_removeSlotLookID;
}

uint8 CItemEquipment::getReqLvl() const
{
    return m_reqLvl;
}

uint8 CItemEquipment::getILvl() const
{
    return m_iLvl;
}

uint32 CItemEquipment::getJobs() const
{
    return m_jobs;
}

void CItemEquipment::setReqLvl(uint8 lvl)
{
    m_reqLvl = lvl;
}

void CItemEquipment::setILvl(uint8 lvl)
{
    m_iLvl = lvl;
}

void CItemEquipment::setJobs(uint32 jobs)
{
    m_jobs = jobs;
}

void CItemEquipment::setModelId(uint16 mdl)
{
    m_modelID = mdl;
}

void CItemEquipment::setShieldSize(uint8 shield)
{
    m_shieldSize = shield;
}

void CItemEquipment::setEquipSlotId(uint16 equipSlot)
{
    m_equipSlotID = equipSlot;
}

/// <summary>
/// Sets the equip slots which should be unequipped when the item is equipped
/// Used for items which occupy multiple equipslots - eg. Cloaks which occupy body and head
/// </summary>
/// <param name="removeSlot">An integer representing a bitmask corresponding to BattleEntity SLOTTYPE</param>
void CItemEquipment::setRemoveSlotId(uint16 removSlot)
{
    m_removeSlotID = removSlot;
}

/// <summary>
/// Sets the equip slots which should be set to blank from the characters appearance when the item is equipped or lockstyled
/// Used for items which occupy multiple appearance slots
/// eg. Mandragora Suit which has a getRemoveSlotId of body and legs - but appearance wise occupies hands, body, legs, and feet
/// </summary>
/// <param name="removeSlotLook">An integer representing a bitmask corresponding to BattleEntity SLOTTYPE</param>
void CItemEquipment::setRemoveSlotLookId(uint16 removeSlotLook)
{
    m_removeSlotLookID = removeSlotLook;
}

uint8 CItemEquipment::getSlotType() const
{
    uint32 result = 0;
    getMSB(&result, (uint32)m_equipSlotID);
    return result;
}

uint8 CItemEquipment::getSuperiorLevel()
{
    return m_superiorLevel;
}

void CItemEquipment::setSuperiorLevel(uint8 level)
{
    m_superiorLevel = level;
}

bool CItemEquipment::isEquippableByRace(uint8 race) const
{
    // first note that a single race actually represents a race and sex combination (for example hume-male)
    // the EQUIPEMENT_ONLY_RACE mod is a multi-bit flag (where each set bit denotes that a specific race can use that equip)
    // this is needed because many equips allow a subset of races
    // for example Steppe Belt allows both taru-male and taru-female
    // also note the default mod value of 0 denotes all races can wear
    auto raceMod      = getModifier(Mod::EQUIPMENT_ONLY_RACE);
    bool isEquippable = true;

    // if a positive mod (so some race restriction(s) exist) then check against the char race
    // do so by converting the race flag of a character (which is a value between 1 and 8)
    // to a multi-bit style flag and then compare
    if (raceMod > 0 && (raceMod & (1 << (race - 1))) == 0)
    {
        isEquippable = false;
    }

    return isEquippable;
}

// percentage of damage blocked by shield
uint8 CItemEquipment::getShieldAbsorption() const
{
    return m_absorption;
}

// check if item is a shield via shield size
bool CItemEquipment::IsShield() const
{
    return m_shieldSize > 0 && m_shieldSize <= 6;
}

// return script type for events such as gear change, zone change, etc
// the function returns the type of event which saves us from having to check in all events
uint16 CItemEquipment::getScriptType() const
{
    return m_scriptType;
}

void CItemEquipment::setScriptType(uint16 ScriptType)
{
    m_scriptType = ScriptType;
}

// add item modifier
void CItemEquipment::addModifier(CModifier modifier)
{
    if (IsShield() && modifier.getModID() == Mod::DEF)
    {
        // reduction calc source: www.bluegartr.com/threads/84830-Shield-Asstery
        // http://www.ffxiah.com/forum/topic/21671/paladin-faq-info-and-trade-studies/33/ <~Aegis and Ochain
        auto pdt = (uint8)(modifier.getModAmount() / 2);

        switch (m_shieldSize)
        {
            case 1: // Buckler
                pdt += 22;
                break;
            case 2: // Round
            case 6: // Ochain
                pdt += 40;
                break;
            case 3: // Kite
                pdt += 50;
                break;
            case 4: // Tower
            case 5: // Aegis
                pdt += 55;
                break;
        }
        m_absorption = std::min<uint8>(pdt, 100);
    }
    modList.emplace_back(modifier);
}

int16 CItemEquipment::getModifier(Mod mod) const
{
    int16 totalAmount = 0;
    for (const auto& i : modList)
    {
        if (i.getModID() == mod)
        {
            totalAmount += i.getModAmount();
        }
    }
    return totalAmount;
}

void CItemEquipment::addPetModifier(CPetModifier modifier)
{
    petModList.emplace_back(modifier);
}

void CItemEquipment::addLatent(LATENT ConditionsID, uint16 ConditionsValue, Mod ModValue, int16 ModPower)
{
    itemLatent latent{ ConditionsID, ConditionsValue, ModValue, ModPower };
    latentList.emplace_back(latent);
}

bool CItemEquipment::delModifier(Mod mod, int16 modValue)
{
    // clang-format off
    auto it = std::find_if(modList.begin(), modList.end(), [mod, modValue](const CModifier& compare)
    {
        return compare.getModID() == mod && compare.getModAmount() == modValue;
    });
    // clang-format on

    if (it == modList.end())
    {
        return false;
    }

    modList.erase(it);
    return true;
}

bool CItemEquipment::delPetModifier(Mod mod, PetModType petType, int16 modValue)
{
    // clang-format off
    auto it = std::find_if(petModList.begin(), petModList.end(), [mod, petType, modValue](const CPetModifier& compare)
    {
        return compare.getModID() == mod && compare.getPetModType() == petType && compare.getModAmount() == modValue;
    });
    // clang-format on

    if (it == petModList.end())
    {
        return false;
    }

    petModList.erase(it);
    return true;
}

void CItemEquipment::setTrialNumber(uint16 trial)
{
    auto& trialData = this->exdata<Exdata::AugmentTrial>();

    if (trial)
    {
        trialData.AugmentSubKind |= Exdata::AugmentSubKindFlags::Trial;
        setSubType(ITEM_AUGMENTED);
        trialData.AugmentKind |= Exdata::AugmentKindFlags::HasAugments;
        trialData.AugmentSubKind |= Exdata::AugmentSubKindFlags::Standard;
    }
    else
    {
        trialData.AugmentSubKind &= ~Exdata::AugmentSubKindFlags::Trial;
    }

    trialData.TrialId = trial;
}

auto CItemEquipment::getTrialNumber() const -> uint16
{
    return this->exdata<Exdata::AugmentTrial>().TrialId;
}

/************************************************************************
 *                                                                       *
 *  Augments: 5 bits for value, 11 bits for augment ID                   *
 *                                                                       *
 ************************************************************************/
void CItemEquipment::LoadAugment(uint8 slot, uint16 augment)
{
    auto& augData = this->exdata<Exdata::AugmentStandard>();
    std::memcpy(&augData.Augments[slot], &augment, sizeof(uint16));
}

bool CItemEquipment::PushAugment(uint16 type, uint8 value)
{
    auto&  augData = this->exdata<Exdata::AugmentStandard>();
    uint8  slot    = 0;
    uint16 augment = 0;
    std::memcpy(&augment, &augData.Augments[slot], sizeof(uint16));
    while (augment != 0 && slot < 4)
    {
        ++slot;
        std::memcpy(&augment, &augData.Augments[slot], sizeof(uint16));
    }
    if (augment == 0)
    {
        setAugment(slot, type, value);
        return true;
    }
    return false;
}

void CItemEquipment::ApplyAugment(uint8 slot)
{
    auto& augData = this->exdata<Exdata::AugmentStandard>();
    SetAugmentMod(augData.Augments[slot].Id, augData.Augments[slot].Value);
}

void CItemEquipment::setAugment(uint8 slot, uint16 type, uint8 value)
{
    auto& augData                = this->exdata<Exdata::AugmentStandard>();
    augData.Augments[slot].Id    = type;
    augData.Augments[slot].Value = value;

    SetAugmentMod(type, value);
}

void CItemEquipment::SetAugmentMod(uint16 type, uint8 value)
{
    if (sAugmentData.find(type) == sAugmentData.end())
    {
        ShowErrorFmt("Invalid augment type {} requested for item {}", type, this->getID());
        return;
    }

    if (type != 0)
    {
        auto& augData = this->exdata<Exdata::AugmentStandard>();
        setSubType(ITEM_AUGMENTED);
        augData.AugmentKind |= Exdata::AugmentKindFlags::HasAugments;
        augData.AugmentSubKind |= Exdata::AugmentSubKindFlags::Standard;
    }

    const auto& augmentDataModifiers = sAugmentData[type];

    for (const auto& augmentData : augmentDataModifiers)
    {
        uint8 multiplier = augmentData.multiplier;
        Mod   modId      = static_cast<Mod>(augmentData.modId);
        int16 modValue   = augmentData.value;

        // type is 0 unless mod is for pets
        uint8      isPet   = augmentData.isPet;
        PetModType petType = static_cast<PetModType>(augmentData.petType);

        // apply modifier to item. increase modifier power by 'value' (default magnitude 1 for most augments) if multiplier isn't specified
        // otherwise increase modifier power using the multiplier
        // check if we should be adding to or taking away from the mod power (handle scripted augments properly)
        modValue = (modValue > 0 ? modValue + value : modValue - value) * (multiplier > 1 ? multiplier : 1);

        // Skip unimplemented augments modifiers
        if (modId == Mod::NONE)
        {
            continue;
        }

        if (!isPet)
        {
            addModifier(CModifier(modId, modValue));
        }
        else
        {
            addPetModifier(CPetModifier(modId, petType, modValue));
        }
    }
}

auto CItemEquipment::getAugment(uint8 slot) const -> uint16
{
    auto&  augData = this->exdata<Exdata::AugmentStandard>();
    uint16 result  = 0;
    std::memcpy(&result, &augData.Augments[slot], sizeof(uint16));
    return result;
}
