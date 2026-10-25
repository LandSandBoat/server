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

#include "common/cbasetypes.h"

#include "entities/battle_entity.h"
#include "enums/action/animation.h"

#define MAX_WEAPONSKILL_ID 256

class CWeaponSkill
{
public:
    CWeaponSkill(uint16 id);

    auto getID() const -> uint16;
    auto getJob(xi::Job JobID) -> uint8;
    auto getSkillLevel() const -> uint16;
    auto getRange() const -> float;
    auto getElement() const -> uint8;
    auto isElemental() const -> bool;

    auto isAoE() const -> bool;
    auto mainOnly() const -> bool; // can only be used as main job
    auto getAoe() const -> uint8;
    auto getRadius() const -> float;
    auto getAnimationId() const -> ActionAnimation;
    auto getAnimationTime() -> timer::duration;
    auto getType() const -> uint8;
    auto getUnlockId() const -> uint8;

    void setID(uint16 id);
    void setJob(const std::array<uint8, MAX_JOBTYPE>& jobs);
    void setSkillLevel(uint16 level);
    void setRange(float range);
    void setElement(uint8 element);
    void setPrimarySkillchain(uint8 skillchain);
    void setSecondarySkillchain(uint8 skillchain);
    void setTertiarySkillchain(uint8 skillchain);
    void setAoe(uint8 aoe);
    void setRadius(float radius);
    void setAnimationId(uint8 id);
    void setAnimationTime(timer::duration time);
    void setType(uint8 type);
    void setMainOnly(uint8 main);
    void setUnlockId(uint8 id);

    auto getPrimarySkillchain() const -> uint8;
    auto getSecondarySkillchain() const -> uint8;
    auto getTertiarySkillchain() const -> uint8;

    auto getName() -> const std::string&;
    void setName(const std::string& name);

private:
    uint16                         m_ID;
    uint8                          m_TypeID;
    std::array<uint8, MAX_JOBTYPE> m_Job{};
    uint16                         m_Skilllevel;
    uint8                          m_AnimationId;
    timer::duration                m_AnimationTime{};
    uint8                          m_Element;
    uint8                          m_PrimarySkillchain;
    uint8                          m_SecondarySkillchain;
    uint8                          m_TertiarySkillchain;
    float                          m_Range;
    uint8                          m_AOE;
    float                          m_Radius{ 0 };
    uint8                          m_mainOnly;
    uint8                          m_unlockId;

    std::string m_name;
};
