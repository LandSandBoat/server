-----------------------------------
-- Area: Horlais Peak
--  Mob: Helltail Harry
-- BCNM: Tails of Woe
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLEEPRES, 1000)
    mob:setMod(tpz.mod.SILENCERES, 900)
    mob:setMod(tpz.mod.LULLABYRES, 700)
end

function onMobDeath(mob, player, isKiller)
end

return entity
