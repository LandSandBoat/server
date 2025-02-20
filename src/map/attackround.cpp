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

#include "attackround.h"
#include "ai/ai_container.h"
#include "items/item_weapon.h"
#include "mob_modifier.h"
#include "packets/inventory_finish.h"
#include "status_effect_container.h"

/************************************************************************
 *                                                                        *
 *  Constructor.                                                            *
 *                                                                        *
 ************************************************************************/
CAttackRound::CAttackRound(CBattleEntity* attacker, CBattleEntity* defender)
{
    m_attacker          = attacker;
    m_defender          = defender;
    m_kickAttackOccured = false;
    m_sataOccured       = false;

    // Grab a trick attack assistant.
    m_taEntity = battleutils::getAvailableTrickAttackChar(attacker, attacker->GetBattleTarget());

    // Get cover partner
    if (attacker->GetBattleTarget()->objtype == TYPE_PC)
    {
        m_coverAbilityUserEntity = battleutils::GetCoverAbilityUser(attacker->GetBattleTarget(), attacker);
    }
    else
    {
        m_coverAbilityUserEntity = nullptr;
    }

    auto* PMain = dynamic_cast<CItemWeapon*>(attacker->m_Weapons[SLOT_MAIN]);
    auto* PSub  = dynamic_cast<CItemWeapon*>(attacker->m_Weapons[SLOT_SUB]);

    if (PMain)
    {
        if (IsH2H()) // Build H2H attacks.
        {
            CreateAttacks(PMain, LEFTATTACK);
            CreateAttacks(PMain, LEFTATTACK);
        }
        else // Build main weapon attacks.
        {
            CreateAttacks(PMain, RIGHTATTACK);
        }
    }

    if (PSub && attacker->m_dualWield)
    {
        CreateAttacks(PSub, LEFTATTACK);
    }

    // Build kick attacks.
    CreateKickAttacks();

    // Build Daken throw
    CreateDakenAttack();

    // Append follow-up attacks
    ProcFollowUpAttacks();

    // Set the first attack flag
    m_attackSwings[0].SetAsFirstSwing();

    // Delete the haste samba effect.
    attacker->StatusEffectContainer->DelStatusEffect(EFFECT_HASTE_SAMBA_HASTE);

    // Clear the action list.
    attacker->m_ActionList.clear();
}

/************************************************************************
 *                                                                        *
 *  Destructor.                                                            *
 *                                                                        *
 ************************************************************************/
CAttackRound::~CAttackRound() = default;

/************************************************************************
 *                                                                        *
 *  Returns the attack swing count.                                        *
 *                                                                        *
 ************************************************************************/
uint8 CAttackRound::GetAttackSwingCount()
{
    return (uint8)m_attackSwings.size();
}

/************************************************************************
 *                                                                        *
 *  Returns an attack via index.                                            *
 *                                                                        *
 ************************************************************************/
CAttack& CAttackRound::GetAttack(uint8 index)
{
    return m_attackSwings[index];
}

/************************************************************************
 *                                                                        *
 *  Returns the current attack.                                            *
 *                                                                        *
 ************************************************************************/
CAttack& CAttackRound::GetCurrentAttack()
{
    return m_attackSwings[0];
}

/************************************************************************
 *                                                                        *
 *  Sets the SATA flag.                                                    *
 *                                                                        *
 ************************************************************************/
void CAttackRound::SetSATA(bool value)
{
    m_sataOccured = value;
}

/************************************************************************
 *                                                                        *
 *  Returns the SATA flag.                                                *
 *                                                                        *
 ************************************************************************/
bool CAttackRound::GetSATAOccured() const
{
    return m_sataOccured;
}

/************************************************************************
 *                                                                        *
 *  Returns the TA entity.                                                *
 *                                                                        *
 ************************************************************************/
CBattleEntity* CAttackRound::GetTAEntity()
{
    return m_taEntity;
}

/************************************************************************
 *                                                                       *
 *  Returns the Cover entity.                                            *
 *                                                                       *
 ************************************************************************/
CBattleEntity* CAttackRound::GetCoverAbilityUserEntity()
{
    return m_coverAbilityUserEntity;
}

/************************************************************************
 *                                                                       *
 *  Returns the H2H flag.                                                *
 *                                                                       *
 ************************************************************************/
bool CAttackRound::IsH2H()
{
    if (auto* weapon = dynamic_cast<CItemWeapon*>(m_attacker->m_Weapons[SLOT_MAIN]))
    {
        return weapon->getSkillType() == SKILL_HAND_TO_HAND;
    }
    return false;
}

/************************************************************************
 *                                                                        *
 *  Adds an attack swing.                                                *
 *                                                                        *
 ************************************************************************/
void CAttackRound::AddAttackSwing(PHYSICAL_ATTACK_TYPE type, PHYSICAL_ATTACK_DIRECTION direction, uint8 count)
{
    if (m_attackSwings.size() < MAX_ATTACKS)
    {
        for (size_t i = 0; i < count; ++i)
        {
            // Flip direction of second H2H swing
            if (IsH2H() && m_attackSwings.size() == 1)
            {
                m_attackSwings.emplace_back(m_attacker, m_defender, type, RIGHTATTACK, this);
            }
            else
            {
                m_attackSwings.emplace_back(m_attacker, m_defender, type, direction, this);
            }

            if (m_attackSwings.size() == MAX_ATTACKS)
            {
                return;
            }
        }
    }
}

/************************************************************************
 *                                                                        *
 *  Deletes the first attack in the list.                                *
 *                                                                        *
 ************************************************************************/
void CAttackRound::DeleteAttackSwing()
{
    m_attackSwings.erase(m_attackSwings.begin());
}

/************************************************************************
 *                                                                       *
 *  Creates up to many attacks for a particular hand.                    *
 *                                                                       *
 ************************************************************************/
void CAttackRound::CreateAttacks(CItemWeapon* PWeapon, PHYSICAL_ATTACK_DIRECTION direction)
{
    if (!PWeapon)
    {
        return;
    }

    uint8 num = 1;

    bool isPC = m_attacker->objtype == TYPE_PC;

    // Checking the players weapon hit count
    if (PWeapon->getReqLvl() <= m_attacker->GetMLevel())
    {
        num = PWeapon->getHitCount();
    }

    // Existance of "Occasionally attacks X times" overwrites PWeapon hit count
    if (isPC && m_attacker->getMod(Mod::MAX_SWINGS))
    {
        auto modSwings = std::min<uint8>((uint8) static_cast<CCharEntity*>(m_attacker)->getMod(Mod::MAX_SWINGS), 8);
        num            = battleutils::getHitCount(modSwings);
    }

    // If the attacker is a mobentity or derived from mobentity, check to see if it has any special mutli-hit capabilties
    if (dynamic_cast<CMobEntity*>(m_attacker))
    {
        auto multiHitMax = (uint8) static_cast<CMobEntity*>(m_attacker)->getMobMod(MOBMOD_MULTI_HIT);

        if (multiHitMax > 0)
        {
            num = 1 + battleutils::getHitCount(multiHitMax);
        }
    }

    // Checking the players triple, double and quadruple attack
    int16 tripleAttack     = m_attacker->getMod(Mod::TRIPLE_ATTACK);
    int16 doubleAttack     = m_attacker->getMod(Mod::DOUBLE_ATTACK);
    int16 quadAttack       = m_attacker->getMod(Mod::QUAD_ATTACK);
    bool  multiHitOccurred = false;
    bool  isMainHand       = (IsH2H() && !m_attackSwings.empty()) || direction == RIGHTATTACK;

    // Checking for Mythic Weapon Aftermath
    int16 occAttThriceRate = std::clamp<int16>(m_attacker->getMod(Mod::MYTHIC_OCC_ATT_THRICE), 0, 100);
    int16 occAttTwiceRate  = std::clamp<int16>(m_attacker->getMod(Mod::MYTHIC_OCC_ATT_TWICE), 0, 100);

    // Checking for merit upgrades
    if (isPC)
    {
        CCharEntity* PChar = (CCharEntity*)m_attacker;

        // Merit chance only applies if player has the job trait
        if (charutils::hasTrait(PChar, TRAIT_TRIPLE_ATTACK))
        {
            tripleAttack += PChar->PMeritPoints->GetMeritValue(MERIT_TRIPLE_ATTACK_RATE, PChar);
        }

        // Ambush Augment adds +1% Triple Attack per merit (need to satisfy conditions for Ambush)
        if (charutils::hasTrait(PChar, TRAIT_AMBUSH) && PChar->getMod(Mod::AUGMENTS_AMBUSH) > 0 &&
            abs(m_defender->loc.p.rotation - m_attacker->loc.p.rotation) < 23)
        {
            tripleAttack += PChar->PMeritPoints->GetMerit(MERIT_AMBUSH)->count;
        }

        if (charutils::hasTrait(PChar, TRAIT_DOUBLE_ATTACK))
        {
            doubleAttack += PChar->PMeritPoints->GetMeritValue(MERIT_DOUBLE_ATTACK_RATE, PChar);
        }
        // TODO: Quadruple attack merits when SE release them.

        // Iga Garb +2 Set augment: possibility to add another swing while using Dual Wield
        // TODO: Double check correct priority for Empyrian armor modifiers? Outsource? Lua function?
        if (!isMainHand)
        {
            doubleAttack += m_attacker->getMod(Mod::EXTRA_DUAL_WIELD_ATTACK);
        }
    }

    quadAttack   = std::clamp<int16>(quadAttack, 0, 100);
    doubleAttack = std::clamp<int16>(doubleAttack, 0, 100);
    tripleAttack = std::clamp<int16>(tripleAttack, 0, 100);

    // Preference matters! The following are additional hits to the default hit that don't stack up
    // Mikage > Quad > Triple > Double > Mythic Aftermath > Occasionally Attacks > Hasso + Zanshin
    // Daken is handled separately in CreateDakenAttack() and Zanshin in src/map/entities/battleentity.cpp#L1768

    // Checking Mikage Effect - Hits Vary With Num of Utsusemi Shadows for Main Weapon
    if (m_attacker->StatusEffectContainer->HasStatusEffect(EFFECT_MIKAGE) && m_attacker->m_Weapons[SLOT_MAIN] && m_attacker->m_Weapons[SLOT_MAIN]->getID() == PWeapon->getID())
    {
        auto shadows = (uint8)m_attacker->getMod(Mod::UTSUSEMI);
        AddAttackSwing(PHYSICAL_ATTACK_TYPE::NORMAL, direction, shadows);
    }
    // Quad/Triple/Double Attack
    else if (xirand::GetRandomNumber(100) < quadAttack)
    {
        AddAttackSwing(PHYSICAL_ATTACK_TYPE::QUAD, direction, 4);
        multiHitOccurred = true;
    }
    else if (xirand::GetRandomNumber(100) < tripleAttack)
    {
        AddAttackSwing(PHYSICAL_ATTACK_TYPE::TRIPLE, direction, 3);
        multiHitOccurred = true;
    }
    else if (xirand::GetRandomNumber(100) < doubleAttack)
    {
        AddAttackSwing(PHYSICAL_ATTACK_TYPE::DOUBLE, direction, 2);
        multiHitOccurred = true;
    }
    // Mythic Weapons Aftermath, only main hand
    else if (isMainHand && xirand::GetRandomNumber(100) < occAttThriceRate)
    {
        AddAttackSwing(PHYSICAL_ATTACK_TYPE::NORMAL, direction, 2);
    }
    else if (isMainHand && xirand::GetRandomNumber(100) < occAttTwiceRate)
    {
        AddAttackSwing(PHYSICAL_ATTACK_TYPE::NORMAL, direction, 1);
    }
    // "Occasionally attacks X times" and regular multiple hits
    else if (num > 1)
    {
        // Deduct the final default hit!
        AddAttackSwing(PHYSICAL_ATTACK_TYPE::NORMAL, direction, (num - 1));
    }

    // Additional swing modifier (stacks!), mostly for Amood weapons
    if (isPC && xirand::GetRandomNumber(100) < m_attacker->getMod(Mod::ADDITIONAL_SWING_CHANCE))
    {
        AddAttackSwing(PHYSICAL_ATTACK_TYPE::NORMAL, direction, 1);
    }

    // Default hit, necessary to check for multi hits as the hits are assigned as PHYSICAL_ATTACK_TYPE
    // Double and Triple Attack Damage + mods are assigned to hits based on attack type
    if (multiHitOccurred == false)
    {
        AddAttackSwing(PHYSICAL_ATTACK_TYPE::NORMAL, direction, 1);
    }
}

/************************************************************************
 *  IsAttackTypeEligibleForFollowUp()
 *  Return true if the attackType attack swing eligible to proc followUpType
 *  Virtue Stone, TODO Raetic, TODO Dynamis [D]
 ************************************************************************/
bool CAttackRound::IsAttackTypeEligibleForFollowUp(Mod followUpType, PHYSICAL_ATTACK_TYPE attackType)
{
    switch (followUpType)
    {
        case Mod::AMMO_SWING:
        {
            switch (attackType)
            {
                case PHYSICAL_ATTACK_TYPE::NORMAL:
                case PHYSICAL_ATTACK_TYPE::DOUBLE:
                case PHYSICAL_ATTACK_TYPE::TRIPLE:
                case PHYSICAL_ATTACK_TYPE::SAMBA:
                case PHYSICAL_ATTACK_TYPE::QUAD:
                    return true;
                default:
                    return false;
            }
        }

        default:
            return false;
    }
}

/************************************************************************
 *  ProcFollowUpAttacks() - Players only
 *  Attempt to proc follow-up attacks and append them to the attack round
 *  Virtue Stone, TODO Raetic, TODO Dynamis [D]
 ************************************************************************/
void CAttackRound::ProcFollowUpAttacks()
{
    if (CCharEntity* PChar = dynamic_cast<CCharEntity*>(m_attacker))
    {
        if (PChar->getMod(Mod::AMMO_SWING))
        {
            // iterate through attackSwings and attempt to proc and store a follow-up swing
            for (auto& attack : m_attackSwings)
            {
                PHYSICAL_ATTACK_DIRECTION direction = attack.GetAttackDirection();
                PHYSICAL_ATTACK_TYPE      type      = attack.GetAttackType();
                CItemEquipment*           PWeapon   = nullptr;

                if (IsAttackTypeEligibleForFollowUp(Mod::AMMO_SWING, type))
                {
                    if (IsH2H() || direction == RIGHTATTACK)
                    {
                        PWeapon = PChar->getEquip(SLOT_MAIN);
                    }
                    else if (direction == LEFTATTACK)
                    {
                        PWeapon = PChar->getEquip(SLOT_SUB);
                    }

                    if (PWeapon && xirand::GetRandomNumber(100) < battleutils::GetScaledItemModifier(PChar, PWeapon, Mod::AMMO_SWING))
                    {
                        CItemEquipment*     PAmmo       = PChar->getEquip(SLOT_AMMO);
                        static const uint16 virtueStone = 18244;

                        if (PAmmo && PAmmo->getID() == virtueStone && PAmmo->getQuantity() > 0)
                        {
                            uint8 loc  = PChar->equipLoc[SLOT_AMMO];
                            uint8 slot = PChar->equip[SLOT_AMMO];

                            if (AddFollowUpAttack(direction))
                            {
                                if (PAmmo->getQuantity() == 1)
                                {
                                    charutils::UnequipItem(PChar, SLOT_AMMO);
                                    PChar->RequestPersist(CHAR_PERSIST::EQUIP);
                                }

                                charutils::UpdateItem(PChar, loc, slot, -1);
                                PChar->pushPacket<CInventoryFinishPacket>();
                            }
                        }
                    }
                }
            }
        }
        // TODO: else if (Raetic) {};
        // TODO: else if (Dynamis [D]) {};

        // Append any swings stored in m_followUpSwings to the attack round
        if (!m_followUpSwings.empty())
        {
            for (size_t i = 0; i < m_followUpSwings.size(); i++)
            {
                AddAttackSwing(PHYSICAL_ATTACK_TYPE::FOLLOWUP, m_followUpSwings[i], 1);
            }
        }
    }
}

/************************************************************************
 *  AddFollowUpAttack() - (Virtue Stone, Raetic, Dynamis [D])
 *  Attempt to store a follow-up swing. Return true if swing is stored.
 *  Ensure that one follow-up per hand is stored, in order
 ************************************************************************/
bool CAttackRound::AddFollowUpAttack(PHYSICAL_ATTACK_DIRECTION direction)
{
    if (m_followUpSwings.size() < 2)
    {
        if (m_followUpSwings.empty() || m_followUpSwings.back() != direction)
        {
            m_followUpSwings.push_back(direction);
            return true;
        }
    }

    return false;
}

/************************************************************************
 *                                                                       *
 *  Creates kick attacks.                                                *
 *                                                                       *
 ************************************************************************/
void CAttackRound::CreateKickAttacks()
{
    if (m_attacker->objtype == TYPE_PC && IsH2H())
    {
        // kick attack mod (All jobs)
        uint16 kickAttack = m_attacker->getMod(Mod::KICK_ATTACK_RATE);

        if (m_attacker->GetMJob() == JOB_MNK) // MNK (Main job)
        {
            kickAttack += ((CCharEntity*)m_attacker)->PMeritPoints->GetMeritValue(MERIT_KICK_ATTACK_RATE, (CCharEntity*)m_attacker);
        }

        kickAttack = std::clamp<uint16>(kickAttack, 0, 100);

        if (xirand::GetRandomNumber(100) < kickAttack)
        {
            AddAttackSwing(PHYSICAL_ATTACK_TYPE::KICK, RIGHTATTACK, 1);
            m_kickAttackOccured = true;
        }

        // Tantra set mod: Try an extra left kick attack.
        if (m_kickAttackOccured && xirand::GetRandomNumber(100) < m_attacker->getMod(Mod::EXTRA_KICK_ATTACK))
        {
            AddAttackSwing(PHYSICAL_ATTACK_TYPE::KICK, LEFTATTACK, 1);
        }
    }
}

/************************************************************************
 *                                                                        *
 *  Creates a Daken throw.                                                *
 *                                                                        *
 ************************************************************************/
void CAttackRound::CreateDakenAttack()
{
    if (m_attacker->objtype == TYPE_PC)
    {
        auto* PAmmo = static_cast<CItemWeapon*>(m_attacker->m_Weapons[SLOT_AMMO]);
        if (PAmmo && PAmmo->isShuriken())
        {
            uint16 daken = m_attacker->getMod(Mod::DAKEN);
            if (xirand::GetRandomNumber(100) < daken)
            {
                AddAttackSwing(PHYSICAL_ATTACK_TYPE::DAKEN, RIGHTATTACK, 1);
            }
        }
    }
}
