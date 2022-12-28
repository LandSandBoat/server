-----------------------------------
-- Area: Horlais Peak
--  Mob: Houndfly
-- BCNM: Dropping Like Flies
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LULLABY_MEVA, 500)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
