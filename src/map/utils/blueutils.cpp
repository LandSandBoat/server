﻿/*
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

#include "common/utils.h"

#include "packets/char_job_extra.h"
#include "packets/char_spells.h"

#include <cmath>

#include "packets/char_health.h"
#include "packets/char_stats.h"
#include "packets/message_basic.h"

#include "battleutils.h"
#include "blue_spell.h"
#include "blue_trait.h"
#include "blueutils.h"
#include "charutils.h"
#include "grades.h"
#include "job_points.h"
#include "merit.h"
#include "modifier.h"
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

        // populate PBlueMages
        if (PChar->PParty != nullptr)
        {
            for (auto& member : PChar->PParty->members)
            {
                if (member->GetMJob() == JOB_BLU && member->objtype == TYPE_PC)
                {
                    PBlueMages.emplace_back((CCharEntity*)member);
                }
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
                            PBlueMage->pushPacket<CMessageBasicPacket>(PBlueMage, PBlueMage, static_cast<uint16>(PSpell->getID()), 0, MSGBASIC_LEARNS_SPELL);
                            charutils::SaveSpell(PBlueMage, static_cast<uint16>(PSpell->getID()));
                            PBlueMage->pushPacket<CCharSpellsPacket>(PBlueMage);
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
        PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
        PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
        PChar->pushPacket<CCharStatsPacket>(PChar);
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
            auto set_blue_spells = db::encodeToBlob(PChar->m_SetBlueSpells);
            auto query           = fmt::format("UPDATE chars SET set_blue_spells = '{}' WHERE charid = {} LIMIT 1",
                                               set_blue_spells, PChar->id);
            db::query(query);
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
                db::extractFromBlob(rset, "set_blue_spells", PChar->m_SetBlueSpells);
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
    void CalculateTraits(CCharEntity* PChar)
    {
        TraitList_t*           PTraitsList = traits::GetTraits(JOB_BLU);
        std::map<uint8, uint8> points;
        std::vector<CTrait*>   traitsToAdd;

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
                    if (PTrait && PTrait->getCategory() == category && totalWeight >= PTrait->getPoints())
                    {
                        bool add = true;

                        // Check if any existing player Traits conflict
                        for (std::size_t j = 0; j < PChar->TraitList.size(); ++j)
                        {
                            CTrait* PExistingTrait = PChar->TraitList.at(j);

                            if (PExistingTrait->getID() == PTrait->getID())
                            {
                                // Player has the real job trait, making them ineligible
                                // TODO remove the trait and add the blu trait if it's stronger
                                if (PExistingTrait->getLevel() > 0)
                                {
                                    add = false;
                                    break;
                                }
                            }
                        }

                        if (add)
                        {
                            // Check all the eligible Blue Traits for conflicts
                            std::size_t j;
                            for (j = 0; j < traitsToAdd.size(); ++j)
                            {
                                auto iter = traitsToAdd.at(j);
                                // New Trait matches a Trait already marked to add
                                if (iter->getID() == PTrait->getID() && iter->getMod() == PTrait->getMod())
                                {
                                    if (iter->getValue() > PTrait->getValue())
                                    {
                                        // New Trait is a lower tier
                                        add = false;
                                        break;
                                    }
                                }
                            }

                            if (add)
                            {
                                if (j != traitsToAdd.size())
                                {
                                    // New Trait is higher power than one already staged
                                    traitsToAdd.at(j) = (CBlueTrait*)PTrait;
                                }
                                else
                                {
                                    // New Trait/Mod combination is not staged yet
                                    traitsToAdd.emplace_back((CBlueTrait*)PTrait);
                                }
                            }
                        }
                    }
                }
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
