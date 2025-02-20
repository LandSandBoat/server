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

#include <array>
#include <cstring>

#include "lua/luautils.h"

#include "blue_spell.h"
#include "items/item_weapon.h"
#include "map.h"
#include "mob_spell_list.h"
#include "spell.h"
#include "status_effect_container.h"
#include "utils/blueutils.h"

CSpell::CSpell(SpellID id)
: m_ID(id)
{
}

std::unique_ptr<CSpell> CSpell::clone()
{
    // no make_unique because it requires the copy constructor to be public
    return std::unique_ptr<CSpell>(new CSpell(*this));
}

void CSpell::setTotalTargets(uint16 total)
{
    m_totalTargets = total;
}

uint16 CSpell::getTotalTargets() const
{
    return m_totalTargets;
}

void CSpell::setID(SpellID id)
{
    m_ID = id;
}

SpellID CSpell::getID()
{
    return m_ID;
}

uint8 CSpell::getJob(JOBTYPE JobID)
{
    return (m_job[JobID] == CANNOT_USE_SPELL ? 255 : m_job[JobID]);
}

void CSpell::setJob(int8* jobs)
{
    std::memcpy(&m_job[1], jobs, 22);
}

uint32 CSpell::getCastTime() const
{
    return m_castTime;
}

void CSpell::setCastTime(uint32 CastTime)
{
    m_castTime = CastTime;
}

uint32 CSpell::getRecastTime() const
{
    return m_recastTime;
}

void CSpell::setRecastTime(uint32 RecastTime)
{
    m_recastTime = RecastTime;
}

const std::string& CSpell::getName()
{
    return m_name;
}

void CSpell::setName(const std::string& name)
{
    m_name = name;
}

SPELLGROUP CSpell::getSpellGroup()
{
    return m_spellGroup;
}

SPELLFAMILY CSpell::getSpellFamily()
{
    return m_spellFamily;
}

void CSpell::setSpellGroup(SPELLGROUP SpellGroup)
{
    m_spellGroup = SpellGroup;
}

void CSpell::setSpellFamily(SPELLFAMILY SpellFamily)
{
    m_spellFamily = SpellFamily;
}

uint8 CSpell::getSkillType() const
{
    return m_skillType;
}

void CSpell::setSkillType(uint8 SkillType)
{
    m_skillType = SkillType;
}

bool CSpell::isBuff() const
{
    return (getValidTarget() & TARGET_SELF) && !(getValidTarget() & TARGET_ENEMY);
}

bool CSpell::tookEffect() const
{
    return !(m_message == 75 || m_message == 284 || m_message == 283 || m_message == 85);
}

bool CSpell::hasMPCost()
{
    return m_spellGroup != SPELLGROUP_SONG && m_spellGroup != SPELLGROUP_NINJUTSU && m_spellGroup != SPELLGROUP_TRUST;
}

bool CSpell::isHeal()
{
    return ((getValidTarget() & TARGET_SELF) && getSkillType() == SKILL_HEALING_MAGIC) || m_ID == SpellID::Pollen || m_ID == SpellID::Wild_Carrot ||
           m_ID == SpellID::Healing_Breeze || m_ID == SpellID::Magic_Fruit;
}

bool CSpell::isCure()
{
    return ((static_cast<uint16>(m_ID) >= 1 && static_cast<uint16>(m_ID) <= 11) || m_ID == SpellID::Cura || m_ID == SpellID::Cura_II ||
            m_ID == SpellID::Cura_III);
}

bool CSpell::isDebuff()
{
    return ((getValidTarget() & TARGET_ENEMY) && getSkillType() == SKILL_ENFEEBLING_MAGIC) || m_spellFamily == SPELLFAMILY_ELE_DOT ||
           m_spellFamily == SPELLFAMILY_BIO || m_ID == SpellID::Stun || m_ID == SpellID::Curse;
}

bool CSpell::isNa()
{
    return (static_cast<uint16>(m_ID) >= 14 && static_cast<uint16>(m_ID) <= 20) || m_ID == SpellID::Erase;
}

bool CSpell::isRaise()
{
    return (static_cast<uint16>(m_ID) >= 12 && static_cast<uint16>(m_ID) <= 13) || m_ID == SpellID::Raise_III || m_ID == SpellID::Arise;
}

bool CSpell::isSevere()
{
    return m_ID == SpellID::Death || m_ID == SpellID::Impact || m_ID == SpellID::Meteor || m_ID == SpellID::Meteor_II || m_ID == SpellID::Comet;
}

bool CSpell::canHitShadow()
{
    return m_ID != SpellID::Meteor_II && canTargetEnemy();
}

bool CSpell::dealsDamage() const
{
    // damage or drain hp
    return m_message == 2 || m_message == 227 || m_message == 252 || m_message == 274;
}

float CSpell::getRadius() const
{
    return m_radius;
}

uint16 CSpell::getZoneMisc() const
{
    return m_zoneMisc;
}

void CSpell::setZoneMisc(uint16 Misc)
{
    m_zoneMisc = Misc;
}

uint16 CSpell::getAnimationID() const
{
    return m_animation;
}

void CSpell::setAnimationID(uint16 AnimationID)
{
    m_animation = AnimationID;
}

uint16 CSpell::getAnimationTime() const
{
    return m_animationTime;
}

void CSpell::setAnimationTime(uint16 AnimationTime)
{
    m_animationTime = AnimationTime;
}

uint16 CSpell::getMPCost() const
{
    return m_mpCost;
}

void CSpell::setMPCost(uint16 MP)
{
    m_mpCost = MP;
}

bool CSpell::canTargetEnemy() const
{
    return (getValidTarget() & TARGET_ENEMY) && !(getValidTarget() & TARGET_SELF);
}

uint8 CSpell::getAOE() const
{
    return m_AOE;
}

void CSpell::setAOE(uint8 AOE)
{
    m_AOE = AOE;
}

uint16 CSpell::getBase() const
{
    return m_base;
}

void CSpell::setBase(uint16 base)
{
    m_base = base;
}

uint16 CSpell::getValidTarget() const
{
    return m_ValidTarget;
}

void CSpell::setValidTarget(uint16 ValidTarget)
{
    m_ValidTarget = ValidTarget;
}

float CSpell::getMultiplier() const
{
    return m_multiplier;
}

void CSpell::setMultiplier(float multiplier)
{
    m_multiplier = multiplier;
}

uint16 CSpell::getMessage() const
{
    return m_message;
}

uint16 CSpell::getAoEMessage() const
{
    switch (m_message)
    {
        case 7: // recovers HP
            return 367;
        case 93: // vanishes
            return 273;
        case 85: // resists
            return 284;
        case 230:       // casts gain the effect of
            return 266; // gains the effect of
        case 236:       // is blind
            // return 203;
            return 277;
            // 279
        case 237: // if its a damage spell msg and is hitting the 2nd+ target
            return 278;
        case 2: // if its a damage spell msg and is hitting the 2nd+ target
            return 264;
        default:
            return m_message;
    }
}

void CSpell::setMessage(uint16 message)
{
    m_message = message;
}

uint16 CSpell::getMagicBurstMessage() const
{
    return m_MagicBurstMessage;
}

void CSpell::setMagicBurstMessage(uint16 message)
{
    m_MagicBurstMessage = message;
}

MODIFIER CSpell::getModifier()
{
    return m_MessageModifier;
}

void CSpell::setModifier(MODIFIER modifier)
{
    m_MessageModifier = modifier;
}

void CSpell::setPrimaryTargetID(uint32 targid)
{
    m_primaryTargetID = targid;
}

uint16 CSpell::getElement() const
{
    return m_element;
}

void CSpell::setElement(uint16 element)
{
    m_element = element;
}

void CSpell::setCE(uint16 ce)
{
    m_CE = ce;
}

uint16 CSpell::getCE() const
{
    return m_CE;
}

void CSpell::setRadius(float radius)
{
    m_radius = radius;
}

void CSpell::setVE(uint16 ve)
{
    m_VE = ve;
}

uint16 CSpell::getVE() const
{
    return m_VE;
}

void CSpell::setModifiedRecast(uint32 mrec)
{
    m_modifiedRecastTime = mrec;
}

uint32 CSpell::getModifiedRecast() const
{
    return m_modifiedRecastTime;
}

uint8 CSpell::getRequirements() const
{
    return m_requirements;
}

void CSpell::setRequirements(uint8 requirements)
{
    m_requirements = requirements;
}

uint16 CSpell::getMeritId() const
{
    return m_meritId;
}

void CSpell::setMeritId(uint16 meritId)
{
    m_meritId = meritId;
}

uint8 CSpell::getFlag() const
{
    return m_flag;
}

void CSpell::setFlag(uint8 flag)
{
    m_flag = flag;
}

const std::string& CSpell::getContentTag()
{
    return m_contentTag;
}

float CSpell::getRange() const
{
    return m_range;
}

uint32 CSpell::getPrimaryTargetID() const
{
    return m_primaryTargetID;
}

void CSpell::setContentTag(const std::string& contentTag)
{
    m_contentTag = contentTag;
}

void CSpell::setRange(float range)
{
    m_range = range;
}

// Implement namespace to work with spells
namespace spell
{
    std::array<CSpell*, MAX_SPELL_ID> PSpellList;           // spell list
    std::map<uint16, uint16>          PMobSkillToBlueSpell; // maps the skill id (key) to spell id (value).

    // Load a list of spells
    void LoadSpellList()
    {
        const char* Query = "SELECT spellid, name, jobs, `group`, family, validTargets, skill, castTime, recastTime, animation, animationTime, mpCost, \
                             AOE, base, element, zonemisc, multiplier, message, magicBurstMessage, CE, VE, requirements, content_tag, spell_range \
                             FROM spell_list";

        int32 ret = _sql->Query(Query);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                CSpell* PSpell = nullptr;
                SpellID id     = (SpellID)_sql->GetUIntData(0);

                if ((SPELLGROUP)_sql->GetIntData(3) == SPELLGROUP_BLUE)
                {
                    PSpell = new CBlueSpell(id);
                }
                else
                {
                    PSpell = new CSpell(id);
                }

                PSpell->setName(_sql->GetStringData(1));
                PSpell->setJob(_sql->GetData(2));
                PSpell->setSpellGroup((SPELLGROUP)_sql->GetIntData(3));
                PSpell->setSpellFamily((SPELLFAMILY)_sql->GetIntData(4));
                PSpell->setValidTarget(_sql->GetIntData(5));
                PSpell->setSkillType(_sql->GetIntData(6));
                PSpell->setCastTime(_sql->GetIntData(7));
                PSpell->setRecastTime(_sql->GetIntData(8));
                PSpell->setAnimationID(_sql->GetIntData(9));
                PSpell->setAnimationTime(_sql->GetIntData(10));
                PSpell->setMPCost(_sql->GetIntData(11));
                PSpell->setAOE(_sql->GetIntData(12));
                PSpell->setBase(_sql->GetIntData(13));
                PSpell->setElement(_sql->GetIntData(14));
                PSpell->setZoneMisc(_sql->GetIntData(15));
                PSpell->setMultiplier((float)_sql->GetIntData(16));
                PSpell->setMessage(_sql->GetIntData(17));
                PSpell->setMagicBurstMessage(_sql->GetIntData(18));
                PSpell->setCE(_sql->GetIntData(19));
                PSpell->setVE(_sql->GetIntData(20));
                PSpell->setRequirements(_sql->GetIntData(21));
                PSpell->setContentTag(_sql->GetStringData(22));

                PSpell->setRange(static_cast<float>(_sql->GetIntData(23)) / 10);

                if (PSpell->getAOE())
                {
                    // default radius
                    PSpell->setRadius(10);
                }

                PSpellList[static_cast<uint16>(PSpell->getID())] = PSpell;

                auto filename = fmt::format("./scripts/actions/spells/{}.lua", PSpell->getName());

                std::string switchKey = "";
                switch (PSpell->getSpellGroup())
                {
                    case SPELLGROUP_WHITE:
                    {
                        switchKey = "white";
                    }
                    break;
                    case SPELLGROUP_BLACK:
                    {
                        switchKey = "black";
                    }
                    break;
                    case SPELLGROUP_SONG:
                    {
                        switchKey = "songs";
                    }
                    break;
                    case SPELLGROUP_NINJUTSU:
                    {
                        switchKey = "ninjutsu";
                    }
                    break;
                    case SPELLGROUP_SUMMONING:
                    {
                        switchKey = "summoning";
                    }
                    break;
                    case SPELLGROUP_BLUE:
                    {
                        switchKey = "blue";
                    }
                    break;
                    case SPELLGROUP_GEOMANCY:
                    {
                        switchKey = "geomancy";
                    }
                    break;
                    case SPELLGROUP_TRUST:
                    {
                        switchKey = "trust";
                    }
                    break;
                    default:
                    {
                        ShowError("spell::LoadSpellList: Spell %s doesnt have a SpellGroup", PSpell->getName());
                    }
                    break;
                }
                filename = fmt::format("./scripts/actions/spells/{}/{}.lua", switchKey, PSpell->getName());

                luautils::CacheLuaObjectFromFile(filename);
            }
        }

        const char* blueQuery = "SELECT blue_spell_list.spellid, blue_spell_list.mob_skill_id, blue_spell_list.set_points, \
                                blue_spell_list.trait_category, blue_spell_list.trait_category_weight, blue_spell_list.primary_sc, \
                                blue_spell_list.secondary_sc, blue_spell_list.tertiary_sc, spell_list.content_tag \
                             FROM blue_spell_list JOIN spell_list on blue_spell_list.spellid = spell_list.spellid";

        ret = _sql->Query(blueQuery);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                char* contentTag = (char*)_sql->GetData(8);
                if (!luautils::IsContentEnabled(contentTag))
                {
                    continue;
                }

                // Sanity check the spell ID
                uint16 spellId = _sql->GetIntData(0);

                if (PSpellList[spellId] == nullptr)
                {
                    ShowWarning("spell::LoadSpellList Tried to load nullptr blue spell (%u)", spellId);
                    continue;
                }

                ((CBlueSpell*)PSpellList[spellId])->setMonsterSkillId(_sql->GetIntData(1));
                ((CBlueSpell*)PSpellList[spellId])->setSetPoints(_sql->GetIntData(2));
                ((CBlueSpell*)PSpellList[spellId])->setTraitCategory(_sql->GetIntData(3));
                ((CBlueSpell*)PSpellList[spellId])->setTraitWeight(_sql->GetIntData(4));
                ((CBlueSpell*)PSpellList[spellId])->setPrimarySkillchain(_sql->GetIntData(5));
                ((CBlueSpell*)PSpellList[spellId])->setSecondarySkillchain(_sql->GetIntData(6));
                ((CBlueSpell*)PSpellList[spellId])->setTertiarySkillchain(_sql->GetIntData(7));
                PMobSkillToBlueSpell.insert(std::make_pair(_sql->GetIntData(1), spellId));
            }
        }
        ret = _sql->Query(
            "SELECT spellId, modId, value FROM blue_spell_mods WHERE spellId IN (SELECT spellId FROM spell_list LEFT JOIN blue_spell_list USING (spellId))");

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                uint16 spellId = (uint16)_sql->GetUIntData(0);
                Mod    modID   = static_cast<Mod>(_sql->GetUIntData(1));
                int16  value   = (int16)_sql->GetIntData(2);

                if (PSpellList[spellId])
                {
                    ((CBlueSpell*)PSpellList[spellId])->addModifier(CModifier(modID, value));
                }
            }
        }

        ret = _sql->Query("SELECT spellId, meritId, content_tag FROM spell_list INNER JOIN merits ON spell_list.name = merits.name");

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                char* contentTag = (char*)_sql->GetData(2);
                if (!luautils::IsContentEnabled(contentTag))
                {
                    continue;
                }

                uint16 spellId = (uint16)_sql->GetUIntData(0);

                if (PSpellList[spellId])
                {
                    PSpellList[spellId]->setMeritId(_sql->GetUIntData(1));
                }
            }
        }
    }

    CSpell* GetSpellByMonsterSkillId(uint16 SkillID)
    {
        std::map<uint16, uint16>::iterator it = PMobSkillToBlueSpell.find(SkillID);
        if (it == PMobSkillToBlueSpell.end())
        {
            return nullptr;
        }
        else
        {
            uint16 spellId = it->second;

            // False positive: this is CSpell*, so it's OK
            // cppcheck-suppress CastIntegerToAddressAtReturn
            return PSpellList[spellId];
        }
    }

    // Get Spell By ID
    CSpell* GetSpell(SpellID SpellID)
    {
        auto id = static_cast<uint16>(SpellID);
        if (id >= MAX_SPELL_ID)
        {
            ShowWarning("Spell ID (%d) exceeds MAX_SPELL_ID.", static_cast<uint16>(SpellID));
            return nullptr;
        }
        // False positive: this is CSpell*, so it's OK
        // cppcheck-suppress CastIntegerToAddressAtReturn
        return PSpellList[id];
    }

    bool CanUseSpell(CBattleEntity* PCaster, SpellID SpellID)
    {
        CSpell* spell = GetSpell(SpellID);
        return CanUseSpell(PCaster, spell);
    }

    // Check If user can cast spell
    bool CanUseSpell(CBattleEntity* PCaster, CSpell* spell)
    {
        if (spell == nullptr)
        {
            return false;
        }

        bool  usable       = false;
        uint8 requirements = 0;

        switch (PCaster->objtype)
        {
            case TYPE_MOB:
                // Unable to cast because caster is hidden or untargetable
                if (PCaster->IsNameHidden() || static_cast<CMobEntity*>(PCaster)->GetUntargetable())
                {
                    return false;
                }
                // Mobs can cast any non-given char spell
                return true;

            case TYPE_PC:
                if (spell->getSpellGroup() == SPELLGROUP_TRUST)
                {
                    return true; // every PC can use trusts
                }
                else if (luautils::OnCanUseSpell(PCaster, spell))
                {
                    return true;
                }
                [[fallthrough]];
            case TYPE_FELLOW:
            case TYPE_NPC:
                requirements = spell->getRequirements();

                // Make sure caster has the right main job and level
                if (PCaster->GetMLevel() >= spell->getJob(PCaster->GetMJob()))
                {
                    usable = true;
                    if (requirements & SPELLREQ_TABULA_RASA)
                    {
                        if (!PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_TABULA_RASA))
                        {
                            usable = false;
                        }
                    }
                    if (PCaster->GetMJob() == JOB_SCH)
                    {
                        if (requirements & SPELLREQ_ADDENDUM_BLACK)
                        {
                            if (!PCaster->StatusEffectContainer->HasStatusEffect({ EFFECT_ADDENDUM_BLACK, EFFECT_ENLIGHTENMENT }))
                            {
                                usable = false;
                            }
                        }
                        else if (requirements & SPELLREQ_ADDENDUM_WHITE)
                        {
                            if (!PCaster->StatusEffectContainer->HasStatusEffect({ EFFECT_ADDENDUM_WHITE, EFFECT_ENLIGHTENMENT }))
                            {
                                usable = false;
                            }
                        }
                    }
                    if (spell->getSpellGroup() == SPELLGROUP_BLUE && PCaster->objtype == TYPE_PC)
                    {
                        if (requirements & SPELLREQ_UNBRIDLED_LEARNING)
                        {
                            if (!PCaster->StatusEffectContainer->HasStatusEffect({ EFFECT_UNBRIDLED_LEARNING, EFFECT_UNBRIDLED_WISDOM }))
                            {
                                usable = false;
                            }
                        }
                        else if (!blueutils::IsSpellSet((CCharEntity*)PCaster, (CBlueSpell*)spell))
                        {
                            usable = false;
                        }
                    }
                    if (usable)
                    {
                        return true;
                    }
                }

                // Make sure caster has the right sub job and level
                if (PCaster->GetSLevel() >= spell->getJob(PCaster->GetSJob()) && !(requirements & SPELLREQ_MAIN_JOB_ONLY))
                {
                    usable = true;
                    if (requirements & SPELLREQ_TABULA_RASA)
                    {
                        if (!PCaster->StatusEffectContainer->HasStatusEffect(EFFECT_TABULA_RASA))
                        {
                            usable = false;
                        }
                    }
                    if (PCaster->GetSJob() == JOB_SCH)
                    {
                        if (requirements & SPELLREQ_ADDENDUM_BLACK)
                        {
                            if (!PCaster->StatusEffectContainer->HasStatusEffect({ EFFECT_ADDENDUM_BLACK, EFFECT_ENLIGHTENMENT }))
                            {
                                usable = false;
                            }
                        }
                        else if (requirements & SPELLREQ_ADDENDUM_WHITE)
                        {
                            if (!PCaster->StatusEffectContainer->HasStatusEffect({ EFFECT_ADDENDUM_WHITE, EFFECT_ENLIGHTENMENT }))
                            {
                                usable = false;
                            }
                        }
                    }
                    if (spell->getSpellGroup() == SPELLGROUP_BLUE && PCaster->objtype == TYPE_PC)
                    {
                        if (requirements & SPELLREQ_UNBRIDLED_LEARNING)
                        {
                            if (!PCaster->StatusEffectContainer->HasStatusEffect({ EFFECT_UNBRIDLED_LEARNING, EFFECT_UNBRIDLED_WISDOM }))
                            {
                                usable = false;
                            }
                        }
                        else if (!blueutils::IsSpellSet((CCharEntity*)PCaster, (CBlueSpell*)spell))
                        {
                            usable = false;
                        }
                    }
                }
                return usable;

            case TYPE_PET:
                if (static_cast<CPetEntity*>(PCaster)->getPetType() == PET_TYPE::AUTOMATON)
                {
                    usable = true;
                }
                [[fallthrough]];
            case TYPE_TRUST:
                // Unable to cast because caster is hidden or untargetable
                if (PCaster->IsNameHidden() || static_cast<CMobEntity*>(PCaster)->GetUntargetable())
                {
                    return false;
                }

                if (usable)
                {
                    return true;
                }

                // Ensure pet or trust is level appropriate
                if (PCaster->GetMLevel() < static_cast<CMobEntity*>(PCaster)->m_SpellListContainer->GetSpellMinLevel(spell->getID()))
                {
                    return false;
                }
                return true;

            default:
                break;
        }
        return false;
    }

    // This is a utility method for mobutils, when we want to work out if we can give monsters a spell
    // but they are on an odd job (e.g. PLDs getting -ga3)
    bool CanUseSpellWith(SpellID spellId, JOBTYPE job, uint8 level)
    {
        if (GetSpell(spellId) != nullptr)
        {
            uint8 jobMLevel = PSpellList[static_cast<size_t>(spellId)]->getJob(job);

            return level > jobMLevel;
        }
        return false;
    }

    float GetSpellRadius(CSpell* spell, CBattleEntity* entity)
    {
        float total = spell->getRadius();

        // brd gets bonus radius from string skill
        if (spell->getSpellGroup() == SPELLGROUP_SONG && (spell->getValidTarget() & TARGET_SELF))
        {
            if (entity->objtype == TYPE_MOB || (entity->GetMJob() == JOB_BRD && entity->objtype == TYPE_PC && ((CCharEntity*)entity)->getEquip(SLOT_RANGED) &&
                                                ((CItemWeapon*)((CCharEntity*)entity)->getEquip(SLOT_RANGED))->getSkillType() == SKILL_STRING_INSTRUMENT))
            {
                total += ((float)entity->GetSkill(SKILL_STRING_INSTRUMENT) / 276) * 10;
            }

            if (total > 20)
            {
                total = 20;
            }
        }

        return total;
    }
}; // namespace spell
