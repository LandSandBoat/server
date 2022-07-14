-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Colo-colo
-- BCNM: Wings of Fury
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setRoamFlags(xi.roamFlag.EVENT)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 18)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
