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

  This file is part of DarkStar-server source code.

===========================================================================
*/

#ifndef _IFELLOWUTILS_H
#define _IFELLOWUTILS_H

#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"

enum FELLOW_TYPE : uint8
{
    FELLOW_TYPE_NONE     = 0,
    FELLOW_TYPE_SHIELD   = 1,
    FELLOW_TYPE_ATTACKER = 2,
    FELLOW_TYPE_HEALER   = 3,
    FELLOW_TYPE_STALWART = 4,
    FELLOW_TYPE_FIERCE   = 5,
    FELLOW_TYPE_SOOTHING = 6
};

enum FELLOWCHAT : uint8
{
    FELLOWCHAT_NONE          = 0,
    FELLOWCHAT_GENERAL       = 1,
    FELLOWCHAT_DISBAND       = 2,
    FELLOWCHAT_NEXTLASTENEMY = 3,
    FELLOWCHAT_LEAVE         = 4,
};

enum FELLOWMESSAGEOFFSET : uint16
{
    FELLOWMESSAGEOFFSET_WS_READY          = 0,
    FELLOWMESSAGEOFFSET_HP_LOW_NOTICE     = 15,
    FELLOWMESSAGEOFFSET_MP_LOW_NOTICE     = 30,
    FELLOWMESSAGEOFFSET_MP_FULL_NOTICE    = 45,
    FELLOWMESSAGEOFFSET_LAST_ENEMY        = 60,
    FELLOWMESSAGEOFFSET_TIME_EXPIRED      = 75,
    FELLOWMESSAGEOFFSET_LEAVE             = 90,
    FELLOWMESSAGEOFFSET_GOODBYE           = 105,
    FELLOWMESSAGEOFFSET_NOT_DONE_YET      = 120,
    FELLOWMESSAGEOFFSET_PROVOKE           = 135,
    FELLOWMESSAGEOFFSET_CALL              = 150,
    FELLOWMESSAGEOFFSET_FIVE_MIN_WARNING  = 165,
    FELLOWMESSAGEOFFSET_NEXT_LAST_ENEMY   = 180,
    FELLOWMESSAGEOFFSET_DISBAND           = 195,
    FELLOWMESSAGEOFFSET_UNABLE_TO_DISBAND = 209,
    FELLOWMESSAGEOFFSET_WEAPONSKILL       = 211,
    FELLOWMESSAGEOFFSET_FULL_HP           = 226, // 81-100%
    FELLOWMESSAGEOFFSET_HIGH_HP           = 241, // 61-80%
    FELLOWMESSAGEOFFSET_MID_HP            = 256, // 41-60%
    FELLOWMESSAGEOFFSET_LOW_HP            = 271, // 21-40%
    FELLOWMESSAGEOFFSET_NO_HP             = 286, // 1-20%
    FELLOWMESSAGEOFFSET_HIGH_MP           = 301, // 67-100%
    FELLOWMESSAGEOFFSET_MID_MP            = 316, // 34-66%
    FELLOWMESSAGEOFFSET_LOW_MP            = 331, // 0-33%
    FELLOWMESSAGEOFFSET_LOW_EXP           = 346, // 0-19%
    FELLOWMESSAGEOFFSET_SOME_EXP          = 361, // 20-39%
    FELLOWMESSAGEOFFSET_MID_EXP           = 376, // 40-59%
    FELLOWMESSAGEOFFSET_MORE_EXP          = 391, // 60-79%
    FELLOWMESSAGEOFFSET_HIGH_EXP          = 406, // 80-99%
    FELLOWMESSAGEOFFSET_GENERAL_CHAT      = 420,
    FELLOWMESSAGEOFFSET_GENERAL_CHAT2     = 434,
    FELLOWMESSAGEOFFSET_GENERAL_CHAT3     = 448,
    FELLOWMESSAGEOFFSET_WEAPONSKILL2      = 463,
    FELLOWMESSAGEOFFSET_BLESSED_RADIANCE  = 477,
    FELLOWMESSAGEOFFSET_LOW_KILLS         = 491, // 1-5 kills
    FELLOWMESSAGEOFFSET_MID_KILLS         = 505, // 6-10 kills
    FELLOWMESSAGEOFFSET_HIGH_KILLS        = 519, // 11+ kills
};

class CFellowEntity;
namespace fellowutils
{
    void   LoadFellowMessages();
    uint16 GetBase(CFellowEntity* PFellow, uint8 rank);
    void   LoadFellowList();

    void           SpawnFellow(CCharEntity* PMaster, uint32 FellowID, bool spawningFromZone);
    uint16         GetMaxTime(CCharEntity* PChar);
    CFellowEntity* LoadFellow(CCharEntity* PMaster, uint32 FellowID, bool spawningFromZone);
    uint32         GetExpNEXTLevel(uint8 charlvl);

    void   DistributeExperiencePoints(CFellowEntity* PFellow, CMobEntity* PMob, CCharEntity* PChar);
    void   AddExperiencePoints(CFellowEntity* PFellow, CBaseEntity* PMob, uint32 exp, CCharEntity* PMaster);
    void   SaveFellowExp(CCharEntity* PMaster, uint8 currentLvl, uint32 currentExp);
    void   AddKillCount(CCharEntity* PMaster);
    uint8  GetPersonalityOffset(CCharEntity* PChar);
    void   TriggerFellowChat(CCharEntity* PChar, uint8 option);
    void   AttackTarget(CBattleEntity* PMaster, CBattleEntity* PTarget);
    void   RetreatToMaster(CBattleEntity* PMaster);
    uint16 GetWeaponDmgByTypeAndLevel(SKILLTYPE skillType, uint8 level);
    uint16 GetWeaponDelayByTypeAndLevel(SKILLTYPE skillType, uint8 level);
} // namespace fellowutils

#endif
