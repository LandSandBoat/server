-----------------------------------
-- Area: Crawlers' Nest (197)
--   NM: Dynast Beetle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(5400, 7200))
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SLOW)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 237)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(5400, 7200)) -- 90 to 120 minutes
end

return entity
