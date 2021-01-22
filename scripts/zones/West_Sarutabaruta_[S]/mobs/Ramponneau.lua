-----------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Ramponneau
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:addStatusEffect(tpz.effect.SHOCK_SPIKES, 10, 0, 0)
    mob:getStatusEffect(tpz.effect.SHOCK_SPIKES):setFlag(tpz.effectFlag.DEATH)
end

entity.onMobFight = function(mob, target)
    mob:SetMobAbilityEnabled(false)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENBLIZZARD)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 519)
end

return entity
