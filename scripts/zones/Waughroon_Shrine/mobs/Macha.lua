-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Macha
-- BCNM: Birds of a Feather
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
