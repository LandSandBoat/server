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

#pragma once

#include "attack.h"
#include "common/cbasetypes.h"
#include "common/macros.h"
#include "entities/battle_entity.h"
#include "utils/attackutils.h"
#include "utils/charutils.h"
#include <vector>

#define MAX_ATTACKS 8

class CAttack;

/************************************************************************
 *                                                                        *
 *  An attack round object (Can contain multiple swings)                    *
 *                                                                        *
 ************************************************************************/
class CAttackRound
{
public:
    CAttackRound(CBattleEntity* attacker, CBattleEntity* defender);
    ~CAttackRound();

    DISALLOW_COPY_AND_MOVE(CAttackRound);

    void AddAttackSwing(PHYSICAL_ATTACK_TYPE type, PHYSICAL_ATTACK_DIRECTION direction, uint8 count); // Adds an attack swing.
    void CreateAttacks(CItemWeapon* PWeapon, PHYSICAL_ATTACK_DIRECTION direction);                    // Creates up to many attacks for a particular hand.
    void DeleteAttackSwing();                                                                         // Deletes the first attack in the list.
    void CreateKickAttacks();                                                                         // Creates kick attacks for the round.
    void CreateDakenAttack();                                                                         // Adds daken attacks

    auto IsAttackTypeEligibleForFollowUp(xi::Mod followUpType, PHYSICAL_ATTACK_TYPE attackType) -> bool; // Is attack type eligible for follow-up?
    void ProcFollowUpAttacks();                                                                          // Attempt to proc follow-up attacks.
    auto AddFollowUpAttack(PHYSICAL_ATTACK_DIRECTION direction) -> bool;                                 // Attempt to store a follow-up swing. Return true if swing is stored.

    auto GetAttackSwingCount() -> uint8;                // Returns the attack list count.
    auto IsH2H() -> bool;                               // Flag: Is the attacker using H2H?
    auto GetAttack(uint8) -> CAttack&;                  // Returns an attack object.
    auto GetCurrentAttack() -> CAttack&;                // Returns the current attack.
    void SetSATA(bool value);                           // Sets the SATA flag.
    auto GetSATAOccured() const -> bool;                // Returns the SATA flag.
    auto GetTAEntity() -> CBattleEntity*;               // Returns the TA entity.
    auto GetCoverAbilityUserEntity() -> CBattleEntity*; // Returns the Cover ablitiy user entity.

private:
    CBattleEntity*       m_attacker;               // The attacker.
    CBattleEntity*       m_defender;               // The defender.
    CBattleEntity*       m_taEntity;               // The trick attack entity.
    CBattleEntity*       m_coverAbilityUserEntity; // The cover ability user.
    std::vector<CAttack> m_attackSwings;           // The list of attacks for this round.
    bool                 m_sataOccured;            // Flag: Did SATA occur during the round?
    bool                 m_kickAttackOccured;      // Flag: Did a kick attack occur during the round?

    std::vector<PHYSICAL_ATTACK_DIRECTION> m_followUpSwings; // The list of follow-up attacks for this round.
};
