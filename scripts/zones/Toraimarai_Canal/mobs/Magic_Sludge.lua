-----------------------------------
-- Area: Toraimarai Canal
--   NM: Magic Sludge
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SILENCERES, 90)
end

entity.onMobDeath = function(mob, player, optParams)
    player:setCharVar("rootProblem", 3)
end

return entity
