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

#ifndef _CINSTANCELOADER_H
#define _CINSTANCELOADER_H

#include "common/cbasetypes.h"
#include "common/socket.h"

#include "common/ipc.h"

class CCharEntity;
class CInstance;
class CZone;

class CInstanceLoader
{
public:
    CInstanceLoader(const ipc::InstanceLoadRequest& message);
    ~CInstanceLoader();

    void loadInstanceMobSQL();
    void loadInstanceMobLua();
    void loadInstanceNPCSQL();
    void loadInstanceNPCLua();

    void update();
    bool ready();

    auto getInstance() -> CInstance*;

private:
    CInstance* m_PInstance;
    CZone*     m_PZone;

    enum class LoadPhase
    {
        SQLPending,
        Lua,
        Done,
    };

    std::atomic<LoadPhase> m_LoadPhase{ LoadPhase::SQLPending };
};

#endif
