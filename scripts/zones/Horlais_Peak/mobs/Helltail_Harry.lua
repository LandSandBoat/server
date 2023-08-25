-----------------------------------
-- Area: Horlais Peak
--  Mob: Helltail Harry
-- BCNM: Tails of Woe
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SILENCERES, 90)
    mob:setMod(xi.mod.LULLABYRES, 70)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
