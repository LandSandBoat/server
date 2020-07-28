-----------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Ramponneau
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:addStatusEffect(tpz.effect.SHOCK_SPIKES, 10, 0, 0)
    mob:getStatusEffect(tpz.effect.SHOCK_SPIKES):setFlag(tpz.effectFlag.DEATH)
end

function onMobFight(mob, target)
    mob:SetMobAbilityEnabled(false)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENBLIZZARD)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 519)
end
