-----------------------------------
-- Area: Promyvion-Dem
--   NM: Stray
-----------------------------------
require("scripts/globals/promyvion")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    tpz.promyvion.strayOnSpawn(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
