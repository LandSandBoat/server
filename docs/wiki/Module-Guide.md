# Module Guide

Modules are bundles of user-defined code that are injected into the server process at different points to allow users to customise the server without needing to modify the `src/`, `sql/`, or `scripts/` directories - leaving behind changes in git that might lead to difficult to resolve conflicts during regular updates.

Modules are designed _first and foremost_ to ensure that server operators can safely keep their servers updated and that bug reports sent back upstream are valid and not the result of deep customisation. Secondarily, they are designed to allow users to share popular modifications and non-retail features with eachother without them needing to be integrated into or maintained by LandSandBoat.

Modules are **NOT** designed to allow operators to implement retail features or bug fixes and keep them away from the rest of the community in order to drive player counts or engagement. Please participate in the open source that you're benefitting from.

Please see `modules/init.txt` for how to load modules.

Example `modules/init.txt`

```txt
# This file is for marking which modules you wish to load.
#
# - This file is tracked in git, but ignores changes: git update-index --assume-unchanged FILE_NAME
# - You can list files and folders you wish to load as modules.
# - One entry per line.
# - Empty lines and comments are ignored.
# - Comments are marked with '#'
# - It is optional to mark folders with a trailing '/'.
# - If you list a folder, all of it's contents will be available for loading.
# - If you list a file, it will be made available for loading.
# - Valid files are: *.cpp, *.lua, *.sql.
# - cpp files are loaded and built with CMake.
# - lua files are loaded at runtime by the main program.
# - sql files are loaded either by dbtool, or by hand.
#
# Examples:
#
# init.txt:
# ---------------------
# | 
# | renamer
# | 
# ---------------------
#
# Will load everything under the renamer folder.
#
# init.txt:
# ---------------------
# | 
# | custom/cpp/custom_module.cpp
# | custom/lua/claim_shield.lua
# |
# ---------------------
#
# Will load only custom/cpp/custom_module.cpp and custom/lua/claim_shield.lua.
#
# Live example:

custom/commands/
custom/lua/test_npcs_in_gm_home.lua
```

## Lua Modules

Lua modules are bundles of Lua code that are prepared before the whole map Lua state is prepared, and each override is injected as the relevant Lua functions are loaded. Then when the relevant Lua function call is executed the override will fire instead, either wrapping or replacing the original function call.

```lua
-----------------------------------
-- Old setting from settings.lua: HOMEPOINT_HEAL
-- Set if you want Home Points to heal you like in single-player Final Fantasy games.
-----------------------------------
require("modules/module_utils")
require("scripts/globals/homepoint")
-----------------------------------
local m = Module:new("homepoint_heal")

m:addOverride("xi.homepoint.onTrigger", function(player, csid, index)
    player:addHP(player:getMaxHP())
    player:addMP(player:getMaxMP())
    super(player, csid, index)
end)

return m
```

If you want to turn off NPCs at will, you can do this with any entity in the game:

- Get their ID somehow: `!exec print(target)` etc.
  - `[08/12/22 09:49:41:827][map][lua] CLuaBaseEntity(TYPE_NPC | 17639680 | DE_Horro | Horro) (lua_print:145)`

![image](https://user-images.githubusercontent.com/1389729/184300199-3aa6eb99-ae70-4105-96cf-608ff549944b.png)

![image](https://user-images.githubusercontent.com/1389729/184300266-d31cb15b-39a5-41e6-991d-029d0af639b5.png)

![image](https://user-images.githubusercontent.com/1389729/184300305-371e8094-1e4e-440e-9955-f48f80e0436e.png)

You get given the NPC/Mob object when you create a dynamic entity, so you can attach that to the global object for easier access.

```lua
xi.custom = xi.custom or {}
xi.custom.Horro = zone:insertDynamicEntity({...
...
xi.custom.Horro:setStatus(xi.status.DISAPPEAR)
xi.custom.Horro:setStatus(xi.status.NORMAL)
```

If you have a module that is applying things on `onInitialize`, like adding new NPCs, a module reload will override `onInitialize`, but `onInitialize` is only called during server start. So a custom NPC won't receive any changes.

If you wanted hot-reloadable onTrigger/onTrade logic for NPCs or Mobs, you'd have to get sneaky with how/when you define and apply that logic.

```lua
-- your_module.lua

local onTriggerFunc = function(player, npc)
    -- NOTE: We have to use getPacketName, because the regular name is modified and being used
    --     : for internal lookups
    player:PrintToPlayer("Welcome to New GM Home!", 0, npc:getPacketName())
end,

m:addOverride("xi.zones.GM_Home.Zone.onInitialize", function(zone)
    super(zone)
    zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Horro",
        onTrigger = onTriggerFunc
    })
end)

-- Internally, the cache entry for Dynamic Entries is prepended with "DE_"
-- This might get upset on startup, since `xi.zones.GM_Home.npcs.DE_Horro` probably doesn't exist when this script is first run
xi.zones.GM_Home.npcs.DE_Horro.onTrigger = onTriggerFunc
```

```txt
[08/12/22 10:01:58:479][map][info] [FileWatcher] RE-RUNNING MODULE FILE modules/custom/lua/test_npcs_in_gm_home.lua (luautils::CacheLuaObjectFromFile:519)
```

![image](https://user-images.githubusercontent.com/1389729/184301844-c675393a-c1e0-43a6-a923-23f8cf449f35.png)

## CPP Modules

CPP modules are less flexible than Lua modules. There are hard-defined customisation points where you can inject your own code, or there are arrays of function objects where you can inject your own function objects (optionally wrapping the object that was already there, if any).

Place a `.cpp` file somewhere in the `modules/` subfolder and enable it with `init.txt`. You'll then need to re-configure
your build using CMake. Towards the end of configuration, it will log which module files have been added to the build:

```txt
-- Adding module files to build: C:/ffxi/server/modules/era/cpp/test.cpp
```

You can then continue your build as normal, and your module files will be compiled at the end.

```cpp
#include "map/utils/moduleutils.h"

// CPP Modules are calls synchronously, so you have safe access to the main sql connection, the Lua state,
// logging, and anything else you might regularly use.
#include "common/logging.h"
#include "common/sql.h"
#include "lua/luautils.h"
#include "utils/itemutils.h"

namespace
{
    constexpr uint16 HOURGLASS_ID = 4237;

    uint32 currentEpoch()
    {
        return static_cast<uint32>(time(nullptr));
    }
};

//       |-- Name your module something unique.
//       v                    v-- You must inherit from CPPModule.
class TestModule : public CPPModule
{
    // In Lua, the ':' function calling syntax is just syntactic sugar for:
    //     function(object, param0, param1, ...)
    // This is what will be required if you want to inject your own bindings.
    //                         v----object----v           v-param0-v    v-param1-v
    void createHourglass(CLuaBaseEntity* PLuaBaseEntity, uint8 zoneID, uint32 token)
    {
        TracyZoneScoped;

        CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
        if (PEntity->objtype != TYPE_PC)
        {
            return;
        }

        auto ret = sql->Query("SELECT value FROM server_variables WHERE name = '[DYNA]Token' LIMIT 1;");
        if (ret != SQL_ERROR && sql->NumRows() && sql->NextRow())
        {
            auto res = sql->GetUIntData(0);
            if (res == HOURGLASS_ID)
            {
                CItem* PItem = itemutils::GetItem(HOURGLASS_ID);
                PItem->setQuantity(1);

                ref<uint8>(PItem->m_extra,  0x02) = 1;
                ref<uint32>(PItem->m_extra, 0x04) = PEntity->id;
                ref<uint32>(PItem->m_extra, 0x0C) = currentEpoch();
                ref<uint8>(PItem->m_extra,  0x10) = zoneID;
                ref<uint32>(PItem->m_extra, 0x14) = token;
            }
        }
    }

    //     v-- OnInit is required for all CPP modules.
    void OnInit() override // Called just before the server is ready to run.
    {
        // player:createHourglass(zoneID, token)
        lua["CBaseEntity"]["createHourglass"] = &TestModule::createHourglass;

        // You could also use lambdas, if you wish
        // mob:anotherFunction()
        lua["CBaseEntity"]["anotherFunction"] = [](CLuaBaseEntity* PLuaBaseEntity) -> void
        {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            if (PEntity->objtype != TYPE_PC)
            {
                return;
            }

            // ...
        };
    }

    // The following are optional:
    // void OnZoneTick(CZone* PZone){};           // Called at the end of Zone_Server's tick.
    // void OnTimeServerTick(){};                 // Called at the end of time_server's tick.
    // void OnCharZoneIn(CCharEntity* PChar){};   // Called just before a character finished zoning in.
    // void OnCharZoneOut(CCharEntity* PChar){};  // Called just before a character starts zoning out.
    // void OnPushPacket(CBasicPacket* packet){}; // Called just before a packet is added to the character's outgoing queue.
};

// You must call this to register your module with the program!
REGISTER_CPP_MODULE(TestModule);
```

## SQL Modules

SQL modules are additional SQL files that are run at the end of `dbtool.py` updates, after all the other SQL files.
`dbtool` will look them up and load them for you, so they still need to be enabled with `init.txt`.

```sql
-- Setting all 2HR abilities to 2HR cooldown
UPDATE abilities SET recastTime = "7200" WHERE name = "mighty_strikes";
UPDATE abilities SET recastTime = "7200" WHERE name = "hundred_fists";
-- ...
```
