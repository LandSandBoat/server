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

#include "common/logging.h"
#include "common/utils.h"

#include <common/types/hash_map.h>

#include "exdata/augment_standard.h"
#include "exdata/augment_trial.h"

#include <algorithm>
#include <bit>

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
HashMap<uint16, AugmentDataRows> sAugmentData;

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

CItemEquipment::CItemEquipment(const CItemEquipment& other) = default;

CItemEquipment::~CItemEquipment() = default;

auto CItemEquipment::getModelId() const -> uint16
{
    return m_modelID;
}

auto CItemEquipment::getShieldSize() const -> uint8
{
    return m_shieldSize;
}

auto CItemEquipment::getEquipSlotId() const -> uint16
{
    return m_equipSlotID;
}

/// <summary>
/// Gets the equip slots which should be unequipped when the item is equipped
/// Used for items which occupy multiple equipslots - eg. Cloaks which occupy body and head
/// </summary>
/// <returns>An integer representing a bitmask corresponding to BattleEntity SLOTTYPE</returns>
auto CItemEquipment::getRemoveSlotId() const -> uint16
{
    return m_removeSlotID;
}

/// <summary>
/// Gets the equip slots which should be set to blank from the characters appearance when the item is equipped or lockstyled
/// Used for items which occupy multiple appearance slots
/// eg. Mandragora Suit which has a getRemoveSlotId of body and legs - but appearance wise occupies hands, body, legs, and feet
/// </summary>
/// <returns>An integer representing a bitmask corresponding to BattleEntity SLOTTYPE</returns>
auto CItemEquipment::getRemoveSlotLookId() const -> uint16
{
    return m_removeSlotLookID;
}

auto CItemEquipment::getReqLvl() const -> uint8
{
    return m_reqLvl;
}

auto CItemEquipment::getILvl() const -> uint8
{
    return m_iLvl;
}

auto CItemEquipment::getJobs() const -> uint32
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

auto CItemEquipment::getSlotType() const -> uint8
{
    return m_equipSlotID ? static_cast<uint8>(std::bit_width(static_cast<uint32>(m_equipSlotID)) - 1) : 0;
}

auto CItemEquipment::getSuperiorLevel() const -> uint8
{
    return m_superiorLevel;
}

void CItemEquipment::setSuperiorLevel(uint8 level)
{
    m_superiorLevel = level;
}

auto CItemEquipment::isEquippableByRace(uint8 race) const -> bool
{
    // first note that a single race actually represents a race and sex combination (for example hume-male)
    // the EQUIPEMENT_ONLY_RACE mod is a multi-bit flag (where each set bit denotes that a specific race can use that equip)
    // this is needed because many equips allow a subset of races
    // for example Steppe Belt allows both taru-male and taru-female
    // also note the default mod value of 0 denotes all races can wear
    auto raceMod      = getModifier(xi::Mod::EQUIPMENT_ONLY_RACE);
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
auto CItemEquipment::getShieldAbsorption() const -> uint8
{
    return m_absorption;
}

// check if item is a shield via shield size
auto CItemEquipment::IsShield() const -> bool
{
    return m_shieldSize > 0 && m_shieldSize <= 6;
}

// return script type for events such as gear change, zone change, etc
// the function returns the type of event which saves us from having to check in all events
auto CItemEquipment::getScriptType() const -> uint16
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
    if (IsShield() && modifier.getModID() == xi::Mod::DEF)
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

auto CItemEquipment::getModifier(xi::Mod mod) const -> int16
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

void CItemEquipment::addLatent(xi::Latent ConditionsID, uint16 ConditionsValue, xi::Mod ModValue, int16 ModPower)
{
    itemLatent latent{ ConditionsID, ConditionsValue, ModValue, ModPower };
    latentList.emplace_back(latent);
}

auto CItemEquipment::delModifier(xi::Mod mod, int16 modValue) -> bool
{
    auto it = std::ranges::find_if(modList,
                                   [mod, modValue](const CModifier& compare)
                                   {
                                       return compare.getModID() == mod && compare.getModAmount() == modValue;
                                   });

    if (it == modList.end())
    {
        return false;
    }

    modList.erase(it);
    return true;
}

auto CItemEquipment::delPetModifier(xi::Mod mod, PetModType petType, int16 modValue) -> bool
{
    auto it = std::ranges::find_if(petModList,
                                   [mod, petType, modValue](const CPetModifier& compare)
                                   {
                                       return compare.getModID() == mod && compare.getPetModType() == petType && compare.getModAmount() == modValue;
                                   });

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
    auto& augData          = this->exdata<Exdata::AugmentStandard>();
    augData.Augments[slot] = std::bit_cast<Exdata::Augment>(augment);
}

auto CItemEquipment::PushAugment(uint16 type, uint8 value) -> bool
{
    auto&  augData = this->exdata<Exdata::AugmentStandard>();
    uint8  slot    = 0;
    uint16 augment = std::bit_cast<uint16>(augData.Augments[slot]);
    while (augment != 0 && slot < 4)
    {
        ++slot;
        augment = std::bit_cast<uint16>(augData.Augments[slot]);
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
    if (!sAugmentData.contains(type))
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
        uint8   multiplier = augmentData.multiplier;
        xi::Mod modId      = static_cast<xi::Mod>(augmentData.modId);
        int16   modValue   = augmentData.value;

        // type is 0 unless mod is for pets
        uint8      isPet   = augmentData.isPet;
        PetModType petType = static_cast<PetModType>(augmentData.petType);

        // apply modifier to item. increase modifier power by 'value' (default magnitude 1 for most augments) if multiplier isn't specified
        // otherwise increase modifier power using the multiplier
        // check if we should be adding to or taking away from the mod power (handle scripted augments properly)
        modValue = (modValue > 0 ? modValue + value : modValue - value) * std::max<uint8>(multiplier, 1);

        // Skip unimplemented augments modifiers
        if (modId == xi::Mod::NONE)
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
    auto& augData = this->exdata<Exdata::AugmentStandard>();
    return std::bit_cast<uint16>(augData.Augments[slot]);
}
