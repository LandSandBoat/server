-----------------------------------
-- Area: Promyvion-Mea
--   NM: Stray
-----------------------------------
require("scripts/globals/promyvion")
-----------------------------------

function onMobSpawn(mob)
    tpz.promyvion.strayOnSpawn(mob)
end

function onMobDeath(mob, player, isKiller)
end
