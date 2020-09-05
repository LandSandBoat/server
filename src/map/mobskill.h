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

#ifndef _CMOBSKILL_H
#define _CMOBSKILL_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"

enum SKILLFLAG
{
    SKILLFLAG_NONE           = 0x000,
    SKILLFLAG_TWO_HOUR       = 0x002,
    // Special skill (ranged attack / call beast)
    SKILLFLAG_SPECIAL        = 0x004,
    SKILLFLAG_HIT_ALL        = 0x008,
    SKILLFLAG_REPLACE_ATTACK = 0x010,
    SKILLFLAG_DRAW_IN        = 0x020
};

#define MAX_MOBSKILL_ID	4262

class CMobSkill
{
public:

    CMobSkill(uint16 id);

    bool        hasMissMsg() const;
    bool        isAoE() const;
    bool        isConal() const;
    bool        isSingle() const;
    bool        isTwoHour() const;
    bool        isSpecial() const;
    bool        isTpSkill() const;

    uint16      getID() const;
    uint16      getAnimationID() const;
    uint16      getPetAnimationID() const;
    uint8       getAoe() const;
    float       getDistance() const;
    uint8       getFlag() const;
    uint16      getAnimationTime() const;
    uint16      getActivationTime() const;
    uint16      getMsg() const;
    uint16      getAoEMsg() const;
    uint16      getValidTargets() const;
    int16       getTP() const;
    uint8       getHPP() const;
    uint16      getTotalTargets() const;
    uint16      getMsgForAction() const;
    float       getRadius() const;
    int16       getParam() const;
    uint8       getKnockback() const;
    uint8       getPrimarySkillchain() const;
    uint8       getSecondarySkillchain() const;
    uint8       getTertiarySkillchain() const;

    bool        isDamageMsg();

    void        setID(uint16 id);
    void        setAnimationID(uint16 aid);
    void        setAoe(uint8 aoe);
    void        setDistance(float distance);
    void        setFlag(uint8 flag);
    void        setAnimationTime(uint16 AnimationTime);
    void        setActivationTime(uint16 ActivationTime);
    void        setMsg(uint16 msg);
    void        setValidTargets(uint16 targ);
    void        setTP(int16 tp);
    void        setHPP(uint8 hpp);
    void        setTotalTargets(uint16 targets);
    void        setParam(int16 value);
    void        setKnockback(uint8 knockback);
    void        setPrimarySkillchain(uint8 skillchain);
    void        setSecondarySkillchain(uint8 skillchain);
    void        setTertiarySkillchain(uint8 skillchain);

    const int8* getName() const;
    void        setName(int8* name);

private:

    uint16      m_ID;
    uint16      m_TotalTargets;
    int16       m_Param;
    uint16      m_AnimID;           //animation id
    uint8       m_Aoe;              // не используется
    float       m_Distance;         // не используется
    uint8       m_Flag;             // не используется
    uint16      m_ValidTarget;      //same as
    uint16      m_AnimationTime;    //how long the tp animation lasts for in ms
    uint16      m_ActivationTime;   //how long the mob prepares the tp move for
    uint16      m_Message;          //message param, scripters can edit this depending on self/resist/etc.
    int16       m_TP;               //the tp at the time of finish readying (for scripts)
    uint8       m_HPP;              // HPP at the time of using mob skill (for scripts)
    uint8       m_knockback;        //knockback value (0-7)
    uint8       m_primarySkillchain;       //weaponskill ID of skillchain properties
    uint8       m_secondarySkillchain;
    uint8       m_tertiarySkillchain;

    string_t    m_name;
};

#endif
