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

#ifndef _TARGETFIND_H
#define _TARGETFIND_H

#include "common/cbasetypes.h"
#include "common/mmo.h"
#include "entities/baseentity.h"

#include <vector>

class CBattleEntity;

// max targets a mobs buff move will accept
// 10+ will cause a crash
#define MAX_AOE_BUFF_TARGETS 9

// max targets for offensive AoEs
#define MAX_AOE_TARGETS 12

// allow pets to recieve buffs from protectra, curaga etc
#define PETS_CAN_AOE_BUFF false

enum class AOE_RADIUS : uint8
{
    ATTACKER = 1,
    TARGET   = 2
};

enum class AURA_TARGET : uint8
{
    ALLIES  = 0,
    ENEMIES = 1
};

enum FINDFLAGS
{
    FINDFLAGS_NONE            = 0,
    FINDFLAGS_DEAD            = 1,  // target dead
    FINDFLAGS_ALLIANCE        = 2,  // force target alliance
    FINDFLAGS_PET             = 4,  // force target pet
    FINDFLAGS_UNLIMITED       = 8,  // unlimited distance
    FINDFLAGS_HIT_ALL         = 16, // hit all targets, regardless of party
    FINDFLAGS_IGNORE_BATTLEID = 32, // ignore battle id check
};

/*

Every targetfinder has a context in which to find targets. See below.

Cases:

If player -> monster
I can hit all monsters around and their pets. If the monsters are not controlled by a player.

If monster -> player
I can hit all players in the party, alliance and their pets.

If player -> player
I can hit all players in my party.

If monster -> monster
I can hit all monsters in my party.

*/
enum class FIND_TYPE : uint8
{
    NONE            = 0,
    PLAYER_PLAYER   = 1,
    MONSTER_MONSTER = 2,
    PLAYER_MONSTER  = 3,
    MONSTER_PLAYER  = 4
};

class CTargetFind
{
public:
    CTargetFind(CBattleEntity* PBattleEntity);

    void reset(); // remove all found targets

    // Main methods for finding targets
    void findSingleTarget(CBattleEntity* PTarget, uint8 flags = FINDFLAGS_NONE);
    void findWithinArea(CBattleEntity* PTarget, AOE_RADIUS radiusType, float radius, uint8 flags = FINDFLAGS_NONE);
    void findWithinCone(CBattleEntity* PTarget, float distance, float angle, uint8 flags = FINDFLAGS_NONE);

    // add all targets in contexts
    void addAllInZone(CBattleEntity* PTarget, bool withPet);
    void addAllInAlliance(CBattleEntity* PTarget, bool withPet);
    void addAllInParty(CBattleEntity* PTarget, bool withPet);
    void addAllInMobList(CBattleEntity* PTarget, bool withPet);
    void addAllInEnmityList();
    void addAllInRange(CBattleEntity* PTarget, float radius, ALLEGIANCE_TYPE allegiance);
    void addEntity(CBattleEntity* PTarget, bool withPet);

    // helpers
    bool           isMobOwner(CBattleEntity* PTarget);
    CBattleEntity* findMaster(CBattleEntity* PTarget);
    bool           validEntity(CBattleEntity* PTarget);
    bool           checkIsPlayer(CBattleEntity* PTarget);

    bool isWithinArea(position_t* pos);
    bool isWithinCone(position_t* pos);
    bool isWithinRange(position_t* pos, float range);

    CBattleEntity* getValidTarget(uint16 actionTargetID, uint16 validTargetFlags);

    std::vector<CBattleEntity*> m_targets; // contains all found entities

protected:
    bool        isPlayer; // is this from a player?
    float       m_radius;
    position_t* m_PRadiusAround;

    CBattleEntity* m_PBattleEntity; // user

    CBattleEntity* m_PMasterTarget; // mater of target
    CBattleEntity* m_PTarget;       // first target

    uint16    m_zone;
    FIND_TYPE m_findType;
    uint8     m_findFlags;

    // conal vars
    bool        m_conal;
    float       m_scalar;
    position_t* m_APoint;
    position_t  m_BPoint;
    position_t  m_CPoint;
};

#endif
