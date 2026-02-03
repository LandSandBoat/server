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

#include "blueutils.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/utils.h"

#include "packets/s2c/0x0aa_magic_data.h"

#include "packets/s2c/0x061_clistatus.h"

#include "battleutils.h"
#include "blue_spell.h"
#include "blue_trait.h"
#include "charutils.h"
#include "job_points.h"
#include "merit.h"
#include "modifier.h"
#include "packets/s2c/0x029_battle_message.h"
#include "party.h"
#include "spell.h"

namespace blueutils
{

void SetBlueSpell(CCharEntity* PChar, CBlueSpell* PSpell, uint8 slotIndex, bool addingSpell)
{
    // sanity check
    if (slotIndex < 20)
    {
        if (PSpell)
        {
            // Blue spells in SetBlueSpells must be 0x200 ofsetted so it's 1 byte per spell.
            if (PChar->m_SetBlueSpells[slotIndex] != 0)
            {
                CBlueSpell* POldSpell = (CBlueSpell*)spell::GetSpell(static_cast<SpellID>(PChar->m_SetBlueSpells[slotIndex] + 0x200));
                PChar->delModifiers(&POldSpell->modList);
                PChar->m_SetBlueSpells[slotIndex] = 0x00;
            }
            if (addingSpell && !IsSpellSet(PChar, PSpell) && HasEnoughSetPoints(PChar, PSpell, slotIndex))
            {
                uint16 spellID = static_cast<uint16>(PSpell->getID());
                if (charutils::hasSpell(PChar, spellID))
                {
                    PChar->m_SetBlueSpells[slotIndex] = spellID - 0x200;
                    PChar->addModifiers(&PSpell->modList);
                }
                else
                {
                    ShowWarning("SetBlueSpell: Player %s trying to set spell ID %u they don't have! ", PChar->getName(), spellID);
                }
            }
            SaveSetSpells(PChar);
        }
    }
}

void TryLearningSpells(CCharEntity* PChar, CMobEntity* PMob)
{
    if (PMob->m_UsedSkillIds.empty())
    { // minor optimisation.
        return;
    }

    // prune the learnable blue spells
    std::vector<CSpell*> PLearnableSpells;
    for (auto& m_UsedSkillId : PMob->m_UsedSkillIds)
    {
        CSpell* PSpell = spell::GetSpellByMonsterSkillId(m_UsedSkillId.first);
        if (PSpell != nullptr)
        {
            PLearnableSpells.emplace_back(PSpell);
        }
    }

    if (PLearnableSpells.empty())
    {
        return;
    }

    std::vector<CCharEntity*> PBlueMages;
    auto                      AddBlueMages = [&PMob, &PBlueMages](const CParty* PParty)
    {
        for (const auto& member : PParty->members)
        {
            auto* PMember = dynamic_cast<CCharEntity*>(member);
            if (PMember &&
                PMember->GetMJob() == JOB_BLU &&
                PMember->getZone() == PMob->getZone())
            {
                PBlueMages.emplace_back(PMember);
            }
        }
    };

    // populate PBlueMages
    if (PChar->PParty != nullptr)
    {
        if (PChar->PParty->m_PAlliance)
        {
            for (const auto* party : PChar->PParty->m_PAlliance->partyList)
            {
                AddBlueMages(party);
            }
        }
        else
        {
            AddBlueMages(PChar->PParty);
        }
    }
    else if (PChar->GetMJob() == JOB_BLU)
    {
        PBlueMages.emplace_back(PChar);
    }

    // loop through the list of BLUs and see if they can learn.
    for (auto PBlueMage : PBlueMages)
    {
        if (PBlueMage->isDead())
        { // too dead to learn
            continue;
        }

        if (distance(PBlueMage->loc.p, PMob->loc.p) > 100)
        { // too far away to learn
            continue;
        }

        for (auto PSpell : PLearnableSpells)
        {
            if (charutils::hasSpell(PBlueMage, static_cast<uint16>(PSpell->getID())))
            {
                continue;
            }

            // get the skill cap for the spell level
            auto skillLvlForSpell = battleutils::GetMaxSkill(SKILL_BLUE_MAGIC, JOB_BLU, PSpell->getJob(JOB_BLU));
            // get player skill level with bonus from gear
            auto playerSkillLvl = PBlueMage->GetSkill(SKILL_BLUE_MAGIC);

            // make sure the difference between spell skill and player is at most 31 points
            if (playerSkillLvl >= skillLvlForSpell - 31)
            {
                auto chanceToLearn = 33 + PBlueMage->getMod(Mod::BLUE_LEARN_CHANCE);
                if (xirand::GetRandomNumber(100) < chanceToLearn)
                {
                    if (charutils::addSpell(PBlueMage, static_cast<uint16>(PSpell->getID())))
                    {
                        PBlueMage->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PBlueMage, PBlueMage, static_cast<uint16>(PSpell->getID()), 0, MsgBasic::LEARNS_SPELL);
                        charutils::SaveSpell(PBlueMage, static_cast<uint16>(PSpell->getID()));
                        PBlueMage->pushPacket<GP_SERV_COMMAND_MAGIC_DATA>(PBlueMage);
                    }
                }
                break; // only one attempt at learning a spell, regardless of learn or not.
            }
        }
    }
}

bool HasEnoughSetPoints(CCharEntity* PChar, CBlueSpell* PSpellToAdd, uint8 slotToPut)
{
    uint8 setpoints = 0;
    for (int slot = 0; slot < 20; slot++)
    {
        if (slot != slotToPut && PChar->m_SetBlueSpells[slot] != 0)
        {
            CBlueSpell* setSpell = (CBlueSpell*)spell::GetSpell(static_cast<SpellID>(PChar->m_SetBlueSpells[slot] + 0x200));
            if (setSpell)
            {
                setpoints += setSpell->getSetPoints();
            }
        }
    }

    return setpoints + PSpellToAdd->getSetPoints() <= GetTotalBlueMagicPoints(PChar);
}

void UnequipAllBlueSpells(CCharEntity* PChar)
{
    for (unsigned char& m_SetBlueSpell : PChar->m_SetBlueSpells)
    {
        if (m_SetBlueSpell != 0)
        {
            CBlueSpell* PSpell = (CBlueSpell*)spell::GetSpell(static_cast<SpellID>(m_SetBlueSpell + 0x200));
            m_SetBlueSpell     = 0;
            PChar->delModifiers(&PSpell->modList);
        }
    }
    charutils::BuildingCharTraitsTable(PChar);
    charutils::SendExtendedJobPackets(PChar);
    PChar->pushPacket<GP_SERV_COMMAND_CLISTATUS>(PChar);
    charutils::CalculateStats(PChar);
    PChar->UpdateHealth();
    SaveSetSpells(PChar);
    PChar->updatemask |= UPDATE_HP;
}

bool IsSpellSet(CCharEntity* PChar, CBlueSpell* PSpell)
{
    for (unsigned char m_SetBlueSpell : PChar->m_SetBlueSpells)
    {
        if (m_SetBlueSpell != 0)
        {
            if (m_SetBlueSpell == static_cast<uint16>(PSpell->getID()) - 0x200)
            {
                return true;
            }
        }
    }
    return false;
}

void CompactSpells(CCharEntity* PChar)
{
    for (int i = 0; i < 20; i++)
    {
        if (PChar->m_SetBlueSpells[i] == 0)
        {
            for (int j = i; j < 20; j++)
            {
                if (PChar->m_SetBlueSpells[j] != 0)
                {
                    PChar->m_SetBlueSpells[i] = PChar->m_SetBlueSpells[j];
                    PChar->m_SetBlueSpells[j] = 0;
                    break;
                }
            }
        }
    }
}

void CheckSpellLevels(CCharEntity* PChar)
{
    uint8 level = 0;
    if (PChar->GetMJob() == JOB_BLU)
    {
        level = PChar->GetMLevel();
    }
    else if (PChar->GetSJob() == JOB_BLU)
    {
        level = PChar->GetSLevel();
    }

    if (level != 0)
    {
        for (int slot = 0; slot < 20; slot++)
        {
            if (PChar->m_SetBlueSpells[slot] != 0)
            {
                CBlueSpell* PSpell = (CBlueSpell*)spell::GetSpell(static_cast<SpellID>(PChar->m_SetBlueSpells[slot] + 0x200));
                if (PSpell && level < PSpell->getJob(JOB_BLU))
                {
                    SetBlueSpell(PChar, PSpell, slot, false);
                }
            }
        }
    }
}

uint8 GetTotalSlots(CCharEntity* PChar)
{
    uint8 level = 0;
    if (PChar->GetMJob() == JOB_BLU)
    {
        level = PChar->GetMLevel();
    }
    else if (PChar->GetSJob() == JOB_BLU)
    {
        level = PChar->GetSLevel();
    }

    if (level == 0)
    {
        return 0;
    }
    else
    {
        return std::clamp(((level - 1) / 10) * 2 + 6, 6, 20);
    }
}

uint8 GetTotalBlueMagicPoints(CCharEntity* PChar)
{
    uint8 level = 0;
    if (PChar->GetMJob() == JOB_BLU)
    {
        level = PChar->GetMLevel();
    }
    else if (PChar->GetSJob() == JOB_BLU)
    {
        level = PChar->GetSLevel();
    }

    if (level == 0)
    {
        return 0;
    }
    else
    {
        uint8 points = std::clamp(((level - 1) / 10) * 5 + 10, 0, 55);
        if (level >= 75)
        {
            points = points + PChar->PMeritPoints->GetMeritValue(MERIT_ASSIMILATION, PChar);
        }

        if (level >= 99)
        {
            points = points + PChar->PJobPoints->GetJobPointValue(JP_BLUE_MAGIC_POINT_BONUS);
        }

        return points;
    }
}

void SaveSetSpells(CCharEntity* PChar)
{
    if (PChar->GetMJob() == JOB_BLU || PChar->GetSJob() == JOB_BLU)
    {
        if (!db::preparedStmt("UPDATE chars SET set_blue_spells = ? WHERE charid = ? LIMIT 1",
                              PChar->m_SetBlueSpells,
                              PChar->id))
        {
            ShowError("Failed to save set blue spells for %s", PChar->getName());
        }
    }
}

void LoadSetSpells(CCharEntity* PChar)
{
    TracyZoneScoped;

    if (PChar->GetMJob() == JOB_BLU || PChar->GetSJob() == JOB_BLU)
    {
        auto rset = db::preparedStmt("SELECT set_blue_spells FROM chars WHERE charid = ? LIMIT 1", PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            PChar->m_SetBlueSpells = rset->get<std::array<uint8, 20>>("set_blue_spells");
        }

        for (unsigned char& m_SetBlueSpell : PChar->m_SetBlueSpells)
        {
            if (m_SetBlueSpell != 0)
            {
                CBlueSpell* PSpell = (CBlueSpell*)spell::GetSpell(static_cast<SpellID>(m_SetBlueSpell + 0x200));
                if (PSpell == nullptr)
                {
                    m_SetBlueSpell = 0;
                }
                else
                {
                    PChar->addModifiers(&PSpell->modList);
                }
            }
        }
        ValidateBlueSpells(PChar);
    }
}

void ValidateBlueSpells(CCharEntity* PChar)
{
    CheckSpellLevels(PChar);

    uint8 maxSetPoints  = GetTotalBlueMagicPoints(PChar);
    uint8 currentPoints = 0;

    for (int slot = 0; slot < 20; slot++)
    {
        if (PChar->m_SetBlueSpells[slot] != 0)
        {
            CBlueSpell* PSpell = (CBlueSpell*)spell::GetSpell(static_cast<SpellID>(PChar->m_SetBlueSpells[slot] + 0x200));
            if (currentPoints + PSpell->getSetPoints() > maxSetPoints)
            {
                SetBlueSpell(PChar, PSpell, slot, false);
            }
            else
            {
                currentPoints += PSpell->getSetPoints();
            }
        }
    }

    CompactSpells(PChar);

    uint8 maxSlots = GetTotalSlots(PChar);

    for (int slot = maxSlots; slot < 20; slot++)
    {
        if (PChar->m_SetBlueSpells[slot] != 0)
        {
            SetBlueSpell(PChar, (CBlueSpell*)spell::GetSpell(static_cast<SpellID>(PChar->m_SetBlueSpells[slot] + 0x200)), slot, false);
        }
    }

    SaveSetSpells(PChar);
}

// Adds Blue Traits based on spells set
// Always run on a player that has just been purged of all traits and job-related traits added
// Loops over all blue spells to get eligible traits based on set spells
// then loops over all blue traits to see if they match the eligible traits
// each eligible blue trait is compared against existing job traits
// if a higher-tier blue trait is found to be valid, lower is removed
// ***note*** this function assumes Blue Traits are added with `tier` in ascending order to reduce complexity
void CalculateTraits(CCharEntity* PChar)
{
    TraitList_t*           PTraitsList = traits::GetTraits(JOB_BLU);
    std::map<uint8, uint8> points;
    std::vector<CTrait*>   traitsToAdd;
    auto                   traitTierBonus = PChar->getMod(Mod::BLUE_JOB_TRAIT_BONUS);

    for (unsigned char m_SetBlueSpell : PChar->m_SetBlueSpells)
    {
        if (m_SetBlueSpell != 0)
        {
            CBlueSpell* PSpell = (CBlueSpell*)spell::GetSpell(static_cast<SpellID>(m_SetBlueSpell + 0x200));

            if (PSpell)
            {
                uint8                            category = PSpell->getTraitCategory();
                uint8                            weight   = PSpell->getTraitWeight();
                std::map<uint8, uint8>::iterator iter     = points.find(category);

                if (iter != points.end())
                {
                    iter->second += weight;
                }
                else
                {
                    points.insert(std::make_pair(category, weight));
                }
            }
        }
    }

    // Add BLU traits that are eligible
    for (auto& point : points)
    {
        uint8 category    = point.first;
        uint8 totalWeight = point.second;

        for (auto& i : *PTraitsList)
        {
            if (i->getLevel() == 0)
            {
                CBlueTrait* PTrait = (CBlueTrait*)i;

                // Player is eligible for this Blue Trait
                if (PTrait && PTrait->getCategory() == category && totalWeight >= PTrait->getPoints() && !PTrait->getJobPointsOnly())
                {
                    // Check all the eligible Blue Traits for conflicts
                    for (auto it = traitsToAdd.begin(); it != traitsToAdd.end();)
                    {
                        auto currentTrait = *it;

                        // Same trait ID, trait mod, and is weaker than new trait
                        if (currentTrait->getID() == PTrait->getID() && currentTrait->getRank() <= PTrait->getRank() && currentTrait->getMod() == PTrait->getMod())
                        {
                            // Erase lower tier trait
                            it = traitsToAdd.erase(it);
                        }
                        else
                        {
                            ++it;
                        }
                    }

                    traitsToAdd.emplace_back((CBlueTrait*)PTrait);
                }
            }
        }
    }

    std::vector<CTrait*> upgradedTraits;

    auto isSameBluTrait = [](CBlueTrait* PBluTraitA, CBlueTrait* PBluTraitB) -> bool
    {
        if (PBluTraitA->getCategory() != PBluTraitB->getCategory())
        {
            return false;
        }

        // Edge case
        // Double Attack upgrades to Triple Attack
        // Gilfinder upgrades to Treasure Hunter
        if (PBluTraitA->getMod() != PBluTraitB->getMod())
        {
            if (PBluTraitA->getMod() == Mod::DOUBLE_ATTACK && PBluTraitB->getMod() == Mod::TRIPLE_ATTACK)
            {
                return true;
            }

            if (PBluTraitA->getMod() == Mod::TRIPLE_ATTACK && PBluTraitB->getMod() == Mod::DOUBLE_ATTACK)
            {
                return true;
            }

            if (PBluTraitA->getMod() == Mod::GILFINDER && PBluTraitB->getMod() == Mod::TREASURE_HUNTER)
            {
                return true;
            }

            if (PBluTraitA->getMod() == Mod::TREASURE_HUNTER && PBluTraitB->getMod() == Mod::GILFINDER)
            {
                return true;
            }

            return false;
        }

        // Must be after mod ID check due to edge case. They have different trait IDs. "Gilfinder" and "Treasure hunter" etc are different in the menus
        if (PBluTraitA->getID() != PBluTraitB->getID())
        {
            return false;
        }

        return true;
    };

    // Search for higher tier bonuses to boost them before we check if existing traits are stronger
    if (traitTierBonus > 0)
    {
        for (auto it = traitsToAdd.begin(); it != traitsToAdd.end();)
        {
            auto        currentTrait = (CBlueTrait*)*it;
            auto        newRank      = currentTrait->getRank() + traitTierBonus;
            CBlueTrait* newTrait     = nullptr;

            for (auto& i : *PTraitsList)
            {
                if (i->getLevel() == 0)
                {
                    CBlueTrait* PTrait = (CBlueTrait*)i;

                    if (isSameBluTrait(PTrait, currentTrait) && newRank >= PTrait->getRank())
                    {
                        newTrait = PTrait;
                    }
                }
            }

            if (newTrait)
            {
                it = traitsToAdd.erase(it);
                upgradedTraits.push_back(newTrait);
            }
            else
            {
                ++it;
            }
        }
    }

    // Append in upgraded traits in place of ones that were removed in the search for upgraded traits, if any
    if (upgradedTraits.size() > 0)
    {
        traitsToAdd.insert(traitsToAdd.end(), upgradedTraits.begin(), upgradedTraits.end());
    }

    // Remove weaker BLU traits
    for (auto PExistingTrait : PChar->TraitList)
    {
        for (auto it = traitsToAdd.begin(); it != traitsToAdd.end();)
        {
            auto PTrait = *it;

            // Ensure they are the same modifier. BLU/THF can theoretically get Gilfinder from /THF and Treasure Hunter from BLU traits (though this is a weird edge case...)
            // Need verification on that exact scenario... though not sure why you wouldn't just level your sub more? You can't get TH2/3 from BLU traits.
            if (PExistingTrait->getID() == PTrait->getID() && PExistingTrait->getMod() == PTrait->getMod())
            {
                // Player has the real job trait, remove ours
                if (PExistingTrait->getRank() >= PTrait->getRank())
                {
                    it = traitsToAdd.erase(it);
                    continue;
                }
            }

            ++it;
        }
    }

    // Remove weaker player traits
    for (auto PTrait : traitsToAdd)
    {
        for (auto it = PChar->TraitList.begin(); it != PChar->TraitList.end();)
        {
            auto PExistingTrait = *it;

            // Ensure they are the same modifier. BLU/THF can theoretically get Gilfinder from /THF and Treasure Hunter from BLU traits (though this is a weird edge case...)
            // Need verification on that exact scenario... though not sure why you wouldn't just level your sub more? You can't get TH2/3 from BLU traits.
            if (PExistingTrait->getID() == PTrait->getID() && PExistingTrait->getMod() == PTrait->getMod())
            {
                // Player has the real job trait, and it's weaker, remove theirs
                if (PExistingTrait->getRank() < PTrait->getRank())
                {
                    PChar->delModifier(PExistingTrait->getMod(), PExistingTrait->getValue());
                    it = PChar->TraitList.erase(it);
                    continue;
                }
            }

            ++it;
        }
    }

    // Finally, add traits to the player
    for (auto PTrait : traitsToAdd)
    {
        charutils::addTrait(PChar, PTrait->getID());

        PChar->TraitList.emplace_back(PTrait);
        PChar->addModifier(PTrait->getMod(), PTrait->getValue());
    }
}

} // namespace blueutils
