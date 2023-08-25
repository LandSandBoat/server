-----------------------------------
-- Area: Horlais Peak
--  Mob: Combound Eyes
-- BCNM: Under Observation
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
