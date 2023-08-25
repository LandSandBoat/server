-----------------------------------
-- Area: Balga's Dais
--  Mob: Myrmidon Apu-apu
-- BCNM: Royal Succession
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
