-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Furies
-- BCNM: Wings of Fury
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

return entity
