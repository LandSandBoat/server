-----------------------------------
-- Area: Waughroon Shrine
--  Mob: The Waughroon Kid
-- BCNM: The Final Bout
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
