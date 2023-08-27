-----------------------------------
-- Area: Balga's Dais
--  Mob: Myrmidon Spo-spo
-- BCNM: Royal Succession
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
