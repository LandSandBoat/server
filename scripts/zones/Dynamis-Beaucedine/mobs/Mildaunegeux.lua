-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Mildaunegeux
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2664, 2680, 2691 })
end

return entity
