-----------------------------------
-- Area: Arrapago Reef
--  ZNM: Velionis
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------
local entity = {}
-- Todo: blaze spikes effect only activates while not in casting animation

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 250, 0, 0)
    mob:getStatusEffect(xi.effect.BLAZE_SPIKES):setFlag(xi.effectFlag.DEATH)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:SetAutoAttackEnabled(false)
    mob:setMod(xi.mod.FASTCAST, 15)
    mob:setLocalVar("HPP", 90)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
end

entity.onMobFight = function(mob, target)
    local FastCast = mob:getLocalVar("HPP")
    if mob:getHPP() <= FastCast then
        if mob:getHPP() > 10 then
            mob:addMod(xi.mod.FASTCAST, 15)
            mob:setLocalVar("HPP", mob:getHPP() - 10)
        end
    end
end

entity.onSpikesDamage = function(mob, target, damage)
    local INT_diff = mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    if INT_diff > 20 then
        INT_diff = 20 + (INT_diff - 20) * 0.5 -- INT above 20 is half as effective.
    end

    local dmg = (damage + INT_diff) * 0.5 -- INT adjustment and base damage averaged together.
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
end

return entity
