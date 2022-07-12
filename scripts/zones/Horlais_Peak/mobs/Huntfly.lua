-----------------------------------
-- Area: Horlais Peak
--  Mob: Huntfly
-- BCNM: Dropping Like Flies
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 1000)
    mob:setMod(xi.mod.LULLABYRES, 1000)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
