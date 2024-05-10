-----------------------------------
-- Area: Promyvion-Holla
--   NM: Stray
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.promyvion.strayOnMobSpawn(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
