/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "common/logging.h"
#include "common/timer.h"

#include "alliance.h"
#include "entities/battleentity.h"
#include "ipc_client.h"
#include "job_points.h"
#include "latent_effect_container.h"
#include "map_server.h"
#include "party/mob_party.h"
#include "status_effect_container.h"
#include "treasure_pool.h"
#include "utils/blueutils.h"
#include "utils/charutils.h"
#include "utils/jailutils.h"
#include "utils/zoneutils.h"
#include <cstring>
#include <vector>

#include "packets/char_abilities.h"
#include "packets/char_status.h"
#include "packets/char_sync.h"
#include "packets/menu_config.h"
#include "packets/message_basic.h"
#include "packets/message_standard.h"
#include "packets/party_define.h"
#include "packets/party_effects.h"
#include "packets/party_member_update.h"

CMobParty::~CMobParty()
{
    for (const auto& member : members)
    {
        if (member != nullptr)
        {
            member->clearParty();
        }
    }
}

auto CMobParty::getMembers() const -> const std::vector<CMobEntity*>&
{
    return members;
}

auto CMobParty::addMember(CMobEntity* PEntity) -> bool
{
    if (PEntity == nullptr)
    {
        ShowWarning("CMobParty::addMember() - PEntity was null, or PParty mismatch.");
        return false;
    }

    members.push_back(PEntity);
    PEntity->setParty(*this);

    return true;
}

auto CMobParty::removeMember(CMobEntity* PEntity) -> bool
{
    auto count = std::erase_if(members, [PEntity](CMobEntity* member)
                               { return member == PEntity; });

    return count > 0;
}

// Executes an arbitrary function for each mob member
void CMobParty::ForEveryMember(const std::function<void(CMobEntity*)>& func) const
{
    for (const auto& member : getMembers())
    {
        func(member);
    }
}
