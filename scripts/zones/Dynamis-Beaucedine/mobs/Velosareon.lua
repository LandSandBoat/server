-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Velosareon
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2676, 2682, 2690 })
end

return entity
