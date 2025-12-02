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

#include "controller.h"

enum class FollowType : uint8
{
    None,
    Roam,
    RunAway,
};

class CMobEntity;
class CMobController : public CController
{
public:
    CMobController(CMobEntity* PEntity);

    virtual void Tick(timer::time_point tick) override;
    virtual auto Disengage() -> bool override;
    virtual auto Engage(uint16 targid) -> bool override;
    virtual void Despawn() override;
    virtual void Reset() override;

    virtual auto MobSkill(uint16 targid, uint16 wsid, std::optional<timer::duration> castTimeOverride) -> bool;
    virtual auto Ability(uint16 targid, uint16 abilityid) -> bool override
    {
        return false;
    }
    auto MobSkill(int listId = 0) -> bool;
    auto TryCastSpell() -> bool;
    auto TrySpecialSkill() -> bool;

    auto         CanFollowTarget(CBattleEntity*) const -> bool;
    auto         CanAggroTarget(CBattleEntity*) const -> bool;
    void         TapDeaggroTime();
    void         TapDeclaimTime();
    virtual auto Cast(uint16 targid, SpellID spellid) -> bool override;
    void         SetFollowTarget(CBaseEntity* PTarget, FollowType followType);
    auto         HasFollowTarget() const -> bool;
    void         ClearFollowTarget();
    auto         CheckHide(const CBattleEntity* PTarget) const -> bool;

    void OnCastStopped(CMagicState& state, action_t& action);

protected:
    virtual auto TryDeaggro() -> bool;

    virtual void TryLink();
    auto         CanDetectTarget(CBattleEntity* PTarget, bool forceSight = false) const -> bool;
    auto         CanPursueTarget(const CBattleEntity* PTarget) const -> bool;
    auto         CheckLock(CBattleEntity* PTarget) const -> bool;
    auto         CheckDetection(CBattleEntity* PTarget) -> bool;
    virtual auto CanCastSpells(IgnoreRecastsAndCosts ignoreRecastsAndCosts) -> bool;
    void         CastSpell(SpellID spellid);
    virtual void Move();

    virtual void DoCombatTick(timer::time_point tick);
    void         FaceTarget(uint16 targid = 0) const;
    virtual void HandleEnmity();

    virtual void DoRoamTick(timer::time_point tick);
    void         Wait(timer::duration _duration);
    void         FollowRoamPath();
    auto         CanMoveForward(float currentDistance) -> bool;
    auto         IsSpecialSkillReady(float currentDistance) const -> bool;
    auto         IsSpellReady(float currentDistance) const -> bool;

    CBattleEntity* PTarget{ nullptr };

    static constexpr float FollowRoamDistance{ 4.0f };
    static constexpr float FollowRunAwayDistance{ 4.0f };
    CBaseEntity*           PFollowTarget{ nullptr };

private:
    CMobEntity* const PMob;

    timer::time_point m_LastActionTime;
    timer::time_point m_nextMagicTime;
    timer::time_point m_LastMobSkillTime;
    timer::time_point m_LastSpecialTime;
    timer::time_point m_DeaggroTime;
    timer::time_point m_DeclaimTime;
    timer::time_point m_NeutralTime;
    timer::time_point m_WaitTime;
    timer::time_point m_mobHealTime;
    FollowType        m_followType = FollowType::None;

    bool              m_firstSpell{ true };
    timer::time_point m_LastRoamScript{ timer::time_point::min() };
};
