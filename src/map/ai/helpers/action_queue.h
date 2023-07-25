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

#ifndef _ACTIONQUEUE_H
#define _ACTIONQUEUE_H

#include "common/cbasetypes.h"
#include "common/mmo.h"
#include <functional>
#include <memory>
#include <queue>

#include "sol/sol.hpp"

class CBaseEntity;

struct queueAction_t
{
    using EntityFunc_t = std::function<void(CBaseEntity*)>;

    time_point    start_time{ server_clock::now() };
    duration      delay{ 0ms };
    bool          checkState{ false };
    sol::function lua_func{};
    EntityFunc_t  func{};

    queueAction_t(int _ms, bool _checkstate, sol::function _lua_func)
    : delay(std::chrono::milliseconds(_ms))
    , checkState(_checkstate)
    , lua_func(_lua_func)
    {
    }

    queueAction_t(duration _ms, bool _checkstate, std::function<void(CBaseEntity*)> _func)
    : delay(_ms)
    , checkState(_checkstate)
    , func(_func)
    {
    }
};

inline bool operator<(const queueAction_t& lhs, const queueAction_t& rhs) noexcept
{
    return lhs.start_time + lhs.delay < rhs.start_time + rhs.delay;
}
inline bool operator>(const queueAction_t& lhs, const queueAction_t& rhs) noexcept
{
    return rhs < lhs;
}
inline bool operator<=(const queueAction_t& lhs, const queueAction_t& rhs) noexcept
{
    return !(lhs > rhs);
}
inline bool operator>=(const queueAction_t& lhs, const queueAction_t& rhs) noexcept
{
    return !(lhs < rhs);
}

class CAIActionQueue
{
public:
    CAIActionQueue(CBaseEntity*);

    void pushAction(queueAction_t&&);
    void checkAction(time_point tick);

    void handleAction(queueAction_t& action);

    bool isEmpty();

private:
    using ActionPQ_t = std::priority_queue<queueAction_t, std::vector<queueAction_t>, std::greater<queueAction_t>>;

    CBaseEntity* PEntity;
    ActionPQ_t   actionQueue;
    ActionPQ_t   timerQueue;
};

#endif
