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

#include "targetfind.h"

#include "ai/ai_container.h"
#include "ai/states/inactive_state.h"
#include "alliance.h"
#include "common/mmo.h"
#include "common/utils.h"
#include "enmity_container.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"
#include "entities/trustentity.h"
#include "packets/action.h"
#include "status_effect_container.h"
#include "utils/zoneutils.h"

#include <cmath>

CTargetFind::CTargetFind(CBattleEntity* PBattleEntity)
: isPlayer(false)
, m_radius(0.0f)
, m_PRadiusAround(nullptr)
, m_PBattleEntity(PBattleEntity)
, m_PMasterTarget(nullptr)
, m_PTarget(nullptr)
, m_zone(0)
, m_findType{}
, m_findFlags(0)
, m_targetFlags(0)
, m_conal(false)
, m_scalar(0.0f)
, m_APoint(nullptr)
, m_BPoint{}
, m_CPoint{}
{
    reset();
}

void CTargetFind::reset()
{
    m_findType = FIND_TYPE::NONE;
    m_targets.clear();
    m_conal     = false;
    m_radius    = 0.0f;
    m_zone      = 0;
    m_findFlags = FINDFLAGS_NONE;

    m_APoint        = nullptr;
    m_PRadiusAround = nullptr;
    m_PTarget       = nullptr;
    m_PMasterTarget = nullptr;
}

void CTargetFind::findSingleTarget(CBattleEntity* PTarget, uint8 findFlags, uint16 targetFlags)
{
    m_findFlags     = findFlags;
    m_zone          = m_PBattleEntity->getZone();
    m_PTarget       = nullptr;
    m_PRadiusAround = &PTarget->loc.p;

    addEntity(PTarget, false);
}

void CTargetFind::findWithinArea(CBattleEntity* PTarget, AOE_RADIUS radiusType, float radius, uint8 findFlags, uint16 targetFlags)
{
    TracyZoneScoped;
    m_findFlags   = findFlags;
    m_targetFlags = targetFlags;
    m_radius      = radius;
    m_zone        = m_PBattleEntity->getZone();

    if (radiusType == AOE_RADIUS::ATTACKER)
    {
        m_PRadiusAround = &m_PBattleEntity->loc.p;
    }
    else
    {
        // radius around target
        m_PRadiusAround = &PTarget->loc.p;
    }

    // get master to properly handle loops
    m_PMasterTarget = findMaster(PTarget);

    // no not include pets if this AoE is a buff spell
    // this is a buff because i'm targetting my self
    bool withPet = PETS_CAN_AOE_BUFF || (m_findFlags & FINDFLAGS_PET) || (m_PMasterTarget->objtype != m_PBattleEntity->objtype);

    // always add original target first
    addEntity(PTarget, false); // pet will be added later

    m_PTarget = PTarget;
    isPlayer  = checkIsPlayer(m_PBattleEntity);

    if (isPlayer)
    {
        // handle this as a player
        if (m_PMasterTarget->objtype == TYPE_PC)
        {
            // players will never need to add whole alliance
            m_findType = FIND_TYPE::PLAYER_PLAYER;

            if (m_PMasterTarget->PParty != nullptr)
            {
                // player -ra spells should never hit whole alliance
                if ((m_findFlags & FINDFLAGS_ALLIANCE) && m_PMasterTarget->PParty->m_PAlliance != nullptr)
                {
                    addAllInAlliance(m_PMasterTarget, withPet);
                }
                else
                {
                    // add party members
                    addAllInParty(m_PMasterTarget, withPet);
                }
            }
            else
            {
                // just add myself
                addEntity(m_PMasterTarget, withPet);
            }
        }
        else
        {
            m_findType = FIND_TYPE::PLAYER_MONSTER;
            // special case to add all mobs in range
            addAllInMobList(m_PMasterTarget, false);
        }
    }
    else
    {
        // handle this as a mob
        if (m_PMasterTarget->objtype == TYPE_PC || m_PBattleEntity->allegiance == ALLEGIANCE_TYPE::PLAYER)
        {
            m_findType = FIND_TYPE::MONSTER_PLAYER;
        }
        else
        {
            m_findType = FIND_TYPE::MONSTER_MONSTER;
        }

        // do not include pets in monster AoE buffs
        if (m_findType == FIND_TYPE::MONSTER_MONSTER && m_PTarget->PMaster == nullptr)
        {
            withPet = PETS_CAN_AOE_BUFF;
        }

        if (m_findFlags & FINDFLAGS_HIT_ALL || (m_findType == FIND_TYPE::MONSTER_PLAYER && ((CMobEntity*)m_PBattleEntity)->GetCallForHelpFlag()))
        {
            addAllInZone(m_PMasterTarget, withPet);
        }
        else
        {
            addAllInAlliance(m_PMasterTarget, withPet);

            // Is the monster casting on a player..
            if (m_findType == FIND_TYPE::MONSTER_PLAYER)
            {
                if (m_PBattleEntity->allegiance == ALLEGIANCE_TYPE::PLAYER)
                {
                    addAllInZone(m_PMasterTarget, withPet);
                }
                else
                {
                    addAllInEnmityList();
                }
            }
        }
    }
}

void CTargetFind::findWithinCone(CBattleEntity* PTarget, float distance, float angle, uint8 findFlags, uint16 targetFlags, uint8 aoeType)
{
    m_findFlags   = findFlags;
    m_targetFlags = targetFlags;
    m_conal       = true;

    m_APoint = &m_PBattleEntity->loc.p;

    uint8 halfAngle = static_cast<uint8>((angle * (256.0f / 360.0f)) / 2.0f);

    // Confirmation on the center of cones is still needed for mob skills; player skills seem to be facing angle
    // uint8 angleToTarget = worldAngle(m_PBattleEntity->loc.p, PTarget->loc.p);
    uint8 angleToTarget = relativeAngle(m_APoint->rotation, 128 * (aoeType == 8)); // adds 180 degree rotation if rear type

    // "Left" and "Right" are like the entity's face - "left" means "turning to the left" NOT "left when looking overhead"
    // Remember that rotation increases when turning to the right, and decreases when turning to the left
    float leftAngle  = rotationToRadian(relativeAngle(angleToTarget, -halfAngle));
    float rightAngle = rotationToRadian(relativeAngle(angleToTarget, halfAngle));

    // calculate end points for triangle
    m_BPoint.x = cosf((2 * (float)M_PI) - rightAngle) * distance + m_APoint->x;
    m_BPoint.z = sinf((2 * (float)M_PI) - rightAngle) * distance + m_APoint->z;

    m_CPoint.x = cosf((2 * (float)M_PI) - leftAngle) * distance + m_APoint->x;
    m_CPoint.z = sinf((2 * (float)M_PI) - leftAngle) * distance + m_APoint->z;

    // ShowDebug("angle %f, left %f, right %f, distance %f, A (%f, %f) B (%f, %f) C (%f, %f)", angle, leftAngle, rightAngle, distance, m_APoint->x,
    // m_APoint->z, m_BPoint.x, m_BPoint.z, m_CPoint.x, m_CPoint.z); ShowDebug("Target: (%f, %f)", PTarget->loc.p.x, PTarget->loc.p.z);

    // precompute for next stage
    m_BPoint.x = m_BPoint.x - m_APoint->x;
    m_BPoint.z = m_BPoint.z - m_APoint->z;

    m_CPoint.x = m_CPoint.x - m_APoint->x;
    m_CPoint.z = m_CPoint.z - m_APoint->z;

    // calculate scalar
    m_scalar = (m_BPoint.x * m_CPoint.z) - (m_BPoint.z * m_CPoint.x);

    findWithinArea(PTarget, AOE_RADIUS::ATTACKER, distance, findFlags, targetFlags);
}

void CTargetFind::addAllInMobList(CBattleEntity* PTarget, bool withPet)
{
    CCharEntity* PChar = dynamic_cast<CCharEntity*>(findMaster(m_PBattleEntity));
    if (PChar)
    {
        FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PBattleTarget, PChar->SpawnMOBList)
        {
            if (PBattleTarget && isMobOwner(PBattleTarget))
            {
                addEntity(PBattleTarget, withPet);
            }
        }
    }
}

void CTargetFind::addAllInZone(CBattleEntity* PTarget, bool withPet)
{
    TracyZoneScoped;
    // clang-format off
    zoneutils::GetZone(PTarget->getZone())->ForEachCharInstance(PTarget, [&](CCharEntity* PChar)
    {
        if (PChar)
        {
            addEntity(PChar, withPet);
        }
    });
    zoneutils::GetZone(PTarget->getZone())->ForEachMobInstance(PTarget, [&](CMobEntity* PMob)
    {
        if (PMob)
        {
            addEntity(PMob, withPet);
        }
    });
    zoneutils::GetZone(PTarget->getZone())->ForEachTrustInstance(PTarget, [&](CTrustEntity* PTrust)
    {
        if (PTrust)
        {
            addEntity(PTrust, withPet);
        }
    });
    // clang-format on
}

void CTargetFind::addAllInAlliance(CBattleEntity* PTarget, bool withPet)
{
    // clang-format off
    PTarget->ForAlliance([this, withPet](CBattleEntity* PMember)
    {
        addEntity(PMember, withPet);
    });
    // clang-format on
}

void CTargetFind::addAllInParty(CBattleEntity* PTarget, bool withPet)
{
    // clang-format off
    if (PTarget->objtype == TYPE_PC)
    {
        static_cast<CCharEntity*>(PTarget)->ForPartyWithTrusts([this, withPet](CBattleEntity* PMember)
        {
            if (!PMember->isInMogHouse())
            {
                addEntity(PMember, withPet);
            }
        });
    }
    else
    {
        PTarget->ForParty([this, withPet](CBattleEntity* PMember)
        {
            addEntity(PMember, withPet);
        });
    }
    // clang-format on
}

void CTargetFind::addAllInEnmityList()
{
    if (m_PBattleEntity->objtype == TYPE_MOB)
    {
        CMobEntity* PMob = static_cast<CMobEntity*>(m_PBattleEntity);

        for (const auto& [_, PEnmityObject] : *PMob->PEnmityContainer->GetEnmityList())
        {
            if (PEnmityObject.PEnmityOwner)
            {
                addEntity(PEnmityObject.PEnmityOwner, false);
            }
        }
    }
}

void CTargetFind::addAllInRange(CBattleEntity* PTarget, float radius, ALLEGIANCE_TYPE allegiance)
{
    m_radius        = radius;
    m_PRadiusAround = &(m_PBattleEntity->loc.p);

    if (PTarget && allegiance == ALLEGIANCE_TYPE::PLAYER)
    {
        if (PTarget->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(PTarget);
            for (auto& spawnList : { PChar->SpawnPCList, PChar->SpawnPETList })
            {
                FOR_EACH_PAIR_CAST_SECOND(CBattleEntity*, PBattleEntity, spawnList)
                {
                    if (PBattleEntity && isWithinArea(&(PBattleEntity->loc.p)) && !PBattleEntity->isDead() &&
                        PBattleEntity->allegiance == ALLEGIANCE_TYPE::PLAYER)
                    {
                        m_targets.emplace_back(PBattleEntity);
                    }
                }
            }
        }
        else
        {
            // clang-format off
            zoneutils::GetZone(PTarget->getZone())->ForEachCharInstance(PTarget, [&](CCharEntity* PChar)
            {
                if (PChar && isWithinArea(&(PChar->loc.p)) && !PChar->isDead())
                {
                    m_targets.emplace_back(PChar);
                }
            });
            // clang-format on
        }
    }
}

void CTargetFind::addEntity(CBattleEntity* PTarget, bool withPet)
{
    if (validEntity(PTarget))
    {
        m_targets.emplace_back(PTarget);
    }

    // add my pet too, if its allowed
    if (withPet && PTarget->PPet != nullptr && validEntity(PTarget->PPet))
    {
        m_targets.emplace_back(PTarget->PPet);
    }
}

CBattleEntity* CTargetFind::findMaster(CBattleEntity* PTarget)
{
    if (PTarget->PMaster != nullptr)
    {
        return PTarget->PMaster;
    }
    return PTarget;
}

bool CTargetFind::isMobOwner(CBattleEntity* PTarget)
{
    if (m_PBattleEntity->objtype != TYPE_PC || PTarget->objtype == TYPE_PC)
    {
        // always true for mobs, npcs, pets
        return true;
    }

    if (PTarget->m_OwnerID.id == 0 || PTarget->m_OwnerID.id == m_PBattleEntity->id)
    {
        return true;
    }

    bool found = false;

    // clang-format off
    m_PBattleEntity->ForAlliance([&found, &PTarget](CBattleEntity* PMember)
    {
        if (PMember->id == PTarget->m_OwnerID.id)
        {
            found = true;
        }
    });
    // clang-format on

    return found;
}

/*
validEntity will check if the given entity can be targeted in the AoE.

*/
bool CTargetFind::validEntity(CBattleEntity* PTarget)
{
    // Check if entity is already in list
    // TODO: Does it make sense to use a hashmap here instead?
    if (std::find(m_targets.begin(), m_targets.end(), PTarget) != m_targets.end())
    {
        return false;
    }

    if (!(m_findFlags & FINDFLAGS_DEAD) && PTarget->isDead())
    {
        return false;
    }

    if (m_PBattleEntity->StatusEffectContainer->GetConfrontationEffect() != PTarget->StatusEffectContainer->GetConfrontationEffect() ||
        m_PBattleEntity->PBattlefield != PTarget->PBattlefield || m_PBattleEntity->PInstance != PTarget->PInstance ||
        ((m_findFlags & FINDFLAGS_IGNORE_BATTLEID) == FINDFLAGS_NONE && m_PBattleEntity->getBattleID() != PTarget->getBattleID()))
    {
        return false;
    }

    if (m_PTarget == PTarget || PTarget->getZone() != m_zone || PTarget->GetUntargetable() || PTarget->status == STATUS_TYPE::INVISIBLE)
    {
        return false;
    }

    // Super Jump or otherwise untargetable
    if (PTarget->PAI->IsUntargetable())
    {
        return false;
    }

    // this is first target, always add him first
    if (m_PTarget == nullptr)
    {
        return true;
    }

    if (m_PTarget->allegiance != PTarget->allegiance)
    {
        return false;
    }

    // If offensive, don't target other entities with same allegiance
    // Cures can be AoE with Accession and Majesty, ideally we would use SPELLGROUP or some other mechanism, but TargetFind wasn't designed with that in mind
    if ((m_targetFlags & TARGET_ENEMY) && !(m_targetFlags & TARGET_PLAYER_PARTY) &&
        m_PBattleEntity->allegiance == PTarget->allegiance)
    {
        return false;
    }

    // shouldn't add if target is charmed by the enemy
    if (PTarget->PMaster != nullptr)
    {
        if (m_findType == FIND_TYPE::MONSTER_PLAYER)
        {
            if (PTarget->PMaster->objtype == TYPE_MOB)
            {
                return false;
            }
        }
        else if (m_findType == FIND_TYPE::PLAYER_MONSTER)
        {
            if (PTarget->PMaster->objtype == TYPE_PC)
            {
                return false;
            }
        }
        else if (m_findType == FIND_TYPE::MONSTER_MONSTER || m_findType == FIND_TYPE::PLAYER_PLAYER)
        {
            return PTarget->objtype == TYPE_TRUST;
        }
    }

    // check placement
    // force first target to be added
    // this will be removed when conal targetting is polished
    if (m_conal)
    {
        if (isWithinCone(&PTarget->loc.p))
        {
            return true;
        }
    }
    else
    {
        if ((m_findFlags & FINDFLAGS_UNLIMITED) || isWithinArea(&PTarget->loc.p))
        {
            return true;
        }
    }

    return false;
}

bool CTargetFind::checkIsPlayer(CBattleEntity* PTarget)
{
    if (PTarget == nullptr)
    {
        return false;
    }
    if (PTarget->objtype == TYPE_PC)
    {
        return true;
    }

    // check if i'm owned by a pc
    return PTarget->PMaster != nullptr && PTarget->PMaster->objtype == TYPE_PC;
}

bool CTargetFind::isWithinArea(position_t* pos)
{
    return distance(*m_PRadiusAround, *pos) <= m_radius;
}

bool CTargetFind::isWithinCone(position_t* pos)
{
    position_t PPoint;

    // holds final weight
    position_t WPoint;

    // move origin to one vertex
    PPoint.x = pos->x - m_APoint->x;
    PPoint.z = pos->z - m_APoint->z;

    WPoint.x = (PPoint.x * (m_BPoint.z - m_CPoint.z) + PPoint.z * (m_CPoint.x - m_BPoint.x) + m_BPoint.x * m_CPoint.z - m_CPoint.x * m_BPoint.z) / m_scalar;

    WPoint.y = (PPoint.x * m_CPoint.z - PPoint.z * m_CPoint.x) / m_scalar;
    WPoint.z = (PPoint.z * m_BPoint.x - PPoint.x * m_BPoint.z) / m_scalar;

    if (WPoint.x < 0 || WPoint.x > 1)
    {
        return false;
    }

    if (WPoint.y < 0 || WPoint.y > 1)
    {
        return false;
    }

    if (WPoint.z < 0 || WPoint.z > 1)
    {
        return false;
    }

    return true;
}

bool CTargetFind::isWithinRange(position_t* pos, float range)
{
    return distance(m_PBattleEntity->loc.p, *pos) <= range;
}

CBattleEntity* CTargetFind::getValidTarget(uint16 actionTargetID, uint16 validTargetFlags)
{
    CBattleEntity* PTarget = (CBattleEntity*)m_PBattleEntity->GetEntity(actionTargetID, TYPE_MOB | TYPE_PC | TYPE_PET | TYPE_TRUST);

    if (PTarget == nullptr)
    {
        return nullptr;
    }

    if (validTargetFlags & TARGET_PET)
    {
        return m_PBattleEntity->PPet;
    }

    bool ignoreBattleId  = (validTargetFlags & TARGET_IGNORE_BATTLEID) == TARGET_IGNORE_BATTLEID;
    bool hasSameBattleId = m_PBattleEntity->getBattleID() == PTarget->getBattleID();
    if ((ignoreBattleId || hasSameBattleId) && PTarget->ValidTarget(m_PBattleEntity, validTargetFlags))
    {
        return PTarget;
    }

    return nullptr;
}
