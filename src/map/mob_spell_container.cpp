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

#include "mob_spell_container.h"
#include "mob_modifier.h"
#include "recast_container.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"

CMobSpellContainer::CMobSpellContainer(CMobEntity* PMob)
{
    m_PMob      = PMob;
    m_hasSpells = false;
}

void CMobSpellContainer::ClearSpells()
{
    m_gaList.clear();
    m_damageList.clear();
    m_buffList.clear();
    m_debuffList.clear();
    m_healList.clear();
    m_naList.clear();
    m_raiseList.clear();
    m_hasSpells = false;
}

void CMobSpellContainer::AddSpell(SpellID spellId)
{
    // get spell
    CSpell* spell = spell::GetSpell(spellId);

    if (spell == nullptr)
    {
        ShowDebug("Missing spellID = %d, given to mob. Check spell_list.sql", static_cast<uint16>(spellId));
        return;
    }

    m_hasSpells = true;

    // add spell to correct vector
    // try to add it to ga list first
    uint8 aoe = battleutils::GetSpellAoEType(m_PMob, spell);
    if (aoe > 0 && spell->canTargetEnemy())
    {
        m_gaList.emplace_back(spellId);
    }
    else if (spell->isSevere())
    {
        // select spells like death and impact
        m_severeList.emplace_back(spellId);
    }
    else if (spell->canTargetEnemy() && !spell->isSevere())
    {
        // add to damage list
        m_damageList.emplace_back(spellId);
    }
    else if (spell->isDebuff())
    {
        m_debuffList.emplace_back(spellId);
    }
    else if (spell->isNa())
    {
        // na spell and erase
        m_naList.emplace_back(spellId);
    }
    else if (spell->isRaise())
    {
        // raise family
        m_raiseList.emplace_back(spellId);
    }
    else if (spell->isHeal())
    { // includes blue mage healing spells, wild carrot etc
        // add to healing
        m_healList.emplace_back(spellId);
    }
    else if (spell->isBuff())
    {
        // buff
        m_buffList.emplace_back(spellId);
    }
    else
    {
        ShowDebug("Where does this spell go? %d", static_cast<uint16>(spellId));
    }
}

void CMobSpellContainer::RemoveSpell(SpellID spellId)
{
    auto findAndRemove = [](std::vector<SpellID>& list, SpellID id)
    { list.erase(std::remove(list.begin(), list.end(), id), list.end()); };

    findAndRemove(m_gaList, spellId);
    findAndRemove(m_damageList, spellId);
    findAndRemove(m_buffList, spellId);
    findAndRemove(m_debuffList, spellId);
    findAndRemove(m_healList, spellId);
    findAndRemove(m_naList, spellId);
    findAndRemove(m_raiseList, spellId);

    m_hasSpells = !(m_gaList.empty() && m_damageList.empty() && m_buffList.empty() && m_debuffList.empty() && m_healList.empty() && m_naList.empty() && m_raiseList.empty());
}

// Used in Gambits to see if the Trust can cast the spell
std::optional<SpellID> CMobSpellContainer::GetAvailable(SpellID spellId)
{
    auto* spell    = spell::GetSpell(spellId);
    bool  enoughMP = spell->getMPCost() <= m_PMob->health.mp ||
                    spell->getSkillType() == SKILL_NINJUTSU ||
                    spell->getSkillType() == SKILL_SINGING ||
                    spell->getSkillType() == SKILL_WIND_INSTRUMENT ||
                    spell->getSkillType() == SKILL_STRING_INSTRUMENT ||
                    spell->getSkillType() == SKILL_GEOMANCY;
    bool isNotInRecast = !m_PMob->PRecastContainer->Has(RECAST_MAGIC, static_cast<uint16>(spellId));

    return (isNotInRecast && enoughMP) ? std::optional<SpellID>(spellId) : std::nullopt;
}

// Used in Gambits to see if the Trust can cast the spell
std::optional<SpellID> CMobSpellContainer::GetBestAvailable(SPELLFAMILY family)
{
    std::vector<SpellID> matches;
    auto                 searchInList = [&](std::vector<SpellID>& list)
    {
        for (auto id : list)
        {
            auto* spell      = spell::GetSpell(id);
            bool  sameFamily = (family == SPELLFAMILY_NONE) ? true : spell->getSpellFamily() == family;
            bool  enoughMP   = spell->getMPCost() <= m_PMob->health.mp ||
                            spell->getSkillType() == SKILL_NINJUTSU ||
                            spell->getSkillType() == SKILL_SINGING ||
                            spell->getSkillType() == SKILL_WIND_INSTRUMENT ||
                            spell->getSkillType() == SKILL_STRING_INSTRUMENT ||
                            spell->getSkillType() == SKILL_GEOMANCY;
            bool isNotInRecast = !m_PMob->PRecastContainer->Has(RECAST_MAGIC, static_cast<uint16>(id));
            if (sameFamily && enoughMP && isNotInRecast)
            {
                matches.emplace_back(id);
            }
        };
    };

    // TODO: After a good refactoring, this sort of hack won't be needed...
    if (family == SPELLFAMILY_NONE)
    {
        searchInList(m_damageList);
    }
    else
    {
        searchInList(m_gaList);
        searchInList(m_damageList);
        searchInList(m_buffList);
        searchInList(m_debuffList);
        searchInList(m_healList);
        searchInList(m_naList);
        searchInList(m_raiseList);
    }

    // Assume the highest ID is the best (back of the vector)
    // TODO: These will need to be organised by family, then merged
    return (!matches.empty()) ? std::optional<SpellID>{ matches.back() } : std::nullopt;
}

std::optional<SpellID> CMobSpellContainer::GetBestIndiSpell(CBattleEntity* PTarget)
{
    auto mJob          = PTarget->GetMJob();
    auto mTarget       = PTarget->GetBattleTarget();
    auto hitrate       = battleutils::GetHitRate(PTarget, mTarget);
    bool accBuffNeeded = hitrate < 65 ? true : false;
    auto mInt          = PTarget->getMod(Mod::INT);
    auto tInt          = mTarget->getMod(Mod::INT);
    auto intDiff       = mInt - tInt + 10;
    auto macc          = PTarget->getMod(Mod::MACC);
    auto tMaeva        = mTarget->getMod(Mod::MEVA);
    auto mSkill        = PTarget->GetSkill(SKILL_ELEMENTAL_MAGIC);
    auto maccFromInt   = mInt;

    if (mInt > tInt + 10)
    {
        maccFromInt = tInt + ((mInt - intDiff) * 0.5);
    }

    auto totalMacc      = mSkill + maccFromInt + macc;
    auto magicHitRate   = float(totalMacc - tMaeva) / 10;
    bool mAccBuffNeeded = magicHitRate < 10 ? true : false;

    std::optional<SpellID> choice    = std::nullopt;
    std::optional<SpellID> subChoice = SpellID::Indi_Regen;

    switch (mJob)
    {
        case JOB_WAR:
        case JOB_MNK:
        case JOB_THF:
        case JOB_DRK:
        case JOB_BST:
        case JOB_RNG:
        case JOB_SAM:
        case JOB_DRG:
        case JOB_BLU:
        case JOB_COR:
        case JOB_PUP:
        case JOB_DNC:
        {
            if (accBuffNeeded)
            {
                choice = SpellID::Indi_Precision;
            }
            else
            {
                choice = SpellID::Indi_Fury;
            }
            subChoice = SpellID::Indi_Regen;
            break;
        }
        case JOB_WHM:
        case JOB_BRD:
        case JOB_SMN:
        case JOB_GEO:
        {
            choice    = SpellID::Indi_Refresh;
            subChoice = SpellID::Indi_Refresh;
            break;
        }
        case JOB_BLM:
        case JOB_RDM:
        case JOB_SCH:
        {
            if (mAccBuffNeeded)
            {
                choice = SpellID::Indi_Focus;
            }
            else
            {
                choice = SpellID::Indi_Acumen;
            }
            subChoice = SpellID::Indi_Refresh;
            break;
        }
        case JOB_PLD:
        case JOB_RUN:
        case JOB_NIN:
        {
            choice    = SpellID::Indi_Haste;
            subChoice = SpellID::Indi_Regen;
            break;
        }
        default:
            break;
    }

    if (PTarget->GetMLevel() < 20)
    {
        choice = std::nullopt;
    }
    else if (PTarget->GetMLevel() < 93)
    {
        choice = subChoice;
        if (subChoice == SpellID::Indi_Refresh && PTarget->GetMLevel() < 30)
        {
            choice = SpellID::Indi_Regen;
        }
    }

    return choice;
}

std::optional<SpellID> CMobSpellContainer::GetBestEntrustedSpell(CBattleEntity* PTarget)
{
    auto                   mastersJob = PTarget->GetMJob();
    std::optional<SpellID> choice     = std::nullopt;

    switch (mastersJob)
    {
        case JOB_WAR:
        case JOB_MNK:
        case JOB_THF:
        case JOB_DRK:
        case JOB_BST:
        case JOB_RNG:
        case JOB_SAM:
        case JOB_DRG:
        case JOB_BLU:
        case JOB_COR:
        case JOB_PUP:
        case JOB_DNC:
            choice = SpellID::Indi_Frailty;
            break;
        case JOB_WHM:
        case JOB_BRD:
        case JOB_SMN:
            choice = SpellID::Indi_Acumen;
            break;
        case JOB_BLM:
        case JOB_RDM:
        case JOB_SCH:
        case JOB_PLD:
        case JOB_RUN:
            choice = SpellID::Indi_Refresh;
            break;
        case JOB_NIN:
            choice = SpellID::Indi_Regen;
            break;
        case JOB_GEO:
            break;
        default:
            break;
    }

    return choice;
}

std::optional<SpellID> CMobSpellContainer::GetBestAgainstTargetWeakness(CBattleEntity* PTarget, SpellID spellId)
{
    // Look up what the target has the _least resistance to_:
    // clang-format off
    std::vector<int16> resistances
    {
        PTarget->getMod(Mod::FIRE_RES_RANK),
        PTarget->getMod(Mod::ICE_RES_RANK),
        PTarget->getMod(Mod::WIND_RES_RANK),
        PTarget->getMod(Mod::EARTH_RES_RANK),
        PTarget->getMod(Mod::THUNDER_RES_RANK),
        PTarget->getMod(Mod::WATER_RES_RANK),
        PTarget->getMod(Mod::LIGHT_RES_RANK),
        PTarget->getMod(Mod::DARK_RES_RANK),
    };
    // clang-format on

    std::size_t            weakestIndex     = std::distance(resistances.begin(), std::min_element(resistances.begin(), resistances.end()));
    std::optional<SpellID> choice           = std::nullopt;
    auto                   Weakness_Element = weakestIndex + 1;
    if (spell::GetSpell(spellId) != 0)
    {
        auto Spell_Element = spell::GetSpell(spellId)->getElement();
        if (Spell_Element == Weakness_Element)
        {
            return spellId;
        }
    }
    switch (Weakness_Element) // Adjust to ignore ELEMENT_NONE
    {
        case ELEMENT_FIRE:
        {
            choice = GetBestAvailable(SPELLFAMILY_FIRE);
            break;
        }
        case ELEMENT_ICE:
        {
            choice = GetBestAvailable(SPELLFAMILY_BLIZZARD);
            break;
        }
        case ELEMENT_WIND:
        {
            choice = GetBestAvailable(SPELLFAMILY_AERO);
            break;
        }
        case ELEMENT_EARTH:
        {
            choice = GetBestAvailable(SPELLFAMILY_STONE);
            break;
        }
        case ELEMENT_THUNDER:
        {
            choice = GetBestAvailable(SPELLFAMILY_THUNDER);
            break;
        }
        case ELEMENT_WATER:
        {
            choice = GetBestAvailable(SPELLFAMILY_WATER);
            break;
        }
        case ELEMENT_LIGHT:
        {
            choice = GetBestAvailable(SPELLFAMILY_BANISH);
            break;
        }
        case ELEMENT_DARK:
        {
            choice = GetBestAvailable(SPELLFAMILY_DRAIN);
            break;
        }
    }
    // If all else fails, just cast the best you have!
    return !choice ? GetBestAvailable(SPELLFAMILY_NONE) : choice;
}

std::optional<SpellID> CMobSpellContainer::EnSpellAgainstTargetWeakness(CBattleEntity* PTarget)
{
    // Look up what the target has the _least resistance to_:
    // clang-format off
    std::vector<int16> resistances
    {
        PTarget->getMod(Mod::FIRE_RES_RANK),
        PTarget->getMod(Mod::ICE_RES_RANK),
        PTarget->getMod(Mod::WIND_RES_RANK),
        PTarget->getMod(Mod::EARTH_RES_RANK),
        PTarget->getMod(Mod::THUNDER_RES_RANK),
        PTarget->getMod(Mod::WATER_RES_RANK),
        PTarget->getMod(Mod::LIGHT_RES_RANK),
        PTarget->getMod(Mod::DARK_RES_RANK),
    };
    // clang-format on

    std::size_t weakestIndex = std::distance(resistances.begin(), std::min_element(resistances.begin(), resistances.end()));

    // TODO: Figure this out properly:
    std::optional<SpellID> choice = std::nullopt;
    switch (weakestIndex + 1) // Adjust to ignore ELEMENT_NONE
    {
        case ELEMENT_FIRE:
        {
            choice = GetBestAvailable(SPELLFAMILY_ENFIRE);
            break;
        }
        case ELEMENT_ICE:
        {
            choice = GetBestAvailable(SPELLFAMILY_ENBLIZZARD);
            break;
        }
        case ELEMENT_WIND:
        {
            choice = GetBestAvailable(SPELLFAMILY_ENAERO);
            break;
        }
        case ELEMENT_EARTH:
        {
            choice = GetBestAvailable(SPELLFAMILY_ENSTONE);
            break;
        }
        case ELEMENT_THUNDER:
        {
            choice = GetBestAvailable(SPELLFAMILY_ENTHUNDER);
            break;
        }
        case ELEMENT_WATER:
        {
            choice = GetBestAvailable(SPELLFAMILY_ENWATER);
            break;
        }
    }
    return choice;
}

std::optional<SpellID> CMobSpellContainer::StormDayAgainstTargetWeakness(CBattleEntity* PTarget)
{
    // Look up what the target has the _least resistance to_:
    // clang-format off
    std::vector<int16> resistances
    {
        PTarget->getMod(Mod::FIRE_RES_RANK),
        PTarget->getMod(Mod::ICE_RES_RANK),
        PTarget->getMod(Mod::WIND_RES_RANK),
        PTarget->getMod(Mod::EARTH_RES_RANK),
        PTarget->getMod(Mod::THUNDER_RES_RANK),
        PTarget->getMod(Mod::WATER_RES_RANK),
        PTarget->getMod(Mod::LIGHT_RES_RANK),
        PTarget->getMod(Mod::DARK_RES_RANK),
    };
    // clang-format on

    std::size_t weakestIndex = std::distance(resistances.begin(), std::min_element(resistances.begin(), resistances.end()));

    // TODO: Figure this out properly:
    std::optional<SpellID> choice = std::nullopt;
    switch (weakestIndex + 1) // Adjust to ignore ELEMENT_NONE
    {
        case ELEMENT_FIRE:
        {
            choice = GetBestAvailable(SPELLFAMILY_FIRESTORM);
            break;
        }
        case ELEMENT_ICE:
        {
            choice = GetBestAvailable(SPELLFAMILY_HAILSTORM);
            break;
        }
        case ELEMENT_WIND:
        {
            choice = GetBestAvailable(SPELLFAMILY_WINDSTORM);
            break;
        }
        case ELEMENT_EARTH:
        {
            choice = GetBestAvailable(SPELLFAMILY_SANDSTORM);
            break;
        }
        case ELEMENT_THUNDER:
        {
            choice = GetBestAvailable(SPELLFAMILY_THUNDERSTORM);
            break;
        }
        case ELEMENT_WATER:
        {
            choice = GetBestAvailable(SPELLFAMILY_RAINSTORM);
            break;
        }
        case ELEMENT_LIGHT:
        {
            choice = GetBestAvailable(SPELLFAMILY_AURORASTORM);
            break;
        }
        case ELEMENT_DARK:
        {
            choice = GetBestAvailable(SPELLFAMILY_VOIDSTORM);
            break;
        }
    }
    return choice;
}

std::optional<SpellID> CMobSpellContainer::HelixAgainstTargetWeakness(CBattleEntity* PTarget)
{
    // Look up what the target has the _least resistance to_:
    // clang-format off
    std::vector<int16> resistances
    {
        PTarget->getMod(Mod::FIRE_RES_RANK),
        PTarget->getMod(Mod::ICE_RES_RANK),
        PTarget->getMod(Mod::WIND_RES_RANK),
        PTarget->getMod(Mod::EARTH_RES_RANK),
        PTarget->getMod(Mod::THUNDER_RES_RANK),
        PTarget->getMod(Mod::WATER_RES_RANK),
        PTarget->getMod(Mod::LIGHT_RES_RANK),
        PTarget->getMod(Mod::DARK_RES_RANK),
    };
    // clang-format on

    std::size_t weakestIndex = std::distance(resistances.begin(), std::min_element(resistances.begin(), resistances.end()));

    // TODO: Figure this out properly:
    std::optional<SpellID> choice = std::nullopt;
    switch (weakestIndex + 1) // Adjust to ignore ELEMENT_NONE
    {
        case ELEMENT_FIRE:
        {
            choice = GetBestAvailable(SPELLFAMILY_PYROHELIX);
            break;
        }
        case ELEMENT_ICE:
        {
            choice = GetBestAvailable(SPELLFAMILY_CRYOHELIX);
            break;
        }
        case ELEMENT_WIND:
        {
            choice = GetBestAvailable(SPELLFAMILY_ANEMOHELIX);
            break;
        }
        case ELEMENT_EARTH:
        {
            choice = GetBestAvailable(SPELLFAMILY_GEOHELIX);
            break;
        }
        case ELEMENT_THUNDER:
        {
            choice = GetBestAvailable(SPELLFAMILY_IONOHELIX);
            break;
        }
        case ELEMENT_WATER:
        {
            choice = GetBestAvailable(SPELLFAMILY_HYDROHELIX);
            break;
        }
        case ELEMENT_LIGHT:
        {
            choice = GetBestAvailable(SPELLFAMILY_LUMINOHELIX);
            break;
        }
        case ELEMENT_DARK:
        {
            choice = GetBestAvailable(SPELLFAMILY_NOCTOHELIX);
            break;
        }
    }
    return choice;
}

std::optional<SpellID> CMobSpellContainer::GetStormDay()
{
    std::optional<SpellID> choice    = std::nullopt;
    std::size_t            dotwIndex = battleutils::GetDayElement();
    switch (dotwIndex)
    {
        case ELEMENT_FIRE:
        {
            choice = GetBestAvailable(SPELLFAMILY_FIRESTORM);
            break;
        }
        case ELEMENT_ICE:
        {
            choice = GetBestAvailable(SPELLFAMILY_HAILSTORM);
            break;
        }
        case ELEMENT_WIND:
        {
            choice = GetBestAvailable(SPELLFAMILY_WINDSTORM);
            break;
        }
        case ELEMENT_EARTH:
        {
            choice = GetBestAvailable(SPELLFAMILY_SANDSTORM);
            break;
        }
        case ELEMENT_THUNDER:
        {
            choice = GetBestAvailable(SPELLFAMILY_THUNDERSTORM);
            break;
        }
        case ELEMENT_WATER:
        {
            choice = GetBestAvailable(SPELLFAMILY_RAINSTORM);
            break;
        }
        case ELEMENT_LIGHT:
        {
            choice = GetBestAvailable(SPELLFAMILY_AURORASTORM);
            break;
        }
        case ELEMENT_DARK:
        {
            choice = GetBestAvailable(SPELLFAMILY_VOIDSTORM);
            break;
        }
    }
    return choice;
}

std::optional<SpellID> CMobSpellContainer::GetHelixDay()
{
    std::optional<SpellID> choice    = std::nullopt;
    std::size_t            dotwIndex = battleutils::GetDayElement();
    switch (dotwIndex)
    {
        case ELEMENT_FIRE:
        {
            choice = GetBestAvailable(SPELLFAMILY_PYROHELIX);
            break;
        }
        case ELEMENT_ICE:
        {
            choice = GetBestAvailable(SPELLFAMILY_CRYOHELIX);
            break;
        }
        case ELEMENT_WIND:
        {
            choice = GetBestAvailable(SPELLFAMILY_ANEMOHELIX);
            break;
        }
        case ELEMENT_EARTH:
        {
            choice = GetBestAvailable(SPELLFAMILY_GEOHELIX);
            break;
        }
        case ELEMENT_THUNDER:
        {
            choice = GetBestAvailable(SPELLFAMILY_IONOHELIX);
            break;
        }
        case ELEMENT_WATER:
        {
            choice = GetBestAvailable(SPELLFAMILY_HYDROHELIX);
            break;
        }
        case ELEMENT_LIGHT:
        {
            choice = GetBestAvailable(SPELLFAMILY_LUMINOHELIX);
            break;
        }
        case ELEMENT_DARK:
        {
            choice = GetBestAvailable(SPELLFAMILY_NOCTOHELIX);
            break;
        }
    }
    return choice;
}

bool CMobSpellContainer::HasSpells() const
{
    return m_hasSpells;
}

bool CMobSpellContainer::HasMPSpells() const
{
    for (auto spell : m_damageList)
    {
        if (spell::GetSpell(spell)->hasMPCost())
        {
            return true;
        }
    }

    for (auto spell : m_buffList)
    {
        if (spell::GetSpell(spell)->hasMPCost())
        {
            return true;
        }
    }

    return false;
}

std::optional<SpellID> CMobSpellContainer::GetAggroSpell()
{
    // high chance to return ga spell
    if (HasGaSpells() && xirand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_GA_CHANCE))
    {
        return GetGaSpell();
    }

    // else to return damage spell
    return GetDamageSpell();
}

std::optional<SpellID> CMobSpellContainer::GetSpell()
{
    // prioritize curing if health low enough
    if (HasHealSpells() && m_PMob->GetHPP() <= m_PMob->getMobMod(MOBMOD_HP_HEAL_CHANCE) &&
        xirand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_HEAL_CHANCE))
    {
        return GetHealSpell();
    }

    // almost always use na if I can
    if (HasNaSpells() && xirand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_NA_CHANCE))
    {
        // will return -1 if no proper na spell exists
        auto naSpell = GetNaSpell();
        if (naSpell)
        {
            return naSpell.value();
        }
    }

    // try something really destructive
    if (HasSevereSpells() && xirand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_SEVERE_SPELL_CHANCE))
    {
        return GetSevereSpell();
    }

    // try ga spell
    if (HasGaSpells() && xirand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_GA_CHANCE))
    {
        return GetGaSpell();
    }

    if (HasBuffSpells() && xirand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_BUFF_CHANCE))
    {
        return GetBuffSpell();
    }

    // Grab whatever spell can be found
    // starting from damage spell
    if (HasDamageSpells())
    {
        // try damage spell
        return GetDamageSpell();
    }

    if (HasDebuffSpells())
    {
        return GetDebuffSpell();
    }

    if (HasBuffSpells())
    {
        return GetBuffSpell();
    }

    if (HasGaSpells())
    {
        return GetGaSpell();
    }

    if (HasHealSpells())
    {
        return GetHealSpell();
    }

    // Got no spells to use
    return {};
}

std::optional<SpellID> CMobSpellContainer::GetGaSpell()
{
    if (m_gaList.empty())
    {
        return {};
    }

    return m_gaList[xirand::GetRandomNumber(m_gaList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetDamageSpell()
{
    if (m_damageList.empty())
    {
        return {};
    }

    return m_damageList[xirand::GetRandomNumber(m_damageList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetBuffSpell()
{
    if (m_buffList.empty())
    {
        return {};
    }

    return m_buffList[xirand::GetRandomNumber(m_buffList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetDebuffSpell()
{
    if (m_debuffList.empty())
    {
        return {};
    }

    return m_debuffList[xirand::GetRandomNumber(m_debuffList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetHealSpell()
{
    if (m_PMob->m_EcoSystem == ECOSYSTEM::UNDEAD || m_healList.empty())
    {
        return {};
    }

    return m_healList[xirand::GetRandomNumber(m_healList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetNaSpell()
{
    if (m_naList.empty())
    {
        return {};
    }

    // paralyna
    if (HasNaSpell(SpellID::Paralyna) && m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_PARALYSIS))
    {
        return SpellID::Paralyna;
    }

    // cursna
    if (HasNaSpell(SpellID::Cursna) && m_PMob->StatusEffectContainer->HasStatusEffect({ EFFECT_CURSE, EFFECT_CURSE_II }))
    {
        return SpellID::Cursna;
    }

    // erase
    if (HasNaSpell(SpellID::Erase) && m_PMob->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_ERASABLE))
    {
        return SpellID::Erase;
    }

    // blindna
    if (HasNaSpell(SpellID::Blindna) && m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_BLINDNESS))
    {
        return SpellID::Blindna;
    }

    // poisona
    if (HasNaSpell(SpellID::Poisona) && m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_POISON))
    {
        return SpellID::Poisona;
    }

    // viruna? whatever ignore
    // silena ignore
    // stona ignore

    return {};
}

std::optional<SpellID> CMobSpellContainer::GetSevereSpell()
{
    if (m_severeList.empty())
    {
        return {};
    }

    return m_severeList[xirand::GetRandomNumber(m_severeList.size())];
}

bool CMobSpellContainer::HasGaSpells() const
{
    return !m_gaList.empty();
}

bool CMobSpellContainer::HasDamageSpells() const
{
    return !m_damageList.empty();
}

bool CMobSpellContainer::HasBuffSpells() const
{
    return !m_buffList.empty();
}

bool CMobSpellContainer::HasHealSpells() const
{
    return !m_healList.empty();
}

bool CMobSpellContainer::HasNaSpells() const
{
    return !m_naList.empty();
}

bool CMobSpellContainer::HasRaiseSpells() const
{
    return !m_raiseList.empty();
}

bool CMobSpellContainer::HasDebuffSpells() const
{
    return !m_debuffList.empty();
}

bool CMobSpellContainer::HasSevereSpells() const
{
    return !m_severeList.empty();
}

bool CMobSpellContainer::HasNaSpell(SpellID spellId) const
{
    for (auto spell : m_naList)
    {
        if (spell == spellId)
        {
            return true;
        }
    }
    return false;
}
