-----------------------------------
-- Area: Promyvion-Vahzl
--   NM: Stray
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.strayOnSpawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
