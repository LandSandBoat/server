-----------------------------------
-- Area: Apollyon SW, Floor 4
--  Mob: Earth Elemental
-----------------------------------
require("scripts/zones/Apollyon/bcnms/ne_apollyon_helper")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    xi.apollyon_sw.handleMobEngagedFloorFour(mob, target, 1)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_sw.handleMobDeathFloorFour(mob, player, isKiller, noKiller, 1)
end

return entity
