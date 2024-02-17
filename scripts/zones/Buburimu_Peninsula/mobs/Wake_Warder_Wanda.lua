-----------------------------------
-- Area: Buburimu Peninsula
--   NM: Wake Warder Wanda
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 50) -- just one spell to spam
end

entity.onMobEngage = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 25)
end

entity.onMobDisengage = function(mob)
    mob:setMod(xi.mod.REGAIN, 0)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 260)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(3600, 4200)) -- repop 60-70min
end

return entity
