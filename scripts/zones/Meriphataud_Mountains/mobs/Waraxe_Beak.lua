-----------------------------------
-- Area: Meriphataud Mountains (119)
--   NM: Waraxe Beak
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN_BITMASK, xi.drawin.NORMAL)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
