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

#ifndef _TASK_MGR_H
#define _TASK_MGR_H

#include "cbasetypes.h"
#include "singleton.h"

#include <any>
#include <functional>
#include <queue>
#include <string>

template <class _Ty>
struct greater_equal
{ // functor for operator>
    bool operator()(const _Ty& _Left, const _Ty& _Right) const
    { // apply operator> to operands
        return ((*_Left) > (*_Right));
    }
};

class CTaskMgr : public Singleton<CTaskMgr>
{
public:
    class CTask;

    enum TASKTYPE
    {
        TASK_INTERVAL,
        TASK_ONCE,
        TASK_REMOVE,
        TASK_INVALID
    };

    using TaskFunc_t = std::function<int32(time_point, CTask*)>;
    typedef std::priority_queue<CTask*, std::deque<CTask*>, greater_equal<CTask*>> TaskList_t;

    class CTask
    {
    public:
        template <typename F>
        CTask(std::string const& name, time_point tick, std::any data, TASKTYPE type, duration interval, F&& func)
        : m_name(name)
        , m_type(type)
        , m_tick(tick)
        , m_interval(interval)
        , m_data(data)
        , m_func(std::forward<F>(func))
        {
        }

        std::string m_name;
        TASKTYPE    m_type;
        time_point  m_tick;
        duration    m_interval;
        std::any    m_data;
        TaskFunc_t  m_func;
    };

    ~CTaskMgr();

    TaskList_t& getTaskList()
    {
        return m_TaskList;
    };

    CTask* AddTask(CTask*);

    template <typename F>
    CTask* AddTask(std::string const& InitName, time_point InitTick, std::any InitData, TASKTYPE InitType, duration InitInterval, F&& InitFunc)
    {
        return AddTask(new CTask(InitName, InitTick, InitData, InitType, InitInterval, std::forward<F>(InitFunc)));
    }

    duration DoTimer(time_point tick);
    void     RemoveTask(std::string const& TaskName);

protected:
    CTaskMgr() = default;

private:
    TaskList_t m_TaskList;
};

inline bool operator<(const CTaskMgr::CTask& a, const CTaskMgr::CTask& b)
{
    return a.m_tick < b.m_tick;
};

inline bool operator>(const CTaskMgr::CTask& a, const CTaskMgr::CTask& b)
{
    return a.m_tick > b.m_tick;
};

inline bool operator>=(const CTaskMgr::CTask& a, const CTaskMgr::CTask& b)
{
    return a.m_tick >= b.m_tick;
};

inline bool operator<=(const CTaskMgr::CTask& a, const CTaskMgr::CTask& b)
{
    return a.m_tick <= b.m_tick;
}

#endif
