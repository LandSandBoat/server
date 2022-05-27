------------------------------------
-- Override specific mission/quest functions
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("escha_beads_npc")
m:setEnabled(true)

m:addOverride("xi.zones.Norg.npcs.Nolan.onTrigger", function(player, npc)

end)

return m
