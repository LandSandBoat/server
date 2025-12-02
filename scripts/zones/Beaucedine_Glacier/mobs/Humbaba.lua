-----------------------------------
-- Area: Beaucedine Glacier
--   NM: Humbaba
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  219.250, y =   0.500, z =  107.140 },
    { x =  246.720, y =   0.130, z = -200.300 },
    { x = -116.850, y =   0.310, z = -370.300 },
    { x =   90.330, y = -39.700, z =   38.400 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 4200)) -- When server restarts, reset timer

    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, 50, 0, 0)
    mob:getStatusEffect(xi.effect.ICE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
end

entity.onSpikesDamage = function(mob, target, damage)
    local intDiff = mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local dmg = damage + intDiff
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(mob, xi.element.ICE, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(mob, target, xi.element.ICE, 0)
    dmg = math.floor(dmg * xi.spells.damage.calculateAbsorption(target, xi.element.ICE, true))
    dmg = math.floor(dmg * xi.spells.damage.calculateNullification(target, xi.element.ICE, true, false))
    dmg = finalMagicNonSpellAdjustments(mob, target, xi.element.ICE, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return xi.subEffect.ICE_SPIKES, xi.msg.basic.SPIKES_EFFECT_DMG, dmg
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 314)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 4200)) -- 60 to 70 minutes
end

return entity
