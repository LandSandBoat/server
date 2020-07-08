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

#ifndef _AUTOMATONCONTROLLER_H
#define _AUTOMATONCONTROLLER_H

#include "pet_controller.h"
#include "../../entities/automatonentity.h"
#include "../../status_effect.h"
#include "../../spell.h"
#include <optional>

struct CurrentManeuvers
{
    int fire{ 0 };
    int ice{ 0 };
    int wind{ 0 };
    int earth{ 0 };
    int thunder{ 0 };
    int water{ 0 };
    int light{ 0 };
    int dark{ 0 };
};

struct AutomatonSpell
{
    uint16 skilllevel{ 0 };
    uint8 heads{ 0 };
    EFFECT enfeeble{ EFFECT_KO };
    IMMUNITY immunity{ IMMUNITY_NONE };
    std::vector<EFFECT> removes;
};

class CAutomatonEntity;

class CAutomatonController : public CPetController
{
public:
    CAutomatonController(CAutomatonEntity* PPet);

    virtual bool Disengage() override;
protected:
    virtual void DoCombatTick(time_point tick) override;
    virtual void Move() override;

    void setCooldowns();
    void setMagicCooldowns();
    virtual bool CanCastSpells() override;
    virtual bool Cast(uint16 targid, SpellID spellid) override;
    virtual bool MobSkill(uint16 targid, uint16 wsid) override;

private:
    bool TryAction();
    bool TryShieldBash();
    bool TrySpellcast(const CurrentManeuvers& maneuvers);
    bool TryHeal(const CurrentManeuvers& maneuvers);
    bool TryElemental(const CurrentManeuvers& maneuvers);
    bool TryEnfeeble(const CurrentManeuvers& maneuvers);
    bool TryStatusRemoval(const CurrentManeuvers& maneuvers);
    bool TryEnhance();
    bool TryTPMove();
    bool TryRangedAttack();
    bool TryAttachment();
    bool isRanged();

    CurrentManeuvers GetCurrentManeuvers() const;

    CAutomatonEntity* PAutomaton;

    duration m_actionCooldown{ 3s };
    duration m_rangedCooldown;
    static constexpr int m_RangedAbility{ 1949 };
    duration m_magicCooldown;
    duration m_enfeebleCooldown;
    duration m_elementalCooldown;
    duration m_healCooldown;
    duration m_enhanceCooldown;
    duration m_statusCooldown;
    duration m_shieldbashCooldown;
    static constexpr int m_ShieldBashAbility{ 1944 };

    time_point m_LastActionTime;
    time_point m_LastMagicTime;
    time_point m_LastEnfeebleTime;
    time_point m_LastElementalTime;
    time_point m_LastHealTime;
    time_point m_LastEnhanceTime;
    time_point m_LastStatusTime;
    time_point m_LastRangedTime;
    time_point m_LastShieldBashTime;
};

namespace autoSpell
{
    void LoadAutomatonSpellList();
    bool CanUseSpell(CAutomatonEntity* PCaster, SpellID spellid);
    bool CanUseEnfeeble(CBattleEntity* PTarget, SpellID spell);
    std::optional<SpellID> FindNaSpell(CStatusEffect* PStatus);
};

#endif
