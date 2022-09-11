-----------------------------------
-- Area: Balga's Dais
--  Mob: Nenaunir's Wife
-- BCNM: Harem Scarem
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.LULLABYRES, 100)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
