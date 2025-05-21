-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Autarch
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.SHOCK_SPIKES, 40, 0, 0)
    mob:getStatusEffect(xi.effect.SHOCK_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.ATT, 50)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 25)
end

entity.onSpikesDamage = function(mob, target, damage)
    -- "damage" is the power of the status effect up in onMobinitialize.
    local intDiff = mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local dmg = damage + intDiff
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(mob, xi.element.THUNDER, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(mob, target, xi.element.THUNDER, 0)
    dmg = dmg * xi.spells.damage.calculateNukeAbsorbOrNullify(target, xi.element.THUNDER)
    dmg = finalMagicNonSpellAdjustments(mob, target, xi.element.THUNDER, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return xi.subEffect.SHOCK_SPIKES, xi.msg.basic.SPIKES_EFFECT_DMG, dmg
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 333)
end

entity.onMobDespawn = function(mob)
    -- UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(1800, 10800)) -- 30 minutes to 3 hrs
end

return entity
