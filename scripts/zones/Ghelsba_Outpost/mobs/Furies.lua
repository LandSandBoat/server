-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Furies
-- BCNM: Wings of Fury
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 18)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1) -- lock from moving
end

entity.onMobEngaged = function(mob, target)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0) -- unlock from moving
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
