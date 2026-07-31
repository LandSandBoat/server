-----------------------------------
-- Area: Buburimu Peninsula (118)
--   NM: Backoo
-- Note: Spawns only from hours 06 to 16.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 263)
end

entity.onMobDespawn = function(mob)
    -- 60-90 minute respawn. The spawn window holds a repop that lands past
    -- 16:00 until the next morning.
    mob:setRespawnTime(math.randomInt(3600, 5400))
end

return entity
