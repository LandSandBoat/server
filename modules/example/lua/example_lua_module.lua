-----------------------------------
-- Old setting from settings.lua: HOMEPOINT_HEAL
-- Set if you want Home Points to heal you like in single-player Final Fantasy games.
-----------------------------------
require("modules/module_utils")
require("scripts/globals/homepoint")
-----------------------------------
local m = Module:new("homepoint_heal")

m:addOverride("xi.homepoint.onTrigger", function(player, csid, index)
    super(player, csid, index)
end)

return m
