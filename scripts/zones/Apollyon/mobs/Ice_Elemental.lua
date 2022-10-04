-----------------------------------
-- Area: Apollyon SW, Floor 4
--  Mob: Ice Elemental
-----------------------------------
require("scripts/zones/Apollyon/bcnms/ne_apollyon_helper")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    xi.apollyon_sw.handleMobEngagedFloorFour(mob, target, 4)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.apollyon_sw.handleMobDeathFloorFour(mob, player, optParams, 4)
end

return entity
