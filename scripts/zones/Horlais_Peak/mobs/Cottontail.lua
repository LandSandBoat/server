-----------------------------------
-- Area: Horlais Peak
--  Mob: Cottontail
-- BCNM: Tails of Woe
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
