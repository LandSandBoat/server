-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Dagourmarche
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2672, 2678, 2686 })
end

return entity
