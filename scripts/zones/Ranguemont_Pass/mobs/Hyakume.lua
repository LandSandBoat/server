-----------------------------------
-- Area: Ranguemont Pass
--   NM: Hyakume
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:addStatusEffect(xi.effect.DREAD_SPIKES, 10, 0, 0)
    mob:getStatusEffect(xi.effect.DREAD_SPIKES):setFlag(xi.effectFlag.DEATH)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.CURSE)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 344)
end

return entity
