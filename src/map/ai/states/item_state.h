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

#include "state.h"

class CBattleEntity;
class CCharEntity;
class CItemUsable;
class ItemUseTransaction;

struct action_t;

class CItemState : public CState
{
public:
    CItemState(CCharEntity* PEntity, const EntityId& target, uint8 loc, uint8 slotid);
    ~CItemState() override;

    auto Update(timer::time_point tick) -> bool override;
    void Cleanup(timer::time_point tick) override;
    auto CanChangeState() -> bool override;
    auto CanFollowPath() -> bool override;
    auto CanInterrupt() -> bool override;
    void TryInterrupt(CBattleEntity* PAttacker) override;
    auto GetItem() const -> CItemUsable*;
    void InterruptItem(action_t& action);
    auto FinishItem(action_t& action) -> bool;

protected:
    auto HasMoved() const -> bool;
    auto validatedTarget() -> CBaseEntity*;

    CCharEntity*        m_PEntity;
    CItemUsable*        m_PItem;
    uint8               m_location;
    uint8               m_slot;
    timer::duration     m_castTime{};
    timer::duration     m_animationTime{};
    position_t          m_startPos;
    bool                m_interrupted{ false };
    bool                m_interruptable{ true };
    ItemUseTransaction* tx_{ nullptr };
};
