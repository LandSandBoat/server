-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Toadsquab
-- BCNM: Toadal Recall
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 1000)
    mob:setMod(xi.mod.LULLABYRES, 1000)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1) -- lock from moving
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
end

entity.onMobEngaged = function(mob, target)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0) -- unlock from moving
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
