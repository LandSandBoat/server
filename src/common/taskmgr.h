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

#include "../common/cbasetypes.h"

#include <string>
#include <queue>
#include <functional>
#include <any>

template<class _Ty>
    struct greater_equal
{    // functor for operator>
    bool operator()(const _Ty& _Left, const _Ty& _Right) const
    {    // apply operator> to operands
        return ((*_Left) > (*_Right));
    }
};

class CTaskMgr
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
    typedef int32 (*TaskFunc_t)(time_point tick,CTask*);
    typedef std::priority_queue<CTask*,std::deque<CTask*>,greater_equal<CTask*> > TaskList_t;

    TaskList_t& getTaskList(){ return m_TaskList; };

    CTask* AddTask(CTask*);
    CTask* AddTask(
        std::string InitName,
        time_point InitTick,
        std::any InitData,
        TASKTYPE InitType,
        TaskFunc_t InitFunc,
        duration InitInterval=1s);

    duration    DoTimer(time_point tick);
    void    RemoveTask(std::string TaskName);

    static CTaskMgr * getInstance();
    static void delInstance();

    ~CTaskMgr() {};

private:

    static CTaskMgr* _instance;

    TaskList_t m_TaskList;

    CTaskMgr() {};
};

class CTaskMgr::CTask
{
public:

    CTask(std::string InitName,
        time_point InitTick,
        std::any InitData,
        TASKTYPE InitType,
        TaskFunc_t InitFunc,
        duration InitInterval=1s
        ):  m_name(InitName),
            m_type(InitType),
            m_tick(InitTick),
            m_interval(InitInterval),
            m_data(InitData),
            m_func(InitFunc) {};

    std::string m_name;
    TASKTYPE    m_type;
    time_point  m_tick;
    duration    m_interval;
    std::any    m_data;
    TaskFunc_t  m_func;
};

inline bool operator<(const CTaskMgr::CTask& a,const CTaskMgr::CTask& b)
{
    return a.m_tick < b.m_tick;
};

inline bool operator>(const CTaskMgr::CTask& a,const CTaskMgr::CTask& b)
{
    return a.m_tick > b.m_tick;
};

inline bool operator >=(const CTaskMgr::CTask& a,const CTaskMgr::CTask& b)
{
    return a.m_tick >= b.m_tick;
};

inline bool operator <=(const CTaskMgr::CTask& a,const CTaskMgr::CTask &b)
{
    return a.m_tick <= b.m_tick;
}

#endif
