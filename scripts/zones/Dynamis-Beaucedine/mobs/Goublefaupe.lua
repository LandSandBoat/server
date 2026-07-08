-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Goublefaupe
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2667, 2671, 2674, 4403 })
end

return entity
