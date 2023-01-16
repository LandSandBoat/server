-----------------------------------
-- Area: Horlais Peak
--  Mob: Sobbing Eyes
-- BCNM: Under Observation
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEP_MEVA, 75)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
