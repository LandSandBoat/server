-----------------------------------
-- Area: Valkurm Dunes
--   NM: Metal Shears
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setRespawnTime(math.randomInt(3600, 4200)) -- 60-70 min repop
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { power = 15, duration = math.randomInt(10, 25) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 207)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 4200)) -- 60-70 min repop
end

return entity
