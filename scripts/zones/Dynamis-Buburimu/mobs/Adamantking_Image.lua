-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Adamantking Image
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    dynamis.timeExtensionOnDeath(mob, player, isKiller)
end

return entity
