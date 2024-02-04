-----------------------------------
-- Area: Halvung
--   NM: Copper Borer
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 10, 0, 0)
end

entity.onMobSpawn = function(mob)
    -- Mob needs to be in the correct state in order to use thermal pulse
    mob:setAnimationSub(0)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE, { power = math.random(3, 7) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 465)
end

return entity
