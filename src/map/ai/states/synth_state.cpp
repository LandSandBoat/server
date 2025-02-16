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

#include "synth_state.h"

#include "entities/battleentity.h"

#include "ai/ai_container.h"
#include "packets/action.h"
#include "packets/lock_on.h"
#include "utils/battleutils.h"
#include "utils/synthutils.h"

CSynthState::CSynthState(CCharEntity* PChar, SKILLTYPE skill)
: CState(PChar, PChar->targid)
, m_PEntity(PChar)
{
    switch (skill)
    {
        case SKILL_WOODWORKING:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_WOODWORKING));
            break;
        case SKILL_SMITHING:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_SMITHING));
            break;
        case SKILL_GOLDSMITHING:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_GOLDSMITHING));
            break;
        case SKILL_CLOTHCRAFT:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_CLOTHCRAFT));
            break;
        case SKILL_LEATHERCRAFT:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_LEATHERCRAFT));
            break;
        case SKILL_BONECRAFT:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_BONECRAFT));
            break;
        case SKILL_ALCHEMY:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_ALCHEMY));
            break;
        case SKILL_COOKING:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_COOKING));
            break;
        default:
            break;
    }
}

bool CSynthState::Update(time_point tick)
{
    if (SynthReady())
    {
        synthutils::sendSynthDone(m_PEntity);
        return true;
    }
    else
    {
        m_synthFinishTime -= (m_PEntity->PAI->getTick() - m_PEntity->PAI->getPrevTick());
    }
    return false;
}

void CSynthState::Cleanup(time_point tick)
{
    std::ignore = tick;
}

void CSynthState::UpdateTarget(CBaseEntity* target)
{
    std::ignore = target;
}

// stub
void CSynthState::UpdateTarget(uint16 targid)
{
    std::ignore = targid;
}

bool CSynthState::SynthReady()
{
    return m_synthFinishTime < 0ms && m_PEntity->isAlive();
}
