-----------------------------------
-- Area: Ordelles Caves
--   NM: Bombast
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 45, 0, 0)
    mob:getStatusEffect(xi.effect.BLAZE_SPIKES):setFlag(xi.effectFlag.DEATH)
end

entity.onSpikesDamage = function(mob, target, damage)
    local INT_diff = mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    if INT_diff > 20 then
        INT_diff = 20 + (INT_diff - 20) * 0.5 -- INT above 20 is half as effective.
    end

    local dmg = (damage + INT_diff) * .5 -- INT adjustment and base damage averaged together.
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(mob, xi.magic.ele.FIRE, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(mob, target, xi.magic.ele.FIRE, 0)
    dmg = adjustForTarget(target, dmg, xi.magic.ele.FIRE)
    dmg = finalMagicNonSpellAdjustments(mob, target, xi.magic.ele.FIRE, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return xi.subEffect.BLAZE_SPIKES, xi.msg.basic.SPIKES_EFFECT_DMG, dmg
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 182)
end

return entity
