-----------------------------------
-- Area: Qufim Island
--   NM: Slippery Sucker
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 308)
    xi.magian.onMobDeath(mob, player, optParams, set{ 218 })
end

return entity
