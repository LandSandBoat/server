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

#include "0x017_charreq2.h"

#include "common/utils.h"

#include <algorithm>
#include <array>

#include "entities/char_entity.h"
#include "packets/char_sync.h"
#include "packets/char_update.h"

namespace
{

constexpr float CHARREQ2_SYNC_RANGE = 50.0f;

auto resolveByUniqueNo(const CCharEntity* PChar, const uint32 uniqueNo) -> CBaseEntity*
{
    if (uniqueNo == 0 || PChar->loc.zone == nullptr)
    {
        return nullptr;
    }

    if (auto* PEntity = PChar->loc.zone->GetEntity(uniqueNo & 0xFFF); PEntity && PEntity->id == uniqueNo)
    {
        return PEntity;
    }

    return PChar->loc.zone->GetCharByID(uniqueNo);
}

} // namespace

auto GP_CLI_COMMAND_CHARREQ2::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar);
}

void GP_CLI_COMMAND_CHARREQ2::process(MapSession* PSession, CCharEntity* PChar) const
{
    const std::array targets{
        this->ActIndex ? PChar->GetEntity(this->ActIndex) : nullptr,
        resolveByUniqueNo(PChar, this->UniqueNo2),
        resolveByUniqueNo(PChar, this->UniqueNo3),
    };

    ShowWarningFmt("GP_CLI_COMMAND_CHARREQ2 from {}: ActIndex={} UniqueNo2={} UniqueNo3={} Flg={} Flg2={}",
                   PChar->getName(),
                   this->ActIndex,
                   this->UniqueNo2,
                   this->UniqueNo3,
                   this->Flg,
                   this->Flg2);

    for (size_t i = 0; i < targets.size(); ++i)
    {
        auto* PTarget = targets[i];
        if (PTarget == nullptr)
        {
            continue;
        }

        const auto seen = std::ranges::subrange(targets.begin(), targets.begin() + i);
        if (std::ranges::find(seen, PTarget) != seen.end())
        {
            continue;
        }

        const float dist = distance(PChar->loc.p, PTarget->loc.p);
        if (dist > CHARREQ2_SYNC_RANGE)
        {
            ShowWarningFmt("GP_CLI_COMMAND_CHARREQ2 from {}: target {} ({}) is {:.1f}y away (beyond {}y)", PChar->getName(), PTarget->getName(), PTarget->id, dist, CHARREQ2_SYNC_RANGE);
        }

        if (PTarget->objtype == TYPE_PC)
        {
            auto* PTargetChar = static_cast<CCharEntity*>(PTarget);
            if (PTargetChar->m_isGMHidden)
            {
                continue;
            }

            PChar->updateEntityPacket(PTargetChar, ENTITY_SPAWN, UPDATE_ALL_CHAR);

            if (dist <= CHARREQ2_SYNC_RANGE)
            {
                PChar->pushPacket<CCharSyncPacket>(PTargetChar);
                PChar->pushPacket<CCharUpdatePacket>(PTargetChar, ENTITY_UPDATE, static_cast<uint8>(UPDATE_NAME));
            }
        }
        else
        {
            PChar->updateEntityPacket(PTarget, ENTITY_UPDATE, static_cast<uint8>(UPDATE_ALL_MOB));
        }
    }
}
