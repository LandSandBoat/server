#include "dummyentity.h"

#include "../../common/logging.h"
#include "../../common/timer.h"
#include "../../common/utils.h"

#include "../ai/ai_container.h"
#include "../ai/controllers/player_charm_controller.h"

#include "../packets/char.h"
#include "../packets/char_update.h"
#include "../packets/char_health.h"

#include <memory>

CDummyEntity::CDummyEntity(CCharEntity* PChar)
: CCharEntity()
, PathFind(std::make_unique<CPathFind>(this))
{
    targetLocation = PChar->loc.p;
}

CDummyEntity::~CDummyEntity()
{
}

void CDummyEntity::Tick(time_point tick)
{
    // Move
    if (distance(this->loc.p, targetLocation) < 2.0f)
    {
        targetLocation = this->loc.zone->m_navMesh->findRandomPosition(this->loc.p, 20.0f).second;
    }
    else
    {
        if (!PathFind->IsFollowingPath())
        {
            PathFind->PathTo(targetLocation, PATHFLAG_RUN, false);
        }
        PathFind->FollowPath();
    }

    // Build update mask
    if (m_previousLocation.p.x != loc.p.x ||
        m_previousLocation.p.y != loc.p.y ||
        m_previousLocation.p.z != loc.p.z)
    {
        updatemask |= UPDATE_POS;
    }

    // Cache info
    m_previousLocation = loc;
};

void CDummyEntity::PostTick()
{
    if (updatemask)
    {
        if (loc.zone && !m_isGMHidden)
        {
            loc.zone->PushPacket(this, CHAR_INRANGE, new CCharPacket(this, ENTITY_UPDATE, updatemask));
        }
        if (updatemask & UPDATE_HP)
        {
            ForAlliance([&](auto PEntity) {
                if (PEntity->objtype == TYPE_PC)
                {
                    static_cast<CCharEntity*>(PEntity)->pushPacket(new CCharHealthPacket(this));
                }
            });
        }
        updatemask = 0;
    }
}