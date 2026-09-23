-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Skirling Liger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(3600) -- 60 min
end

entity.onMobEngage = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 50)
end

entity.onMobDisengage = function(mob)
    mob:setMod(xi.mod.REGAIN, 0)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 162)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(3600) -- 60 min
end

return entity
