-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Goublefaupe
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2667, 2671, 2674, 4403 })
end

return entity
