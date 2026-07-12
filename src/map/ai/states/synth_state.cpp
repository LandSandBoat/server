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

#include "entities/battle_entity.h"

#include "ai/ai_container.h"
#include "utils/synthutils.h"

CSynthState::CSynthState(CCharEntity* PChar, xi::SkillType skill)
: CState(PChar, PChar->targid)
, m_PEntity(PChar)
{
    switch (skill)
    {
        case xi::SkillType::Woodworking:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_WOODWORKING));
            break;
        case xi::SkillType::Smithing:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_SMITHING));
            break;
        case xi::SkillType::Goldsmithing:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_GOLDSMITHING));
            break;
        case xi::SkillType::Clothcraft:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_CLOTHCRAFT));
            break;
        case xi::SkillType::Leathercraft:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_LEATHERCRAFT));
            break;
        case xi::SkillType::Bonecraft:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_BONECRAFT));
            break;
        case xi::SkillType::Alchemy:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_ALCHEMY));
            break;
        case xi::SkillType::Cooking:
            m_synthFinishTime -= std::chrono::milliseconds(PChar->getMod(Mod::SYNTH_SPEED_COOKING));
            break;
        default:
            break;
    }
}

bool CSynthState::Update(timer::time_point tick)
{
    // Exit state if dead
    if (m_PEntity->isDead())
    {
        synthutils::doSynthCriticalFail(m_PEntity);
        return true;
    }

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

void CSynthState::Cleanup(timer::time_point tick)
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
