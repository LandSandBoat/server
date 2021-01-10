-----------------------------------
-- Area: Promyvion-Dem
--   NM: Stray
-----------------------------------
require("scripts/globals/promyvion")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    tpz.promyvion.strayOnSpawn(mob)
end

function onMobDeath(mob, player, isKiller)
end

return entity
