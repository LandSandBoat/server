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

#pragma once

#include "mobskill.h"
#include "state.h"

class CBattleEntity;

class CMobSkillState : public CState
{
public:
    CMobSkillState(CBattleEntity* PEntity, const EntityId& target, uint16 wsid, Maybe<timer::duration> castTimeOverride);

    auto GetSkill() const -> CMobSkill*;
    auto GetSpentTP() const -> int16;

protected:
    auto CanChangeState() -> bool override;
    auto CanFollowPath() -> bool override;
    auto CanInterrupt() -> bool override;

    auto Update(timer::time_point tick) -> bool override;
    void Cleanup(timer::time_point tick) override;
    void SpendCost();

private:
    CBattleEntity* const       m_PEntity;
    std::unique_ptr<CMobSkill> m_PSkill;
    timer::time_point          m_finishTime;
    timer::duration            m_castTime{};
    int16                      m_spentTP;
    bool                       m_skillSuccess{ false };

    void reduceTpOnInterrupt() const;
};
