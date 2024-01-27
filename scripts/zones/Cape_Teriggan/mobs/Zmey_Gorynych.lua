-----------------------------------
-- Area: Cape Teriggan
--   NM: Zmey Gorynych
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 45)
    mob:addMod(xi.mod.ATTP, 100)
    mob:addMod(xi.mod.ACC, 100)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 406)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1-2 hours
end

return entity
