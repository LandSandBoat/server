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

#include "common/timer.h"
#include "common/types/badge.h"
#include "common/types/error_or.h"
#include "entities/base_entity.h"
#include "packets/basic.h"

#include <concepts>
#include <memory>

class CBattleEntity;

//
// StateErrorOr<T>
//
//   The result of entering a state.
//
//       return Success();
//       return Error{ std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(...) };
//       return RefuseSilently();
//
template <typename T>
using StateErrorOr = ErrorOr<T, std::unique_ptr<CBasicPacket>>;

//
// RefuseSilently()
//
//   Refuse to enter a state without telling the entity why.
//
inline auto RefuseSilently() -> Error<std::unique_ptr<CBasicPacket>>
{
    // Despite being a whole lot of words, this is essentially just nullptr.
    return Error{ std::unique_ptr<CBasicPacket>{ nullptr } };
}

class CState
{
public:
    //
    // The only way to create a state.
    //
    //   Every state constructor takes a Badge<CState>, and only this function can make
    //   one.
    //
    template <typename T, typename... Args>
        requires std::derived_from<T, CState>
    static auto make(Args&&... args) -> std::unique_ptr<T>
    {
        return std::unique_ptr<T>(new T(xi::Badge<CState>{}, std::forward<Args>(args)...));
    }

    virtual auto init() -> StateErrorOr<void>
    {
        return Success();
    }

    virtual ~CState() = default;

    auto target() const -> EntityId;

    auto HasErrorMsg() const -> bool;
    auto GetErrorMsg() const -> std::unique_ptr<CBasicPacket>;

    auto DoUpdate(timer::time_point tick) -> bool;

    // try interrupt (on hit)
    virtual void TryInterrupt(CBattleEntity* PAttacker);

    // called when state completes
    virtual void Cleanup(timer::time_point tick) = 0;
    // whether the state can be changed by normal means
    virtual auto CanChangeState() -> bool = 0;
    virtual auto CanFollowPath() -> bool  = 0;
    // whether the state can be interrupted (including by stun/sleep)
    virtual auto CanInterrupt() -> bool = 0;
    auto         IsCompleted() const -> bool;
    void         ResetEntryTime();
    void         SetTarget(const EntityId& target);

protected:
    CState(CBaseEntity* PEntity, const EntityId& target);

    auto refuseWithErrorMsg() const -> Error<std::unique_ptr<CBasicPacket>>;

    // state logic done per tick - returns whether to exit the state or not
    virtual auto Update(timer::time_point tick) -> bool = 0;
    virtual void UpdateTarget(const EntityId& target);

    void Complete();
    auto GetEntryTime() const -> timer::time_point;

    std::unique_ptr<CBasicPacket> m_errorMsg;

    CBaseEntity* const m_PEntity;

private:
    EntityId          target_{};
    bool              m_completed{ false };
    timer::time_point m_entryTime{ timer::now() };
};
