-----------------------------------
-- Area: Balga's Dais
--  Mob: Searcher
-- Mission 2-3 BCNM Fight
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
