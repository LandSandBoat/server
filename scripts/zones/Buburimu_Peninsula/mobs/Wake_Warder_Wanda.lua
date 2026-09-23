-----------------------------------
-- Area: Buburimu Peninsula
--   NM: Wake Warder Wanda
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 4200)) -- When server restarts, reset timer

    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)

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
    mob:setRespawnTime(math.randomInt(3600, 4200)) -- repop 60-70min
end

return entity
