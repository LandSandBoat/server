-----------------------------------
-- Area: Arrapago Reef
--  ZNM: Velionis
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------
-- Todo: blaze spikes effect only activates while not in casting animation
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(tpz.effect.BLAZE_SPIKES, 250, 0, 0)
    mob:getStatusEffect(tpz.effect.BLAZE_SPIKES):setFlag(tpz.effectFlag.DEATH)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:SetAutoAttackEnabled(false)
    mob:setMod(tpz.mod.FASTCAST, 15)
    mob:setLocalVar("HPP", 90)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
end

function onMobFight(mob, target)
    local FastCast = mob:getLocalVar("HPP")
    if mob:getHPP() <= FastCast then
        if mob:getHPP() > 10 then
            mob:addMod(tpz.mod.FASTCAST, 15)
            mob:setLocalVar("HPP", mob:getHPP() - 10)
        end
    end
end

function onSpikesDamage(mob, target, damage)
    local INT_diff = mob:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)

    if INT_diff > 20 then
        INT_diff = 20 + (INT_diff - 20) * 0.5 -- INT above 20 is half as effective.
    end

    local dmg = (damage + INT_diff) * 0.5 -- INT adjustment and base damage averaged together.
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(mob, tpz.magic.ele.FIRE, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(mob, target, tpz.magic.ele.FIRE, 0)
    dmg = adjustForTarget(target, dmg, tpz.magic.ele.FIRE)
    dmg = finalMagicNonSpellAdjustments(mob, target, tpz.magic.ele.FIRE, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return tpz.subEffect.BLAZE_SPIKES, tpz.msg.basic.SPIKES_EFFECT_DMG, dmg
end

function onMobDeath(mob, player, isKiller)
end
