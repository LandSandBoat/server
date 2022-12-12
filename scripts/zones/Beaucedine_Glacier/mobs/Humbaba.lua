-----------------------------------
-- Area: Beaucedine Glacier
--   NM: Humbaba
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, 45, 0, 0)
    mob:getStatusEffect(xi.effect.ICE_SPIKES):setFlag(xi.effectFlag.DEATH)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
end

entity.onSpikesDamage = function(mob, target, damage)
    local intDiff = mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    if intDiff > 20 then
        intDiff = 20 + (intDiff - 20) * 0.5 -- INT above 20 is half as effective.
    end

    local dmg = (damage + intDiff) * 0.5 -- INT adjustment and base damage averaged together.
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(mob, xi.magic.ele.ICE, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(mob, target, xi.magic.ele.ICE, 0)
    dmg = adjustForTarget(target, dmg, xi.magic.ele.ICE)
    dmg = finalMagicNonSpellAdjustments(mob, target, xi.magic.ele.ICE, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return xi.subEffect.ICE_SPIKES, xi.msg.basic.SPIKES_EFFECT_DMG, dmg
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 314)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(3600, 4200)) -- 60 to 70 minutes
end

return entity
