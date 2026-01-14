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

#ifndef _CATTACK_H
#define _CATTACK_H

#include "common/cbasetypes.h"
#include "entities/battleentity.h"
#include "utils/attackutils.h"
#include "utils/battleutils.h"
#include <vector>

enum class PHYSICAL_ATTACK_TYPE
{
    NORMAL     = 0,
    DOUBLE     = 1,
    TRIPLE     = 2,
    ZANSHIN    = 3,
    KICK       = 4,
    RANGED     = 5,
    RAPID_SHOT = 6,
    SAMBA      = 7,
    QUAD       = 8,
    DAKEN      = 9,
    FOLLOWUP   = 10,
};

enum PHYSICAL_ATTACK_DIRECTION
{
    LEFTATTACK  = 0,
    RIGHTATTACK = 1,
};

enum class AttackAnimation
{
    RIGHTATTACK = 0,
    LEFTATTACK  = 1,
    RIGHTKICK   = 2,
    LEFTKICK    = 3,
    THROW       = 4
};

class CAttackRound;

/************************************************************************
 *                                                                       *
 *  A single attack object                                               *
 *                                                                       *
 ************************************************************************/
class CAttack
{
public:
    CAttack(CBattleEntity*            attacker,
            CBattleEntity*            defender,
            PHYSICAL_ATTACK_TYPE      type,
            PHYSICAL_ATTACK_DIRECTION direction,
            CAttackRound*             attackRound);

    auto GetAnimationID() -> uint16;
    auto GetAttackType() const -> PHYSICAL_ATTACK_TYPE;
    auto SetAttackType(PHYSICAL_ATTACK_TYPE type) -> void;
    auto GetAttackDirection() const -> PHYSICAL_ATTACK_DIRECTION;
    auto GetWeaponSlot() -> uint8;
    auto GetHitRate() -> uint8;
    auto GetDamage() const -> int32;
    auto SetDamage(int32 damage) -> void;
    auto IsCritical() const -> bool;
    auto SetCritical(bool crit) -> void;
    auto IsFirstSwing() const -> bool;
    auto SetAsFirstSwing(bool isFirst = true) -> void;
    auto GetDamageRatio() const -> float;
    auto IsEvaded() const -> bool;
    auto SetEvaded(bool e) -> void;
    auto IsBlocked() const -> bool;
    auto IsParried() const -> bool;
    bool IsGuarded() const;
    auto CheckGuarded() -> bool;
    auto CheckParried() -> bool;
    auto IsAnticipated() const -> bool;
    auto IsDeflected() const -> bool;
    auto CheckAnticipated() -> bool;
    auto IsSneakAttack() const -> bool;
    auto IsTrickAttack() const -> bool;
    auto IsCountered() const -> bool;
    auto CheckCounter() -> bool;
    auto IsCovered() const -> bool;
    auto CheckCover() -> bool;
    auto ProcessDamage() -> void;

private:
    CBattleEntity*            m_attacker;
    CBattleEntity*            m_victim;
    CAttackRound*             m_attackRound;
    PHYSICAL_ATTACK_TYPE      m_attackType;
    PHYSICAL_ATTACK_DIRECTION m_attackDirection;
    uint8                     m_hitRate{ 0 };
    bool                      m_isCritical{ false };
    bool                      m_isGuarded{ false };
    bool                      m_isParried{ false };
    bool                      m_isBlocked{ false };
    bool                      m_isEvaded{ false };
    bool                      m_isCountered{ false };
    bool                      m_isCovered{ false };
    bool                      m_anticipated{ false };
    bool                      m_isSA{ false };
    bool                      m_isTA{ false };
    bool                      m_isFirstSwing{ false };
    float                     m_damageRatio{ 0.0f };
    int32                     m_damage{ 0 };
    int32                     m_bonusBasePhysicalDamage{ 0 };
    int32                     m_naturalH2hDamage{ 0 };
    int32                     m_baseDamage{ 0 };
};

#endif
