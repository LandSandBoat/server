-----------------------------------
-- Area: RoMaeve
--   NM: Martinet
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -187.611, y = -8.000, z = -35.805 },
    { x = -196.069, y = -8.000, z = -36.258 },
    { x = -199.632, y = -8.000, z = -46.155 },
    { x = -189.160, y = -8.000, z = -49.926 },
    { x = -191.781, y = -8.808, z = -38.077 },
    { x = -189.696, y = -8.500, z = -33.497 },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.MAGIC, xi.detects.SCENT)) -- TODO: Verify scent tracking on retail.
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addStatusEffect(xi.effect.SHOCK_SPIKES, 60, 0, 0)
    mob:getStatusEffect(xi.effect.SHOCK_SPIKES):setEffectFlags(xi.effectFlag.DEATH)

    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(7200)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 80)
end

entity.onSpikesDamage = function(mob, target, damage)
    local intDiff = mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local dmg = damage + intDiff
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(mob, xi.element.THUNDER, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(mob, target, xi.element.THUNDER, 0)
    dmg = math.floor(dmg * xi.spells.damage.calculateAbsorption(target, xi.element.THUNDER, true))
    dmg = math.floor(dmg * xi.spells.damage.calculateNullification(target, xi.element.THUNDER, true, false))
    dmg = finalMagicNonSpellAdjustments(mob, target, xi.element.THUNDER, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return xi.subEffect.SHOCK_SPIKES, xi.msg.basic.SPIKES_EFFECT_DMG, dmg
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 329)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(7200)
end

return entity
