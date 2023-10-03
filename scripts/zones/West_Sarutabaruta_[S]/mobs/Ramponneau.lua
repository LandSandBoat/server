-----------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Ramponneau
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addStatusEffect(xi.effect.SHOCK_SPIKES, 10, 0, 0)
    mob:getStatusEffect(xi.effect.SHOCK_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onMobFight = function(mob, target)
    mob:setMobAbilityEnabled(false)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENBLIZZARD)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 519)
    xi.magian.onMobDeath(mob, player, optParams, set{ 72, 286, 434 })
end

return entity
