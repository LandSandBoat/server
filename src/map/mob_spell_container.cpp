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
#include "utils/battleutils.h"
#include "status_effect_container.h"
#include "recast_container.h"
#include "mob_modifier.h"

CMobSpellContainer::CMobSpellContainer(CMobEntity* PMob)
{
    m_PMob = PMob;
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
    m_hasSpells = false;
}

void CMobSpellContainer::AddSpell(SpellID spellId)
{
    // get spell
    CSpell* spell = spell::GetSpell(spellId);

    if(spell == nullptr){
        ShowDebug("Missing spellID = %d, given to mob. Check spell_list.sql\n", static_cast<uint16>(spellId));
        return;
    }

    m_hasSpells = true;

    // add spell to correct vector
    // try to add it to ga list first
    uint8 aoe = battleutils::GetSpellAoEType(m_PMob, spell);
    if(aoe > 0 && spell->canTargetEnemy())
    {
        m_gaList.push_back(spellId);
    }
    else if (spell->isSevere())
    {
        // select spells like death and impact
        m_severeList.push_back(spellId);
    }
    else if (spell->canTargetEnemy() && !spell->isSevere())
    {
        // add to damage list
        m_damageList.push_back(spellId);
    }
    else if (spell->isDebuff())
    {
        m_debuffList.push_back(spellId);
    }
    else if(spell->isNa())
    {
        // na spell and erase
        m_naList.push_back(spellId);
    }
    else if(spell->isHeal()){ // includes blue mage healing spells, wild carrot etc
   // add to healing
        m_healList.push_back(spellId);

    }
    else if(spell->isBuff()){
        // buff
        m_buffList.push_back(spellId);

    }
    else {
        ShowDebug("Where does this spell go? %d\n", static_cast<uint16>(spellId));
    }
}

void CMobSpellContainer::RemoveSpell(SpellID spellId)
{
    auto findAndRemove = [](std::vector<SpellID>& list, SpellID id)
    {
        list.erase(std::remove(list.begin(), list.end(), id), list.end());
    };

    findAndRemove(m_gaList, spellId);
    findAndRemove(m_damageList, spellId);
    findAndRemove(m_buffList, spellId);
    findAndRemove(m_debuffList, spellId);
    findAndRemove(m_healList, spellId);
    findAndRemove(m_naList, spellId);

    m_hasSpells = !(m_gaList.empty() && m_damageList.empty() && m_buffList.empty() && m_debuffList.empty() && m_healList.empty() && m_naList.empty());
}

std::optional<SpellID> CMobSpellContainer::GetAvailable(SpellID spellId)
{
    auto spell = spell::GetSpell(spellId);
    bool hasEnoughMP = spell->getMPCost() <= m_PMob->health.mp;
    bool isNotInRecast = !m_PMob->PRecastContainer->Has(RECAST_MAGIC, static_cast<uint16>(spellId));

    return  (isNotInRecast && hasEnoughMP) ? std::optional<SpellID>(spellId) : std::nullopt;
}

std::optional<SpellID> CMobSpellContainer::GetBestAvailable(SPELLFAMILY family)
{
    std::vector<SpellID> matches;
    auto searchInList = [&](std::vector<SpellID>& list)
    {
        for (auto id : list)
        {
            auto spell = spell::GetSpell(id);
            bool sameFamily = (family == SPELLFAMILY_NONE) ? true : spell->getSpellFamily() == family;
            bool hasEnoughMP = spell->getMPCost() <= m_PMob->health.mp;
            bool isNotInRecast = !m_PMob->PRecastContainer->Has(RECAST_MAGIC, static_cast<uint16>(id));
            if (sameFamily && hasEnoughMP && isNotInRecast)
            {
                matches.push_back(id);
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
    }

    // Assume the highest ID is the best (back of the vector)
    // TODO: These will need to be organised by family, then merged
    return (!matches.empty()) ? std::optional<SpellID>{ matches.back() } : std::nullopt;
}

bool CMobSpellContainer::HasSpells() const
{
    return m_hasSpells;
}

bool CMobSpellContainer::HasMPSpells() const
{
    for(auto spell : m_damageList)
    {
        if(spell::GetSpell(spell)->hasMPCost()){
            return true;
        }
    }

    for(auto spell : m_buffList)
    {
        if(spell::GetSpell(spell)->hasMPCost()){
            return true;
        }
    }

    return false;
}

std::optional<SpellID> CMobSpellContainer::GetAggroSpell()
{
    // high chance to return ga spell
    if(HasGaSpells() && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_GA_CHANCE)){
        return GetGaSpell();
    }

    // else to return damage spell
    return GetDamageSpell();
}

std::optional<SpellID> CMobSpellContainer::GetSpell()
{
    // prioritize curing if health low enough
    if(HasHealSpells() && m_PMob->GetHPP() <= m_PMob->getMobMod(MOBMOD_HP_HEAL_CHANCE) && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_HEAL_CHANCE)){
        return GetHealSpell();
    }

    // almost always use na if I can
    if(HasNaSpells() && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_NA_CHANCE)){
        // will return -1 if no proper na spell exists
        auto naSpell = GetNaSpell();
        if(naSpell){
            return naSpell.value();
        }
    }

    // try something really destructive
    if (HasSevereSpells() && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_SEVERE_SPELL_CHANCE))
    {
        return GetSevereSpell();
    }

    // try ga spell
    if(HasGaSpells() && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_GA_CHANCE)){
        return GetGaSpell();
    }

    if(HasBuffSpells() && tpzrand::GetRandomNumber(100) < m_PMob->getMobMod(MOBMOD_BUFF_CHANCE)){
        return GetBuffSpell();
    }

    // Grab whatever spell can be found
    // starting from damage spell
    if(HasDamageSpells())
    {
        // try damage spell
        return GetDamageSpell();
    }

    if (HasDebuffSpells())
    {
        return GetDebuffSpell();
    }

    if(HasBuffSpells())
    {
        return GetBuffSpell();
    }

    if(HasGaSpells())
    {
        return GetGaSpell();
    }

    if(HasHealSpells())
    {
        return GetHealSpell();
    }

    // Got no spells to use
    return {};
}

std::optional<SpellID> CMobSpellContainer::GetGaSpell()
{
    if(m_gaList.empty()) return {};

    return m_gaList[tpzrand::GetRandomNumber(m_gaList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetDamageSpell()
{
    if(m_damageList.empty()) return {};

    return m_damageList[tpzrand::GetRandomNumber(m_damageList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetBuffSpell()
{
    if(m_buffList.empty()) return {};

    return m_buffList[tpzrand::GetRandomNumber(m_buffList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetDebuffSpell()
{
    if (m_debuffList.empty()) return {};

    return m_debuffList[tpzrand::GetRandomNumber(m_debuffList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetHealSpell()
{
    if(m_PMob->m_EcoSystem == SYSTEM_UNDEAD || m_healList.empty()) return {};

    return m_healList[tpzrand::GetRandomNumber(m_healList.size())];
}

std::optional<SpellID> CMobSpellContainer::GetNaSpell()
{
    if(m_naList.empty()) return {};

    // paralyna
    if(HasNaSpell(SpellID::Paralyna) && m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_PARALYSIS)) {
        return SpellID::Paralyna;
    }

    // cursna
    if(HasNaSpell(SpellID::Cursna) && m_PMob->StatusEffectContainer->HasStatusEffect({EFFECT_CURSE, EFFECT_CURSE_II})){
        return SpellID::Cursna;
    }

    // erase
    if(HasNaSpell(SpellID::Erase) && m_PMob->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_ERASABLE)){
        return SpellID::Erase;
    }

    // blindna
    if(HasNaSpell(SpellID::Blindna) && m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_BLINDNESS)){
        return SpellID::Blindna;
    }

    // poisona
    if(HasNaSpell(SpellID::Poisona) && m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_POISON)){
        return SpellID::Poisona;
    }

    // viruna? whatever ignore
    // silena ignore
    // stona ignore

    return {};
}

std::optional<SpellID> CMobSpellContainer::GetSevereSpell()
{
    if(m_severeList.empty()) return {};

    return m_severeList[tpzrand::GetRandomNumber(m_severeList.size())];
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
    for(auto spell : m_naList)
    {
        if(spell == spellId)
        {
            return true;
        }
    }
    return false;
}
