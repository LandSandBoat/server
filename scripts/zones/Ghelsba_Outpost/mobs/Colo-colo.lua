-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Colo-colo
-- BCNM: Wings of Fury
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1) -- lock from moving
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 18)
end

entity.onMobEngaged = function(mob, target)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0) -- unlock mob
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
