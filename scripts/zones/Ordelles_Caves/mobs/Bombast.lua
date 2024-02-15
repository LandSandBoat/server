-----------------------------------
-- Area: Ordelles Caves
--   NM: Bombast
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 15, 0, 0)
    mob:getStatusEffect(xi.effect.BLAZE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onSpikesDamage = function(mob, target, damage)
    -- "Damage" is the power of the status effect up in onMobinitialize.
    local intDiff = mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local dmg = damage + intDiff
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(mob, xi.element.FIRE, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(mob, target, xi.element.FIRE, 0)
    dmg = adjustForTarget(target, dmg, xi.element.FIRE)
    dmg = finalMagicNonSpellAdjustments(mob, target, xi.element.FIRE, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return xi.subEffect.BLAZE_SPIKES, xi.msg.basic.SPIKES_EFFECT_DMG, dmg
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 182)
end

return entity
