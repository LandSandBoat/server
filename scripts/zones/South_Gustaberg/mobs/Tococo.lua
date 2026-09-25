-----------------------------------
-- Area: South Gustaberg
--   NM: Tococo
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 4200)) -- When server restarts, reset timer
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { power = 5, duration = math.randomInt(5, 15) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 201)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 4200)) -- 60 to 70 minutes
end

return entity
