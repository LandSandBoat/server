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

#include "death_state.h"

#include "ai/ai_container.h"
#include "entities/battleentity.h"
#include "entities/charentity.h"
#include "packets/s2c/0x0f9_res.h"
#include "status_effect.h"
#include "status_effect_container.h"

namespace
{

static const timer::duration TIME_TO_SEND_RERAISE_MENU = 8s;

}

CDeathState::CDeathState(CBattleEntity* PEntity, timer::duration death_time)
: CState(PEntity, PEntity->targid)
, m_PEntity(PEntity)
, m_deathTime(death_time)
, m_raiseTime(GetEntryTime() + TIME_TO_SEND_RERAISE_MENU)
{
    m_PEntity->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DEATH, EffectNotice::Silent);

    m_PEntity->animation = ANIMATION_DEATH;
    m_PEntity->updatemask |= UPDATE_HP;
    if (m_PEntity->PAI->PathFind)
    {
        m_PEntity->PAI->PathFind->Clear();
    }
}

bool CDeathState::Update(timer::time_point tick)
{
    if (m_PEntity->objtype != TYPE_PC)
    {
        if (IsCompleted() || !m_PEntity->isDead())
        {
            return true;
        }
        else
        {
            auto time = GetEntryTime() + m_deathTime - std::chrono::seconds(m_PEntity->getMod(Mod::DESPAWN_TIME_REDUCTION));
            if (tick > time)
            {
                Complete();
                m_PEntity->OnDeathTimer();
            }
        }
    }
    else
    {
        CCharEntity* PChar = static_cast<CCharEntity*>(m_PEntity);

        auto time = GetEntryTime() + m_deathTime - std::chrono::seconds(m_PEntity->getMod(Mod::DESPAWN_TIME_REDUCTION));

        // exit state after 2 seconds on raise
        if (m_raiseAccepted && IsCompleted() && tick > m_raiseAcceptedTime + 2s)
        {
            m_PEntity->animation = ANIMATION_NONE; // TODO: should this be set in acceptRaise or after 2 seconds?
            m_PEntity->updatemask |= UPDATE_HP;

            return true;
        }
        // Check for auto-homepoint
        else if (tick > time)
        {
            Complete();
            m_PEntity->OnDeathTimer();

            return true;
        }

        if (tick > m_raiseTime && !m_raiseSent && m_PEntity->isDead())
        {
            if (PChar->m_hasRaise)
            {
                PChar->pushPacket<GP_SERV_COMMAND_RES>(PChar, GP_SERV_COMMAND_RES_TYPE::Raise);
                m_raiseSent = true;
            }
        }
    }

    return false;
}

void CDeathState::allowSendRaise()
{
    m_raiseTime = timer::now() + 12s;
    m_raiseSent = false;
}

void CDeathState::acceptRaise()
{
    m_raiseAcceptedTime = timer::now();
    m_raiseAccepted     = true;
    Complete();
}
