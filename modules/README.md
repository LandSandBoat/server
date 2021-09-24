# Modules

```lua
-----------------------------------
-- Basic Example Module
-----------------------------------
require("modules/module_utils") -- REQUIRED

-- Require any scripts you'll be applying modules to
require("scripts/globals/player")
-----------------------------------

-- Create and name your module
local m = Module:new("example_module")

-- Enable true/false, will default to false if not set
m:setEnabled(true)

-- First Arg: Use the string name of the function you want to override
-- Second Arg: The function (with the same signature) to override with
m:addOverride("xi.player.onGameIn", function(player, firstLogin, zoning)
    -- You have access to the original function as "super" inside the new function body
    super(player, firstLogin, zoning)
end)

-- Make sure you return the module at the end
return m
```
