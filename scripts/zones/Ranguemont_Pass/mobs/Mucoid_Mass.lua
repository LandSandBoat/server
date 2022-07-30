-----------------------------------
-- Area: Ranguemont Pass
--   NM: Mucoid Mass
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.BLIND)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 345)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(5400, 6000)) -- 90 to 100 minutes
end

return entity
