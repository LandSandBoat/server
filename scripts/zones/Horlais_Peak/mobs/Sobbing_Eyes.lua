-----------------------------------
-- Area: Horlais Peak
--  Mob: Sobbing Eyes
-- BCNM: Under Observation
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEP_MEVA, 75)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
