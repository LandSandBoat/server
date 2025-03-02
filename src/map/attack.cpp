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

#include "attack.h"
#include "ai/ai_container.h"
#include "attackround.h"
#include "entities/battleentity.h"
#include "items/item_weapon.h"
#include "job_points.h"
#include "status_effect_container.h"
#include "utils/puppetutils.h"

#include <cmath>

/************************************************************************
 *                                                                      *
 *  Constructor.                                                            *
 *                                                                      *
 ************************************************************************/
CAttack::CAttack(CBattleEntity* attacker, CBattleEntity* defender, PHYSICAL_ATTACK_TYPE type, PHYSICAL_ATTACK_DIRECTION direction, CAttackRound* attackRound)
: m_attacker(attacker)
, m_victim(defender)
, m_attackRound(attackRound)
, m_attackType(type)
, m_attackDirection(direction)
{
}

/************************************************************************
 *                                                                      *
 *  Returns the attack direction.                                       *
 *                                                                      *
 ************************************************************************/
PHYSICAL_ATTACK_DIRECTION CAttack::GetAttackDirection()
{
    return m_attackDirection;
}

/************************************************************************
 *                                                                      *
 *  Returns the attack type.                                                *
 *                                                                      *
 ************************************************************************/
PHYSICAL_ATTACK_TYPE CAttack::GetAttackType()
{
    return m_attackType;
}

/************************************************************************
 *                                                                      *
 *  Sets the attack type.                                               *
 *                                                                      *
 ************************************************************************/
void CAttack::SetAttackType(PHYSICAL_ATTACK_TYPE type)
{
    m_attackType = type;
}

/************************************************************************
 *                                                                      *
 *  Returns the isCritical flag.                                            *
 *                                                                      *
 ************************************************************************/
bool CAttack::IsCritical() const
{
    return m_isCritical;
}

/************************************************************************
 *                                                                      *
 *  Sets the critical flag.                                             *
 *                                                                      *
 ************************************************************************/
void CAttack::SetCritical(bool value)
{
    m_isCritical = value;

    if (m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        uint16 bonusRatt = 0;

        if (m_attacker->StatusEffectContainer)
        {
            const CStatusEffect* sangeEffect = m_attacker->StatusEffectContainer->GetStatusEffect(EFFECT_SANGE);
            CCharEntity*         PChar       = dynamic_cast<CCharEntity*>(m_attacker);

            if (sangeEffect && PChar && PChar->PMeritPoints)
            {
                int32 meritValue = PChar->PMeritPoints->GetMeritValue(MERIT_SANGE, PChar);

                // Add N ranged attack * merit level during Sange effect
                bonusRatt += PChar->getMod(Mod::ENHANCES_SANGE) * meritValue;
            }
        }
        m_damageRatio = battleutils::GetRangedDamageRatio(m_attacker, m_victim, m_isCritical, bonusRatt);
    }
    else
    {
        float attBonus = 1.0f;
        if (m_attackType == PHYSICAL_ATTACK_TYPE::KICK)
        {
            if (CStatusEffect* footworkEffect = m_attacker->StatusEffectContainer->GetStatusEffect(EFFECT_FOOTWORK))
            {
                attBonus += (footworkEffect->GetSubPower() / 256.f); // Mod is out of 256
            }
        }

        SKILLTYPE skilltype  = SKILLTYPE::SKILL_NONE;
        SLOTTYPE  weaponSlot = static_cast<SLOTTYPE>(GetWeaponSlot());

        if (m_attacker->objtype == TYPE_PC)
        {
            if (auto* weapon = dynamic_cast<CItemWeapon*>(m_attacker->m_Weapons[weaponSlot]))
            {
                skilltype = static_cast<SKILLTYPE>(weapon->getSkillType());
            }
            else
            {
                skilltype = SKILLTYPE::SKILL_HAND_TO_HAND;
            }
        }

        // need to pass the weapon slot because damage ratio depends on ATT which varies by slot
        m_damageRatio = battleutils::GetDamageRatio(m_attacker, m_victim, m_isCritical, attBonus, skilltype, weaponSlot, false);
    }
}

/************************************************************************
 *                                                                      *
 *  Sets the guarded flag.                                              *
 *                                                                      *
 ************************************************************************/
void CAttack::SetGuarded(bool isGuarded)
{
    m_isGuarded = isGuarded;
}

/************************************************************************
 *                                                                      *
 *  Gets the guarded flag.                                              *
 *                                                                      *
 ************************************************************************/
bool CAttack::IsGuarded()
{
    m_isGuarded = attackutils::IsGuarded(m_attacker, m_victim);
    if (m_isGuarded)
    {
        if (m_damageRatio > 1.0f)
        {
            m_damageRatio -= 1.0f;
        }
        else
        {
            m_damageRatio = 0;
        }
    }
    return m_isGuarded;
}

/************************************************************************
 *                                                                      *
 *  Gets the evaded flag.                                               *
 *                                                                      *
 ************************************************************************/
bool CAttack::IsEvaded() const
{
    return m_isEvaded;
}

/************************************************************************
 *                                                                      *
 *  Sets the evaded flag.                                               *
 *                                                                      *
 ************************************************************************/
void CAttack::SetEvaded(bool value)
{
    m_isEvaded = value;
}

/************************************************************************
 *                                                                      *
 *  Gets the blocked flag.                                              *
 *                                                                      *
 ************************************************************************/
bool CAttack::IsBlocked() const
{
    return m_isBlocked;
}

bool CAttack::IsParried() const
{
    return m_isParried;
}

bool CAttack::CheckParried()
{
    if (m_attackType != PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        if (attackutils::IsParried(m_attacker, m_victim))
        {
            m_isParried = true;
        }
    }
    return m_isParried;
}

bool CAttack::IsAnticipated() const
{
    return m_anticipated;
}

bool CAttack::IsDeflected() const
{
    if (!m_victim->StatusEffectContainer->HasStatusEffect(EFFECT_DEFENSE_BOOST))
    {
        return false;
    }

    uint16 subpower = m_victim->StatusEffectContainer->GetStatusEffect(EFFECT_DEFENSE_BOOST)->GetSubPower();
    if (subpower == 0)
    {
        return false;
    }

    return infront(m_attacker->loc.p, m_victim->loc.p, subpower);
}

/************************************************************************
 *                                                                      *
 *  Returns the isFirstSwing flag.                                      *
 *                                                                      *
 ************************************************************************/
bool CAttack::IsFirstSwing() const
{
    return m_isFirstSwing;
}

/************************************************************************
 *                                                                      *
 *  Sets this swing as the first.                                       *
 *                                                                      *
 ************************************************************************/
void CAttack::SetAsFirstSwing(bool isFirst)
{
    m_isFirstSwing = isFirst;
}

/************************************************************************
 *                                                                      *
 *  Gets the damage ratio.                                              *
 *                                                                      *
 ************************************************************************/
float CAttack::GetDamageRatio() const
{
    return m_damageRatio;
}

/************************************************************************
 *                                                                      *
 *  Sets the attack type.                                               *
 *                                                                      *
 ************************************************************************/
uint8 CAttack::GetWeaponSlot()
{
    if (m_attackRound->IsH2H())
    {
        return SLOT_MAIN;
    }
    if (m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        return SLOT_AMMO;
    }
    return m_attackDirection == RIGHTATTACK ? SLOT_MAIN : SLOT_SUB;
}

/************************************************************************
 *                                                                      *
 *  Returns the animation ID.                                           *
 *                                                                      *
 ************************************************************************/
uint16 CAttack::GetAnimationID()
{
    AttackAnimation animation{};

    // Try normal kick attacks (without footwork)
    if (this->m_attackType == PHYSICAL_ATTACK_TYPE::KICK)
    {
        animation = this->m_attackDirection == RIGHTATTACK ? AttackAnimation::RIGHTKICK : AttackAnimation::LEFTKICK;
    }

    else if (this->m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        animation = AttackAnimation::THROW;
    }

    // Normal attack
    else
    {
        animation = this->m_attackDirection == RIGHTATTACK ? AttackAnimation::RIGHTATTACK : AttackAnimation::LEFTATTACK;
    }

    return (uint16)animation;
}

/************************************************************************
 *                                                                      *
 *  Returns the hitrate for this swing.                                 *
 *                                                                      *
 ************************************************************************/
uint8 CAttack::GetHitRate()
{
    if (m_attackType == PHYSICAL_ATTACK_TYPE::KICK)
    {
        m_hitRate = battleutils::GetHitRate(m_attacker, m_victim, 2);
    }
    else if (m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        int16 accBonus = 100;

        if (m_attacker->StatusEffectContainer)
        {
            const CStatusEffect* sangeEffect = m_attacker->StatusEffectContainer->GetStatusEffect(EFFECT_SANGE);
            CCharEntity*         PChar       = dynamic_cast<CCharEntity*>(m_attacker);
            if (sangeEffect && PChar && PChar->PMeritPoints)
            {
                int32 meritValue = PChar->PMeritPoints->GetMeritValue(MERIT_SANGE, PChar);

                accBonus += (meritValue - 1) * 25; // add 25 acc per merit past the first (you have to merit Sange to even have the status effect, so this will never be negative acc bonus)
            }
        }

        m_hitRate = battleutils::GetRangedHitRate(m_attacker, m_victim, false, accBonus);
    }
    else if (m_attackDirection == RIGHTATTACK)
    {
        if (m_attackType == PHYSICAL_ATTACK_TYPE::ZANSHIN)
        {
            m_hitRate = battleutils::GetHitRate(m_attacker, m_victim, 0, (uint8)35);
        }
        else
        {
            m_hitRate = battleutils::GetHitRate(m_attacker, m_victim, 0);
        }

        // Deciding this here because SA/TA wears on attack, before the 2nd+ hits go off.
        if (m_hitRate == 100)
        {
            m_attackRound->SetSATA(true);
        }
    }
    else if (m_attackDirection == LEFTATTACK)
    {
        if (m_attackType == PHYSICAL_ATTACK_TYPE::ZANSHIN)
        {
            m_hitRate = battleutils::GetHitRate(m_attacker, m_victim, 1, (uint8)35);
        }
        else
        {
            m_hitRate = battleutils::GetHitRate(m_attacker, m_victim, 1);
        }
    }
    return m_hitRate;
}

/************************************************************************
 *                                                                      *
 *  Returns the damage for this swing.                                  *
 *                                                                      *
 ************************************************************************/
int32 CAttack::GetDamage() const
{
    return m_damage;
}

/************************************************************************
 *                                                                      *
 *  Sets the damage for this swing.                                     *
 *                                                                      *
 ************************************************************************/
void CAttack::SetDamage(int32 value)
{
    m_damage = value;
}

bool CAttack::CheckAnticipated()
{
    if (m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        return false;
    }

    CStatusEffect* effect = m_victim->StatusEffectContainer->GetStatusEffect(EFFECT_THIRD_EYE, 0);
    if (effect == nullptr)
    {
        return false;
    }

    // power stores how many times this effect has anticipated
    auto pastAnticipations = effect->GetPower();

    if (pastAnticipations > 7)
    {
        // max 7 anticipates!
        m_victim->StatusEffectContainer->DelStatusEffect(EFFECT_THIRD_EYE);
        return false;
    }
    auto* weapon             = dynamic_cast<CItemWeapon*>(m_victim->m_Weapons[SLOT_MAIN]);
    bool  isValid2HandWeapon = weapon && weapon->isTwoHanded();
    bool  hasValidSeigan     = isValid2HandWeapon && m_victim->StatusEffectContainer->HasStatusEffect(EFFECT_SEIGAN, 0);

    if (!hasValidSeigan && pastAnticipations == 0)
    {
        m_victim->StatusEffectContainer->DelStatusEffect(EFFECT_THIRD_EYE);
        m_anticipated = true;
        return true;
    }
    else if (!hasValidSeigan)
    {
        m_victim->StatusEffectContainer->DelStatusEffect(EFFECT_THIRD_EYE);
        return false;
    }
    else
    { // do have seigan, decay anticipations correctly (guesstimated)
        // 5-6 anticipates is a 'lucky' streak, going to assume 15% decay per proc, with a 100% base w/ Seigan
        if (xirand::GetRandomNumber(100) < (100 - (pastAnticipations * 15) + m_victim->getMod(Mod::THIRD_EYE_ANTICIPATE_RATE)))
        {
            // increment power and don't remove
            effect->SetPower(effect->GetPower() + 1);
            // chance to counter - 25% base
            if (xirand::GetRandomNumber(100) < 25 + m_victim->getMod(Mod::THIRD_EYE_COUNTER_RATE))
            {
                if (m_victim->PAI->IsEngaged())
                {
                    m_isCountered = true;
                    m_isCritical  = (xirand::GetRandomNumber(100) < battleutils::GetCritHitRate(m_victim, m_attacker, false));
                }
            }
            m_anticipated = true;
            return true;
        }
        m_victim->StatusEffectContainer->DelStatusEffect(EFFECT_THIRD_EYE);
        return false;
    }
}

bool CAttack::CheckHadSneakAttack() const
{
    return m_isSA;
}

bool CAttack::CheckHadTrickAttack() const
{
    return m_isTA;
}

bool CAttack::IsCountered() const
{
    return m_isCountered;
}

bool CAttack::CheckCounter()
{
    // TODO return false if boost is active (when boost gets refactored to be current retail accurate)
    if (m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
    {
        return false;
    }

    // Don't counter if not engaged or stunned, slept, etc.
    if (!m_victim->PAI->IsEngaged() || m_victim->StatusEffectContainer->HasPreventActionEffect(true))
    {
        m_isCountered = false;
        return m_isCountered;
    }

    uint8 meritCounter = 0;
    if (m_victim->objtype == TYPE_PC && charutils::hasTrait((CCharEntity*)m_victim, TRAIT_COUNTER))
    {
        if (m_victim->GetMJob() == JOB_MNK || m_victim->GetMJob() == JOB_PUP)
        {
            meritCounter = ((CCharEntity*)m_victim)->PMeritPoints->GetMeritValue(MERIT_COUNTER_RATE, (CCharEntity*)m_victim);
        }
    }

    // counter check (rate AND your hit rate makes it land, else its just a regular hit)
    // having seigan active gives chance to counter at 25% of the zanshin proc rate
    uint16 seiganChance       = 0;
    auto*  weapon             = dynamic_cast<CItemWeapon*>(m_victim->m_Weapons[SLOT_MAIN]);
    bool   isValid2HandWeapon = weapon && weapon->isTwoHanded();
    bool   hasValidSeigan     = isValid2HandWeapon && m_victim->StatusEffectContainer->HasStatusEffect(EFFECT_SEIGAN, 0);

    if (m_victim->objtype == TYPE_PC && hasValidSeigan)
    {
        seiganChance = m_victim->getMod(Mod::ZANSHIN) + ((CCharEntity*)m_victim)->PMeritPoints->GetMeritValue(MERIT_ZASHIN_ATTACK_RATE, (CCharEntity*)m_victim);
        seiganChance = std::clamp<uint16>(seiganChance, 0, 100);
        seiganChance /= 4;
    }

    // Do not counter if PD is up
    if (!m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_PERFECT_DODGE))
    {
        if ((xirand::GetRandomNumber(100) < std::clamp<uint16>(m_victim->getMod(Mod::COUNTER) + meritCounter, 0, 80) ||
             xirand::GetRandomNumber(100) < seiganChance) &&
            facing(m_victim->loc.p, m_attacker->loc.p, 64))
        {
            if (xirand::GetRandomNumber(100) < battleutils::GetHitRate(m_victim, m_attacker))
            {
                m_isCountered = true;
                m_isCritical  = (xirand::GetRandomNumber(100) < battleutils::GetCritHitRate(m_victim, m_attacker, false));
            }
            else
            {
                m_attacker->PAI->EventHandler.triggerListener("MELEE_SWING_MISS", m_attacker, m_victim, this);
            }
        }
        else if (m_victim->StatusEffectContainer->HasStatusEffect(EFFECT_PERFECT_COUNTER))
        {
            // Perfect Counter only counters hits that normal counter misses, always critical, can counter 1-3 times before wearing
            // TODO: Perfect Counter can negate an attack even if it misses (No accuracy check yet)
            m_isCountered = true;
            m_isCritical  = true;

            // TODO: Implement VIT-based formula for Perfect Counter wearing off, and add JP bonus
            m_victim->StatusEffectContainer->DelStatusEffect(EFFECT_PERFECT_COUNTER);
        }
    }
    return m_isCountered;
}

bool CAttack::IsCovered() const
{
    return m_isCovered;
}

bool CAttack::CheckCover()
{
    CBattleEntity* PCoverAbilityUser = m_attackRound->GetCoverAbilityUserEntity();
    if (PCoverAbilityUser != nullptr && PCoverAbilityUser->isAlive())
    {
        m_isCovered = true;
        m_victim    = PCoverAbilityUser;
    }
    else
    {
        m_isCovered = false;
    }

    return m_isCovered;
}

/************************************************************************
 *                                                                      *
 *  Processes the damage for this swing.                                    *
 *                                                                      *
 ************************************************************************/
void CAttack::ProcessDamage()
{
    // Sneak attack.
    if (m_attacker->GetMJob() == JOB_THF && m_isFirstSwing && m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK_ATTACK) &&
        (behind(m_attacker->loc.p, m_victim->loc.p, 64) || m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_HIDE) ||
         m_victim->StatusEffectContainer->HasStatusEffect(EFFECT_DOUBT)))
    {
        m_bonusBasePhysicalDamage += m_attacker->DEX() * (1.0f + m_attacker->getMod(Mod::SNEAK_ATK_DEX) / 100.0f);
        m_isSA = true;
    }

    // Trick attack.
    if (m_attacker->GetMJob() == JOB_THF && m_isFirstSwing && m_attackRound->GetTAEntity() != nullptr)
    {
        m_bonusBasePhysicalDamage += m_attacker->AGI() * (1.0f + m_attacker->getMod(Mod::TRICK_ATK_AGI) / 100.0f);
        m_isTA = true;
    }

    // Consume mana
    if (m_attacker->objtype == TYPE_PC)
    {
        m_bonusBasePhysicalDamage += battleutils::doConsumeManaEffect((CCharEntity*)m_attacker);
    }

    SLOTTYPE slot = (SLOTTYPE)GetWeaponSlot();
    if (m_attackRound->IsH2H())
    {
        m_naturalH2hDamage = (int32)(m_attacker->GetSkill(SKILL_HAND_TO_HAND) * 0.11f) + 3;
        m_baseDamage       = m_attacker->GetMainWeaponDmg();
        m_damage           = (uint32)(((m_baseDamage + m_naturalH2hDamage + m_bonusBasePhysicalDamage + battleutils::GetFSTR(m_attacker, m_victim, slot)) * m_damageRatio));
    }
    else if (slot == SLOT_MAIN)
    {
        m_damage = (uint32)(((m_attacker->GetMainWeaponDmg() + m_bonusBasePhysicalDamage + battleutils::GetFSTR(m_attacker, m_victim, slot)) * m_damageRatio));
    }
    else if (slot == SLOT_SUB)
    {
        m_damage = (uint32)(((m_attacker->GetSubWeaponDmg() + m_bonusBasePhysicalDamage + battleutils::GetFSTR(m_attacker, m_victim, slot)) * m_damageRatio));
    }
    else if (slot == SLOT_AMMO)
    {
        m_damage = (uint32)((m_attacker->GetRangedWeaponDmg() + battleutils::GetFSTR(m_attacker, m_victim, slot)) * m_damageRatio);
    }

    // Apply Scarlet Delirium damage bonus
    // EFFECT_SCARLET_DELIRIUM_1 is only active after damage has been dealt to the DRK and EFFECT_SCARLET_DELIRIUM has been removed.
    if (m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_SCARLET_DELIRIUM_1))
    {
        float effectPower = 1.0f + (m_attacker->StatusEffectContainer->GetStatusEffect(EFFECT_SCARLET_DELIRIUM_1)->GetPower() / 100.0f);

        m_damage = (uint32)(m_damage * effectPower);
    }

    // Apply "Double Attack" damage and "Triple Attack" damage mods
    if (m_attackType == PHYSICAL_ATTACK_TYPE::DOUBLE && m_attacker->objtype == TYPE_PC)
    {
        m_damage = (int32)(m_damage * ((100.0f + m_attacker->getMod(Mod::DOUBLE_ATTACK_DMG)) / 100.0f));
    }
    else if (m_attackType == PHYSICAL_ATTACK_TYPE::TRIPLE && m_attacker->objtype == TYPE_PC)
    {
        m_damage = (int32)(m_damage * ((100.0f + m_attacker->getMod(Mod::TRIPLE_ATTACK_DMG)) / 100.0f));
    }

    // Soul eater.
    if (m_attacker->objtype == TYPE_PC)
    {
        m_damage = battleutils::doSoulEaterEffect((CCharEntity*)m_attacker, m_damage);
    }

    // Set attack type to Samba if the attack type is normal.  Don't overwrite other types.  Used for Samba double damage.
    if (m_attackType == PHYSICAL_ATTACK_TYPE::NORMAL && (m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_SAMBA) ||
                                                         m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_ASPIR_SAMBA) || m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_HASTE_SAMBA)))
    {
        SetAttackType(PHYSICAL_ATTACK_TYPE::SAMBA);
    }

    // Get damage multipliers.
    m_damage =
        attackutils::CheckForDamageMultiplier((CCharEntity*)m_attacker, dynamic_cast<CItemWeapon*>(m_attacker->m_Weapons[slot]), m_damage, m_attackType, slot, m_isFirstSwing);

    // Apply Sneak Attack Augment Mod
    if (m_attacker->getMod(Mod::AUGMENTS_SA) > 0 && CheckHadSneakAttack() && m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK_ATTACK))
    {
        m_damage += (int32)(m_damage * ((100 + (m_attacker->getMod(Mod::AUGMENTS_SA))) / 100.0f));
    }

    // Apply Trick Attack Augment Mod
    if (m_attacker->getMod(Mod::AUGMENTS_TA) > 0 && CheckHadTrickAttack() && m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_TRICK_ATTACK))
    {
        m_damage += (int32)(m_damage * ((100 + (m_attacker->getMod(Mod::AUGMENTS_TA))) / 100.0f));
    }

    // low level mobs can get negative fSTR so low they crater their (base weapon damage + fstr) to below 0.
    // TODO: find out proper fSTR calc for low level mobs when your VIT is ridiculously high. It's likely that this is slightly wrong (possibly you'd get more hits for 0 than you should)
    // However, there are legitimate strategies on retail with 1 dmg weapons and negative fSTR ranks that result in all auto attacks hitting for 0 but using enspells for damage so no TP is fed.
    // Absorption isn't possible at this point in the calculation, so zero it.
    if (m_damage < 0)
    {
        m_damage = 0;
    }

    // Try skill up.
    if (m_damage > 0)
    {
        if (m_attacker->objtype == TYPE_PC)
        {
            if (m_attackType == PHYSICAL_ATTACK_TYPE::DAKEN)
            {
                charutils::TrySkillUP((CCharEntity*)m_attacker, SKILLTYPE::SKILL_THROWING, m_victim->GetMLevel());
            }
            else if (auto* weapon = dynamic_cast<CItemWeapon*>(m_attacker->m_Weapons[slot]))
            {
                charutils::TrySkillUP((CCharEntity*)m_attacker, (SKILLTYPE)weapon->getSkillType(), m_victim->GetMLevel());
            }
        }
        else if (m_attacker->objtype == TYPE_PET && m_attacker->PMaster && m_attacker->PMaster->objtype == TYPE_PC &&
                 static_cast<CPetEntity*>(m_attacker)->getPetType() == PET_TYPE::AUTOMATON)
        {
            puppetutils::TrySkillUP((CAutomatonEntity*)m_attacker, SKILL_AUTOMATON_MELEE, m_victim->GetMLevel());
        }
    }
    m_isBlocked = attackutils::IsBlocked(m_attacker, m_victim);

    // Apply Restraint Weaponskill Damage Modifier
    // Effect power tracks the total bonus
    // Effect sub power tracks remainder left over from whole percentage flooring
    if (m_isFirstSwing && m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_RESTRAINT))
    {
        CStatusEffect* effect = m_attacker->StatusEffectContainer->GetStatusEffect(EFFECT_RESTRAINT);

        if (effect == nullptr)
        {
            ShowError("Restraint effect was null.");
            return;
        }

        if (effect->GetPower() < 30)
        {
            uint8 jpBonus = 0;

            if (m_attacker->objtype == TYPE_PC)
            {
                jpBonus = static_cast<CCharEntity*>(m_attacker)->PJobPoints->GetJobPointValue(JP_RESTRAINT_EFFECT) * 2;
            }

            // Convert weapon delay and divide
            // Pull remainder of previous hit's value from Effect sub Power
            float boostPerRound = ((m_attacker->GetWeaponDelay(false) / 1000.0f) * 60.0f) / 385.0f;
            float remainder     = effect->GetSubPower() / 100.0f;

            // Calculate bonuses from Enhances Restraint, Job Point upgrades, and remainder from previous hit
            boostPerRound = (boostPerRound * (1 + m_attacker->getMod(Mod::ENHANCES_RESTRAINT) / 100.0f) * (1 + jpBonus / 100.0f)) + remainder;

            // Calculate new remainder and multiply by 100 so significant digits aren't lost
            // Floor Boost per Round
            remainder     = (1 - (std::ceil(boostPerRound) - boostPerRound)) * 100;
            boostPerRound = std::floor(boostPerRound);

            // Cap total power to +30% WSD
            if (effect->GetPower() + boostPerRound > 30)
            {
                boostPerRound = 30 - effect->GetPower();
            }

            effect->SetPower(effect->GetPower() + boostPerRound);
            effect->SetSubPower(remainder);
            m_attacker->addModifier(Mod::ALL_WSDMG_FIRST_HIT, boostPerRound);
        }
    }
}
