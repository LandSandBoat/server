-----------------------------------
-- Area: La Theine Plateau
--   NM: Slumbering Samwell
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(1200) -- 20 min
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 33)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 155)
    mob:setRespawnTime(1200) -- 20 min
end

return entity
