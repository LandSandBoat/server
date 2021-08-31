-----------------------------------
-- Area: Balga's Dais
--  Mob: Myrmidon Spo-spo
-- BCNM: Royal Succession
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 50)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
