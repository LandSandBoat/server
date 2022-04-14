-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Effigy Prototype
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.dynamis.timeExtensionOnDeath(mob, player, isKiller)
end

return entity
