/*
===========================================================================

  Copyright (c) 2022 LandSandBoat Dev Team

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

#include "ability.h"
#include "common/cbasetypes.h"
#include "common/mmo.h"
#include "enums/action/knockback.h"

class CPetSkill
{
public:
    CPetSkill(uint16 id);

    auto hasMissMsg() const -> bool;
    auto isAoE() const -> bool;
    auto isConal() const -> bool;
    auto isSingle() const -> bool;
    auto isTpFreeSkill() const -> bool;
    auto isAstralFlow() const -> bool;
    auto isBloodPactWard() const -> bool;
    auto isBloodPactRage() const -> bool;

    auto getID() const -> uint16;
    auto getAnimationID() const -> ActionAnimation;
    auto getMobSkillID() const -> uint16;
    auto getAoe() const -> uint8;
    auto getDistance() const -> float;
    auto getFlag() const -> uint8;
    auto getAnimationTime() const -> timer::duration;
    auto getActivationTime() const -> timer::duration;
    auto getMsg() const -> MsgBasic;
    auto getSkillFinishCategory() const -> ActionCategory;
    auto getValidTargets() const -> uint16;
    auto getTP() const -> int16;
    auto getHP() const -> int32;
    auto getHPP() const -> uint8;
    auto getTotalTargets() const -> uint16;
    auto getPrimaryTargetID() const -> uint32;
    auto getFinalAnimationSub() -> Maybe<uint8>;
    auto getMsgForAction() const -> uint16;
    auto getRadius() const -> float;
    auto getParam() const -> int16;
    auto getKnockback() const -> Knockback;
    auto getPrimarySkillchain() const -> uint8;
    auto getSecondarySkillchain() const -> uint8;
    auto getTertiarySkillchain() const -> uint8;
    auto getAttackType() const -> xi::AttackType;
    auto isCritical() const -> bool;

    auto isDamageMsg() const -> bool;

    void setID(uint16 id);
    void setAnimationID(uint16 aid);
    void setMobSkillID(uint16 skillID);
    void setAoe(uint8 aoe);
    void setRadius(uint8 radius);
    void setDistance(float distance);
    void setFlag(uint8 flag);
    void setAnimationTime(timer::duration AnimationTime);
    void setActivationTime(timer::duration ActivationTime);
    void setMsg(MsgBasic msg);
    void setSkillFinishCategory(uint8 category);
    void setValidTargets(uint16 targ);
    void setTP(int16 tp);
    void setHP(int32 hp);
    void setHPP(uint8 hpp);
    void setTotalTargets(uint16 targets);
    void setPrimaryTargetID(uint32 targid);
    void setFinalAnimationSub(uint8 newAnimationSub);
    void setParam(int16 value);
    void setKnockback(uint8 knockback);
    void setPrimarySkillchain(uint8 skillchain);
    void setSecondarySkillchain(uint8 skillchain);
    void setTertiarySkillchain(uint8 skillchain);
    void setAttackType(xi::AttackType attackType);
    void setCritical(bool isCritical);

    auto getName() const -> const std::string&;
    void setName(const std::string& name);

private:
    uint16          m_ID;
    uint16          m_AnimID;     // animation id
    uint16          m_MobSkillID; // mobskill id for jug petskill packet to use instead of JA ability ID
    std::string     m_name;
    uint8           m_Aoe;
    uint8           m_Radius{ 0 };
    float           m_Distance;
    timer::duration m_AnimationTime;  // how long the tp animation lasts
    timer::duration m_ActivationTime; // how long the pet prepares the tp move for
    uint16          m_ValidTarget;
    MsgBasic        m_Message; // message param, scripters can edit this depending on self/resist/etc.
    uint8           m_Flag;
    int16           m_Param;
    uint8           m_SkillFinishCategory;
    uint8           m_knockback;         // knockback value (0-7)
    uint8           m_primarySkillchain; // weaponskill ID of skillchain properties
    uint8           m_secondarySkillchain;
    uint8           m_tertiarySkillchain;
    xi::AttackType  m_attackType{ xi::AttackType::None };
    bool            m_isCritical{ false };

    int16  m_TP;  // the tp at the time of finish readying (for scripts)
    int32  m_HP;  // HP at the time of using mob skill (for scripts)
    uint8  m_HPP; // HPP at the time of using mob skill (for scripts)
    uint16 m_TotalTargets;
    uint32 m_PrimaryTargetID; // primary target ID

    Maybe<uint8> m_FinalAnimationSub; // If non-null, entity will get this new animation sub after state exits
};
