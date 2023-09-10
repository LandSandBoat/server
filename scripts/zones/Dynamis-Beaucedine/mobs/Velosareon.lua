-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Velosareon
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2676, 2682, 2690 })
end

return entity
