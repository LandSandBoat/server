-----------------------------------
-- Area: Horlais Peak
--  Mob: Helltail Harry
-- BCNM: Tails of Woe
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 1000)
    mob:setMod(xi.mod.SILENCERES, 900)
    mob:setMod(xi.mod.LULLABYRES, 700)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
