/*
===========================================================================

  Copyright (c) 2021 LandSandBoat Dev Teams

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

#ifndef _MODULEUTILS_H
#define _MODULEUTILS_H

#include "common/logging.h"
#include "lua/luautils.h"

#include <memory>

extern std::unique_ptr<SqlConnection> _sql;

// Forward declare
class CPPModule;
namespace moduleutils
{
    void RegisterCPPModule(CPPModule* ptr);
}

class CPPModule
{
public:
    CPPModule()
    : lua(::lua)
    , sql(::_sql)
    {
        moduleutils::RegisterCPPModule(this);
    }

    virtual ~CPPModule() = default;

    // Required
    virtual void OnInit() = 0;

    // Optional
    virtual void OnZoneTick(CZone* PZone){};
    virtual void OnTimeServerTick(){};
    virtual void OnCharZoneIn(CCharEntity* PChar){};
    virtual void OnCharZoneOut(CCharEntity* PChar){};
    virtual void OnPushPacket(CCharEntity* PChar, CBasicPacket* packet){};

    template <typename T>
    static T* Register()
    {
        return new T();
    };

protected:
    sol::state&                     lua;
    std::unique_ptr<SqlConnection>& sql;
};

#define REGISTER_CPP_MODULE(className) \
    static CPPModule* classNamePtr = className::Register<className>();

namespace moduleutils
{
    void RegisterCPPModule(CPPModule* ptr);

    // Hooks for calling modules
    void OnInit();
    void OnZoneTick(CZone* PZone);
    void OnTimeServerTick();
    void OnCharZoneIn(CCharEntity* PChar);
    void OnCharZoneOut(CCharEntity* PChar);
    void OnPushPacket(CCharEntity* PChar, CBasicPacket* packet);

    // The program has two "states":
    // - Load-time: As all data is being loaded and init'd
    // - Run-time: Once the main server tick starts
    //
    // There are multiple points where we'd like to override
    // the functionality of our Lua scripts, but it's hard
    // to determine when is the correct time to apply everything.
    //
    // So instead, we maintain a list of overrides specified by
    // active modules, and try multiple times during load-time
    // to apply them - looking for whether or not the cache
    // entry they want to modify exists.
    //
    // When run-time starts, we will be left with a list of
    // overrides that were either successfully or unsuccessfully
    // applied, and we can warn the user if there have been any
    // problems.

    void LoadLuaModules();
    void CleanupLuaModules();
    void TryApplyLuaModules();
    void ReportLuaModuleUsage();
}; // namespace moduleutils

#endif // _MODULEUTILS_H
