-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Quiebitiel
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2660, 2684, 2715 })
end

return entity
