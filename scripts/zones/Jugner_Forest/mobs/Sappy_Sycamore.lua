-----------------------------------
-- Area: Jugner_Forest
--   NM: Sappy Sycamore
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addMod(xi.mod.SLEEP_MEVA, 20)
    mob:addMod(xi.mod.BIND_MEVA, 20)
    mob:addMod(xi.mod.EARTH_MEVA, 100)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW, { power = 1500, duration = math.random(15, 25) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 159)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(3600, 4200)) -- repop 60-70min
end

return entity
