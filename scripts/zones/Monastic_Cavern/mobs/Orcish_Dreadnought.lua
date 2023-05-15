-----------------------------------
-- Area: Monastic Cavern
--   NM: Orcish Dreadnought
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.LEDGE_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
