-----------------------------------
-- Area: North Gustaberg
--   NM: Bedrock Barry
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 4200)) -- When server restarts, reset timer
end

entity.onMobSpawn = function(mob)
    mob:addStatusEffect(xi.effect.STONESKIN, { power = math.randomInt(30, 40), duration = 300, origin = mob })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 199)
    xi.regime.checkRegime(player, mob, 16, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(3600) -- 1 hour.
end

return entity
