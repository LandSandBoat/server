-----------------------------------
-- Area: Promyvion-Vahzl
--   NM: Stray
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.strayOnMobSpawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
