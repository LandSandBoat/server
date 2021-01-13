-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Furies
-- BCNM: Wings of Fury
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 1)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
