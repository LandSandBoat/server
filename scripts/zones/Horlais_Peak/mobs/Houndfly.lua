-----------------------------------
-- Area: Horlais Peak
--  Mob: Houndfly
-- BCNM: Dropping Like Flies
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.LULLABYRES, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
